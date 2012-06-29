From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
Date: Fri, 29 Jun 2012 14:53:02 +0300
Message-ID: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36421 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab2F2LxH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 07:53:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com

From: Wenbiao Wang <wwang@ti.com>

OTG clock usb_otg_hs_ick used a incorrect parent l3_div_ck.
Correct it to use the right colck otg_60m_gfclk as its
parent.

Signed-off-by: Wenbiao Wang <wwang@ti.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index b825049..fd43214 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -199,12 +199,6 @@ static struct clk tie_low_clock_ck = {
 	.ops		= &clkops_null,
 };
 
-static struct clk utmi_phy_clkout_ck = {
-	.name		= "utmi_phy_clkout_ck",
-	.rate		= 60000000,
-	.ops		= &clkops_null,
-};
-
 static struct clk xclk60mhsp1_ck = {
 	.name		= "xclk60mhsp1_ck",
 	.rate		= 60000000,
@@ -992,6 +986,13 @@ static struct clk dpll_usb_clkdcoldo_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk utmi_phy_clkout_ck = {
+	.name		= "utmi_phy_clkout_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_usb_clkdcoldo_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static const struct clksel dpll_usb_m2_div[] = {
 	{ .parent = &dpll_usb_ck, .rates = div31_1to31_rates },
 	{ .parent = NULL },
@@ -2685,7 +2686,7 @@ static struct clk usb_otg_hs_ick = {
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l3_div_ck,
+	.parent		= &otg_60m_gfclk,
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.7.1

