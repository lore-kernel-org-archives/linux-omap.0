From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Fri, 13 Apr 2012 15:09:07 +0530
Message-ID: <1334309947-25214-4-git-send-email-hvaibhav@ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46994 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab2DMJjl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:39:41 -0400
In-Reply-To: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

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
Option 3 will still work but it is no better than 32K sync-timer
based clocksource.

So ideally we can kill the gptimer based clocksource option but there
are some OMAP based derivative SoCs like AM33XX which doesn't have
32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
clocksource.
Considering above, make sync-timer and gptimer clocksource runtime
selectable so that both OMAP and AMXXXX continue to use the same code.

Also, in order to precisely configure/setup sched_clock for given
clocksource, decision has to be made early enough in boot sequence.

So, the solution is,

Use kernel parameter ("clocksource=") to override
default 32k_sync-timer, in addition to this, we also use hwmod database
lookup mechanism, through which at run-time we can identify availability
of 32k-sync timer on the device, else fall back to gptimer.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap1/timer32k.c           |    6 ++-
 arch/arm/mach-omap2/timer.c              |  100 +++++++++++++++++++++++-------
 arch/arm/plat-omap/counter_32k.c         |   85 +++++++++++---------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 4 files changed, 120 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 325b9a0..1c164cd 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -71,6 +71,7 @@

 /* 16xx specific defines */
 #define OMAP1_32K_TIMER_BASE		0xfffb9000
+#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc410
 #define OMAP1_32K_TIMER_CR		0x08
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
@@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
  */
 bool __init omap_32k_timer_init(void)
 {
-	omap_init_clocksource_32k();
+	u32 pbase;
+
+	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
+	omap_init_clocksource_32k(pbase, SZ_1K);
 	omap_init_32k_timer();

 	return true;
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ecec873..cde80d4 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -71,6 +71,8 @@

 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
+/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksyn counter register */
+#define OMAP2_32KSYNCNT_CR_OFF	0x10

 static u32 sys_timer_reserved;

@@ -243,22 +245,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
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
@@ -285,7 +273,32 @@ static u32 notrace dmtimer_read_sched_clock(void)
 }

 /* Setup free-running counter for clocksource */
-static void __init omap2_gp_clocksource_init(int gptimer_id,
+static int __init omap2_sync32k_clocksource_init(void)
+{
+	int res;
+	u32 pbase, size;
+	struct omap_hwmod *oh;
+	struct resource mem_rsrc;
+	const char *oh_name = "counter_32k";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh || oh->slaves_cnt == 0)
+		return -ENODEV;
+
+	res = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM,
+				NULL, &mem_rsrc);
+	if (!res) {
+		pbase = mem_rsrc.start + OMAP2_32KSYNCNT_CR_OFF;
+		size = mem_rsrc.end - mem_rsrc.start;
+
+		res = omap_init_clocksource_32k(pbase, size);
+	}
+
+	WARN_ON(res);
+	return res;
+}
+
+static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
 {
 	int res;
@@ -293,9 +306,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
 	BUG_ON(res);

-	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
-		gptimer_id, clksrc.rate);
-
 	__omap_dm_timer_load_start(&clksrc,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
@@ -303,15 +313,36 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
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
+	 * by user (clocksource="gp timer").
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
@@ -342,7 +373,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
 static void __init omap4_timer_init(void)
 {
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
-	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
+	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
 #ifdef CONFIG_LOCAL_TIMERS
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
@@ -510,3 +541,28 @@ static int __init omap2_dm_timer_init(void)
 	return 0;
 }
 arch_initcall(omap2_dm_timer_init);
+
+/**
+ * omap2_override_clocksource - clocksource override with user configuration
+ *
+ * Allows user to override default clocksource, using kernel parameter
+ *   clocksource="gp timer"
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
+	 *    - gp timer
+	 */
+	if (!strcmp(str, "gp timer"))
+		use_gptimer_clksrc = true;
+
+	return 0;
+}
+early_param("clocksource", omap2_override_clocksource);
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..bd4a3fd 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -35,8 +35,6 @@
  */
 static void __iomem *timer_32k_base;

-#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
-
 static u32 notrace omap_32k_read_sched_clock(void)
 {
 	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
@@ -68,54 +66,43 @@ void read_persistent_clock(struct timespec *ts)
 	*ts = *tsp;
 }

-int __init omap_init_clocksource_32k(void)
+int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
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
+	void __iomem *base;
+	struct clk *sync_32k_ick;
+
+	if (!pbase || !size)
+		return -ENODEV;
+	/*
+	 * For this to work we must have a static mapping in io.c
+	 * for this area
+	 */
+	base = ioremap(pbase, size);
+	if (!base) {
+		pr_err("32k_counter: failed to map base addr\n");
+		return -ENODEV;
 	}
+
+	sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
+	if (!IS_ERR(sync_32k_ick))
+		clk_enable(sync_32k_ick);
+
+	timer_32k_base = base;
+
+	/*
+	 * 120000 rough estimate from the calculations in
+	 * __clocksource_updatefreq_scale.
+	 */
+	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
+			32768, NSEC_PER_SEC, 120000);
+
+	if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
+				clocksource_mmio_readl_up))
+		pr_err("32k_counter: can't register clocksource\n");
+	else
+		pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+
+	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index b4d7ec3..6cc1e43 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -30,7 +30,7 @@
 #include <plat/i2c.h>
 #include <plat/omap_hwmod.h>

-extern int __init omap_init_clocksource_32k(void);
+extern int __init omap_init_clocksource_32k(u32 pbase, unsigned long size);

 extern void omap_reserve(void);
 extern int omap_dss_reset(struct omap_hwmod *);
--
1.7.0.4

