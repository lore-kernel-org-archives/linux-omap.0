From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update display support"
Date: Sun,  5 Mar 2017 01:43:02 +0100
Message-ID: <20170305004309.28259-3-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This reverts commit 5a35876e2830511cb8110667fc426c6a6165a593.

Revert the removal of manual update display support in
preparation for DSI command mode panels.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
[tony@atomide.com: left out unused omap_framebuffer_dirty]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 12 +++++++
 drivers/gpu/drm/omapdrm/omap_drv.h       |  4 +++
 drivers/gpu/drm/omapdrm/omap_fb.c        | 28 ++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_fbdev.c     | 57 +++++++++++++++++++++++++++++---
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index f90e2d22c5ec..7b2a9f680dce 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -205,6 +205,18 @@ static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.mode_valid = omap_connector_mode_valid,
 };
 
+/* flush an area of the framebuffer (in case of manual update display that
+ * is not automatically flushed)
+ */
+void omap_connector_flush(struct drm_connector *connector,
+		int x, int y, int w, int h)
+{
+	struct omap_connector *omap_connector = to_omap_connector(connector);
+
+	/* TODO: enable when supported in dss */
+	VERB("%s: %d,%d, %dx%d", omap_connector->dssdev->name, x, y, w, h);
+}
+
 /* initialize connector */
 struct drm_connector *omap_connector_init(struct drm_device *dev,
 		int connector_type, struct omap_dss_device *dssdev,
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 65977982f15f..5b1061586401 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -155,6 +155,8 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
+void omap_connector_flush(struct drm_connector *connector,
+		int x, int y, int w, int h);
 
 uint32_t omap_framebuffer_get_formats(uint32_t *pixel_formats,
 		uint32_t max_formats, enum omap_color_mode supported_modes);
@@ -169,6 +171,8 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 struct drm_connector *omap_framebuffer_get_next_connector(
 		struct drm_framebuffer *fb, struct drm_connector *from);
 bool omap_framebuffer_supports_rotation(struct drm_framebuffer *fb);
+void omap_framebuffer_flush(struct drm_framebuffer *fb,
+		int x, int y, int w, int h);
 
 void omap_gem_init(struct drm_device *dev);
 void omap_gem_deinit(struct drm_device *dev);
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 29dc677dd4d3..b6ae28fe3257 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -333,6 +333,34 @@ struct drm_connector *omap_framebuffer_get_next_connector(
 	return NULL;
 }
 
+/* flush an area of the framebuffer (in case of manual update display that
+ * is not automatically flushed)
+ */
+void omap_framebuffer_flush(struct drm_framebuffer *fb,
+		int x, int y, int w, int h)
+{
+	struct drm_connector *connector = NULL;
+
+	VERB("flush: %d,%d %dx%d, fb=%p", x, y, w, h, fb);
+
+	/* FIXME: This is racy - no protection against modeset config changes. */
+	while ((connector = omap_framebuffer_get_next_connector(fb, connector))) {
+		/* only consider connectors that are part of a chain */
+		if (connector->encoder && connector->encoder->crtc) {
+			/* TODO: maybe this should propagate thru the crtc who
+			 * could do the coordinate translation..
+			 */
+			struct drm_crtc *crtc = connector->encoder->crtc;
+			int cx = max(0, x - crtc->x);
+			int cy = max(0, y - crtc->y);
+			int cw = w + (x - crtc->x) - cx;
+			int ch = h + (y - crtc->y) - cy;
+
+			omap_connector_flush(connector, cx, cy, cw, ch);
+		}
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 942c4d483008..6c52a9fa4a37 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -42,8 +42,42 @@ struct omap_fbdev {
 	struct work_struct work;
 };
 
+static void omap_fbdev_flush(struct fb_info *fbi, int x, int y, int w, int h);
 static struct drm_fb_helper *get_fb(struct fb_info *fbi);
 
+static ssize_t omap_fbdev_write(struct fb_info *fbi, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	ssize_t res;
+
+	res = fb_sys_write(fbi, buf, count, ppos);
+	omap_fbdev_flush(fbi, 0, 0, fbi->var.xres, fbi->var.yres);
+
+	return res;
+}
+
+static void omap_fbdev_fillrect(struct fb_info *fbi,
+		const struct fb_fillrect *rect)
+{
+	sys_fillrect(fbi, rect);
+	omap_fbdev_flush(fbi, rect->dx, rect->dy, rect->width, rect->height);
+}
+
+static void omap_fbdev_copyarea(struct fb_info *fbi,
+		const struct fb_copyarea *area)
+{
+	sys_copyarea(fbi, area);
+	omap_fbdev_flush(fbi, area->dx, area->dy, area->width, area->height);
+}
+
+static void omap_fbdev_imageblit(struct fb_info *fbi,
+		const struct fb_image *image)
+{
+	sys_imageblit(fbi, image);
+	omap_fbdev_flush(fbi, image->dx, image->dy,
+				image->width, image->height);
+}
+
 static void pan_worker(struct work_struct *work)
 {
 	struct omap_fbdev *fbdev = container_of(work, struct omap_fbdev, work);
@@ -88,10 +122,10 @@ static struct fb_ops omap_fb_ops = {
 	 * basic fbdev ops which write to the framebuffer
 	 */
 	.fb_read = drm_fb_helper_sys_read,
-	.fb_write = drm_fb_helper_sys_write,
-	.fb_fillrect = drm_fb_helper_sys_fillrect,
-	.fb_copyarea = drm_fb_helper_sys_copyarea,
-	.fb_imageblit = drm_fb_helper_sys_imageblit,
+	.fb_write = omap_fbdev_write,
+	.fb_fillrect = omap_fbdev_fillrect,
+	.fb_copyarea = omap_fbdev_copyarea,
+	.fb_imageblit = omap_fbdev_imageblit,
 
 	.fb_pan_display = omap_fbdev_pan_display,
 };
@@ -245,6 +279,21 @@ static struct drm_fb_helper *get_fb(struct fb_info *fbi)
 	return fbi->par;
 }
 
+/* flush an area of the framebuffer (in case of manual update display that
+ * is not automatically flushed)
+ */
+static void omap_fbdev_flush(struct fb_info *fbi, int x, int y, int w, int h)
+{
+	struct drm_fb_helper *helper = get_fb(fbi);
+
+	if (!helper)
+		return;
+
+	VERB("flush fbdev: %d,%d %dx%d, fbi=%p", x, y, w, h, fbi);
+
+	omap_framebuffer_flush(helper->fb, x, y, w, h);
+}
+
 /* initialize fbdev helper */
 struct drm_fb_helper *omap_fbdev_init(struct drm_device *dev)
 {
-- 
2.11.0
