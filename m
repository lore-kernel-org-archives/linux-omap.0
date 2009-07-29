From: balajitk@ti.com
Subject: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to create twl6030 regulators
Date: Wed, 29 Jul 2009 10:06:13 +0530
Message-ID: <1248842173-21821-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbZG2Egk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jul 2009 00:36:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.

This patch adds initial support for creating twl6030 PMIC
specific voltage regulators in the twl mfd driver.

Board specific regulator configurations will have to be passed from
respective board files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/mfd/twl-core.c  |   56 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/i2c/twl.h |   18 +++++++++++----
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f505537..747289c 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -76,9 +76,9 @@
 #define twl_has_gpio()	false
 #endif
 
-#if defined(CONFIG_REGULATOR_TWL4030) \
-	|| defined(CONFIG_REGULATOR_TWL4030_MODULE)
-#define twl_has_regulator()	true
+#if defined(CONFIG_REGULATOR_TWL) \
+	|| defined(CONFIG_REGULATOR_TWL_MODULE)
+#define twl_has_regulator() true
 #else
 #define twl_has_regulator()	false
 #endif
@@ -636,7 +636,7 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_regulator()) {
+	if (twl_has_regulator() && is_class_twl4030()) {
 		/*
 		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
 		if (IS_ERR(child))
@@ -659,7 +659,7 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_regulator() && usb_transceiver) {
+	if (twl_has_regulator() && is_class_twl4030() && usb_transceiver) {
 		static struct regulator_consumer_supply usb1v5 = {
 			.supply =	"usb1v5",
 		};
@@ -701,7 +701,8 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
 	}
 
 	/* maybe add LDOs that are omitted on cost-reduced parts */
-	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
+	if (twl_has_regulator() && is_class_twl4030()
+	  && !(features & TPS_SUBSET)) {
 		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
@@ -727,6 +728,49 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
+	/* twl6030 regulators */
+	if (twl_has_regulator() && is_class_twl4030()) {
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
index 53d9360..1f678ed 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -306,6 +306,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 #define TWL4030_INT_PWR_EDR2		0x6
 #define TWL4030_INT_PWR_SIH_CTRL	0x7
 
+
 /*----------------------------------------------------------------------*/
 
 /* Power bus message definitions */
@@ -424,18 +425,25 @@ struct twl_platform_data {
 	struct twl_keypad_data		*keypad;
 	struct twl_usb_data			*usb;
 
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

