From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check presence of 32k timer
Date: Thu, 19 Jan 2012 19:58:22 +0530
Message-ID: <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51274 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab2ASOeN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:34:13 -0500
In-Reply-To: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, johnstul@us.ibm.com, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

OMAP device has 32k-sync timer which is currently used as a
clocksource in the kernel (omap2plus_defconfig).
The current implementation uses compile time selection between
gp-timer and 32k-sync timer, which breaks multi-omap build for
the devices like AM33xx, where 32k-sync timer is not available.

So use hwmod database lookup mechanism, through which at run-time
we can identify availability of 32k-sync timer on the device,
else fall back to gp-timer.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/timer.c      |   27 +++++-------
 arch/arm/plat-omap/counter_32k.c |   83 +++++++++++++++++++------------------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 6eeff0e..b978b39 100644
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
@@ -281,6 +266,17 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 {
 	int res;
 
+	/*
+	 * First check for availability for 32k-sync timer.
+	 *
+	 * Return non-zero, means the device doesn't have 32k-sync timer and
+	 * execution will fallback to gp-timer.
+	 */
+	res = omap_init_clocksource_32k();
+	if (!res)
+		return;
+
+	/* Fall back to gp-timer code */
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
 	BUG_ON(res);
 
@@ -295,7 +291,6 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 		pr_err("Could not register clocksource %s\n",
 			clocksource_gpt.name);
 }
-#endif
 
 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
 				clksrc_nr, clksrc_src)			\
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5f0f229..8504bea 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -69,52 +69,55 @@ void read_persistent_clock(struct timespec *ts)
 
 int __init omap_init_clocksource_32k(void)
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
+	u32 pbase;
+	unsigned long size = SZ_4K;
+	void __iomem *base;
+	struct clk *sync_32k_ick;
+
+	if (cpu_is_omap16xx()) {
+		pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
+		size = SZ_1K;
+	} else if (cpu_class_is_omap2()) {
+		struct omap_hwmod *oh;
+		const char *oh_name = "counter_32k";
+
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh || oh->slaves_cnt == 0) {
+			pr_err("Could not lookup %s hwmod\n", oh_name);
 			return -ENODEV;
+		}
+		pbase = oh->slaves[0]->addr->pa_start + 0x10;
+	} else {
+		return -ENODEV;
+	}
 
-		/* For this to work we must have a static mapping in io.c for this area */
-		base = ioremap(pbase, size);
-		if (!base)
-			return -ENODEV;
+	/*
+	 * For this to work we must have a static mapping in io.c
+	 * for this area
+	 */
+	base = ioremap(pbase, size);
+	if (!base)
+		return -ENODEV;
 
-		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
-		if (!IS_ERR(sync_32k_ick))
-			clk_enable(sync_32k_ick);
+	sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
+	if (!IS_ERR(sync_32k_ick))
+		clk_enable(sync_32k_ick);
 
-		timer_32k_base = base;
+	timer_32k_base = base;
 
-		/*
-		 * 120000 rough estimate from the calculations in
-		 * __clocksource_updatefreq_scale.
-		 */
-		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
-				32768, NSEC_PER_SEC, 120000);
+	/*
+	 * 120000 rough estimate from the calculations in
+	 * __clocksource_updatefreq_scale.
+	 */
+	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
+			32768, NSEC_PER_SEC, 120000);
 
-		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
-					  clocksource_mmio_readl_up))
-			printk(err, "32k_counter");
+	if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
+				clocksource_mmio_readl_up))
+		printk(KERN_ERR "%s: can't register clocksource!\n",
+				"32k_counter");
+
+	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 
-		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
-	}
 	return 0;
 }
-- 
1.7.0.4

