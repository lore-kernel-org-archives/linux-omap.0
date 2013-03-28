From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/28] ARM: OMAP: Panda & SDP: use new HDMI driver
Date: Thu, 28 Mar 2013 14:49:05 +0200
Message-ID: <1364474962-20439-12-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57251 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab3C1Mt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:49:58 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change Pandaboard and 4430SDP to use the new HDMI platform driver
instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index fac4b3e..1e2c5c0 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -63,21 +63,13 @@ static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
-static struct omap_dss_device  omap4_panda_hdmi_device = {
-	.name = "hdmi",
-	.driver_name = "hdmi_panel",
-	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
-	.data = &omap4_panda_hdmi_data,
-};
-
-static struct omap_dss_device *omap4_panda_dss_devices[] = {
-	&omap4_panda_hdmi_device,
+static struct platform_device omap4_panda_hdmi_device = {
+	.name			= "hdmi_panel",
+	.id			= 0,
+	.dev.platform_data	= &omap4_panda_hdmi_data,
 };
 
 static struct omap_dss_board_info omap4_panda_dss_data = {
-	.num_devices	= ARRAY_SIZE(omap4_panda_dss_devices),
-	.devices	= omap4_panda_dss_devices,
 	.default_display_name = "dvi",
 };
 
@@ -85,6 +77,7 @@ void __init omap4_panda_display_init(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
 	platform_device_register(&omap4_panda_tfp410_device);
+	platform_device_register(&omap4_panda_hdmi_device);
 
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
@@ -104,6 +97,7 @@ void __init omap4_panda_display_init_of(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
 	platform_device_register(&omap4_panda_tfp410_device);
+	platform_device_register(&omap4_panda_hdmi_device);
 }
 
 
@@ -115,12 +109,10 @@ static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
-static struct omap_dss_device sdp4430_hdmi_device = {
-	.name = "hdmi",
-	.driver_name = "hdmi_panel",
-	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
-	.data = &sdp4430_hdmi_data,
+static struct platform_device sdp4430_hdmi_device = {
+	.name			= "hdmi_panel",
+	.id			= 0,
+	.dev.platform_data	= &sdp4430_hdmi_data,
 };
 
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
@@ -235,7 +227,6 @@ static struct omap_dss_device *sdp4430_dss_devices[] = {
 #ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2
 	&sdp4430_lcd2_device,
 #endif
-	&sdp4430_hdmi_device,
 #ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_PICO
 	&sdp4430_picodlp_device,
 #endif
@@ -259,6 +250,7 @@ void __init omap_4430sdp_display_init(void)
 
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+	platform_device_register(&sdp4430_hdmi_device);
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
@@ -285,4 +277,5 @@ void __init omap_4430sdp_display_init_of(void)
 
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+	platform_device_register(&sdp4430_hdmi_device);
 }
-- 
1.7.10.4

