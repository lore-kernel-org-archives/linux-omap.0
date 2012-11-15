From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 12/16] ARM: OMAP2+: clock data: Merge utmi_px_gfclk into usb_host_hs_utmi_px_clk
Date: Thu, 15 Nov 2012 16:34:10 +0200
Message-ID: <1352990054-14680-13-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52164 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768031Ab2KOOed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:33 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com, Benoit Cousson <b-cousson@ti.com>

There is no such clock as utmi_p1_gfclk. It is only a clock selector
bit to select th the parent of usb_host_hs_utmi_p1_clk.
So we get rid of utmi_p1_gfclk and utmi_p2_gfclk by merging them into
usb_host_hs_utmi_p1_clk and usb_host_hs_utmi_p2_clk respectively.

CC: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 --
 arch/arm/mach-omap2/clock44xx_data.c |   30 ++++++++----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1f42c9d..0d2ee04 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3400,8 +3400,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6efc30c..fc3e490 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2462,25 +2462,19 @@ static const struct clksel utmi_p1_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk utmi_p1_gfclk = {
-	.name		= "utmi_p1_gfclk",
+/* Merged utmi_p1_gfclk into usb_host_hs_utmi_p1_clk */
+static struct clk usb_host_hs_utmi_p1_clk = {
+	.name		= "usb_host_hs_utmi_p1_clk",
 	.parent		= &init_60m_fclk,
 	.clksel		= utmi_p1_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk usb_host_hs_utmi_p1_clk = {
-	.name		= "usb_host_hs_utmi_p1_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p1_gfclk,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static const struct clksel utmi_p2_gfclk_sel[] = {
@@ -2489,25 +2483,19 @@ static const struct clksel utmi_p2_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-static struct clk utmi_p2_gfclk = {
-	.name		= "utmi_p2_gfclk",
+/* Merged utmi_p2_gfclk into usb_host_hs_utmi_p2_clk */
+static struct clk usb_host_hs_utmi_p2_clk = {
+	.name		= "usb_host_hs_utmi_p2_clk",
 	.parent		= &init_60m_fclk,
 	.clksel		= utmi_p2_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk usb_host_hs_utmi_p2_clk = {
-	.name		= "usb_host_hs_utmi_p2_clk",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.enable_bit	= OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
 	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &utmi_p2_gfclk,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk usb_host_hs_utmi_p3_clk = {
@@ -3246,9 +3234,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
 	CLK("usbhs_omap",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
-	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_443X),
-- 
1.7.4.1

