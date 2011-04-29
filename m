From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Fri, 29 Apr 2011 15:47:44 +0300
Message-ID: <1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:19258 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab1D2Msq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 08:48:46 -0400
In-Reply-To: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: sakari.ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The vaux2 (VCSI) regulator is left on by the bootloader
in rx-51. Since there the product has shipped and there
won't be any bootloader updates to fix this issue, we
need to define all the regulators and declare full
constraints for the regulator FW. This will allow the
regulator FW to disable unused regulators.

Also this helps in adding more fine grain regulator
support for rx-51 in the future.

Thanks for Mark Brown for pointing out the correct
solution.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   75 ++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..8373b74 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -475,6 +475,34 @@ static struct regulator_init_data rx51_vmmc2 = {
 	.consumer_supplies	= rx51_vmmc2_supplies,
 };
 
+static struct regulator_init_data rx51_vpll1 = {
+	.constraints = {
+		.name			= "VPLL",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.always_on		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vpll2 = {
+	.constraints = {
+		.name			= "VSDI_CSI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.always_on		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct regulator_init_data rx51_vsim = {
 	.constraints = {
 		.name			= "VMMC2_IO_18",
@@ -519,6 +547,46 @@ static struct regulator_init_data rx51_vio = {
 	.consumer_supplies	= rx51_vio_supplies,
 };
 
+static struct regulator_init_data rx51_vintana1 = {
+	.constraints = {
+		.name			= "VINTANA1",
+		.min_uV			= 1500000,
+		.max_uV			= 1500000,
+		.always_on		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vintana2 = {
+	.constraints = {
+		.name			= "VINTANA2",
+		.min_uV			= 2750000,
+		.max_uV			= 2750000,
+		.apply_uV		= true,
+		.always_on		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vintdig = {
+	.constraints = {
+		.name			= "VINTDIG",
+		.min_uV			= 1500000,
+		.max_uV			= 1500000,
+		.always_on		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct si4713_platform_data rx51_si4713_i2c_data __initdata_or_module = {
 	.gpio_reset	= RX51_FMTX_RESET_GPIO,
 };
@@ -767,8 +835,13 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vaux2			= &rx51_vaux2,
 	.vaux4			= &rx51_vaux4,
 	.vmmc1			= &rx51_vmmc1,
+	.vpll1			= &rx51_vpll1,
+	.vpll2			= &rx51_vpll2,
 	.vsim			= &rx51_vsim,
 	.vdac			= &rx51_vdac,
+	.vintana1		= &rx51_vintana1,
+	.vintana2		= &rx51_vintana2,
+	.vintdig		= &rx51_vintdig,
 	.vio			= &rx51_vio,
 };
 
@@ -838,6 +911,8 @@ static int __init rx51_i2c_init(void)
 	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
 			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 	omap_register_i2c_bus(3, 400, NULL, 0);
+	regulator_has_full_constraints();
+
 	return 0;
 }
 
-- 
1.7.1

