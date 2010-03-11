From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH 2/2] OMAP3630: SDRC: Change in DVFS Latency Formula for OMAP3630
Date: Thu, 11 Mar 2010 17:04:57 +0530
Message-ID: <1268307297-23330-3-git-send-email-pramod.gurav@ti.com>
References: <1268307297-23330-1-git-send-email-pramod.gurav@ti.com>
 <1268307297-23330-2-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33528 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab0CKL2p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 06:28:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2BBSgjD005822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 05:28:44 -0600
In-Reply-To: <1268307297-23330-2-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

This patch uses new formula to derive the dpll3 clock Stabilization
delay during DVFS for OMAP3630. The formula used is :
Latency = 2 * SYS_CLK + 10 * CLKOUTX2

Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>

---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   53 +++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 3f61eb2..eee0332 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -67,7 +67,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	u32 clk_sel_regval;
 	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
 	u32 sys_clk_rate, sdrc_clk_stab;
-	u32 refclk, clkoutx2, switch_latency;
+	u32 refclk, clkoutx2, switch_latency, dpll_lock_freq;
 	unsigned int delay_sram;
 
 	if (!clk || !rate)
@@ -103,25 +103,50 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 
 	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
 
-	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
-	refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
-	clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
+	if (cpu_is_omap3630()) {
+		/*
+		 * wait time for L3 clk stabilization =
+		 * 2*SYS_CLK + 10*CLKOUTX2
+		 */
+		/* Avoid truncation of float values */
+		refclk = 2000 / sys_clk_rate;
+		dpll_lock_freq = (1000 * 100 * (core_dpll_div_n + 1))/
+					(2 * sys_clk_rate * core_dpll_mul_m);
+		clkoutx2 = 10 * (dpll_lock_freq * core_dpll_clkoutdiv_m2) / 100;
+		switch_latency = refclk + clkoutx2;
+
+		/* Adding 1000 nano seconds to sdrc clk stab */
+		sdrc_clk_stab = switch_latency + 1000;
+
+		delay_sram = delay_sram_val();
+		/*
+		 * Calculate the number of MPU cycles to wait for
+		 * SDRC to stabilize
+		 */
+		_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+
+		c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2 * 1000));
+	} else {
+		/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2*/
+		refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
+		clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
 					(sys_clk_rate * core_dpll_mul_m * 2);
-	switch_latency =  refclk + 8 * clkoutx2;
+		switch_latency =  refclk + 8 * clkoutx2;
 
-	/* Adding 2us to sdrc clk stab */
-	sdrc_clk_stab =  switch_latency + 2;
+		/* Adding 2us to sdrc clk stab */
+		sdrc_clk_stab =  switch_latency + 2;
 
-	delay_sram = delay_sram_val();
+		delay_sram = delay_sram_val();
 
-	/*
-	 * Calculate the number of MPU cycles
-	 * to wait for SDRC to stabilize
-	 */
+		/*
+		 * Calculate the number of MPU cycles
+		 * to wait for SDRC to stabilize
+		 */
+		_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
 
-	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+		c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
 
-	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
+	}
 
 	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
 						core_dpll_clkoutdiv_m2);
-- 
1.5.6.3

