From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/5] regulator: twl: fix twl6030 regulator is_enabled
Date: Fri,  1 Apr 2011 10:22:44 +0530
Message-ID: <1301633566-5212-4-git-send-email-nm@ti.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45169 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590Ab1DAExY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:53:24 -0400
Received: by gxk23 with SMTP id 23so1637514gxk.14
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:53:23 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

From: Saquib Herman <saquib@ti.com>

With TWL6030, it is not enough to ensure that the regulator is the
group of P1 group (CPU/Linux), but we need to check the state as far
as APP is concerned as well.

Split the current is_enabled to 6030 and 4030 specific ones. This
split impacts few macros and variables as well, but sets up the
stage for further fixes to set_mode and get_status in subsequent
patches.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Saquib Herman <saquib@ti.com>
---
 drivers/regulator/twl-regulator.c |   61 ++++++++++++++++++++++++++++---------
 1 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 2e88865..11d2e08 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -80,6 +80,10 @@ struct twlreg_info {
 #define TWL6030_CFG_STATE_OFF	0x00
 #define TWL6030_CFG_STATE_ON	0x01
 #define TWL6030_CFG_STATE_GRP_SHIFT	5
+#define TWL6030_CFG_STATE_APP_SHIFT	2
+#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
+#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
+						TWL6030_CFG_STATE_APP_SHIFT)
 
 static inline int
 twlreg_read(struct twlreg_info *info, unsigned slave_subgp, unsigned offset)
@@ -123,18 +127,31 @@ static int twlreg_grp(struct regulator_dev *rdev)
 #define P2_GRP_6030	BIT(1)		/* "peripherals" */
 #define P1_GRP_6030	BIT(0)		/* CPU/Linux */
 
-static int twlreg_is_enabled(struct regulator_dev *rdev)
+static int twl4030reg_is_enabled(struct regulator_dev *rdev)
 {
 	int	state = twlreg_grp(rdev);
 
 	if (state < 0)
 		return state;
 
-	if (twl_class_is_4030())
-		state &= P1_GRP_4030;
-	else
-		state &= P1_GRP_6030;
-	return state;
+	return state & P1_GRP_4030;
+}
+
+static int twl6030reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp, val;
+
+	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
+	if (grp < 0)
+		return grp;
+
+	grp &= P1_GRP_6030;
+
+	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+	val = TWL6030_CFG_STATE_APP(val);
+
+	return grp && (val == TWL6030_CFG_STATE_ON);
 }
 
 static int twlreg_enable(struct regulator_dev *rdev)
@@ -406,7 +423,7 @@ static struct regulator_ops twl4030ldo_ops = {
 
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
-	.is_enabled	= twlreg_is_enabled,
+	.is_enabled	= twl4030reg_is_enabled,
 
 	.set_mode	= twlreg_set_mode,
 
@@ -464,7 +481,7 @@ static struct regulator_ops twl6030ldo_ops = {
 
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
-	.is_enabled	= twlreg_is_enabled,
+	.is_enabled	= twl6030reg_is_enabled,
 
 	.set_mode	= twlreg_set_mode,
 
@@ -490,14 +507,28 @@ static int twlfixed_get_voltage(struct regulator_dev *rdev)
 	return info->min_mV * 1000;
 }
 
-static struct regulator_ops twlfixed_ops = {
+static struct regulator_ops twl4030fixed_ops = {
+	.list_voltage	= twlfixed_list_voltage,
+
+	.get_voltage	= twlfixed_get_voltage,
+
+	.enable		= twlreg_enable,
+	.disable	= twlreg_disable,
+	.is_enabled	= twl4030reg_is_enabled,
+
+	.set_mode	= twlreg_set_mode,
+
+	.get_status	= twlreg_get_status,
+};
+
+static struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= twlfixed_list_voltage,
 
 	.get_voltage	= twlfixed_get_voltage,
 
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
-	.is_enabled	= twlreg_is_enabled,
+	.is_enabled	= twl6030reg_is_enabled,
 
 	.set_mode	= twlreg_set_mode,
 
@@ -507,7 +538,7 @@ static struct regulator_ops twlfixed_ops = {
 static struct regulator_ops twl6030_fixed_resource = {
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
-	.is_enabled	= twlreg_is_enabled,
+	.is_enabled	= twl6030reg_is_enabled,
 	.get_status	= twlreg_get_status,
 };
 
@@ -516,10 +547,10 @@ static struct regulator_ops twl6030_fixed_resource = {
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf, TWL4030)
+			remap_conf, TWL4030, twl4030fixed_ops)
 #define TWL6030_FIXED_LDO(label, offset, mVolts, num, turnon_delay) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			0x0, TWL6030)
+			0x0, TWL6030, twl6030fixed_ops)
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) { \
 	.base = offset, \
@@ -555,7 +586,7 @@ static struct regulator_ops twl6030_fixed_resource = {
 
 
 #define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
-		family) { \
+		family, operations) { \
 	.base = offset, \
 	.id = num, \
 	.min_mV = mVolts, \
@@ -565,7 +596,7 @@ static struct regulator_ops twl6030_fixed_resource = {
 		.name = #label, \
 		.id = family##_REG_##label, \
 		.n_voltages = 1, \
-		.ops = &twlfixed_ops, \
+		.ops = &operations, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		}, \
-- 
1.7.1

