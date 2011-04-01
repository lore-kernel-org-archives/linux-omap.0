From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/5] regulator: twl: add twl6030 set_mode
Date: Fri,  1 Apr 2011 10:22:46 +0530
Message-ID: <1301633566-5212-6-git-send-email-nm@ti.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43211 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751942Ab1DAExl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:53:41 -0400
Received: by mail-yi0-f42.google.com with SMTP id 12so1666960yib.15
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:53:40 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

From: Saquib Herman <saquib@ti.com>

Current set_mode logic does not support 6030. The logic for 4030 is
not reusable for 6030 as the mode setting for 6030 now uses the new
CFG_STATE register. We hence rename the old get_status as being
specific to 4030.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Saquib Herman <saquib@ti.com>
---
 drivers/regulator/twl-regulator.c |   42 +++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index d2f7e71..bf7c402 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -262,15 +262,12 @@ static int twl6030reg_get_status(struct regulator_dev *rdev)
 	return REGULATOR_STATUS_OFF;
 }
 
-static int twlreg_set_mode(struct regulator_dev *rdev, unsigned mode)
+static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	unsigned		message;
 	int			status;
 
-	if (twl_class_is_6030())
-		return 0; /* FIXME return for 6030 regulator */
-
 	/* We can only set the mode through state machine commands... */
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -299,6 +296,35 @@ static int twlreg_set_mode(struct regulator_dev *rdev, unsigned mode)
 			message & 0xff, TWL4030_PM_MASTER_PB_WORD_LSB);
 }
 
+static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
+{
+	struct twlreg_info	*info = rdev_get_drvdata(rdev);
+	int grp;
+	int val;
+
+	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
+
+	if (grp < 0)
+		return grp;
+
+	/* Compose the state register settings */
+	val = grp << TWL6030_CFG_STATE_GRP_SHIFT;
+	/* We can only set the mode through state machine commands... */
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val |= TWL6030_CFG_STATE_ON;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		val |= TWL6030_CFG_STATE_SLEEP;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE, val);
+}
+
 /*----------------------------------------------------------------------*/
 
 /*
@@ -451,7 +477,7 @@ static struct regulator_ops twl4030ldo_ops = {
 	.disable	= twlreg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
-	.set_mode	= twlreg_set_mode,
+	.set_mode	= twl4030reg_set_mode,
 
 	.get_status	= twl4030reg_get_status,
 };
@@ -509,7 +535,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
-	.set_mode	= twlreg_set_mode,
+	.set_mode	= twl6030reg_set_mode,
 
 	.get_status	= twl6030reg_get_status,
 };
@@ -542,7 +568,7 @@ static struct regulator_ops twl4030fixed_ops = {
 	.disable	= twlreg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
 
-	.set_mode	= twlreg_set_mode,
+	.set_mode	= twl4030reg_set_mode,
 
 	.get_status	= twl4030reg_get_status,
 };
@@ -556,7 +582,7 @@ static struct regulator_ops twl6030fixed_ops = {
 	.disable	= twlreg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
 
-	.set_mode	= twlreg_set_mode,
+	.set_mode	= twl6030reg_set_mode,
 
 	.get_status	= twl6030reg_get_status,
 };
-- 
1.7.1

