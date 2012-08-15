From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 2/2] Expose the OMAP Z-Order property through DRM
Date: Wed, 15 Aug 2012 15:18:02 -0500
Message-ID: <1345061882-9743-3-git-send-email-rob.clark@linaro.org>
References: <1345061882-9743-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab2HOUSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 16:18:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2563161obb.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 13:18:43 -0700 (PDT)
In-Reply-To: <1345061882-9743-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Andre Renaud <andre@bluewatersys.com>, Rob Clark <rob@ti.com>

From: Andre Renaud <andre@bluewatersys.com>

Added support for zorder changes through DRM plane properties

Signed-off-by: Andre Renaud <andre@bluewatersys.com>
Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.h   |    1 +
 drivers/staging/omapdrm/omap_plane.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index b103d28..9dc72d1 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -62,6 +62,7 @@ struct omap_drm_private {
 
 	/* properties: */
 	struct drm_property *rotation_prop;
+	struct drm_property *zorder_prop;
 };
 
 /* this should probably be in drm-core to standardize amongst drivers */
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 6931d06..4bde639 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -433,6 +433,15 @@ void omap_plane_install_properties(struct drm_plane *plane,
 		priv->rotation_prop = prop;
 	}
 	drm_object_attach_property(obj, prop, 0);
+
+        prop = priv->zorder_prop;
+        if (!prop) {
+		prop = drm_property_create_range(dev, 0, "zorder", 0, 3);
+		if (prop == NULL)
+			return;
+		priv->zorder_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, 0);
 }
 
 int omap_plane_set_property(struct drm_plane *plane,
@@ -452,6 +461,16 @@ int omap_plane_set_property(struct drm_plane *plane,
 			ret = omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
 		else
 			ret = 0;
+	} else if (property == priv->zorder_prop) {
+		struct omap_overlay *ovl = omap_plane->ovl;
+
+		DBG("%s: zorder: %d", ovl->name, (uint32_t)val);
+		omap_plane->info.zorder = val;
+
+		if (ovl->is_enabled(ovl))
+			ret = omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
+		else
+			ret = 0;
 	}
 
 	return ret;
-- 
1.7.9.5

