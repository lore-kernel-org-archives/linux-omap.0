From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] iovmm: Support non page-aligned buffers in iommu_vmap
Date: Thu,  3 Jun 2010 14:53:07 +0200
Message-ID: <1275569587-32463-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:34064 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0FCMul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 08:50:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com

The IOMMU virtual memory mapping API requires page-aligned buffers.
There's no hardware reason behind such a restriction. Remove it by
rounding the address of the first page entry down, and adding the offset
back to the IOMMU virtual address.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/iovmm.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 663e2d2..7d63f98 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -59,6 +59,15 @@
 
 static struct kmem_cache *iovm_area_cachep;
 
+/* return the offset of the first scatterlist entry in a sg table */
+static unsigned int sgtable_offset(const struct sg_table *sgt)
+{
+	if (!sgt || !sgt->nents)
+		return 0;
+
+	return sgt->sgl->offset;
+}
+
 /* return total bytes of sg buffers */
 static size_t sgtable_len(const struct sg_table *sgt)
 {
@@ -71,11 +80,17 @@ static size_t sgtable_len(const struct sg_table *sgt)
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes;
 
-		bytes = sg_dma_len(sg);
+		bytes = sg_dma_len(sg) + sg->offset;
 
 		if (!iopgsz_ok(bytes)) {
-			pr_err("%s: sg[%d] not iommu pagesize(%x)\n",
-			       __func__, i, bytes);
+			pr_err("%s: sg[%d] not iommu pagesize(%u %u)\n",
+			       __func__, i, bytes, sg->offset);
+			return 0;
+		}
+
+		if (i && sg->offset) {
+			pr_err("%s: sg[%d] offset not allowed in internal "
+			       "entries\n", __func__, i);
 			return 0;
 		}
 
@@ -197,8 +212,8 @@ static void *vmap_sg(const struct sg_table *sgt)
 		u32 pa;
 		int err;
 
-		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg_dma_len(sg) + sg->offset;
 
 		BUG_ON(bytes != PAGE_SIZE);
 
@@ -467,8 +482,8 @@ static int map_iovm_area(struct iommu *obj, struct iovm_struct *new,
 		size_t bytes;
 		struct iotlb_entry e;
 
-		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg_dma_len(sg) + sg->offset;
 
 		flags &= ~IOVMF_PGSZ_MASK;
 		pgsz = bytes_to_iopgsz(bytes);
@@ -649,7 +664,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 	if (IS_ERR_VALUE(da))
 		vunmap_sg(va);
 
-	return da;
+	return da + sgtable_offset(sgt);
 }
 EXPORT_SYMBOL_GPL(iommu_vmap);
 
@@ -668,6 +683,7 @@ struct sg_table *iommu_vunmap(struct iommu *obj, u32 da)
 	 * 'sgt' is allocated before 'iommu_vmalloc()' is called.
 	 * Just returns 'sgt' to the caller to free
 	 */
+	da &= PAGE_MASK;
 	sgt = unmap_vm_area(obj, da, vunmap_sg, IOVMF_DISCONT | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.6.4.4

