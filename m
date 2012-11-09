From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 03/14] ARM: OMAP3+: Implement timer workaround for
 errata i103 and i767
Date: Fri, 9 Nov 2012 13:41:14 -0600
Message-ID: <509D5C5A.1010200@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-4-git-send-email-jon-hunter@ti.com> <509ADD28.20707@ti.com> <509AEEA4.80804@ti.com> <509AF21C.7020105@ti.com> <509BE3E4.8050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45387 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab2KITlT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 14:41:19 -0500
In-Reply-To: <509BE3E4.8050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/08/2012 10:55 AM, Jon Hunter wrote:
> 
> On 11/07/2012 05:43 PM, Santosh Shilimkar wrote:
>> On Wednesday 07 November 2012 05:28 PM, Jon Hunter wrote:
>>>
>>> On 11/07/2012 04:14 PM, Santosh Shilimkar wrote:
>>>
>>>> Looks sensible considering alternative WAs.
>>>>
>>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Thanks. With further thought I think that it would be best to combine
>>> patches #2 and #3. Really the main motivation here is the errata
>>> workaround and without actually benchmarking the timer read I should
>>> not claim the improvement in overhead as stated in patch #2. So I
>>> have combined #2 and #3 and updated the changelog/comments
>>> appropriately. Let me know if you guys are ok with this.
>>>
>> Yep. Sounds good.
> 
> Updated, removing the additional OMAP_CLKEVT/SRC_POSTEDMODE definitions.

Another minor update after rebasing on Tony's linux-omap master. I
needed to fix-up headers included.

Cheers
Jon

>From 0b2e3ef2cea7896f6466e010f9ab22a86a00bba1 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 27 Sep 2012 12:47:43 -0500
Subject: [PATCH] ARM: OMAP3+: Implement timer workaround for errata i103 and
 i767

Errata Titles:
i103: Delay needed to read some GP timer, WD timer and sync timer
      registers after wakeup (OMAP3/4)
i767: Delay needed to read some GP timer registers after wakeup (OMAP5)

Description (i103/i767):
If a General Purpose Timer (GPTimer) is in posted mode
(TSICR [2].POSTED=1), due to internal resynchronizations, values read in
TCRR, TCAR1 and TCAR2 registers right after the timer interface clock
(L4) goes from stopped to active may not return the expected values. The
most common event leading to this situation occurs upon wake up from
idle.

GPTimer non-posted synchronization mode is not impacted by this
limitation.

Workarounds:
1). Disable posted mode
2). Use static dependency between timer clock domain and MPUSS clock
    domain
3). Use no-idle mode when the timer is active

Workarounds #2 and #3 are not pratical from a power standpoint and so
workaround #1 has been implemented. Disabling posted mode adds some CPU
overhead for configuring and reading the timers as the CPU has to wait
for accesses to be re-synchronised within the timer. However, disabling
posted mode guarantees correct operation.

Please note that it is safe to use posted mode for timers if the counter
(TCRR) and capture (TCARx) registers will never be read. An example of
this is the clock-event system timer. This is used by the kernel to
schedule events however, the timers counter is never read and capture
registers are not used. Given that the kernel configures this timer
often yet never reads the counter register it is safe to enable posted
mode in this case. Hence, for the timer used for kernel clock-events,
posted mode is enabled by overriding the errata for devices that are
impacted by this defect.

For drivers using the timers that do not read the counter or capture
registers and wish to use posted mode, can override the errata and
enable posted mode by making the following function calls.

	omap_dm_timer_override_errata(timer, OMAP_TIMER_ERRATA_I103_I767);
	omap_dm_timer_enable_posted(timer);

Both dmtimers and watchdogs are impacted by this defect this patch only
implements the workaround for the dmtimer. Currently the watchdog driver
does not read the counter register and so no workaround is necessary.

Posted mode will be disabled for all OMAP2+ devices (including AM33xx)
using a GP timer as a clock-source timer to guarantee correct operation.
This is not necessary for OMAP24xx devices but the default clock-source
timer for OMAP24xx devices is the 32k-sync timer and not the GP timer
and so should not have any impact. This should be re-visited for future
devices if this errata is fixed.

Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx
devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   35 +++++++++++++----
 arch/arm/plat-omap/dmtimer.c              |   60 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |   18 +++++++--
 3 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a135d28..23ebe15 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -225,7 +225,8 @@ void __init omap_dmtimer_init(void)
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 						int gptimer_id,
 						const char *fck_source,
-						const char *property)
+						const char *property,
+						int posted)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	const char *oh_name;
@@ -311,10 +312,15 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	}
 	__omap_dm_timer_init_regs(timer);
 	__omap_dm_timer_reset(timer, 1, 1);
-	timer->posted = 1;
 
-	timer->rate = clk_get_rate(timer->fclk);
+	if (posted)
+		omap_dm_timer_enable_posted(timer);
 
+	/* Check that the intended posted configuration matches the actual */
+	if (posted != timer->posted)
+		return -EINVAL;
+
+	timer->rate = clk_get_rate(timer->fclk);
 	timer->reserved = 1;
 
 	return res;
@@ -326,7 +332,17 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property);
+	omap_dm_timer_populate_errata(&clkev);
+
+	/*
+	 * For clock-event timers we never read the timer counter and
+	 * so we are not impacted by errata i103 and i767. Therefore,
+	 * we can safely ignore this errata for clock-event timers.
+	 */
+	omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
+
+	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
+				     OMAP_TIMER_POSTED);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = &clkev;
@@ -360,7 +376,7 @@ static bool use_gptimer_clksrc;
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)__omap_dm_timer_read_counter(&clksrc,
-						     OMAP_TIMER_POSTED);
+						     OMAP_TIMER_NONPOSTED);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -375,7 +391,7 @@ static u32 notrace dmtimer_read_sched_clock(void)
 {
 	if (clksrc.reserved)
 		return __omap_dm_timer_read_counter(&clksrc,
-						    OMAP_TIMER_POSTED);
+						    OMAP_TIMER_NONPOSTED);
 
 	return 0;
 }
@@ -453,12 +469,15 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL);
+	omap_dm_timer_populate_errata(&clksrc);
+
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
+				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
 				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0,
-				   OMAP_TIMER_POSTED);
+				   OMAP_TIMER_NONPOSTED);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9dca23e..9a15123 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
+#include <plat/cpu.h>
 #include <plat/dmtimer.h>
 
 static u32 omap_reserved_systimers;
@@ -128,8 +129,8 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 
 	__omap_dm_timer_reset(timer, 0, 0);
+	omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
-	timer->posted = 1;
 }
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
@@ -173,6 +174,61 @@ int omap_dm_timer_reserve_systimer(int id)
 	return 0;
 }
 
+/**
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
+ * omap_dm_timer_enable_posted - enables write posted mode
+ * @timer:      pointer to timer instance handle
+ *
+ * Enables the write posted mode for the timer. When posted mode is enabled
+ * writes to certain timer registers are immediately acknowledged by the
+ * internal bus and hence prevents stalling the CPU waiting for the write to
+ * complete. Enabling this feature can improve performance for writing to the
+ * timer registers.
+ */
+void omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+{
+	if (timer->posted)
+		return;
+
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767)
+		return;
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+				OMAP_TIMER_CTRL_POSTED);
+	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
+	timer->posted = OMAP_TIMER_POSTED;
+}
+
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -805,6 +861,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
+	omap_dm_timer_populate_errata(timer);
+
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		pm_runtime_enable(dev);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 1bee0ac..2ebc8d6 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -66,6 +66,16 @@
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
@@ -102,6 +112,9 @@ struct dmtimer_platform_data {
 };
 
 int omap_dm_timer_reserve_systimer(int id);
+void omap_dm_timer_populate_errata(struct omap_dm_timer *timer);
+void omap_dm_timer_override_errata(struct omap_dm_timer *timer, u32 errata);
+void omap_dm_timer_enable_posted(struct omap_dm_timer *timer);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
@@ -273,6 +286,7 @@ struct omap_dm_timer {
 	int ctx_loss_count;
 	int revision;
 	u32 capability;
+	u32 errata;
 	struct platform_device *pdev;
 	struct list_head node;
 };
@@ -344,10 +358,6 @@ static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
 		l |= 1 << 2;
 
 	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
-
-	/* Match hardware reset default of posted mode */
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-					OMAP_TIMER_CTRL_POSTED, 0);
 }
 
 static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
-- 
1.7.9.5
