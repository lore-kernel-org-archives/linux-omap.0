From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Tue, 13 Jan 2009 16:19:28 -0800
Message-ID: <200901131619.28700.david-b@pacbell.net>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:34258 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755907AbZANATb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 19:19:31 -0500
In-Reply-To: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk

Feedback-in-the-form-of-a-patch ...

- Dave



Fives various problems with the latest tps6235x driver patch:

 - Remove most board-specific comments, policy, and infrastructure
 - Let it compile as a module; useful for built tests etc
 - Support the other five values of "x", not just "2" and "3"
 - Implement the missing register read/write operations
 - Partial bugfix to is_enabled() ... fault handling is unclear

Initialization still looks iffy to me; it's making assumptions that
may not be correct in any given system.  There's a comment saying how
to address that using the regulator_init_data.

---
 drivers/regulator/Kconfig              |   12 -
 drivers/regulator/tps6235x-regulator.c |  353 ++++++++++++++++++-------------
 2 files changed, 211 insertions(+), 154 deletions(-)

--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -81,13 +81,11 @@ config REGULATOR_DA903X
 	  Dialog Semiconductor DA9030/DA9034 PMIC.
 
 config REGULATOR_TPS6235X
-	bool "TPS6235X Power regulator for OMAP3EVM"
-	depends on I2C=y
+	tristate "TI TPS6235x Power regulators"
+	depends on I2C
 	help
-	  This driver supports the voltage regulators provided by TPS6235x chips.
-	  The TPS62352 and TPS62353 are mounted on PR785 Power module card for
-	  providing voltage regulator functions. The PR785 Power board from
-	  Texas Instruments Inc is a TPS6235X based power card used with OMAP3
-	  EVM boards.
+	  This driver supports TPS6235x voltage regulator chips, for values
+	  of "x" from 0 to 6.  These are buck converters which support TI's
+	  hardware based "SmartReflex" dynamic voltage scaling.
 
 endif
--- a/drivers/regulator/tps6235x-regulator.c
+++ b/drivers/regulator/tps6235x-regulator.c
@@ -19,39 +19,17 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 
-int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val);
-int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val);
-extern struct regulator_consumer_supply tps62352_core_consumers;
-extern struct regulator_consumer_supply tps62352_mpu_consumers;
-
-/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
-All voltages given in millivolts */
-#define	TPS62352_MIN_CORE_VOLT	750
-#define	TPS62352_MAX_CORE_VOLT	1537
-#define	TPS62353_MIN_MPU_VOLT	750
-#define	TPS62353_MAX_MPU_VOLT	1537
 
-/* Register bit settings */
-#define	TPS6235X_EN_DCDC	(0x1 << 0x7)
-#define	TPS6235X_VSM_MSK	(0x3F)
-#define	TPS6235X_EN_SYN_MSK	(0x1 << 0x5)
-#define	TPS6235X_SW_VOLT_MSK	(0x1 << 0x4)
-#define	TPS6235X_PWR_OK_MSK	(0x1 << 0x5)
-#define	TPS6235X_OUT_DIS_MSK	(0x1 << 0x6)
-#define	TPS6235X_GO_MSK		(0x1 << 0x7)
-
-#define	MODULE_NAME		"tps_6235x_pwr"
 /*
  * These chips are often used in OMAP-based systems.
  *
  * This driver implements software-based resource control for various
  * voltage regulators.  This is usually augmented with state machine
  * based control.
- */
-
-/* LDO control registers ... offset is from the base of its register bank.
- * The first three registers of all power resource banks help hardware to
- * manage the various resource groups.
+ *
+ * For now, all regulator operations apply to VSEL1 (the "ceiling"),
+ * instead of VSEL0 (the "floor") which is used for low power modes.
+ * Also, this *assumes* only software mode control is used...
  */
 
 #define	TPS6235X_REG_VSEL0	0
@@ -59,37 +37,74 @@ All voltages given in millivolts */
 #define	TPS6235X_REG_CTRL1	2
 #define	TPS6235X_REG_CTRL2	3
 
-/* Device addresses for TPS devices */
-#define	TPS_62352_CORE_ADDR	0x4A
-#define	TPS_62353_MPU_ADDR	0x48
+/* VSEL bitfields (EN_DCDC is shared) */
+#define TPS6235X_EN_DCDC	BIT(7)
+#define TPS6235X_LIGHTPFM	BIT(6)
+#define TPS6235X_VSM_MSK	(0x3F)
 
-int omap_i2c_match_child(struct device *dev, void *data);
+/* CTRL1 bitfields */
+#define TPS6235X_EN_SYNC	BIT(5)
+#define TPS6235X_HW_nSW		BIT(4)
+/* REVISIT plus mode controls */
+
+/* CTRL2 bitfields */
+#define TPS6235X_PWR_OK_MSK	BIT(5)
+#define TPS6235X_OUT_DIS_MSK	BIT(6)
+#define TPS6235X_GO_MSK		BIT(7)
+
+struct tps_info {
+	unsigned		min_uV;
+	unsigned		max_uV;
+	unsigned		mult_uV;
+	bool			fixed;
+};
+
+struct tps {
+	struct regulator_desc	desc;
+	struct i2c_client	*client;
+	struct regulator_dev	*rdev;
+	const struct tps_info	*info;
+};
+
+
+static inline int tps_6235x_read_reg(struct tps *tps, u8 reg, u8 *val)
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
+static inline int tps_6235x_write_reg(struct tps *tps, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(tps->client, reg, val);
+}
 
 static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
 {
 	unsigned char vsel1;
 	int ret;
-	struct i2c_client *tps_info	=
-			rdev_get_drvdata(dev);
-	ret = tps_6235x_read_reg(tps_info, TPS6235X_REG_VSEL1, &vsel1);
-	ret &= TPS6235X_EN_DCDC;
-	if (ret)
-		return 1;
-	else
-		return 0;
+	struct tps *tps = rdev_get_drvdata(dev);
+
+	ret = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
+	/* REVISIT we need to be able to report errors here ... */
+
+	return !!(vsel1 & TPS6235X_EN_DCDC);
 }
 
 static int tps6235x_dcdc_enable(struct regulator_dev *dev)
 {
 	unsigned char vsel1;
 	int ret;
+	struct tps *tps = rdev_get_drvdata(dev);
 
-	struct i2c_client *client = rdev_get_drvdata(dev);
-
-	ret = tps_6235x_read_reg(client, TPS6235X_REG_VSEL1, &vsel1);
+	ret = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
 	if (ret == 0) {
 		vsel1 |= TPS6235X_EN_DCDC;
-		ret = tps_6235x_write_reg(client, TPS6235X_REG_VSEL1, vsel1);
+		ret = tps_6235x_write_reg(tps, TPS6235X_REG_VSEL1, vsel1);
 	}
 	return ret;
 }
@@ -98,164 +113,216 @@ static int tps6235x_dcdc_disable(struct 
 {
 	unsigned char vsel1;
 	int ret;
-	struct	i2c_client *client = rdev_get_drvdata(dev);
+	struct tps *tps = rdev_get_drvdata(dev);
 
-	ret = tps_6235x_read_reg(client, TPS6235X_REG_VSEL1, &vsel1);
+	ret = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
 	if (ret == 0) {
 		vsel1 &= ~(TPS6235X_EN_DCDC);
-		ret = tps_6235x_write_reg(client, TPS6235X_REG_VSEL1, vsel1);
+		ret = tps_6235x_write_reg(tps, TPS6235X_REG_VSEL1, vsel1);
 	}
 	return ret;
 }
 
 static int tps6235x_dcdc_get_voltage(struct regulator_dev *dev)
 {
-	struct	i2c_client *tps_info = rdev_get_drvdata(dev);
+	struct tps *tps = rdev_get_drvdata(dev);
+	const struct tps_info *info = tps->info;
+	int status;
 	unsigned char vsel1;
-	unsigned int volt;
 
 	/* Read the VSEL1 register to get VSM */
-	tps_6235x_read_reg(tps_info, TPS6235X_REG_VSEL1, &vsel1);
-	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
-	/* To cut out floating point operation we will multiply by 25
-	divide by 2 */
-	volt = (((vsel1 & TPS6235X_VSM_MSK) * 25) / 2) + TPS62352_MIN_CORE_VOLT;
+	status = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
+	if (status < 0)
+		return status;
 
-	return volt * 1000;
+	return info->min_uV + ((vsel1 & TPS6235X_VSM_MSK) * info->mult_uV);
 }
 
 static int tps6235x_dcdc_set_voltage(struct regulator_dev *dev,
 				int min_uV, int max_uV)
 {
+	struct tps *tps = rdev_get_drvdata(dev);
+	const struct tps_info *info = tps->info;
 	unsigned char vsel1;
-	unsigned int volt;
-	struct	i2c_client *tps_info = rdev_get_drvdata(dev);
-	unsigned int millivolts = min_uV / 1000;
+	unsigned step;
+	int status;
 
-	/* check if the millivolts is within range */
-	if ((millivolts < TPS62352_MIN_CORE_VOLT) ||
-		(millivolts > TPS62352_MAX_CORE_VOLT))
+	/* adjust to match supported range, fail if out of range */
+	if (min_uV < info->min_uV)
+		min_uV = info->min_uV;
+	if (max_uV > info->max_uV)
+		max_uV = info->min_uV;
+	if (min_uV > max_uV)
 		return -EINVAL;
 
-	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
-	volt = millivolts - TPS62352_MIN_CORE_VOLT;
-	volt /= 25;
-	volt *= 2;
-	vsel1 = ((TPS6235X_EN_DCDC) | (volt & TPS6235X_VSM_MSK));
-	tps_6235x_write_reg(tps_info, TPS6235X_REG_VSEL1, vsel1);
-	return 0;
+	/* compute and sanity-check voltage step multiplier */
+	step = DIV_ROUND_UP(min_uV - info->min_uV, info->mult_uV);
+	if ((info->min_uV + (step * info->mult_uV)) > max_uV)
+		return -EINVAL;
+
+	status = tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vsel1);
+	if (status < 0)
+		return status;
+
+	/* update voltage */
+	vsel1 &= ~TPS6235X_VSM_MSK;
+	vsel1 |= step;
+	return tps_6235x_write_reg(tps, TPS6235X_REG_VSEL1, vsel1);
 }
 
-static struct regulator_ops tps62352_dcdc_ops = {
-	.is_enabled = tps6235x_dcdc_is_enabled,
-	.get_voltage = tps6235x_dcdc_get_voltage,
-	.set_voltage = tps6235x_dcdc_set_voltage,
-};
+/* tps6345{0,2,4,5} have some parameters hard-wired */
+static struct regulator_ops tps6235x_fixed_dcdc_ops = {
+	.is_enabled	= tps6235x_dcdc_is_enabled,
+	.get_voltage	= tps6235x_dcdc_get_voltage,
+	.set_voltage	= tps6235x_dcdc_set_voltage,
 
-static struct regulator_ops tps62353_dcdc_ops = {
-	.is_enabled = tps6235x_dcdc_is_enabled,
-	.enable = tps6235x_dcdc_enable,
-	.disable = tps6235x_dcdc_disable,
-	.get_voltage = tps6235x_dcdc_get_voltage,
-	.set_voltage = tps6235x_dcdc_set_voltage,
+	/* REVISIT these can support regulator mode operations too */
 };
 
-static struct regulator_desc regulators[] = {
-	{
-		.name = "tps62352",
-		.id = 2,
-		.ops = &tps62352_dcdc_ops,
-		.type = REGULATOR_VOLTAGE,
-		.owner = THIS_MODULE,
-	},
-	{
-		.name = "tps62353",
-		.id = 3,
-		.ops = &tps62353_dcdc_ops,
-		.type = REGULATOR_VOLTAGE,
-		.owner = THIS_MODULE,
-	},
-};
+/* tps6345{1,3,6} are more programmable */
+static struct regulator_ops tps6235x_dcdc_ops = {
+	.is_enabled	= tps6235x_dcdc_is_enabled,
+	.enable		= tps6235x_dcdc_enable,
+	.disable	= tps6235x_dcdc_disable,
+	.get_voltage	= tps6235x_dcdc_get_voltage,
+	.set_voltage	= tps6235x_dcdc_set_voltage,
 
-static const char *regulator_consumer_name[] = {
-			"vdd2",
-			"vdd1",
+	/* REVISIT these can support regulator mode operations too */
 };
 
 static
 int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct  regulator_dev           *rdev = NULL;
+	static int desc_id;
+
+	const struct tps_info *info = (void *)id->driver_data;
+	struct regulator_init_data *init_data;
+	struct regulator_dev *rdev;
+	struct tps *tps;
 	unsigned char reg_val;
-	struct device *dev_child = NULL;
 
-	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	init_data = client->dev.platform_data;
+	if (!init_data)
+		return -EIO;
+
+	tps = kzalloc(sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	tps->desc.name = id->name;
+	tps->desc.id = desc_id++;
+	tps->desc.ops = info->fixed ? &tps6235x_fixed_dcdc_ops : &tps6235x_dcdc_ops;
+	tps->desc.type = REGULATOR_VOLTAGE;
+	tps->desc.owner = THIS_MODULE;
+
+	tps->client = client;
+	tps->info = info;
+
+	/* FIXME board init code should provide init_data->driver_data
+	 * saying how to configure this regulator:  how big is the
+	 * inductor (affects light PFM mode optimization), slew rate,
+	 * PLL multiplier, and so forth.
+	 */
+	tps_6235x_read_reg(tps, TPS6235X_REG_CTRL2, &reg_val);
 	reg_val |= (TPS6235X_OUT_DIS_MSK | TPS6235X_GO_MSK);
-	tps_6235x_write_reg(client, TPS6235X_REG_CTRL2, reg_val);
-	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
+	tps_6235x_write_reg(tps, TPS6235X_REG_CTRL2, reg_val);
+	tps_6235x_read_reg(tps, TPS6235X_REG_CTRL2, &reg_val);
 
 	if (reg_val & TPS6235X_PWR_OK_MSK)
 		dev_dbg(&client->dev, "Power is OK  %x\n", reg_val);
-	else {
+	else
 		dev_dbg(&client->dev, "Power not in range = %x\n", reg_val);
-		return -EIO;
-	}
-
-	/* Register the regulators */
-	dev_child = device_find_child(client->adapter->dev.parent,
-			(void *)regulator_consumer_name[id->driver_data],
-			omap_i2c_match_child);
-	rdev = regulator_register(&regulators[id->driver_data],
-			dev_child, client);
 
+	/* Register the regulator */
+	rdev = regulator_register(&tps->desc, &client->dev, tps);
 	if (IS_ERR(rdev)) {
-		dev_err(dev_child, "failed to register %s\n",
-			regulator_consumer_name[id->driver_data]);
+		dev_err(&client->dev, "failed to register %s\n", id->name);
+		kfree(tps);
 		return PTR_ERR(rdev);
 	}
 
-	/* Set the regulator platform data for unregistration later on */
-	i2c_set_clientdata(client, rdev);
+	/* Save regulator for cleanup */
+	tps->rdev = rdev;
+	i2c_set_clientdata(client, tps);
 
 	return 0;
 }
 
-/**
- * tps_6235x_remove - TPS6235x driver i2c remove handler
- * @client: i2c driver client device structure
- *
- * Unregister  TPS driver as an i2c client device driver
- */
-static int __exit tps_6235x_remove(struct i2c_client *client)
+static int __devexit tps_6235x_remove(struct i2c_client *client)
 {
-	struct  regulator_dev   *rdev = NULL;
-
-	if (!client->adapter)
-		return -ENODEV; /* our client isn't attached */
+	struct tps *tps = i2c_get_clientdata(client);
 
-	rdev = (struct  regulator_dev *)i2c_get_clientdata(client);
-	regulator_unregister(rdev);
-	/* clear the client data in i2c */
+	regulator_unregister(tps->rdev);
+	kfree(tps);
 	i2c_set_clientdata(client, NULL);
-
 	return 0;
 }
 
+/*
+ * These regulators have the same register structure, and differ
+ * primarily according to supported voltages and default settings.
+ */
+static const struct tps_info tps62350_info = {
+	.min_uV		=  750000,
+	.max_uV		= 1537500,
+	.mult_uV	=   12500,
+	.fixed		= true,
+};
+static const struct tps_info tps62351_info = {
+	.min_uV		=  900000,
+	.max_uV		= 1687500,
+	.mult_uV	=   12500,
+};
+static const struct tps_info tps62352_info = {
+	.min_uV		=  750000,
+	.max_uV		= 1437500,
+	.mult_uV	=   12500,
+	.fixed		= true,
+};
+static const struct tps_info tps62353_info = {
+	.min_uV		=  750000,
+	.max_uV		= 1537500,
+	.mult_uV	=   12500,
+};
+static const struct tps_info tps62354_info = {
+	.min_uV		=  750000,
+	.max_uV		= 1537500,
+	.mult_uV	=   12500,
+	.fixed		= true,
+};
+static const struct tps_info tps62355_info = {
+	.min_uV		=  750000,
+	.max_uV		= 1537500,
+	.mult_uV	=   12500,
+	.fixed		= true,
+};
+static const struct tps_info tps62356_info = {
+	.min_uV		= 1500000,
+	.max_uV		= 1975000,
+	.mult_uV	=   25000,
+};
+
 static const struct i2c_device_id tps_6235x_id[] = {
-	{ "tps62352", 0},
-	{ "tps62353", 1},
+	{ "tps62350", (unsigned long) &tps62350_info, },
+	{ "tps62351", (unsigned long) &tps62351_info, },
+	{ "tps62352", (unsigned long) &tps62352_info, },
+	{ "tps62353", (unsigned long) &tps62353_info, },
+	{ "tps62354", (unsigned long) &tps62354_info, },
+	{ "tps62355", (unsigned long) &tps62355_info, },
+	{ "tps62356", (unsigned long) &tps62356_info, },
 	{},
 };
-
 MODULE_DEVICE_TABLE(i2c, tps_6235x_id);
 
 static struct i2c_driver tps_6235x_i2c_driver = {
 	.driver = {
-		.name	=	MODULE_NAME,
-		.owner	=	THIS_MODULE,
+		.name	= "tps_6235x_pwr"
 	},
 	.probe		= tps_6235x_probe,
-	.remove		= __exit_p(tps_6235x_remove),
+	.remove		= __devexit_p(tps_6235x_remove),
 	.id_table	= tps_6235x_id,
 };
 
@@ -266,15 +333,9 @@ static struct i2c_driver tps_6235x_i2c_d
  */
 static int __init tps_6235x_init(void)
 {
-	int err;
-
-	err = i2c_add_driver(&tps_6235x_i2c_driver);
-	if (err) {
-		printk(KERN_ERR "Failed to register " MODULE_NAME ".\n");
-		return err;
-	}
-	return 0;
+	return i2c_add_driver(&tps_6235x_i2c_driver);
 }
+subsys_initcall(tps_6235x_init);
 
 
 /**
@@ -286,10 +347,8 @@ static void __exit tps_6235x_cleanup(voi
 {
 	i2c_del_driver(&tps_6235x_i2c_driver);
 }
-
-late_initcall(tps_6235x_init);
 module_exit(tps_6235x_cleanup);
 
 MODULE_AUTHOR("Texas Instruments");
-MODULE_DESCRIPTION("TPS6235x based linux driver");
+MODULE_DESCRIPTION("TPS6235x voltage regulator driver");
 MODULE_LICENSE("GPL");
