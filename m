From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm/omap: only advertise rotation prop if supported
Date: Thu, 25 Oct 2012 17:14:13 -0500
Message-ID: <1351203253-29142-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33109 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2JYWOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 18:14:25 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2114276oag.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 15:14:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

For hardware that does not have DMM/TILER, there is no rotation,
so no point in getting userspace's hopes up.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.c   |   27 +++++++++++++++------------
 drivers/staging/omapdrm/omap_plane.c |   34 ++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 2bf7259..e4f3cd8 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -670,19 +670,22 @@ static void dev_lastclose(struct drm_device *dev)
 
 	DBG("lastclose: dev=%p", dev);
 
-	/* need to restore default rotation state.. not sure if there is
-	 * a cleaner way to restore properties to default state?  Maybe
-	 * a flag that properties should automatically be restored to
-	 * default state on lastclose?
-	 */
-	for (i = 0; i < priv->num_crtcs; i++) {
-		drm_object_property_set_value(&priv->crtcs[i]->base,
-				priv->rotation_prop, 0);
-	}
+	if (priv->rotation_prop) {
+		/* need to restore default rotation state.. not sure
+		 * if there is a cleaner way to restore properties to
+		 * default state?  Maybe a flag that properties should
+		 * automatically be restored to default state on
+		 * lastclose?
+		 */
+		for (i = 0; i < priv->num_crtcs; i++) {
+			drm_object_property_set_value(&priv->crtcs[i]->base,
+					priv->rotation_prop, 0);
+		}
 
-	for (i = 0; i < priv->num_planes; i++) {
-		drm_object_property_set_value(&priv->planes[i]->base,
-				priv->rotation_prop, 0);
+		for (i = 0; i < priv->num_planes; i++) {
+			drm_object_property_set_value(&priv->planes[i]->base,
+					priv->rotation_prop, 0);
+		}
 	}
 
 	ret = drm_fb_helper_restore_fbdev_mode(priv->fbdev);
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 4bde639..1b3a9fe 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -416,23 +416,25 @@ void omap_plane_install_properties(struct drm_plane *plane,
 	struct omap_drm_private *priv = dev->dev_private;
 	struct drm_property *prop;
 
-	prop = priv->rotation_prop;
-	if (!prop) {
-		const struct drm_prop_enum_list props[] = {
-				{ DRM_ROTATE_0,   "rotate-0" },
-				{ DRM_ROTATE_90,  "rotate-90" },
-				{ DRM_ROTATE_180, "rotate-180" },
-				{ DRM_ROTATE_270, "rotate-270" },
-				{ DRM_REFLECT_X,  "reflect-x" },
-				{ DRM_REFLECT_Y,  "reflect-y" },
-		};
-		prop = drm_property_create_bitmask(dev, 0, "rotation",
-				props, ARRAY_SIZE(props));
-		if (prop == NULL)
-			return;
-		priv->rotation_prop = prop;
+	if (priv->has_dmm) {
+		prop = priv->rotation_prop;
+		if (!prop) {
+			const struct drm_prop_enum_list props[] = {
+					{ DRM_ROTATE_0,   "rotate-0" },
+					{ DRM_ROTATE_90,  "rotate-90" },
+					{ DRM_ROTATE_180, "rotate-180" },
+					{ DRM_ROTATE_270, "rotate-270" },
+					{ DRM_REFLECT_X,  "reflect-x" },
+					{ DRM_REFLECT_Y,  "reflect-y" },
+			};
+			prop = drm_property_create_bitmask(dev, 0, "rotation",
+					props, ARRAY_SIZE(props));
+			if (prop == NULL)
+				return;
+			priv->rotation_prop = prop;
+		}
+		drm_object_attach_property(obj, prop, 0);
 	}
-	drm_object_attach_property(obj, prop, 0);
 
         prop = priv->zorder_prop;
         if (!prop) {
-- 
1.7.9.5

