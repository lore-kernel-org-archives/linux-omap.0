From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/4] omap: igep0020: minor refactoring
Date: Fri, 13 May 2011 00:31:02 +0300
Message-ID: <91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50626
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932785Ab1ELVbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 17:31:17 -0400
In-Reply-To: <cover.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony.Lindgren.tony@atomide.com
Cc: =?UTF-8?q?Enric=20Balletb=F2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

to allow easy addition of IGEP3

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-igep0020.c |   57 ++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ad20f7b..ea7cbc6 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -299,17 +299,14 @@ static struct omap2_hsmmc_info mmc[] = {
 static struct gpio_led igep_gpio_leds[] = {
 	[0] = {
 		.name			= "gpio-led:red:d0",
-		.gpio			= IGEP2_GPIO_LED0_RED,
 		.default_trigger	= "default-off"
 	},
 	[1] = {
 		.name			= "gpio-led:green:d0",
-		.gpio			= IGEP2_GPIO_LED0_GREEN,
 		.default_trigger	= "default-off",
 	},
 	[2] = {
 		.name			= "gpio-led:red:d1",
-		.gpio			= IGEP2_GPIO_LED1_RED,
 		.default_trigger	= "default-off",
 	},
 	[3] = {
@@ -335,6 +332,10 @@ static struct platform_device igep_led_device = {
 
 static void __init igep_leds_init(void)
 {
+	igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
+	igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
+	igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
+
 	platform_device_register(&igep_led_device);
 }
 
@@ -347,14 +348,15 @@ static struct gpio igep_gpio_leds[] __initdata = {
 
 static inline void igep_leds_init(void)
 {
+	int i;
+
 	if (gpio_request_array(igep_gpio_leds, ARRAY_SIZE(igep_gpio_leds))) {
 		pr_warning("IGEP v2: Could not obtain leds gpios\n");
 		return;
 	}
 
-	gpio_export(IGEP2_GPIO_LED0_RED, 0);
-	gpio_export(IGEP2_GPIO_LED0_GREEN, 0);
-	gpio_export(IGEP2_GPIO_LED1_RED, 0);
+	for (i = 0; i < ARRAY_SIZE(igep_gpio_leds); i++)
+		gpio_export(igep_gpio_leds[i].gpio, 0);
 }
 #endif
 
@@ -372,6 +374,18 @@ static int igep_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
+	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
+#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
+	ret = gpio_request_one(gpio + TWL4030_GPIO_MAX + 1, GPIOF_OUT_INIT_HIGH,
+			       "gpio-led:green:d1");
+	if (ret == 0)
+		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
+	else
+		pr_warning("IGEP: Could not obtain gpio GPIO_LED1_GREEN\n");
+#else
+	igep_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
+#endif
+
 	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -385,18 +399,6 @@ static int igep_twl_gpio_setup(struct device *dev,
 	if (ret < 0)
 		pr_err("IGEP2: Could not obtain gpio for USBH_CPEN");
 
-	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
-#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
-	ret = gpio_request_one(gpio + TWL4030_GPIO_MAX + 1, GPIOF_OUT_INIT_HIGH,
-			       "gpio-led:green:d1");
-	if (ret == 0)
-		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
-	else
-		pr_warning("IGEP: Could not obtain gpio GPIO_LED1_GREEN\n");
-#else
-	igep_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
-#endif
-
 	return 0;
 };
 
@@ -531,11 +533,8 @@ static struct twl4030_platform_data igep_twldata = {
 
 	/* platform_data for children goes here */
 	.usb		= &igep_usb_data,
-	.codec		= &igep2_codec_data,
 	.gpio		= &igep_twl4030_gpio_pdata,
-	.keypad		= &igep2_keypad_pdata,
 	.vmmc1          = &igep_vmmc1,
-	.vpll2		= &igep2_vpll2,
 	.vio		= &igep_vio,
 };
 
@@ -549,8 +548,6 @@ static void __init igep_i2c_init(void)
 {
 	int ret;
 
-	omap3_pmic_init("twl4030", &igep_twldata);
-
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz
@@ -559,6 +556,12 @@ static void __init igep_i2c_init(void)
 		ARRAY_SIZE(igep2_i2c3_boardinfo));
 	if (ret)
 		pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
+
+	igep_twldata.codec	= &igep2_codec_data;
+	igep_twldata.keypad	= &igep2_keypad_pdata;
+	igep_twldata.vpll2	= &igep2_vpll2;
+
+	omap3_pmic_init("twl4030", &igep_twldata);
 }
 
 static const struct usbhs_omap_board_data igep2_usbhs_bdata __initconst = {
@@ -630,15 +633,11 @@ static void __init igep_init(void)
 	/* Register I2C busses and drivers */
 	igep_i2c_init();
 	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
-	omap_display_init(&igep2_dss_data);
 	omap_serial_init();
 	usb_musb_init(NULL);
-	usbhs_init(&igep2_usbhs_bdata);
 
 	igep_flash_init();
 	igep_leds_init();
-	igep2_display_init();
-	igep2_init_smsc911x();
 
 	/*
 	 * WLAN-BT combo module from MuRata which has a Marvell WLAN
@@ -646,6 +645,10 @@ static void __init igep_init(void)
 	 */
 	igep_wlan_bt_init();
 
+	omap_display_init(&igep2_dss_data);
+	igep2_display_init();
+	igep2_init_smsc911x();
+	usbhs_init(&igep2_usbhs_bdata);
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
-- 
1.7.3.1

