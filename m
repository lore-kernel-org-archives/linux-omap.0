From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under DVFS+SR operation
Date: Thu, 11 Mar 2010 18:46:05 +0530
Message-ID: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238Ab0CKNJx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 08:09:53 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2BD9nko029650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 07:09:52 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Shweta Gulati <shweta.gulati@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
running DSP codec was earlier restricted as DSP crashed.
The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
The solution is to make sure DPLL1/DPLL2 bypass clock is always less than 
maximum supported frequency for the specific OPP

Tested on 3630 ZOOM3.

changes in V2 : Rebased to new OPP implementation

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
 arch/arm/mach-omap2/pm34xx.c          |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/resource34xx.c    |   28 +++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a3a3ca0..ee420ab 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -81,7 +81,7 @@
 
 /* CM_CLKSEL1_PLL_IVA2 */
 #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
-#define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_IVA2_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
 #define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
@@ -126,7 +126,7 @@
 
 /* CM_CLKSEL1_PLL_MPU */
 #define OMAP3430_MPU_CLK_SRC_SHIFT			19
-#define OMAP3430_MPU_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_MPU_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_MPU_DPLL_MULT_SHIFT			8
 #define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_MPU_DPLL_DIV_SHIFT			0
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b51b461..494e5e6
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -828,6 +828,29 @@ static void __init omap3_d2d_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
+	u32 cm_clksel1_mpu, cm_clksel1_iva2;
+
+	/*set Bypass clock dividers for MPU and IVA */
+	cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
+	cm_clksel1_iva2 = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
+	if (cpu_is_omap3630()) {
+		cm_clksel1_iva2 = (cm_clksel1_iva2 &
+					~(OMAP3430_IVA2_CLK_SRC_MASK)) |
+					(0x2 << OMAP3430_IVA2_CLK_SRC_SHIFT);
+		cm_clksel1_mpu = (cm_clksel1_mpu &
+					~(OMAP3430_MPU_CLK_SRC_MASK)) |
+					(0x1 << OMAP3430_MPU_CLK_SRC_SHIFT);
+	} else if (cpu_is_omap34xx()) {
+		cm_clksel1_iva2 = (cm_clksel1_iva2 &
+					~(OMAP3430_IVA2_CLK_SRC_MASK)) |
+					(0x4 << OMAP3430_IVA2_CLK_SRC_SHIFT);
+		cm_clksel1_mpu = (cm_clksel1_mpu &
+					~(OMAP3430_MPU_CLK_SRC_MASK)) |
+					(0x2 << OMAP3430_MPU_CLK_SRC_SHIFT);
+		}
+	cm_write_mod_reg(cm_clksel1_iva2, OMAP3430_IVA2_MOD, CM_CLKSEL1);
+	cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
+
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..03d7fce
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -276,12 +276,13 @@ static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
 
 static int program_opp_freq(int res, int target_level, int current_level)
 {
-	int ret = 0, l3_div;
+	int ret = 0, l3_div, mpu_div, iva2_div;
 	int *curr_opp;
 	unsigned long mpu_freq, dsp_freq, l3_freq;
 #ifndef CONFIG_CPU_FREQ
 	unsigned long mpu_cur_freq;
 #endif
+	u32 cm_clksel1_mpu, cm_clksel1_iva2, max_core_clk;
 
 	/* Check if I can actually switch or not */
 	if (res == VDD1_OPP) {
@@ -299,6 +300,31 @@ static int program_opp_freq(int res, int target_level, int current_level)
 
 	lock_scratchpad_sem();
 	if (res == VDD1_OPP) {
+		/* adjust bypass clock diviers */
+		max_core_clk = ULONG_MAX;
+		opp_find_freq_floor(OPP_L3, &max_core_clk);
+		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+				OMAP3430_CLKSEL_L3_MASK;
+
+		max_core_clk *= l3_div;
+		mpu_div = 1 << (max_core_clk / mpu_freq);
+		iva2_div = 1 << (max_core_clk / dsp_freq);
+
+		cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
+		cm_clksel1_iva2 =
+				cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
+
+		cm_clksel1_iva2 = (cm_clksel1_iva2 &
+				~(OMAP3430_IVA2_CLK_SRC_MASK)) |
+				(iva2_div << OMAP3430_IVA2_CLK_SRC_SHIFT);
+		cm_clksel1_mpu = (cm_clksel1_mpu &
+				~(OMAP3430_MPU_CLK_SRC_MASK)) |
+				(mpu_div << OMAP3430_MPU_CLK_SRC_SHIFT);
+
+		cm_write_mod_reg(cm_clksel1_iva2,
+				OMAP3430_IVA2_MOD, CM_CLKSEL1);
+		cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
+
 		curr_opp = &curr_vdd1_opp;
 		clk_set_rate(dpll1_clk, mpu_freq);
 		clk_set_rate(dpll2_clk, dsp_freq);
-- 
1.5.6.3

