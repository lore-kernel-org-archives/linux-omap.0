From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 5/7] omap: iovmm: remove unused functionality
Date: Thu, 18 Aug 2011 02:10:06 +0300
Message-ID: <1313622608-30397-6-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63009 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1HQXKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Aug 2011 19:10:49 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1018589wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 16:10:49 -0700 (PDT)
In-Reply-To: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Remove unused functionality from OMAP's iovmm module.

The intention is to eventually completely replace iovmm with the
generic DMA-API, so new code that'd need this iovmm functionality
will have to extend the DMA-API instead.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/include/plat/iovmm.h |    8 --
 drivers/iommu/omap-iovmm.c              |  167 -------------------------------
 2 files changed, 0 insertions(+), 175 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/arch/arm/plat-omap/include/plat/iovmm.h
index e2f0b38..fc9aa6f 100644
--- a/arch/arm/plat-omap/include/plat/iovmm.h
+++ b/arch/arm/plat-omap/include/plat/iovmm.h
@@ -81,14 +81,6 @@ extern u32 iommu_vmalloc(struct iommu_domain *domain, struct iommu *obj,
 				u32 da, size_t bytes, u32 flags);
 extern void iommu_vfree(struct iommu_domain *domain, struct iommu *obj,
 				const u32 da);
-extern u32 iommu_kmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
-				u32 pa, size_t bytes, u32 flags);
-extern void iommu_kunmap(struct iommu_domain *domain, struct iommu *obj,
-				u32 da);
-extern u32 iommu_kmalloc(struct iommu_domain *domain, struct iommu *obj,
-				u32 da, size_t bytes, u32 flags);
-extern void iommu_kfree(struct iommu_domain *domain, struct iommu *obj, u32 da);
-
 extern void *da_to_va(struct iommu *obj, u32 da);
 
 #endif /* __IOMMU_MMAP_H */
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 809ca12..d5cf3cf 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -419,40 +419,6 @@ static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
 	BUG_ON(!sgt);
 }
 
-static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 da,
-								size_t len)
-{
-	unsigned int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		unsigned bytes;
-
-		bytes = max_alignment(da | pa);
-		bytes = min_t(unsigned, bytes, iopgsz_max(len));
-
-		BUG_ON(!iopgsz_ok(bytes));
-
-		sg_set_buf(sg, phys_to_virt(pa), bytes);
-		/*
-		 * 'pa' is cotinuous(linear).
-		 */
-		pa += bytes;
-		da += bytes;
-		len -= bytes;
-	}
-	BUG_ON(len);
-}
-
-static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
-{
-	/*
-	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readability
-	 */
-	BUG_ON(!sgt);
-}
-
 /* create 'da' <-> 'pa' mapping from 'sgt' */
 static int map_iovm_area(struct iommu_domain *domain, struct iovm_struct *new,
 			const struct sg_table *sgt, u32 flags)
@@ -764,139 +730,6 @@ void iommu_vfree(struct iommu_domain *domain, struct iommu *obj, const u32 da)
 }
 EXPORT_SYMBOL_GPL(iommu_vfree);
 
-static u32 __iommu_kmap(struct iommu_domain *domain, struct iommu *obj,
-			u32 da, u32 pa, void *va, size_t bytes, u32 flags)
-{
-	struct sg_table *sgt;
-
-	sgt = sgtable_alloc(bytes, flags, da, pa);
-	if (IS_ERR(sgt))
-		return PTR_ERR(sgt);
-
-	sgtable_fill_kmalloc(sgt, pa, da, bytes);
-
-	da = map_iommu_region(domain, obj, da, sgt, va, bytes, flags);
-	if (IS_ERR_VALUE(da)) {
-		sgtable_drain_kmalloc(sgt);
-		sgtable_free(sgt);
-	}
-
-	return da;
-}
-
-/**
- * iommu_kmap  -  (d)-(p)-(v) address mapper
- * @obj:	objective iommu
- * @da:		contiguous iommu virtual memory
- * @pa:		contiguous physical memory
- * @flags:	iovma and page property
- *
- * Creates 1-1-1 mapping and returns @da again, which can be
- * adjusted if 'IOVMF_DA_FIXED' is not set.
- */
-u32 iommu_kmap(struct iommu_domain *domain, struct iommu *obj, u32 da, u32 pa,
-						size_t bytes, u32 flags)
-{
-	void *va;
-
-	if (!obj || !obj->dev || !bytes)
-		return -EINVAL;
-
-	bytes = PAGE_ALIGN(bytes);
-
-	va = ioremap(pa, bytes);
-	if (!va)
-		return -ENOMEM;
-
-	flags |= IOVMF_LINEAR;
-	flags |= IOVMF_MMIO;
-
-	da = __iommu_kmap(domain, obj, da, pa, va, bytes, flags);
-	if (IS_ERR_VALUE(da))
-		iounmap(va);
-
-	return da;
-}
-EXPORT_SYMBOL_GPL(iommu_kmap);
-
-/**
- * iommu_kunmap  -  release virtual mapping obtained by 'iommu_kmap()'
- * @obj:	objective iommu
- * @da:		iommu device virtual address
- *
- * Frees the iommu virtually contiguous memory area starting at
- * @da, which was passed to and was returned by'iommu_kmap()'.
- */
-void iommu_kunmap(struct iommu_domain *domain, struct iommu *obj, u32 da)
-{
-	struct sg_table *sgt;
-	typedef void (*func_t)(const void *);
-
-	sgt = unmap_vm_area(domain, obj, da, (func_t)iounmap,
-			    IOVMF_LINEAR | IOVMF_MMIO);
-	if (!sgt)
-		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-	sgtable_free(sgt);
-}
-EXPORT_SYMBOL_GPL(iommu_kunmap);
-
-/**
- * iommu_kmalloc  -  (d)-(p)-(v) address allocator and mapper
- * @obj:	objective iommu
- * @da:		contiguous iommu virtual memory
- * @bytes:	bytes for allocation
- * @flags:	iovma and page property
- *
- * Allocate @bytes linearly and creates 1-1-1 mapping and returns
- * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set.
- */
-u32 iommu_kmalloc(struct iommu_domain *domain, struct iommu *obj, u32 da,
-						size_t bytes, u32 flags)
-{
-	void *va;
-	u32 pa;
-
-	if (!obj || !obj->dev || !bytes)
-		return -EINVAL;
-
-	bytes = PAGE_ALIGN(bytes);
-
-	va = kmalloc(bytes, GFP_KERNEL | GFP_DMA);
-	if (!va)
-		return -ENOMEM;
-	pa = virt_to_phys(va);
-
-	flags |= IOVMF_LINEAR;
-	flags |= IOVMF_ALLOC;
-
-	da = __iommu_kmap(domain, obj, da, pa, va, bytes, flags);
-	if (IS_ERR_VALUE(da))
-		kfree(va);
-
-	return da;
-}
-EXPORT_SYMBOL_GPL(iommu_kmalloc);
-
-/**
- * iommu_kfree  -  release virtual mapping obtained by 'iommu_kmalloc()'
- * @obj:	objective iommu
- * @da:		iommu device virtual address
- *
- * Frees the iommu virtually contiguous memory area starting at
- * @da, which was passed to and was returned by'iommu_kmalloc()'.
- */
-void iommu_kfree(struct iommu_domain *domain, struct iommu *obj, u32 da)
-{
-	struct sg_table *sgt;
-
-	sgt = unmap_vm_area(domain, obj, da, kfree, IOVMF_LINEAR | IOVMF_ALLOC);
-	if (!sgt)
-		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-	sgtable_free(sgt);
-}
-EXPORT_SYMBOL_GPL(iommu_kfree);
-
-
 static int __init iovmm_init(void)
 {
 	const unsigned long flags = SLAB_HWCACHE_ALIGN;
-- 
1.7.4.1

