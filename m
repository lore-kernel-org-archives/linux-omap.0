From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH v2 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630
Date: Thu, 18 Mar 2010 10:25:48 +0530
Message-ID: <1268888148-10983-3-git-send-email-pramod.gurav@ti.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com>
 <1268888148-10983-2-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45979 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab0CREtO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 00:49:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2I4nBgT017565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 23:49:13 -0500
In-Reply-To: <1268888148-10983-2-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

This patch uses new formula to derive the dpll3 clock Stabilization
delay during DVFS for OMAP3630. The formula used is :
Latency = 2 * SYS_CLK + 10 * CLKOUTX2

1usec buffer time is added for safety.

Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>

---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   60 ++++++++++++++++++++++----------
 1 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 29421b1..58979ec 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -40,6 +40,9 @@
 #define		SHIFT_DPLL_N		8
 #define		SHIFT_DPLL_M2		27
 
+#define		AVOID_TRUNC_1000	1000
+#define		AVOID_TRUNC_100		100
+
 /*
  * CORE DPLL (DPLL3) M2 divider rate programming functions
  *
@@ -67,7 +70,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	u32 clk_sel_regval;
 	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
 	u32 sys_clk_rate, sdrc_clk_stab;
-	u32 refclk, clkoutx2, switch_latency;
+	u32 refclk, clkoutx2, switch_latency, dpll_lock_freq;
 	unsigned int delay_sram;
 
 	if (!clk || !rate)
@@ -100,28 +103,47 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
 							DPLL_M2_MASK;
 	sys_clk_rate = clk_get_rate(sys_ck_p);
-
 	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
 
-	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
-	refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
-	clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
-					(sys_clk_rate * core_dpll_mul_m * 2);
-	switch_latency =  refclk + 8 * clkoutx2;
-
-	/* Adding 2us to sdrc clk stab */
-	sdrc_clk_stab =  switch_latency + 2;
-
-	delay_sram = delay_sram_val();
-
-	/*
-	 * Calculate the number of MPU cycles
-	 * to wait for SDRC to stabilize
-	 */
-
 	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+	delay_sram = delay_sram_val();
 
-	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
+	if (cpu_is_omap3630()) {
+		/*
+		 * wait time for L3 clk stabilization =
+		 * 2*SYS_CLK + 10*CLKOUTX2
+		 */
+		/*
+		 * To avoid truncation of floating values, AVOID_TRUNC_1000 &
+		 * AVOID_TRUNC_100 are multiplied and divided appropriately
+		 */
+		refclk = 2 * (AVOID_TRUNC_1000 / sys_clk_rate);
+		dpll_lock_freq = (AVOID_TRUNC_1000 * AVOID_TRUNC_100 *
+					(core_dpll_div_n + 1))/
+					(2 * sys_clk_rate * core_dpll_mul_m);
+		clkoutx2 = 10 * (dpll_lock_freq * core_dpll_clkoutdiv_m2) /
+							AVOID_TRUNC_100;
+		switch_latency = refclk + clkoutx2;
+
+		/* Adding 1000 nano seconds to sdrc clk stab */
+		sdrc_clk_stab = switch_latency + 1000;
+		c = ((sdrc_clk_stab * _mpurate) /
+					(delay_sram * 2 * AVOID_TRUNC_1000));
+	} else {
+		/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
+		refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
+		clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
+					(sys_clk_rate * core_dpll_mul_m * 2);
+		switch_latency =  refclk + 8 * clkoutx2;
+
+		/* Adding 2us to sdrc clk stab */
+		sdrc_clk_stab =  switch_latency + 2;
+		/*
+		 * Calculate the number of MPU cycles to wait for
+		 * SDRC to stabilize
+		 */
+		c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
+	}
 
 	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
 						core_dpll_clkoutdiv_m2);
-- 
1.5.6.3

