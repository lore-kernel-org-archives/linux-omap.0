From: balajitk@ti.com
Subject: [PATCH v4 08/08] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators
Date: Fri, 11 Dec 2009 21:36:54 +0530
Message-ID: <1260547614-24308-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933388AbZLKQGz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 11:06:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Balaji T K <balajitk@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.

This patch adds initial support for creating twl6030 PMIC
specific voltage regulators in the twl mfd driver.

Board specific regulator configurations will have to be passed from
respective board files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl-core.c  |   50 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/i2c/twl.h |   17 +++++++++++----
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 3d67321..42af794 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -614,7 +614,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_usb() && pdata->usb) {
+	if (twl_has_usb() && pdata->usb && twl_class_is_4030()) {
 
 		static struct regulator_consumer_supply usb1v5 = {
 			.supply =	"usb1v5",
@@ -694,7 +694,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_regulator()) {
+	if (twl_has_regulator() && twl_class_is_4030()) {
 		/*
 		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
 		if (IS_ERR(child))
@@ -718,7 +718,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	}
 
 	/* maybe add LDOs that are omitted on cost-reduced parts */
-	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
+	if (twl_has_regulator() && !(features & TPS_SUBSET)
+	  && twl_class_is_4030()) {
 		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
@@ -744,6 +745,49 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
+	/* twl6030 regulators */
+	if (twl_has_regulator() && twl_class_is_6030()) {
+		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VPP, pdata->vpp);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VUSIM, pdata->vusim);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VANA, pdata->vana);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VCXIO, pdata->vcxio);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDAC, pdata->vdac);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VUSB, pdata->vusb);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VAUX1_6030, pdata->vaux1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VAUX2_6030, pdata->vaux2);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VAUX3_6030, pdata->vaux3);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index dce4c22..d49c1c7 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -516,18 +516,25 @@ struct twl4030_platform_data {
 	struct twl4030_power_data		*power;
 	struct twl4030_codec_data		*codec;
 
-	/* LDO regulators */
+	/* LDO regulators common to TWL4030/TWL6030 */
 	struct regulator_init_data		*vdac;
+	struct regulator_init_data		*vaux1;
+	struct regulator_init_data		*vaux2;
+	struct regulator_init_data		*vaux3;
+	/* TWL4030 LDO regulators */
 	struct regulator_init_data		*vpll1;
 	struct regulator_init_data		*vpll2;
 	struct regulator_init_data		*vmmc1;
 	struct regulator_init_data		*vmmc2;
 	struct regulator_init_data		*vsim;
-	struct regulator_init_data		*vaux1;
-	struct regulator_init_data		*vaux2;
-	struct regulator_init_data		*vaux3;
 	struct regulator_init_data		*vaux4;
-
+	/* TWL6030 LDO regulators */
+	struct regulator_init_data              *vmmc;
+	struct regulator_init_data              *vpp;
+	struct regulator_init_data              *vusim;
+	struct regulator_init_data              *vana;
+	struct regulator_init_data              *vcxio;
+	struct regulator_init_data              *vusb;
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
 
-- 
1.5.4.7

