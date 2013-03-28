From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/28] ARM: OMAP: AM3517EVM: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:49:03 +0200
Message-ID: <1364474962-20439-10-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38202 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab3C1Mt4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:56 -0400
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
 arch/arm/mach-omap2/Kconfig           |   13 +++++++++
 arch/arm/mach-omap2/board-am3517evm.c |   49 ++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 6e73cb4..57e1d37 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -298,6 +298,19 @@ config MACH_OMAP3517EVM
 	default y
 	select OMAP_PACKAGE_CBB
 
+choice
+	depends on MACH_OMAP3517EVM
+	default MACH_OMAP3517EVM_EXPANSION_LCD
+	prompt "OMAP3517/ AM3517 EVM video output"
+
+config MACH_OMAP3517EVM_EXPANSION_LCD
+	bool "OMAP3517/ AM3517 EVM with LCD"
+
+config MACH_OMAP3517EVM_EXPANSION_DVI
+	bool "OMAP3517/ AM3517 EVM with DVI"
+
+endchoice
+
 config MACH_CRANEBOARD
 	bool "AM3517/05 CRANE board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 25a0894..1d7d0d8 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -121,11 +121,15 @@ static int __init am3517_evm_i2c_init(void)
 	return 0;
 }
 
-static int lcd_enabled;
-static int dvi_enabled;
+static struct omap_dss_device am3517_evm_tv_device = {
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.name			= "tv",
+	.driver_name		= "venc",
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+#if defined(CONFIG_MACH_OMAP3517EVM_EXPANSION_LCD)
 
-#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
-		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
 static struct gpio am3517_evm_dss_gpios[] __initdata = {
 	/* GPIO 182 = LCD Backlight Power */
 	{ LCD_PANEL_BKLIGHT_PWR, GPIOF_OUT_INIT_HIGH, "lcd_backlight_pwr" },
@@ -152,26 +156,16 @@ static void __init am3517_evm_display_init(void)
 
 	printk(KERN_INFO "Display initialized successfully\n");
 }
-#else
-static void __init am3517_evm_display_init(void) {}
-#endif
 
 static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
 	gpio_set_value(LCD_PANEL_PWR, 1);
-	lcd_enabled = 1;
-
 	return 0;
 }
 
 static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 	gpio_set_value(LCD_PANEL_PWR, 0);
-	lcd_enabled = 0;
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
@@ -188,13 +182,23 @@ static struct omap_dss_device am3517_evm_lcd_device = {
 	.phy.dpi.data_lines 	= 16,
 };
 
-static struct omap_dss_device am3517_evm_tv_device = {
-	.type 			= OMAP_DISPLAY_TYPE_VENC,
-	.name 			= "tv",
-	.driver_name		= "venc",
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct omap_dss_device *am3517_evm_dss_devices[] = {
+	&am3517_evm_lcd_device,
+	&am3517_evm_tv_device,
+};
+
+static struct omap_dss_board_info am3517_evm_dss_data = {
+	.num_devices	= ARRAY_SIZE(am3517_evm_dss_devices),
+	.devices	= am3517_evm_dss_devices,
+	.default_display_name = "lcd",
 };
 
+#elif defined(CONFIG_MACH_OMAP3517EVM_EXPANSION_DVI)
+
+static void __init am3517_evm_display_init(void)
+{
+}
+
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
 	.i2c_bus_num		= -1,
@@ -209,17 +213,18 @@ static struct omap_dss_device am3517_evm_dvi_device = {
 };
 
 static struct omap_dss_device *am3517_evm_dss_devices[] = {
-	&am3517_evm_lcd_device,
-	&am3517_evm_tv_device,
 	&am3517_evm_dvi_device,
+	&am3517_evm_tv_device,
 };
 
 static struct omap_dss_board_info am3517_evm_dss_data = {
 	.num_devices	= ARRAY_SIZE(am3517_evm_dss_devices),
 	.devices	= am3517_evm_dss_devices,
-	.default_device	= &am3517_evm_lcd_device,
+	.default_display_name = "dvi",
 };
 
+#endif
+
 /*
  * Board initialization
  */
-- 
1.7.10.4

