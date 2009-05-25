From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: OMAP3: pandora: setup regulator framework for MMC
Date: Mon, 25 May 2009 10:51:02 -0700
Message-ID: <20090525175102.19679.9018.stgit@localhost>
References: <20090525174517.19679.18805.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51192 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbZEYRvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:51:01 -0400
In-Reply-To: <20090525174517.19679.18805.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

Setup regulators for MMC1 and MMC2 to get those SD slots
working again.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
CC: David Brownell <david-b@pacbell.net>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   45 ++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 3571bb4..2ab2497 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -23,6 +23,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
 
 #include <asm/mach-types.h>
@@ -70,6 +71,14 @@ static struct omap_uart_config omap3pandora_uart_config __initdata = {
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
@@ -78,6 +87,10 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	twl4030_mmc_init(omap3pandora_mmc);
 
+	/* link regulators to MMC adapters */
+	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
+	pandora_vmmc2_supply.dev = omap3pandora_mmc[1].dev;
+
 	return 0;
 }
 
@@ -88,6 +101,36 @@ static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
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
@@ -97,6 +140,8 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &omap3pandora_gpio_data,
 	.usb		= &omap3pandora_usb_data,
+	.vmmc1		= &pandora_vmmc1,
+	.vmmc2		= &pandora_vmmc2,
 };
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {

