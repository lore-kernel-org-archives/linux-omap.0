From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/6] Implement event capture for OMAP (draft)
Date: Fri, 23 Feb 2018 11:12:54 +0100
Message-ID: <20180223101254.GA5746@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

Hi,

this patchset based on next-20180223 first cleans up playground (patches
1-4 which I'd appreciate to be reviewed and merged eventually) and then
adds event capture functionality which is just good for doing:
$ echo 0 > /sys/class/pwm/pwmchip4/export
$ cat /sys/class/pwm/pwmchip4/pwm0/capture 
1000000 500000
$ cat /sys/class/pwm/pwmchip4/pwm0/capture 
100000 50000
$ cat /sys/class/pwm/pwmchip4/pwm0/capture 
100000 75000

Above measured frequencies are 1kHz and 10kHz with 50% duty cycle,
the last one is with 75% duty cycle. However with 100kHz it sometimes
ends with:
$ cat /sys/class/pwm/pwmchip4/pwm0/capture 
omap_dm_timer_read_status: timer not available or enabled.
12462 6231

So locking is probably not done right, therefore patches 5 and 6 are sent
only for reference, as there's also another fundamental problem:

Hardware can be told to capture both edges, but there's no way to tell it
which one should be captured first. Other posibility would be first
configure for rising edge and reconfigure in interrupt for falling one.
Here we meet latency problem again:
https://www.spinics.net/lists/linux-omap/msg140081.html
Attached test patch shows average diff around 150us (sometimes over 300us)
which pretty much limits maximum measurable frequency.

I tried to misuse PM_QOS_CPU_DMA_LATENCY to overcome latency issue, but
with no luck.

Ladislav Michl (6):
  clocksource: timer-ti-dm: Make unexported functions static
  clocksource: timer-ti-dm: Consolidate set source
  clocksource: timer-ti-dm: Check prescaler value
  pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
  clocksource: timer-ti-dm: Add event capture
  pwm: pwm-omap-dmtimer: Add capture functionality

 drivers/clocksource/timer-ti-dm.c          | 263 ++++++++++++++++-------------
 drivers/pwm/pwm-omap-dmtimer.c             | 220 +++++++++++++++++++-----
 include/clocksource/timer-ti-dm.h          |  33 ----
 include/linux/platform_data/dmtimer-omap.h |   8 +
 4 files changed, 340 insertions(+), 184 deletions(-)

Latency test patch:

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 5a2fc0e0a1c5..c1a94740079a 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -46,7 +46,7 @@ struct pwm_omap_dmtimer_chip {
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
 	unsigned long freq;
-	unsigned int ev_cnt, overflow, width;
+	unsigned int ev_cnt, overflow, width, counter_irq, counter_captured;
 };
 
 static inline struct pwm_omap_dmtimer_chip *
@@ -280,6 +280,8 @@ static int pwm_omap_dmtimer_capture(struct pwm_chip *chip,
 		omap->ev_cnt = omap->width = 0;
 		spin_unlock_irqrestore(&omap->lock, flags);
 
+		printk("diff: %d\n", pwm_omap_dmtimer_ticks_to_ns(omap, omap->counter_irq - omap->counter_captured));
+
 		res = wait_event_interruptible_timeout(omap->wait,
 						       omap->width > 0,
 						       timeout);
@@ -317,6 +319,8 @@ static irqreturn_t pwm_omap_dmtimer_irq(int irq, void *dev_id)
 	if (l & OMAP_TIMER_INT_CAPTURE) {
 		if (!omap->width && omap->ev_cnt == 1) {
 			omap->pdata->read_capture(omap->dm_timer, &c1, &c2);
+			omap->counter_irq = omap->pdata->read_counter(omap->dm_timer);
+			omap->counter_captured = c2;
 			omap->width = pwm_omap_dmtimer_get_width(omap, c1, c2);
 			wake_up(&omap->wait);
 		}

-- 
2.16.1
