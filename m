From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH v1 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630
Date: Fri,  2 Apr 2010 01:16:56 +0800
Message-ID: <1270142216-18118-3-git-send-email-pramod.gurav@ti.com>
References: <>
 <1270142216-18118-1-git-send-email-pramod.gurav@ti.com>
 <1270142216-18118-2-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755443Ab0DALjg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 07:39:36 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o31BdXXf005374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Apr 2010 06:39:35 -0500
In-Reply-To: <1270142216-18118-2-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Ambresh K <ambresh@ti.com>

To calculate the dpll3 M2 clock stabilization delay dynamically and wait
time for L3 M2 clock stabilization are different for 3430 & 3630 and is
as follows:
3430: 4*REFCLK + 8*CLKOUTX2
3630: 2*SYS_CLK + 10*CLKOUTX2
REFCLK & CLKOUTX2 are derived from M, N, M2  and DPLL reference clock.

Incase of 3430 a 2usec and 3630 1usec buffer time is added for safety.

Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
Signed-off-by: Ambresh K <ambresh@ti.com>

---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 6ad18f2..af0807a 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -39,6 +39,12 @@
 #define		SHIFT_DPLL_M		16
 #define		SHIFT_DPLL_N		8
 #define		SHIFT_DPLL_M2		27
+
+/*
+ * While calculating M2 stabilization delay, especially the formula
+ * used for 3630 computes to zero. So to avoid calculation truncating to
+ * zero, SCALING_FACTOR is used appropriately.
+ */
 #define		SCALING_FACTOR		10
 
 /*
@@ -107,12 +113,21 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	sys_clk = (1 << SCALING_FACTOR) / sys_clk_rate;
 	clkoutx2 = (sys_clk * (n + 1) * m2) / (2 * m);
 
-	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
-	refclk = (n + 1) * sys_clk;
-	switch_latency =  (4 * refclk) + (8 * clkoutx2);
-
-	/* Adding 2000 ns to sdrc clk stab */
-	sdrc_clk_stab =  switch_latency + 2000;
+	/*
+	 * wait time for L3 clk stabilization
+	 * for OMAP3430 = 4*REFCLK + 8*CLKOUTX2
+	 * for OMAP3630 = 2*REFCLK + 8*CLKOUTX2
+	 */
+	if (cpu_is_omap3630()) {
+		switch_latency = (2 * sys_clk) + (10 * clkoutx2);
+		/* Adding 1000 nano seconds to sdrc clk stab */
+		sdrc_clk_stab = switch_latency + 1000;
+	} else {
+		refclk = (n + 1) * sys_clk;
+		switch_latency =  (4 * refclk) + (8 * clkoutx2);
+		/* Adding 2000 ns to sdrc clk stab */
+		sdrc_clk_stab =  switch_latency + 2000;
+	}
 
 	/*
 	 * Calculate the number of MPU cycles
-- 
1.6.0.4

