From: Archit Taneja <archit@ti.com>
Subject: [PATCH 29/33] arm: omap boards: Remove unnecessary platform_enable/disable callbacks for VENC devices
Date: Wed, 13 Feb 2013 19:52:21 +0530
Message-ID: <1360765345-19312-30-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039Ab3BMOYm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:42 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The omap_dss_device's platform_enable/disable callbacks don't do anything for
any of the boards. The platform calls from the VENC driver will also be removed
in the future. Remove these calls from the board which have a VENC device.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   11 -----------
 arch/arm/mach-omap2/board-am3517evm.c    |   11 -----------
 arch/arm/mach-omap2/board-cm-t35.c       |   11 -----------
 arch/arm/mach-omap2/board-omap3evm.c     |   11 -----------
 arch/arm/mach-omap2/board-omap3stalker.c |   11 -----------
 5 files changed, 55 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 13f1431..717dd15 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -124,15 +124,6 @@ static void __init sdp3430_display_init(void)
 
 }
 
-static int sdp3430_panel_enable_tv(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void sdp3430_panel_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct panel_sharp_ls037v7dw01_data sdp3430_lcd_data = {
 	.resb_gpio = SDP3430_LCD_PANEL_ENABLE_GPIO,
 	.ini_gpio = -1,
@@ -167,8 +158,6 @@ static struct omap_dss_device sdp3430_tv_device = {
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= sdp3430_panel_enable_tv,
-	.platform_disable	= sdp3430_panel_disable_tv,
 };
 
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index eb245a6..edb4cce 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -138,22 +138,11 @@ static struct omap_dss_device am3517_evm_lcd_device = {
 	.phy.dpi.data_lines 	= 16,
 };
 
-static int am3517_evm_panel_enable_tv(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void am3517_evm_panel_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct omap_dss_device am3517_evm_tv_device = {
 	.type 			= OMAP_DISPLAY_TYPE_VENC,
 	.name 			= "tv",
 	.driver_name		= "venc",
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= am3517_evm_panel_enable_tv,
-	.platform_disable	= am3517_evm_panel_disable_tv,
 };
 
 static struct tfp410_platform_data dvi_panel = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 563d5ab..cb3b078 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -189,15 +189,6 @@ static inline void cm_t35_init_nand(void) {}
 #define CM_T35_LCD_BL_GPIO 58
 #define CM_T35_DVI_EN_GPIO 54
 
-static int cm_t35_panel_enable_tv(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct panel_generic_dpi_data lcd_panel = {
 	.name			= "toppoly_tdo35s",
 	.num_gpios		= 2,
@@ -233,8 +224,6 @@ static struct omap_dss_device cm_t35_tv_device = {
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= cm_t35_panel_enable_tv,
-	.platform_disable	= cm_t35_panel_disable_tv,
 };
 
 static struct omap_dss_device *cm_t35_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index dfb5e1b..a471476 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -201,22 +201,11 @@ static struct omap_dss_device omap3_evm_lcd_device = {
 	.data			= &omap3_evm_lcd_data,
 };
 
-static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void omap3_evm_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct omap_dss_device omap3_evm_tv_device = {
 	.name			= "tv",
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= omap3_evm_enable_tv,
-	.platform_disable	= omap3_evm_disable_tv,
 };
 
 static struct tfp410_platform_data dvi_panel = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 621ace1..8f1b0a1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -93,15 +93,6 @@ static void __init omap3_stalker_display_init(void)
 	return;
 }
 
-static int omap3_stalker_enable_tv(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void omap3_stalker_disable_tv(struct omap_dss_device *dssdev)
-{
-}
-
 static struct omap_dss_device omap3_stalker_tv_device = {
 	.name			= "tv",
 	.driver_name		= "venc",
@@ -111,8 +102,6 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 #elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
 	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
 #endif
-	.platform_enable	= omap3_stalker_enable_tv,
-	.platform_disable	= omap3_stalker_disable_tv,
 };
 
 static struct tfp410_platform_data dvi_panel = {
-- 
1.7.9.5

