From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Remove unnecessarily .init initializers from OMAP3 clocks
Date: Sun, 10 Jan 2010 22:30:31 +0000
Message-ID: <20100110223031.GA15812@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53450 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0AJWan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jan 2010 17:30:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

The first thing that omap2_init_clksel_parent() does is check for
a non-zero .clksel field in the struct clk.  Therefore, it is
pointless calling this function on clocks where the clksel field
is unset.

Remove init calls to omap2_init_clksel_parent() on clocks without
a clksel field.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
The changes in this patch were script generated.  Script will follow
with other changes shortly.

 arch/arm/mach-omap2/clock34xx_data.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 8bdcc9c..08f6e10 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -671,7 +671,6 @@ static struct clk dpll4_m3x2_ck = {
 	.name		= "dpll4_m3x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m3_ck,
-	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
 	.flags		= INVERT_ENABLE,
@@ -809,7 +808,6 @@ static struct clk dpll4_m6x2_ck = {
 	.name		= "dpll4_m6x2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m6_ck,
-	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
 	.flags		= INVERT_ENABLE,
@@ -1045,7 +1043,6 @@ static struct clk iva2_ck = {
 	.name		= "iva2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll2_m2_ck,
-	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 	.clkdm_name	= "iva2_clkdm",
@@ -1119,7 +1116,6 @@ static struct clk gfx_l3_ck = {
 	.name		= "gfx_l3_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.recalc		= &followparent_recalc,
