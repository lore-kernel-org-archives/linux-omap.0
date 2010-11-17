From: Marc Zyngier <maz@misterjones.org>
Subject: [PATCH v2] Fix IGEPv2 second MMC channel power supply
Date: Wed, 17 Nov 2010 19:08:59 +0000
Message-ID: <1290020939-408-1-git-send-email-maz@misterjones.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:42251 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758321Ab0KQTJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 14:09:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

Commit 72f381ba056 (omap3: Remove VMMC2 regulator on IGEP v2)
removed an unused regulator entry, but left the second MMC channel
(used by the Libertas WLAN module) without link to power regulator.
This causes the SDIO module to fail being detected.

This patch adds the two regulators that actually feed the WLAN module
(1v8 from the TWL4030 VIO LDO, and a fixed 3v3). With that patch, the
second channel is properly detected. Details of the power supply
implementation were kindly provided by Enric Balletbo i Serra.

Also change vmmc1 to use symbolic names instead of direct device
reference.

Tested on an IGEPv2 Rev-B.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   61 ++++++++++++++++++++++++++++-----
 1 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..9a85e60 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
 
@@ -257,9 +258,8 @@ static inline void __init igep2_init_smsc911x(void) { }
 static struct omap_board_config_kernel igep2_config[] __initdata = {
 };
 
-static struct regulator_consumer_supply igep2_vmmc1_supply = {
-	.supply		= "vmmc",
-};
+static struct regulator_consumer_supply igep2_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep2_vmmc1 = {
@@ -276,6 +276,52 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
+static struct regulator_consumer_supply igep2_vio_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
+
+static struct regulator_init_data igep2_vio = {
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
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &igep2_vio_supply,
+};
+
+static struct regulator_consumer_supply igep2_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+
+static struct regulator_init_data igep2_vmmc2 = {
+	.constraints		= {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.always_on		= 1,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &igep2_vmmc2_supply,
+};
+
+static struct fixed_voltage_config igep2_vwlan = {
+	.supply_name		= "vwlan",
+	.microvolts		= 3300000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &igep2_vmmc2,
+};
+
+static struct platform_device igep2_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &igep2_vwlan,
+	},
+};
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -373,12 +419,6 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	omap2_hsmmc_init(mmc);
 
 	/*
-	 * link regulators to MMC adapters ... we "know" the
-	 * regulators will be set up only *after* we return.
-	 */
-	igep2_vmmc1_supply.dev = mmc[0].dev;
-
-	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
@@ -489,6 +529,7 @@ static void __init igep2_display_init(void)
 
 static struct platform_device *igep2_devices[] __initdata = {
 	&igep2_dss_device,
+	&igep2_vwlan_device,
 };
 
 static void __init igep2_init_irq(void)
@@ -519,7 +560,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	.gpio		= &igep2_twl4030_gpio_pdata,
 	.vmmc1          = &igep2_vmmc1,
 	.vpll2		= &igep2_vpll2,
-
+	.vio		= &igep2_vio,
 };
 
 static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
-- 
1.7.3.2

