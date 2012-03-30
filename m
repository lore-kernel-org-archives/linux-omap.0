From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 3/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Fri, 30 Mar 2012 19:24:15 +0530
Message-ID: <1333115655-28530-4-git-send-email-hvaibhav@ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760787Ab2C3OFg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 10:05:36 -0400
In-Reply-To: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tom.leiming@gmail.com, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

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

Use hwmod database lookup mechanism, through which at run-time
we can identify availability of 32k-sync timer on the device,
else fall back to gptimer.

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
 arch/arm/mach-omap2/timer.c              |   45 +++++++++-------
 arch/arm/plat-omap/counter_32k.c         |   86 ++++++++++++-----------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 4 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index a2e6d07..3f96a00 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -72,6 +72,7 @@

 /* 16xx specific defines */
 #define OMAP1_32K_TIMER_BASE		0xfffb9000
+#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc410
 #define OMAP1_32K_TIMER_CR		0x08
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
@@ -185,7 +186,10 @@ static __init void omap_init_32k_timer(void)
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
index 5c9acea..f35db1a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -234,21 +234,6 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
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

 /*
@@ -280,13 +265,33 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 						const char *fck_source)
 {
 	int res;
+	struct omap_hwmod *oh;
+	const char *oh_name = "counter_32k";
+
+	/*
+	 * First check for availability for 32k-sync timer.
+	 *
+	 * In case of failure in finding 32k_counter module or
+	 * registering it as clocksource, execution will fallback to
+	 * gp-timer.
+	 */
+	oh = omap_hwmod_lookup(oh_name);
+	if (oh && oh->slaves_cnt != 0) {
+		u32 pbase;
+		unsigned long size;
+
+		pbase = oh->slaves[0]->addr->pa_start + 0x10;
+		size = oh->slaves[0]->addr->pa_end -
+			oh->slaves[0]->addr->pa_start;
+		res = omap_init_clocksource_32k(pbase, size);
+		if (!res)
+			return;
+	}

+	/* Fall back to gp-timer code */
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
 	BUG_ON(res);

-	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
-		gptimer_id, clksrc.rate);
-
 	__omap_dm_timer_load_start(&clksrc,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
@@ -294,8 +299,10 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
 			clocksource_gpt.name);
+	else
+		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
+			gptimer_id, clksrc.rate);
 }
-#endif

 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
 				clksrc_nr, clksrc_src)			\
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..c1af18c 100644
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
@@ -68,54 +66,42 @@ void read_persistent_clock(struct timespec *ts)
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
-	}
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
+	if (!base)
+		return -ENODEV;
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
+		pr_err("32k_counter: can't register clocksource!\n");
+
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

