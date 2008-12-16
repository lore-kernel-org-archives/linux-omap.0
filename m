From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 2/2] Changes for adding TPS6235x based PR785 board support
Date: Tue, 16 Dec 2008 15:36:21 +0530
Message-ID: <1229421981-11448-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYLPKG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 05:06:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, broonie@sirena.org.uk
Cc: Manikandan Pillai <mani.pillai@ti.com>

TPS6235x chip based PR785 power modules are from Texas Instruments
for OMAP3 EVM boards. This patch supports the PR785 card
and provides the driver support for the TPS devices.

For compilation, the LCD and MMC drivers are modified and will not
work. Further patches will be provided for support of LCD and MMC
with PR785 boards.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/Kconfig          |   11 +++
 arch/arm/mach-omap2/board-omap3evm.c |  118 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mmc-twl4030.c    |    5 +-
 drivers/mmc/host/Kconfig             |    1 -
 drivers/video/omap/lcd_omap3evm.c    |    6 ++
 5 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ca24a7a..7aaba79 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -121,6 +121,17 @@ config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+menu 	"Power board selection for OMAP3 EVM"
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
index e4e60e2..1aababc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -40,8 +40,14 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "twl4030-generic-scripts.h"
 #include "mmc-twl4030.h"
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
 
+#define TPS6235X_REG_MAX	3
 
+#if defined(CONFIG_OMAP3EVM_PR785) && defined(CONFIG_TWL4030_CORE)
+#error config err : only one of OMAP3EVM_PR785 or TWL4030_CORE can be defined
+#endif
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start  = OMAP3EVM_ETHR_START,
@@ -89,6 +95,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+#if defined(CONFIG_TWL4030_CORE)
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -150,16 +157,127 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 		.platform_data = &omap3evm_twldata,
 	},
 };
+#endif
+
+#if defined(CONFIG_OMAP3EVM_PR785)
+struct regulator_init_data tps_regulator_data[];
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
+struct regulator_init_data tps_regulator_data[] = {
+	{
+		.constraints = {
+			.min_uV = 750000,
+			.max_uV = 1537000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+	},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps62352_core_consumers,
+	},
+	{
+		.constraints = {
+			.min_uV = 750000,
+			.max_uV = 1537000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+	},
+		.num_consumer_supplies  = 1,
+		.consumer_supplies      = &tps62352_mpu_consumers,
+	},
+};
+
+static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("tps62352", 0x4A),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &tps_regulator_data[0],
+	},
+	{
+		I2C_BOARD_INFO("tps62353", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &tps_regulator_data[1],
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
 }
 
+/*
+ * Read a value from a register in an tps_6235x device.
+ * The value is returned in 'val'.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	u8 data;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	if (reg > TPS6235X_REG_MAX)
+		return -1;
+
+	data = i2c_smbus_read_byte_data(client, reg);
+	*val = data;
+	return 0;
+}
+
+/*
+ * Write a value to a register in an tps_6235x device.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	int err;
+	int retry = 0;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	if (reg > TPS6235X_REG_MAX)
+		return -1;
+
+again:
+	err = i2c_smbus_write_byte_data(client, reg, val);
+	if (err >= 0)
+		return 0;
+
+	dev_err(&client->dev,
+		"wrote 0x%.2x to offset 0x%.2x error %d\n", val, reg, err);
+
+	/* Try 3 times */
+	if (retry <= 3) {
+		dev_info(&client->dev, "retry ... %d\n", retry);
+		retry++;
+		schedule_timeout(msecs_to_jiffies(20));
+		goto again;
+	}
+	return err;
+}
+
+/*-------------------------------------------------------------------*/
+
 static struct platform_device omap3_evm_lcd_device = {
 	.name		= "omap3evm_lcd",
 	.id		= -1,
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 437f520..ed96cff 100644
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
@@ -230,7 +231,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->twl_mmc_dedicated);
-
+#endif
 	return ret;
 }
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6fef94f..b697c96 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -80,7 +80,6 @@ config MMC_OMAP
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
 	depends on (ARCH_OMAP2 && ARCH_OMAP2430) || ARCH_OMAP3
-	select TWL4030_CORE
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an OMAP2(2430) or OMAP3 board with a Multimedia Card slot,
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

