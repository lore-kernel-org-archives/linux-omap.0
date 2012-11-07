From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 02/14] ARM: OMAP2+: Disable posted mode for the clocksource timer
Date: Wed, 7 Nov 2012 13:01:18 -0600
Message-ID: <1352314890-22224-3-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698Ab2KGTBn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:43 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

When using a DMTIMER as the clock-source timer, posted mode configuration of
the DMTIMER is used. Posted mode is only benefical when configuring timers as
it allows writes to be posted and does not stall the CPU until the write is
complete. The clock-source timer is only configured once on boot and so using
posted mode has no benefit. In fact, by using posted mode, it adds overhead
to reading the timer. Therefore, by default disable posted mode for DMTIMERs
used for clock-source.

Using objdump this change reduces the function clocksource_read_cycles()
function from a total of 15 instructions (including 3 branches and 7 loads)
to 5 instructions (including 1 branch and 3 loads). Please note that before
the minimum number of instructions that would be executed when calling
clocksource_read_cycles() would be 9 instructions (including 2 branches and 5
loads) where as now it will always be 5 instructions.

This change also reduces the function dmtimer_read_sched_clock() function from
a total of 17 instructions (including 4 branches and 8 loads) to 6 instructions
(including 1 branch and 4 loads). Please note that before the minimum number of
instructions that would be executed when calling dmtimer_read_sched_clock()
would be 11 instructions (including 2 branches and 6 loads) where as now it
will always be 6 instructions.

This change removes the configuration of posted mode from the
__omap_dm_timer_reset() function and adds a new function called
omap_dm_timer_enable_posted() for enabling posted mode. Hence, call
omap_dm_timer_enable_posted() where ever we are calling __omap_dm_timer_reset().

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   28 ++++++++++++++++++++--------
 arch/arm/plat-omap/dmtimer.c              |   23 ++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    5 +----
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 28c6078..78b7712 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -83,11 +83,19 @@
 #define NUMERATOR_DENUMERATOR_MASK			0xfffff000
 
 /*
- * For clock-events timer, always use posted mode to
- * minimise CPU overhead for configuring the timer.
+ * For the clock-events timer, always use posted mode to
+ * minimise CPU overhead for configuring the timer. This timer
+ * is never read and so overhead of reading the timer in posted
+ * mode is not applicable.
  */
 #define OMAP_CLKEVT_POSTEDMODE	OMAP_TIMER_POSTED
-#define OMAP_CLKSRC_POSTEDMODE	OMAP_TIMER_POSTED
+
+/*
+ * For the clock-source timer, always use non-posted mode to
+ * minimise CPU overhead for reading the timer. This timer is
+ * only configured once and so using posted mode has no benefit.
+ */
+#define OMAP_CLKSRC_POSTEDMODE	OMAP_TIMER_NONPOSTED
 
 /* Clockevent code */
 
@@ -233,7 +241,8 @@ void __init omap_dmtimer_init(void)
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 						int gptimer_id,
 						const char *fck_source,
-						const char *property)
+						const char *property,
+						int posted)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	const char *oh_name;
@@ -319,10 +328,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	}
 	__omap_dm_timer_init_regs(timer);
 	__omap_dm_timer_reset(timer, 1, 1);
-	timer->posted = 1;
 
-	timer->rate = clk_get_rate(timer->fclk);
+	if (posted)
+		omap_dm_timer_enable_posted(timer);
 
+	timer->rate = clk_get_rate(timer->fclk);
 	timer->reserved = 1;
 
 	return res;
@@ -334,7 +344,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property);
+	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source, property,
+				     OMAP_CLKEVT_POSTEDMODE);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = &clkev;
@@ -461,7 +472,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 {
 	int res;
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL);
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
+				     OMAP_CLKSRC_POSTEDMODE);
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index b09e556..699570b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -131,8 +131,8 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 
 	__omap_dm_timer_reset(timer, 0, 0);
+	omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
-	timer->posted = 1;
 }
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
@@ -176,6 +176,27 @@ int omap_dm_timer_reserve_systimer(int id)
 	return 0;
 }
 
+/**
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
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+				OMAP_TIMER_CTRL_POSTED);
+	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
+	timer->posted = OMAP_TIMER_POSTED;
+}
+
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 835c3bdf..2d0228f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -101,6 +101,7 @@ struct dmtimer_platform_data {
 };
 
 int omap_dm_timer_reserve_systimer(int id);
+void omap_dm_timer_enable_posted(struct omap_dm_timer *timer);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
@@ -342,10 +343,6 @@ static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
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

