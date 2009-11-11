From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/4] Regulator: Modifying board-omap3evm.c to use PMIC-init-macros or wrappers
Date: Wed, 11 Nov 2009 20:14:47 +0530
Message-ID: <1257950687-32488-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45252 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbZKKOos (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 09:44:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Modified board-omap3evm.c to use PMIC initialization macros / wrappers
for TWL4030 regulators.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   82 ++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b0f4c..4df83c6 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -44,6 +44,8 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
+#include "board-omap35x-pmic.h"
+
 #define OMAP3_EVM_TS_GPIO	175
 
 #define OMAP3EVM_ETHR_START	0x2c000000
@@ -94,43 +96,10 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
-static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply omap3evm_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data omap3evm_vmmc1 = {
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
-	.consumer_supplies	= &omap3evm_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data omap3evm_vsim = {
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
-	.consumer_supplies	= &omap3evm_vsim_supply,
-};
+/* Create default supply for VMMC1 */
+TWL_VMMC1_SUPPLY;
+/* Create default supply for VSIM */
+TWL_VSIM_SUPPLY;
 
 static struct twl4030_hsmmc_info mmc[] = {
 	{
@@ -165,7 +134,6 @@ static struct platform_device leds_gpio = {
 	},
 };
 
-
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -175,8 +143,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	omap3evm_vmmc1_supply.dev = mmc[0].dev;
-	omap3evm_vsim_supply.dev = mmc[0].dev;
+	vmmc1_consumers[0].dev = mmc[0].dev;
+	vsim_consumers[0].dev = mmc[0].dev;
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
@@ -238,6 +206,32 @@ static struct twl4030_madc_platform_data omap3evm_madc_data = {
 	.irq_line	= 1,
 };
 
+/* Create init data for VMMC1 */
+REGULATOR_INIT_DATA(vmmc1, VMMC1, 1850000, 3150000,
+		TWL_REGULATOR_MODES_DEFAULT,
+		TWL_REGULATOR_OPS_DEFAULT | REGULATOR_CHANGE_VOLTAGE,
+		false);
+
+/* Create init data for VSIM */
+REGULATOR_INIT_DATA(vsim, VSIM, 1800000, 3000000,
+		TWL_REGULATOR_MODES_DEFAULT,
+		TWL_REGULATOR_OPS_DEFAULT | REGULATOR_CHANGE_VOLTAGE,
+		false);
+
+/* Create default supply for VDAC */
+TWL_VDAC_SUPPLY;
+/* Create default supply for VPLL2 */
+TWL_VPLL2_SUPPLY;
+
+/* Create init data for VDAC */
+TWL_VDAC_DATA;
+
+/* Create init data for VPLL2 */
+REGULATOR_INIT_DATA(vpll2, VDVI, 1800000, 1800000,
+		TWL_REGULATOR_MODES_DEFAULT,
+		TWL_REGULATOR_OPS_DEFAULT,
+		true);
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -247,8 +241,10 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
-	.vmmc1		= &omap3evm_vmmc1,
-	.vsim		= &omap3evm_vsim,
+	.vmmc1		= &vmmc1_data[0],
+	.vsim		= &vsim_data[0],
+	.vdac		= &vdac_data[0],
+	.vpll2		= &vpll2_data[0],
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
@@ -359,6 +355,8 @@ static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
 
+	regulator_has_full_constraints();
+
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
 
 	spi_register_board_info(omap3evm_spi_board_info,
-- 
1.6.2.4

