From: Rob Clark <rob.clark@linaro.org>
Subject: [RFC 3/3] drm/omap: use dispc directly
Date: Fri, 27 Jul 2012 20:07:54 -0500
Message-ID: <1343437674-24246-4-git-send-email-rob.clark@linaro.org>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46849 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2G1BI7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 21:08:59 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5089501obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 18:08:58 -0700 (PDT)
In-Reply-To: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

This is still work in progress, but it nicely solves the omapdss vs drm
impedence mismatches, and properly fixes unpin confusion vs GO bit status.
As an added bonus, we also no longer leave the last overlay buffer pinned.
Adding the previously missing vblank event handling for userspace should
be pretty trivial now too.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/Makefile         |    1 +
 drivers/staging/omapdrm/omap_connector.c |   20 +-
 drivers/staging/omapdrm/omap_crtc.c      |   42 ++--
 drivers/staging/omapdrm/omap_drv.c       |   70 +-----
 drivers/staging/omapdrm/omap_drv.h       |   64 ++++-
 drivers/staging/omapdrm/omap_encoder.c   |  213 ++++++++++++++---
 drivers/staging/omapdrm/omap_irq.c       |  133 +++++++++++
 drivers/staging/omapdrm/omap_plane.c     |  382 +++++++++---------------------
 8 files changed, 544 insertions(+), 381 deletions(-)
 create mode 100644 drivers/staging/omapdrm/omap_irq.c

diff --git a/drivers/staging/omapdrm/Makefile b/drivers/staging/omapdrm/Makefile
index 1ca0e00..d85e058 100644
--- a/drivers/staging/omapdrm/Makefile
+++ b/drivers/staging/omapdrm/Makefile
@@ -5,6 +5,7 @@
 
 ccflags-y := -Iinclude/drm -Werror
 omapdrm-y := omap_drv.o \
+	omap_irq.o \
 	omap_debugfs.o \
 	omap_crtc.o \
 	omap_plane.o \
diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 5e2856c..577ae32 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -284,16 +284,17 @@ static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 };
 
 /* called from encoder when mode is set, to propagate settings to the dssdev */
-void omap_connector_mode_set(struct drm_connector *connector,
-		struct drm_display_mode *mode)
+int omap_connector_mode_set(struct drm_connector *connector,
+		struct drm_display_mode *mode,
+		struct omap_video_timings *timings)
 {
 	struct drm_device *dev = connector->dev;
 	struct omap_connector *omap_connector = to_omap_connector(connector);
 	struct omap_dss_device *dssdev = omap_connector->dssdev;
 	struct omap_dss_driver *dssdrv = dssdev->driver;
-	struct omap_video_timings timings;
+	int ret;
 
-	copy_timings_drm_to_omap(&timings, mode);
+	copy_timings_drm_to_omap(timings, mode);
 
 	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
 			omap_connector->dssdev->name,
@@ -303,12 +304,15 @@ void omap_connector_mode_set(struct drm_connector *connector,
 			mode->vdisplay, mode->vsync_start,
 			mode->vsync_end, mode->vtotal, mode->type, mode->flags);
 
-	if (dssdrv->check_timings(dssdev, &timings)) {
-		dev_err(dev->dev, "could not set timings\n");
-		return;
+	ret = dssdrv->check_timings(dssdev, timings);
+	if (ret) {
+		dev_err(dev->dev, "could not set timings: %d\n", ret);
+		return ret;
 	}
 
-	dssdrv->set_timings(dssdev, &timings);
+	dssdrv->set_timings(dssdev, timings);
+
+	return 0;
 }
 
 /* flush an area of the framebuffer (in case of manual update display that
diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index 7479dcb..3024dcd 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -33,7 +33,6 @@ struct omap_crtc {
 
 	/* if there is a pending flip, these will be non-null: */
 	struct drm_pending_vblank_event *event;
-	struct drm_framebuffer *old_fb;
 };
 
 static void omap_crtc_destroy(struct drm_crtc *crtc)
@@ -78,7 +77,8 @@ static int omap_crtc_mode_set(struct drm_crtc *crtc,
 	return omap_plane_mode_set(plane, crtc, crtc->fb,
 			0, 0, mode->hdisplay, mode->vdisplay,
 			x << 16, y << 16,
-			mode->hdisplay << 16, mode->vdisplay << 16);
+			mode->hdisplay << 16, mode->vdisplay << 16,
+			NULL, NULL);
 }
 
 static void omap_crtc_prepare(struct drm_crtc *crtc)
@@ -102,10 +102,11 @@ static int omap_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 	struct drm_plane *plane = omap_crtc->plane;
 	struct drm_display_mode *mode = &crtc->mode;
 
-	return plane->funcs->update_plane(plane, crtc, crtc->fb,
+	return omap_plane_mode_set(plane, crtc, crtc->fb,
 			0, 0, mode->hdisplay, mode->vdisplay,
 			x << 16, y << 16,
-			mode->hdisplay << 16, mode->vdisplay << 16);
+			mode->hdisplay << 16, mode->vdisplay << 16,
+			NULL, NULL);
 }
 
 static void omap_crtc_load_lut(struct drm_crtc *crtc)
@@ -154,17 +155,17 @@ static void page_flip_cb(void *arg)
 {
 	struct drm_crtc *crtc = arg;
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
-	struct drm_framebuffer *old_fb = omap_crtc->old_fb;
-
-	omap_crtc->old_fb = NULL;
-
-	omap_crtc_mode_set_base(crtc, crtc->x, crtc->y, old_fb);
+	struct drm_plane *plane = omap_crtc->plane;
+	struct drm_display_mode *mode = &crtc->mode;
 
-	/* really we'd like to setup the callback atomically w/ setting the
-	 * new scanout buffer to avoid getting stuck waiting an extra vblank
-	 * cycle.. for now go for correctness and later figure out speed..
-	 */
-	omap_plane_on_endwin(omap_crtc->plane, vblank_cb, crtc);
+	// XXX this needs to be shunted off to a worker.. at
+	// least right now we are making assumptions that everything is
+	// synchronized on mode_config.mutex
+	omap_plane_mode_set(plane, crtc, crtc->fb,
+			0, 0, mode->hdisplay, mode->vdisplay,
+			crtc->x << 16, crtc->y << 16,
+			mode->hdisplay << 16, mode->vdisplay << 16,
+			vblank_cb, arg);
 }
 
 static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
@@ -181,7 +182,6 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 		return -EINVAL;
 	}
 
-	omap_crtc->old_fb = crtc->fb;
 	omap_crtc->event = event;
 	crtc->fb = fb;
 
@@ -222,6 +222,18 @@ static const struct drm_crtc_helper_funcs omap_crtc_helper_funcs = {
 	.load_lut = omap_crtc_load_lut,
 };
 
+struct drm_encoder *omap_crtc_attached_encoder(struct drm_crtc *crtc)
+{
+	struct omap_drm_private *priv = crtc->dev->dev_private;
+	int i;
+
+	for (i = 0; i < priv->num_encoders; i++)
+		if (priv->encoders[i]->crtc == crtc)
+			return priv->encoders[i];
+
+	return NULL;
+}
+
 /* initialize crtc */
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct omap_overlay *ovl, int id)
diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index df31c89..2a67e4e 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -419,7 +419,7 @@ static int omap_modeset_init(struct drm_device *dev)
 
 	dev->mode_config.funcs = &omap_mode_config_funcs;
 
-	return 0;
+	return drm_irq_install(dev);
 }
 
 static void omap_modeset_free(struct drm_device *dev)
@@ -756,7 +756,9 @@ static void dev_lastclose(struct drm_device *dev)
 				priv->rotation_prop, 0);
 	}
 
+	mutex_lock(&dev->mode_config.mutex);
 	ret = drm_fb_helper_restore_fbdev_mode(priv->fbdev);
+	mutex_unlock(&dev->mode_config.mutex);
 	if (ret)
 		DBG("failed to restore crtc mode");
 }
@@ -780,60 +782,6 @@ static void dev_postclose(struct drm_device *dev, struct drm_file *file)
 	DBG("postclose: dev=%p, file=%p", dev, file);
 }
 
-/**
- * enable_vblank - enable vblank interrupt events
- * @dev: DRM device
- * @crtc: which irq to enable
- *
- * Enable vblank interrupts for @crtc.  If the device doesn't have
- * a hardware vblank counter, this routine should be a no-op, since
- * interrupts will have to stay on to keep the count accurate.
- *
- * RETURNS
- * Zero on success, appropriate errno if the given @crtc's vblank
- * interrupt cannot be enabled.
- */
-static int dev_enable_vblank(struct drm_device *dev, int crtc)
-{
-	DBG("enable_vblank: dev=%p, crtc=%d", dev, crtc);
-	return 0;
-}
-
-/**
- * disable_vblank - disable vblank interrupt events
- * @dev: DRM device
- * @crtc: which irq to enable
- *
- * Disable vblank interrupts for @crtc.  If the device doesn't have
- * a hardware vblank counter, this routine should be a no-op, since
- * interrupts will have to stay on to keep the count accurate.
- */
-static void dev_disable_vblank(struct drm_device *dev, int crtc)
-{
-	DBG("disable_vblank: dev=%p, crtc=%d", dev, crtc);
-}
-
-static irqreturn_t dev_irq_handler(DRM_IRQ_ARGS)
-{
-	return IRQ_HANDLED;
-}
-
-static void dev_irq_preinstall(struct drm_device *dev)
-{
-	DBG("irq_preinstall: dev=%p", dev);
-}
-
-static int dev_irq_postinstall(struct drm_device *dev)
-{
-	DBG("irq_postinstall: dev=%p", dev);
-	return 0;
-}
-
-static void dev_irq_uninstall(struct drm_device *dev)
-{
-	DBG("irq_uninstall: dev=%p", dev);
-}
-
 static const struct vm_operations_struct omap_gem_vm_ops = {
 	.fault = omap_gem_fault,
 	.open = omap_gem_vm_open,
@@ -863,12 +811,12 @@ static struct drm_driver omap_drm_driver = {
 		.preclose = dev_preclose,
 		.postclose = dev_postclose,
 		.get_vblank_counter = drm_vblank_count,
-		.enable_vblank = dev_enable_vblank,
-		.disable_vblank = dev_disable_vblank,
-		.irq_preinstall = dev_irq_preinstall,
-		.irq_postinstall = dev_irq_postinstall,
-		.irq_uninstall = dev_irq_uninstall,
-		.irq_handler = dev_irq_handler,
+		.enable_vblank = omap_irq_enable_vblank,
+		.disable_vblank = omap_irq_disable_vblank,
+		.irq_preinstall = omap_irq_preinstall,
+		.irq_postinstall = omap_irq_postinstall,
+		.irq_uninstall = omap_irq_uninstall,
+		.irq_handler = omap_irq_handler,
 		.reclaim_buffers = drm_core_reclaim_buffers,
 #ifdef CONFIG_DEBUG_FS
 		.debugfs_init = omap_debugfs_init,
diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index 799dd46..5cd3b1e 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -28,6 +28,31 @@
 #include <plat/drm.h>
 #include "omap_drm.h"
 
+/* APIs we need from dispc.. TODO omapdss should export these */
+void dispc_clear_irqs(u32 mask);
+u32 dispc_read_irqs(void);
+void dispc_set_irqs(u32 mask);
+u32 dispc_error_irqs(void);
+int dispc_runtime_get(void);
+int dispc_runtime_put(void);
+
+void dispc_mgr_enable(enum omap_channel channel, bool enable);
+void dispc_mgr_setup(enum omap_channel channel,
+		struct omap_overlay_manager_info *info);
+void dispc_mgr_set_timings(enum omap_channel channel,
+		struct omap_video_timings *timings);
+void dispc_mgr_go(enum omap_channel channel);
+bool dispc_mgr_go_busy(enum omap_channel channel);
+u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
+
+int dispc_ovl_enable(enum omap_plane plane, bool enable);
+void dispc_ovl_set_channel_out(enum omap_plane plane,
+		enum omap_channel channel);
+int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+		bool ilace, bool replication,
+		const struct omap_video_timings *mgr_timings);
+
+
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
 
@@ -81,6 +106,21 @@ struct omap_drm_window {
 	uint32_t src_w, src_h;
 };
 
+/* Once GO bit is set, we can't make further updates to shadowed registers
+ * until the GO bit is cleared.  So various parts in the kms code that need
+ * to update shadowed registers queue up a pair of callbacks, pre_apply
+ * which is called before setting GO bit, and post_apply that is called
+ * after GO bit is cleared.  The encoder manages the queuing, and everyone
+ * else goes thru omap_encoder_apply() using these callbacks so that the
+ * code which has to deal w/ GO bit state is centralized.
+ */
+struct omap_drm_apply {
+	struct list_head pending_node, queued_node;
+	bool queued;
+	void (*pre_apply)(struct omap_drm_apply *apply);
+	void (*post_apply)(struct omap_drm_apply *apply);
+};
+
 #ifdef CONFIG_DEBUG_FS
 int omap_debugfs_init(struct drm_minor *minor);
 void omap_debugfs_cleanup(struct drm_minor *minor);
@@ -89,9 +129,19 @@ void omap_gem_describe(struct drm_gem_object *obj, struct seq_file *m);
 void omap_gem_describe_objects(struct list_head *list, struct seq_file *m);
 #endif
 
+int omap_irq_enable_vblank(struct drm_device *dev, int crtc);
+void omap_irq_disable_vblank(struct drm_device *dev, int crtc);
+irqreturn_t omap_irq_handler(DRM_IRQ_ARGS);
+void omap_irq_preinstall(struct drm_device *dev);
+int omap_irq_postinstall(struct drm_device *dev);
+void omap_irq_uninstall(struct drm_device *dev);
+void omap_irq_enable(uint32_t mask);
+void omap_irq_disable(uint32_t mask);
+
 struct drm_fb_helper *omap_fbdev_init(struct drm_device *dev);
 void omap_fbdev_free(struct drm_device *dev);
 
+struct drm_encoder *omap_crtc_attached_encoder(struct drm_crtc *crtc);
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct omap_overlay *ovl, int id);
 
@@ -104,8 +154,7 @@ int omap_plane_mode_set(struct drm_plane *plane,
 		int crtc_x, int crtc_y,
 		unsigned int crtc_w, unsigned int crtc_h,
 		uint32_t src_x, uint32_t src_y,
-		uint32_t src_w, uint32_t src_h);
-void omap_plane_on_endwin(struct drm_plane *plane,
+		uint32_t src_w, uint32_t src_h,
 		void (*fxn)(void *), void *arg);
 void omap_plane_install_properties(struct drm_plane *plane,
 		struct drm_mode_object *obj);
@@ -116,6 +165,12 @@ struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		struct omap_overlay_manager *mgr);
 struct omap_overlay_manager *omap_encoder_get_manager(
 		struct drm_encoder *encoder);
+const struct omap_video_timings *omap_encoder_timings(
+		struct drm_encoder *encoder);
+enum omap_channel omap_encoder_channel(struct drm_encoder *encoder);
+void omap_encoder_vblank(struct drm_encoder *encoder, uint32_t irqstatus);
+int omap_encoder_apply(struct drm_encoder *encoder,
+		struct omap_drm_apply *apply);
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 enum drm_connector_status omap_connector_detect(
@@ -123,8 +178,9 @@ enum drm_connector_status omap_connector_detect(
 
 struct drm_connector *omap_connector_init(struct drm_device *dev,
 		int connector_type, struct omap_dss_device *dssdev);
-void omap_connector_mode_set(struct drm_connector *connector,
-		struct drm_display_mode *mode);
+int omap_connector_mode_set(struct drm_connector *connector,
+		struct drm_display_mode *mode,
+		struct omap_video_timings *timings);
 void omap_connector_flush(struct drm_connector *connector,
 		int x, int y, int w, int h);
 
diff --git a/drivers/staging/omapdrm/omap_encoder.c b/drivers/staging/omapdrm/omap_encoder.c
index 06c52cb..d56d14d 100644
--- a/drivers/staging/omapdrm/omap_encoder.c
+++ b/drivers/staging/omapdrm/omap_encoder.c
@@ -22,6 +22,9 @@
 #include "drm_crtc.h"
 #include "drm_crtc_helper.h"
 
+#include <linux/list.h>
+
+
 /*
  * encoder funcs
  */
@@ -30,13 +33,32 @@
 
 struct omap_encoder {
 	struct drm_encoder base;
-	struct omap_overlay_manager *mgr;
+	struct omap_overlay_manager *mgr; // TODO remove
+
+	const char *name;
+	enum omap_channel channel;
+	struct omap_overlay_manager_info info;
+
+	struct omap_video_timings timings;
+	bool enabled, timings_valid;
+	uint32_t irqmask;
+
+	struct omap_drm_apply apply;
+
+	/* list of in-progress apply's: */
+	struct list_head pending_applies;
+
+	/* list of queued apply's: */
+	struct list_head queued_applies;
+
+	/* for handling queued and in-progress applies: */
+	struct work_struct work;
 };
 
 static void omap_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	DBG("%s", omap_encoder->mgr->name);
+	DBG("%s", omap_encoder->name);
 	drm_encoder_cleanup(encoder);
 	kfree(omap_encoder);
 }
@@ -44,7 +66,14 @@ static void omap_encoder_destroy(struct drm_encoder *encoder)
 static void omap_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	DBG("%s: %d", omap_encoder->mgr->name, mode);
+	bool enabled = (mode == DRM_MODE_DPMS_ON);
+
+	DBG("%s: %d", omap_encoder->name, mode);
+
+	if (enabled != omap_encoder->enabled) {
+		omap_encoder->enabled = enabled;
+		omap_encoder_apply(encoder, &omap_encoder->apply);
+	}
 }
 
 static bool omap_encoder_mode_fixup(struct drm_encoder *encoder,
@@ -52,7 +81,7 @@ static bool omap_encoder_mode_fixup(struct drm_encoder *encoder,
 				  struct drm_display_mode *adjusted_mode)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	DBG("%s", omap_encoder->mgr->name);
+	DBG("%s", omap_encoder->name);
 	return true;
 }
 
@@ -67,13 +96,14 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 
 	mode = adjusted_mode;
 
-	DBG("%s: set mode: %dx%d", omap_encoder->mgr->name,
+	DBG("%s: set mode: %dx%d", omap_encoder->name,
 			mode->hdisplay, mode->vdisplay);
 
 	for (i = 0; i < priv->num_connectors; i++) {
 		struct drm_connector *connector = priv->connectors[i];
 		if (connector->encoder == encoder) {
-			omap_connector_mode_set(connector, mode);
+			omap_encoder->timings_valid = omap_connector_mode_set(
+					connector, mode, &omap_encoder->timings) == 0;
 		}
 	}
 }
@@ -83,7 +113,7 @@ static void omap_encoder_prepare(struct drm_encoder *encoder)
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
 	struct drm_encoder_helper_funcs *encoder_funcs =
 				encoder->helper_private;
-	DBG("%s", omap_encoder->mgr->name);
+	DBG("%s", omap_encoder->name);
 	encoder_funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
 }
 
@@ -92,8 +122,7 @@ static void omap_encoder_commit(struct drm_encoder *encoder)
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
 	struct drm_encoder_helper_funcs *encoder_funcs =
 				encoder->helper_private;
-	DBG("%s", omap_encoder->mgr->name);
-	omap_encoder->mgr->apply(omap_encoder->mgr);
+	DBG("%s", omap_encoder->name);
 	encoder_funcs->dpms(encoder, DRM_MODE_DPMS_ON);
 }
 
@@ -109,6 +138,32 @@ static const struct drm_encoder_helper_funcs omap_encoder_helper_funcs = {
 	.commit = omap_encoder_commit,
 };
 
+static void omap_encoder_pre_apply(struct omap_drm_apply *apply)
+{
+	struct omap_encoder *omap_encoder =
+			container_of(apply, struct omap_encoder, apply);
+
+	DBG("%s: enabled=%d, timings_valid=%d", omap_encoder->name,
+			omap_encoder->enabled,
+			omap_encoder->timings_valid);
+
+	if (!omap_encoder->enabled || !omap_encoder->timings_valid) {
+		dispc_mgr_enable(omap_encoder->channel, false);
+		return;
+	}
+
+	dispc_mgr_setup(omap_encoder->channel, &omap_encoder->info);
+	dispc_mgr_set_timings(omap_encoder->channel,
+			&omap_encoder->timings);
+	dispc_mgr_enable(omap_encoder->channel, true);
+}
+
+static void omap_encoder_post_apply(struct omap_drm_apply *apply)
+{
+	/* nothing needed for post-apply */
+}
+
+// TODO remove
 struct omap_overlay_manager *omap_encoder_get_manager(
 		struct drm_encoder *encoder)
 {
@@ -116,14 +171,113 @@ struct omap_overlay_manager *omap_encoder_get_manager(
 	return omap_encoder->mgr;
 }
 
+const struct omap_video_timings *omap_encoder_timings(
+		struct drm_encoder *encoder)
+{
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+	return &omap_encoder->timings;
+}
+
+enum omap_channel omap_encoder_channel(struct drm_encoder *encoder)
+{
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+	return omap_encoder->channel;
+}
+
+void omap_encoder_vblank(struct drm_encoder *encoder, uint32_t irqstatus)
+{
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+
+	if (irqstatus & omap_encoder->irqmask) {
+		DBG("%s: it's for me!", omap_encoder->name);
+		if (!dispc_mgr_go_busy(omap_encoder->channel)) {
+			struct omap_drm_private *priv =
+					encoder->dev->dev_private;
+			DBG("%s: apply done", omap_encoder->name);
+			omap_irq_disable(omap_encoder->irqmask);
+			queue_work(priv->wq, &omap_encoder->work);
+		}
+	}
+}
+
+static void apply_worker(struct work_struct *work)
+{
+	struct omap_encoder *omap_encoder =
+			container_of(work, struct omap_encoder, work);
+	struct drm_encoder *encoder = &omap_encoder->base;
+	struct drm_device *dev = encoder->dev;
+	struct omap_drm_apply *apply, *n;
+	bool need_apply;
+
+	/*
+	 * Synchronize everything on mode_config.mutex, to keep
+	 * the callbacks and list modification all serialized
+	 * with respect to modesetting ioctls from userspace.
+	 */
+	mutex_lock(&dev->mode_config.mutex);
+	dispc_runtime_get();
+
+	/* finish up previous apply's: */
+	list_for_each_entry_safe(apply, n,
+			&omap_encoder->pending_applies, pending_node) {
+	}
+
+	need_apply = !list_empty(&omap_encoder->queued_applies);
+
+	/* then handle the next round of of queued apply's: */
+	list_for_each_entry_safe(apply, n,
+			&omap_encoder->queued_applies, queued_node) {
+		apply->pre_apply(apply);
+		list_del(&apply->queued_node);
+		apply->queued = false;
+		list_add_tail(&apply->pending_node,
+				&omap_encoder->pending_applies);
+	}
+
+	if (need_apply) {
+		DBG("%s: GO", omap_encoder->name);
+		omap_irq_enable(omap_encoder->irqmask);
+		dispc_mgr_go(omap_encoder->channel);
+	}
+	dispc_runtime_put();
+	mutex_unlock(&dev->mode_config.mutex);
+}
+
+int omap_encoder_apply(struct drm_encoder *encoder,
+		struct omap_drm_apply *apply)
+{
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+	struct drm_device *dev = encoder->dev;
+
+	WARN_ON(!mutex_is_locked(&dev->mode_config.mutex));
+
+	/* no need to queue it again if it is already queued: */
+	if (apply->queued)
+		return 0;
+
+	apply->queued = true;
+	list_add_tail(&apply->queued_node, &omap_encoder->queued_applies);
+
+	/*
+	 * If there are no currently pending updates, then go ahead and
+	 * kick the worker immediately, otherwise it will run again when
+	 * the current update finishes.
+	 */
+	if (list_empty(&omap_encoder->pending_applies)) {
+		struct omap_drm_private *priv = encoder->dev->dev_private;
+		queue_work(priv->wq, &omap_encoder->work);
+	}
+
+	return 0;
+}
+
 /* initialize encoder */
 struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		struct omap_overlay_manager *mgr)
 {
 	struct drm_encoder *encoder = NULL;
 	struct omap_encoder *omap_encoder;
-	struct omap_overlay_manager_info info;
-	int ret;
+	struct omap_overlay_manager_info *info;
 
 	DBG("%s", mgr->name);
 
@@ -133,32 +287,33 @@ struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		goto fail;
 	}
 
+	omap_encoder->name = mgr->name;
+	omap_encoder->channel = mgr->id;
+	omap_encoder->irqmask =
+			dispc_mgr_get_vsync_irq(mgr->id);
 	omap_encoder->mgr = mgr;
+
 	encoder = &omap_encoder->base;
 
+	INIT_WORK(&omap_encoder->work, apply_worker);
+	INIT_LIST_HEAD(&omap_encoder->pending_applies);
+	INIT_LIST_HEAD(&omap_encoder->queued_applies);
+
+	omap_encoder->apply.pre_apply  = omap_encoder_pre_apply;
+	omap_encoder->apply.post_apply = omap_encoder_post_apply;
+
 	drm_encoder_init(dev, encoder, &omap_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS);
 	drm_encoder_helper_add(encoder, &omap_encoder_helper_funcs);
 
-	mgr->get_manager_info(mgr, &info);
-
-	/* TODO: fix hard-coded setup.. */
-	info.default_color = 0x00000000;
-	info.trans_key = 0x00000000;
-	info.trans_key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
-	info.trans_enabled = false;
-
-	ret = mgr->set_manager_info(mgr, &info);
-	if (ret) {
-		dev_err(dev->dev, "could not set manager info\n");
-		goto fail;
-	}
+	info = &omap_encoder->info;
+	mgr->get_manager_info(mgr, info);
 
-	ret = mgr->apply(mgr);
-	if (ret) {
-		dev_err(dev->dev, "could not apply\n");
-		goto fail;
-	}
+	/* TODO: fix hard-coded setup.. add properties! */
+	info->default_color = 0x00000000;
+	info->trans_key = 0x00000000;
+	info->trans_key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
+	info->trans_enabled = false;
 
 	return encoder;
 
diff --git a/drivers/staging/omapdrm/omap_irq.c b/drivers/staging/omapdrm/omap_irq.c
new file mode 100644
index 0000000..28450ff
--- /dev/null
+++ b/drivers/staging/omapdrm/omap_irq.c
@@ -0,0 +1,133 @@
+/*
+ * drivers/staging/omapdrm/omap_irq.c
+ *
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Rob Clark <rob.clark@linaro.org>
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
+#include "omap_drv.h"
+
+/* TODO move to priv.. */
+static u32 error_mask;
+static u32 current_mask;
+
+/**
+ * enable_vblank - enable vblank interrupt events
+ * @dev: DRM device
+ * @crtc: which irq to enable
+ *
+ * Enable vblank interrupts for @crtc.  If the device doesn't have
+ * a hardware vblank counter, this routine should be a no-op, since
+ * interrupts will have to stay on to keep the count accurate.
+ *
+ * RETURNS
+ * Zero on success, appropriate errno if the given @crtc's vblank
+ * interrupt cannot be enabled.
+ */
+int omap_irq_enable_vblank(struct drm_device *dev, int crtc)
+{
+	DBG("dev=%p, crtc=%d", dev, crtc);
+	return 0;
+}
+
+/**
+ * disable_vblank - disable vblank interrupt events
+ * @dev: DRM device
+ * @crtc: which irq to enable
+ *
+ * Disable vblank interrupts for @crtc.  If the device doesn't have
+ * a hardware vblank counter, this routine should be a no-op, since
+ * interrupts will have to stay on to keep the count accurate.
+ */
+void omap_irq_disable_vblank(struct drm_device *dev, int crtc)
+{
+	DBG("dev=%p, crtc=%d", dev, crtc);
+}
+
+/* call w/ pm runtime held */
+void omap_irq_enable(uint32_t mask)
+{
+	current_mask |= mask;
+	dispc_set_irqs(current_mask);
+}
+
+/* call w/ pm runtime held */
+void omap_irq_disable(uint32_t mask)
+{
+	current_mask &= ~mask;
+	dispc_set_irqs(current_mask);
+}
+
+irqreturn_t omap_irq_handler(DRM_IRQ_ARGS)
+{
+	struct drm_device *dev = (struct drm_device *) arg;
+	struct omap_drm_private *priv = dev->dev_private;
+	u32 irqstatus;
+
+	irqstatus = dispc_read_irqs();
+	dispc_clear_irqs(irqstatus);
+	dispc_read_irqs();            /* flush posted write */
+
+	if (irqstatus & error_mask) {
+		DBG("errors: %08x", irqstatus & error_mask);
+		/* TODO */
+	}
+
+	DBG("irqs: %08x", irqstatus & ~error_mask);
+
+#define VBLANK (DISPC_IRQ_VSYNC|DISPC_IRQ_VSYNC2|DISPC_IRQ_EVSYNC_ODD|DISPC_IRQ_EVSYNC_EVEN)
+	if (irqstatus & VBLANK) {
+		unsigned int i;
+		for (i = 0; i < priv->num_encoders; i++)
+			omap_encoder_vblank(priv->encoders[i], irqstatus);
+
+		/* TODO we could probably dispatch to CRTC's and handle
+		 * page-flip events w/out the callback between omap_plane
+		 * and omap_crtc.. that would be a bit cleaner.
+		 */
+	}
+
+	return IRQ_HANDLED;
+}
+
+void omap_irq_preinstall(struct drm_device *dev)
+{
+	DBG("dev=%p", dev);
+
+	dispc_runtime_get();
+	error_mask = dispc_error_irqs();
+
+	/* for now ignore DISPC_IRQ_SYNC_LOST_DIGIT.. really I think
+	 * we just need to ignore it while enabling tv-out
+	 */
+	error_mask &= ~DISPC_IRQ_SYNC_LOST_DIGIT;
+
+	dispc_clear_irqs(0xffffffff);
+	dispc_runtime_put();
+}
+
+int omap_irq_postinstall(struct drm_device *dev)
+{
+	DBG("dev=%p", dev);
+	dispc_runtime_get();
+	omap_irq_enable(error_mask);
+	dispc_runtime_put();
+	return 0;
+}
+
+void omap_irq_uninstall(struct drm_device *dev)
+{
+	DBG("dev=%p", dev);
+}
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 6931d06..a8d0df0 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -41,12 +41,14 @@ struct callback {
 
 struct omap_plane {
 	struct drm_plane base;
-	struct omap_overlay *ovl;
+	int plane;  /* TODO rename omap_plane -> omap_plane_id in omapdss so I can use the enum */
+	const char *name;
 	struct omap_overlay_info info;
+	struct omap_drm_apply apply;
 
 	/* position/orientation of scanout within the fb: */
 	struct omap_drm_window win;
-
+	bool enabled;
 
 	/* last fb that we pinned: */
 	struct drm_framebuffer *pinned_fb;
@@ -54,189 +56,13 @@ struct omap_plane {
 	uint32_t nformats;
 	uint32_t formats[32];
 
-	/* for synchronizing access to unpins fifo */
-	struct mutex unpin_mutex;
-
-	/* set of bo's pending unpin until next END_WIN irq */
+	/* set of bo's pending unpin until next post_apply() */
 	DECLARE_KFIFO_PTR(unpin_fifo, struct drm_gem_object *);
-	int num_unpins, pending_num_unpins;
-
-	/* for deferred unpin when we need to wait for scanout complete irq */
-	struct work_struct work;
-
-	/* callback on next endwin irq */
-	struct callback endwin;
-};
 
-/* map from ovl->id to the irq we are interested in for scanout-done */
-static const uint32_t id2irq[] = {
-		[OMAP_DSS_GFX]    = DISPC_IRQ_GFX_END_WIN,
-		[OMAP_DSS_VIDEO1] = DISPC_IRQ_VID1_END_WIN,
-		[OMAP_DSS_VIDEO2] = DISPC_IRQ_VID2_END_WIN,
-		[OMAP_DSS_VIDEO3] = DISPC_IRQ_VID3_END_WIN,
+	// XXX maybe get rid of this and handle vblank in crtc too?
+	struct callback apply_done_cb;
 };
 
-static void dispc_isr(void *arg, uint32_t mask)
-{
-	struct drm_plane *plane = arg;
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_drm_private *priv = plane->dev->dev_private;
-
-	omap_dispc_unregister_isr(dispc_isr, plane,
-			id2irq[omap_plane->ovl->id]);
-
-	queue_work(priv->wq, &omap_plane->work);
-}
-
-static void unpin_worker(struct work_struct *work)
-{
-	struct omap_plane *omap_plane =
-			container_of(work, struct omap_plane, work);
-	struct callback endwin;
-
-	mutex_lock(&omap_plane->unpin_mutex);
-	DBG("unpinning %d of %d", omap_plane->num_unpins,
-			omap_plane->num_unpins + omap_plane->pending_num_unpins);
-	while (omap_plane->num_unpins > 0) {
-		struct drm_gem_object *bo = NULL;
-		int ret = kfifo_get(&omap_plane->unpin_fifo, &bo);
-		WARN_ON(!ret);
-		omap_gem_put_paddr(bo);
-		drm_gem_object_unreference_unlocked(bo);
-		omap_plane->num_unpins--;
-	}
-	endwin = omap_plane->endwin;
-	omap_plane->endwin.fxn = NULL;
-	mutex_unlock(&omap_plane->unpin_mutex);
-
-	if (endwin.fxn)
-		endwin.fxn(endwin.arg);
-}
-
-static void install_irq(struct drm_plane *plane)
-{
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_overlay *ovl = omap_plane->ovl;
-	int ret;
-
-	ret = omap_dispc_register_isr(dispc_isr, plane, id2irq[ovl->id]);
-
-	/*
-	 * omapdss has upper limit on # of registered irq handlers,
-	 * which we shouldn't hit.. but if we do the limit should
-	 * be raised or bad things happen:
-	 */
-	WARN_ON(ret == -EBUSY);
-}
-
-/* push changes down to dss2 */
-static int commit(struct drm_plane *plane)
-{
-	struct drm_device *dev = plane->dev;
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_overlay *ovl = omap_plane->ovl;
-	struct omap_overlay_info *info = &omap_plane->info;
-	int ret;
-
-	DBG("%s", ovl->name);
-	DBG("%dx%d -> %dx%d (%d)", info->width, info->height, info->out_width,
-			info->out_height, info->screen_width);
-	DBG("%d,%d %08x %08x", info->pos_x, info->pos_y,
-			info->paddr, info->p_uv_addr);
-
-	/* NOTE: do we want to do this at all here, or just wait
-	 * for dpms(ON) since other CRTC's may not have their mode
-	 * set yet, so fb dimensions may still change..
-	 */
-	ret = ovl->set_overlay_info(ovl, info);
-	if (ret) {
-		dev_err(dev->dev, "could not set overlay info\n");
-		return ret;
-	}
-
-	mutex_lock(&omap_plane->unpin_mutex);
-	omap_plane->num_unpins += omap_plane->pending_num_unpins;
-	omap_plane->pending_num_unpins = 0;
-	mutex_unlock(&omap_plane->unpin_mutex);
-
-	/* our encoder doesn't necessarily get a commit() after this, in
-	 * particular in the dpms() and mode_set_base() cases, so force the
-	 * manager to update:
-	 *
-	 * could this be in the encoder somehow?
-	 */
-	if (ovl->manager) {
-		ret = ovl->manager->apply(ovl->manager);
-		if (ret) {
-			dev_err(dev->dev, "could not apply settings\n");
-			return ret;
-		}
-
-		/*
-		 * NOTE: really this should be atomic w/ mgr->apply() but
-		 * omapdss does not expose such an API
-		 */
-		if (omap_plane->num_unpins > 0)
-			install_irq(plane);
-
-	} else {
-		struct omap_drm_private *priv = dev->dev_private;
-		queue_work(priv->wq, &omap_plane->work);
-	}
-
-
-	if (ovl->is_enabled(ovl)) {
-		omap_framebuffer_flush(plane->fb, info->pos_x, info->pos_y,
-				info->out_width, info->out_height);
-	}
-
-	return 0;
-}
-
-/* when CRTC that we are attached to has potentially changed, this checks
- * if we are attached to proper manager, and if necessary updates.
- */
-static void update_manager(struct drm_plane *plane)
-{
-	struct omap_drm_private *priv = plane->dev->dev_private;
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_overlay *ovl = omap_plane->ovl;
-	struct omap_overlay_manager *mgr = NULL;
-	int i;
-
-	if (plane->crtc) {
-		for (i = 0; i < priv->num_encoders; i++) {
-			struct drm_encoder *encoder = priv->encoders[i];
-			if (encoder->crtc == plane->crtc) {
-				mgr = omap_encoder_get_manager(encoder);
-				break;
-			}
-		}
-	}
-
-	if (ovl->manager != mgr) {
-		bool enabled = ovl->is_enabled(ovl);
-
-		/* don't switch things around with enabled overlays: */
-		if (enabled)
-			omap_plane_dpms(plane, DRM_MODE_DPMS_OFF);
-
-		if (ovl->manager) {
-			DBG("disconnecting %s from %s", ovl->name,
-					ovl->manager->name);
-			ovl->unset_manager(ovl);
-		}
-
-		if (mgr) {
-			DBG("connecting %s to %s", ovl->name, mgr->name);
-			ovl->set_manager(ovl, mgr);
-		}
-
-		if (enabled && mgr)
-			omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
-	}
-}
-
 static void unpin(void *arg, struct drm_gem_object *bo)
 {
 	struct drm_plane *plane = arg;
@@ -244,7 +70,6 @@ static void unpin(void *arg, struct drm_gem_object *bo)
 
 	if (kfifo_put(&omap_plane->unpin_fifo,
 			(const struct drm_gem_object **)&bo)) {
-		omap_plane->pending_num_unpins++;
 		/* also hold a ref so it isn't free'd while pinned */
 		drm_gem_object_reference(bo);
 	} else {
@@ -264,9 +89,7 @@ static int update_pin(struct drm_plane *plane, struct drm_framebuffer *fb)
 
 		DBG("%p -> %p", pinned_fb, fb);
 
-		mutex_lock(&omap_plane->unpin_mutex);
 		ret = omap_framebuffer_replace(pinned_fb, fb, plane, unpin);
-		mutex_unlock(&omap_plane->unpin_mutex);
 
 		if (ret) {
 			dev_err(plane->dev->dev, "could not swap %p -> %p\n",
@@ -281,31 +104,92 @@ static int update_pin(struct drm_plane *plane, struct drm_framebuffer *fb)
 	return 0;
 }
 
-/* update parameters that are dependent on the framebuffer dimensions and
- * position within the fb that this plane scans out from. This is called
- * when framebuffer or x,y base may have changed.
- */
-static void update_scanout(struct drm_plane *plane)
+static void omap_plane_pre_apply(struct omap_drm_apply *apply)
 {
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_overlay_info *info = &omap_plane->info;
+	struct omap_plane *omap_plane =
+			container_of(apply, struct omap_plane, apply);
 	struct omap_drm_window *win = &omap_plane->win;
+	struct drm_plane *plane = &omap_plane->base;
+	struct drm_device *dev = plane->dev;
+	struct drm_encoder *encoder = plane->crtc ?
+			omap_crtc_attached_encoder(plane->crtc) : NULL;
+	struct omap_overlay_info *info = &omap_plane->info;
+	bool enabled = omap_plane->enabled && encoder;
+	bool ilace, replication;
 	int ret;
 
-	ret = update_pin(plane, plane->fb);
-	if (ret) {
-		dev_err(plane->dev->dev,
-			"could not pin fb: %d\n", ret);
-		omap_plane_dpms(plane, DRM_MODE_DPMS_OFF);
+	DBG("%s", omap_plane->name);
+
+	/* if fb has changed, pin new fb: */
+	update_pin(plane, enabled ? plane->fb : NULL);
+
+	if (!enabled) {
+		dispc_ovl_enable(omap_plane->plane, false);
 		return;
 	}
 
+	/* update scanout: */
 	omap_framebuffer_update_scanout(plane->fb, win, info);
 
-	DBG("%s: %d,%d: %08x %08x (%d)", omap_plane->ovl->name,
-			win->src_x, win->src_y,
-			(u32)info->paddr, (u32)info->p_uv_addr,
+	DBG("%dx%d -> %dx%d (%d)", info->width, info->height,
+			info->out_width, info->out_height,
 			info->screen_width);
+	DBG("%d,%d %08x %08x", info->pos_x, info->pos_y,
+			info->paddr, info->p_uv_addr);
+
+	/* TODO: */
+	ilace = false;
+	replication = false;
+
+	/* and finally, update omapdss: */
+	ret = dispc_ovl_setup(omap_plane->plane, info, ilace,
+			replication, omap_encoder_timings(encoder));
+	if (ret) {
+		dev_err(dev->dev, "dispc_ovl_setup failed: %d\n", ret);
+		return;
+	}
+
+	dispc_ovl_enable(omap_plane->plane, true);
+	dispc_ovl_set_channel_out(omap_plane->plane,
+			omap_encoder_channel(encoder));
+}
+
+static void omap_plane_post_apply(struct omap_drm_apply *apply)
+{
+	struct omap_plane *omap_plane =
+			container_of(apply, struct omap_plane, apply);
+	struct drm_plane *plane = &omap_plane->base;
+	struct omap_overlay_info *info = &omap_plane->info;
+	struct drm_gem_object *bo = NULL;
+	struct callback cb;
+
+	cb = omap_plane->apply_done_cb;
+	omap_plane->apply_done_cb.fxn = NULL;
+
+	while (kfifo_get(&omap_plane->unpin_fifo, &bo)) {
+		omap_gem_put_paddr(bo);
+		drm_gem_object_unreference_unlocked(bo);
+	}
+
+	if (cb.fxn)
+		cb.fxn(cb.arg);
+
+	if (omap_plane->enabled) {
+		omap_framebuffer_flush(plane->fb, info->pos_x, info->pos_y,
+				info->out_width, info->out_height);
+	}
+}
+
+static int apply(struct drm_plane *plane)
+{
+	if (plane->crtc) {
+		struct omap_plane *omap_plane = to_omap_plane(plane);
+		struct drm_encoder *encoder =
+				omap_crtc_attached_encoder(plane->crtc);
+		if (encoder)
+			return omap_encoder_apply(encoder, &omap_plane->apply);
+	}
+	return 0;
 }
 
 int omap_plane_mode_set(struct drm_plane *plane,
@@ -313,7 +197,8 @@ int omap_plane_mode_set(struct drm_plane *plane,
 		int crtc_x, int crtc_y,
 		unsigned int crtc_w, unsigned int crtc_h,
 		uint32_t src_x, uint32_t src_y,
-		uint32_t src_w, uint32_t src_h)
+		uint32_t src_w, uint32_t src_h,
+		void (*fxn)(void *), void *arg)
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct omap_drm_window *win = &omap_plane->win;
@@ -329,17 +214,13 @@ int omap_plane_mode_set(struct drm_plane *plane,
 	win->src_w = src_w >> 16;
 	win->src_h = src_h >> 16;
 
-	/* note: this is done after this fxn returns.. but if we need
-	 * to do a commit/update_scanout, etc before this returns we
-	 * need the current value.
-	 */
+	omap_plane->apply_done_cb.fxn = fxn;
+	omap_plane->apply_done_cb.arg = arg;
+
 	plane->fb = fb;
 	plane->crtc = crtc;
 
-	update_scanout(plane);
-	update_manager(plane);
-
-	return 0;
+	return apply(plane);
 }
 
 static int omap_plane_update(struct drm_plane *plane,
@@ -349,9 +230,12 @@ static int omap_plane_update(struct drm_plane *plane,
 		uint32_t src_x, uint32_t src_y,
 		uint32_t src_w, uint32_t src_h)
 {
-	omap_plane_mode_set(plane, crtc, fb, crtc_x, crtc_y, crtc_w, crtc_h,
-			src_x, src_y, src_w, src_h);
-	return omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
+	struct omap_plane *omap_plane = to_omap_plane(plane);
+	omap_plane->enabled = true;
+	return omap_plane_mode_set(plane, crtc, fb,
+			crtc_x, crtc_y, crtc_w, crtc_h,
+			src_x, src_y, src_w, src_h,
+			NULL, NULL);
 }
 
 static int omap_plane_disable(struct drm_plane *plane)
@@ -364,10 +248,10 @@ static int omap_plane_disable(struct drm_plane *plane)
 static void omap_plane_destroy(struct drm_plane *plane)
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
-	DBG("%s", omap_plane->ovl->name);
+	DBG("%s", omap_plane->name);
 	omap_plane_disable(plane);
 	drm_plane_cleanup(plane);
-	WARN_ON(omap_plane->pending_num_unpins + omap_plane->num_unpins > 0);
+	WARN_ON(!kfifo_is_empty(&omap_plane->unpin_fifo));
 	kfifo_free(&omap_plane->unpin_fifo);
 	kfree(omap_plane);
 }
@@ -375,37 +259,15 @@ static void omap_plane_destroy(struct drm_plane *plane)
 int omap_plane_dpms(struct drm_plane *plane, int mode)
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
-	struct omap_overlay *ovl = omap_plane->ovl;
-	int r;
-
-	DBG("%s: %d", omap_plane->ovl->name, mode);
+	bool enabled = (mode == DRM_MODE_DPMS_ON);
+	int ret = 0;
 
-	if (mode == DRM_MODE_DPMS_ON) {
-		update_scanout(plane);
-		r = commit(plane);
-		if (!r)
-			r = ovl->enable(ovl);
-	} else {
-		struct omap_drm_private *priv = plane->dev->dev_private;
-		r = ovl->disable(ovl);
-		update_pin(plane, NULL);
-		queue_work(priv->wq, &omap_plane->work);
+	if (enabled != omap_plane->enabled) {
+		omap_plane->enabled = enabled;
+		ret = apply(plane);
 	}
 
-	return r;
-}
-
-void omap_plane_on_endwin(struct drm_plane *plane,
-		void (*fxn)(void *), void *arg)
-{
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-
-	mutex_lock(&omap_plane->unpin_mutex);
-	omap_plane->endwin.fxn = fxn;
-	omap_plane->endwin.arg = arg;
-	mutex_unlock(&omap_plane->unpin_mutex);
-
-	install_irq(plane);
+	return ret;
 }
 
 /* helper to install properties which are common to planes and crtcs */
@@ -443,15 +305,9 @@ int omap_plane_set_property(struct drm_plane *plane,
 	int ret = -EINVAL;
 
 	if (property == priv->rotation_prop) {
-		struct omap_overlay *ovl = omap_plane->ovl;
-
-		DBG("%s: rotation: %02x", ovl->name, (uint32_t)val);
+		DBG("%s: rotation: %02x", omap_plane->name, (uint32_t)val);
 		omap_plane->win.rotation = val;
-
-		if (ovl->is_enabled(ovl))
-			ret = omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
-		else
-			ret = 0;
+		ret = apply(plane);
 	}
 
 	return ret;
@@ -471,36 +327,35 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 {
 	struct drm_plane *plane = NULL;
 	struct omap_plane *omap_plane;
+	struct omap_overlay_info *info;
 	int ret;
 
 	DBG("%s: possible_crtcs=%08x, priv=%d", ovl->name,
 			possible_crtcs, priv);
 
-	/* friendly reminder to update table for future hw: */
-	WARN_ON(ovl->id >= ARRAY_SIZE(id2irq));
-
 	omap_plane = kzalloc(sizeof(*omap_plane), GFP_KERNEL);
 	if (!omap_plane) {
 		dev_err(dev->dev, "could not allocate plane\n");
 		goto fail;
 	}
 
-	mutex_init(&omap_plane->unpin_mutex);
-
 	ret = kfifo_alloc(&omap_plane->unpin_fifo, 16, GFP_KERNEL);
 	if (ret) {
 		dev_err(dev->dev, "could not allocate unpin FIFO\n");
 		goto fail;
 	}
 
-	INIT_WORK(&omap_plane->work, unpin_worker);
-
 	omap_plane->nformats = omap_framebuffer_get_formats(
 			omap_plane->formats, ARRAY_SIZE(omap_plane->formats),
 			ovl->supported_modes);
-	omap_plane->ovl = ovl;
+	omap_plane->plane = ovl->id;
+	omap_plane->name = ovl->name;
+
 	plane = &omap_plane->base;
 
+	omap_plane->apply.pre_apply  = omap_plane_pre_apply;
+	omap_plane->apply.post_apply = omap_plane_post_apply;
+
 	drm_plane_init(dev, plane, possible_crtcs, &omap_plane_funcs,
 			omap_plane->formats, omap_plane->nformats, priv);
 
@@ -509,11 +364,12 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	/* get our starting configuration, set defaults for parameters
 	 * we don't currently use, etc:
 	 */
-	ovl->get_overlay_info(ovl, &omap_plane->info);
-	omap_plane->info.rotation_type = OMAP_DSS_ROT_DMA;
-	omap_plane->info.rotation = OMAP_DSS_ROT_0;
-	omap_plane->info.global_alpha = 0xff;
-	omap_plane->info.mirror = 0;
+	info = &omap_plane->info;
+	ovl->get_overlay_info(ovl, info);
+	info->rotation_type = OMAP_DSS_ROT_DMA;
+	info->rotation = OMAP_DSS_ROT_0;
+	info->global_alpha = 0xff;
+	info->mirror = 0;
 
 	/* Set defaults depending on whether we are a CRTC or overlay
 	 * layer.
@@ -525,8 +381,6 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	else
 		omap_plane->info.zorder = ovl->id;
 
-	update_manager(plane);
-
 	return plane;
 
 fail:
-- 
1.7.9.5

