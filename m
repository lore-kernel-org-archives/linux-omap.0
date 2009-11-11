From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3 2/8] omap: zoom: rename zoom2 name to generic zoom
Date: Wed, 11 Nov 2009 17:41:30 -0600
Message-ID: <1257982896-25087-3-git-send-email-vikram.pandita@ti.com>
References: <1257982896-25087-1-git-send-email-vikram.pandita@ti.com>
 <1257982896-25087-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59449 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759631AbZKKXmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:42:07 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABNgDuk012367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 17:42:13 -0600
In-Reply-To: <1257982896-25087-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Replace zoom2 with zoom name in board-zoom-peripherals.c file
This file has functions reused for boards: Zoom2/Zoom3/sdp3630.
Hence have all functions commonly named as zoom

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   70 +++++++++++++-------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 1bb4a8a..4ca9c20 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -87,27 +87,27 @@ static struct matrix_keymap_data board_map_data = {
 	.keymap_size		= ARRAY_SIZE(board_keymap),
 };
 
-static struct twl4030_keypad_data zoom2_kp_twl4030_data = {
+static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.keymap_data	= &board_map_data,
 	.rows		= 8,
 	.cols		= 8,
 	.rep		= 1,
 };
 
-static struct regulator_consumer_supply zoom2_vmmc1_supply = {
+static struct regulator_consumer_supply zoom_vmmc1_supply = {
 	.supply		= "vmmc",
 };
 
-static struct regulator_consumer_supply zoom2_vsim_supply = {
+static struct regulator_consumer_supply zoom_vsim_supply = {
 	.supply		= "vmmc_aux",
 };
 
-static struct regulator_consumer_supply zoom2_vmmc2_supply = {
+static struct regulator_consumer_supply zoom_vmmc2_supply = {
 	.supply		= "vmmc",
 };
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data zoom2_vmmc1 = {
+static struct regulator_init_data zoom_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
@@ -118,11 +118,11 @@ static struct regulator_init_data zoom2_vmmc1 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vmmc1_supply,
+	.consumer_supplies      = &zoom_vmmc1_supply,
 };
 
 /* VMMC2 for MMC2 card */
-static struct regulator_init_data zoom2_vmmc2 = {
+static struct regulator_init_data zoom_vmmc2 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 1850000,
@@ -133,11 +133,11 @@ static struct regulator_init_data zoom2_vmmc2 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vmmc2_supply,
+	.consumer_supplies      = &zoom_vmmc2_supply,
 };
 
 /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data zoom2_vsim = {
+static struct regulator_init_data zoom_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
@@ -148,7 +148,7 @@ static struct regulator_init_data zoom2_vsim = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vsim_supply,
+	.consumer_supplies      = &zoom_vsim_supply,
 };
 
 static struct twl4030_hsmmc_info mmc[] __initdata = {
@@ -165,7 +165,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{}      /* Terminator */
 };
 
-static int zoom2_twl_gpio_setup(struct device *dev,
+static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ),
@@ -178,15 +178,15 @@ static int zoom2_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	zoom2_vmmc1_supply.dev = mmc[0].dev;
-	zoom2_vsim_supply.dev = mmc[0].dev;
-	zoom2_vmmc2_supply.dev = mmc[1].dev;
+	zoom_vmmc1_supply.dev = mmc[0].dev;
+	zoom_vsim_supply.dev = mmc[0].dev;
+	zoom_vmmc2_supply.dev = mmc[1].dev;
 
 	return 0;
 }
 
 
-static int zoom2_batt_table[] = {
+static int zoom_batt_table[] = {
 /* 0 C*/
 30800, 29500, 28300, 27100,
 26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
@@ -197,55 +197,55 @@ static int zoom2_batt_table[] = {
 4040,  3910,  3790,  3670,  3550
 };
 
-static struct twl4030_bci_platform_data zoom2_bci_data = {
-	.battery_tmp_tbl	= zoom2_batt_table,
-	.tblsize		= ARRAY_SIZE(zoom2_batt_table),
+static struct twl4030_bci_platform_data zoom_bci_data = {
+	.battery_tmp_tbl	= zoom_batt_table,
+	.tblsize		= ARRAY_SIZE(zoom_batt_table),
 };
 
-static struct twl4030_usb_data zoom2_usb_data = {
+static struct twl4030_usb_data zoom_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_gpio_platform_data zoom2_gpio_data = {
+static struct twl4030_gpio_platform_data zoom_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
-	.setup		= zoom2_twl_gpio_setup,
+	.setup		= zoom_twl_gpio_setup,
 };
 
-static struct twl4030_madc_platform_data zoom2_madc_data = {
+static struct twl4030_madc_platform_data zoom_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_platform_data zoom2_twldata = {
+static struct twl4030_platform_data zoom_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
-	.bci		= &zoom2_bci_data,
-	.madc		= &zoom2_madc_data,
-	.usb		= &zoom2_usb_data,
-	.gpio		= &zoom2_gpio_data,
-	.keypad		= &zoom2_kp_twl4030_data,
-	.vmmc1          = &zoom2_vmmc1,
-	.vmmc2          = &zoom2_vmmc2,
-	.vsim           = &zoom2_vsim,
+	.bci		= &zoom_bci_data,
+	.madc		= &zoom_madc_data,
+	.usb		= &zoom_usb_data,
+	.gpio		= &zoom_gpio_data,
+	.keypad		= &zoom_kp_twl4030_data,
+	.vmmc1          = &zoom_vmmc1,
+	.vmmc2          = &zoom_vmmc2,
+	.vsim           = &zoom_vsim,
 
 };
 
-static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
 		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &zoom2_twldata,
+		.platform_data	= &zoom_twldata,
 	},
 };
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
-			ARRAY_SIZE(zoom2_i2c_boardinfo));
+	omap_register_i2c_bus(1, 2600, zoom_i2c_boardinfo,
+			ARRAY_SIZE(zoom_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
-- 
1.6.5.1.69.g36942

