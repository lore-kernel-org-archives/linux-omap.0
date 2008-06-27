From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
 omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 23:29:32 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806262328120.947@utopia.booyaka.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain> <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYF0F3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 01:29:33 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 26 Jun 2008, Pandita, Vikram wrote:

> I hope this has fixed:
> "Clock usbhost_48m_fck didn't enable in 100000 tries"

This patch has been in the works for several days.  Maybe it fixes the 
problem you reported?  Please let me know either way.


- Paul

Fix some bugs in the OMAP3 clock tree pertaining to the 96MHz clocks.

From: Paul Walmsley <paul@pwsan.com>

The 96MHz portion of the clock tree should now have reasonable
fidelity to the 34xx TRM Rev I.

One remaining question mark: it's not clear exactly which 96MHz source
clock the USIM uses.  This patch sticks with the previous setting, which
seems reasonable.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.h       |   60 +++++++++++++++++++++------------
 arch/arm/mach-omap2/cm-regbits-34xx.h |    8 +++-
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 1d40053..f2ccd5e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -658,6 +658,12 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 	{ .parent = NULL }
 };
 
+/*
+ * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
+ * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
+ * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
+ * CM_96K_(F)CLK.
+ */
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.parent		= &dpll4_m2x2_ck,
@@ -666,31 +672,41 @@ static struct clk omap_96m_alwon_fck = {
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= omap_96m_alwon_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				 PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk omap_96m_fck = {
-	.name		= "omap_96m_fck",
+static struct clk cm_96m_fck = {
+	.name		= "cm_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
-static const struct clksel cm_96m_fck_clksel[] = {
-	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
-	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
+static const struct clksel_rate omap_96m_dpll_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate omap_96m_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap_96m_fck_clksel[] = {
+	{ .parent = &cm_96m_fck, .rates = omap_96m_dpll_rates },
+	{ .parent = &sys_ck,	 .rates = omap_96m_sys_rates },
 	{ .parent = NULL }
 };
 
-static struct clk cm_96m_fck = {
-	.name		= "cm_96m_fck",
-	.parent		= &dpll4_m2x2_ck,
+static struct clk omap_96m_fck = {
+	.name		= "omap_96m_fck",
+	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.clksel		= cm_96m_fck_clksel,
+	.clksel_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_SOURCE_96M_MASK,
+	.clksel		= omap_96m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
@@ -758,14 +774,14 @@ static struct clk omap_54m_fck = {
 	.name		= "omap_54m_fck",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_54M,
+	.clksel_mask	= OMAP3430_SOURCE_54M_MASK,
 	.clksel		= omap_54m_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel_rate omap_48m_96md2_rates[] = {
+static const struct clksel_rate omap_48m_cm96m_rates[] = {
 	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 0 }
 };
@@ -776,7 +792,7 @@ static const struct clksel_rate omap_48m_alt_rates[] = {
 };
 
 static const struct clksel omap_48m_clksel[] = {
-	{ .parent = &cm_96m_fck, .rates = omap_48m_96md2_rates },
+	{ .parent = &cm_96m_fck, .rates = omap_48m_cm96m_rates },
 	{ .parent = &sys_altclk, .rates = omap_48m_alt_rates },
 	{ .parent = NULL }
 };
@@ -785,7 +801,7 @@ static struct clk omap_48m_fck = {
 	.name		= "omap_48m_fck",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_48M,
+	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
 	.clksel		= omap_48m_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -973,10 +989,10 @@ static const struct clksel_rate clkout2_src_54m_rates[] = {
 };
 
 static const struct clksel clkout2_src_clksel[] = {
-	{ .parent = &core_ck,		  .rates = clkout2_src_core_rates },
-	{ .parent = &sys_ck,		  .rates = clkout2_src_sys_rates },
-	{ .parent = &omap_96m_alwon_fck,  .rates = clkout2_src_96m_rates },
-	{ .parent = &omap_54m_fck,	  .rates = clkout2_src_54m_rates },
+	{ .parent = &core_ck,		.rates = clkout2_src_core_rates },
+	{ .parent = &sys_ck,		.rates = clkout2_src_sys_rates },
+	{ .parent = &cm_96m_fck,	.rates = clkout2_src_96m_rates },
+	{ .parent = &omap_54m_fck,	.rates = clkout2_src_54m_rates },
 	{ .parent = NULL }
 };
 
@@ -2804,8 +2820,8 @@ static struct clk mcbsp4_ick = {
 };
 
 static const struct clksel mcbsp_234_clksel[] = {
-	{ .parent = &per_96m_fck, .rates = common_mcbsp_96m_rates },
-	{ .parent = &mcbsp_clks,  .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
 	{ .parent = NULL }
 };
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 971b9ad..07ab180 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -457,8 +457,12 @@
 #define OMAP3430_CORE_DPLL_MULT_MASK			(0x7ff << 16)
 #define OMAP3430_CORE_DPLL_DIV_SHIFT			8
 #define OMAP3430_CORE_DPLL_DIV_MASK			(0x7f << 8)
-#define OMAP3430_SOURCE_54M				(1 << 5)
-#define OMAP3430_SOURCE_48M				(1 << 3)
+#define OMAP3430_SOURCE_96M_SHIFT			6
+#define OMAP3430_SOURCE_96M_MASK			(1 << 6)
+#define OMAP3430_SOURCE_54M_SHIFT			5
+#define OMAP3430_SOURCE_54M_MASK			(1 << 5)
+#define OMAP3430_SOURCE_48M_SHIFT			3
+#define OMAP3430_SOURCE_48M_MASK			(1 << 3)
 
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
