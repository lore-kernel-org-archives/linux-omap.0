From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] 3430 clock: Fix missing enable warnings from various
	clocks
Date: Tue, 04 Dec 2007 02:26:09 -0700
Message-ID: <20071204092737.164520116@pwsan.com>
References: <20071204092605.831497615@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=3430_resolve_clock_warnings.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch marks all of the 3430 clocks that are missing enable information
with either the ALWAYS_ENABLED or PARENT_CONTROLS_CLOCK clock flags, as deemed
appropriate.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.h |   97 +++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 36 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-12-04 02:14:15.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-12-04 02:21:09.000000000 -0700
@@ -223,7 +223,7 @@
 	.name		= "dpll1_ck",
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -234,7 +234,8 @@
 static struct clk emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
 	.parent		= &dpll1_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -259,7 +260,7 @@
 	.name		= "dpll2_ck",
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll2_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -283,7 +284,7 @@
 	.name		= "dpll3_ck",
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -324,14 +325,16 @@
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div2_dpll3m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.parent		= &dpll3_m2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -342,14 +345,16 @@
 static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.parent		= &dpll3_x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -397,7 +402,7 @@
 	.name		= "dpll4_ck",
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap3_dpll_recalc,
 };
 
@@ -408,7 +413,8 @@
 static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.parent		= &dpll4_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -450,7 +456,8 @@
 static struct clk cm_96m_fck = {
 	.name		= "cm_96m_fck",
 	.parent		= &dpll4_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -480,7 +487,7 @@
 
 static const struct clksel omap_54m_clksel[] = {
 	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates },
-	{ .parent = &sys_altclk,     .rates = omap_54m_alt_rates },
+	{ .parent = &sys_altclk,    .rates = omap_54m_alt_rates },
 	{ .parent = NULL }
 };
 
@@ -490,7 +497,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_54M,
 	.clksel		= omap_54m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -516,7 +524,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_48M,
 	.clksel		= omap_48m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -524,7 +533,8 @@
 	.name		= "omap_12m_fck",
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -573,7 +583,8 @@
 static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -649,7 +660,8 @@
 static struct clk corex2_fck = {
 	.name		= "corex2_fck",
 	.parent		= &dpll3_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -671,7 +683,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -682,7 +695,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -695,7 +709,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -711,7 +726,8 @@
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 
 };
@@ -728,7 +744,7 @@
 	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
 	.clksel		= div2_l4_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -940,7 +956,8 @@
 static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1012,7 +1029,8 @@
 static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
 	.parent		= &omap_12m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1058,7 +1076,7 @@
 	.name		= "ssi_sst_fck",
 	.parent		= &ssi_ssr_fck,
 	.fixed_div	= 2,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1069,7 +1087,8 @@
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1094,7 +1113,7 @@
 static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.parent		= &core_l3_ick,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1103,7 +1122,8 @@
 static struct clk security_l3_ick = {
 	.name		= "security_l3_ick",
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1121,7 +1141,8 @@
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1391,7 +1412,8 @@
 static struct clk security_l4_ick2 = {
 	.name		= "security_l4_ick2",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1533,7 +1555,7 @@
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
 	.parent		= &omap_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1558,7 +1580,7 @@
 static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.parent		= &sys_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1623,14 +1645,16 @@
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1742,7 +1766,7 @@
 static struct clk per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
 	.parent		= &omap_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1803,7 +1827,8 @@
 static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 

-- 
