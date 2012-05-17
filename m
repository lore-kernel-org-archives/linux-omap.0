From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 1/2] staging: drm/omap: dmabuf/prime mmap support
Date: Thu, 17 May 2012 02:37:25 -0600
Message-ID: <1337243846-27942-2-git-send-email-rob.clark@linaro.org>
References: <1337243846-27942-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55563 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2EQIhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 04:37:37 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so993342wey.19
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 01:37:37 -0700 (PDT)
In-Reply-To: <1337243846-27942-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Add support for mmap'ing buffers via dmabuf.  For handling mmap of
cached buffers correctly, fault handling and PTE shootdown are used
to track dirty pages and automagically handle cache flushes before
dma access to the buffer.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.h        |    5 ++
 drivers/staging/omapdrm/omap_fb.c         |    5 +-
 drivers/staging/omapdrm/omap_gem.c        |  104 ++++++++++++++++++++++++++---
 drivers/staging/omapdrm/omap_gem_dmabuf.c |   48 +++++++++++++
 4 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index 3586173..73a606e 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -138,6 +138,8 @@ int omap_gem_dumb_destroy(struct drm_file *file, struct drm_device *dev,
 int omap_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
 int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int omap_gem_mmap_obj(struct drm_gem_object *obj,
+		struct vm_area_struct *vma);
 int omap_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf);
 int omap_gem_op_start(struct drm_gem_object *obj, enum omap_gem_op op);
 int omap_gem_op_finish(struct drm_gem_object *obj, enum omap_gem_op op);
@@ -145,6 +147,9 @@ int omap_gem_op_sync(struct drm_gem_object *obj, enum omap_gem_op op);
 int omap_gem_op_async(struct drm_gem_object *obj, enum omap_gem_op op,
 		void (*fxn)(void *arg), void *arg);
 int omap_gem_roll(struct drm_gem_object *obj, uint32_t roll);
+void omap_gem_cpu_sync(struct drm_gem_object *obj, int pgoff);
+void omap_gem_dma_sync(struct drm_gem_object *obj,
+		enum dma_data_direction dir);
 int omap_gem_get_paddr(struct drm_gem_object *obj,
 		dma_addr_t *paddr, bool remap);
 int omap_gem_put_paddr(struct drm_gem_object *obj);
diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omapdrm/omap_fb.c
index 04b235b..3478757 100644
--- a/drivers/staging/omapdrm/omap_fb.c
+++ b/drivers/staging/omapdrm/omap_fb.c
@@ -197,8 +197,11 @@ int omap_framebuffer_replace(struct drm_framebuffer *a,
 			pa->paddr = 0;
 		}
 
-		if (pb && !ret)
+		if (pb && !ret) {
 			ret = omap_gem_get_paddr(pb->bo, &pb->paddr, true);
+			if (!ret)
+				omap_gem_dma_sync(pb->bo, DMA_TO_DEVICE);
+		}
 	}
 
 	if (ret) {
diff --git a/drivers/staging/omapdrm/omap_gem.c b/drivers/staging/omapdrm/omap_gem.c
index c5ba334..3a0d035 100644
--- a/drivers/staging/omapdrm/omap_gem.c
+++ b/drivers/staging/omapdrm/omap_gem.c
@@ -207,13 +207,27 @@ static inline bool is_shmem(struct drm_gem_object *obj)
 	return obj->filp != NULL;
 }
 
+/**
+ * shmem buffers that are mapped cached can simulate coherency via using
+ * page faulting to keep track of dirty pages
+ */
+static inline bool is_cached_coherent(struct drm_gem_object *obj)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+	return is_shmem(obj) &&
+		((omap_obj->flags & OMAP_BO_CACHE_MASK) == OMAP_BO_CACHED);
+}
+
 static DEFINE_SPINLOCK(sync_lock);
 
 /** ensure backing pages are allocated */
 static int omap_gem_attach_pages(struct drm_gem_object *obj)
 {
+	struct drm_device *dev = obj->dev;
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
 	struct page **pages;
+	int i, npages = obj->size >> PAGE_SHIFT;
+	dma_addr_t *addrs;
 
 	WARN_ON(omap_obj->pages);
 
@@ -231,16 +245,18 @@ static int omap_gem_attach_pages(struct drm_gem_object *obj)
 	 * DSS, GPU, etc. are not cache coherent:
 	 */
 	if (omap_obj->flags & (OMAP_BO_WC|OMAP_BO_UNCACHED)) {
-		int i, npages = obj->size >> PAGE_SHIFT;
-		dma_addr_t *addrs = kmalloc(npages * sizeof(addrs), GFP_KERNEL);
+		addrs = kmalloc(npages * sizeof(addrs), GFP_KERNEL);
 		for (i = 0; i < npages; i++) {
-			addrs[i] = dma_map_page(obj->dev->dev, pages[i],
+			addrs[i] = dma_map_page(dev->dev, pages[i],
 					0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 		}
-		omap_obj->addrs = addrs;
+	} else {
+		addrs = kzalloc(npages * sizeof(addrs), GFP_KERNEL);
 	}
 
+	omap_obj->addrs = addrs;
 	omap_obj->pages = pages;
+
 	return 0;
 }
 
@@ -258,10 +274,11 @@ static void omap_gem_detach_pages(struct drm_gem_object *obj)
 			dma_unmap_page(obj->dev->dev, omap_obj->addrs[i],
 					PAGE_SIZE, DMA_BIDIRECTIONAL);
 		}
-		kfree(omap_obj->addrs);
-		omap_obj->addrs = NULL;
 	}
 
+	kfree(omap_obj->addrs);
+	omap_obj->addrs = NULL;
+
 	_drm_gem_put_pages(obj, omap_obj->pages, true, false);
 	omap_obj->pages = NULL;
 }
@@ -336,6 +353,7 @@ static int fault_1d(struct drm_gem_object *obj,
 			vma->vm_start) >> PAGE_SHIFT;
 
 	if (omap_obj->pages) {
+		omap_gem_cpu_sync(obj, pgoff);
 		pfn = page_to_pfn(omap_obj->pages[pgoff]);
 	} else {
 		BUG_ON(!(omap_obj->flags & OMAP_BO_DMA));
@@ -510,7 +528,6 @@ fail:
 /** We override mainly to fix up some of the vm mapping flags.. */
 int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	struct omap_gem_object *omap_obj;
 	int ret;
 
 	ret = drm_gem_mmap(filp, vma);
@@ -519,8 +536,13 @@ int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 		return ret;
 	}
 
-	/* after drm_gem_mmap(), it is safe to access the obj */
-	omap_obj = to_omap_bo(vma->vm_private_data);
+	return omap_gem_mmap_obj(vma->vm_private_data, vma);
+}
+
+int omap_gem_mmap_obj(struct drm_gem_object *obj,
+		struct vm_area_struct *vma)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
 
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_flags |= VM_MIXEDMAP;
@@ -530,12 +552,31 @@ int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	} else if (omap_obj->flags & OMAP_BO_UNCACHED) {
 		vma->vm_page_prot = pgprot_noncached(vm_get_page_prot(vma->vm_flags));
 	} else {
+		/*
+		 * We do have some private objects, at least for scanout buffers
+		 * on hardware without DMM/TILER.  But these are allocated write-
+		 * combine
+		 */
+		if (WARN_ON(!obj->filp))
+			return -EINVAL;
+
+		/*
+		 * Shunt off cached objs to shmem file so they have their own
+		 * address_space (so unmap_mapping_range does what we want,
+		 * in particular in the case of mmap'd dmabufs)
+		 */
+		fput(vma->vm_file);
+		get_file(obj->filp);
+		vma->vm_pgoff = 0;
+		vma->vm_file  = obj->filp;
+
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	}
 
-	return ret;
+	return 0;
 }
 
+
 /**
  * omap_gem_dumb_create	-	create a dumb buffer
  * @drm_file: our client file
@@ -645,6 +686,48 @@ fail:
 	return ret;
 }
 
+/* Sync the buffer for CPU access.. note pages should already be
+ * attached, ie. omap_gem_get_pages()
+ */
+void omap_gem_cpu_sync(struct drm_gem_object *obj, int pgoff)
+{
+	struct drm_device *dev = obj->dev;
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+
+	if (is_cached_coherent(obj) && omap_obj->addrs[pgoff]) {
+		dma_unmap_page(dev->dev, omap_obj->addrs[pgoff],
+				PAGE_SIZE, DMA_BIDIRECTIONAL);
+		omap_obj->addrs[pgoff] = 0;
+	}
+}
+
+/* sync the buffer for DMA access */
+void omap_gem_dma_sync(struct drm_gem_object *obj,
+		enum dma_data_direction dir)
+{
+	struct drm_device *dev = obj->dev;
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+
+	if (is_cached_coherent(obj)) {
+		int i, npages = obj->size >> PAGE_SHIFT;
+		struct page **pages = omap_obj->pages;
+		bool dirty = false;
+
+		for (i = 0; i < npages; i++) {
+			if (!omap_obj->addrs[i]) {
+				omap_obj->addrs[i] = dma_map_page(dev->dev, pages[i], 0,
+						PAGE_SIZE, DMA_BIDIRECTIONAL);
+				dirty = true;
+			}
+		}
+
+		if (dirty) {
+			unmap_mapping_range(obj->filp->f_mapping, 0,
+					omap_gem_mmap_size(obj), 1);
+		}
+	}
+}
+
 /* Get physical address for DMA.. if 'remap' is true, and the buffer is not
  * already contiguous, remap it to pin in physically contiguous memory.. (ie.
  * map in TILER)
@@ -709,6 +792,7 @@ int omap_gem_get_paddr(struct drm_gem_object *obj,
 		*paddr = omap_obj->paddr;
 	} else {
 		ret = -EINVAL;
+		goto fail;
 	}
 
 fail:
diff --git a/drivers/staging/omapdrm/omap_gem_dmabuf.c b/drivers/staging/omapdrm/omap_gem_dmabuf.c
index 2fa39e8..aba4b34 100644
--- a/drivers/staging/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/staging/omapdrm/omap_gem_dmabuf.c
@@ -50,6 +50,9 @@ static struct sg_table *omap_gem_map_dma_buf(
 	sg_set_page(sg->sgl, pfn_to_page(PFN_DOWN(paddr)), obj->size, 0);
 	sg_dma_address(sg->sgl) = paddr;
 
+	/* this should be after _get_paddr() to ensure we have pages attached */
+	omap_gem_dma_sync(obj, dir);
+
 out:
 	if (ret)
 		return ERR_PTR(ret);
@@ -104,6 +107,7 @@ static void *omap_gem_dmabuf_kmap_atomic(struct dma_buf *buffer,
 	struct drm_gem_object *obj = buffer->priv;
 	struct page **pages;
 	omap_gem_get_pages(obj, &pages, false);
+	omap_gem_cpu_sync(obj, page_num);
 	return kmap_atomic(pages[page_num]);
 }
 
@@ -119,6 +123,7 @@ static void *omap_gem_dmabuf_kmap(struct dma_buf *buffer,
 	struct drm_gem_object *obj = buffer->priv;
 	struct page **pages;
 	omap_gem_get_pages(obj, &pages, false);
+	omap_gem_cpu_sync(obj, page_num);
 	return kmap(pages[page_num]);
 }
 
@@ -131,6 +136,48 @@ static void omap_gem_dmabuf_kunmap(struct dma_buf *buffer,
 	kunmap(pages[page_num]);
 }
 
+/*
+ * TODO maybe we can split up drm_gem_mmap to avoid duplicating
+ * some here.. or at least have a drm_dmabuf_mmap helper.
+ */
+static int omap_gem_dmabuf_mmap(struct dma_buf *buffer,
+		struct vm_area_struct *vma)
+{
+	struct drm_gem_object *obj = buffer->priv;
+	int ret = 0;
+
+	if (WARN_ON(!obj->filp))
+		return -EINVAL;
+
+	/* Check for valid size. */
+	if (omap_gem_mmap_size(obj) < vma->vm_end - vma->vm_start) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (!obj->dev->driver->gem_vm_ops) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	vma->vm_flags |= VM_RESERVED | VM_IO | VM_PFNMAP | VM_DONTEXPAND;
+	vma->vm_ops = obj->dev->driver->gem_vm_ops;
+	vma->vm_private_data = obj;
+	vma->vm_page_prot =  pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+
+	/* Take a ref for this mapping of the object, so that the fault
+	 * handler can dereference the mmap offset's pointer to the object.
+	 * This reference is cleaned up by the corresponding vm_close
+	 * (which should happen whether the vma was created by this call, or
+	 * by a vm_open due to mremap or partial unmap or whatever).
+	 */
+	vma->vm_ops->open(vma);
+
+out_unlock:
+
+	return omap_gem_mmap_obj(obj, vma);
+}
+
 struct dma_buf_ops omap_dmabuf_ops = {
 		.map_dma_buf = omap_gem_map_dma_buf,
 		.unmap_dma_buf = omap_gem_unmap_dma_buf,
@@ -141,6 +188,7 @@ struct dma_buf_ops omap_dmabuf_ops = {
 		.kunmap_atomic = omap_gem_dmabuf_kunmap_atomic,
 		.kmap = omap_gem_dmabuf_kmap,
 		.kunmap = omap_gem_dmabuf_kunmap,
+		.mmap = omap_gem_dmabuf_mmap,
 };
 
 struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
-- 
1.7.9.5

