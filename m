From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap 2/5] regulator: twl4030 voltage enumeration
Date: Wed, 11 Mar 2009 04:21:39 -0800
Message-ID: <200903110521.39984.david-b@pacbell.net>
References: <200903110518.34945.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:44243 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752020AbZCKMct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 08:32:49 -0400
In-Reply-To: <200903110518.34945.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>
Subject: regulator: twl4030 voltage enumeration (v2)

Update previously-posted twl4030 regulator driver to export
supported voltages to upper layers using a new mechanism.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 drivers/regulator/twl4030-regulator.c |   62 +++++++++++---------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -42,7 +42,6 @@ struct twlreg_info {
 
 	/* chip constraints on regulator behavior */
 	u16			min_mV;
-	u16			max_mV;
 
 	/* used by regulator core */
 	struct regulator_desc	desc;
@@ -262,6 +261,14 @@ static const u16 VDAC_VSEL_table[] = {
 };
 
 
+static int twl4030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			mV = info->table[index];
+
+	return IS_UNSUP(mV) ? 0 : (LDO_MV(mV) * 1000);
+}
+
 static int
 twl4030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 {
@@ -276,6 +283,8 @@ twl4030ldo_set_voltage(struct regulator_
 			continue;
 		uV = LDO_MV(mV) * 1000;
 
+		/* REVISIT for VAUX2, first match may not be best/lowest */
+
 		/* use the first in-range value */
 		if (min_uV <= uV && uV <= max_uV)
 			return twl4030reg_write(info, VREG_DEDICATED, vsel);
@@ -297,6 +306,8 @@ static int twl4030ldo_get_voltage(struct
 }
 
 static struct regulator_ops twl4030ldo_ops = {
+	.list_voltage	= twl4030ldo_list_voltage,
+
 	.set_voltage	= twl4030ldo_set_voltage,
 	.get_voltage	= twl4030ldo_get_voltage,
 
@@ -314,6 +325,13 @@ static struct regulator_ops twl4030ldo_o
 /*
  * Fixed voltage LDOs don't have a VSEL field to update.
  */
+static int twl4030fixed_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	return info->min_mV * 1000;
+}
+
 static int twl4030fixed_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -322,6 +340,8 @@ static int twl4030fixed_get_voltage(stru
 }
 
 static struct regulator_ops twl4030fixed_ops = {
+	.list_voltage	= twl4030fixed_list_voltage,
+
 	.get_voltage	= twl4030fixed_get_voltage,
 
 	.enable		= twl4030reg_enable,
@@ -343,6 +363,7 @@ static struct regulator_ops twl4030fixed
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
+		.n_voltages = ARRAY_SIZE(label##_VSEL_table), \
 		.ops = &twl4030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
@@ -353,10 +374,10 @@ static struct regulator_ops twl4030fixed
 	.base = offset, \
 	.id = num, \
 	.min_mV = mVolts, \
-	.max_mV = mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
+		.n_voltages = 1, \
 		.ops = &twl4030fixed_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
@@ -402,14 +423,11 @@ static int twl4030reg_probe(struct platf
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	int				min_uV, max_uV;
 
 	for (i = 0, info = NULL; i < ARRAY_SIZE(twl4030_regs); i++) {
 		if (twl4030_regs[i].desc.id != pdev->id)
 			continue;
 		info = twl4030_regs + i;
-		min_uV = info->min_mV * 1000;
-		max_uV = info->max_mV * 1000;
 		break;
 	}
 	if (!info)
@@ -423,10 +441,6 @@ static int twl4030reg_probe(struct platf
 	 * this driver and the chip itself can actually do.
 	 */
 	c = &initdata->constraints;
-	if (!c->min_uV || c->min_uV < min_uV)
-		c->min_uV = min_uV;
-	if (!c->max_uV || c->max_uV > max_uV)
-		c->max_uV = max_uV;
 	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
 	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
 				| REGULATOR_CHANGE_MODE
@@ -471,36 +485,6 @@ static struct platform_driver twl4030reg
 
 static int __init twl4030reg_init(void)
 {
-	unsigned i, j;
-
-	/* determine min/max voltage constraints, taking into account
-	 * whether set_voltage() will use the "unsupported" settings
-	 */
-	for (i = 0; i < ARRAY_SIZE(twl4030_regs); i++) {
-		struct twlreg_info	*info = twl4030_regs + i;
-		const u16		*table;
-
-		/* fixed-voltage regulators */
-		if (!info->table_len)
-			continue;
-
-		/* LDO regulators: */
-		for (j = 0, table = info->table;
-				j < info->table_len;
-				j++, table++) {
-			u16		mV = *table;
-
-			if (IS_UNSUP(mV))
-				continue;
-			mV = LDO_MV(mV);
-
-			if (info->min_mV == 0 || info->min_mV > mV)
-				info->min_mV = mV;
-			if (info->max_mV < mV)
-				info->max_mV = mV;
-		}
-	}
-
 	return platform_driver_register(&twl4030reg_driver);
 }
 subsys_initcall(twl4030reg_init);
