From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC] drm/tilcdc: Hijack external connectors helper funcs to filter modes
Date: Tue, 24 Mar 2015 21:59:50 +0200
Message-ID: <1427227190-13737-1-git-send-email-jsarha@ti.com>
References: <cover.1426668480.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbbCXUA1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 16:00:27 -0400
In-Reply-To: <cover.1426668480.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

Hijack external connectors helper funcs to filter modes. TILCDC crtc
wants to have its say on which modes are valid. There appears to be no
trivial way to do that directly from crtc. This patch goes and hijacks
the external connectors helper functions and puts its own mode_valid()
function there. The original mode_valid() function is still called if
the mode is found suitable and the original helper funcs pointer is
restored when TILCDC is unloaded.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---

This patch applies on top of my "[PATCH v3 0/7] Use DRM component API
in tilcdc to connect to tda998x"-patch set[1].

I am too new to DRM to know if what I am doing here is acceptable or
not. And I am too new to TILCDC to know if there is not someting
fundamentally wrong with it and that is why need to do this.

The code would certainly look nicer if there would be a mode_valid
func in crtc_helper_funcs too. Would such a patch be accepted?

Best regards,
Jyri

[1]http://www.spinics.net/lists/linux-omap/msg116923.html

 drivers/gpu/drm/tilcdc/tilcdc_drv.c      |  9 +++++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.h      |  1 +
 drivers/gpu/drm/tilcdc/tilcdc_external.c | 43 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tilcdc/tilcdc_external.h |  1 +
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index eb7ed8f..1876945 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -110,6 +110,8 @@ static int tilcdc_unload(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
 
+	tilcdc_remove_external_encoders(dev);
+
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_kms_helper_poll_fini(dev);
 	drm_mode_config_cleanup(dev);
@@ -267,13 +269,13 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 	if ((priv->num_encoders == 0) || (priv->num_connectors == 0)) {
 		dev_err(dev->dev, "no encoders/connectors found\n");
 		ret = -ENXIO;
-		goto fail_component_cleanup;
+		goto fail_external_cleanup;
 	}
 
 	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
-		goto fail_component_cleanup;
+		goto fail_external_cleanup;
 	}
 
 	pm_runtime_get_sync(dev->dev);
@@ -318,6 +320,9 @@ fail_component_cleanup:
 	if (priv->is_componentized)
 		component_unbind_all(dev->dev, dev);
 
+fail_external_cleanup:
+	tilcdc_remove_external_encoders(dev);
+
 fail_cpufreq_unregister:
 	pm_runtime_disable(dev->dev);
 #ifdef CONFIG_CPU_FREQ
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 8ea3d11..ff1c3dd 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -85,6 +85,7 @@ struct tilcdc_drm_private {
 
 	unsigned int num_connectors;
 	struct drm_connector *connectors[8];
+	struct drm_connector_helper_funcs *connector_funcs[8];
 
 	bool is_componentized;
 };
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 1dd6c20..581b775 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -27,12 +27,34 @@ static const struct tilcdc_panel_info panel_info_tda998x = {
 		.raster_order           = 0,
 };
 
+static int tilcdc_external_mode_valid(struct drm_connector *connector,
+				      struct drm_display_mode *mode)
+{
+	struct tilcdc_drm_private *priv = connector->dev->dev_private;
+	int ret, i;
+
+	ret = tilcdc_crtc_mode_valid(priv->crtc, mode);
+	if (ret != MODE_OK)
+		return ret;
+
+	for (i = 0; i < priv->num_connectors &&
+		     priv->connectors[i] != connector; i++);
+
+	BUG_ON(priv->connectors[i] != connector);
+
+	if (priv->connector_funcs[i]->mode_valid)
+		return priv->connector_funcs[i]->mode_valid(connector, mode);
+
+	return MODE_OK;
+}
+
 static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
 				       struct drm_connector *connector)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
+	struct drm_connector_helper_funcs *connector_funcs;
 
-	priv->connectors[priv->num_connectors++] = connector;
+	priv->connectors[priv->num_connectors] = connector;
 	priv->encoders[priv->num_encoders++] = connector->encoder;
 
 	/* Only tda998x is supported at the moment. */
@@ -40,6 +62,14 @@ static int tilcdc_add_external_encoder(struct drm_device *dev, int *bpp,
 	tilcdc_crtc_set_panel_info(priv->crtc, &panel_info_tda998x);
 	*bpp = panel_info_tda998x.bpp;
 
+	priv->connector_funcs[priv->num_connectors] = connector->helper_private;
+	connector_funcs = devm_kzalloc(dev->dev, sizeof(*connector_funcs),
+				       GFP_KERNEL);
+	*connector_funcs = *priv->connector_funcs[priv->num_connectors];
+	connector_funcs->mode_valid = tilcdc_external_mode_valid;
+	connector->helper_private = connector_funcs;
+	priv->num_connectors++;
+
 	dev_dbg(dev->dev, "External encoder '%s' connected\n",
 		connector->encoder->name);
 
@@ -68,6 +98,17 @@ int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp)
 	return 0;
 }
 
+void tilcdc_remove_external_encoders(struct drm_device *dev)
+{
+	struct tilcdc_drm_private *priv = dev->dev_private;
+	int i;
+
+	for (i = 0; i < priv->num_connectors; i++)
+		if (priv->connector_funcs[i])
+			priv->connectors[i]->helper_private =
+				priv->connector_funcs[i];
+}
+
 static int dev_match_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.h b/drivers/gpu/drm/tilcdc/tilcdc_external.h
index 4e7fbf6..685e4dc 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.h
@@ -19,6 +19,7 @@
 #define __TILCDC_EXTERNAL_H__
 
 int tilcdc_add_external_encoders(struct drm_device *dev, int *bpp);
+void tilcdc_remove_external_encoders(struct drm_device *dev);
 int tilcdc_get_external_components(struct device *dev,
 				   struct component_match **match);
 #endif /* __TILCDC_SLAVE_H__ */
-- 
1.9.1

