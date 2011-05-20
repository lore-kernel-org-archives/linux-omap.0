From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] regulator: twl6030: do not write to _GRP for regulator enable
Date: Fri, 20 May 2011 19:03:51 +0530
Message-ID: <1305898432-14939-2-git-send-email-balajitk@ti.com>
References: <1305898432-14939-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56678 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933851Ab1ETNfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:35:03 -0400
In-Reply-To: <1305898432-14939-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, Balaji T K <balajitk@ti.com>

TWL6030: regulator is enabled via VREG_STATE
TWL4030: regulator is enabled via VREG_GRP
Since there is nothing common, split twlreg_enable similar to other regulator_ops

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/regulator/twl-regulator.c |   39 +++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 2a808c2..abb40c6 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -156,7 +156,7 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
 	return grp && (val == TWL6030_CFG_STATE_ON);
 }
 
-static int twlreg_enable(struct regulator_dev *rdev)
+static int twl4030reg_enable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
@@ -166,17 +166,28 @@ static int twlreg_enable(struct regulator_dev *rdev)
 	if (grp < 0)
 		return grp;
 
-	if (twl_class_is_4030())
-		grp |= P1_GRP_4030;
-	else
-		grp |= P1_GRP_6030;
+	grp |= P1_GRP_4030;
 
 	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 
-	if (!ret && twl_class_is_6030())
-		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
-				grp << TWL6030_CFG_STATE_GRP_SHIFT |
-				TWL6030_CFG_STATE_ON);
+	udelay(info->delay);
+
+	return ret;
+}
+
+static int twl6030reg_enable(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp;
+	int			ret;
+
+	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
+	if (grp < 0)
+		return grp;
+
+	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			grp << TWL6030_CFG_STATE_GRP_SHIFT |
+			TWL6030_CFG_STATE_ON);
 
 	udelay(info->delay);
 
@@ -473,7 +484,7 @@ static struct regulator_ops twl4030ldo_ops = {
 	.set_voltage	= twl4030ldo_set_voltage,
 	.get_voltage	= twl4030ldo_get_voltage,
 
-	.enable		= twlreg_enable,
+	.enable		= twl4030reg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
@@ -531,7 +542,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.set_voltage	= twl6030ldo_set_voltage,
 	.get_voltage	= twl6030ldo_get_voltage,
 
-	.enable		= twlreg_enable,
+	.enable		= twl6030reg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
@@ -564,7 +575,7 @@ static struct regulator_ops twl4030fixed_ops = {
 
 	.get_voltage	= twlfixed_get_voltage,
 
-	.enable		= twlreg_enable,
+	.enable		= twl4030reg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
@@ -578,7 +589,7 @@ static struct regulator_ops twl6030fixed_ops = {
 
 	.get_voltage	= twlfixed_get_voltage,
 
-	.enable		= twlreg_enable,
+	.enable		= twl6030reg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
@@ -588,7 +599,7 @@ static struct regulator_ops twl6030fixed_ops = {
 };
 
 static struct regulator_ops twl6030_fixed_resource = {
-	.enable		= twlreg_enable,
+	.enable		= twl6030reg_enable,
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 	.get_status	= twl6030reg_get_status,
-- 
1.7.0.4

