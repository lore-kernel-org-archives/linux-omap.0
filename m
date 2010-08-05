From: Pawel Moll <mail@pawelmoll.com>
Subject: [PATCH] omap: Update omap3evm board support
Date: Thu,  5 Aug 2010 09:36:14 +0100
Message-ID: <1280997374-2314-1-git-send-email-mail@pawelmoll.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from stallman.rootnode.net ([89.248.165.10]:46947 "EHLO
	stallman.rootnode.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758834Ab0HEJD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 05:03:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stallman.rootnode.net (Exchange) with ESMTP id 37D2E4B7B
	for <linux-omap@vger.kernel.org>; Thu,  5 Aug 2010 10:36:17 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- Fix regulator definitions to provide supplies required
  by frame buffer (OMAP DSS2) and touch panel drivers,
- fix LCD and touch panel power handling (as disabling the LCD power
  disabled touch panel as well which meant no more input events...),
- fix power module LED definition,
- update omap3_defconfig, enabling required drivers

Signed-off-by: Pawel Moll <mail@pawelmoll.com>
---
 arch/arm/configs/omap3_defconfig     |    5 +++
 arch/arm/mach-omap2/board-omap3evm.c |   51 +++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 5db9a6b..fd5980a 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -182,6 +182,7 @@ CONFIG_MENELAUS=y
 CONFIG_TWL4030_CORE=y
 CONFIG_TWL4030_POWER=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
@@ -190,6 +191,10 @@ CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_OMAP_LCD_VGA=y
+CONFIG_OMAP2_DSS=y
+CONFIG_FB_OMAP2=y
+CONFIG_PANEL_GENERIC=y
+CONFIG_PANEL_SHARP_LS037V7DW01=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6494dbd..d180be7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -31,6 +31,7 @@
 #include <linux/smsc911x.h>
 
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -157,8 +158,8 @@ static inline void __init omap3evm_init_smsc911x(void) { return; }
 #define OMAP3EVM_LCD_PANEL_ENVDD	153
 #define OMAP3EVM_LCD_PANEL_QVGA		154
 #define OMAP3EVM_LCD_PANEL_RESB		155
-#define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
 #define OMAP3EVM_DVI_PANEL_EN_GPIO	199
+#define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
 
 static int lcd_enabled;
 static int dvi_enabled;
@@ -243,7 +244,11 @@ static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 
 static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 {
+	/* We don't really want to cut off the panel power, as the touch panel
+	 * is powered from the same source... */
+#if 0
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);
+#endif
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
 		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
@@ -381,7 +386,7 @@ static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "omap3evm::ledb",
 		/* normally not visible (board underside) */
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 		.gpio			= -EINVAL,	/* gets replaced */
 		.active_low		= true,
 	},
@@ -419,15 +424,15 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	 */
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_request(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, "EN_LCD_BKL");
+	gpio_direction_output(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 
 	/* gpio + 7 == DVI Enable */
 	gpio_request(gpio + 7, "EN_DVI");
 	gpio_direction_output(gpio + 7, 0);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+	gpio_leds[0].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
 	platform_device_register(&leds_gpio);
 
@@ -493,10 +498,8 @@ static struct twl4030_codec_data omap3evm_codec_data = {
 	.audio = &omap3evm_audio_data,
 };
 
-static struct regulator_consumer_supply omap3_evm_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &omap3_evm_dss_device.dev,
-};
+static struct regulator_consumer_supply omap3_evm_vdda_dac_supply = 
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
 /* VDAC for DSS driving S-Video */
 static struct regulator_init_data omap3_evm_vdac = {
@@ -514,10 +517,8 @@ static struct regulator_init_data omap3_evm_vdac = {
 };
 
 /* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
-	.supply		= "vdvi",
-	.dev		= &omap3_evm_lcd_device.dev,
-};
+static struct regulator_consumer_supply omap3_evm_vpll2_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
 
 static struct regulator_init_data omap3_evm_vpll2 = {
 	.constraints = {
@@ -573,6 +574,29 @@ static int __init omap3_evm_i2c_init(void)
 	return 0;
 }
 
+static struct regulator_consumer_supply ads7846_consumer_supply =
+	REGULATOR_SUPPLY("vcc", "spi1.0");
+
+struct regulator_init_data ads7846_vcc_initdata = {
+	.consumer_supplies = &ads7846_consumer_supply,
+	.num_consumer_supplies = 1,
+};
+
+static struct fixed_voltage_config ads7846_vcc_config = {
+	.supply_name = "VIO_1v8",
+	.microvolts = 1800000,
+	.gpio = -1,
+	.init_data = &ads7846_vcc_initdata,
+};
+
+static struct platform_device omap3_evm_ads7846_vcc_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &ads7846_vcc_config,
+	},
+};
+
 static void ads7846_dev_init(void)
 {
 	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
@@ -631,6 +655,7 @@ static void __init omap3_evm_init_irq(void)
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
+	&omap3_evm_ads7846_vcc_device,
 	&omap3_evm_dss_device,
 };
 
-- 
1.6.3.3

