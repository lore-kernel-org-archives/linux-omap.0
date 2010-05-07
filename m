From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/5] omap iommu: Fix superpage unalignment at allocation of iovm areas
Date: Fri,  7 May 2010 09:56:01 +0300
Message-ID: <1273215364-15098-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32334 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0EGG5C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:57:02 -0400
In-Reply-To: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Superpage addresses should be aligned on mapping size of 4KB, 64KB,
1MB and 16MB respectively both for physical and device virtual
addresses.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |  122 +++++++++++++++++++++++++------------------
 1 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 65c6d1f..111fbca 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: simple virtual address space management
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
@@ -87,33 +87,6 @@ static size_t sgtable_len(const struct sg_table *sgt)
 }
 #define sgtable_ok(x)	(!!sgtable_len(x))
 
-/*
- * calculate the optimal number sg elements from total bytes based on
- * iommu superpages
- */
-static unsigned int sgtable_nents(size_t bytes)
-{
-	int i;
-	unsigned int nr_entries;
-	const unsigned long pagesize[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K, };
-
-	if (!IS_ALIGNED(bytes, PAGE_SIZE)) {
-		pr_err("%s: wrong size %08x\n", __func__, bytes);
-		return 0;
-	}
-
-	nr_entries = 0;
-	for (i = 0; i < ARRAY_SIZE(pagesize); i++) {
-		if (bytes >= pagesize[i]) {
-			nr_entries += (bytes / pagesize[i]);
-			bytes %= pagesize[i];
-		}
-	}
-	BUG_ON(bytes);
-
-	return nr_entries;
-}
-
 /* allocate and initialize sg_table header(a kind of 'superblock') */
 static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags)
 {
@@ -127,13 +100,8 @@ static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags)
 	if (!IS_ALIGNED(bytes, PAGE_SIZE))
 		return ERR_PTR(-EINVAL);
 
-	/* FIXME: IOVMF_DA_FIXED should support 'superpages' */
-	if ((flags & IOVMF_LINEAR) && (flags & IOVMF_DA_ANON)) {
-		nr_entries = sgtable_nents(bytes);
-		if (!nr_entries)
-			return ERR_PTR(-EINVAL);
-	} else
-		nr_entries =  bytes / PAGE_SIZE;
+	/* FIXME: Maximam number of entries are always prepared. */
+	nr_entries =  bytes / PAGE_SIZE;
 
 	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt)
@@ -270,7 +238,7 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 	start = da;
 	alignement = PAGE_SIZE;
 
-	if (flags & IOVMF_DA_ANON) {
+	if ((da == 0) && (flags & IOVMF_DA_ANON)) {
 		/*
 		 * Reserve the first page for NULL
 		 */
@@ -404,29 +372,80 @@ static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
 	BUG_ON(!sgt);
 }
 
-static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, size_t len)
+static u32 __alloc_area_by_size(u32 start, u32 end, size_t unit,
+				struct scatterlist **_sg)
 {
-	unsigned int i;
+	u32 e;
 	struct scatterlist *sg;
-	void *va;
 
-	va = phys_to_virt(pa);
+	sg = *_sg;
+	while ((e = start + unit) <= end) {
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		size_t bytes;
+		pr_debug("%s: %08x %8d KB\n",
+			 __func__, start, (e - start) / SZ_1K);
 
-		bytes = iopgsz_max(len);
+		sg_set_buf(sg++, (const void *)start, unit);
+		start += unit;
+	}
+	*_sg = sg;
 
-		BUG_ON(!iopgsz_ok(bytes));
+	return start;
+}
 
-		sg_set_buf(sg, phys_to_virt(pa), bytes);
-		/*
-		 * 'pa' is cotinuous(linear).
-		 */
-		pa += bytes;
-		len -= bytes;
+static void alloc_area_by_size(u32 start, u32 end, u32 unit,
+			       struct scatterlist **_sg)
+{
+	u32 addr;
+
+	if (unit == 0)
+		return;
+
+	if (start == end)
+		return;
+
+	addr = ALIGN(start, unit);
+	if (addr > end) {
+		/* retry with smaller granularity */
+		alloc_area_by_size(start, end, iopgsz_max(unit - 1), _sg);
+		return;
+	}
+	/* lower chuck with smaller granularity */
+	alloc_area_by_size(start, addr, iopgsz_max(unit - 1), _sg);
+
+	addr = __alloc_area_by_size(addr, end, unit, _sg);
+	if (addr < end)
+		/* higher chuck with smaller granularity */
+		alloc_area_by_size(addr, end, iopgsz_max(unit - 1), _sg);
+}
+
+#ifdef DEBUG
+static void sgtable_dump_entries(struct sg_table *sgt)
+{
+	unsigned int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		pr_debug("%s: %3d %p %6d KB\n",
+			 __func__, i, sg_virt(sg), sg_dma_len(sg) / SZ_1K);
 	}
-	BUG_ON(len);
+}
+#else
+static inline void sgtable_dump_entries(struct sg_table *sgt) { }
+#endif
+
+static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, size_t len)
+{
+	struct scatterlist *sg;
+	u32 va;
+
+	sg = sgt->sgl;
+	va = (u32)phys_to_virt(pa);
+
+	alloc_area_by_size(va, va + len, SZ_16M, &sg);
+	/* update actual nents */
+	sgt->nents = sg - sgt->sgl;
+
+	sgtable_dump_entries(sgt);
 }
 
 static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
@@ -571,6 +590,7 @@ static u32 map_iommu_region(struct iommu *obj, u32 da,
 
 	mutex_lock(&obj->mmap_lock);
 
+	da = da ? da : sg_phys(sgt->sgl) &  ~(SZ_64K - 1);
 	new = alloc_iovm_area(obj, da, bytes, flags);
 	if (IS_ERR(new)) {
 		err = PTR_ERR(new);
-- 
1.7.1.rc1

