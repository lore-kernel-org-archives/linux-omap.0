From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 22/26] ARM: OMAP: dmtimer: Eliminate
 __omap_dm_timer_write_status function
Date: Thu, 24 Apr 2014 16:44:05 -0500
Message-ID: <1398375849-6017-23-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

__omap_dm_timer_write_status is folded back into omap_dm_timer_write_status,
all users are converted to use it, and old API is removed. This works thanks to
the systimer flag just introduced in the series.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    2 +-
 arch/arm/plat-omap/dmtimer.c              |    5 ++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    6 ------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5cceaae..7c0cd72 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -80,7 +80,7 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_gpt;
 
-	__omap_dm_timer_write_status(&clkev, OMAP_TIMER_INT_OVERFLOW);
+	omap_dm_timer_write_status(&clkev, OMAP_TIMER_INT_OVERFLOW);
 
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 504784f..af67e30 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -768,6 +768,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
 
 static int is_timer_available(struct omap_dm_timer *timer)
 {
+	if (timer && timer->systimer)
+		return 1;
+
 	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
 		pr_err("Timer not available or enabled.\n");
 		WARN_ON(1);
@@ -794,7 +797,7 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 	if (!is_timer_available(timer))
 		return -EINVAL;
 
-	__omap_dm_timer_write_status(timer, value);
+	__raw_writel(value, timer->irq_stat);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 7005a1e..f542ef2 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -380,10 +380,4 @@ __omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
 	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
 }
 
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	__raw_writel(value, timer->irq_stat);
-}
-
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.7.9.5
