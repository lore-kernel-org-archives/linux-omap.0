From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] ARM: OMAP3: evm: initialize vmmc and vmmc_aux regulators
Date: Mon,  7 Sep 2009 10:56:35 +0300
Message-ID: <1252310195-16101-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:41599 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbZIGH6X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Sep 2009 03:58:23 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1MkZ7J-0004sM-Qs
	for linux-omap@vger.kernel.org; Mon, 07 Sep 2009 02:58:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id D788F9A034E
	for <linux-omap@vger.kernel.org>; Mon,  7 Sep 2009 10:58:24 +0300 (IDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-omap3evm.c |   46 ++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 35f6075..ce755c3 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,6 +27,8 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
 
+#include <linux/regulator/machine.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -92,6 +94,44 @@ static inline void __init omap3evm_init_smc911x(void)
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
@@ -134,6 +174,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
+	/* link regulators to MMC adapters */
+	omap3evm_vmmc1_supply.dev = mmc[0].dev;
+	omap3evm_vsim_supply.dev = mmc[0].dev;
+
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
@@ -199,6 +243,8 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
+	.vmmc1		= &omap3evm_vmmc1,
+	.vsim		= &omap3evm_vsim,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
-- 
1.6.0.6

