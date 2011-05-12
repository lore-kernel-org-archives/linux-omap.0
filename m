From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 3/4] omap: igep0020: add support for IGEP3
Date: Fri, 13 May 2011 00:31:03 +0300
Message-ID: <ca1b59c2bed6076d68f18bad84a2504b855160d4.1305235542.git.mike@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50629
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932790Ab1ELVbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 17:31:18 -0400
In-Reply-To: <cover.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony.Lindgren.tony@atomide.com
Cc: =?UTF-8?q?Enric=20Balletb=F2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Add IGEP3 machine support to board-igep0020

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-igep0020.c |  103 ++++++++++++++++++++++++++--------
 1 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ea7cbc6..0d6d583 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -55,6 +55,11 @@
 #define IGEP2_RC_GPIO_WIFI_NRESET  139
 #define IGEP2_RC_GPIO_BT_NRESET    137
 
+#define IGEP3_GPIO_LED0_GREEN	54
+#define IGEP3_GPIO_LED0_RED	53
+#define IGEP3_GPIO_LED1_RED	16
+#define IGEP3_GPIO_USBH_NRESET  183
+
 /*
  * IGEP2 Hardware Revision Table
  *
@@ -69,6 +74,7 @@
 
 #define IGEP2_BOARD_HWREV_B	0
 #define IGEP2_BOARD_HWREV_C	1
+#define IGEP3_BOARD_HWREV	2
 
 static u8 hwrev;
 
@@ -76,6 +82,11 @@ static void __init igep2_get_revision(void)
 {
 	u8 ret;
 
+	if (machine_is_igep0030()) {
+		hwrev = IGEP3_BOARD_HWREV;
+		return;
+	}
+
 	omap_mux_init_gpio(IGEP2_GPIO_LED1_RED, OMAP_PIN_INPUT);
 
 	if (gpio_request_one(IGEP2_GPIO_LED1_RED, GPIOF_IN, "GPIO_HW0_REV")) {
@@ -332,24 +343,40 @@ static struct platform_device igep_led_device = {
 
 static void __init igep_leds_init(void)
 {
-	igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
-	igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
-	igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
+	if (machine_is_igep0020()) {
+		igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
+		igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
+		igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
+	} else {
+		igep_gpio_leds[0].gpio = IGEP3_GPIO_LED0_RED;
+		igep_gpio_leds[1].gpio = IGEP3_GPIO_LED0_GREEN;
+		igep_gpio_leds[2].gpio = IGEP3_GPIO_LED1_RED;
+	}
 
 	platform_device_register(&igep_led_device);
 }
 
 #else
 static struct gpio igep_gpio_leds[] __initdata = {
-	{ IGEP2_GPIO_LED0_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d0"   },
-	{ IGEP2_GPIO_LED0_GREEN, GPIOF_OUT_INIT_LOW, "gpio-led:green:d0" },
-	{ IGEP2_GPIO_LED1_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d1"   },
+	{ -EINVAL,	GPIOF_OUT_INIT_LOW, "gpio-led:red:d0"   },
+	{ -EINVAL,	GPIOF_OUT_INIT_LOW, "gpio-led:green:d0" },
+	{ -EINVAL,	GPIOF_OUT_INIT_LOW, "gpio-led:red:d1"   },
 };
 
 static inline void igep_leds_init(void)
 {
 	int i;
 
+	if (machine_is_igep0020()) {
+		igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
+		igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
+		igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
+	} else {
+		igep_gpio_leds[0].gpio = IGEP3_GPIO_LED0_RED;
+		igep_gpio_leds[1].gpio = IGEP3_GPIO_LED0_GREEN;
+		igep_gpio_leds[2].gpio = IGEP3_GPIO_LED1_RED;
+	}
+
 	if (gpio_request_array(igep_gpio_leds, ARRAY_SIZE(igep_gpio_leds))) {
 		pr_warning("IGEP v2: Could not obtain leds gpios\n");
 		return;
@@ -386,6 +413,9 @@ static int igep_twl_gpio_setup(struct device *dev,
 	igep_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
 #endif
 
+	if (machine_is_igep0030())
+		return 0;
+
 	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -548,18 +578,20 @@ static void __init igep_i2c_init(void)
 {
 	int ret;
 
-	/*
-	 * Bus 3 is attached to the DVI port where devices like the pico DLP
-	 * projector don't work reliably with 400kHz
-	 */
-	ret = omap_register_i2c_bus(3, 100, igep2_i2c3_boardinfo,
-		ARRAY_SIZE(igep2_i2c3_boardinfo));
-	if (ret)
-		pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
-
-	igep_twldata.codec	= &igep2_codec_data;
-	igep_twldata.keypad	= &igep2_keypad_pdata;
-	igep_twldata.vpll2	= &igep2_vpll2;
+	if (machine_is_igep0020()) {
+		/*
+		 * Bus 3 is attached to the DVI port where devices like the
+		 * pico DLP projector don't work reliably with 400kHz
+		 */
+		ret = omap_register_i2c_bus(3, 100, igep2_i2c3_boardinfo,
+					    ARRAY_SIZE(igep2_i2c3_boardinfo));
+		if (ret)
+			pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
+
+		igep_twldata.codec	= &igep2_codec_data;
+		igep_twldata.keypad	= &igep2_keypad_pdata;
+		igep_twldata.vpll2	= &igep2_vpll2;
+	}
 
 	omap3_pmic_init("twl4030", &igep_twldata);
 }
@@ -575,6 +607,17 @@ static const struct usbhs_omap_board_data igep2_usbhs_bdata __initconst = {
 	.reset_gpio_port[2] = -EINVAL,
 };
 
+static const struct usbhs_omap_board_data igep3_usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
+
+	.phy_reset = true,
+	.reset_gpio_port[0] = -EINVAL,
+	.reset_gpio_port[1] = IGEP3_GPIO_USBH_NRESET,
+	.reset_gpio_port[2] = -EINVAL,
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -597,7 +640,7 @@ static void __init igep_wlan_bt_init(void)
 		igep_wlan_bt_gpios[0].gpio = IGEP2_RB_GPIO_WIFI_NPD;
 		igep_wlan_bt_gpios[1].gpio = IGEP2_RB_GPIO_WIFI_NRESET;
 		igep_wlan_bt_gpios[2].gpio = IGEP2_RB_GPIO_BT_NRESET;
-	} else if (hwrev == IGEP2_BOARD_HWREV_C) {
+	} else if (hwrev == IGEP2_BOARD_HWREV_C || machine_is_igep0030()) {
 		igep_wlan_bt_gpios[0].gpio = IGEP2_RC_GPIO_WIFI_NPD;
 		igep_wlan_bt_gpios[1].gpio = IGEP2_RC_GPIO_WIFI_NRESET;
 		igep_wlan_bt_gpios[2].gpio = IGEP2_RC_GPIO_BT_NRESET;
@@ -645,10 +688,14 @@ static void __init igep_init(void)
 	 */
 	igep_wlan_bt_init();
 
-	omap_display_init(&igep2_dss_data);
-	igep2_display_init();
-	igep2_init_smsc911x();
-	usbhs_init(&igep2_usbhs_bdata);
+	if (machine_is_igep0020()) {
+		omap_display_init(&igep2_dss_data);
+		igep2_display_init();
+		igep2_init_smsc911x();
+		usbhs_init(&igep2_usbhs_bdata);
+	} else {
+		usbhs_init(&igep3_usbhs_bdata);
+	}
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
@@ -660,3 +707,13 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_machine	= igep_init,
 	.timer		= &omap_timer,
 MACHINE_END
+
+MACHINE_START(IGEP0030, "IGEP OMAP3 module")
+	.boot_params	= 0x80000100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= igep_init_early,
+	.init_irq	= omap_init_irq,
+	.init_machine	= igep_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.7.3.1

