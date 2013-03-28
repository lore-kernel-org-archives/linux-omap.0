From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/28] ARM: OMAP: 4430SDP: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:48:59 +0200
Message-ID: <1364474962-20439-6-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44541 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mtu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:50 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Boards with multiple display options for the same video bus have all the
possible linux display devices present at the same time. Only one of
those devices should be used at a time, as the video bus cannot be
shared.

This model is hacky, and will be changed in the forthcoming DSS patches
to a model where only one display device can be present on a single
video bus.

This patch creates Kconfig options to select which of the display
devices is present on the board. While this model is also somewhat
hacky, and prevents us from using a single kernel image for all the
display options, it allows us to make the DSS driver changes for DT
adaptation. And with DT, the information about display devices can be
passed from the bootloader, solving the mess.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/Kconfig      |   13 +++++++++++++
 arch/arm/mach-omap2/dss-common.c |   39 +++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 17e02a3..fcbcd6c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -413,6 +413,19 @@ config MACH_OMAP_4430SDP
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+choice
+	depends on MACH_OMAP_4430SDP
+	default MACH_OMAP_4430SDP_EXPANSION_LCD2
+	prompt "OMAP 4430 SDP video output"
+
+config MACH_OMAP_4430SDP_EXPANSION_LCD2
+	bool "OMAP 4430 SDP with second LCD panel"
+
+config MACH_OMAP_4430SDP_EXPANSION_PICO
+	bool "OMAP 4430 SDP with Pico DLP projector"
+
+endchoice
+
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
 	default y
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 4228e57..135fdd8 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -108,8 +108,21 @@ void __init omap4_panda_display_init_of(void)
 
 /* OMAP4 Blaze display data */
 
+static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
+	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
+	.ls_oe_gpio = HDMI_GPIO_LS_OE,
+	.hpd_gpio = HDMI_GPIO_HPD,
+};
+
+static struct omap_dss_device sdp4430_hdmi_device = {
+	.name = "hdmi",
+	.driver_name = "hdmi_panel",
+	.type = OMAP_DISPLAY_TYPE_HDMI,
+	.channel = OMAP_DSS_CHANNEL_DIGIT,
+	.data = &sdp4430_hdmi_data,
+};
+
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
-#define DLP_POWER_ON_GPIO	40
 
 static struct nokia_dsi_panel_data dsi1_panel = {
 		.name		= "taal",
@@ -134,6 +147,10 @@ static struct omap_dss_device sdp4430_lcd_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD,
 };
 
+#if defined(CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2)
+
+static void sdp4430_picodlp_init(void) { }
+
 static struct nokia_dsi_panel_data dsi2_panel = {
 		.name		= "taal",
 		.reset_gpio	= 104,
@@ -158,19 +175,9 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
-	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
-	.ls_oe_gpio = HDMI_GPIO_LS_OE,
-	.hpd_gpio = HDMI_GPIO_HPD,
-};
+#elif defined(CONFIG_MACH_OMAP_4430SDP_EXPANSION_PICO)
 
-static struct omap_dss_device sdp4430_hdmi_device = {
-	.name = "hdmi",
-	.driver_name = "hdmi_panel",
-	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
-	.data = &sdp4430_hdmi_data,
-};
+#define DLP_POWER_ON_GPIO	40
 
 static struct picodlp_panel_data sdp4430_picodlp_pdata = {
 	.picodlp_adapter_id	= 2,
@@ -220,11 +227,17 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 	.data			= &sdp4430_picodlp_pdata,
 };
 
+#endif
+
 static struct omap_dss_device *sdp4430_dss_devices[] = {
 	&sdp4430_lcd_device,
+#ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_LCD2
 	&sdp4430_lcd2_device,
+#endif
 	&sdp4430_hdmi_device,
+#ifdef CONFIG_MACH_OMAP_4430SDP_EXPANSION_PICO
 	&sdp4430_picodlp_device,
+#endif
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
-- 
1.7.10.4

