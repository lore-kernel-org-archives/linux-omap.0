From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 03/10] staging: drm/omap: call omap_gem_roll() in non-atomic ctx
Date: Mon,  5 Mar 2012 10:48:33 -0600
Message-ID: <1330966120-28582-4-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58192 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab2CEQtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:09 -0500
Received: by yenl12 with SMTP id l12so1739759yen.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:09 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

If fbcon calls us from atomic context, push the work off to the
workqueue to avoid calling into the gem/dmm code in an atomic
context.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_fbdev.c |   26 ++++++++++++++++++++++----
 drivers/staging/omapdrm/omap_gem.c   |   14 ++------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_fbdev.c b/drivers/staging/omapdrm/omap_fbdev.c
index 96940bb..11acd4c 100644
--- a/drivers/staging/omapdrm/omap_fbdev.c
+++ b/drivers/staging/omapdrm/omap_fbdev.c
@@ -37,6 +37,9 @@ struct omap_fbdev {
 	struct drm_framebuffer *fb;
 	struct drm_gem_object *bo;
 	bool ywrap_enabled;
+
+	/* for deferred dmm roll when getting called in atomic ctx */
+	struct work_struct work;
 };
 
 static void omap_fbdev_flush(struct fb_info *fbi, int x, int y, int w, int h);
@@ -75,12 +78,22 @@ static void omap_fbdev_imageblit(struct fb_info *fbi,
 				image->width, image->height);
 }
 
+static void pan_worker(struct work_struct *work)
+{
+	struct omap_fbdev *fbdev = container_of(work, struct omap_fbdev, work);
+	struct fb_info *fbi = fbdev->base.fbdev;
+	int npages;
+
+	/* DMM roll shifts in 4K pages: */
+	npages = fbi->fix.line_length >> PAGE_SHIFT;
+	omap_gem_roll(fbdev->bo, fbi->var.yoffset * npages);
+}
+
 static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *fbi)
 {
 	struct drm_fb_helper *helper = get_fb(fbi);
 	struct omap_fbdev *fbdev = to_omap_fbdev(helper);
-	int npages;
 
 	if (!helper)
 		goto fallback;
@@ -88,9 +101,12 @@ static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 	if (!fbdev->ywrap_enabled)
 		goto fallback;
 
-	/* DMM roll shifts in 4K pages: */
-	npages = fbi->fix.line_length >> PAGE_SHIFT;
-	omap_gem_roll(fbdev->bo, var->yoffset * npages);
+	if (drm_can_sleep()) {
+		pan_worker(&fbdev->work);
+	} else {
+		struct omap_drm_private *priv = helper->dev->dev_private;
+		queue_work(priv->wq, &fbdev->work);
+	}
 
 	return 0;
 
@@ -336,6 +352,8 @@ struct drm_fb_helper *omap_fbdev_init(struct drm_device *dev)
 		goto fail;
 	}
 
+	INIT_WORK(&fbdev->work, pan_worker);
+
 	helper = &fbdev->base;
 
 	helper->funcs = &omap_fb_helper_funcs;
diff --git a/drivers/staging/omapdrm/omap_gem.c b/drivers/staging/omapdrm/omap_gem.c
index b7d6f88..bd35520 100644
--- a/drivers/staging/omapdrm/omap_gem.c
+++ b/drivers/staging/omapdrm/omap_gem.c
@@ -566,6 +566,8 @@ fail:
 
 /* Set scrolling position.  This allows us to implement fast scrolling
  * for console.
+ *
+ * Call only from non-atomic contexts.
  */
 int omap_gem_roll(struct drm_gem_object *obj, uint32_t roll)
 {
@@ -580,18 +582,6 @@ int omap_gem_roll(struct drm_gem_object *obj, uint32_t roll)
 
 	omap_obj->roll = roll;
 
-	if (in_atomic() || mutex_is_locked(&obj->dev->struct_mutex)) {
-		/* this can get called from fbcon in atomic context.. so
-		 * just ignore it and wait for next time called from
-		 * interruptible context to update the PAT.. the result
-		 * may be that user sees wrap-around instead of scrolling
-		 * momentarily on the screen.  If we wanted to be fancier
-		 * we could perhaps schedule some workqueue work at this
-		 * point.
-		 */
-		return 0;
-	}
-
 	mutex_lock(&obj->dev->struct_mutex);
 
 	/* if we aren't mapped yet, we don't need to do anything */
-- 
1.7.5.4

