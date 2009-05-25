From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] ARM: OMAP3: Initialize regulators for Beagle and Overo
Date: Mon, 25 May 2009 10:49:38 -0700
Message-ID: <20090525174938.19679.51804.stgit@localhost>
References: <20090525174517.19679.18805.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64381 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZEYRtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:49:47 -0400
In-Reply-To: <20090525174517.19679.18805.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Initialize regulators for Beagle and Overo.

Patch is based on earlier patches posted to linux-omap mailing
list.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |  104 ++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/board-overo.c       |   76 +++++++++++++++++------
 2 files changed, 152 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f25082c..991ac9c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -28,6 +28,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 
+#include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
 
 #include <mach/hardware.h>
@@ -120,6 +121,23 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+static struct platform_device omap3_beagle_lcd_device = {
+	.name		= "omap3beagle_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct regulator_consumer_supply beagle_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply beagle_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
 static struct gpio_led gpio_leds[];
 
 static int beagle_twl_gpio_setup(struct device *dev,
@@ -130,6 +148,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
+	/* link regulators to MMC adapters */
+	beagle_vmmc1_supply.dev = mmc[0].dev;
+	beagle_vsim_supply.dev = mmc[0].dev;
+
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
@@ -158,12 +180,85 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.setup		= beagle_twl_gpio_setup,
 };
 
+static struct regulator_consumer_supply beagle_vdac_supply = {
+	.supply		= "vdac",
+	.dev		= &omap3_beagle_lcd_device.dev,
+};
+
+static struct regulator_consumer_supply beagle_vdvi_supply = {
+	.supply		= "vdvi",
+	.dev		= &omap3_beagle_lcd_device.dev,
+};
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data beagle_vmmc1 = {
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
+	.consumer_supplies	= &beagle_vmmc1_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data beagle_vsim = {
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
+	.consumer_supplies	= &beagle_vsim_supply,
+};
+
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data beagle_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data beagle_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &beagle_vdvi_supply,
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &beagle_gpio_data,
+	.vmmc1		= &beagle_vmmc1,
+	.vsim		= &beagle_vsim,
+	.vdac		= &beagle_vdac,
+	.vpll2		= &beagle_vpll2,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
@@ -195,15 +290,6 @@ static void __init omap3_beagle_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct platform_device omap3_beagle_lcd_device = {
-	.name		= "omap3beagle_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "beagleboard::usr0",
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c7443ff..dff5528 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/machine.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -272,21 +273,76 @@ static struct omap_uart_config overo_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+		.transceiver	= true,
+		.ocr_mask	= 0x00100000,	/* 3.3V */
+	},
+	{}	/* Terminator */
+};
+
+static struct regulator_consumer_supply overo_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static int overo_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	twl4030_mmc_init(mmc);
+
+	overo_vmmc1_supply.dev = mmc[0].dev;
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= overo_twl_gpio_setup,
+};
+
+static struct twl4030_usb_data overo_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
+static struct regulator_init_data overo_vmmc1 = {
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
+	.consumer_supplies	= &overo_vmmc1_supply,
 };
 
+/* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
+	.usb		= &overo_usb_data,
+	.vmmc1		= &overo_vmmc1,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &overo_twldata,
@@ -327,23 +383,6 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{
-		.mmc		= 2,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-		.transceiver	= true,
-	},
-	{}	/* Terminator */
-};
-
 static void __init overo_init(void)
 {
 	overo_i2c_init();
@@ -351,7 +390,6 @@ static void __init overo_init(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
 	overo_flash_init();
 	usb_musb_init();
 	overo_ads7846_init();

