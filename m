From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/2] omap3: iovmm: Support non page-aligned buffers in iommu_vmap
Date: Wed,  1 Jun 2011 14:25:02 +0200
Message-ID: <1306931102-10943-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <20110531132233.GQ11352@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:47416 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab1FAMZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 08:25:23 -0400
Received: from localhost.localdomain (unknown [91.178.85.245])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1213359A1
	for <linux-omap@vger.kernel.org>; Wed,  1 Jun 2011 12:25:21 +0000 (UTC)
In-Reply-To: <20110531132233.GQ11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The IOMMU virtual memory mapping API requires page-aligned buffers.
There's no hardware reason behind such a restriction. Remove it by
rounding the address of the first page entry down, and adding the offset
back to the IOMMU virtual address.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index b82cef4..fa5ae98 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -60,6 +60,15 @@
 
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
@@ -72,11 +81,17 @@ static size_t sgtable_len(const struct sg_table *sgt)
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
 
@@ -207,8 +222,8 @@ static void *vmap_sg(const struct sg_table *sgt)
 		u32 pa;
 		int err;
 
-		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg_dma_len(sg) + sg->offset;
 
 		BUG_ON(bytes != PAGE_SIZE);
 
@@ -485,8 +500,8 @@ static int map_iovm_area(struct iommu *obj, struct iovm_struct *new,
 		size_t bytes;
 		struct iotlb_entry e;
 
-		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg_dma_len(sg) + sg->offset;
 
 		flags &= ~IOVMF_PGSZ_MASK;
 		pgsz = bytes_to_iopgsz(bytes);
@@ -666,7 +681,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 	if (IS_ERR_VALUE(da))
 		vunmap_sg(va);
 
-	return da;
+	return da + sgtable_offset(sgt);
 }
 EXPORT_SYMBOL_GPL(iommu_vmap);
 
@@ -685,6 +700,7 @@ struct sg_table *iommu_vunmap(struct iommu *obj, u32 da)
 	 * 'sgt' is allocated before 'iommu_vmalloc()' is called.
 	 * Just returns 'sgt' to the caller to free
 	 */
+	da &= PAGE_MASK;
 	sgt = unmap_vm_area(obj, da, vunmap_sg, IOVMF_DISCONT | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.7.3.4

