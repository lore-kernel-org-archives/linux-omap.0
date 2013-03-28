From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/28] ARM: OMAP: 3430SDP: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:48:58 +0200
Message-ID: <1364474962-20439-5-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57242 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab3C1Mts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:49:48 -0400
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
 arch/arm/mach-omap2/Kconfig         |   13 ++++++++
 arch/arm/mach-omap2/board-3430sdp.c |   63 +++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f30aadb..17e02a3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -296,6 +296,19 @@ config MACH_OMAP_3430SDP
 	default y
 	select OMAP_PACKAGE_CBB
 
+choice
+	depends on MACH_OMAP_3430SDP
+	default MACH_OMAP_3430SDP_EXPANSION_LCD
+	prompt "OMAP 3430 SDP video output"
+
+config MACH_OMAP_3430SDP_EXPANSION_LCD
+	bool "OMAP 3430 SDP with LCD"
+
+config MACH_OMAP_3430SDP_EXPANSION_DVI
+	bool "OMAP 3430 SDP with DVI"
+
+endchoice
+
 config MACH_NOKIA_N800
        bool
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5fdb382..4acd4aa 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -105,6 +105,45 @@ static struct twl4030_keypad_data sdp3430_kp_data = {
 	.rep		= 1,
 };
 
+static struct omap_dss_device sdp3430_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+#if defined(CONFIG_MACH_OMAP_3430SDP_EXPANSION_DVI)
+
+static void __init sdp3430_display_init(void)
+{
+}
+
+static struct tfp410_platform_data dvi_panel = {
+	.power_down_gpio	= -1,
+	.i2c_bus_num		= -1,
+};
+
+static struct omap_dss_device sdp3430_dvi_device = {
+	.name			= "dvi",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "tfp410",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device *sdp3430_dss_devices[] = {
+	&sdp3430_dvi_device,
+	&sdp3430_tv_device,
+};
+
+static struct omap_dss_board_info sdp3430_dss_data = {
+	.num_devices	= ARRAY_SIZE(sdp3430_dss_devices),
+	.devices	= sdp3430_dss_devices,
+	.default_device	= &sdp3430_dvi_device,
+};
+
+#elif defined(CONFIG_MACH_OMAP_3430SDP_EXPANSION_LCD)
+
 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
 #define SDP3430_LCD_PANEL_ENABLE_GPIO		5
 
@@ -147,30 +186,8 @@ static struct omap_dss_device sdp3430_lcd_device = {
 	.platform_disable	= sdp3430_panel_disable_lcd,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
-	.i2c_bus_num		= -1,
-};
-
-static struct omap_dss_device sdp3430_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device sdp3430_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-};
-
-
 static struct omap_dss_device *sdp3430_dss_devices[] = {
 	&sdp3430_lcd_device,
-	&sdp3430_dvi_device,
 	&sdp3430_tv_device,
 };
 
@@ -180,6 +197,8 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };
 
+#endif
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-- 
1.7.10.4

