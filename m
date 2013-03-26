From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/26] ARM: OMAP: Panda & SDP: use new HDMI driver
Date: Tue, 26 Mar 2013 15:33:53 +0200
Message-ID: <1364304836-18134-24-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934289Ab3CZNfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:35:03 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Change Pandaboard and 4430SDP to use the new HDMI platform driver
instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 0e94df8..64ca888 100644
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
 
 
@@ -165,12 +159,10 @@ static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
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
 
 static struct picodlp_panel_data sdp4430_picodlp_pdata = {
@@ -224,7 +216,6 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 static struct omap_dss_device *sdp4430_dss_devices[] = {
 	&sdp4430_lcd_device,
 	&sdp4430_lcd2_device,
-	&sdp4430_hdmi_device,
 	&sdp4430_picodlp_device,
 };
 
@@ -246,6 +237,7 @@ void __init omap_4430sdp_display_init(void)
 
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+	platform_device_register(&sdp4430_hdmi_device);
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
@@ -272,4 +264,5 @@ void __init omap_4430sdp_display_init_of(void)
 
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+	platform_device_register(&sdp4430_hdmi_device);
 }
-- 
1.7.10.4

