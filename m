From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 2/3] mfd: lp873x: Add lp873x PMIC support
Date: Wed, 29 Jun 2016 21:14:26 +0530
Message-ID: <1467215067-6486-3-git-send-email-j-keerthy@ti.com>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The LP873X chip is a power management IC for Portable Navigation Systems
    and Tablet Computing devices. It contains the following components:

     - Regulators.
     - Configurable General Purpose Output Signals(GPO).

PMIC interacts with the main processor through i2c. PMIC has
couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
Converter Cores) and GPOs(General Purpose Output Signals).

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Added Author.
  * Added the mfd_cell for gpio.

Changes in v3:

  * Reordered the probe code.
  * Fixed Typo in Kconfig description.
  * Removed unused member from struct lp873x.

 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/lp873x.c       |  99 +++++++++++++++++
 include/linux/mfd/lp873x.h | 264 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9987d86..e68ac28 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1221,6 +1221,20 @@ config MFD_TPS65217
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65217.
 
+config MFD_LP873X
+	tristate "TI LP873X Power Management IC"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  If you say yes here then you get support for the LP873X series of
+	  power management integrated circuits(PMIC).
+	  These include voltage regulators, Thermal protection, Configurable
+	  general purpose outputs(GPO) that are used in portable devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lp873x.
+
 config MFD_TPS65218
 	tristate "TI TPS65218 Power Management chips"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2ba3ba3..7d9b965 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -22,6 +22,8 @@ obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
 obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
 
+obj-$(CONFIG_MFD_LP873X)	+= lp873x.o
+
 obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
new file mode 100644
index 0000000..54ed0ce
--- /dev/null
+++ b/drivers/mfd/lp873x.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Author: Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lp873x.h>
+
+static const struct regmap_config lp873x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = LP873X_REG_MAX,
+};
+
+static const struct mfd_cell lp873x_cells[] = {
+	{ .name = "lp873x-regulator", },
+	{ .name = "lp873x-gpio", },
+};
+
+static int lp873x_probe(struct i2c_client *client,
+			const struct i2c_device_id *ids)
+{
+	struct lp873x *lp873;
+	int ret;
+	unsigned int otpid;
+
+	lp873 = devm_kzalloc(&client->dev, sizeof(*lp873), GFP_KERNEL);
+	if (!lp873)
+		return -ENOMEM;
+
+	lp873->dev = &client->dev;
+
+	lp873->regmap = devm_regmap_init_i2c(client, &lp873x_regmap_config);
+	if (IS_ERR(lp873->regmap)) {
+		ret = PTR_ERR(lp873->regmap);
+		dev_err(lp873->dev, "Failed to initialize register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	mutex_init(&lp873->lp873_lock);
+
+	ret = regmap_read(lp873->regmap, LP873X_REG_OTP_REV, &otpid);
+	if (ret) {
+		dev_err(lp873->dev, "Failed to read OTP ID\n");
+		return ret;
+	}
+
+	lp873->rev = otpid & LP873X_OTP_REV_OTP_ID;
+	i2c_set_clientdata(client, lp873);
+	ret = mfd_add_devices(lp873->dev, PLATFORM_DEVID_AUTO, lp873x_cells,
+			      ARRAY_SIZE(lp873x_cells), NULL, 0, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id of_lp873x_match_table[] = {
+	{ .compatible = "ti,lp8733", },
+	{ .compatible = "ti,lp8732", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
+
+static const struct i2c_device_id lp873x_id_table[] = {
+	{ "lp873x", LP873X },
+	{ "lp8732", LP873X },
+	{ "lp8733", LP873X },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, lp873x_id_table);
+
+static struct i2c_driver lp873x_driver = {
+	.driver		= {
+		.name	= "lp873x",
+		.of_match_table = of_lp873x_match_table,
+	},
+	.probe		= lp873x_probe,
+	.id_table	= lp873x_id_table,
+};
+module_i2c_driver(lp873x_driver);
+
+MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
+MODULE_DESCRIPTION("LP873X chip family multi-function driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/lp873x.h b/include/linux/mfd/lp873x.h
new file mode 100644
index 0000000..fb7ec55
--- /dev/null
+++ b/include/linux/mfd/lp873x.h
@@ -0,0 +1,264 @@
+/*
+ * Functions to access LP873X power management chip.
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_MFD_LP873X_H
+#define __LINUX_MFD_LP873X_H
+
+#include <linux/i2c.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+/* LP873x chip id list */
+#define LP873X			0x00
+
+/* All register addresses */
+#define LP873X_REG_DEV_REV		0X00
+#define LP873X_REG_OTP_REV		0X01
+#define LP873X_REG_BUCK0_CTRL_1		0X02
+#define LP873X_REG_BUCK0_CTRL_2		0X03
+#define LP873X_REG_BUCK1_CTRL_1		0X04
+#define LP873X_REG_BUCK1_CTRL_2		0X05
+#define LP873X_REG_BUCK0_VOUT		0X06
+#define LP873X_REG_BUCK1_VOUT		0X07
+#define LP873X_REG_LDO0_CTRL		0X08
+#define LP873X_REG_LDO1_CTRL            0X09
+#define LP873X_REG_LDO0_VOUT		0X0A
+#define LP873X_REG_LDO1_VOUT		0X0B
+#define LP873X_REG_BUCK0_DELAY		0X0C
+#define LP873X_REG_BUCK1_DELAY		0X0D
+#define LP873X_REG_LDO0_DELAY		0X0E
+#define LP873X_REG_LDO1_DELAY		0X0F
+#define LP873X_REG_GPO_DELAY		0X10
+#define LP873X_REG_GPO2_DELAY		0X11
+#define LP873X_REG_GPO_CTRL		0X12
+#define LP873X_REG_CONFIG		0X13
+#define LP873X_REG_PLL_CTRL		0X14
+#define LP873X_REG_PGOOD_CTRL1		0X15
+#define LP873X_REG_PGOOD_CTRL2		0X16
+#define LP873X_REG_PG_FAULT		0X17
+#define LP873X_REG_RESET		0X18
+#define LP873X_REG_INT_TOP_1		0X19
+#define LP873X_REG_INT_TOP_2		0X1A
+#define LP873X_REG_INT_BUCK		0X1B
+#define LP873X_REG_INT_LDO		0X1C
+#define LP873X_REG_TOP_STAT		0X1D
+#define LP873X_REG_BUCK_STAT		0X1E
+#define LP873X_REG_LDO_STAT		0x1F
+#define LP873X_REG_TOP_MASK_1		0x20
+#define LP873X_REG_TOP_MASK_2		0x21
+#define LP873X_REG_BUCK_MASK		0x22
+#define LP873X_REG_LDO_MASK		0x23
+#define LP873X_REG_SEL_I_LOAD		0x24
+#define LP873X_REG_I_LOAD_2		0x25
+#define LP873X_REG_I_LOAD_1		0x26
+
+#define LP873X_REG_MAX			LP873X_REG_I_LOAD_1
+
+/* Register field definitions */
+#define LP873X_DEV_REV_DEV_ID			0xC0
+#define LP873X_DEV_REV_ALL_LAYER		0x30
+#define LP873X_DEV_REV_METAL_LAYER		0x0F
+
+#define LP873X_OTP_REV_OTP_ID			0xFF
+
+#define LP873X_BUCK0_CTRL_1_BUCK0_FPWM		BIT(3)
+#define LP873X_BUCK0_CTRL_1_BUCK0_RDIS_EN	BIT(2)
+#define LP873X_BUCK0_CTRL_1_BUCK0_EN_PIN_CTRL	BIT(1)
+#define LP873X_BUCK0_CTRL_1_BUCK0_EN		BIT(0)
+
+#define LP873X_BUCK0_CTRL_2_BUCK0_ILIM		0x38
+#define LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE	0x07
+
+#define LP873X_BUCK1_CTRL_1_BUCK1_FPWM		BIT(3)
+#define LP873X_BUCK1_CTRL_1_BUCK1_RDIS_EN	BIT(2)
+#define LP873X_BUCK1_CTRL_1_BUCK1_EN_PIN_CTRL	BIT(1)
+#define LP873X_BUCK1_CTRL_1_BUCK1_EN		BIT(0)
+
+#define LP873X_BUCK1_CTRL_2_BUCK1_ILIM		0x38
+#define LP873X_BUCK1_CTRL_2_BUCK1_SLEW_RATE	0x07
+
+#define LP873X_BUCK0_VOUT_BUCK0_VSET		0xFF
+
+#define LP873X_BUCK1_VOUT_BUCK1_VSET		0xFF
+
+#define LP873X_LDO0_CTRL_LDO0_RDIS_EN		BIT(2)
+#define LP873X_LDO0_CTRL_LDO0_EN_PIN_CTRL	BIT(1)
+#define LP873X_LDO0_CTRL_LDO0_EN		BIT(0)
+
+#define LP873X_LDO1_CTRL_LDO1_RDIS_EN		BIT(2)
+#define LP873X_LDO1_CTRL_LDO1_EN_PIN_CTRL	BIT(1)
+#define LP873X_LDO1_CTRL_LDO1_EN		BIT(0)
+
+#define LP873X_LDO0_VOUT_LDO0_VSET		0x1F
+
+#define LP873X_LDO1_VOUT_LDO1_VSET		0x1F
+
+#define LP873X_BUCK0_DELAY_BUCK0_SD_DELAY	0xF0
+#define LP873X_BUCK0_DELAY_BUCK0_SU_DELAY	0x0F
+
+#define LP873X_BUCK1_DELAY_BUCK1_SD_DELAY	0xF0
+#define LP873X_BUCK1_DELAY_BUCK1_SU_DELAY	0x0F
+
+#define LP873X_LDO0_DELAY_LDO0_SD_DELAY	0xF0
+#define LP873X_LDO0_DELAY_LDO0_SU_DELAY	0x0F
+
+#define LP873X_LDO1_DELAY_LDO1_SD_DELAY	0xF0
+#define LP873X_LDO1_DELAY_LDO1_SU_DELAY	0x0F
+
+#define LP873X_GPO_DELAY_GPO_SD_DELAY		0xF0
+#define LP873X_GPO_DELAY_GPO_SU_DELAY		0x0F
+
+#define LP873X_GPO2_DELAY_GPO2_SD_DELAY	0xF0
+#define LP873X_GPO2_DELAY_GPO2_SU_DELAY	0x0F
+
+#define LP873X_GPO_CTRL_GPO2_OD		BIT(6)
+#define LP873X_GPO_CTRL_GPO2_EN_PIN_CTRL	BIT(5)
+#define LP873X_GPO_CTRL_GPO2_EN		BIT(4)
+#define LP873X_GPO_CTRL_GPO_OD			BIT(2)
+#define LP873X_GPO_CTRL_GPO_EN_PIN_CTRL	BIT(1)
+#define LP873X_GPO_CTRL_GPO_EN			BIT(0)
+
+#define LP873X_CONFIG_SU_DELAY_SEL		BIT(6)
+#define LP873X_CONFIG_SD_DELAY_SEL		BIT(5)
+#define LP873X_CONFIG_CLKIN_PIN_SEL		BIT(4)
+#define LP873X_CONFIG_CLKIN_PD			BIT(3)
+#define LP873X_CONFIG_EN_PD			BIT(2)
+#define LP873X_CONFIG_TDIE_WARN_LEVEL		BIT(1)
+#define LP873X_EN_SPREAD_SPEC			BIT(0)
+
+#define LP873X_PLL_CTRL_EN_PLL			BIT(6)
+#define LP873X_EXT_CLK_FREQ			0x1F
+
+#define LP873X_PGOOD_CTRL1_PGOOD_POL		BIT(7)
+#define LP873X_PGOOD_CTRL1_PGOOD_OD		BIT(6)
+#define LP873X_PGOOD_CTRL1_PGOOD_WINDOW_LDO	BIT(5)
+#define LP873X_PGOOD_CTRL1_PGOOD_WINDOWN_BUCK	BIT(4)
+#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_LDO1	BIT(3)
+#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_LDO0	BIT(2)
+#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_BUCK1	BIT(1)
+#define LP873X_PGOOD_CTRL1_PGOOD_EN_PGOOD_BUCK0	BIT(0)
+
+#define LP873X_PGOOD_CTRL2_EN_PGOOD_TWARN	BIT(2)
+#define LP873X_PGOOD_CTRL2_EN_PG_FAULT_GATE	BIT(1)
+#define LP873X_PGOOD_CTRL2_PGOOD_MODE		BIT(0)
+
+#define LP873X_PG_FAULT_PG_FAULT_LDO1		BIT(3)
+#define LP873X_PG_FAULT_PG_FAULT_LDO0		BIT(2)
+#define LP873X_PG_FAULT_PG_FAULT_BUCK1		BIT(1)
+#define LP873X_PG_FAULT_PG_FAULT_BUCK0		BIT(0)
+
+#define LP873X_RESET_SW_RESET			BIT(0)
+
+#define LP873X_INT_TOP_1_PGOOD_INT		BIT(7)
+#define LP873X_INT_TOP_1_LDO_INT		BIT(6)
+#define LP873X_INT_TOP_1_BUCK_INT		BIT(5)
+#define LP873X_INT_TOP_1_SYNC_CLK_INT		BIT(4)
+#define LP873X_INT_TOP_1_TDIE_SD_INT		BIT(3)
+#define LP873X_INT_TOP_1_TDIE_WARN_INT		BIT(2)
+#define LP873X_INT_TOP_1_OVP_INT		BIT(1)
+#define LP873X_INT_TOP_1_I_MEAS_INT		BIT(0)
+
+#define LP873X_INT_TOP_2_RESET_REG_INT		BIT(0)
+
+#define LP873X_INT_BUCK_BUCK1_PG_INT		BIT(6)
+#define LP873X_INT_BUCK_BUCK1_SC_INT		BIT(5)
+#define LP873X_INT_BUCK_BUCK1_ILIM_INT		BIT(4)
+#define LP873X_INT_BUCK_BUCK0_PG_INT		BIT(2)
+#define LP873X_INT_BUCK_BUCK0_SC_INT		BIT(1)
+#define LP873X_INT_BUCK_BUCK0_ILIM_INT		BIT(0)
+
+#define LP873X_INT_LDO_LDO1_PG_INT		BIT(6)
+#define LP873X_INT_LDO_LDO1_SC_INT		BIT(5)
+#define LP873X_INT_LDO_LDO1_ILIM_INT		BIT(4)
+#define LP873X_INT_LDO_LDO0_PG_INT		BIT(2)
+#define LP873X_INT_LDO_LDO0_SC_INT		BIT(1)
+#define LP873X_INT_LDO_LDO0_ILIM_INT		BIT(0)
+
+#define LP873X_TOP_STAT_PGOOD_STAT		BIT(7)
+#define LP873X_TOP_STAT_SYNC_CLK_STAT		BIT(4)
+#define LP873X_TOP_STAT_TDIE_SD_STAT		BIT(3)
+#define LP873X_TOP_STAT_TDIE_WARN_STAT		BIT(2)
+#define LP873X_TOP_STAT_OVP_STAT		BIT(1)
+
+#define LP873X_BUCK_STAT_BUCK1_STAT		BIT(7)
+#define LP873X_BUCK_STAT_BUCK1_PG_STAT		BIT(6)
+#define LP873X_BUCK_STAT_BUCK1_ILIM_STAT	BIT(4)
+#define LP873X_BUCK_STAT_BUCK0_STAT		BIT(3)
+#define LP873X_BUCK_STAT_BUCK0_PG_STAT		BIT(2)
+#define LP873X_BUCK_STAT_BUCK0_ILIM_STAT	BIT(0)
+
+#define LP873X_LDO_STAT_LDO1_STAT		BIT(7)
+#define LP873X_LDO_STAT_LDO1_PG_STAT		BIT(6)
+#define LP873X_LDO_STAT_LDO1_ILIM_STAT		BIT(4)
+#define LP873X_LDO_STAT_LDO0_STAT		BIT(3)
+#define LP873X_LDO_STAT_LDO0_PG_STAT		BIT(2)
+#define LP873X_LDO_STAT_LDO0_ILIM_STAT		BIT(0)
+
+#define LP873X_TOP_MASK_1_PGOOD_INT_MASK	BIT(7)
+#define LP873X_TOP_MASK_1_SYNC_CLK_MASK	BIT(4)
+#define LP873X_TOP_MASK_1_TDIE_WARN_MASK	BIT(2)
+#define LP873X_TOP_MASK_1_I_MEAS_MASK		BIT(0)
+
+#define LP873X_TOP_MASK_2_RESET_REG_MASK	BIT(0)
+
+#define LP873X_BUCK_MASK_BUCK1_PGF_MASK	BIT(7)
+#define LP873X_BUCK_MASK_BUCK1_PGR_MASK	BIT(6)
+#define LP873X_BUCK_MASK_BUCK1_ILIM_MASK	BIT(4)
+#define LP873X_BUCK_MASK_BUCK0_PGF_MASK	BIT(3)
+#define LP873X_BUCK_MASK_BUCK0_PGR_MASK	BIT(2)
+#define LP873X_BUCK_MASK_BUCK0_ILIM_MASK	BIT(0)
+
+#define LP873X_LDO_MASK_LDO1_PGF_MASK		BIT(7)
+#define LP873X_LDO_MASK_LDO1_PGR_MASK		BIT(6)
+#define LP873X_LDO_MASK_LDO1_ILIM_MASK		BIT(4)
+#define LP873X_LDO_MASK_LDO0_PGF_MASK		BIT(3)
+#define LP873X_LDO_MASK_LDO0_PGR_MASK		BIT(2)
+#define LP873X_LDO_MASK_LDO0_ILIM_MASK		BIT(0)
+
+#define LP873X_SEL_I_LOAD_CURRENT_BUCK_SELECT	BIT(0)
+
+#define LP873X_I_LOAD_2_BUCK_LOAD_CURRENT	BIT(0)
+
+#define LP873X_I_LOAD_1_BUCK_LOAD_CURRENT	0xFF
+
+#define LP873X_MAX_REG_ID		LP873X_LDO_1
+
+/* Number of step-down converters available */
+#define LP873X_NUM_BUCK		2
+/* Number of LDO voltage regulators available */
+#define LP873X_NUM_LDO		2
+/* Number of total regulators available */
+#define LP873X_NUM_REGULATOR		(LP873X_NUM_BUCK + LP873X_NUM_LDO)
+
+enum lp873x_regulator_id {
+	/* BUCK's */
+	LP873X_BUCK_0,
+	LP873X_BUCK_1,
+	/* LDOs */
+	LP873X_LDO_0,
+	LP873X_LDO_1,
+};
+
+/**
+ * struct lp873x - state holder for the lp873x driver
+ * Device data may be used to access the LP873X chip
+ */
+struct lp873x {
+	struct device *dev;
+	u8 rev;
+	struct mutex lp873_lock;	/* lock guarding the data structure */
+	struct regmap *regmap;
+};
+#endif /*  __LINUX_MFD_LP873X_H */
-- 
1.9.1
