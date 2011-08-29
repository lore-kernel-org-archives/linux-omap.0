From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Mon, 29 Aug 2011 22:36:09 +0300
Message-ID: <1314646569-16738-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43317 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1H2Tgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 15:36:48 -0400
Received: by wwf5 with SMTP id 5so6075111wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 12:36:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ohad Ben-Cohen <ohad@wizery.com>

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

omap_iovmm requires page-aligned buffers, and that sometimes causes
omap3isp failures (i.e. whenever the buffer passed from userspace is not
page-aligned).

Remove this limitation by rounding the address of the first page entry
down, and adding the offset back to the device address.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
[ohad@wizery.com: slightly edited the commit log]
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
A fix by Laurent that was waiting until omap's iommu lands in drivers/.

Generally we're not extending omap-iovmm anymore, but this fixes a real
breakage for omap3isp users, so there's no point in delaying it until
the generic DMA API is ready and we've migrated.

Thanks Laurent!

 drivers/iommu/omap-iovmm.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 5e7f97d..d28a256 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -27,6 +27,15 @@
 
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
@@ -39,11 +48,17 @@ static size_t sgtable_len(const struct sg_table *sgt)
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes;
 
-		bytes = sg->length;
+		bytes = sg->length + sg->offset;
 
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
+					"entries\n", __func__, i);
 			return 0;
 		}
 
@@ -164,8 +179,8 @@ static void *vmap_sg(const struct sg_table *sgt)
 		u32 pa;
 		int err;
 
-		pa = sg_phys(sg);
-		bytes = sg->length;
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg->length + sg->offset;
 
 		BUG_ON(bytes != PAGE_SIZE);
 
@@ -405,8 +420,8 @@ static int map_iovm_area(struct iommu_domain *domain, struct iovm_struct *new,
 		u32 pa;
 		size_t bytes;
 
-		pa = sg_phys(sg);
-		bytes = sg->length;
+		pa = sg_phys(sg) - sg->offset;
+		bytes = sg->length + sg->offset;
 
 		flags &= ~IOVMF_PGSZ_MASK;
 
@@ -600,7 +615,7 @@ u32 omap_iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da,
 	if (IS_ERR_VALUE(da))
 		vunmap_sg(va);
 
-	return da;
+	return da + sgtable_offset(sgt);
 }
 EXPORT_SYMBOL_GPL(omap_iommu_vmap);
 
@@ -620,6 +635,7 @@ omap_iommu_vunmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da)
 	 * 'sgt' is allocated before 'omap_iommu_vmalloc()' is called.
 	 * Just returns 'sgt' to the caller to free
 	 */
+	da &= PAGE_MASK;
 	sgt = unmap_vm_area(domain, obj, da, vunmap_sg,
 					IOVMF_DISCONT | IOVMF_MMIO);
 	if (!sgt)
-- 
1.7.4.1

