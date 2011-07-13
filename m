From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 3/5] omap3: beagle: instantiate smps regulators
Date: Wed, 13 Jul 2011 17:00:36 +0300
Message-ID: <1310565638-13140-4-git-send-email-t-kristo@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab1GMOCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 10:02:33 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

VDD1 and VDD2 are now available. This requires SMPS regulator driver to work.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   53 +++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 78cf5f2..d7ae648 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/host.h>
 
 #include <linux/regulator/machine.h>
+#include <linux/regulator/omap-smps.h>
 #include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
@@ -274,6 +275,15 @@ static struct regulator_consumer_supply beagle_vsim_supply[] = {
 	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
 };
 
+static struct regulator_consumer_supply beagle_smps1_supply[] = {
+	REGULATOR_SUPPLY("vcc", "mpu"),
+};
+
+static struct regulator_consumer_supply beagle_smps2_supply[] = {
+	REGULATOR_SUPPLY("vcc", "core"),
+};
+
+
 static struct gpio_led gpio_leds[];
 
 static int beagle_twl_gpio_setup(struct device *dev,
@@ -400,6 +410,30 @@ static struct regulator_init_data beagle_vpll2 = {
 	.consumer_supplies	= beagle_vdvi_supplies,
 };
 
+static struct regulator_init_data beagle_smps1 = {
+	.constraints = {
+		.name			= "VDD1",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(beagle_smps1_supply),
+	.consumer_supplies	= beagle_smps1_supply,
+};
+
+static struct regulator_init_data beagle_smps2 = {
+	.constraints = {
+		.name			= "VDD2",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(beagle_smps2_supply),
+	.consumer_supplies	= beagle_smps2_supply,
+};
+
 static struct twl4030_usb_data beagle_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -425,6 +459,16 @@ static struct twl4030_platform_data beagle_twldata = {
 	.vpll2		= &beagle_vpll2,
 };
 
+static struct regulator_init_data *beagle_smps_reg_list[] = {
+	&beagle_smps1,
+	&beagle_smps2,
+};
+
+static struct omap_smps_platform_data beagle_smps_info = {
+	.regulators 		= beagle_smps_reg_list,
+	.num_regulators		= ARRAY_SIZE(beagle_smps_reg_list),
+};
+
 static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
        {
                I2C_BOARD_INFO("eeprom", 0x50),
@@ -494,6 +538,14 @@ static struct platform_device keys_gpio = {
 	},
 };
 
+static struct platform_device beagle_smps = {
+	.name	= "omap-smps",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &beagle_smps_info,
+	},
+};
+
 static void __init omap3_beagle_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -509,6 +561,7 @@ static void __init omap3_beagle_init_irq(void)
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
+	&beagle_smps,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

