From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP3 clock: split mcbspX_src_fck from mcbspX_fck
Date: Tue, 16 Sep 2008 08:18:43 -0600
Message-ID: <20080916141840.13182.77302.stgit@localhost.localdomain>
References: <20080916141809.13182.31144.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54878 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYIPOUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 10:20:04 -0400
In-Reply-To: <20080916141809.13182.31144.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

McBSP clock source control registers are located in the System Control
Module, not the PRCM.  However, the clock enable/disable registers are
in the CM.  Since the following patches require all registers in a
struct clk to be in only one of {CM, PRM, SCM}, we must split the
source clock selection into a separate struct clk from the clock
enable/disable control.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |   82 +++++++++++++++++++++++++++++++--------
 1 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 3ee60bc..3bd2bd9 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1463,12 +1463,10 @@ static const struct clksel mcbsp_15_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
+static struct clk mcbsp5_src_fck = {
+	.name		= "mcbsp_src_fck",
 	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
@@ -1477,12 +1475,21 @@ static struct clk mcbsp5_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk mcbsp1_fck = {
+static struct clk mcbsp5_fck = {
 	.name		= "mcbsp_fck",
+	.id		= 5,
+	.parent		= &mcbsp5_src_fck,
+	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp1_src_fck = {
+	.name		= "mcbsp_src_fck",
 	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
@@ -1491,6 +1498,17 @@ static struct clk mcbsp1_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk mcbsp1_fck = {
+	.name		= "mcbsp_fck",
+	.id		= 1,
+	.parent		= &mcbsp1_src_fck,
+	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
 /* CORE_48M_FCK-derived clocks */
 
 static struct clk core_48m_fck = {
@@ -2764,14 +2782,35 @@ static const struct clksel mcbsp_234_clksel[] = {
 	{ .parent = NULL }
 };
 
+static struct clk mcbsp2_src_fck = {
+	.name		= "mcbsp_src_fck",
+	.id		= 2,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
+	.clksel		= mcbsp_234_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "per_clkdm" },
+	.recalc		= &omap2_clksel_recalc,
+};
+
 static struct clk mcbsp2_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 2,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &mcbsp2_src_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
-	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "per_clkdm" },
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp3_src_fck = {
+	.name		= "mcbsp_src_fck",
+	.id		= 3,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm		= { .name = "per_clkdm" },
@@ -2781,11 +2820,20 @@ static struct clk mcbsp2_fck = {
 static struct clk mcbsp3_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 3,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &mcbsp3_src_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "per_clkdm" },
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp4_src_fck = {
+	.name		= "mcbsp_src_fck",
+	.id		= 4,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
+	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm		= { .name = "per_clkdm" },
@@ -2795,12 +2843,9 @@ static struct clk mcbsp3_fck = {
 static struct clk mcbsp4_fck = {
 	.name		= "mcbsp_fck",
 	.id		= 4,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &mcbsp4_src_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
-	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
@@ -3082,7 +3127,9 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&i2c3_fck,
 	&i2c2_fck,
 	&i2c1_fck,
+	&mcbsp5_src_fck,
 	&mcbsp5_fck,
+	&mcbsp1_src_fck,
 	&mcbsp1_fck,
 	&core_48m_fck,
 	&mcspi4_fck,
@@ -3198,8 +3245,11 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&mcbsp2_ick,
 	&mcbsp3_ick,
 	&mcbsp4_ick,
+	&mcbsp2_src_fck,
 	&mcbsp2_fck,
+	&mcbsp3_src_fck,
 	&mcbsp3_fck,
+	&mcbsp4_src_fck,
 	&mcbsp4_fck,
 	&emu_src_ck,
 	&pclk_fck,


