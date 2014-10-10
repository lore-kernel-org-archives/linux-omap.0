From: Tero Kristo <t-kristo@ti.com>
Subject: [REPOST PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping platform data via pdata-quirks
Date: Fri, 10 Oct 2014 17:06:28 +0300
Message-ID: <1412949989-20186-2-git-send-email-t-kristo@ti.com>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49928 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaJJOGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 10:06:47 -0400
In-Reply-To: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, nm@ti.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Device tree based boot does not currently support DVFS voltage scaling,
as the VC/VP mapping is broken. This patch adds support to provide
platform data in the device tree boot case also, basically to pass the
function pointers to the vc/vp core for voltage changes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |    8 ++--
 arch/arm/mach-omap2/twl-common.c   |   88 ++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/twl-common.h   |    2 +
 3 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 90c88d4..03e4a86 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -311,10 +311,10 @@ void omap_auxdata_legacy_init(struct device *dev)
 	if (dev->platform_data)
 		return;
 
-	if (strcmp("twl4030-gpio", dev_name(dev)))
-		return;
-
-	dev->platform_data = &twl_gpio_auxdata;
+	if (!strcmp("twl4030-gpio", dev_name(dev)))
+		dev->platform_data = &twl_gpio_auxdata;
+	else
+		dev->platform_data = omap_twl_match_regulator(dev);
 }
 
 /*
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index b0d54da..50f6d33 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -210,17 +210,37 @@ static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
 	.set_voltage = twl_set_voltage,
 };
 
+struct pmic_drvdata_config {
+	const char *voltdm;
+	struct twl_regulator_driver_data *data;
+};
+
+static struct pmic_drvdata_config twl4030_vdd1 = {
+	.voltdm = "mpu_iva",
+	.data = &omap3_vdd1_drvdata,
+};
+
+static struct pmic_drvdata_config twl4030_vdd2 = {
+	.voltdm = "core",
+	.data = &omap3_vdd2_drvdata,
+};
+
+struct twl_regulator_driver_data
+*omap_pmic_get_drvdata(struct pmic_drvdata_config *conf)
+{
+	conf->data->data = voltdm_lookup(conf->voltdm);
+	return conf->data;
+}
+
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
 	if (!pmic_data->vdd1) {
-		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
-		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
+		omap3_vdd1.driver_data = omap_pmic_get_drvdata(&twl4030_vdd1);
 		pmic_data->vdd1 = &omap3_vdd1;
 	}
 	if (!pmic_data->vdd2) {
-		omap3_vdd2.driver_data = &omap3_vdd2_drvdata;
-		omap3_vdd2_drvdata.data = voltdm_lookup("core");
+		omap3_vdd2.driver_data = omap_pmic_get_drvdata(&twl4030_vdd2);
 		pmic_data->vdd2 = &omap3_vdd2;
 	}
 
@@ -440,6 +460,21 @@ static struct twl_regulator_driver_data omap4_vdd3_drvdata = {
 	.set_voltage = twl_set_voltage,
 };
 
+static struct pmic_drvdata_config twl6030_vdd1 = {
+	.voltdm = "mpu",
+	.data = &omap4_vdd1_drvdata,
+};
+
+static struct pmic_drvdata_config twl6030_vdd2 = {
+	.voltdm = "iva",
+	.data = &omap4_vdd2_drvdata,
+};
+
+static struct pmic_drvdata_config twl6030_vdd3 = {
+	.voltdm = "core",
+	.data = &omap4_vdd3_drvdata,
+};
+
 static struct regulator_consumer_supply omap4_v1v8_supply[] = {
 	REGULATOR_SUPPLY("vio", "1-004b"),
 };
@@ -475,24 +510,57 @@ static struct regulator_init_data omap4_v2v1_idata = {
 	.consumer_supplies	= omap4_v2v1_supply,
 };
 
+static struct of_device_id twl_regulator_ids[] = {
+	{ .compatible = "ti,twl4030-vdd1", .data = &twl4030_vdd1, },
+	{ .compatible = "ti,twl4030-vdd2", .data = &twl4030_vdd2, },
+	{ .compatible = "ti,twl6030-vdd1", .data = &twl6030_vdd1, },
+	{ .compatible = "ti,twl6030-vdd2", .data = &twl6030_vdd2, },
+	{ .compatible = "ti,twl6030-vdd3", .data = &twl6030_vdd3, },
+	{}
+};
+
+/**
+ * omap_twl_match_regulator - match regulator against a device
+ * @dev: device to check for regulator match
+ *
+ * Checks if the device provided is a supported regulator device. If yes,
+ * will initialize the corresponding platform data structure for it and
+ * return it for the caller to use. Returns NULL if not supported,
+ * a pointer to the regulator platform data struct otherwise.
+ */
+void *omap_twl_match_regulator(struct device *dev)
+{
+	const struct of_device_id *match;
+	struct pmic_drvdata_config *conf;
+
+	if (!dev->of_node)
+		return NULL;
+
+	match = of_match_node(twl_regulator_ids, dev->of_node);
+
+	if (!match)
+		return NULL;
+
+	conf = (struct pmic_drvdata_config *)match->data;
+
+	return omap_pmic_get_drvdata(conf);
+}
+
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
 	if (!pmic_data->vdd1) {
-		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
-		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
+		omap4_vdd1.driver_data = omap_pmic_get_drvdata(&twl6030_vdd1);
 		pmic_data->vdd1 = &omap4_vdd1;
 	}
 
 	if (!pmic_data->vdd2) {
-		omap4_vdd2.driver_data = &omap4_vdd2_drvdata;
-		omap4_vdd2_drvdata.data = voltdm_lookup("iva");
+		omap4_vdd2.driver_data = omap_pmic_get_drvdata(&twl6030_vdd2);
 		pmic_data->vdd2 = &omap4_vdd2;
 	}
 
 	if (!pmic_data->vdd3) {
-		omap4_vdd3.driver_data = &omap4_vdd3_drvdata;
-		omap4_vdd3_drvdata.data = voltdm_lookup("core");
+		omap4_vdd3.driver_data = omap_pmic_get_drvdata(&twl6030_vdd3);
 		pmic_data->vdd3 = &omap4_vdd3;
 	}
 
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 24b65d0..b392ade 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -55,6 +55,8 @@ void omap4_pmic_init(const char *pmic_type,
 		    struct twl4030_platform_data *pmic_data,
 		    struct i2c_board_info *devices, int nr_devices);
 
+void *omap_twl_match_regulator(struct device *dev);
+
 void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
 
-- 
1.7.9.5

