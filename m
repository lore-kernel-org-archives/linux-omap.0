From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/4] Regulator: Modifying board-3430sdp.c to use PMIC-init-macros or wrappers
Date: Wed, 11 Nov 2009 20:14:55 +0530
Message-ID: <1257950695-32526-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45268 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756228AbZKKOo4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 09:44:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Modified board-3430sdp.c to use PMIC initialization macros / wrappers
for TWL4030 regulator.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |  196 +++++++++--------------------------
 1 files changed, 51 insertions(+), 145 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a3c1271..d87e50d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -44,6 +44,8 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 
+#include "board-omap35x-pmic.h"
+
 #define CONFIG_DISABLE_HFCLK 1
 
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
@@ -157,15 +159,10 @@ static struct platform_device sdp3430_lcd_device = {
 	.id		= -1,
 };
 
-static struct regulator_consumer_supply sdp3430_vdac_supply = {
-	.supply		= "vdac",
-	.dev		= &sdp3430_lcd_device.dev,
-};
-
-static struct regulator_consumer_supply sdp3430_vdvi_supply = {
-	.supply		= "vdvi",
-	.dev		= &sdp3430_lcd_device.dev,
-};
+/* Create a single supply for VDAC */
+REGULATOR_CONSUMER_SINGLE_SUPPLY(vdac, vdac, &sdp3430_lcd_device.dev);
+/* Create a single supply for VDAC */
+REGULATOR_CONSUMER_SINGLE_SUPPLY(vpll2, vdvi, &sdp3430_lcd_device.dev);
 
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_lcd_device,
@@ -221,17 +218,12 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp3430_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply sdp3430_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-static struct regulator_consumer_supply sdp3430_vmmc2_supply = {
-	.supply			= "vmmc",
-};
+/* Create default supply for VMMC1 */
+TWL_VMMC1_SUPPLY;
+/* Create default supply for VSIM */
+TWL_VSIM_SUPPLY;
+/* Create default supply for VMMC2 */
+TWL_VMMC2_SUPPLY;
 
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
@@ -246,9 +238,9 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	 */
-	sdp3430_vmmc1_supply.dev = mmc[0].dev;
-	sdp3430_vsim_supply.dev = mmc[0].dev;
-	sdp3430_vmmc2_supply.dev = mmc[1].dev;
+	vmmc1_consumers[0].dev = mmc[0].dev;
+	vsim_consumers[0].dev = mmc[0].dev;
+	vmmc2_consumers[0].dev = mmc[1].dev;
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request(gpio + 7, "sub_lcd_en_bkl");
@@ -282,133 +274,45 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
  * Apply all the fixed voltages since most versions of U-Boot
  * don't bother with that initialization.
  */
-
+/* VAUX1 doesn't supply to anyone */
+REGULATOR_CONSUMER_NO_SUPPLY(vaux1);
+/* VAUX2 doesn't supply to anyone */
+REGULATOR_CONSUMER_NO_SUPPLY(vaux2);
+/* VAUX3 doesn't supply to anyone */
+REGULATOR_CONSUMER_NO_SUPPLY(vaux3);
+/* VAUX4 doesn't supply to anyone */
+REGULATOR_CONSUMER_NO_SUPPLY(vaux4);
+
+/* Create regulator initialization data for various regulators */
 /* VAUX1 for mainboard (irda and sub-lcd) */
-static struct regulator_init_data sdp3430_vaux1 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
+TWL_VAUX1_DATA;
 /* VAUX2 for camera module */
-static struct regulator_init_data sdp3430_vaux2 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
+TWL_VAUX2_DATA;
 /* VAUX3 for LCD board */
-static struct regulator_init_data sdp3430_vaux3 = {
-	.constraints = {
-		.min_uV			= 2800000,
-		.max_uV			= 2800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
+TWL_VAUX3_DATA;
 /* VAUX4 for OMAP VDD_CSI2 (camera) */
-static struct regulator_init_data sdp3430_vaux4 = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
+TWL_VAUX4_DATA;
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data sdp3430_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vmmc1_supply,
-};
+REGULATOR_INIT_DATA(vmmc1, VMMC1, 1850000, 3150000,
+		TWL_REGULATOR_MODES_DEFAULT,
+		TWL_REGULATOR_OPS_DEFAULT | REGULATOR_CHANGE_VOLTAGE,
+		false);
 
 /* VMMC2 for MMC2 card */
-static struct regulator_init_data sdp3430_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 1850000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vmmc2_supply,
-};
+TWL_VMMC2_DATA;
 
 /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data sdp3430_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vsim_supply,
-};
+REGULATOR_INIT_DATA(vsim, VSIM, 1800000, 3000000,
+		TWL_REGULATOR_MODES_DEFAULT,
+		TWL_REGULATOR_OPS_DEFAULT | REGULATOR_CHANGE_VOLTAGE,
+		false);
 
 /* VDAC for DSS driving S-Video */
-static struct regulator_init_data sdp3430_vdac = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vdac_supply,
-};
+TWL_VDAC_DATA;
 
 /* VPLL2 for digital video outputs */
-static struct regulator_init_data sdp3430_vpll2 = {
-	.constraints = {
-		.name			= "VDVI",
-		.min_uV			= 1800000,
-		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &sdp3430_vdvi_supply,
-};
+TWL_VPLL2_DATA;
 
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
@@ -421,15 +325,15 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.keypad		= &sdp3430_kp_data,
 	.usb		= &sdp3430_usb_data,
 
-	.vaux1		= &sdp3430_vaux1,
-	.vaux2		= &sdp3430_vaux2,
-	.vaux3		= &sdp3430_vaux3,
-	.vaux4		= &sdp3430_vaux4,
-	.vmmc1		= &sdp3430_vmmc1,
-	.vmmc2		= &sdp3430_vmmc2,
-	.vsim		= &sdp3430_vsim,
-	.vdac		= &sdp3430_vdac,
-	.vpll2		= &sdp3430_vpll2,
+	.vaux1		= &vaux1_data[0],
+	.vaux2		= &vaux2_data[0],
+	.vaux3		= &vaux3_data[0],
+	.vaux4		= &vaux4_data[0],
+	.vmmc1		= &vmmc1_data[0],
+	.vmmc2		= &vmmc2_data[0],
+	.vsim		= &vsim_data[0],
+	.vdac		= &vdac_data[0],
+	.vpll2		= &vpll2_data[0],
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
@@ -499,6 +403,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
+	regulator_has_full_constraints();
+
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
-- 
1.6.2.4

