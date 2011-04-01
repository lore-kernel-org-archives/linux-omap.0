From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/5] regulator: twl: fix twl6030 enable/disable
Date: Fri,  1 Apr 2011 10:22:42 +0530
Message-ID: <1301633566-5212-2-git-send-email-nm@ti.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:32849 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab1DAExH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:53:07 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so1268381gyd.19
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:53:05 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

From: Saquib Herman <saquib@ti.com>

TWL6030 requires an additional register write to CFG_STATE register
to explicitly state that the regulator is in a certain state. Merely
associating the regulator with the group is not enough. Add the
required register field definitions and fix the handling for
TWL6030 enable/disable.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Saquib Herman <saquib@ti.com>
---
 drivers/regulator/twl-regulator.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6a29285..3e9060c 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -76,6 +76,11 @@ struct twlreg_info {
 #define VREG_BC_PROC		3
 #define VREG_BC_CLK_RST		4
 
+/* TWL6030 LDO register values for CFG_STATE */
+#define TWL6030_CFG_STATE_OFF	0x00
+#define TWL6030_CFG_STATE_ON	0x01
+#define TWL6030_CFG_STATE_GRP_SHIFT	5
+
 static inline int
 twlreg_read(struct twlreg_info *info, unsigned slave_subgp, unsigned offset)
 {
@@ -149,6 +154,11 @@ static int twlreg_enable(struct regulator_dev *rdev)
 
 	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 
+	if (!ret && twl_class_is_6030())
+		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+				grp << TWL6030_CFG_STATE_GRP_SHIFT |
+				TWL6030_CFG_STATE_ON);
+
 	udelay(info->delay);
 
 	return ret;
@@ -158,17 +168,36 @@ static int twlreg_disable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
+	int			ret;
 
 	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
 	if (grp < 0)
 		return grp;
 
+	/* For 6030, set the off state for all grps enabled */
+	if (twl_class_is_6030()) {
+		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			(grp & (P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030)) <<
+				TWL6030_CFG_STATE_GRP_SHIFT |
+			TWL6030_CFG_STATE_OFF);
+		if (ret)
+			return ret;
+	}
+
 	if (twl_class_is_4030())
 		grp &= ~(P1_GRP_4030 | P2_GRP_4030 | P3_GRP_4030);
 	else
 		grp &= ~(P1_GRP_6030 | P2_GRP_6030 | P3_GRP_6030);
 
-	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
+	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
+
+	/* Next, associate cleared grp in state register */
+	if (!ret && twl_class_is_6030())
+		ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+				grp << TWL6030_CFG_STATE_GRP_SHIFT |
+				TWL6030_CFG_STATE_OFF);
+
+	return ret;
 }
 
 static int twlreg_get_status(struct regulator_dev *rdev)
-- 
1.7.1

