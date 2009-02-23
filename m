From: David Brownell <david-b@pacbell.net>
Subject: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage enumeration
Date: Mon, 23 Feb 2009 12:54:13 -0800
Message-ID: <200902231254.13990.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <20090210224851.GA6408@sirena.org.uk> <200902231245.44360.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:32334 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751847AbZBWVAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 16:00:14 -0500
In-Reply-To: <200902231245.44360.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Update previously-posted twl4030 regulator driver to export
supported voltages to upper layers using a new mechanism.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/twl4030-regulator.c |   72 ++++++++++++++------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -42,7 +42,6 @@ struct twlreg_info {
 
 	/* chip constraints on regulator behavior */
 	u16			min_mV;
-	u16			max_mV;
 
 	/* used by regulator core */
 	struct regulator_desc	desc;
@@ -262,6 +261,24 @@ static const u16 VDAC_VSEL_table[] = {
 };
 
 
+static int twl4030ldo_count_voltages(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+
+	return info->table_len ? : 1;
+}
+
+static int twl4030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			mV;
+
+	mV = info->table[index];
+	if (IS_UNSUP(mV))
+		return -ESRCH;
+	return LDO_MV(mV) * 1000;
+}
+
 static int
 twl4030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 {
@@ -276,6 +293,8 @@ twl4030ldo_set_voltage(struct regulator_
 			continue;
 		uV = LDO_MV(mV) * 1000;
 
+		/* REVISIT for VAUX2, first match may not be best/lowest */
+
 		/* use the first in-range value */
 		if (min_uV <= uV && uV <= max_uV)
 			return twl4030reg_write(info, VREG_DEDICATED, vsel);
@@ -297,6 +316,9 @@ static int twl4030ldo_get_voltage(struct
 }
 
 static struct regulator_ops twl4030ldo_ops = {
+	.count_voltages	= twl4030ldo_count_voltages,
+	.list_voltage	= twl4030ldo_list_voltage,
+
 	.set_voltage	= twl4030ldo_set_voltage,
 	.get_voltage	= twl4030ldo_get_voltage,
 
@@ -314,6 +336,13 @@ static struct regulator_ops twl4030ldo_o
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
@@ -322,6 +351,9 @@ static int twl4030fixed_get_voltage(stru
 }
 
 static struct regulator_ops twl4030fixed_ops = {
+	.count_voltages	= twl4030ldo_count_voltages,
+	.list_voltage	= twl4030fixed_list_voltage,
+
 	.get_voltage	= twl4030fixed_get_voltage,
 
 	.enable		= twl4030reg_enable,
@@ -353,7 +385,6 @@ static struct regulator_ops twl4030fixed
 	.base = offset, \
 	.id = num, \
 	.min_mV = mVolts, \
-	.max_mV = mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
@@ -402,14 +433,11 @@ static int twl4030reg_probe(struct platf
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
@@ -423,10 +451,6 @@ static int twl4030reg_probe(struct platf
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
@@ -471,36 +495,6 @@ static struct platform_driver twl4030reg
 
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
