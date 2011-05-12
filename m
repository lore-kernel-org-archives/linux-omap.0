From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/4] omap: igep0020: name refactoring for future merge with IGEP3
Date: Fri, 13 May 2011 00:31:01 +0300
Message-ID: <d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50625
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932764Ab1ELVbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 17:31:17 -0400
In-Reply-To: <cover.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony.Lindgren.tony@atomide.com
Cc: =?UTF-8?q?Enric=20Balletb=F2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

IGEP2 and IGEP3 boards are very similar and can be merged into one file.
Start refactoring with changing igep2 to igep where applicable.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-igep0020.c |  158 +++++++++++++++++-----------------
 1 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index c62c297e..ad20f7b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -112,7 +112,7 @@ static void __init igep2_get_revision(void)
  * So MTD regards it as 4KiB page size and 256KiB block size 64*(2*2048)
  */
 
-static struct mtd_partition igep2_onenand_partitions[] = {
+static struct mtd_partition igep_onenand_partitions[] = {
 	{
 		.name           = "X-Loader",
 		.offset         = 0,
@@ -140,21 +140,21 @@ static struct mtd_partition igep2_onenand_partitions[] = {
 	},
 };
 
-static struct omap_onenand_platform_data igep2_onenand_data = {
-	.parts = igep2_onenand_partitions,
-	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
+static struct omap_onenand_platform_data igep_onenand_data = {
+	.parts = igep_onenand_partitions,
+	.nr_parts = ARRAY_SIZE(igep_onenand_partitions),
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
 };
 
-static struct platform_device igep2_onenand_device = {
+static struct platform_device igep_onenand_device = {
 	.name		= "omap2-onenand",
 	.id		= -1,
 	.dev = {
-		.platform_data = &igep2_onenand_data,
+		.platform_data = &igep_onenand_data,
 	},
 };
 
-static void __init igep2_flash_init(void)
+static void __init igep_flash_init(void)
 {
 	u8 cs = 0;
 	u8 onenandcs = GPMC_CS_NUM + 1;
@@ -166,7 +166,7 @@ static void __init igep2_flash_init(void)
 		/* Check if NAND/oneNAND is configured */
 		if ((ret & 0xC00) == 0x800)
 			/* NAND found */
-			pr_err("IGEP2: Unsupported NAND found\n");
+			pr_err("IGEP: Unsupported NAND found\n");
 		else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
@@ -176,18 +176,18 @@ static void __init igep2_flash_init(void)
 	}
 
 	if (onenandcs > GPMC_CS_NUM) {
-		pr_err("IGEP2: Unable to find configuration in GPMC\n");
+		pr_err("IGEP: Unable to find configuration in GPMC\n");
 		return;
 	}
 
-	igep2_onenand_data.cs = onenandcs;
+	igep_onenand_data.cs = onenandcs;
 
-	if (platform_device_register(&igep2_onenand_device) < 0)
-		pr_err("IGEP2: Unable to register OneNAND device\n");
+	if (platform_device_register(&igep_onenand_device) < 0)
+		pr_err("IGEP: Unable to register OneNAND device\n");
 }
 
 #else
-static void __init igep2_flash_init(void) {}
+static void __init igep_flash_init(void) {}
 #endif
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
@@ -211,11 +211,11 @@ static inline void __init igep2_init_smsc911x(void)
 static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
-static struct regulator_consumer_supply igep2_vmmc1_supply =
+static struct regulator_consumer_supply igep_vmmc1_supply =
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data igep2_vmmc1 = {
+static struct regulator_init_data igep_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
@@ -226,13 +226,13 @@ static struct regulator_init_data igep2_vmmc1 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vmmc1_supply,
+	.consumer_supplies      = &igep_vmmc1_supply,
 };
 
-static struct regulator_consumer_supply igep2_vio_supply =
+static struct regulator_consumer_supply igep_vio_supply =
 	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.1");
 
-static struct regulator_init_data igep2_vio = {
+static struct regulator_init_data igep_vio = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
@@ -244,34 +244,34 @@ static struct regulator_init_data igep2_vio = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vio_supply,
+	.consumer_supplies      = &igep_vio_supply,
 };
 
-static struct regulator_consumer_supply igep2_vmmc2_supply =
+static struct regulator_consumer_supply igep_vmmc2_supply =
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
-static struct regulator_init_data igep2_vmmc2 = {
+static struct regulator_init_data igep_vmmc2 = {
 	.constraints		= {
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
 		.always_on		= 1,
 	},
 	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &igep2_vmmc2_supply,
+	.consumer_supplies	= &igep_vmmc2_supply,
 };
 
-static struct fixed_voltage_config igep2_vwlan = {
+static struct fixed_voltage_config igep_vwlan = {
 	.supply_name		= "vwlan",
 	.microvolts		= 3300000,
 	.gpio			= -EINVAL,
 	.enabled_at_boot	= 1,
-	.init_data		= &igep2_vmmc2,
+	.init_data		= &igep_vmmc2,
 };
 
-static struct platform_device igep2_vwlan_device = {
+static struct platform_device igep_vwlan_device = {
 	.name		= "reg-fixed-voltage",
 	.id		= 0,
 	.dev = {
-		.platform_data	= &igep2_vwlan,
+		.platform_data	= &igep_vwlan,
 	},
 };
 
@@ -296,7 +296,7 @@ static struct omap2_hsmmc_info mmc[] = {
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 #include <linux/leds.h>
 
-static struct gpio_led igep2_gpio_leds[] = {
+static struct gpio_led igep_gpio_leds[] = {
 	[0] = {
 		.name			= "gpio-led:red:d0",
 		.gpio			= IGEP2_GPIO_LED0_RED,
@@ -320,34 +320,34 @@ static struct gpio_led igep2_gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data igep2_led_pdata = {
-	.leds           = igep2_gpio_leds,
-	.num_leds       = ARRAY_SIZE(igep2_gpio_leds),
+static struct gpio_led_platform_data igep_led_pdata = {
+	.leds           = igep_gpio_leds,
+	.num_leds       = ARRAY_SIZE(igep_gpio_leds),
 };
 
-static struct platform_device igep2_led_device = {
+static struct platform_device igep_led_device = {
 	 .name   = "leds-gpio",
 	 .id     = -1,
 	 .dev    = {
-		 .platform_data  =  &igep2_led_pdata,
+		 .platform_data  =  &igep_led_pdata,
 	},
 };
 
-static void __init igep2_leds_init(void)
+static void __init igep_leds_init(void)
 {
-	platform_device_register(&igep2_led_device);
+	platform_device_register(&igep_led_device);
 }
 
 #else
-static struct gpio igep2_gpio_leds[] __initdata = {
+static struct gpio igep_gpio_leds[] __initdata = {
 	{ IGEP2_GPIO_LED0_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d0"   },
 	{ IGEP2_GPIO_LED0_GREEN, GPIOF_OUT_INIT_LOW, "gpio-led:green:d0" },
 	{ IGEP2_GPIO_LED1_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d1"   },
 };
 
-static inline void igep2_leds_init(void)
+static inline void igep_leds_init(void)
 {
-	if (gpio_request_array(igep2_gpio_leds, ARRAY_SIZE(igep2_gpio_leds))) {
+	if (gpio_request_array(igep_gpio_leds, ARRAY_SIZE(igep_gpio_leds))) {
 		pr_warning("IGEP v2: Could not obtain leds gpios\n");
 		return;
 	}
@@ -363,7 +363,7 @@ static struct gpio igep2_twl_gpios[] = {
 	{ -EINVAL, GPIOF_OUT_INIT_LOW,	"GPIO_USBH_CPEN" },
 };
 
-static int igep2_twl_gpio_setup(struct device *dev,
+static int igep_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	int ret;
@@ -392,23 +392,23 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	if (ret == 0)
 		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
 	else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
+		pr_warning("IGEP: Could not obtain gpio GPIO_LED1_GREEN\n");
 #else
-	igep2_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
+	igep_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
 #endif
 
 	return 0;
 };
 
-static struct twl4030_gpio_platform_data igep2_twl4030_gpio_pdata = {
+static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
-	.setup		= igep2_twl_gpio_setup,
+	.setup		= igep_twl_gpio_setup,
 };
 
-static struct twl4030_usb_data igep2_usb_data = {
+static struct twl4030_usb_data igep_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
@@ -476,11 +476,11 @@ static void __init igep2_display_init(void)
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
 
-static struct platform_device *igep2_devices[] __initdata = {
-	&igep2_vwlan_device,
+static struct platform_device *igep_devices[] __initdata = {
+	&igep_vwlan_device,
 };
 
-static void __init igep2_init_early(void)
+static void __init igep_init_early(void)
 {
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(m65kxxxxam_sdrc_params,
@@ -525,18 +525,18 @@ static struct twl4030_keypad_data igep2_keypad_pdata = {
 	.rep		= 1,
 };
 
-static struct twl4030_platform_data igep2_twldata = {
+static struct twl4030_platform_data igep_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
-	.usb		= &igep2_usb_data,
+	.usb		= &igep_usb_data,
 	.codec		= &igep2_codec_data,
-	.gpio		= &igep2_twl4030_gpio_pdata,
+	.gpio		= &igep_twl4030_gpio_pdata,
 	.keypad		= &igep2_keypad_pdata,
-	.vmmc1          = &igep2_vmmc1,
+	.vmmc1          = &igep_vmmc1,
 	.vpll2		= &igep2_vpll2,
-	.vio		= &igep2_vio,
+	.vio		= &igep_vio,
 };
 
 static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
@@ -545,11 +545,11 @@ static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
 	},
 };
 
-static void __init igep2_i2c_init(void)
+static void __init igep_i2c_init(void)
 {
 	int ret;
 
-	omap3_pmic_init("twl4030", &igep2_twldata);
+	omap3_pmic_init("twl4030", &igep_twldata);
 
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
@@ -561,7 +561,7 @@ static void __init igep2_i2c_init(void)
 		pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
 }
 
-static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+static const struct usbhs_omap_board_data igep2_usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -579,64 +579,64 @@ static struct omap_board_mux board_mux[] __initdata = {
 #endif
 
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
-static struct gpio igep2_wlan_bt_gpios[] __initdata = {
+static struct gpio igep_wlan_bt_gpios[] __initdata = {
 	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NPD"	   },
 	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NRESET" },
 	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_BT_NRESET"   },
 };
 
-static void __init igep2_wlan_bt_init(void)
+static void __init igep_wlan_bt_init(void)
 {
 	int err;
 
 	/* GPIO's for WLAN-BT combo depends on hardware revision */
 	if (hwrev == IGEP2_BOARD_HWREV_B) {
-		igep2_wlan_bt_gpios[0].gpio = IGEP2_RB_GPIO_WIFI_NPD;
-		igep2_wlan_bt_gpios[1].gpio = IGEP2_RB_GPIO_WIFI_NRESET;
-		igep2_wlan_bt_gpios[2].gpio = IGEP2_RB_GPIO_BT_NRESET;
+		igep_wlan_bt_gpios[0].gpio = IGEP2_RB_GPIO_WIFI_NPD;
+		igep_wlan_bt_gpios[1].gpio = IGEP2_RB_GPIO_WIFI_NRESET;
+		igep_wlan_bt_gpios[2].gpio = IGEP2_RB_GPIO_BT_NRESET;
 	} else if (hwrev == IGEP2_BOARD_HWREV_C) {
-		igep2_wlan_bt_gpios[0].gpio = IGEP2_RC_GPIO_WIFI_NPD;
-		igep2_wlan_bt_gpios[1].gpio = IGEP2_RC_GPIO_WIFI_NRESET;
-		igep2_wlan_bt_gpios[2].gpio = IGEP2_RC_GPIO_BT_NRESET;
+		igep_wlan_bt_gpios[0].gpio = IGEP2_RC_GPIO_WIFI_NPD;
+		igep_wlan_bt_gpios[1].gpio = IGEP2_RC_GPIO_WIFI_NRESET;
+		igep_wlan_bt_gpios[2].gpio = IGEP2_RC_GPIO_BT_NRESET;
 	} else
 		return;
 
-	err = gpio_request_array(igep2_wlan_bt_gpios,
-				 ARRAY_SIZE(igep2_wlan_bt_gpios));
+	err = gpio_request_array(igep_wlan_bt_gpios,
+				 ARRAY_SIZE(igep_wlan_bt_gpios));
 	if (err) {
 		pr_warning("IGEP2: Could not obtain WIFI/BT gpios\n");
 		return;
 	}
 
-	gpio_export(igep2_wlan_bt_gpios[0].gpio, 0);
-	gpio_export(igep2_wlan_bt_gpios[1].gpio, 0);
-	gpio_export(igep2_wlan_bt_gpios[2].gpio, 0);
+	gpio_export(igep_wlan_bt_gpios[0].gpio, 0);
+	gpio_export(igep_wlan_bt_gpios[1].gpio, 0);
+	gpio_export(igep_wlan_bt_gpios[2].gpio, 0);
 
-	gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 0);
+	gpio_set_value(igep_wlan_bt_gpios[1].gpio, 0);
 	udelay(10);
-	gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 1);
+	gpio_set_value(igep_wlan_bt_gpios[1].gpio, 1);
 
 }
 #else
-static inline void __init igep2_wlan_bt_init(void) { }
+static inline void __init igep_wlan_bt_init(void) { }
 #endif
 
-static void __init igep2_init(void)
+static void __init igep_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
 	igep2_get_revision();
 	/* Register I2C busses and drivers */
-	igep2_i2c_init();
-	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
+	igep_i2c_init();
+	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
 	omap_display_init(&igep2_dss_data);
 	omap_serial_init();
 	usb_musb_init(NULL);
-	usbhs_init(&usbhs_bdata);
+	usbhs_init(&igep2_usbhs_bdata);
 
-	igep2_flash_init();
-	igep2_leds_init();
+	igep_flash_init();
+	igep_leds_init();
 	igep2_display_init();
 	igep2_init_smsc911x();
 
@@ -644,7 +644,7 @@ static void __init igep2_init(void)
 	 * WLAN-BT combo module from MuRata which has a Marvell WLAN
 	 * (88W8686) + CSR Bluetooth chipset. Uses SDIO interface.
 	 */
-	igep2_wlan_bt_init();
+	igep_wlan_bt_init();
 
 }
 
@@ -652,8 +652,8 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= igep2_init_early,
+	.init_early	= igep_init_early,
 	.init_irq	= omap_init_irq,
-	.init_machine	= igep2_init,
+	.init_machine	= igep_init,
 	.timer		= &omap_timer,
 MACHINE_END
-- 
1.7.3.1

