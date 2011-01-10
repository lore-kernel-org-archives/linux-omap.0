From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/3] omap3: igep3: Fix IGEP module second MMC channel power supply.
Date: Mon, 10 Jan 2011 14:26:13 +0100
Message-ID: <1294665974-10590-3-git-send-email-eballetbo@gmail.com>
References: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58293 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab1AJN02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 08:26:28 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so19431115wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:26:28 -0800 (PST)
In-Reply-To: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

The second MMC channel (used by the WLAN/BT module) is not linked to
power regulator. This causes the WLAN/BT module to fail being detected if
CONFIG_REGULATOR_DUMMY is not set.

This patch adds the two regulators that actually feed the WLAN/BT module
(1v8 from the TWL4030 VIO LDO, and a fixed 3v3). With that patch, the
second channel is properly detected.

Also change vmmc1 to use symbolic names instead of direct device
reference.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0030.c |   65 ++++++++++++++++++++++++++++-----
 1 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index f0a85c1..8ddd45c 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
 
@@ -140,9 +141,8 @@ static void __init igep3_flash_init(void)
 static void __init igep3_flash_init(void) {}
 #endif
 
-static struct regulator_consumer_supply igep3_vmmc1_supply = {
-	.supply		= "vmmc",
-};
+static struct regulator_consumer_supply igep3_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep3_vmmc1 = {
@@ -159,6 +159,52 @@ static struct regulator_init_data igep3_vmmc1 = {
 	.consumer_supplies      = &igep3_vmmc1_supply,
 };
 
+static struct regulator_consumer_supply igep3_vio_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
+
+static struct regulator_init_data igep3_vio = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= 1,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &igep3_vio_supply,
+};
+
+static struct regulator_consumer_supply igep3_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+
+static struct regulator_init_data igep3_vmmc2 = {
+	.constraints	= {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.always_on		= 1,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &igep3_vmmc2_supply,
+};
+
+static struct fixed_voltage_config igep3_vwlan = {
+	.supply_name		= "vwlan",
+	.microvolts		= 3300000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &igep3_vmmc2,
+};
+
+static struct platform_device igep3_vwlan_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &igep3_vwlan,
+	},
+};
+
 static struct omap2_hsmmc_info mmc[] = {
 	[0] = {
 		.mmc		= 1,
@@ -254,12 +300,6 @@ static int igep3_twl4030_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/*
-	 * link regulators to MMC adapters ... we "know" the
-	 * regulators will be set up only *after* we return.
-	 */
-	igep3_vmmc1_supply.dev = mmc[0].dev;
-
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
 	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
@@ -287,6 +327,10 @@ static struct twl4030_usb_data igep3_twl4030_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct platform_device *igep3_devices[] __initdata = {
+	&igep3_vwlan_device,
+};
+
 static void __init igep3_init_irq(void)
 {
 	omap2_init_common_infrastructure();
@@ -303,6 +347,7 @@ static struct twl4030_platform_data igep3_twl4030_pdata = {
 	.usb		= &igep3_twl4030_usb_data,
 	.gpio		= &igep3_twl4030_gpio_pdata,
 	.vmmc1		= &igep3_vmmc1,
+	.vio		= &igep3_vio,
 };
 
 static struct i2c_board_info __initdata igep3_i2c_boardinfo[] = {
@@ -387,7 +432,7 @@ static void __init igep3_init(void)
 
 	/* Register I2C busses and drivers */
 	igep3_i2c_init();
-
+	platform_add_devices(igep3_devices, ARRAY_SIZE(igep3_devices));
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
-- 
1.7.0.4

