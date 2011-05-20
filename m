From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] regulator: twl6030: do not write to _GRP for regulator disable
Date: Fri, 20 May 2011 19:03:52 +0530
Message-ID: <1305898432-14939-3-git-send-email-balajitk@ti.com>
References: <1305898432-14939-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933946Ab1ETNfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:35:07 -0400
In-Reply-To: <1305898432-14939-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, Balaji T K <balajitk@ti.com>

TWL6030: regulator is disabled via VREG_STATE
TWL4030: regulator is disabled via VREG_GRP
Since there is nothing common, split twlreg_enable similar to other regulator_ops

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/regulator/twl-regulator.c |   47 +++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index abb40c6..4702b8a 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -194,7 +194,7 @@ static int twl6030reg_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int twlreg_disable(struct regulator_dev *rdev)
+static int twl4030reg_disable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
@@ -204,28 +204,25 @@ static int twlreg_disable(struct regulator_dev *rdev)
 	if (grp < 0)
 		return grp;
 
-	/* For 6030, set the off state for all grps enabled */
-	if (twl_class_is_6030()) {
-		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
-			(grp & (P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030)) <<
-				TWL6030_CFG_STATE_GRP_SHIFT |
-			TWL6030_CFG_STATE_OFF);
-		if (ret)
-			return ret;
-	}
-
-	if (twl_class_is_4030())
-		grp &= ~(P1_GRP_4030 | P2_GRP_4030 | P3_GRP_4030);
-	else
-		grp &= ~(P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030);
+	grp &= ~(P1_GRP_4030 | P2_GRP_4030 | P3_GRP_4030);
 
 	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 
-	/* Next, associate cleared grp in state register */
-	if (!ret && twl_class_is_6030())
-		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
-				grp << TWL6030_CFG_STATE_GRP_SHIFT |
-				TWL6030_CFG_STATE_OFF);
+	return ret;
+}
+
+static int twl6030reg_disable(struct regulator_dev *rdev)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int			grp = 0;
+	int			ret;
+
+	grp = P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030;
+
+	/* For 6030, set the off state for all grps enabled */
+	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			(grp) << TWL6030_CFG_STATE_GRP_SHIFT |
+			TWL6030_CFG_STATE_OFF);
 
 	return ret;
 }
@@ -485,7 +482,7 @@ static struct regulator_ops twl4030ldo_ops = {
 	.get_voltage	= twl4030ldo_get_voltage,
 
 	.enable		= twl4030reg_enable,
-	.disable	= twlreg_disable,
+	.disable	= twl4030reg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
 	.set_mode	= twl4030reg_set_mode,
@@ -543,7 +540,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.get_voltage	= twl6030ldo_get_voltage,
 
 	.enable		= twl6030reg_enable,
-	.disable	= twlreg_disable,
+	.disable	= twl6030reg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
 	.set_mode	= twl6030reg_set_mode,
@@ -576,7 +573,7 @@ static struct regulator_ops twl4030fixed_ops = {
 	.get_voltage	= twlfixed_get_voltage,
 
 	.enable		= twl4030reg_enable,
-	.disable	= twlreg_disable,
+	.disable	= twl4030reg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
 	.set_mode	= twl4030reg_set_mode,
@@ -590,7 +587,7 @@ static struct regulator_ops twl6030fixed_ops = {
 	.get_voltage	= twlfixed_get_voltage,
 
 	.enable		= twl6030reg_enable,
-	.disable	= twlreg_disable,
+	.disable	= twl6030reg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
 	.set_mode	= twl6030reg_set_mode,
@@ -600,7 +597,7 @@ static struct regulator_ops twl6030fixed_ops = {
 
 static struct regulator_ops twl6030_fixed_resource = {
 	.enable		= twl6030reg_enable,
-	.disable	= twlreg_disable,
+	.disable	= twl6030reg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 	.get_status	= twl6030reg_get_status,
 };
-- 
1.7.0.4

