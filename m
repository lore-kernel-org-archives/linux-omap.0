From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 01/10] staging: drm/omap: get supported color formats from ovl
Date: Mon,  5 Mar 2012 10:48:31 -0600
Message-ID: <1330966120-28582-2-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab2CEQtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:01 -0500
Received: by mail-yw0-f46.google.com with SMTP id m54so1741570yhm.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:01 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Get the supported formats for a plane from ovl's supported_modes
bitmask.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.h   |    2 ++
 drivers/staging/omapdrm/omap_fb.c    |   14 ++++++++++++++
 drivers/staging/omapdrm/omap_plane.c |   27 +++++++--------------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index 61fe022..d924c95 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -92,6 +92,8 @@ void omap_connector_mode_set(struct drm_connector *connector,
 void omap_connector_flush(struct drm_connector *connector,
 		int x, int y, int w, int h);
 
+uint32_t omap_framebuffer_get_formats(uint32_t *pixel_formats,
+		uint32_t max_formats, enum omap_color_mode supported_modes);
 struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, struct drm_mode_fb_cmd2 *mode_cmd);
 struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omapdrm/omap_fb.c
index d021a7e..116a8ff 100644
--- a/drivers/staging/omapdrm/omap_fb.c
+++ b/drivers/staging/omapdrm/omap_fb.c
@@ -59,6 +59,20 @@ static const struct format formats[] = {
 	{ OMAP_DSS_COLOR_UYVY,        DRM_FORMAT_UYVY,     {{2, 1}}, true },
 };
 
+/* convert from overlay's pixel formats bitmask to an array of fourcc's */
+uint32_t omap_framebuffer_get_formats(uint32_t *pixel_formats,
+		uint32_t max_formats, enum omap_color_mode supported_modes)
+{
+	uint32_t nformats = 0;
+	int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(formats) && nformats < max_formats; i++)
+		if (formats[i].dss_format & supported_modes)
+			pixel_formats[nformats++] = formats[i].pixel_format;
+
+	return nformats;
+}
+
 /* per-plane info for the fb: */
 struct plane {
 	struct drm_gem_object *bo;
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 9790912..c5625e3 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -43,8 +43,10 @@ struct omap_plane {
 
 	/* last fb that we pinned: */
 	struct drm_framebuffer *pinned_fb;
-};
 
+	uint32_t nformats;
+	uint32_t formats[32];
+};
 
 /* push changes down to dss2 */
 static int commit(struct drm_plane *plane)
@@ -271,24 +273,6 @@ static const struct drm_plane_funcs omap_plane_funcs = {
 		.destroy = omap_plane_destroy,
 };
 
-static const uint32_t formats[] = {
-		DRM_FORMAT_RGB565,
-		DRM_FORMAT_RGBX4444,
-		DRM_FORMAT_XRGB4444,
-		DRM_FORMAT_RGBA4444,
-		DRM_FORMAT_ABGR4444,
-		DRM_FORMAT_XRGB1555,
-		DRM_FORMAT_ARGB1555,
-		DRM_FORMAT_RGB888,
-		DRM_FORMAT_RGBX8888,
-		DRM_FORMAT_XRGB8888,
-		DRM_FORMAT_RGBA8888,
-		DRM_FORMAT_ARGB8888,
-		DRM_FORMAT_NV12,
-		DRM_FORMAT_YUYV,
-		DRM_FORMAT_UYVY,
-};
-
 /* initialize plane */
 struct drm_plane *omap_plane_init(struct drm_device *dev,
 		struct omap_overlay *ovl, unsigned int possible_crtcs,
@@ -306,11 +290,14 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 		goto fail;
 	}
 
+	omap_plane->nformats = omap_framebuffer_get_formats(
+			omap_plane->formats, ARRAY_SIZE(omap_plane->formats),
+			ovl->supported_modes);
 	omap_plane->ovl = ovl;
 	plane = &omap_plane->base;
 
 	drm_plane_init(dev, plane, possible_crtcs, &omap_plane_funcs,
-			formats, ARRAY_SIZE(formats), priv);
+			omap_plane->formats, omap_plane->nformats, priv);
 
 	/* get our starting configuration, set defaults for parameters
 	 * we don't currently use, etc:
-- 
1.7.5.4

