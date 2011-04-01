From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 4/5] regulator: twl: add twl6030 get_status
Date: Fri,  1 Apr 2011 10:22:45 +0530
Message-ID: <1301633566-5212-5-git-send-email-nm@ti.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33320 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590Ab1DAExd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:53:33 -0400
Received: by yib18 with SMTP id 18so1534796yib.0
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:53:32 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

From: Saquib Herman <saquib@ti.com>

Current get_status logic does not support 6030 get_status.
The logic for 4030 is not reusable for 6030 as the status
check for 6030 now depends on the new CFG_STATE register.
We hence rename the old get_status as being specific to
4030 and remove the redundant check for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Saquib Herman <saquib@ti.com>
---
 drivers/regulator/twl-regulator.c |   44 +++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 11d2e08..d2f7e71 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -79,6 +79,8 @@ struct twlreg_info {
 /* TWL6030 LDO register values for CFG_STATE */
 #define TWL6030_CFG_STATE_OFF	0x00
 #define TWL6030_CFG_STATE_ON	0x01
+#define TWL6030_CFG_STATE_OFF2	0x02
+#define TWL6030_CFG_STATE_SLEEP	0x03
 #define TWL6030_CFG_STATE_GRP_SHIFT	5
 #define TWL6030_CFG_STATE_APP_SHIFT	2
 #define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
@@ -217,13 +219,10 @@ static int twlreg_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int twlreg_get_status(struct regulator_dev *rdev)
+static int twl4030reg_get_status(struct regulator_dev *rdev)
 {
 	int	state = twlreg_grp(rdev);
 
-	if (twl_class_is_6030())
-		return 0; /* FIXME return for 6030 regulator */
-
 	if (state < 0)
 		return state;
 	state &= 0x0f;
@@ -236,6 +235,33 @@ static int twlreg_get_status(struct regulator_dev *rdev)
 		: REGULATOR_STATUS_STANDBY;
 }
 
+static int twl6030reg_get_status(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			val;
+
+	val = twlreg_grp(rdev);
+	if (val < 0)
+		return val;
+
+	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+
+	switch (TWL6030_CFG_STATE_APP(val)) {
+	case TWL6030_CFG_STATE_ON:
+		return REGULATOR_STATUS_NORMAL;
+
+	case TWL6030_CFG_STATE_SLEEP:
+		return REGULATOR_STATUS_STANDBY;
+
+	case TWL6030_CFG_STATE_OFF:
+	case TWL6030_CFG_STATE_OFF2:
+	default:
+		break;
+	}
+
+	return REGULATOR_STATUS_OFF;
+}
+
 static int twlreg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -427,7 +453,7 @@ static struct regulator_ops twl4030ldo_ops = {
 
 	.set_mode	= twlreg_set_mode,
 
-	.get_status	= twlreg_get_status,
+	.get_status	= twl4030reg_get_status,
 };
 
 static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
@@ -485,7 +511,7 @@ static struct regulator_ops twl6030ldo_ops = {
 
 	.set_mode	= twlreg_set_mode,
 
-	.get_status	= twlreg_get_status,
+	.get_status	= twl6030reg_get_status,
 };
 
 /*----------------------------------------------------------------------*/
@@ -518,7 +544,7 @@ static struct regulator_ops twl4030fixed_ops = {
 
 	.set_mode	= twlreg_set_mode,
 
-	.get_status	= twlreg_get_status,
+	.get_status	= twl4030reg_get_status,
 };
 
 static struct regulator_ops twl6030fixed_ops = {
@@ -532,14 +558,14 @@ static struct regulator_ops twl6030fixed_ops = {
 
 	.set_mode	= twlreg_set_mode,
 
-	.get_status	= twlreg_get_status,
+	.get_status	= twl6030reg_get_status,
 };
 
 static struct regulator_ops twl6030_fixed_resource = {
 	.enable		= twlreg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
-	.get_status	= twlreg_get_status,
+	.get_status	= twl6030reg_get_status,
 };
 
 /*----------------------------------------------------------------------*/
-- 
1.7.1

