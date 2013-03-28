From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/28] ARM: OMAP: 4430SDP: use new Taal driver
Date: Thu, 28 Mar 2013 14:49:06 +0200
Message-ID: <1364474962-20439-13-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040Ab3C1Mt7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:59 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change 4430SDP to use the new Taal platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   47 +++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 1e2c5c0..0c0fc79 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -118,7 +118,8 @@ static struct platform_device sdp4430_hdmi_device = {
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 
 static struct nokia_dsi_panel_data dsi1_panel = {
-		.name		= "taal",
+		.name		= "lcd",
+		.source		= "dsi.0",
 		.reset_gpio	= 102,
 		.use_ext_te	= false,
 		.ext_te_gpio	= 101,
@@ -129,15 +130,10 @@ static struct nokia_dsi_panel_data dsi1_panel = {
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
 
 #if defined(CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2)
@@ -145,7 +141,8 @@ static struct omap_dss_device sdp4430_lcd_device = {
 static void sdp4430_picodlp_init(void) { }
 
 static struct nokia_dsi_panel_data dsi2_panel = {
-		.name		= "taal",
+		.name		= "lcd2",
+		.source		= "dsi.1",
 		.reset_gpio	= 104,
 		.use_ext_te	= false,
 		.ext_te_gpio	= 103,
@@ -156,16 +153,10 @@ static struct nokia_dsi_panel_data dsi2_panel = {
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
 
 #elif defined(CONFIG_MACH_OMAP_4430SDP_EXPANSION_PICO)
@@ -223,10 +214,6 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 #endif
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
-	&sdp4430_lcd_device,
-#ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2
-	&sdp4430_lcd2_device,
-#endif
 #ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_PICO
 	&sdp4430_picodlp_device,
 #endif
@@ -235,7 +222,7 @@ static struct omap_dss_device *sdp4430_dss_devices[] = {
 static struct omap_dss_board_info sdp4430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
 	.devices	= sdp4430_dss_devices,
-	.default_device	= &sdp4430_lcd_device,
+	.default_display_name = "lcd",
 };
 
 void __init omap_4430sdp_display_init(void)
@@ -251,6 +238,10 @@ void __init omap_4430sdp_display_init(void)
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	platform_device_register(&sdp4430_hdmi_device);
+	platform_device_register(&sdp4430_lcd1_device);
+#ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2
+	platform_device_register(&sdp4430_lcd2_device);
+#endif
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
@@ -278,4 +269,8 @@ void __init omap_4430sdp_display_init_of(void)
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	platform_device_register(&sdp4430_hdmi_device);
+	platform_device_register(&sdp4430_lcd1_device);
+#ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2
+	platform_device_register(&sdp4430_lcd2_device);
+#endif
 }
-- 
1.7.10.4

