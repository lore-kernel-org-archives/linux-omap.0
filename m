From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] staging: drm/omap: dmabuf/prime support
Date: Thu,  5 Apr 2012 13:15:44 -0500
Message-ID: <1333649744-28410-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51768 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab2DESP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 14:15:59 -0400
Received: by obbtb18 with SMTP id tb18so2082987obb.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 11:15:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

For now just implementing the exporting APIs, not yet importing.  And
kmap is rejected on tiled buffers (although the usefulness of that seems
questionable, but could be added later if needed).

---
 drivers/staging/omapdrm/Makefile          |    1 +
 drivers/staging/omapdrm/omap_drv.c        |    4 +-
 drivers/staging/omapdrm/omap_drv.h        |    7 ++
 drivers/staging/omapdrm/omap_gem.c        |   26 +++++-
 drivers/staging/omapdrm/omap_gem_dmabuf.c |  150 +++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/omapdrm/omap_gem_dmabuf.c

diff --git a/drivers/staging/omapdrm/Makefile b/drivers/staging/omapdrm/Makefile
index d9cdc12..1ca0e00 100644
--- a/drivers/staging/omapdrm/Makefile
+++ b/drivers/staging/omapdrm/Makefile
@@ -13,6 +13,7 @@ omapdrm-y := omap_drv.o \
 	omap_fb.o \
 	omap_fbdev.o \
 	omap_gem.o \
+	omap_gem_dmabuf.o \
 	omap_dmm_tiler.o \
 	tcm-sita.o
 
diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 620b8d5..1f559f4 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -746,7 +746,7 @@ static const struct file_operations omapdriver_fops = {
 
 static struct drm_driver omap_drm_driver = {
 		.driver_features =
-				DRIVER_HAVE_IRQ | DRIVER_MODESET | DRIVER_GEM,
+				DRIVER_HAVE_IRQ | DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
 		.load = dev_load,
 		.unload = dev_unload,
 		.open = dev_open,
@@ -766,6 +766,8 @@ static struct drm_driver omap_drm_driver = {
 		.debugfs_init = omap_debugfs_init,
 		.debugfs_cleanup = omap_debugfs_cleanup,
 #endif
+		.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+		.gem_prime_export = omap_gem_prime_export,
 		.gem_init_object = omap_gem_init_object,
 		.gem_free_object = omap_gem_free_object,
 		.gem_vm_ops = &omap_gem_vm_ops,
diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index 3d22df7..2b41152 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -148,9 +148,16 @@ int omap_gem_roll(struct drm_gem_object *obj, uint32_t roll);
 int omap_gem_get_paddr(struct drm_gem_object *obj,
 		dma_addr_t *paddr, bool remap);
 int omap_gem_put_paddr(struct drm_gem_object *obj);
+int omap_gem_get_pages(struct drm_gem_object *obj, struct page ***pages,
+		bool remap);
+int omap_gem_put_pages(struct drm_gem_object *obj);
+uint32_t omap_gem_flags(struct drm_gem_object *obj);
 uint64_t omap_gem_mmap_offset(struct drm_gem_object *obj);
 size_t omap_gem_mmap_size(struct drm_gem_object *obj);
 
+struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
+		struct drm_gem_object *obj, int flags);
+
 static inline int align_pitch(int pitch, int width, int bpp)
 {
 	int bytespp = (bpp + 7) / 8;
diff --git a/drivers/staging/omapdrm/omap_gem.c b/drivers/staging/omapdrm/omap_gem.c
index 921f058..c5ba334 100644
--- a/drivers/staging/omapdrm/omap_gem.c
+++ b/drivers/staging/omapdrm/omap_gem.c
@@ -266,6 +266,12 @@ static void omap_gem_detach_pages(struct drm_gem_object *obj)
 	omap_obj->pages = NULL;
 }
 
+/* get buffer flags */
+uint32_t omap_gem_flags(struct drm_gem_object *obj)
+{
+	return to_omap_bo(obj)->flags;
+}
+
 /** get mmap offset */
 static uint64_t mmap_offset(struct drm_gem_object *obj)
 {
@@ -764,9 +770,27 @@ static int get_pages(struct drm_gem_object *obj, struct page ***pages)
 	return 0;
 }
 
-int omap_gem_get_pages(struct drm_gem_object *obj, struct page ***pages)
+/* if !remap, and we don't have pages backing, then fail, rather than
+ * increasing the pin count (which we don't really do yet anyways,
+ * because we don't support swapping pages back out).  And 'remap'
+ * might not be quite the right name, but I wanted to keep it working
+ * similarly to omap_gem_get_paddr().  Note though that mutex is not
+ * aquired if !remap (because this can be called in atomic ctxt),
+ * but probably omap_gem_get_paddr() should be changed to work in the
+ * same way.  If !remap, a matching omap_gem_put_pages() call is not
+ * required (and should not be made).
+ */
+int omap_gem_get_pages(struct drm_gem_object *obj, struct page ***pages,
+		bool remap)
 {
 	int ret;
+	if (!remap) {
+		struct omap_gem_object *omap_obj = to_omap_bo(obj);
+		if (!omap_obj->pages)
+			return -ENOMEM;
+		*pages = omap_obj->pages;
+		return 0;
+	}
 	mutex_lock(&obj->dev->struct_mutex);
 	ret = get_pages(obj, pages);
 	mutex_unlock(&obj->dev->struct_mutex);
diff --git a/drivers/staging/omapdrm/omap_gem_dmabuf.c b/drivers/staging/omapdrm/omap_gem_dmabuf.c
new file mode 100644
index 0000000..2fa39e8
--- /dev/null
+++ b/drivers/staging/omapdrm/omap_gem_dmabuf.c
@@ -0,0 +1,150 @@
+/*
+ * drivers/staging/omapdrm/omap_gem_dmabuf.c
+ *
+ * Copyright (C) 2011 Texas Instruments
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
+#include <linux/dma-buf.h>
+
+static struct sg_table *omap_gem_map_dma_buf(
+		struct dma_buf_attachment *attachment,
+		enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = attachment->dmabuf->priv;
+	struct sg_table *sg;
+	dma_addr_t paddr;
+	int ret;
+
+	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
+	if (!sg)
+		return ERR_PTR(-ENOMEM);
+
+	/* camera, etc, need physically contiguous.. but we need a
+	 * better way to know this..
+	 */
+	ret = omap_gem_get_paddr(obj, &paddr, true);
+	if (ret)
+		goto out;
+
+	ret = sg_alloc_table(sg, 1, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	sg_init_table(sg->sgl, 1);
+	sg_dma_len(sg->sgl) = obj->size;
+	sg_set_page(sg->sgl, pfn_to_page(PFN_DOWN(paddr)), obj->size, 0);
+	sg_dma_address(sg->sgl) = paddr;
+
+out:
+	if (ret)
+		return ERR_PTR(ret);
+	return sg;
+}
+
+static void omap_gem_unmap_dma_buf(struct dma_buf_attachment *attachment,
+		struct sg_table *sg, enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = attachment->dmabuf->priv;
+	omap_gem_put_paddr(obj);
+	sg_free_table(sg);
+	kfree(sg);
+}
+
+static void omap_gem_dmabuf_release(struct dma_buf *buffer)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	/* release reference that was taken when dmabuf was exported
+	 * in omap_gem_prime_set()..
+	 */
+	drm_gem_object_unreference_unlocked(obj);
+}
+
+
+static int omap_gem_dmabuf_begin_cpu_access(struct dma_buf *buffer,
+		size_t start, size_t len, enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	struct page **pages;
+	if (omap_gem_flags(obj) & OMAP_BO_TILED) {
+		/* TODO we would need to pin at least part of the buffer to
+		 * get de-tiled view.  For now just reject it.
+		 */
+		return -ENOMEM;
+	}
+	/* make sure we have the pages: */
+	return omap_gem_get_pages(obj, &pages, true);
+}
+
+static void omap_gem_dmabuf_end_cpu_access(struct dma_buf *buffer,
+		size_t start, size_t len, enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	omap_gem_put_pages(obj);
+}
+
+
+static void *omap_gem_dmabuf_kmap_atomic(struct dma_buf *buffer,
+		unsigned long page_num)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	struct page **pages;
+	omap_gem_get_pages(obj, &pages, false);
+	return kmap_atomic(pages[page_num]);
+}
+
+static void omap_gem_dmabuf_kunmap_atomic(struct dma_buf *buffer,
+		unsigned long page_num, void *addr)
+{
+	kunmap_atomic(addr);
+}
+
+static void *omap_gem_dmabuf_kmap(struct dma_buf *buffer,
+		unsigned long page_num)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	struct page **pages;
+	omap_gem_get_pages(obj, &pages, false);
+	return kmap(pages[page_num]);
+}
+
+static void omap_gem_dmabuf_kunmap(struct dma_buf *buffer,
+		unsigned long page_num, void *addr)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	struct page **pages;
+	omap_gem_get_pages(obj, &pages, false);
+	kunmap(pages[page_num]);
+}
+
+struct dma_buf_ops omap_dmabuf_ops = {
+		.map_dma_buf = omap_gem_map_dma_buf,
+		.unmap_dma_buf = omap_gem_unmap_dma_buf,
+		.release = omap_gem_dmabuf_release,
+		.begin_cpu_access = omap_gem_dmabuf_begin_cpu_access,
+		.end_cpu_access = omap_gem_dmabuf_end_cpu_access,
+		.kmap_atomic = omap_gem_dmabuf_kmap_atomic,
+		.kunmap_atomic = omap_gem_dmabuf_kunmap_atomic,
+		.kmap = omap_gem_dmabuf_kmap,
+		.kunmap = omap_gem_dmabuf_kunmap,
+};
+
+struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
+		struct drm_gem_object *obj, int flags)
+{
+	return dma_buf_export(obj, &omap_dmabuf_ops, obj->size, 0600);
+}
-- 
1.7.9.1

