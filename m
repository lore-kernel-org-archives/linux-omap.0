From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm: refcnt drm_framebuffer
Date: Tue, 31 Jul 2012 11:20:21 -0500
Message-ID: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43129 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab2GaQUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 12:20:37 -0400
Received: by obbuo13 with SMTP id uo13so10809073obb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 09:20:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

This simplifies drm fb lifetime, and if the crtc/plane needs to hold
a ref to the fb when disabling a pipe until the next vblank, this
avoids the need to make disabling an overlay synchronous.  This is a
problem that shows up when userspace is using a drm plane to
implement a hw cursor.. making overlay disable synchronous causes
a performance problem when x11 is rapidly enabling/disabling the
hw cursor.  But not making it synchronous opens up a race condition
for crashing if userspace turns around and immediately deletes the
fb.  Refcnt'ing the fb makes it possible to solve this problem.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/gpu/drm/drm_crtc.c                |   38 ++++++++++++++++++++++++++---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |    4 +--
 drivers/gpu/drm/i915/intel_display.c      |    4 +--
 include/drm/drm_crtc.h                    |    4 +++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 08a7aa7..2f928a3 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -294,6 +294,8 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 {
 	int ret;
 
+	kref_init(&fb->refcount);
+
 	ret = drm_mode_object_get(dev, &fb->base, DRM_MODE_OBJECT_FB);
 	if (ret)
 		return ret;
@@ -307,6 +309,36 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_framebuffer_init);
 
+static void drm_framebuffer_free(struct kref *kref)
+{
+	struct drm_framebuffer *fb =
+			container_of(kref, struct drm_framebuffer, refcount);
+	fb->funcs->destroy(fb);
+}
+
+/**
+ * drm_framebuffer_unreference - unref a framebuffer
+ *
+ * LOCKING:
+ * Caller must hold mode config lock.
+ */
+void drm_framebuffer_unreference(struct drm_framebuffer *fb)
+{
+	struct drm_device *dev = fb->dev;
+	WARN_ON(!mutex_is_locked(&dev->mode_config.mutex));
+	kref_put(&fb->refcount, drm_framebuffer_free);
+}
+EXPORT_SYMBOL(drm_framebuffer_unreference);
+
+/**
+ * drm_framebuffer_reference - incr the fb refcnt
+ */
+void drm_framebuffer_reference(struct drm_framebuffer *fb)
+{
+	kref_get(&fb->refcount);
+}
+EXPORT_SYMBOL(drm_framebuffer_reference);
+
 /**
  * drm_framebuffer_cleanup - remove a framebuffer object
  * @fb: framebuffer to remove
@@ -1031,7 +1063,7 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	}
 
 	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
-		fb->funcs->destroy(fb);
+		drm_framebuffer_unreference(fb);
 	}
 
 	list_for_each_entry_safe(crtc, ct, &dev->mode_config.crtc_list, head) {
@@ -2339,7 +2371,7 @@ int drm_mode_rmfb(struct drm_device *dev,
 	/* TODO unhock the destructor from the buffer object */
 
 	list_del(&fb->filp_head);
-	fb->funcs->destroy(fb);
+	drm_framebuffer_unreference(fb);
 
 out:
 	mutex_unlock(&dev->mode_config.mutex);
@@ -2490,7 +2522,7 @@ void drm_fb_release(struct drm_file *priv)
 	mutex_lock(&dev->mode_config.mutex);
 	list_for_each_entry_safe(fb, tfb, &priv->fbs, filp_head) {
 		list_del(&fb->filp_head);
-		fb->funcs->destroy(fb);
+		drm_framebuffer_unreference(fb);
 	}
 	mutex_unlock(&dev->mode_config.mutex);
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index d5586cc..05695d6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -266,8 +266,8 @@ static void exynos_drm_fbdev_destroy(struct drm_device *dev,
 	/* release drm framebuffer and real buffer */
 	if (fb_helper->fb && fb_helper->fb->funcs) {
 		fb = fb_helper->fb;
-		if (fb && fb->funcs->destroy)
-			fb->funcs->destroy(fb);
+		if (fb)
+			drm_framebuffer_unreference(fb);
 	}
 
 	/* release linux framebuffer */
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index a8538ac..a9d2328 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -5467,7 +5467,7 @@ bool intel_get_load_detect_pipe(struct intel_encoder *intel_encoder,
 	if (!drm_crtc_helper_set_mode(crtc, mode, 0, 0, old_fb)) {
 		DRM_DEBUG_KMS("failed to set mode on load-detect pipe\n");
 		if (old->release_fb)
-			old->release_fb->funcs->destroy(old->release_fb);
+			drm_framebuffer_unreference(old->release_fb);
 		crtc->fb = old_fb;
 		return false;
 	}
@@ -5497,7 +5497,7 @@ void intel_release_load_detect_pipe(struct intel_encoder *intel_encoder,
 		drm_helper_disable_unused_functions(dev);
 
 		if (old->release_fb)
-			old->release_fb->funcs->destroy(old->release_fb);
+			drm_framebuffer_unreference(old->release_fb);
 
 		return;
 	}
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index bac55c2..8a5b16d 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -221,6 +221,7 @@ struct drm_display_info {
 };
 
 struct drm_framebuffer_funcs {
+	/* note: use drm_framebuffer_unreference() */
 	void (*destroy)(struct drm_framebuffer *framebuffer);
 	int (*create_handle)(struct drm_framebuffer *fb,
 			     struct drm_file *file_priv,
@@ -245,6 +246,7 @@ struct drm_framebuffer_funcs {
 
 struct drm_framebuffer {
 	struct drm_device *dev;
+	struct kref refcount;
 	struct list_head head;
 	struct drm_mode_object base;
 	const struct drm_framebuffer_funcs *funcs;
@@ -923,6 +925,8 @@ extern void drm_framebuffer_set_object(struct drm_device *dev,
 extern int drm_framebuffer_init(struct drm_device *dev,
 				struct drm_framebuffer *fb,
 				const struct drm_framebuffer_funcs *funcs);
+void drm_framebuffer_unreference(struct drm_framebuffer *fb);
+void drm_framebuffer_reference(struct drm_framebuffer *fb);
 extern void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
 extern int drmfb_probe(struct drm_device *dev, struct drm_crtc *crtc);
 extern int drmfb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
-- 
1.7.9.5

