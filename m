From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/2] TPS6235x driver added into the power regulator framework
Date: Mon,  8 Dec 2008 15:38:02 +0530
Message-ID: <1228730882-22328-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36477 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYLHKIL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 05:08:11 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB8A831u002153
	for <linux-omap@vger.kernel.org>; Mon, 8 Dec 2008 04:08:09 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

Resending this patch after fixing comments received.
CONFIG_OMAP3EVM_PR785 has been moved to arch/arm/mach-omap2/Kconfig
MUX patch has been separated and sent out separately
regulator/core.c changes have been separated and send out earlier
Platform driver has been removed
Renamed supplies to vdd1 and vdd2
regulator_get_drvdata() is being used to get driver data


Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/Kconfig            |   32 ++
 arch/arm/mach-omap2/board-omap3evm.c   |   23 ++-
 arch/arm/mach-omap2/mmc-twl4030.c      |    5 +-
 drivers/mfd/Kconfig                    |   14 -
 drivers/regulator/Kconfig              |    8 +
 drivers/regulator/Makefile             |    1 +
 drivers/regulator/tps6235x-regulator.c |  557 ++++++++++++++++++++++++++++++++
 drivers/video/omap/lcd_omap3evm.c      |    4 +
 8 files changed, 627 insertions(+), 17 deletions(-)
 create mode 100644 drivers/regulator/tps6235x-regulator.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ca24a7a..c1fb1db 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -121,6 +121,38 @@ config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+choice
+	prompt "Power board for OMAP3 EVM"
+	depends on MACH_OMAP3EVM=y
+	help
+		Select the power module available on your OMAP3 EVM.
+
+config TWL4030_CORE
+	bool "TI  TWL4030/TPS659x0 Support"
+	depends on I2C=y && GENERIC_HARDIRQS
+	help
+	 Say yes here if you have TWL4030 family chip on your board.
+	 This core driver provides register access and IRQ handling
+	 facilities, and registers devices for the various functions
+	 so that function-specific drivers can bind to them.
+
+	 These multi-function chips are found on many OMAP2 and OMAP3
+	 boards, providing power management, RTC, GPIO, keypad, a
+	 high speed USB OTG transceiver, an audio codec (on most
+	 versions) and many other features.
+
+config OMAP3EVM_PR785
+	bool "TI TPS6235X based Power Module"
+	depends on I2C=y && (ARCH_OMAP3)
+	default n
+	help
+	 Say yes here if you are using the TPS6235x based PR785 Power Module
+	 for the EVM boards. This core driver provides register access and IRQ
+	 handling facilities, and registers devices for the various functions
+	 so that function-specific drivers can bind to them.
+
+endchoice
+
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8a1b86e..d0d6a91 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -41,7 +41,7 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "twl4030-generic-scripts.h"
 #include "mmc-twl4030.h"
-
+#include <linux/regulator/machine.h>
 
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
@@ -90,6 +90,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+#if defined(CONFIG_TWL4030_CORE)
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -151,11 +152,31 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 		.platform_data = &omap3evm_twldata,
 	},
 };
+#endif
+
+#if defined(CONFIG_OMAP3EVM_PR785)
+static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("tps62352", 0x4A),
+		.flags = I2C_CLIENT_WAKE,
+	},
+	{
+		I2C_BOARD_INFO("tps62353", 0x48),
+		.flags = I2C_CLIENT_WAKE,
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
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 626d668..daf10f3 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -167,7 +167,7 @@ static int twl_mmc_resume(struct device *dev, int slot)
  */
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
-	int ret;
+	int ret = 0;
 	u8 vmmc, dev_grp_val;
 
 	switch (1 << vdd) {
@@ -222,6 +222,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 	else
 		dev_grp_val = LDO_CLR;		/* Power down */
 
+#if defined(CONFIG_TWL4030_CORE)
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					dev_grp_val, c->twl_vmmc_dev_grp);
 	if (ret)
@@ -229,7 +230,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->twl_mmc_dedicated);
-
+#endif
 	return ret;
 }
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 650b51c..ff5fbd5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -61,20 +61,6 @@ config UCB1400_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_core.
 
-config TWL4030_CORE
-	bool "Texas Instruments TWL4030/TPS659x0 Support"
-	depends on I2C=y && GENERIC_HARDIRQS
-	help
-	  Say yes here if you have TWL4030 family chip on your board.
-	  This core driver provides register access and IRQ handling
-	  facilities, and registers devices for the various functions
-	  so that function-specific drivers can bind to them.
-
-	  These multi-function chips are found on many OMAP2 and OMAP3
-	  boards, providing power management, RTC, GPIO, keypad, a
-	  high speed USB OTG transceiver, an audio codec (on most
-	  versions) and many other features.
-
 config TWL4030_POWER
 	bool "Support power sequencing scripts on TWL4030/TPS659x0"
 	depends on TWL4030_CORE
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 0765389..514b166 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -80,4 +80,12 @@ config REGULATOR_DA903X
 	  Say y here to support the BUCKs and LDOs regulators found on
 	  Dialog Semiconductor DA9030/DA9034 PMIC.
 
+config REGULATOR_TPS6235X
+	bool "TPS6235X Power regulator for OMAP3EVM"
+	depends on I2C=y
+	help
+	  This driver supports the voltage regulators provided by TPS6235x chips.
+	  The TPS62352 and TPS62353 are mounted on PR785 Power module card for
+	  providing voltage regulator functions.
+
 endif
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
new file mode 100644
index 0000000..26ddb78
--- /dev/null
+++ b/drivers/regulator/tps6235x-regulator.c
@@ -0,0 +1,557 @@
+/*
+ * tps6235x-regulator.c -- support regulators in tps6235x family chips
+ *
+ * Copyright (C) 2008 David Brownell
+ * Author : Manikandan Pillai<mani.pillai@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+
+/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
+All voltages given in millivolts */
+#define PR785_MIN_CORE_VOLT     750
+#define PR785_MAX_CORE_VOLT     1537
+#define PR785_MIN_MPU_VOLT      750
+#define PR785_MAX_MPU_VOLT      1537
+
+/* Maximum number of bytes to be read in a single read */
+#define PR785_RETRY_COUNT       0x3
+
+/* Register bit settings */
+#define TPS6235X_EN_DCDC        (0x1 << 0x7)
+#define TPS6235X_VSM_MSK        (0x3F)
+#define TPS6235X_EN_SYN_MSK     (0x1 << 0x5)
+#define TPS6235X_SW_VOLT_MSK    (0x1 << 0x4)
+#define TPS6235X_PWR_OK_MSK     (0x1 << 0x5)
+#define TPS6235X_OUT_DIS_MSK    (0x1 << 0x6)
+#define TPS6235X_GO_MSK         (0x1 << 0x7)
+
+/*
+ * These chips are often used in OMAP-based systems.
+ *
+ * This driver implements software-based resource control for various
+ * voltage regulators.  This is usually augmented with state machine
+ * based control.
+ */
+struct tps_6235x_info {
+	unsigned int		state;
+	unsigned int		tps_i2c_addr;
+	struct i2c_client	*client;
+	struct device		*i2c_dev;
+	/* platform data holder */
+	void			*pdata;
+};
+
+static struct tps_6235x_info    tps_6235x_infodata[2];
+
+
+#ifndef REGULATOR_MODE_OFF
+#define REGULATOR_MODE_OFF 0
+#endif
+
+
+/* LDO control registers ... offset is from the base of its register bank.
+ * The first three registers of all power resource banks help hardware to
+ * manage the various resource groups.
+ */
+
+#define	TPS6235X_REG_VSEL0	0
+#define	TPS6235X_REG_VSEL1	1
+#define	TPS6235X_REG_CTRL1	2
+#define	TPS6235X_REG_CTRL2	3
+#define	TPS6235X_REG_MAX	TPS6235X_REG_CTRL2
+
+#define	MODULE_NAME		"tps6235x_power"
+
+/* Debug functions */
+#ifdef	DEBUG
+
+#define dump_reg(client, reg, val)                                      \
+	do {                                                            \
+		tps6235x_read_reg(client, reg, &val);                   \
+		dev_dbg(&(client)->dev, "Reg(0x%.2X): 0x%.2X\n", reg, val); \
+	} while (0)
+
+#endif	/* #ifdef DEBUG */
+
+/* Device addresses for PR785 card */
+#define	PR785_62352_CORE_ADDR	0x4A
+#define	PR785_62353_MPU_ADDR	0x48
+
+/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
+All voltages given in millivolts */
+#define	PR785_MIN_CORE_VOLT	750
+#define	PR785_MAX_CORE_VOLT	1537
+#define	PR785_MIN_MPU_VOLT	750
+#define	PR785_MAX_MPU_VOLT	1537
+
+/* Maximum number of bytes to be read in a single read */
+#define	PR785_RETRY_COUNT	0x3
+
+/* Register bit settings */
+#define	TPS6235X_EN_DCDC	(0x1 << 0x7)
+#define	TPS6235X_VSM_MSK	(0x3F)
+#define	TPS6235X_EN_SYN_MSK	(0x1 << 0x5)
+#define	TPS6235X_SW_VOLT_MSK	(0x1 << 0x4)
+#define	TPS6235X_PWR_OK_MSK	(0x1 << 0x5)
+#define	TPS6235X_OUT_DIS_MSK	(0x1 << 0x6)
+#define	TPS6235X_GO_MSK		(0x1 << 0x7)
+
+/*
+ * Get client pointer for a particular device
+ * Returns zero if successful, or non-zero otherwise.
+ */
+static struct i2c_client *tps_6235x_get_client(unsigned char tps_i2c_addr)
+{
+	if (tps_i2c_addr == PR785_62352_CORE_ADDR)
+		return tps_6235x_infodata[0].client;
+	else if (tps_i2c_addr == PR785_62353_MPU_ADDR)
+		return tps_6235x_infodata[1].client;
+	else
+		return NULL;
+}
+
+/*
+ * Read a value from a register in an tps_6235x device.
+ * The value is returned in 'val'.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+static int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val)
+{
+	u8 data;
+
+	if (!client->adapter)
+		return -ENODEV;
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
+static int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	int err;
+	int retry = 0;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+again:
+	err = i2c_smbus_write_byte_data(client, reg, val);
+	if (err >= 0)
+		return 0;
+
+	dev_err(&client->dev,
+		"wrote 0x%.2x to offset 0x%.2x error %d\n", val, reg, err);
+
+	if (retry <= PR785_RETRY_COUNT) {
+		dev_info(&client->dev, "retry ... %d\n", retry);
+		retry++;
+		schedule_timeout(msecs_to_jiffies(20));
+		goto again;
+	}
+	return err;
+}
+
+
+/**
+*  pwr_i2c_read - Allows the caller to read one register from TPS device
+*                   based on the address given. For the PR785 it reads
+*                   only 1 byte into a specified register
+*  tps_mod_type - Enum for the device to be read
+*  reg          - Register to be read from(value has to be between 0-3
+*  val          - value read from the reg
+*  Retval       - 0 -> Success else non-zero
+**/
+int pwr_i2c_read(unsigned char tps_mod_type, u8 reg, u8 *val)
+{
+	struct i2c_client *client;
+
+	client = tps_6235x_get_client(tps_mod_type);
+	/* check if register is less than <= 3 Register is 0 -3 */
+	if (reg > TPS6235X_REG_MAX)
+		return -1;
+
+	return tps_6235x_read_reg(client, reg, val);
+}
+EXPORT_SYMBOL(pwr_i2c_read);
+
+/**
+*  pwr_i2c_write - Allows the caller to write one register from TPS device
+*                   based on the address given. For the PR785 it writes
+*                   only 1 byte into a specified register
+*  tps_mod_type  - Enum for the device to be written
+*  reg           - Register to be written to(value has to be between 0-3
+*  val           - value to be written to reg
+*  Retval        - 0 -> Success else non-zero
+**/
+int pwr_i2c_write(unsigned char tps_mod_type, u8 reg, u8 val)
+{
+	struct i2c_client *client;
+
+	client = tps_6235x_get_client(tps_mod_type);
+
+	/* check if register is less than <= 3 Register is 0 -3 */
+	if (reg > TPS6235X_REG_MAX)
+		return -1;
+
+	return tps_6235x_write_reg(client, reg, val);
+}
+EXPORT_SYMBOL(pwr_i2c_write);
+
+
+/**
+*  TPSPR785        - Specific functions
+*  pr785_enbl_dcdc - Allows the caller to enable or disable the TPS6235x device
+*                    on the PR785 board. The voltage for PR785 is selected by
+*                    VSEL1 register since VSEL pin is kept high
+*
+*  flag            - 1 == enable 0 == disable
+*  Retval          - 0 -> Success else non-zero
+**/
+int pr785_enbl_dcdc(unsigned char tps_mod_type, unsigned int en_flag)
+{
+	unsigned char vsel1;
+	int ret;
+
+	ret = pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
+	if (ret == 0) {
+		if (en_flag)
+			vsel1 |= TPS6235X_EN_DCDC;
+		else
+			vsel1 &= ~(TPS6235X_EN_DCDC);
+		ret = pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(pr785_enbl_dcdc);
+
+/**
+*  TPSPR785            - Specific functions
+*  pr785_set_dcdc_volt - Allows the caller to set a particular voltage on
+*                        for CORE or MPU
+*
+*  voltage              - voltage to be set in millivolts (75--1537)
+*  Retval          - 0 -> Success else non-zero
+**/
+int pr785_set_dcdc_volt(unsigned char tps_mod_type, unsigned int millivolts)
+{
+	unsigned char vsel1;
+	unsigned int volt;
+
+	/* check if the millivolts is within range */
+	if ((millivolts < PR785_MIN_CORE_VOLT) ||
+		(millivolts > PR785_MAX_CORE_VOLT))
+		return -1;
+
+	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
+	volt = millivolts - PR785_MIN_CORE_VOLT;
+	volt /= 25;
+	volt *= 2;
+	vsel1 = ((TPS6235X_EN_DCDC) | (volt & TPS6235X_VSM_MSK));
+	return  pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
+}
+EXPORT_SYMBOL(pr785_set_dcdc_volt);
+
+/**
+*  TPSPR785            - Specific functions
+*  pr785_get_dcdc_volt - Allows the caller to get the set voltage on a
+*                        particular TPS 6235x device on PR785 card
+*
+*  voltage              - voltage to be set in millivolts (75--1537)
+*  Retval          - 0 -> Success else non-zero
+**/
+int pr785_get_dcdc_volt(unsigned char tps_mod_type, unsigned int *millivolts)
+{
+	unsigned char vsel1;
+	unsigned int volt;
+
+	/* Read the VSEL1 register to get VSM */
+	pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
+	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
+	/* To cut out floating point operation we will multiply by 25
+	divide by 2 */
+	volt = (((vsel1 & TPS6235X_VSM_MSK) * 25) / 2) + PR785_MIN_CORE_VOLT;
+	*millivolts = volt;
+	return 0;
+}
+EXPORT_SYMBOL(pr785_get_dcdc_volt);
+
+static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
+{
+	struct  tps_6235x_info *tps_info =
+		(struct tps_6235x_info *)rdev_get_drvdata(dev);
+	return tps_info->state;
+}
+
+static int tps6235x_dcdc_enable(struct regulator_dev *dev)
+{
+	struct  tps_6235x_info *tps_info =
+		(struct tps_6235x_info *)rdev_get_drvdata(dev);
+
+	tps_info->state = 1;
+	return pr785_enbl_dcdc(tps_info->tps_i2c_addr, 1);
+}
+
+static int tps6235x_dcdc_disable(struct regulator_dev *dev)
+{
+	struct  tps_6235x_info *tps_info =
+		(struct tps_6235x_info *)rdev_get_drvdata(dev);
+
+	tps_info->state = 0;
+	return pr785_enbl_dcdc(tps_info->tps_i2c_addr, 0);
+}
+
+static int tps6235x_dcdc_get_voltage(struct regulator_dev *dev)
+{
+	struct  tps_6235x_info *tps_info =
+		(struct tps_6235x_info *)rdev_get_drvdata(dev);
+	unsigned int millivolts;
+
+	pr785_get_dcdc_volt(tps_info->tps_i2c_addr, &millivolts);
+	return millivolts * 1000;
+}
+
+static int tps6235x_dcdc_set_voltage(struct regulator_dev *dev,
+				int min_uV, int max_uV)
+{
+	struct  tps_6235x_info *tps_info =
+			(struct tps_6235x_info *)rdev_get_drvdata(dev);
+	unsigned int millivolts = min_uV / 1000;
+
+	return pr785_set_dcdc_volt(tps_info->tps_i2c_addr,  millivolts) ;
+}
+
+static struct regulator_ops tps62352_dcdc_ops = {
+	.is_enabled = tps6235x_dcdc_is_enabled,
+	.get_voltage = tps6235x_dcdc_get_voltage,
+	.set_voltage = tps6235x_dcdc_set_voltage,
+};
+
+static struct regulator_ops tps62353_dcdc_ops = {
+	.is_enabled = tps6235x_dcdc_is_enabled,
+	.enable = tps6235x_dcdc_enable,
+	.disable = tps6235x_dcdc_disable,
+	.get_voltage = tps6235x_dcdc_get_voltage,
+	.set_voltage = tps6235x_dcdc_set_voltage,
+};
+
+
+static struct regulator_init_data tps_regulator_data[];
+
+/* CORE voltage regulator */
+static struct regulator_consumer_supply tps62352_core_consumers = {
+	.supply = "vdd2",
+};
+
+/* MPU voltage regulator */
+static struct regulator_consumer_supply tps62352_mpu_consumers = {
+	.supply = "vdd1",
+};
+
+static struct regulator_init_data tps_regulator_data[] = {
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
+static struct regulator_desc regulators[] = {
+	{
+		.name = "tps62352",
+		.id = 2,
+		.ops = &tps62352_dcdc_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+	},
+	{
+		.name = "tps62353",
+		.id = 3,
+		.ops = &tps62353_dcdc_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+	},
+};
+
+/**
+ * tps_6235x_probe - TPS6235x driver i2c probe handler
+ * @client: i2c driver client device structure
+ *
+ * Register PR785 as an i2c client device driver
+ */
+static struct i2c_driver tps_6235x_i2c_driver;
+
+static
+int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct  tps_6235x_info          *info;
+	struct  regulator_dev           *rdev = NULL;
+	unsigned char reg_val;
+
+	printk(KERN_INFO "tps_6235x_probe:i2c_addr = %x\n", (int)client->addr);
+
+	info = &tps_6235x_infodata[id->driver_data];
+	/* Device probed is TPS62352 CORE pwr chip if driver_data  = 0
+	Device probed is TPS62353 MPU pwr chip if driver_data = 1   */
+	tps_6235x_infodata[id->driver_data].client = client;
+	tps_6235x_infodata[id->driver_data].tps_i2c_addr = client->addr;
+	tps_6235x_infodata[id->driver_data].state = 1;
+	tps_6235x_infodata[id->driver_data].i2c_dev = &client->dev;
+
+	if (id->driver_data == 0)
+		tps62352_core_consumers.dev = &client->dev;
+	else
+		tps62352_mpu_consumers.dev = &client->dev;
+
+	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
+	reg_val |= (TPS6235X_OUT_DIS_MSK | TPS6235X_GO_MSK);
+	tps_6235x_write_reg(client, TPS6235X_REG_CTRL2, reg_val);
+	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
+
+	if (reg_val & TPS6235X_PWR_OK_MSK)
+		printk(KERN_INFO "Power is OK  %x\n", reg_val);
+	else {
+		printk(KERN_ERR "Power not within range = %x\n", reg_val);
+		return -2;
+	}
+
+	/* Initialize platform data for TPS devices */
+	client->dev.platform_data =
+			(void *)&tps_regulator_data[id->driver_data];
+	rdev = regulator_register(&regulators[id->driver_data], &client->dev,
+					info);
+	if (rdev == NULL) {
+		printk(KERN_ERR "ERR in regulator registration\n");
+		return -1;
+	}
+
+	/* Set the regulator platform data for unregistration later on */
+	tps_6235x_infodata[id->driver_data].pdata = (void *)rdev;
+	i2c_set_clientdata(client, &tps_6235x_infodata[id->driver_data]);
+
+	return 0;
+}
+
+/**
+ * tps_6235x_remove - TPS6235x driver i2c remove handler
+ * @client: i2c driver client device structure
+ *
+ * UnregisterPR785  as an i2c client device driver
+ */
+static int __exit tps_6235x_remove(struct i2c_client *client)
+{
+	struct	regulator_dev	*rdev = NULL;
+	struct	tps_6235x_info	*info;
+#ifdef DEBUG
+	printk(KERN_INFO "tps_6235x_remove invoked\n");
+#endif
+
+	if (!client->adapter)
+		return -ENODEV; /* our client isn't attached */
+
+	info = (struct  tps_6235x_info *)i2c_get_clientdata(client);
+	/* Unregister the regulator */
+	rdev = (struct  regulator_dev *)info->pdata;
+	regulator_unregister(rdev);
+	/* clear the client data in i2c */
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+
+static const struct i2c_device_id tps_6235x_id[] = {
+	{ "tps62352", 0},
+	{ "tps62353", 1},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, tps_6235x_id);
+
+static struct i2c_driver tps_6235x_i2c_driver = {
+	.driver = {
+		.name	=	MODULE_NAME,
+		.owner	=	THIS_MODULE,
+	},
+	.probe = tps_6235x_probe,
+	.remove = __exit_p(tps_6235x_remove),
+	.id_table = tps_6235x_id,
+};
+
+/**
+ * tps_6235x_init
+ *
+ * Module init function
+ */
+static int __init tps_6235x_init(void)
+{
+	int err;
+
+#ifdef DEBUG
+	printk(KERN_INFO "tps_6235x_init invoked\n");
+#endif
+
+	err = i2c_add_driver(&tps_6235x_i2c_driver);
+	if (err) {
+		printk(KERN_ERR "Failed to register " MODULE_NAME ".\n");
+		return err;
+	} else
+		printk(KERN_INFO "I2c driver registered\n");
+
+	return 0;
+}
+
+/**
+ * tps_6235x_cleanup
+ *
+ * Module exit function
+ */
+static void __exit tps_6235x_cleanup(void)
+{
+#ifdef DEBUG
+	printk(KERN_INFO "tps_6235x_cleanup invoked\n");
+#endif
+	i2c_del_driver(&tps_6235x_i2c_driver);
+}
+
+late_initcall(tps_6235x_init);
+module_exit(tps_6235x_cleanup);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("TPS6235x based linux driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 1c3d814..6daa68d 100644
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
@@ -97,12 +99,14 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
 static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 						unsigned int level)
 {
+#if defined(CONFIG_TWL4030_CORE)
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
 		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
+#endif
 	return 0;
 }
 
-- 
1.5.6

