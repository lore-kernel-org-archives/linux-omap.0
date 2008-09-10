From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 05/12] OMAP2/3 clock: mark the rest of the CM clocks as
	belonging to cm_clkdm
Date: Wed, 10 Sep 2008 10:47:49 -0600
Message-ID: <20080910164746.17024.98438.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58262 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbYIJQsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:48:54 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Mark CM clocks with no clockdomain as belonging to the CM clockdomain.


References for the OMAP3xxx clocks:

OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
  Figure 4-13:
     - sys_ck
  Figure 4-35:
     - sys_clkout2
  Figure 4-37:
     - corex2_fck, core_ck, dss_tv_fck
  Figure 4-38:
     - omap_96m_alwon_fck
  Figure 4-39:
     - corex2_fck, cm_96m_fck, omap_96m_fck, omap_54m_fck, omap_12m_fck,
       dpll1_fck, dpll2_fck, rm_ick, dss_tv_fck
  Section 4.7.3.2:
     - omap_96m_alwon_fck, omap_96m_fck, omap_48m_fck


OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.0 Security
Addendum Version B TRM
  Figure 3-19:
     - cpefuse_fck
  Table 3-57:
     - dss_tv_fck


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 01414e2..0c2acea 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -225,10 +225,15 @@ static struct clk sys_ck = {
 static struct clk sys_altclk = {
 	.name		= "sys_altclk",
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
-/* Optional external clock input for some McBSPs */
+/*
+ * Optional external clock input for some McBSPs
+ * Apparently this is not really in prm_clkdm, but rather is fed into
+ * both CORE and PER separately.
+ */
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
@@ -526,6 +531,7 @@ static struct clk core_ck = {
 	.clksel		= core_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -699,6 +705,7 @@ static struct clk cm_96m_fck = {
 	.parent		= &omap_96m_alwon_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -727,6 +734,7 @@ static struct clk omap_96m_fck = {
 	.clksel		= omap_96m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -769,6 +777,7 @@ static struct clk virt_omap_54m_fck = {
 	.clksel		= virt_omap_54m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -796,6 +805,7 @@ static struct clk omap_54m_fck = {
 	.clksel		= omap_54m_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -823,6 +833,7 @@ static struct clk omap_48m_fck = {
 	.clksel		= omap_48m_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -832,6 +843,7 @@ static struct clk omap_12m_fck = {
 	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1048,6 +1060,7 @@ static struct clk sys_clkout2 = {
 	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1058,6 +1071,7 @@ static struct clk corex2_fck = {
 	.parent		= &dpll3_m2x2_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1075,10 +1089,6 @@ static const struct clksel div4_core_clksel[] = {
 	{ .parent = NULL }
 };
 
-/*
- * REVISIT: Are these in DPLL power domain or CM power domain? docs
- * may be inconsistent here?
- */
 static struct clk dpll1_fck = {
 	.name		= "dpll1_fck",
 	.parent		= &core_ck,
@@ -1088,6 +1098,7 @@ static struct clk dpll1_fck = {
 	.clksel		= div4_core_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1163,6 +1174,7 @@ static struct clk dpll2_fck = {
 	.clksel		= div4_core_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1246,6 +1258,7 @@ static struct clk rm_ick = {
 	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
 	.clksel		= div2_l4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1409,6 +1422,7 @@ static struct clk cpefuse_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2169,7 +2183,7 @@ static struct clk dss_tv_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "dss_clkdm" },
+	.clkdm		= { .name = "dss_clkdm" }, /* XXX: in cm_clkdm? */
 	.recalc		= &followparent_recalc,
 };
 


