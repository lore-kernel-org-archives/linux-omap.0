From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 2/3] drm/tilcdc: slave: Add support for "i2c-slave" DT-parameter
Date: Tue, 13 Jan 2015 19:12:27 +0200
Message-ID: <a2977a32ee76ea5a1bc116d98d274de560d01986.1421167634.git.jsarha@ti.com>
References: <cover.1421167634.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37095 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbbAMRMm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 12:12:42 -0500
In-Reply-To: <cover.1421167634.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

It is more convenient to refer to the i2c slave encoder directly with
phandle than to refer to the i2c bus and to create the device "manually".

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/drm/tilcdc/slave.txt       |    4 +-
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   50 ++++++++++++--------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/drm/tilcdc/slave.txt b/Documentation/devicetree/bindings/drm/tilcdc/slave.txt
index 3d2c524..930550f 100644
--- a/Documentation/devicetree/bindings/drm/tilcdc/slave.txt
+++ b/Documentation/devicetree/bindings/drm/tilcdc/slave.txt
@@ -2,6 +2,8 @@ Device-Tree bindings for tilcdc DRM encoder slave output driver
 
 Required properties:
  - compatible: value should be "ti,tilcdc,slave".
+ - i2c-slave: phandle for the encoder slave device
+ or
  - i2c: the phandle for the i2c device the encoder slave is connected to
 
 Recommended properties:
@@ -12,7 +14,7 @@ Example:
 
 	hdmi {
 		compatible = "ti,tilcdc,slave";
-		i2c = <&i2c0>;
+		i2c-slave = <&tda19988>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
 	};
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 3775fd4..a1e2f86 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -25,6 +25,7 @@
 struct slave_module {
 	struct tilcdc_module base;
 	struct i2c_adapter *i2c;
+	struct i2c_client *slave;
 };
 #define to_slave_module(x) container_of(x, struct slave_module, base)
 
@@ -140,7 +141,12 @@ static struct drm_encoder *slave_encoder_create(struct drm_device *dev,
 
 	drm_encoder_helper_add(encoder, &slave_encoder_helper_funcs);
 
-	ret = drm_i2c_encoder_init(dev, to_encoder_slave(encoder), mod->i2c, &info);
+	if (mod->slave)
+		ret = drm_i2c_encoder_attach(dev, to_encoder_slave(encoder),
+					     mod->slave);
+	else
+		ret = drm_i2c_encoder_init(dev, to_encoder_slave(encoder),
+					   mod->i2c, &info);
 	if (ret)
 		goto fail;
 
@@ -309,12 +315,12 @@ static struct of_device_id slave_of_match[];
 static int slave_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *i2c_node;
+	struct device_node *slave_node;
 	struct slave_module *slave_mod;
 	struct tilcdc_module *mod;
 	struct pinctrl *pinctrl;
-	uint32_t i2c_phandle;
-	struct i2c_adapter *slavei2c;
+	struct i2c_adapter *slavei2c = NULL;
+	struct i2c_client *slave = NULL;
 	int ret = -EINVAL;
 
 	/* bail out early if no DT data: */
@@ -323,26 +329,29 @@ static int slave_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	/* Bail out early if i2c not specified */
-	if (of_property_read_u32(node, "i2c", &i2c_phandle)) {
-		dev_err(&pdev->dev, "could not get i2c bus phandle\n");
-		return ret;
-	}
-
-	i2c_node = of_find_node_by_phandle(i2c_phandle);
-	if (!i2c_node) {
-		dev_err(&pdev->dev, "could not get i2c bus node\n");
-		return ret;
+	slave_node = of_parse_phandle(node, "i2c-slave", 0);
+	if (slave_node) {
+		slave = of_find_i2c_device_by_node(slave_node);
+		of_node_put(slave_node);
+	} else {
+		struct device_node *i2c_node = of_parse_phandle(node, "i2c", 0);
+
+		if (!i2c_node) {
+			dev_err(&pdev->dev,
+				"phandle for i2c-slave or i2c not found\n");
+			return -ENODEV;
+		}
+		slavei2c = of_find_i2c_adapter_by_node(i2c_node);
+		of_node_put(i2c_node);
 	}
 
-	/* but defer the probe if it can't be initialized it might come later */
-	slavei2c = of_find_i2c_adapter_by_node(i2c_node);
-	of_node_put(i2c_node);
-
-	if (!slavei2c) {
+	/* defer the probe if either slave device or the i2c bus
+	   was not found, they might come later */
+	if (!slavei2c && !slave) {
 		ret = -EPROBE_DEFER;
 		tilcdc_slave_probedefer(true);
-		dev_err(&pdev->dev, "could not get i2c\n");
+		dev_info(&pdev->dev,
+			 "could not get i2c-slave or i2c, probe defered\n");
 		return ret;
 	}
 
@@ -358,6 +367,7 @@ static int slave_probe(struct platform_device *pdev)
 	mod->preferred_bpp = slave_info.bpp;
 
 	slave_mod->i2c = slavei2c;
+	slave_mod->slave = slave;
 
 	tilcdc_module_init(mod, "slave", &slave_module_ops);
 
-- 
1.7.9.5

