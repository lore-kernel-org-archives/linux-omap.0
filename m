From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 6/6] pwm: pwm-omap-dmtimer: Add capture functionality
Date: Fri, 23 Feb 2018 11:17:21 +0100
Message-ID: <20180223101721.GG5746@lenoch>
References: <20180223101254.GA5746@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180223101254.GA5746@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Cc: t-kristo@ti.com, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, robh+dt@kernel.org, narmstrong@baylibre.com, thierry.reding@gmail.com, Brecht Neyrinck <brechtneyrinck@gmail.com>, sebastian.reichel@collabora.co.uk, Thomas Gleixner <tglx@linutronix.de>, Claudiu.Beznea@microchip.com
List-Id: linux-omap@vger.kernel.org

Implement event capture.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: Please see cover letter

 drivers/pwm/pwm-omap-dmtimer.c | 127 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 48342285c953..5a2fc0e0a1c5 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -16,8 +16,10 @@
  *   PWM driver / controller, using the OMAP's dual-mode timers.
  */
 
+#include <clocksource/timer-ti-dm.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -30,17 +32,21 @@
 #include <linux/pwm.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/wait.h>
 
 #define DM_TIMER_LOAD_MIN 0xfffffffe
 #define DM_TIMER_MAX      0xffffffff
 
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
+	spinlock_t lock;
 	struct mutex mutex;
+	wait_queue_head_t wait;
 	pwm_omap_dmtimer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
 	unsigned long freq;
+	unsigned int ev_cnt, overflow, width;
 };
 
 static inline struct pwm_omap_dmtimer_chip *
@@ -55,6 +61,22 @@ pwm_omap_dmtimer_get_clock_cycles(struct pwm_omap_dmtimer_chip *omap, int ns)
 	return DIV_ROUND_CLOSEST_ULL((u64)omap->freq * ns, NSEC_PER_SEC);
 }
 
+static inline unsigned int
+pwm_omap_dmtimer_ticks_to_ns(struct pwm_omap_dmtimer_chip *omap,
+			     unsigned int ticks)
+{
+	return DIV_ROUND_CLOSEST_ULL((u64)ticks * NSEC_PER_SEC, omap->freq);
+}
+
+static unsigned int pwm_omap_dmtimer_get_width(struct pwm_omap_dmtimer_chip *omap,
+					       unsigned int c1, unsigned int c2)
+{
+	if (c1 <= c2)
+		return c2 - c1;
+
+	return (c2 - omap->overflow) + (DM_TIMER_MAX - c1);
+}
+
 static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
 {
 	/*
@@ -218,7 +240,101 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
+static int pwm_omap_dmtimer_capture(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_capture *result,
+				    unsigned long timeout)
+
+{
+	int res;
+	unsigned long flags;
+	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+
+	mutex_lock(&omap->mutex);
+
+	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
+		omap->pdata->stop(omap->dm_timer);
+
+	/* Let timer overflow every 1 second */
+	omap->overflow = DM_TIMER_MAX - (1 * omap->freq);
+	timeout = msecs_to_jiffies(timeout);
+	result->period = result->duty_cycle = 0;
+
+	spin_lock_irqsave(&omap->lock, flags);
+	omap->pdata->set_int_enable(omap->dm_timer, OMAP_TIMER_INT_CAPTURE |
+				    OMAP_TIMER_INT_OVERFLOW);
+	omap->pdata->set_capture(omap->dm_timer, 1, 1);
+	omap->pdata->set_load_start(omap->dm_timer, true, omap->overflow);
+	omap->ev_cnt = omap->width = 0;
+	spin_unlock_irqrestore(&omap->lock, flags);
+
+	res = wait_event_interruptible_timeout(omap->wait,
+					       omap->width > 0, timeout);
+	if (res > 0) {
+		spin_lock_irqsave(&omap->lock, flags);
+		result->period =
+			pwm_omap_dmtimer_ticks_to_ns(omap, omap->width);
+		omap->pdata->stop(omap->dm_timer);
+		omap->pdata->set_capture(omap->dm_timer, 1, 3);
+		omap->pdata->start(omap->dm_timer);
+		omap->ev_cnt = omap->width = 0;
+		spin_unlock_irqrestore(&omap->lock, flags);
+
+		res = wait_event_interruptible_timeout(omap->wait,
+						       omap->width > 0,
+						       timeout);
+	}
+
+	spin_lock_irqsave(&omap->lock, flags);
+	omap->pdata->stop(omap->dm_timer);
+	omap->pdata->set_int_disable(omap->dm_timer, OMAP_TIMER_INT_CAPTURE |
+				     OMAP_TIMER_INT_OVERFLOW);
+	spin_unlock_irqrestore(&omap->lock, flags);
+
+	if (res == 0) {
+		res = -ETIMEDOUT;
+	} else if (res > 0) {
+		result->duty_cycle =
+			pwm_omap_dmtimer_ticks_to_ns(omap, omap->width);
+		res = 0;
+	}
+
+	mutex_unlock(&omap->mutex);
+
+	return res;
+}
+
+static irqreturn_t pwm_omap_dmtimer_irq(int irq, void *dev_id)
+{
+	u32 l;
+	unsigned int c1, c2;
+	unsigned long flags;
+        struct pwm_omap_dmtimer_chip *omap = dev_id;
+
+	spin_lock_irqsave(&omap->lock, flags);
+
+	l = omap->pdata->read_status(omap->dm_timer);
+	if (l & OMAP_TIMER_INT_CAPTURE) {
+		if (!omap->width && omap->ev_cnt == 1) {
+			omap->pdata->read_capture(omap->dm_timer, &c1, &c2);
+			omap->width = pwm_omap_dmtimer_get_width(omap, c1, c2);
+			wake_up(&omap->wait);
+		}
+		omap->ev_cnt++;
+	}
+	/* TODO: handle overflow as well
+	if (l & OMAP_TIMER_INT_OVERFLOW)
+		overflow++;
+	*/
+	omap->pdata->write_status(omap->dm_timer, l);
+
+	spin_unlock_irqrestore(&omap->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 static const struct pwm_ops pwm_omap_dmtimer_ops = {
+	.capture = pwm_omap_dmtimer_capture,
 	.enable	= pwm_omap_dmtimer_enable,
 	.disable = pwm_omap_dmtimer_disable,
 	.config	= pwm_omap_dmtimer_config,
@@ -349,7 +465,18 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->chip.of_xlate = of_pwm_xlate_with_flags;
 	omap->chip.of_pwm_n_cells = 3;
 
+	spin_lock_init(&omap->lock);
 	mutex_init(&omap->mutex);
+	init_waitqueue_head(&omap->wait);
+
+	ret = omap->pdata->get_irq(omap->dm_timer);
+	if (ret < 0)
+		goto free_dm_timer;
+
+	ret = devm_request_irq(&pdev->dev, ret, pwm_omap_dmtimer_irq, 0,
+				"event_capture", omap);
+	if (ret)
+		goto free_dm_timer;
 
 	ret = pwmchip_add(&omap->chip);
 	if (ret < 0) {
-- 
2.16.1
