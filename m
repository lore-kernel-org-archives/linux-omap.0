From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] omap3evm: Initialize vmmc and vmmc_aux regulators
Date: Mon, 16 Nov 2009 15:27:57 -0800
Message-ID: <20091116232757.24892.39771.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58513 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbZKPX1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:27:53 -0500
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

From: Mike Rapoport <mike@compulab.co.il>

Initialize vmmc and vmmc_aux regulators

Note that the omap3evm_twldata.vmmc1 and omap3evm_twldata.vsim
are set in omap3_evm_i2c_init() to avoid a merge conflict
with the MFD tree. These will be initialized in omap3evm_i2c_boardinfo
as a fix later on.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   51 ++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 64c1ae0..148de2e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -28,6 +28,8 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
 
+#include <linux/regulator/machine.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -125,6 +127,44 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
+static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply omap3evm_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data omap3evm_vmmc1 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3evm_vmmc1_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data omap3evm_vsim = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3evm_vsim_supply,
+};
+
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -167,6 +207,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
+	/* link regulators to MMC adapters */
+	omap3evm_vmmc1_supply.dev = mmc[0].dev;
+	omap3evm_vsim_supply.dev = mmc[0].dev;
+
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
@@ -259,6 +303,13 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 
 static int __init omap3_evm_i2c_init(void)
 {
+	/*
+	 * REVISIT: These entries can be set in omap3evm_twl_data
+	 * after a merge with MFD tree
+	 */
+	omap3evm_twldata.vmmc1 = &omap3evm_vmmc1;
+	omap3evm_twldata.vsim = &omap3evm_vsim;
+
 	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);

