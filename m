From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 24/26] ARM: OMAP: 4430SDP: use new Taal driver
Date: Tue, 26 Mar 2013 15:33:54 +0200
Message-ID: <1364304836-18134-25-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934388Ab3CZNfF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:35:05 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Change 4430SDP to use the new Taal platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   41 ++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 64ca888..a10c56b 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -107,7 +107,8 @@ void __init omap4_panda_display_init_of(void)
 #define DLP_POWER_ON_GPIO	40
 
 static struct nokia_dsi_panel_data dsi1_panel = {
-		.name		= "taal",
+		.name		= "lcd",
+		.source		= "dsi.0",
 		.reset_gpio	= 102,
 		.use_ext_te	= false,
 		.ext_te_gpio	= 101,
@@ -118,19 +119,15 @@ static struct nokia_dsi_panel_data dsi1_panel = {
 		},
 };
 
-static struct omap_dss_device sdp4430_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "taal",
-	.type			= OMAP_DISPLAY_TYPE_DSI,
-	.data			= &dsi1_panel,
-	.phy.dsi		= {
-		.module		= 0,
-	},
-	.channel		= OMAP_DSS_CHANNEL_LCD,
+static struct platform_device sdp4430_lcd1_device = {
+	.name			= "taal",
+	.id			= 0,
+	.dev.platform_data	= &dsi1_panel,
 };
 
 static struct nokia_dsi_panel_data dsi2_panel = {
-		.name		= "taal",
+		.name		= "lcd2",
+		.source		= "dsi.1",
 		.reset_gpio	= 104,
 		.use_ext_te	= false,
 		.ext_te_gpio	= 103,
@@ -141,16 +138,10 @@ static struct nokia_dsi_panel_data dsi2_panel = {
 		},
 };
 
-static struct omap_dss_device sdp4430_lcd2_device = {
-	.name			= "lcd2",
-	.driver_name		= "taal",
-	.type			= OMAP_DISPLAY_TYPE_DSI,
-	.data			= &dsi2_panel,
-	.phy.dsi		= {
-
-		.module		= 1,
-	},
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
+static struct platform_device sdp4430_lcd2_device = {
+	.name			= "taal",
+	.id			= 1,
+	.dev.platform_data	= &dsi2_panel,
 };
 
 static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
@@ -214,15 +205,13 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 };
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
-	&sdp4430_lcd_device,
-	&sdp4430_lcd2_device,
 	&sdp4430_picodlp_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
 	.devices	= sdp4430_dss_devices,
-	.default_device	= &sdp4430_lcd_device,
+	.default_display_name = "lcd",
 };
 
 void __init omap_4430sdp_display_init(void)
@@ -238,6 +227,8 @@ void __init omap_4430sdp_display_init(void)
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	platform_device_register(&sdp4430_hdmi_device);
+	platform_device_register(&sdp4430_lcd1_device);
+	platform_device_register(&sdp4430_lcd2_device);
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
@@ -265,4 +256,6 @@ void __init omap_4430sdp_display_init_of(void)
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	platform_device_register(&sdp4430_hdmi_device);
+	platform_device_register(&sdp4430_lcd1_device);
+	platform_device_register(&sdp4430_lcd2_device);
 }
-- 
1.7.10.4

