From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 3/4] omap3: add common twl configurations for vdd1
 and vdd2
Date: Wed, 22 Feb 2012 12:47:55 +0200
Message-ID: <1329907675.4102.488.camel@sokoban>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
	 <1329733568-26676-4-git-send-email-t-kristo@ti.com> <871upn4tzf.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9EwMC/gFa4q7uFLHz7Fj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50603 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab2BVKsE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 05:48:04 -0500
In-Reply-To: <871upn4tzf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--=-9EwMC/gFa4q7uFLHz7Fj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-02-21 at 16:00 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> > to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> > are needed by DVFS.
> >
> > Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
> > - SWCS019L : TWL4030 ES3.1 Data Manual rev L
> > - SWCS030E : TWL5030 ES1.2 Data Manual rev E
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Do you have a similar patch for OMAP4 support?

It looks like OMAP4 support requires some changes to the twl-regulator /
twl-core in addition to the twl-common.c. I have these available (just
created them), should I post these out? Attached here for reference in
case you need to test something quickly.

-Tero


--=-9EwMC/gFa4q7uFLHz7Fj
Content-Disposition: attachment;
	filename*0="0001-regulator-twl6030-add-support-for-vdd1-vdd2-and-vdd3.pat";
	filename*1="ch"
Content-Type: text/x-patch;
	name="0001-regulator-twl6030-add-support-for-vdd1-vdd2-and-vdd3.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 4bee5804e8f20af94ecfe170dd4c5df984bdca6c Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 22 Feb 2012 12:36:58 +0200
Subject: [PATCH 1/2] regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators

vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
regulator voltages can only be controlled through the smartreflex
voltage channel, thus the support for the voltage_get and set is
minimal and requires external controller.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/mfd/twl-core.c            |   15 ++++++++++++++
 drivers/regulator/twl-regulator.c |   39 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h           |    5 ++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index fae5f76..c788e36 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -949,6 +949,21 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	/* twl6030 regulators */
 	if (twl_has_regulator() && twl_class_is_6030() &&
 			!(features & TWL6025_SUBCLASS)) {
+		child = add_regulator(TWL6030_REG_VDD1, pdata->vdd1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD2, pdata->vdd2,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD3, pdata->vdd3,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 0afc9e1a..55a0e4d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -561,6 +561,32 @@ static struct regulator_ops twl4030smps_ops = {
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
+static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
+	int max_uV, unsigned *selector)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->set_voltage)
+		return info->set_voltage(info->data, min_uV);
+
+	return 0;
+}
+
+static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->get_voltage)
+		return info->get_voltage(info->data);
+
+	return 0;
+}
+
+static struct regulator_ops twl6030coresmps_ops = {
+	.set_voltage	= twl6030coresmps_set_voltage,
+	.get_voltage	= twl6030coresmps_get_voltage,
+};
+
 static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -918,6 +944,16 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
+#define TWL6030_ADJUSTABLE_SMPS(label) { \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030coresmps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
 #define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
@@ -1019,6 +1055,9 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
+	TWL6030_ADJUSTABLE_SMPS(VDD1),
+	TWL6030_ADJUSTABLE_SMPS(VDD2),
+	TWL6030_ADJUSTABLE_SMPS(VDD3),
 	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300),
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 08a82d3..f66c031 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -712,6 +712,9 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vaux1;
 	struct regulator_init_data		*vaux2;
 	struct regulator_init_data		*vaux3;
+	struct regulator_init_data		*vdd1;
+	struct regulator_init_data		*vdd2;
+	struct regulator_init_data		*vdd3;
 	/* TWL4030 LDO regulators */
 	struct regulator_init_data		*vpll1;
 	struct regulator_init_data		*vpll2;
@@ -720,8 +723,6 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vsim;
 	struct regulator_init_data		*vaux4;
 	struct regulator_init_data		*vio;
-	struct regulator_init_data		*vdd1;
-	struct regulator_init_data		*vdd2;
 	struct regulator_init_data		*vintana1;
 	struct regulator_init_data		*vintana2;
 	struct regulator_init_data		*vintdig;
-- 
1.7.4.1


--=-9EwMC/gFa4q7uFLHz7Fj
Content-Disposition: attachment;
	filename*0="0002-arm-omap4-add-common-twl-configurations-for-vdd1-vdd.pat";
	filename*1="ch"
Content-Type: text/x-patch;
	name="0002-arm-omap4-add-common-twl-configurations-for-vdd1-vdd.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 463f0e24eb89d7f14112379df04b6d86eb2a4e97 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 22 Feb 2012 12:40:40 +0200
Subject: [PATCH 2/2] arm: omap4: add common twl configurations for vdd1, vdd2 and vdd3

VDD1 is used for MPU voltage, VDD2 is for IVA and VDD3 is for CORE.
These are needed by DVFS. This patch also adds external controller
support for these regulators, the default I2C control channel can't
be used to modify the voltages for these regulators on TWL6030.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   82 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 0c453e7..f19793e 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -349,6 +349,70 @@ static struct regulator_init_data omap4_clk32kg_idata = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_vdd1_supply[] = {
+	REGULATOR_SUPPLY("vcc", "mpu.0"),
+};
+
+static struct regulator_consumer_supply omap4_vdd2_supply[] = {
+	REGULATOR_SUPPLY("vcc", "iva.0"),
+};
+
+static struct regulator_consumer_supply omap4_vdd3_supply[] = {
+	REGULATOR_SUPPLY("vcc", "l3_main.0"),
+};
+
+static struct regulator_init_data omap4_vdd1 = {
+	.constraints = {
+		.name			= "vdd_mpu",
+		.min_uV			= 500000,
+		.max_uV			= 1500000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd1_supply),
+	.consumer_supplies		= omap4_vdd1_supply,
+};
+
+static struct regulator_init_data omap4_vdd2 = {
+	.constraints = {
+		.name			= "vdd_iva",
+		.min_uV			= 500000,
+		.max_uV			= 1500000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd2_supply),
+	.consumer_supplies		= omap4_vdd2_supply,
+};
+
+static struct regulator_init_data omap4_vdd3 = {
+	.constraints = {
+		.name			= "vdd_core",
+		.min_uV			= 500000,
+		.max_uV			= 1500000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap4_vdd3_supply),
+	.consumer_supplies		= omap4_vdd3_supply,
+};
+
+
+static struct twl_regulator_driver_data omap4_vdd1_drvdata = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
+static struct twl_regulator_driver_data omap4_vdd2_drvdata = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
+static struct twl_regulator_driver_data omap4_vdd3_drvdata = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
@@ -357,6 +421,24 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 	if (!pmic_data->irq_end)
 		pmic_data->irq_end = TWL6030_IRQ_END;
 
+	if (!pmic_data->vdd1) {
+		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
+		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
+		pmic_data->vdd1 = &omap4_vdd1;
+	}
+
+	if (!pmic_data->vdd2) {
+		omap4_vdd2.driver_data = &omap4_vdd2_drvdata;
+		omap4_vdd2_drvdata.data = voltdm_lookup("iva");
+		pmic_data->vdd2 = &omap4_vdd2;
+	}
+
+	if (!pmic_data->vdd3) {
+		omap4_vdd3.driver_data = &omap4_vdd3_drvdata;
+		omap4_vdd3_drvdata.data = voltdm_lookup("core");
+		pmic_data->vdd3 = &omap4_vdd3;
+	}
+
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
 		pmic_data->usb = &omap4_usb_pdata;
-- 
1.7.4.1


--=-9EwMC/gFa4q7uFLHz7Fj--
