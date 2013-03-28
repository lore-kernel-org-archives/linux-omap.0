From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/28] ARM: OMAP: Remove unnecessary platform callbacks for VENC devices
Date: Thu, 28 Mar 2013 14:48:55 +0200
Message-ID: <1364474962-20439-2-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004Ab3C1Mto (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:44 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

The omap_dss_device's platform_enable/disable callbacks don't do anything for
any of the boards. The platform calls from the VENC driver will also be removed
in the future. Remove these calls from boards which have a VENC device.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   12 ------------
 arch/arm/mach-omap2/board-am3517evm.c    |   11 -----------
 arch/arm/mach-omap2/board-cm-t35.c       |   11 -----------
 arch/arm/mach-omap2/board-omap3evm.c     |   11 -----------
 arch/arm/mach-omap2/board-omap3stalker.c |   11 -----------
 5 files changed, 56 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ce812de..5fdb382 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -138,16 +138,6 @@ static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 0);
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
-
 static struct omap_dss_device sdp3430_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "sharp_ls_panel",
@@ -175,8 +165,6 @@ static struct omap_dss_device sdp3430_tv_device = {
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= sdp3430_panel_enable_tv,
-	.platform_disable	= sdp3430_panel_disable_tv,
 };
 
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 9fb8590..25a0894 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -188,22 +188,11 @@ static struct omap_dss_device am3517_evm_lcd_device = {
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
index af2bb21..9c1895a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -217,15 +217,6 @@ static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
 }
 
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
 	.platform_enable	= cm_t35_panel_enable_lcd,
@@ -258,8 +249,6 @@ static struct omap_dss_device cm_t35_tv_device = {
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-	.platform_enable	= cm_t35_panel_enable_tv,
-	.platform_disable	= cm_t35_panel_disable_tv,
 };
 
 static struct omap_dss_device *cm_t35_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 48789e0..e86eb41 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -221,22 +221,11 @@ static struct omap_dss_device omap3_evm_lcd_device = {
 	.platform_disable	= omap3_evm_disable_lcd,
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
index 95c10b3..d427240 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -95,15 +95,6 @@ static void __init omap3_stalker_display_init(void)
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
@@ -113,8 +104,6 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 #elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
 	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
 #endif
-	.platform_enable	= omap3_stalker_enable_tv,
-	.platform_disable	= omap3_stalker_disable_tv,
 };
 
 static struct tfp410_platform_data dvi_panel = {
-- 
1.7.10.4

