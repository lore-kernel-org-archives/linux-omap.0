From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 2/2] Adding and building TPS6235x based PR785 board support
Date: Fri, 30 Jan 2009 14:53:10 +0530
Message-ID: <1233307390-14974-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52351 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbZA3JXg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2009 04:23:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@sirena.org.uk, linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

Change in this patch include
comments fix from David Brownell and Mark

TPS6235x chip based PR785 power modules are from Texas Instruments
for OMAP3 EVM boards. This patch supports the PR785 card
and provides the driver support for the TPS devices.

For compilation, the LCD and MMC drivers are modified and will not
work. Further patches will be provided for support of LCD and MMC
with PR785 boards.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/Kconfig            |   11 ++++
 arch/arm/mach-omap2/board-omap3evm.c   |   81 +++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.c      |    4 +-
 arch/arm/plat-omap/i2c.c               |   69 ++++++++++++++++++++++++++-
 drivers/regulator/Makefile             |    1 +
 drivers/regulator/tps6235x-regulator.c |   10 ++--
 drivers/video/omap/lcd_omap3evm.c      |    6 ++
 7 files changed, 174 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0a86a88..91890be 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -121,6 +121,17 @@ config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+menu 	"PR785 Power board selection for OMAP3 EVM"
+config OMAP3EVM_PR785
+	bool "Power board for OMAP3 EVM"
+	depends on I2C=y && ARCH_OMAP34XX
+	help
+	Say yes here if you are using the TPS6235x based PR785 Power Module
+	for the EVM boards. This core driver provides register access and IRQ
+	handling facilities, and registers devices for the various functions
+	so that function-specific drivers can bind to them.
+endmenu
+
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e4e60e2..49f8ac2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -36,12 +36,16 @@
 #include <mach/usb-ehci.h>
 #include <mach/common.h>
 #include <mach/mcspi.h>
+#include <mach/mux.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "twl4030-generic-scripts.h"
 #include "mmc-twl4030.h"
+#include <linux/regulator/machine.h>
 
-
+#if defined(CONFIG_OMAP3EVM_PR785) && defined(CONFIG_TWL4030_CORE)
+#error config err : only one of OMAP3EVM_PR785 or TWL4030_CORE can be defined
+#endif
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start  = OMAP3EVM_ETHR_START,
@@ -89,6 +93,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+#if defined(CONFIG_TWL4030_CORE)
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -150,11 +155,65 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 		.platform_data = &omap3evm_twldata,
 	},
 };
+#endif
+
+#if defined(CONFIG_OMAP3EVM_PR785)
+/* CORE voltage regulator */
+struct regulator_consumer_supply tps62352_core_consumers = {
+	.supply = "vdd2",
+};
+
+/* MPU voltage regulator */
+struct regulator_consumer_supply tps62352_mpu_consumers = {
+	.supply = "vdd1",
+};
+
+struct regulator_init_data vdd2_tps_regulator_data = {
+		.constraints = {
+			.min_uV = 750000,
+			.max_uV = 1537000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps62352_core_consumers,
+};
+
+struct regulator_init_data vdd1_tps_regulator_data = {
+		.constraints = {
+			.min_uV = 750000,
+			.max_uV = 1537000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+		},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps62352_mpu_consumers,
+};
+
+static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("tps62352", 0x4A),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &vdd2_tps_regulator_data,
+	},
+	{
+		I2C_BOARD_INFO("tps62353", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &vdd1_tps_regulator_data,
+	},
+};
+#endif
 
 static int __init omap3_evm_i2c_init(void)
 {
+#if defined(CONFIG_OMAP3EVM_PR785)
+	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
+		ARRAY_SIZE(tps_6235x_i2c_board_info));
+#endif
+#if defined(CONFIG_TWL4030_CORE)
 	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
+#endif
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
@@ -233,6 +292,7 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+#if defined(CONFIG_TWL4030_CORE)
 static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
@@ -242,6 +302,20 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	},
 	{}	/* Terminator */
 };
+#endif
+
+static void omap_init_pr785(void)
+{
+	/* Initialize the mux settings for PR785 power module board */
+	if (cpu_is_omap343x()) {
+		omap_cfg_reg(AF26_34XX_GPIO0);
+		omap_cfg_reg(AF22_34XX_GPIO9);
+		omap_cfg_reg(AF6_34XX_GPIO140_UP);
+		omap_cfg_reg(AE6_34XX_GPIO141);
+		omap_cfg_reg(AF5_34XX_GPIO142);
+		omap_cfg_reg(AE5_34XX_GPIO143);
+	}
+}
 
 static void __init omap3_evm_init(void)
 {
@@ -255,7 +329,12 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
+#if defined(CONFIG_TWL4030_CORE)
 	twl4030_mmc_init(mmc);
+#endif
+#if defined(CONFIG_OMAP3EVM_PR785)
+	omap_init_pr785();
+#endif
 	usb_musb_init();
 	usb_ehci_init();
 	omap3evm_flash_init();
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 437f520..d907889 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -168,7 +168,7 @@ static int twl_mmc_resume(struct device *dev, int slot)
  */
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
-	int ret;
+	int ret = 0;
 	u8 vmmc, dev_grp_val;
 
 	switch (1 << vdd) {
@@ -223,6 +223,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 	else
 		dev_grp_val = LDO_CLR;		/* Power down */
 
+#if defined(CONFIG_TWL4030_CORE)
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					dev_grp_val, c->twl_vmmc_dev_grp);
 	if (ret)
@@ -231,6 +232,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->twl_mmc_dedicated);
 
+#endif
 	return ret;
 }
 
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 89a6ab0..210bb79 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <mach/mux.h>
+#include <linux/string.h>
+#include <linux/regulator/machine.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
@@ -97,6 +99,15 @@ static const int omap34xx_pins[][2] = {
 static const int omap34xx_pins[][2] = {};
 #endif
 
+#if defined(CONFIG_OMAP3EVM_PR785)
+struct platform_device *vdd2_platform_device;
+struct platform_device *vdd1_platform_device;
+extern struct regulator_init_data vdd2_tps_regulator_data;
+extern struct regulator_init_data vdd1_tps_regulator_data;
+extern struct regulator_consumer_supply tps62352_core_consumers;
+extern struct regulator_consumer_supply tps62352_mpu_consumers;
+#endif
+
 static void __init omap_i2c_mux_pins(int bus)
 {
 	int scl, sda;
@@ -118,6 +129,51 @@ static void __init omap_i2c_mux_pins(int bus)
 	omap_cfg_reg(scl);
 }
 
+#if defined(CONFIG_OMAP3EVM_PR785)
+/* This is the callback function used to find the correct
+ * i2c platform child for the regulator consumer
+*/
+int omap_i2c_match_child(struct device *dev, void *data)
+{
+	struct regulator_init_data *reg_init_data = dev->platform_data;
+	char *name = data;
+
+	/* Child does not match */
+	if (strcmp(name, reg_init_data->consumer_supplies->supply))
+		return 0;
+	else
+		return 1;
+}
+
+int omap_i2c_register_child(struct platform_device *pdev_parent,
+			const char *name, struct platform_device **pdev)
+{
+	int ret = 0;
+
+	*pdev = platform_device_alloc(name, -1);
+	if (pdev == NULL) {
+		dev_err(&(*pdev)->dev, "Failed to alloc i2c-child %s\n", name);
+		return -1;
+	}
+
+	(*pdev)->dev.parent = &pdev_parent->dev;
+	if (!strcmp(name, "vdd2_consumer"))
+		(*pdev)->dev.platform_data = &vdd2_tps_regulator_data;
+	else if (!strcmp(name, "vdd1_consumer"))
+		(*pdev)->dev.platform_data = &vdd1_tps_regulator_data;
+
+
+	ret = platform_device_add(*pdev);
+	if (ret != 0) {
+		dev_err(&(*pdev)->dev, "Failed to register %s: %d\n",
+			name, ret);
+		platform_device_put(*pdev);
+		*pdev = NULL;
+	}
+	return ret;
+}
+#endif
+
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
@@ -160,5 +216,16 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	}
 
 	omap_i2c_mux_pins(bus_id - 1);
-	return platform_device_register(pdev);
+	platform_device_register(pdev);
+#if defined(CONFIG_OMAP3EVM_PR785)
+	if (bus_id == 1) {
+		omap_i2c_register_child(pdev, "vdd2_consumer", \
+				&vdd2_platform_device);
+		omap_i2c_register_child(pdev, "vdd1_consumer", \
+				&vdd1_platform_device);
+		tps62352_core_consumers.dev = &vdd2_platform_device->dev;
+		tps62352_mpu_consumers.dev = &vdd1_platform_device->dev;
+	}
+#endif
+	return 0;
 }
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 0dacb18..fdc5f5b 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
 obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
+obj-$(CONFIG_REGULATOR_TPS6235X)+= tps6235x-regulator.o
 
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/tps6235x-regulator.c b/drivers/regulator/tps6235x-regulator.c
index 340720d..ed4ceaf 100644
--- a/drivers/regulator/tps6235x-regulator.c
+++ b/drivers/regulator/tps6235x-regulator.c
@@ -82,12 +82,12 @@ static inline int tps_6235x_write_reg(struct tps *tps, u8 reg, u8 val)
 
 static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
 {
+	unsigned char vsel1;
 	struct tps *tps = rdev_get_drvdata(dev);
 
-	ret = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
-	/* REVISIT we need to be able to report errors here ... */
+	tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
 
-	return !!(vsel1 & TPS6235X_EN_DCDC);
+	return !(vsel1 & TPS6235X_EN_DCDC);
 }
 
 static int tps6235x_dcdc_enable(struct regulator_dev *dev)
@@ -121,8 +121,8 @@ static int tps6235x_dcdc_disable(struct regulator_dev *dev)
 
 static int tps6235x_dcdc_get_voltage(struct regulator_dev *dev)
 {
-	struct	i2c_client *tps_info = rdev_get_drvdata(dev);
 	unsigned char vsel1;
+	struct tps *tps = rdev_get_drvdata(dev);
 	const struct tps_info *info = tps->info;
 	int status;
 
@@ -343,7 +343,7 @@ static void __exit tps_6235x_cleanup(void)
 {
 	i2c_del_driver(&tps_6235x_i2c_driver);
 }
-subsys_initcall(tps_6235x_init);
+late_initcall(tps_6235x_init);
 module_exit(tps_6235x_cleanup);
 
 MODULE_AUTHOR("Texas Instruments");
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 1c3d814..4f373b2 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -66,9 +66,11 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	gpio_direction_output(LCD_PANEL_LR, 1);
 	gpio_direction_output(LCD_PANEL_UD, 1);
 
+#if defined(CONFIG_TWL4030_CORE)
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+#endif
 	bklight_level = 100;
 
 	return 0;
@@ -97,6 +99,7 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
 static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 						unsigned int level)
 {
+#if defined(CONFIG_TWL4030_CORE)
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
@@ -104,6 +107,9 @@ static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 		bklight_level = level;
 	}
 	return 0;
+#endif
+	/* Fix this once patch fix is sent out for TPS-boards */
+	return -1;
 }
 
 static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
-- 
1.5.6

