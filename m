From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised DRM encoder
Date: Thu, 26 Feb 2015 16:55:32 +0200
Message-ID: <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
References: <cover.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41750 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbbBZO4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 09:56:11 -0500
In-Reply-To: <cover.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

Add support for an external compontised DRM encoder. The external
encoder can be connected to tilcdc trough device tree graph binding.
The binding document for tilcdc has been updated. The support has only
been tested with tda998x encoder, but other encoders should work too
with a little tweaking.

I got the idea and some lines of code from Jean-Francois Moine's
"drm/tilcdc: Change the interface with the tda998x driver"-patch.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++++++
 drivers/gpu/drm/tilcdc/Makefile                    |   1 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  33 +++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  56 ++++++++---
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   2 +
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 105 +++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  24 +++++
 7 files changed, 235 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h

diff --git a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
index fff10da..2136ee8 100644
--- a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
@@ -18,6 +18,12 @@ Optional properties:
  - max-pixelclock: The maximum pixel clock that can be supported
    by the lcd controller in KHz.
 
+Optional nodes:
+
+ - port/ports: to describe a connection to an external encoder. The
+   binding follows Documentation/devicetree/bindings/graph.txt and
+   suppors a single port with a single endpoint.
+
 Example:
 
 	fb: fb@4830e000 {
@@ -26,4 +32,25 @@ Example:
 		interrupt-parent = <&intc>;
 		interrupts = <36>;
 		ti,hwmods = "lcdc";
+
+		port {
+			lcdc_0: endpoint@0 {
+				remote-endpoint = <&hdmi_0>;
+			};
+		};
+	};
+
+	tda19988: tda19988 {
+		compatible = "nxp,tda998x";
+		reg = <0x70>;
+
+		pinctrl-names = "default", "off";
+		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
+		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
+
+		port {
+			hdmi_0: endpoint@0 {
+				remote-endpoint = <&lcdc_0>;
+			};
+		};
 	};
diff --git a/drivers/gpu/drm/tilcdc/Makefile b/drivers/gpu/drm/tilcdc/Makefile
index 44485f9..e1f738b 100644
--- a/drivers/gpu/drm/tilcdc/Makefile
+++ b/drivers/gpu/drm/tilcdc/Makefile
@@ -7,6 +7,7 @@ tilcdc-y := \
 	tilcdc_crtc.o \
 	tilcdc_tfp410.o \
 	tilcdc_panel.o \
+	tilcdc_external.o \
 	tilcdc_drv.o
 
 obj-$(CONFIG_DRM_TILCDC)	+= tilcdc.o
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index c2d5980..7d07733 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -37,6 +37,9 @@ struct tilcdc_crtc {
 
 	/* for deferred fb unref's: */
 	struct drm_flip_work unref_work;
+
+	/* Only set if an external encoder is connected */
+	bool simulate_vesa_sync;
 };
 #define to_tilcdc_crtc(x) container_of(x, struct tilcdc_crtc, base)
 
@@ -214,6 +217,28 @@ static bool tilcdc_crtc_mode_fixup(struct drm_crtc *crtc,
 		const struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
 {
+	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
+
+	if (!tilcdc_crtc->simulate_vesa_sync)
+		return true;
+
+	/*
+	 * tilcdc does not generate VESA-compliant sync but aligns
+	 * VS on the second edge of HS instead of first edge.
+	 * We use adjusted_mode, to fixup sync by aligning both rising
+	 * edges and add HSKEW offset to fix the sync.
+	 */
+	adjusted_mode->hskew = mode->hsync_end - mode->hsync_start;
+	adjusted_mode->flags |= DRM_MODE_FLAG_HSKEW;
+
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC) {
+		adjusted_mode->flags |= DRM_MODE_FLAG_PHSYNC;
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_NHSYNC;
+	} else {
+		adjusted_mode->flags |= DRM_MODE_FLAG_NHSYNC;
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_PHSYNC;
+	}
+
 	return true;
 }
 
@@ -534,6 +559,14 @@ void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
 	tilcdc_crtc->info = info;
 }
 
+void tilcdc_crtc_set_simulate_vesa_sync(struct drm_crtc *crtc,
+					bool simulate_vesa_sync)
+{
+	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
+
+	tilcdc_crtc->simulate_vesa_sync = simulate_vesa_sync;
+}
+
 void tilcdc_crtc_update_clk(struct drm_crtc *crtc)
 {
 	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0f1e099..50e1be1 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -17,10 +17,13 @@
 
 /* LCDC DRM driver, based on da8xx-fb */
 
+#include <linux/component.h>
+
 #include "tilcdc_drv.h"
 #include "tilcdc_regs.h"
 #include "tilcdc_tfp410.h"
 #include "tilcdc_panel.h"
+#include "tilcdc_external.h"
 
 #include "drm_fb_helper.h"
 
@@ -73,13 +76,6 @@ static int modeset_init(struct drm_device *dev)
 		mod->funcs->modeset_init(mod, dev);
 	}
 
-	if ((priv->num_encoders == 0) || (priv->num_connectors == 0)) {
-		/* oh nos! */
-		dev_err(dev->dev, "no encoders/connectors found\n");
-		drm_mode_config_cleanup(dev);
-		return -ENXIO;
-	}
-
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = tilcdc_crtc_max_width(priv->crtc);
@@ -253,10 +249,28 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 		goto fail_cpufreq_unregister;
 	}
 
+	platform_set_drvdata(pdev, dev);
+
+	ret = component_bind_all(dev->dev, dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "Binding subcomponents failed: %d\n", ret);
+		goto fail_mode_config_cleanup;
+	}
+
+	ret = tilcdc_add_external_encoders(dev, &bpp);
+	if (ret < 0)
+		goto fail_component_cleanup;
+
+	if ((priv->num_encoders == 0) || (priv->num_connectors == 0)) {
+		dev_err(dev->dev, "no encoders/connectors found\n");
+		ret = -ENXIO;
+		goto fail_component_cleanup;
+	}
+
 	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
-		goto fail_mode_config_cleanup;
+		goto fail_component_cleanup;
 	}
 
 	pm_runtime_get_sync(dev->dev);
@@ -267,9 +281,6 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 		goto fail_vblank_cleanup;
 	}
 
-	platform_set_drvdata(pdev, dev);
-
-
 	list_for_each_entry(mod, &module_list, list) {
 		DBG("%s: preferred_bpp: %d", mod->name, mod->preferred_bpp);
 		bpp = mod->preferred_bpp;
@@ -300,6 +311,9 @@ fail_vblank_cleanup:
 fail_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
 
+fail_component_cleanup:
+	component_unbind_all(dev->dev, dev);
+
 fail_cpufreq_unregister:
 	pm_runtime_disable(dev->dev);
 #ifdef CONFIG_CPU_FREQ
@@ -605,6 +619,22 @@ static const struct dev_pm_ops tilcdc_pm_ops = {
  * Platform driver:
  */
 
+static int tilcdc_bind(struct device *dev)
+{
+	return drm_platform_init(&tilcdc_driver, to_platform_device(dev));
+}
+
+static void tilcdc_unbind(struct device *dev)
+{
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static const struct component_master_ops tilcdc_comp_ops = {
+	.add_components = tilcdc_add_external_components,
+	.bind = tilcdc_bind,
+	.unbind = tilcdc_unbind,
+};
+
 static int tilcdc_pdev_probe(struct platform_device *pdev)
 {
 	/* bail out early if no DT data: */
@@ -613,12 +643,12 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	return drm_platform_init(&tilcdc_driver, pdev);
+	return component_master_add(&pdev->dev, &tilcdc_comp_ops);
 }
 
 static int tilcdc_pdev_remove(struct platform_device *pdev)
 {
-	drm_put_dev(platform_get_drvdata(pdev));
+	component_master_del(&pdev->dev, &tilcdc_comp_ops);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 6336512..70a06c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -165,6 +165,8 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc);
 void tilcdc_crtc_update_clk(struct drm_crtc *crtc);
 void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
 		const struct tilcdc_panel_info *info);
+void tilcdc_crtc_set_simulate_vesa_sync(struct drm_crtc *crtc,
+					bool simulate_vesa_sync);
 int tilcdc_crtc_mode_valid(struct drm_crtc *crtc, struct drm_display_mode *mode);
 int tilcdc_crtc_max_width(struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
new file mode 100644
index 0000000..7254151
--- /dev/null
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2015 Texas Instruments
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+#define DEBUG 1
+
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include "tilcdc_drv.h"
+#include "tilcdc_external.h"
+
+static const struct tilcdc_panel_info panel_info_defaults = {
+		.ac_bias                = 255,
+		.ac_bias_intrpt         = 0,
+		.dma_burst_sz           = 16,
+		.bpp                    = 16,
+		.fdd                    = 0x80,
+		.tft_alt_mode           = 0,
+		.invert_pxl_clk		= 1,
+		.sync_edge              = 1,
+		.sync_ctrl              = 1,
+		.raster_order           = 0,
+};
+
+static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
+				       struct drm_connector *connector)
+{
+	struct tilcdc_drm_private *priv = dev->dev_private;
+
+	priv->connectors[priv->num_connectors++] = connector;
+	priv->encoders[priv->num_encoders++] = connector->encoder;
+
+	tilcdc_crtc_set_simulate_vesa_sync(priv->crtc, true);
+	tilcdc_crtc_set_panel_info(priv->crtc, &panel_info_defaults);
+	*bpp = panel_info_defaults.bpp;
+
+	dev_info(dev->dev, "External encoder '%s' connected\n",
+		 connector->encoder->name);
+
+	return 0;
+}
+
+
+int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp)
+{
+	struct tilcdc_drm_private *priv = dev->dev_private;
+	struct drm_connector *connector;
+	int num_internal_connectors = priv->num_connectors;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		bool found = false;
+		int i, ret;
+
+		for (i = 0; i < num_internal_connectors; i++)
+			if (connector == priv->connectors[i])
+				found = true;
+		if (!found) {
+			ret = tilcdc_add_external_encoder(dev, bpp, connector);
+			if (ret)
+				return ret;
+		}
+	}
+	if (priv->num_connectors - num_internal_connectors > 1) {
+		dev_err(dev->dev, "Only one external encoder is supported.");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+int tilcdc_add_external_components(struct device *master,
+				   struct master *m)
+{
+	struct device_node *ep = NULL;
+
+	while ((ep = of_graph_get_next_endpoint(master->of_node, ep))) {
+		struct device_node *node;
+		int ret;
+
+		node = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
+		if (!node || !of_device_is_available(node))
+			continue;
+
+		dev_info(master, "Subdevice node '%s' found\n", node->name);
+		ret = component_master_add_child(m, of_dev_node_match, node);
+		of_node_put(node);
+		if (ret) {
+			dev_err(master, "Adding component failed: %d\n", ret);
+			of_node_put(ep);
+			return ret;
+		}
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.h b/drivers/gpu/drm/tilcdc/tilcdc_external.h
new file mode 100644
index 0000000..8acf3a1
--- /dev/null
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2015 Texas Instruments
+ * Author: Jyri Sarha <jsarha@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __TILCDC_EXTERNAL_H__
+#define __TILCDC_EXTERNAL_H__
+
+int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp);
+int tilcdc_add_external_components(struct device *master, struct master *m);
+
+#endif /* __TILCDC_SLAVE_H__ */
-- 
1.9.1

