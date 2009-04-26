From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP: pandora: setup regulator framework for MMC
Date: Sun, 26 Apr 2009 23:45:19 +0300
Message-ID: <1240778719-26353-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:16311 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbZDZUp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 16:45:26 -0400
Received: by mu-out-0910.google.com with SMTP id i2so586756mue.1
        for <linux-omap@vger.kernel.org>; Sun, 26 Apr 2009 13:45:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>

Setup regulators for MMC1 and MMC2 to get those SD slots
working again.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
CC: David Brownell <david-b@pacbell.net>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   45 ++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index c67f62f..c525b16 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -27,6 +27,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
 
 #include <linux/mtd/mtd.h>
@@ -171,6 +172,14 @@ static struct omap_uart_config omap3pandora_uart_config __initdata = {
 	.enabled_uarts	= (1 << 2), /* UART3 */
 };
 
+static struct regulator_consumer_supply pandora_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply pandora_vmmc2_supply = {
+	.supply			= "vmmc",
+};
+
 static int omap3pandora_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -179,6 +188,10 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	twl4030_mmc_init(omap3pandora_mmc);
 
+	/* link regulators to MMC adapters */
+	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
+	pandora_vmmc2_supply.dev = omap3pandora_mmc[1].dev;
+
 	return 0;
 }
 
@@ -189,6 +202,36 @@ static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.setup		= omap3pandora_twl_gpio_setup,
 };
 
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data pandora_vmmc1 = {
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
+	.consumer_supplies	= &pandora_vmmc1_supply,
+};
+
+/* VMMC2 for MMC2 pins CMD, CLK, DAT0..DAT3 (max 100 mA) */
+static struct regulator_init_data pandora_vmmc2 = {
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
+	.consumer_supplies	= &pandora_vmmc2_supply,
+};
+
 static struct twl4030_usb_data omap3pandora_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -198,6 +241,8 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &omap3pandora_gpio_data,
 	.usb		= &omap3pandora_usb_data,
+	.vmmc1		= &pandora_vmmc1,
+	.vmmc2		= &pandora_vmmc2,
 };
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
-- 
1.5.6.3

