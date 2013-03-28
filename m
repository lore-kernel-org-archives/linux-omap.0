From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/28] ARM: OMAP: DEVKIT8000: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:49:00 +0200
Message-ID: <1364474962-20439-7-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55295 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab3C1Myz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:54:55 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Weber <weber@corscience.de>

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
Cc: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/Kconfig            |   13 +++++++
 arch/arm/mach-omap2/board-devkit8000.c |   58 +++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fcbcd6c..940903e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -206,6 +206,19 @@ config MACH_DEVKIT8000
 	default y
 	select OMAP_PACKAGE_CUS
 
+choice
+	depends on MACH_DEVKIT8000
+	default MACH_DEVKIT8000_EXPANSION_LCD
+	prompt "DEVKIT8000 video output"
+
+config MACH_DEVKIT8000_EXPANSION_LCD
+	bool "DEVKIT8000 with LCD"
+
+config MACH_DEVKIT8000_EXPANSION_DVI
+	bool "DEVKIT8000 with DVI"
+
+endchoice
+
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53056c3..e90808c 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -104,6 +104,24 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+static struct regulator_consumer_supply devkit8000_vmmc1_supply[] = {
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
+};
+
+/* ads7846 on SPI */
+static struct regulator_consumer_supply devkit8000_vio_supply[] = {
+	REGULATOR_SUPPLY("vcc", "spi2.0"),
+};
+
+static struct omap_dss_device devkit8000_tv_device = {
+	.name                   = "tv",
+	.driver_name            = "venc",
+	.type                   = OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+#if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
+
 static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
@@ -117,15 +135,6 @@ static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
 
-static struct regulator_consumer_supply devkit8000_vmmc1_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-/* ads7846 on SPI */
-static struct regulator_consumer_supply devkit8000_vio_supply[] = {
-	REGULATOR_SUPPLY("vcc", "spi2.0"),
-};
-
 static struct panel_generic_dpi_data lcd_panel = {
 	.name			= "innolux_at070tn83",
 	.platform_enable        = devkit8000_panel_enable_lcd,
@@ -140,6 +149,19 @@ static struct omap_dss_device devkit8000_lcd_device = {
 	.phy.dpi.data_lines     = 24,
 };
 
+static struct omap_dss_device *devkit8000_dss_devices[] = {
+	&devkit8000_lcd_device,
+	&devkit8000_tv_device,
+};
+
+static struct omap_dss_board_info devkit8000_dss_data = {
+	.num_devices = ARRAY_SIZE(devkit8000_dss_devices),
+	.devices = devkit8000_dss_devices,
+	.default_display_name = "lcd",
+};
+
+#elif defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
+
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
 	.i2c_bus_num		= 1,
@@ -153,16 +175,7 @@ static struct omap_dss_device devkit8000_dvi_device = {
 	.phy.dpi.data_lines     = 24,
 };
 
-static struct omap_dss_device devkit8000_tv_device = {
-	.name                   = "tv",
-	.driver_name            = "venc",
-	.type                   = OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
-};
-
-
 static struct omap_dss_device *devkit8000_dss_devices[] = {
-	&devkit8000_lcd_device,
 	&devkit8000_dvi_device,
 	&devkit8000_tv_device,
 };
@@ -170,8 +183,9 @@ static struct omap_dss_device *devkit8000_dss_devices[] = {
 static struct omap_dss_board_info devkit8000_dss_data = {
 	.num_devices = ARRAY_SIZE(devkit8000_dss_devices),
 	.devices = devkit8000_dss_devices,
-	.default_device = &devkit8000_lcd_device,
+	.default_display_name = "dvi",
 };
+#endif
 
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
@@ -211,7 +225,9 @@ static struct gpio_led gpio_leds[];
 static int devkit8000_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+#if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
 	int ret;
+#endif
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
@@ -220,6 +236,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+#if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
 	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
 	devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
 	ret = gpio_request_one(devkit8000_lcd_device.reset_gpio,
@@ -228,9 +245,10 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 		devkit8000_lcd_device.reset_gpio = -EINVAL;
 		printk(KERN_ERR "Failed to request GPIO for LCD_PWRN\n");
 	}
-
+#elif defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
 	/* gpio + 7 is "DVI_PD" (out, active low) */
 	dvi_panel.power_down_gpio = gpio + 7;
+#endif
 
 	return 0;
 }
-- 
1.7.10.4

