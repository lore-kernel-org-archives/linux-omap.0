From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 2/2] staging: drm/omap: initial dmabuf/prime import support
Date: Thu, 17 May 2012 02:37:26 -0600
Message-ID: <1337243846-27942-3-git-send-email-rob.clark@linaro.org>
References: <1337243846-27942-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56781 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2EQIhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 04:37:42 -0400
Received: by wibhm6 with SMTP id hm6so4182017wib.1
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 01:37:41 -0700 (PDT)
In-Reply-To: <1337243846-27942-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

This adds support to re-import omapdrm's own buffers.  Importing buffers
allocated by other drivers can be added later, but for now is not needed
(we don't yet have any other exportering drivers to test with).

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.c        |    2 ++
 drivers/staging/omapdrm/omap_drv.h        |    2 ++
 drivers/staging/omapdrm/omap_gem_dmabuf.c |   22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 1f559f4..0d2acca 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -767,7 +767,9 @@ static struct drm_driver omap_drm_driver = {
 		.debugfs_cleanup = omap_debugfs_cleanup,
 #endif
 		.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+		.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 		.gem_prime_export = omap_gem_prime_export,
+		.gem_prime_import = omap_gem_prime_import,
 		.gem_init_object = omap_gem_init_object,
 		.gem_free_object = omap_gem_free_object,
 		.gem_vm_ops = &omap_gem_vm_ops,
diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index 73a606e..f238d57 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -162,6 +162,8 @@ size_t omap_gem_mmap_size(struct drm_gem_object *obj);
 
 struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
 		struct drm_gem_object *obj, int flags);
+struct drm_gem_object * omap_gem_prime_import(struct drm_device *dev,
+		struct dma_buf *buffer);
 
 static inline int align_pitch(int pitch, int width, int bpp)
 {
diff --git a/drivers/staging/omapdrm/omap_gem_dmabuf.c b/drivers/staging/omapdrm/omap_gem_dmabuf.c
index aba4b34..42728e0 100644
--- a/drivers/staging/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/staging/omapdrm/omap_gem_dmabuf.c
@@ -196,3 +196,25 @@ struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
 {
 	return dma_buf_export(obj, &omap_dmabuf_ops, obj->size, 0600);
 }
+
+struct drm_gem_object * omap_gem_prime_import(struct drm_device *dev,
+		struct dma_buf *buffer)
+{
+	struct drm_gem_object *obj;
+
+	/* is this one of own objects? */
+	if (buffer->ops == &omap_dmabuf_ops) {
+		obj = buffer->priv;
+		/* is it from our device? */
+		if (obj->dev == dev) {
+			drm_gem_object_reference(obj);
+			return obj;
+		}
+	}
+
+	/*
+	 * TODO add support for importing buffers from other devices..
+	 * for now we don't need this but would be nice to add eventually
+	 */
+	return ERR_PTR(-EINVAL);
+}
-- 
1.7.9.5

