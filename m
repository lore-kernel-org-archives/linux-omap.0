From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V6 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Wed, 2 May 2012 19:26:54 +0530
Message-ID: <1335967014-11937-4-git-send-email-hvaibhav@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48204 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab2EBODs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 10:03:48 -0400
In-Reply-To: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Current OMAP code supports couple of clocksource options based
on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
So there can be 3 options -

1. 32KHz sync-timer
2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
3. 32KHz based gptimer.

The optional gptimer based clocksource was added so that it can
give the high precision than sync-timer, so expected usage was 2
and not 3.
Unfortunately option 2, clocksource doesn't meet the requirement of
free-running clock as per clocksource need. It stops in low power states
when sys_clock is cut. That makes gptimer based clocksource option
useless for OMAP2/3/4 devices with sys_clock as a clock input.
So, in order to use option 2, deeper idle state MUST be disabled.

Option 3 will still work but it is no better than 32K sync-timer
based clocksource.

We must support both sync timer and gptimer based clocksource as
some OMAP based derivative SoCs like AM33XX does not have the
sync timer.

Considering above, make sync-timer and gptimer clocksource runtime
selectable so that both OMAP and AMXXXX continue to use the same code.

And, in order to precisely configure/setup sched_clock for given
clocksource, decision has to be made early enough in boot sequence.

So, the solution is,

Use standard kernel parameter ("clocksource=") to override
default 32k_sync-timer, in addition to this, we also use hwmod database
lookup mechanism, through which at run-time we can identify availability
of 32k-sync timer on the device, else fall back to gptimer.

Also, moved low-level SoC specific init code to respective files,
(mach-omap1/timer32k.c and mach-omap2/timer.c)

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>
---
Two of the original patch-series (1/3 and 2/3) has already been
accepted and queued by Paul, so removing them.
New 2 patches have been added to the series,
	- OMAP2 timer32k cleanup, check for return values.
	- Changed name of system timers, "gp timer" => "gp_timer".

 arch/arm/mach-omap1/timer32k.c           |   19 +++++-
 arch/arm/mach-omap2/timer.c              |  112 ++++++++++++++++++++++++------
 arch/arm/plat-omap/counter_32k.c         |   91 ++++++++++--------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 4 files changed, 147 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index e3613a8..eae49c3 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -71,6 +71,7 @@

 /* 16xx specific defines */
 #define OMAP1_32K_TIMER_BASE		0xfffb9000
+#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc400
 #define OMAP1_32K_TIMER_CR		0x08
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
@@ -186,8 +187,22 @@ int __init omap_32k_timer_init(void)
 {
 	int ret = -ENODEV;

-	if (cpu_is_omap16xx())
-		ret = omap_init_clocksource_32k();
+	if (cpu_is_omap16xx()) {
+		void __iomem *base;
+		struct clk *sync32k_ick;
+
+		base = ioremap(OMAP1_32KSYNC_TIMER_BASE, SZ_1K);
+		if (!base) {
+			pr_err("32k_counter: failed to map base addr\n");
+			return -ENODEV;
+		}
+
+		sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
+		if (!IS_ERR(sync32k_ick))
+			clk_enable(sync32k_ick);
+
+		ret = omap_init_clocksource_32k(base);
+	}

 	if (!ret)
 		omap_init_32k_timer();
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 777f84b..30824b5 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -243,22 +243,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 }

 /* Clocksource code */
-
-#ifdef CONFIG_OMAP_32K_TIMER
-/*
- * When 32k-timer is enabled, don't use GPTimer for clocksource
- * instead, just leave default clocksource which uses the 32k
- * sync counter.  See clocksource setup in plat-omap/counter_32k.c
- */
-
-static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
-{
-	omap_init_clocksource_32k();
-}
-
-#else
-
 static struct omap_dm_timer clksrc;
+static bool use_gptimer_clksrc;

 /*
  * clocksource
@@ -285,7 +271,46 @@ static u32 notrace dmtimer_read_sched_clock(void)
 }

 /* Setup free-running counter for clocksource */
-static void __init omap2_gp_clocksource_init(int gptimer_id,
+static int __init omap2_sync32k_clocksource_init(void)
+{
+	int ret;
+	struct omap_hwmod *oh;
+	void __iomem *vbase;
+	const char *oh_name = "counter_32k";
+
+	/*
+	 * First check hwmod data is available for sync32k counter
+	 */
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh || oh->slaves_cnt == 0)
+		return -ENODEV;
+
+	omap_hwmod_setup_one(oh_name);
+
+	vbase = omap_hwmod_get_mpu_rt_va(oh);
+	if (!vbase) {
+		pr_warn("%s: failed to get counter_32k resource\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = omap_hwmod_enable(oh);
+	if (ret) {
+		pr_warn("%s: failed to enable counter_32k module (%d)\n",
+							__func__, ret);
+		return ret;
+	}
+
+	ret = omap_init_clocksource_32k(vbase);
+	if (ret) {
+		pr_warn("%s: failed to initialize counter_32k as a clocksource (%d)\n",
+							__func__, ret);
+		omap_hwmod_idle(oh);
+	}
+
+	return ret;
+}
+
+static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
 {
 	int res;
@@ -293,9 +318,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
 	BUG_ON(res);

-	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
-		gptimer_id, clksrc.rate);
-
 	__omap_dm_timer_load_start(&clksrc,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
@@ -303,15 +325,36 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
 			clocksource_gpt.name);
+	else
+		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
+			gptimer_id, clksrc.rate);
+}
+
+static void __init omap2_clocksource_init(int gptimer_id,
+						const char *fck_source)
+{
+	/*
+	 * First give preference to kernel parameter configuration
+	 * by user (clocksource="gp_timer").
+	 *
+	 * In case of missing kernel parameter for clocksource,
+	 * first check for availability for 32k-sync timer, in case
+	 * of failure in finding 32k_counter module or registering
+	 * it as clocksource, execution will fallback to gp-timer.
+	 */
+	if (use_gptimer_clksrc == true)
+		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
+	else if (omap2_sync32k_clocksource_init())
+		/* Fall back to gp-timer code */
+		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
 }
-#endif

 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
 				clksrc_nr, clksrc_src)			\
 static void __init omap##name##_timer_init(void)			\
 {									\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
-	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);		\
+	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
 }

 #define OMAP_SYS_TIMER(name)						\
@@ -342,7 +385,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
 static void __init omap4_timer_init(void)
 {
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
-	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
+	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
 #ifdef CONFIG_LOCAL_TIMERS
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
@@ -510,3 +553,28 @@ static int __init omap2_dm_timer_init(void)
 	return 0;
 }
 arch_initcall(omap2_dm_timer_init);
+
+/**
+ * omap2_override_clocksource - clocksource override with user configuration
+ *
+ * Allows user to override default clocksource, using kernel parameter
+ *   clocksource="gp_timer"	(For all OMAP2PLUS architectures)
+ *
+ * Note that, here we are using same standard kernel parameter "clocksource=",
+ * and not introducing any OMAP specific interface.
+ */
+static int __init omap2_override_clocksource(char *str)
+{
+	if (!str)
+		return 0;
+	/*
+	 * For OMAP architecture, we only have two options
+	 *    - sync_32k (default)
+	 *    - gp_timer (sys_clk based)
+	 */
+	if (!strcmp(str, "gp_timer"))
+		use_gptimer_clksrc = true;
+
+	return 0;
+}
+early_param("clocksource", omap2_override_clocksource);
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..b2f634b 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -27,19 +27,20 @@

 #include <plat/clock.h>

+/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
+#define OMAP2_32KSYNCNT_CR_OFF		0x10
+
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
  * OMAP 730 and 1510.  Other timers could be used as clocksources, with
  * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
  * but systems won't necessarily want to spend resources that way.
  */
-static void __iomem *timer_32k_base;
-
-#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
+static void __iomem *sync32k_cnt_reg;

 static u32 notrace omap_32k_read_sched_clock(void)
 {
-	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
+	return sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
 }

 /**
@@ -59,7 +60,7 @@ void read_persistent_clock(struct timespec *ts)
 	struct timespec *tsp = &persistent_ts;

 	last_cycles = cycles;
-	cycles = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
+	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
 	delta = cycles - last_cycles;

 	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
@@ -68,54 +69,40 @@ void read_persistent_clock(struct timespec *ts)
 	*ts = *tsp;
 }

-int __init omap_init_clocksource_32k(void)
+/**
+ * omap_init_clocksource_32k - setup and register counter 32k as a
+ * kernel clocksource
+ * @pbase: base addr of counter_32k module
+ * @size: size of counter_32k to map
+ *
+ * Returns 0 upon success or negative error code upon failure.
+ *
+ */
+int __init omap_init_clocksource_32k(void __iomem *vbase)
 {
-	static char err[] __initdata = KERN_ERR
-			"%s: can't register clocksource!\n";
-
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		u32 pbase;
-		unsigned long size = SZ_4K;
-		void __iomem *base;
-		struct clk *sync_32k_ick;
-
-		if (cpu_is_omap16xx()) {
-			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
-			size = SZ_1K;
-		} else if (cpu_is_omap2420())
-			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
-		else if (cpu_is_omap2430())
-			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
-		else if (cpu_is_omap34xx())
-			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
-		else if (cpu_is_omap44xx())
-			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
-		else
-			return -ENODEV;
-
-		/* For this to work we must have a static mapping in io.c for this area */
-		base = ioremap(pbase, size);
-		if (!base)
-			return -ENODEV;
-
-		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
-		if (!IS_ERR(sync_32k_ick))
-			clk_enable(sync_32k_ick);
-
-		timer_32k_base = base;
-
-		/*
-		 * 120000 rough estimate from the calculations in
-		 * __clocksource_updatefreq_scale.
-		 */
-		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
-				32768, NSEC_PER_SEC, 120000);
-
-		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
-					  clocksource_mmio_readl_up))
-			printk(err, "32k_counter");
-
-		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+	int ret;
+
+	/*
+	 * 32k sync Counter register offset is at 0x10
+	 */
+	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
+
+	/*
+	 * 120000 rough estimate from the calculations in
+	 * __clocksource_updatefreq_scale.
+	 */
+	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
+			32768, NSEC_PER_SEC, 120000);
+
+	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
+				250, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("32k_counter: can't register clocksource\n");
+		return ret;
 	}
+
+	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index a557b84..d1cb6f5 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -30,7 +30,7 @@
 #include <plat/i2c.h>
 #include <plat/omap_hwmod.h>

-extern int __init omap_init_clocksource_32k(void);
+extern int __init omap_init_clocksource_32k(void __iomem *vbase);

 extern void __init omap_check_revision(void);

--
1.7.0.4

