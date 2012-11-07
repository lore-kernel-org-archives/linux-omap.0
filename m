From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 03/14] ARM: OMAP3+: Implement timer workaround for errata i103 and i767
Date: Wed, 7 Nov 2012 13:01:19 -0600
Message-ID: <1352314890-22224-4-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48749 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab2KGTBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 14:01:46 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Errata Titles:
i103: Delay needed to read some GP timer, WD timer and sync timer registers
      after wakeup (OMAP3/4)
i767: Delay needed to read some GP timer registers after wakeup (OMAP5)

Description (i103/i767):
If a General Purpose Timer (GPTimer) is in posted mode (TSICR [2].POSTED=1),
due to internal resynchronizations, values read in TCRR, TCAR1 and TCAR2
registers right after the timer interface clock (L4) goes from stopped to
active may not return the expected values. The most common event leading to
this situation occurs upon wake up from idle.

GPTimer non-posted synchronization mode is not impacted by this limitation.

Workarounds:
1). Disable posted mode
2). Use static dependency between timer clock domain and MPUSS clock domain
3). Use no-idle mode when the timer is active

Workarounds #2 and #3 are not pratical from a power standpoint and so
workaround #1 has been implemented. Disabling posted mode adds some CPU overhead
for configuring the timers as the CPU has to wait for the write to complete.
However, disabling posted mode guarantees correct operation.

Please note that it is safe to use posted mode for timers if the counter (TCRR)
and capture (TCARx) registers will never be read. An example of this is the
clock-event system timer. This is used by the kernel to schedule events however,
the timers counter is never read and capture registers are not used. Given that
the kernel configures this timer often yet never reads the counter register it
is safe to enable posted mode in this case. Hence, for the timer used for kernel
clock-events, posted mode is enabled by overriding the errata for devices that
are impacted by this defect.

For drivers using the timers that do not read the counter or capture registers
and wish to use posted mode, can override the errata and enable posted mode by
making the following function calls.

	omap_dm_timer_override_errata(timer, OMAP_TIMER_ERRATA_I103_I767);
	omap_dm_timer_enable_posted(timer);

Both dmtimers and watchdogs are impacted by this defect this patch only
implements the workaround for the dmtimer. Currently the watchdog driver does
not read the counter register and so no workaround is necessary.

Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx devices.

Please note that now calls to omap_dm_timer_enable_posted() may not able posted
mode if the device is impacted by this errata. Therefore, for system-timers
check to see if the intended posted mode matches the actual. If it does not then
there is a configuration error in the system timers posted configuration.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   15 ++++++++++++
 arch/arm/plat-omap/dmtimer.c              |   36 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |   14 +++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 78b7712..8b0068c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -332,6 +332,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (posted)
 		omap_dm_timer_enable_posted(timer);
 
+	/* Check that the intended posted configuration matches the actual */
+	if (posted != timer->posted)
+		return -EINVAL;
+
 	timer->rate = clk_get_rate(timer->fclk);
 	timer->reserved = 1;
 
@@ -344,6 +348,15 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 {
 	int res;
 
+	omap_dm_timer_populate_errata(&clkev);
+
+	/*
+	 * For clock-event timers we never read the timer counter and
+	 * so we are not impacted by errata i103 and i767. Therefore,
+	 * we can safely ignore this errata for clock-event timers.
+	 */
+	omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
+
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
 				     OMAP_CLKEVT_POSTEDMODE);
 	BUG_ON(res);
@@ -472,6 +485,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
+	omap_dm_timer_populate_errata(&clksrc);
+
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
 				     OMAP_CLKSRC_POSTEDMODE);
 	BUG_ON(res);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 699570b..4abbbe5 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -177,6 +177,37 @@ int omap_dm_timer_reserve_systimer(int id)
 }
 
 /**
+ * omap_dm_timer_populate_errata - populate errata flags for a timer
+ * @timer:      pointer to timer handle
+ *
+ * For a given timer, populate the timer errata flags that are specific to the
+ * OMAP device being used.
+ */
+void omap_dm_timer_populate_errata(struct omap_dm_timer *timer)
+{
+	timer->errata = 0;
+
+	if (cpu_class_is_omap1() || cpu_is_omap24xx())
+		return;
+
+	timer->errata = OMAP_TIMER_ERRATA_I103_I767;
+}
+
+/**
+ * omap_dm_timer_override_errata - override errata flags for a timer
+ * @timer:      pointer to timer handle
+ * @errata:	errata flags to be ignored
+ *
+ * For a given timer, override a timer errata by clearing the flags specified
+ * by the errata argument. A specific erratum should only be overridden for a
+ * timer if the timer is used in such a way the erratum has no impact.
+ */
+void omap_dm_timer_override_errata(struct omap_dm_timer *timer, u32 errata)
+{
+	timer->errata &= ~errata;
+}
+
+/*
  * omap_dm_timer_enable_posted - enables write posted mode
  * @timer:      pointer to timer instance handle
  *
@@ -191,6 +222,9 @@ void omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
 	if (timer->posted)
 		return;
 
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767)
+		return;
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
 				OMAP_TIMER_CTRL_POSTED);
 	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
@@ -824,6 +858,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
+	omap_dm_timer_populate_errata(timer);
+
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		pm_runtime_enable(dev);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 2d0228f..ef93017 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <plat/cpu.h>
 
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
@@ -66,6 +67,16 @@
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
 #define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
 
+/*
+ * timer errata flags
+ *
+ * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
+ * errata prevents us from using posted mode on these devices, unless the
+ * timer counter register is never read. For more details please refer to
+ * the OMAP3/4/5 errata documents.
+ */
+#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
+
 struct omap_timer_capability_dev_attr {
 	u32 timer_capability;
 };
@@ -101,6 +112,8 @@ struct dmtimer_platform_data {
 };
 
 int omap_dm_timer_reserve_systimer(int id);
+void omap_dm_timer_populate_errata(struct omap_dm_timer *timer);
+void omap_dm_timer_override_errata(struct omap_dm_timer *timer, u32 errata);
 void omap_dm_timer_enable_posted(struct omap_dm_timer *timer);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
@@ -272,6 +285,7 @@ struct omap_dm_timer {
 	int ctx_loss_count;
 	int revision;
 	u32 capability;
+	u32 errata;
 	struct platform_device *pdev;
 	struct list_head node;
 };
-- 
1.7.9.5

