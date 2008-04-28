From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: [PATCH] PRCM: Combine 34xx l3_icks and l4_icks
Date: Mon, 28 Apr 2008 11:29:53 +0300
Message-ID: <873ap69ybi.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36416 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765837AbYD1IaY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 04:30:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Tony Lindgren <tony@atomide.com>, ext Paul Walmsley <paul@pwsan.com>, igor.stoppa@nokia.com

E.g dss_l3_ick and dss_l4_ick have same gating control. Having own
clock for both of them causes race condition between enable / disable.

This patch combines this kind of clocks and names new clock as <module>_ick.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |   62 +++++++++++++++------------------------
 1 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 4b1dd71..85afe1e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1200,27 +1200,34 @@ static const struct clksel gfx_l3_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk gfx_l3_fck = {
-	.name		= "gfx_l3_fck",
+/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
+static struct clk gfx_l3_ck = {
+	.name		= "gfx_l3_ck",
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES1,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gfx_l3_fck = {
+	.name		= "gfx_l3_fck",
+	.parent		= &gfx_l3_ck,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
-	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP_EN_GFX_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
+	.parent		= &gfx_l3_ck,
+	.flags		= CLOCK_IN_OMAP3430ES1 | PARENT_CONTROLS_CLOCK,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2160,19 +2167,9 @@ static struct clk cam_mclk = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk cam_l3_ick = {
-	.name		= "cam_l3_ick",
-	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm_name	= "cam_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk cam_l4_ick = {
-	.name		= "cam_l4_ick",
+static struct clk cam_ick = {
+	/* Handles both L3 and L4 clocks */
+	.name		= "cam_ick",
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
@@ -2206,19 +2203,9 @@ static struct clk usbhost_48m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhost_l3_ick = {
-	.name		= "usbhost_l3_ick",
-	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usbhost_l4_ick = {
-	.name		= "usbhost_l4_ick",
+static struct clk usbhost_ick = {
+	/* Handles both L3 and L4 clocks */
+	.name		= "usbhost_ick",
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
@@ -3094,6 +3081,7 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&l3_ick,
 	&l4_ick,
 	&rm_ick,
+	&gfx_l3_ck,
 	&gfx_l3_fck,
 	&gfx_l3_ick,
 	&gfx_cg1_ck,
@@ -3175,12 +3163,10 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&dss2_alwon_fck,
 	&dss_ick,
 	&cam_mclk,
-	&cam_l3_ick,
-	&cam_l4_ick,
+	&cam_ick,
 	&usbhost_120m_fck,
 	&usbhost_48m_fck,
-	&usbhost_l3_ick,
-	&usbhost_l4_ick,
+	&usbhost_ick,
 	&usbhost_sar_fck,
 	&usim_fck,
 	&gpt1_fck,
-- 
1.5.5


