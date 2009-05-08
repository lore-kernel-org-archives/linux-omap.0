From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/3] Regulator: Add TPS65023 Regulator Driver
Date: Fri,  8 May 2009 20:42:12 +0530
Message-ID: <1241795532-15716-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbZEHPMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 11:12:18 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n48FCDga020015
	for <linux-omap@vger.kernel.org>; Fri, 8 May 2009 10:12:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Added regulator driver for TPS65023 and modified the Kconfig and Makefile for
the same.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 drivers/regulator/Kconfig              |    8 +
 drivers/regulator/Makefile             |    1 +
 drivers/regulator/tps65023-regulator.c |  510 ++++++++++++++++++++++++++++++++
 3 files changed, 519 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/tps65023-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index e58c0ce..28109e1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -91,4 +91,12 @@ config REGULATOR_PCF50633
 	 Say Y here to support the voltage regulators and convertors
 	 on PCF50633

+config REGULATOR_TPS65023
+	tristate "TI TPS65023 Power regulators"
+	depends on OMAP3EVM_TPS65023
+	help
+	  This driver supports TPS65023 voltage regulator chips. TPS65023 provides
+	  three step-down converters and two general-purpose LDO voltage regulators.
+	  It supports TI's software based Class-2 SmartReflex implementation.
+
 endif
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index c0d87bf..28235b9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
+obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o

 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
new file mode 100644
index 0000000..657c0c3
--- /dev/null
+++ b/drivers/regulator/tps65023-regulator.c
@@ -0,0 +1,510 @@
+/*
+ * tps65023-regulator.c -- Supports TPS65023 regulator
+ *
+ * Author : Anuj Aggarwal<anuj.aggarwal@ti.com>
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
+
+/* Register definitions */
+#define	TPS65023_REG_VERSION		0
+#define	TPS65023_REG_PGOODZ		1
+#define	TPS65023_REG_MASK		2
+#define	TPS65023_REG_REG_CTRL		3
+#define	TPS65023_REG_CON_CTRL		4
+#define	TPS65023_REG_CON_CTRL2		5
+#define	TPS65023_REG_DEF_CORE		6
+#define	TPS65023_REG_DEFSLEW		7
+#define	TPS65023_REG_LDO_CTRL		8
+
+/* PGOODZ bitfields */
+#define	TPS65023_PGOODZ_PWRFAILZ	BIT(7)
+#define	TPS65023_PGOODZ_LOWBATTZ	BIT(6)
+#define	TPS65023_PGOODZ_VDCDC1		BIT(5)
+#define	TPS65023_PGOODZ_VDCDC2		BIT(4)
+#define	TPS65023_PGOODZ_VDCDC3		BIT(3)
+#define	TPS65023_PGOODZ_LDO2		BIT(2)
+#define	TPS65023_PGOODZ_LDO1		BIT(1)
+
+/* MASK bitfields */
+#define	TPS65023_MASK_PWRFAILZ		BIT(7)
+#define	TPS65023_MASK_LOWBATTZ		BIT(6)
+#define	TPS65023_MASK_VDCDC1		BIT(5)
+#define	TPS65023_MASK_VDCDC2		BIT(4)
+#define	TPS65023_MASK_VDCDC3		BIT(3)
+#define	TPS65023_MASK_LDO2		BIT(2)
+#define	TPS65023_MASK_LDO1		BIT(1)
+
+/* REG_CTRL bitfields */
+#define TPS65023_REG_CTRL_VDCDC1_EN	BIT(5)
+#define TPS65023_REG_CTRL_VDCDC2_EN	BIT(4)
+#define TPS65023_REG_CTRL_VDCDC3_EN	BIT(3)
+#define TPS65023_REG_CTRL_LDO2_EN	BIT(2)
+#define TPS65023_REG_CTRL_LDO1_EN	BIT(1)
+
+/* LDO_CTRL bitfields */
+#define TPS65023_LDO_CTRL_LDOx_SHIFT	4
+#define TPS65023_LDO_CTRL_LDOx_MASK(ldo_id)		(0xF0 >> (ldo_id*4))
+
+/* Number of step-down converters available */
+#define TPS65023_NUM_DCDC		3
+/* Number of LDO voltage regulators  available */
+#define TPS65023_NUM_LDO		2
+/* Number of total regulators available */
+#define TPS65023_NUM_REGULATOR	(TPS65023_NUM_DCDC + TPS65023_NUM_LDO)
+
+struct tps_info {
+	const char 	*name;
+	unsigned		min_uV;
+	unsigned		max_uV;
+	bool			fixed;
+	u8			table_len;
+	const u16		*table;
+};
+
+struct tps {
+	struct regulator_desc	desc[TPS65023_NUM_REGULATOR];
+	struct i2c_client	*client;
+	struct regulator_dev	*rdev[TPS65023_NUM_REGULATOR];
+	const struct tps_info	*info[TPS65023_NUM_REGULATOR];
+};
+
+static inline int tps_65023_read_reg(struct tps *tps, u8 reg, u8 *val)
+{
+	int status;
+
+	status = i2c_smbus_read_byte_data(tps->client, reg);
+	*val = status;
+	if (status < 0)
+		return status;
+	return 0;
+}
+
+static inline int tps_65023_write_reg(struct tps *tps, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(tps->client, reg, val);
+}
+
+static int tps65023_dcdc_is_enabled(struct regulator_dev *dev)
+{
+	unsigned char reg_ctrl;
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+	int ret;
+
+	ret = tps_65023_read_reg(tps, TPS65023_REG_REG_CTRL, &reg_ctrl);
+
+	if (ret == 0) {
+		switch (regulator_id) {
+		case 0:
+			reg_ctrl &= TPS65023_REG_CTRL_VDCDC1_EN;
+			break;
+
+		case 1:
+			reg_ctrl &= TPS65023_REG_CTRL_VDCDC2_EN;
+			break;
+
+		case 2:
+			reg_ctrl &= TPS65023_REG_CTRL_VDCDC3_EN;
+			break;
+
+		case 3:
+			reg_ctrl &= TPS65023_REG_CTRL_LDO1_EN;
+			break;
+
+		case 4:
+			reg_ctrl &= TPS65023_REG_CTRL_LDO2_EN;
+			break;
+
+		default:
+			/* error message */
+			break;
+		}
+	}
+
+	if (ret == 0)
+		return reg_ctrl ? 1 : 0;
+	else
+		return ret;
+}
+
+static int tps65023_dcdc_enable(struct regulator_dev *dev)
+{
+	unsigned char reg_ctrl;
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+	int ret;
+
+	ret = tps_65023_read_reg(tps, TPS65023_REG_REG_CTRL, &reg_ctrl);
+
+	if (ret == 0) {
+		switch (regulator_id) {
+		case 0:
+			reg_ctrl |= TPS65023_REG_CTRL_VDCDC1_EN;
+			break;
+
+		case 1:
+			reg_ctrl |= TPS65023_REG_CTRL_VDCDC2_EN;
+			break;
+
+		case 2:
+			reg_ctrl |= TPS65023_REG_CTRL_VDCDC3_EN;
+			break;
+
+		case 3:
+			reg_ctrl |= TPS65023_REG_CTRL_LDO1_EN;
+			break;
+
+		case 4:
+			reg_ctrl |= TPS65023_REG_CTRL_LDO2_EN;
+			break;
+
+		default:
+			/* error message */
+			break;
+		}
+	}
+
+	if (ret == 0)
+		return tps_65023_write_reg(tps, TPS65023_REG_REG_CTRL,
+						reg_ctrl);
+	else
+		return ret;
+}
+
+static int tps65023_dcdc_disable(struct regulator_dev *dev)
+{
+	unsigned char reg_ctrl;
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+	int ret;
+
+	ret = tps_65023_read_reg(tps, TPS65023_REG_REG_CTRL, &reg_ctrl);
+
+	if (ret == 0) {
+		switch (regulator_id) {
+		case 0:
+			reg_ctrl &= ~(TPS65023_REG_CTRL_VDCDC1_EN);
+			break;
+
+		case 1:
+			reg_ctrl &= ~(TPS65023_REG_CTRL_VDCDC2_EN);
+			break;
+
+		case 2:
+			reg_ctrl &= ~(TPS65023_REG_CTRL_VDCDC3_EN);
+			break;
+
+		case 3:
+			reg_ctrl &= ~(TPS65023_REG_CTRL_LDO1_EN);
+			break;
+
+		case 4:
+			reg_ctrl &= ~(TPS65023_REG_CTRL_LDO2_EN);
+			break;
+
+		default:
+			/* error message */
+			break;
+		}
+	}
+
+	if (ret == 0)
+		return tps_65023_write_reg(tps, TPS65023_REG_REG_CTRL,
+						reg_ctrl);
+	else
+		return ret;
+}
+
+static int tps65023_fixed_get_voltage(struct regulator_dev *dev)
+{
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+
+	return tps->info[regulator_id]->min_uV;
+}
+
+static int tps65023_dcdc_get_voltage(struct regulator_dev *dev)
+{
+	unsigned char reg_ctrl;
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+	u8 reg;
+	int ret;
+
+	/* Choose the control register according to the regulator */
+	reg = (regulator_id ? TPS65023_REG_LDO_CTRL : TPS65023_REG_DEF_CORE);
+	ret = tps_65023_read_reg(tps, reg, &reg_ctrl);
+	if (ret < 0)
+		return ret;
+
+	if (regulator_id)	{
+		/* Select between LDO 1 and 2 */
+		int ldo_id = regulator_id - TPS65023_NUM_DCDC;
+
+		reg_ctrl >>= (TPS65023_LDO_CTRL_LDOx_SHIFT * ldo_id);
+		reg_ctrl &= (tps->info[regulator_id]->table_len - 1);
+		return tps->info[regulator_id]->table[reg_ctrl] * 1000;
+	} else {
+		/* VDCDC1 */
+		reg_ctrl &= (tps->info[regulator_id]->table_len - 1);
+		return tps->info[regulator_id]->table[reg_ctrl] * 1000;
+	}
+}
+
+static int tps65023_dcdc_set_voltage(struct regulator_dev *dev,
+				int min_uV, int max_uV)
+{
+	struct tps *tps = rdev_get_drvdata(dev);
+	int regulator_id = rdev_get_id(dev);
+	u8 reg;
+	int vsel;
+
+	/* Choose the control register according to the regulator */
+	reg = (regulator_id ? TPS65023_REG_LDO_CTRL : TPS65023_REG_DEF_CORE);
+
+	for (vsel = 0; vsel < tps->info[regulator_id]->table_len; vsel++) {
+		int mV = tps->info[regulator_id]->table[vsel];
+		int uV = mV * 1000;
+
+		/* Break at the first in-range value */
+		if (min_uV <= uV && uV <= max_uV)
+			break;
+	}
+
+	if (regulator_id)	{
+		/* LDO 1 or 2 */
+		int ret;
+		unsigned char reg_ctrl;
+		int ldo_id = regulator_id - TPS65023_NUM_DCDC;
+
+		ret = tps_65023_read_reg(tps, reg, &reg_ctrl);
+		if (ret < 0)
+			return ret;
+
+		reg_ctrl &= TPS65023_LDO_CTRL_LDOx_MASK(ldo_id);
+		reg_ctrl |= (vsel << (ldo_id * TPS65023_LDO_CTRL_LDOx_SHIFT));
+		return tps_65023_write_reg(tps, reg, reg_ctrl);
+	} else {
+		/* VDCDC1 */
+		return tps_65023_write_reg(tps, reg, vsel);
+	}
+}
+
+/* Voltage set is not permitted on VDCDC2/3 */
+static struct regulator_ops tps65023_fixed_ops = {
+	.is_enabled	= tps65023_dcdc_is_enabled,
+	.enable		= tps65023_dcdc_enable,
+	.disable	= tps65023_dcdc_disable,
+	.get_voltage	= tps65023_fixed_get_voltage,
+};
+
+/* Operations permitted on VDCDC1 and LDO1/2 */
+static struct regulator_ops tps65023_adjustable_ops = {
+	.is_enabled	= tps65023_dcdc_is_enabled,
+	.enable		= tps65023_dcdc_enable,
+	.disable	= tps65023_dcdc_disable,
+	.get_voltage	= tps65023_dcdc_get_voltage,
+	.set_voltage	= tps65023_dcdc_set_voltage,
+};
+
+static
+int tps_65023_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	static int desc_id;
+	const struct tps_info *info = (void *)id->driver_data;
+	struct regulator_init_data *init_data;
+	struct regulator_dev *rdev;
+	struct tps *tps;
+	int i;
+	int num_regulators = 0;
+	unsigned char reg_val;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	/**
+	 * init_data points to array of regulator_init structures
+	 * coming from the board-evm file.
+	 */
+	init_data = client->dev.platform_data;
+
+	if (!init_data)
+		return -EIO;
+
+	tps = kzalloc(sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	tps->client = client;
+
+	for (i = 0; i < TPS65023_NUM_REGULATOR; i++, info++, init_data++) {
+		/* Store regulator specific information */
+		tps->info[i] = info;
+
+		tps->desc[i].name = info->name;
+		tps->desc[i].id = desc_id++;
+		tps->desc[i].ops = (info->fixed ? &tps65023_fixed_ops
+					: &tps65023_adjustable_ops);
+		tps->desc[i].type = REGULATOR_VOLTAGE;
+		tps->desc[i].owner = THIS_MODULE;
+
+		/* Register the regulators */
+		rdev = regulator_register(&tps->desc[i], &client->dev,
+								init_data, tps);
+		if (IS_ERR(rdev)) {
+			dev_err(&client->dev, "failed to register %s\n",
+				id->name);
+			kfree(tps);
+			return PTR_ERR(rdev);
+		}
+
+		/* Save regulator for cleanup */
+		tps->rdev[i] = rdev;
+	}
+
+	i2c_set_clientdata(client, tps);
+
+	return 0;
+}
+
+/**
+ * tps_65023_remove - TPS65023 driver i2c remove handler
+ * @client: i2c driver client device structure
+ *
+ * Unregister TPS driver as an i2c client device driver
+ */
+static int __devexit tps_65023_remove(struct i2c_client *client)
+{
+	struct tps *tps = i2c_get_clientdata(client);
+
+	regulator_unregister(tps->rdev);
+	/* clear the client data in i2c */
+	i2c_set_clientdata(client, NULL);
+	kfree(tps);
+
+	return 0;
+}
+
+/* Supported voltage values for regulators */
+static const u16 VDCDC1_VSEL_table[] = {
+	800, 825, 850, 875,
+	900, 925, 950, 975,
+	1000, 1025, 1050, 1075,
+	1100, 1125, 1150, 1175,
+	1200, 1225, 1250, 1275,
+	1300, 1325, 1350, 1375,
+	1400, 1425, 1450, 1475,
+	1500, 1525, 1550, 1600,
+};
+
+static const u16 LDO1_VSEL_table[] = {
+	1000, 1100, 1300, 1800,
+	2200, 2600, 2800, 3150,
+ };
+
+static const u16 LDO2_VSEL_table[] = {
+	1050, 1200, 1300, 1800,
+	2500, 2800, 3000, 3300,
+ };
+
+/*
+ * These regulators have the same register structure, and differ
+ * primarily according to supported voltages and default settings.
+ */
+static const struct tps_info tps65023_regs[] = {
+	{
+	.name = "VDCDC1",
+	.min_uV		=  800000,
+	.max_uV		= 1600000,
+	.fixed = 0,
+	.table_len = ARRAY_SIZE(VDCDC1_VSEL_table),
+	.table = VDCDC1_VSEL_table,
+	},
+	{
+	.name = "VDCDC2",
+	.min_uV		=  3300000,
+	.max_uV		= 3300000,
+	.fixed = 1,
+	.table_len = 0,
+	},
+	{
+	.name = "VDCDC3",
+	.min_uV		=  1800000,
+	.max_uV		= 1800000,
+	.fixed = 1,
+	.table_len = 0,
+	},
+	{
+	.name = "LDO1",
+	.min_uV		= 1000000,
+	.max_uV		= 3150000,
+	.fixed = 0,
+	.table_len = ARRAY_SIZE(LDO1_VSEL_table),
+	.table = LDO1_VSEL_table,
+	},
+	{
+	.name = "LDO2",
+	.min_uV		= 1000000,
+	.max_uV		= 3150000,
+	.fixed = 0,
+	.table_len = ARRAY_SIZE(LDO2_VSEL_table),
+	.table = LDO2_VSEL_table,
+	},
+};
+
+static const struct i2c_device_id tps_65023_id = {
+	.name = "tps65023",
+	.driver_data = (unsigned long) &tps65023_regs[0],
+};
+
+MODULE_DEVICE_TABLE(i2c, tps_65023_id);
+
+static struct i2c_driver tps_65023_i2c_driver = {
+	.driver = {
+		.name	= "tps_65023_pwr",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tps_65023_probe,
+	.remove		= __devexit_p(tps_65023_remove),
+	.id_table	= &tps_65023_id,
+};
+
+/**
+ * tps_65023_init
+ *
+ * Module init function
+ */
+static int __init tps_65023_init(void)
+{
+	return i2c_add_driver(&tps_65023_i2c_driver);
+}
+late_initcall(tps_65023_init);
+
+/**
+ * tps_65023_cleanup
+ *
+ * Module exit function
+ */
+static void __exit tps_65023_cleanup(void)
+{
+	i2c_del_driver(&tps_65023_i2c_driver);
+}
+module_exit(tps_65023_cleanup);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("TPS65023 voltage regulator driver");
+MODULE_LICENSE("GPLv2");
--
1.6.2.4

