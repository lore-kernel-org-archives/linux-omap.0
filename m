From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 01/10] ARM: OMAP3+: Implement timer workaround for errata i103 and i767
Date: Wed, 5 Sep 2012 14:04:23 -0500
Message-ID: <1346871872-24413-2-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758989Ab2IETEt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:49 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
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

Although both dmtimers and watchdogs are impacted by this defect this patch only
implements the workaround for the dmtimer. Currently the watchdog driver does
not read the counter register and so no workaround is necessary.

Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    9 +++++++
 arch/arm/plat-omap/dmtimer.c              |    2 ++
 arch/arm/plat-omap/include/plat/dmtimer.h |   39 +++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..5471706 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -208,6 +208,13 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 {
 	int res;
 
+	/*
+	 * For clock-event timers we never read the timer counter and
+	 * so we are not impacted by errata i103 and i767. Therefore,
+	 * we can safely ignore this errata for clock-event timers.
+	 */
+	__omap_dm_timer_populate_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
+
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
 	BUG_ON(res);
 
@@ -305,6 +312,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
+	__omap_dm_timer_populate_errata(&clksrc, 0);
+
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
 	BUG_ON(res);
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 938b50a..c34f55b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -730,6 +730,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 	timer->capability = pdata->timer_capability;
 
+	__omap_dm_timer_populate_errata(timer, 0);
+
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		pm_runtime_enable(dev);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 19e7fa5..5ce2f00 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <plat/cpu.h>
 
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
@@ -61,6 +62,16 @@
 #define OMAP_TIMER_HAS_PWM				0x20000000
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
 
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
@@ -265,6 +276,7 @@ struct omap_dm_timer {
 	int ctx_loss_count;
 	int revision;
 	u32 capability;
+	u32 errata;
 	struct platform_device *pdev;
 	struct list_head node;
 };
@@ -337,11 +349,38 @@ static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
 
 	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
 
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767)
+		return;
+
 	/* Match hardware reset default of posted mode */
 	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
 					OMAP_TIMER_CTRL_POSTED, 0);
 }
 
+/**
+ * __omap_dm_timer_populate_errata - populate errata flags for a timer
+ * @timer:      pointer to timer handle
+ * @override:   errata flags to be ignored
+ *
+ * For a given timer, populate the timer errata flags that are specific to the
+ * OMAP device being used. An override argument is provided so that a specific
+ * erratum could be ignored for a timer if the timer is used in such a way the
+ * erratum has no impact.
+ */
+static inline void
+__omap_dm_timer_populate_errata(struct omap_dm_timer *timer, u32 override)
+{
+	timer->errata = 0;
+
+	if (cpu_class_is_omap1() || cpu_is_omap24xx())
+		return;
+
+	if (override & OMAP_TIMER_ERRATA_I103_I767)
+		return;
+
+	timer->errata = OMAP_TIMER_ERRATA_I103_I767;
+}
+
 static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
 						struct clk *parent)
 {
-- 
1.7.9.5

