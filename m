From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 4/4] omap iommu: simple virtual address space management
Date: Mon, 29 Sep 2008 08:27:04 +0300
Message-ID: <1222666024-27137-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1222666024-27137-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1222666024-27137-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1222666024-27137-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1222666024-27137-4-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23011 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYI2F11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 01:27:27 -0400
In-Reply-To: <1222666024-27137-4-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, lethal@linux-sh.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This patch provides a device driver, which has a omap iommu, with
address mapping APIs between device virtual address(iommu), physical
address and mpu virtual address.

There are 3 possible patterns for iommu virtual address(iova/da) mapping.

   | iova			  mapping
   | da	pa	va	(d)-(p)-(v)		function	page
 ----------------------------------------------------------------------------
 1 | c	c,(a)	c	 1 - 1 - 1	  _mmap() / _munmap()	s
 2 | c	d	c	 1 - n - 1	  _vmap() / _vunmap()	s
 3 | c	d,a	c	 1 - n - 1	_vmalloc()/ _vfree()	n*

	'iova':	device iommu virtual address
	'da':	alias of 'iova'
	'pa':	physical address
	'va':	mpu virtual address

	'c':	contiguous memory area
	'd':	dicontiguous memory area
	'a':	anonymous memory allocation
	'()':	optional feature

	'n':	a normal page(4kb) size is used.
	's':	multiple iommu superpage(16mb, 1mb, 64kb, 4kb) size is used.

	'*':	's' should be supported.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/include/asm/io.h               |    2 +
 arch/arm/mm/ioremap.c                   |    7 +
 arch/arm/plat-omap/include/mach/iovmm.h |   93 ++++
 arch/arm/plat-omap/iovmm.c              |  910 +++++++++++++++++++++++++++++++
 4 files changed, 1012 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 create mode 100644 arch/arm/plat-omap/iovmm.c

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 7193485..97f4e35 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -75,6 +75,8 @@ extern void __iomem * __arm_ioremap_pfn(unsigned long, unsigned long, size_t, un
 extern void __iomem * __arm_ioremap(unsigned long, size_t, unsigned int);
 extern void __iounmap(volatile void __iomem *addr);
 
+extern int remap_area_page(unsigned long virt, unsigned long phys);
+
 /*
  * Bad read/write accesses...
  */
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index b81dbf9..80dba0c 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -110,6 +110,13 @@ static int remap_area_pages(unsigned long start, unsigned long pfn,
 	return err;
 }
 
+/* FIXME */
+int remap_area_page(unsigned long virt, unsigned long phys)
+{
+	return remap_area_pages(virt, __phys_to_pfn(phys), PAGE_SIZE,
+				get_mem_type(MT_DEVICE));
+}
+EXPORT_SYMBOL(remap_area_page);
 
 void __check_kvm_seq(struct mm_struct *mm)
 {
diff --git a/arch/arm/plat-omap/include/mach/iovmm.h b/arch/arm/plat-omap/include/mach/iovmm.h
new file mode 100644
index 0000000..43d84c2
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/iovmm.h
@@ -0,0 +1,93 @@
+/*
+ * omap iommu: simple virtual address space management
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __IOMMU_MMAP_H
+#define __IOMMU_MMAP_H
+
+struct iovm_struct {
+	struct iommu		*iommu;	/* iommu object which this belongs to */
+
+	u32			da_start; /* area definition */
+	u32			da_end;
+
+	u32			flags;
+
+	struct list_head	list; /* linked in ascending order */
+
+	struct sg_table		*sgt; /* collection of physical addresses */
+	void			*va; /* mpu side mapped address */
+};
+
+/*
+ * IOVMF_FLAGS: attribute for iommu virtual memory area(iovma)
+ *
+ * lower 16 bit is used for h/w and upper 16 bit is for s/w.
+ */
+#define IOVMF_SW_SHIFT		16
+#define IOVMF_HW_SIZE		(1 << IOVMF_SW_SHIFT)
+#define IOVMF_HW_MASK		(~(IOVMF_HW_SIZE - 1))
+#define IOVMF_SW_MASK		(~IOVMF_HW_MASK)UL
+
+/*
+ * iovma: h/w flags derived from cam and ram attribute
+ */
+#define IOVMF_CAM_MASK		(~((1 << 10) - 1))
+#define IOVMF_RAM_MASK		(~IOVMF_CAM_MASK)
+
+#define IOVMF_PGSZ_MASK		(3 << 0)
+#define IOVMF_PGSZ_1M		MMU_CAM_PGSZ_1M
+#define IOVMF_PGSZ_64K		MMU_CAM_PGSZ_64K
+#define IOVMF_PGSZ_4K		MMU_CAM_PGSZ_4K
+#define IOVMF_PGSZ_16M		MMU_CAM_PGSZ_16M
+
+#define IOVMF_ENDIAN_MASK	(1 << 9)
+#define IOVMF_ENDIAN_BIG	MMU_RAM_ENDIAN_BIG
+#define IOVMF_ENDIAN_LITTLE	MMU_RAM_ENDIAN_LITTLE
+
+#define IOVMF_ELSZ_MASK	(3 << 7)
+#define IOVMF_ELSZ_8		MMU_RAM_ELSZ_8
+#define IOVMF_ELSZ_16		MMU_RAM_ELSZ_16
+#define IOVMF_ELSZ_32		MMU_RAM_ELSZ_32
+#define IOVMF_ELSZ_NONE		MMU_RAM_ELSZ_NONE
+
+#define IOVMF_MIXED_MASK	(1 << 6)
+#define IOVMF_MIXED		MMU_RAM_MIXED
+
+/*
+ * iovma: s/w flags, used for mapping and umapping
+ */
+#define IOVMF_PAGE		(1 << (1 + IOVMF_SW_SHIFT))
+#define IOVMF_MMIO		(2 << (1 + IOVMF_SW_SHIFT))
+#define IOVMF_ALLOC_MASK	(3 << (1 + IOVMF_SW_SHIFT))
+
+#define IOVMF_SGLIST		(1 << (3 + IOVMF_SW_SHIFT))
+#define IOVMF_LINEAR		(2 << (3 + IOVMF_SW_SHIFT))
+#define IOVMF_LINEAR_MASK	(3 << (3 + IOVMF_SW_SHIFT))
+
+#define IOVMF_FIXED		(1 << (5 + IOVMF_SW_SHIFT))
+#define IOVMF_ANON		(2 << (5 + IOVMF_SW_SHIFT))
+#define IOVMF_ADDR_MASK		(3 << (5 + IOVMF_SW_SHIFT))
+
+extern void *iommu_vmalloc(struct iommu *obj, size_t len, u32 flags);
+extern void iommu_vfree(struct iommu *obj, const void *da);
+
+extern void *iommu_vmap(struct iommu *obj, const struct sg_table *sgt,
+			u32 flags);
+extern void iommu_vunmap(struct iommu *obj, void *da);
+
+extern void *iommu_mmap(struct iommu *obj, u32 da, u32 pa, size_t len,
+			u32 flags);
+extern void iommu_munmap(struct iommu *obj, void *da);
+
+extern struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da);
+
+#endif /* __IOMMU_MMAP_H */
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
new file mode 100644
index 0000000..4af11a4
--- /dev/null
+++ b/arch/arm/plat-omap/iovmm.c
@@ -0,0 +1,910 @@
+/*
+ * omap iommu: simple virtual address space management
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define DEBUG
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/vmalloc.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/scatterlist.h>
+#include <asm/cacheflush.h>
+
+#include <mach/iommu.h>
+#include <mach/iovmm.h>
+
+#include "iopgtable.h"
+
+/*
+ * There are 3 possible patterns for iommu virtual address(iova/da) mapping.
+ *
+ *   | iova			  mapping
+ *   | da	pa	va	(d)-(p)-(v)		function	page
+ * ----------------------------------------------------------------------------
+ * 1 | c	c,(a)	c	 1 - 1 - 1	  _mmap() / _munmap()	s
+ * 2 | c	d	c	 1 - n - 1	  _vmap() / _vunmap()	s
+ * 3 | c	d,a	c	 1 - n - 1	_vmalloc()/ _vfree()	n*
+ *
+ *	'iova':	device iommu virtual address
+ *	'da':	alias of 'iova'
+ *	'pa':	physical address
+ *	'va':	mpu virtual address
+ *
+ *	'c':	contiguous memory area
+ *	'd':	dicontiguous memory area
+ *	'a':	anonymous memory allocation
+ *	'()':	optional feature
+ *
+ *	'n':	a normal page(4kb) size is used.
+ *	's':	multiple iommu superpage(16mb, 1mb, 64kb, 4kb) size is used.
+ *
+ *	'*':    's' should be supported.
+ *
+ */
+
+enum {
+	SGTABLE_NORMAL,	/* PAGE_SIZE: 4kb */
+	SGTABLE_SUPER,	/* SUPERPAGE: 16mb, 1mb, 64kb, 4kb */
+};
+
+#define iovmf_ioremap(x)	((x & IOVMF_MMIO) && (x & IOVMF_LINEAR))
+#define iovmf_kmalloc(x)	((x & IOVMF_PAGE) && (x & IOVMF_LINEAR))
+#define iovmf_mmio_sg(x)	((x & IOVMF_MMIO) && (x & IOVMF_SGLIST))
+#define iovmf_anon_sg(x)	((x & IOVMF_PAGE) && (x & IOVMF_SGLIST))
+
+static struct kmem_cache *iovm_area_cachep;
+
+/* return total bytes of sg buffers */
+static size_t sgtable_len(const struct sg_table *sgt)
+{
+	unsigned int i, total = 0;
+	struct scatterlist *sg;
+
+	if (!sgt)
+		return 0;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		size_t bytes;
+
+		bytes = sg_dma_len(sg);
+
+		if (!iopgsz_ok(bytes)) {
+			pr_err("%s: sg[%d] not iommu pagesize(%x)\n",
+			       __func__, i, bytes);
+			return 0;
+		}
+
+		total += bytes;
+	}
+
+	return total;
+}
+#define sgtable_ok(x)	(!!sgtable_len(x))
+
+/* calculate the optimal number sg elements based on length */
+static unsigned int sgtable_nents(size_t len)
+{
+	int i;
+	unsigned int nr_entries;
+	const unsigned long page[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K, };
+
+	if (!IS_ALIGNED(len, PAGE_SIZE)) {
+		pr_err("%s: wrong size %08x\n", __func__, len);
+		return 0;
+	}
+
+	nr_entries = 0;
+	for (i = 0; i < ARRAY_SIZE(page); i++) {
+		if (len >= page[i]) {
+			nr_entries += (len / page[i]);
+			len %= page[i];
+		}
+	}
+	BUG_ON(len);
+
+	return nr_entries;
+}
+
+/* allocate and initialize sg_table header(a kind of superblock) */
+static struct sg_table *sgtable_alloc_sb(size_t len, int allow_sueperpage)
+{
+	unsigned int nr_entries;
+	int err;
+	struct sg_table *sgt;
+
+	if (!len)
+		return ERR_PTR(-EINVAL);
+
+	if (!IS_ALIGNED(len, PAGE_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	if (allow_sueperpage) {
+		nr_entries = sgtable_nents(len);
+		if (!nr_entries)
+			return ERR_PTR(-EINVAL);
+	} else
+		nr_entries = len / PAGE_SIZE;
+
+	WARN_ON(nr_entries >= 512); /* FIXME: limit of 'sg_alloc_table' ? */
+
+	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
+	if (err)
+		return ERR_PTR(err);
+
+	pr_debug("%s: sgt:%p(%d entries)\n", __func__, sgt, nr_entries);
+
+	return sgt;
+}
+
+/* free sg_table header(a kind of superblock) */
+static void sgtable_free_sb(struct sg_table *sgt)
+{
+	if (!sgt)
+		return;
+
+	sg_free_table(sgt);
+	kfree(sgt);
+
+	pr_debug("%s: sgt:%p\n", __func__, sgt);
+}
+
+static int sgtable_alloc_buf(struct sg_table *sgt, size_t len)
+{
+	unsigned int i, j;
+	struct scatterlist *sg;
+
+	if (!sgt || !len)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(len, PAGE_SIZE))
+		return -EINVAL;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		void *pa, *va;
+		size_t bytes;
+
+		bytes = iopgsz_max(len);
+		BUG_ON(!bytes);
+
+		va = kmalloc(bytes, GFP_KERNEL | GFP_DMA);
+		if (!va)
+			goto err_out;
+
+		pa = (void *)virt_to_phys(va);
+		sg_set_buf(sg, pa, bytes);
+
+		len -= bytes;
+	}
+	BUG_ON(len);
+
+	pr_debug("%s: %p filled with %x\n", __func__, sgt, len);
+	return 0;
+
+err_out:
+	i ? --i : i;
+	for_each_sg(sgt->sgl, sg, i, j) {
+		void *va;
+
+		va = sg_virt(sg);
+
+		BUG_ON(!virt_addr_valid(va));
+		kfree(va);
+	}
+
+	return -ENOMEM;
+}
+
+static void sgtable_free_buf(struct sg_table *sgt)
+{
+	unsigned int i;
+	struct scatterlist *sg;
+
+	if (!sgt)
+		return;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		void *va;
+
+		va = sg_virt(sg);
+
+		BUG_ON(!virt_addr_valid(va));
+		kfree(va);
+	}
+	pr_debug("%s: %p drained\n", __func__, sgt);
+}
+
+/* map 'sglist' to a contiguous mpu virtual area and return 'va' */
+static void *vmap_sg(const struct sg_table *sgt)
+{
+	u32 va;
+	size_t total;
+	unsigned int i;
+	struct scatterlist *sg;
+	struct vm_struct *new;
+	pgprot_t pgprot;
+
+	total = sgtable_len(sgt);
+	if (!total)
+		return ERR_PTR(-EINVAL);
+
+	new = __get_vm_area(total, VM_IOREMAP, VMALLOC_START, VMALLOC_END);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+	va = (u32)new->addr;
+
+	pgprot = pgprot_noncached(pgprot_kernel);
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		size_t bytes;
+		u32 pa;
+
+		pa = sg_dma_address(sg);
+		bytes = sg_dma_len(sg);
+
+		BUG_ON(bytes != PAGE_SIZE);
+
+		if (remap_area_page(va,  pa)) {
+			vunmap(new->addr);
+			return ERR_PTR(-EAGAIN);
+		}
+		va += bytes;
+	}
+
+	flush_cache_vmap(va, total);
+	return new->addr;
+}
+
+static void vunmap_sg(void *va)
+{
+	vunmap(va);
+}
+
+static struct iovm_struct *__find_iovm_area(struct iommu *obj, u32 da)
+{
+	struct iovm_struct *tmp;
+
+	list_for_each_entry(tmp, &obj->mmap, list) {
+		if ((da >= tmp->da_start) && (da < tmp->da_end)) {
+			size_t len;
+
+			len = tmp->da_end - tmp->da_start;
+
+			dev_dbg(obj->dev, "%s: %08x-%08x-%08x(%x) %08x\n",
+				__func__,
+				tmp->da_start, da, tmp->da_end, len,
+				tmp->flags);
+
+			return tmp;
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ *	find_iovm_area  -  find iovma which includes @da
+ *	@da:		iommu device virtual address
+ *
+ *	Find the existing iovma starting at @da
+ */
+struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da)
+{
+	struct iovm_struct *new;
+
+	mutex_lock(&obj->mmap_lock);
+	new = __find_iovm_area(obj, da);
+	mutex_unlock(&obj->mmap_lock);
+
+	return new;
+}
+EXPORT_SYMBOL_GPL(find_iovm_area);
+
+/*
+ * This finds the hole(area) which fits the requested address and len
+ * in IOVMAs mmap, and returns the new allocated iovma.
+ */
+static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
+					   size_t len, u32 flags)
+{
+	struct iovm_struct *tmp = NULL, *new;
+	u32 start, prev_end;
+
+	if (!obj || !len)
+		return ERR_PTR(-EINVAL);
+
+	start = ((flags & IOVMF_ADDR_MASK) == IOVMF_FIXED) ? da : 0;
+	prev_end = 0;
+
+	if (list_empty(&obj->mmap))
+		goto found;
+
+	list_for_each_entry(tmp, &obj->mmap, list) {
+
+		if ((prev_end <= start) && (start + len < tmp->da_start))
+			goto found;
+
+		if (!(flags & IOVMF_FIXED))
+			start = tmp->da_end;
+
+		prev_end = tmp->da_end;
+	}
+
+	dev_dbg(obj->dev, "%s: no space to fit %08x(%x)\n", __func__, da, len);
+	return ERR_PTR(-EINVAL);
+
+found:
+	new = kmem_cache_zalloc(iovm_area_cachep, GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	new->iommu = obj;
+	new->da_start = start;
+	new->da_end = start + len;
+	new->flags = flags;
+
+	/*
+	 * keep ascending order of IOVMAs
+	 */
+	if (tmp)
+		list_add_tail(&new->list, &tmp->list);
+	else
+		list_add(&new->list, &obj->mmap);
+
+	dev_dbg(obj->dev, "%s: %08x-%08x-%08x(%x) %08x\n",
+		__func__, new->da_start, da, new->da_end, len, flags);
+
+	return new;
+}
+
+static void free_iovm_area(struct iommu *obj, struct iovm_struct *area)
+{
+	size_t len = area->da_end - area->da_start;
+
+	BUG_ON(!obj || !area);
+
+	dev_dbg(obj->dev, "%s: %08x-%08x(%x) %08x\n",
+		__func__, area->da_start, area->da_end, len, area->flags);
+
+	list_del(&area->list);
+	kmem_cache_free(iovm_area_cachep, area);
+}
+
+static struct iovm_struct *alloc_iovm_anonymous(struct iommu *obj, size_t len,
+						u32 flags)
+{
+	flags &= ~IOVMF_ADDR_MASK;
+	flags |= IOVMF_ANON;
+
+	return alloc_iovm_area(obj, 0, len, flags);
+}
+
+static void free_iovm_anonymous(struct iommu *obj, struct iovm_struct *area)
+{
+	u32 flags = area->flags;
+
+	BUG_ON(!obj || !area);
+	WARN_ON((flags & IOVMF_ADDR_MASK) != IOVMF_ANON);
+
+	free_iovm_area(obj, area);
+}
+
+static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
+{
+	unsigned int i;
+	struct scatterlist *sg;
+	void *va = _va;
+	void *va_end;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		struct page *page;
+		size_t bytes;
+		void *pa;
+
+		/*
+		 * iommu 'superpage' isn't supported with 'iommu_vmalloc()'
+		 */
+		bytes = PAGE_SIZE;
+		page = vmalloc_to_page(va);
+		pa = (void *)page_to_phys(page);
+		sg_set_buf(sg, pa, bytes);
+
+		pr_debug("%s: %3d %p %p\n", __func__, i, va, pa);
+
+		va += bytes;
+	}
+
+	va_end = _va + PAGE_SIZE * i - 1;
+	flush_cache_vmap(_va, va_end);
+}
+
+static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
+{
+	/*
+	 * Actually this is not necessary at all, just exists for
+	 * consistency of the readibility
+	 */
+	BUG_ON(!sgt);
+}
+
+static int sgtable_fill_kmalloc(struct sg_table *sgt, void *pa, size_t len)
+{
+	unsigned int i;
+	struct scatterlist *sg;
+
+	if (!sgt || !len)
+		return -EINVAL;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		size_t bytes;
+
+		bytes = iopgsz_max(len);
+
+		BUG_ON(!iopgsz_ok(bytes));
+
+		sg->dma_address = (dma_addr_t)pa;
+		sg->length = bytes;
+
+		/*
+		 * 'pa' is cotinuous(linear).
+		 */
+		pa += bytes;
+		len -= bytes;
+	}
+	BUG_ON(len);
+
+	/* FIXME: flush cache */
+	return 0;
+}
+
+static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
+{
+	/*
+	 * Actually this is not necessary at all, just exists for
+	 * consistency of the readibility
+	 */
+	BUG_ON(!sgt);
+}
+
+static int map_iovma_sgtable(struct iommu *obj, struct iovm_struct *new,
+			     const struct sg_table *sgt, u32 flags)
+{
+	int err;
+	unsigned int i, j;
+	struct scatterlist *sg;
+	u32 da = new->da_start;
+
+	if (!obj || !new || !sgt)
+		return -EINVAL;
+
+	BUG_ON(!sgtable_ok(sgt));
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		u32 pa;
+		int pgsz;
+		size_t bytes;
+		struct iotlb_entry e;
+
+		pa = sg_dma_address(sg);
+		bytes = sg_dma_len(sg);
+
+		flags &= ~IOVMF_PGSZ_MASK;
+		pgsz = bytes_to_iopgsz(bytes);
+		if (pgsz < 0)
+			goto err_out;
+		flags |= pgsz;
+
+		iotlb_init_entry(&e, da, pa, flags);
+		err = iopgtable_store_entry(obj, &e);
+		if (err)
+			goto err_out;
+
+		da += bytes;
+	}
+	new->sgt = (struct sg_table *)sgt;
+
+	return 0;
+
+err_out:
+	i ? --i : i;
+	da = new->da_start;
+
+	for_each_sg(sgt->sgl, sg, i, j) {
+		size_t bytes;
+
+		bytes = iopgtable_clear_entry(obj, da);
+
+		BUG_ON(!iopgsz_ok(bytes));
+
+		da += bytes;
+	}
+	return err;
+}
+
+static void unmap_iovma(struct iommu *obj, struct iovm_struct *area)
+{
+	u32 start;
+	size_t len = area->da_end - area->da_start;
+
+	BUG_ON((!len) || !IS_ALIGNED(len, PAGE_SIZE));
+
+	start = area->da_start;
+	while (len > 0) {
+		size_t bytes;
+
+		bytes = iopgtable_clear_entry(obj, start);
+		if (bytes == 0)
+			bytes = PAGE_SIZE;
+		else
+			dev_dbg(obj->dev, "%s: unmap %08x(%x) %08x\n",
+				__func__, start, bytes, area->flags);
+
+		BUG_ON(!IS_ALIGNED(bytes, PAGE_SIZE));
+
+		len -= bytes;
+		start += bytes;
+	}
+	BUG_ON(len);
+}
+
+/*
+ * This is actually the common gateway to unmap the regions which was
+ * mapped by all mapper,'vmalloc()','vmap()' and 'mmap()'.
+ */
+static void __iommu_vunmap(struct iommu *obj, const void *da)
+{
+	struct iovm_struct *area;
+
+	if (!IS_ALIGNED((u32)da, PAGE_SIZE))
+		return;
+
+	area = __find_iovm_area(obj, (u32)da);
+	if (!area)
+		return;
+
+	unmap_iovma(obj, area);
+
+	/*
+	 * clearing mpu mapping, which depends on how it was allocated.
+	 */
+	if (iovmf_kmalloc(area->flags)) {
+		/*
+		 * 'va' was allocated by 'iommu_mmap(IOVMF_PAGE)'.
+		 */
+		kfree(area->va);
+
+	} else if (iovmf_ioremap(area->flags)) {
+		/*
+		 * 'va' was just mapped by 'iommu_mmap(IOVMF_MMIO)'.
+		 */
+		iounmap(area->va);
+
+	} else if (iovmf_anon_sg(area->flags)) {
+		/*
+		 * 'sgt' was created based on 'vmalloc()'.
+		 */
+		vfree(area->va);
+
+	} else if (iovmf_mmio_sg(area->flags)) {
+		/*
+		 * 'sg' was given by the caller, in the case of calling
+		 * 'iommu_vmap()'
+		 */
+		vunmap_sg(area->va);
+
+	} else {
+		/* shouldn't happen */
+		BUG();
+	}
+
+	dev_dbg(obj->dev, "%s: %08x-%p-%08x(%x) %08x\n", __func__,
+		area->da_start, da, area->da_end,
+		area->da_end - area->da_start, area->flags);
+
+	free_iovm_area(obj, area);
+}
+
+/**
+ *	iommu_vmap  -  (d)-(p)-(v) address mapper
+ *	@obj:		objective iommu
+ *	@sgt:		address of scatter gather table
+ *	@flags:		iovma and page property
+ *
+ *	Creates 1-n-1 mapping with given @sgt and returns @da.
+ *	All @sgt element must be io page size aligned.
+ */
+void *iommu_vmap(struct iommu *obj, const struct sg_table *sgt, u32 flags)
+{
+	unsigned int total;
+	void *va;
+	struct iovm_struct *new;
+	int err;
+
+	total = sgtable_len(sgt);
+	if (!total)
+		return ERR_PTR(-EINVAL);
+	total = PAGE_ALIGN(total);
+
+	va = vmap_sg(sgt);
+	if (IS_ERR(va))
+		return va;
+
+	mutex_lock(&obj->mmap_lock);
+
+	new = alloc_iovm_anonymous(obj, total, flags);
+	if (IS_ERR(new)) {
+		err = PTR_ERR(new);
+		goto err_alloc_iovm_area;
+	}
+
+	new->flags &= ~IOVMF_LINEAR_MASK;
+	new->flags |= IOVMF_SGLIST;
+	new->va = va;
+
+	err = map_iovma_sgtable(obj, new, sgt, new->flags);
+	if (err)
+		goto err_map;
+
+	dev_dbg(obj->dev, "%s: da:%08x(%x) %08x va:%p\n", __func__,
+		new->da_start, new->da_end - new->da_start, new->flags, va);
+
+	mutex_unlock(&obj->mmap_lock);
+	return (void *)new->da_start;
+
+err_map:
+	free_iovm_anonymous(obj, new);
+err_alloc_iovm_area:
+	vunmap_sg(va);
+
+	mutex_unlock(&obj->mmap_lock);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(iommu_vmap);
+
+/**
+ *	iommu_vunmap  -  release virtual mapping obtained by 'iommu_vmap()'
+ *	@obj:		objective iommu
+ *	@da:		iommu device virtual address
+ *
+ *	Free the iommu virtually contiguous memory area starting at
+ *	@da, which was returned by 'iommu_vmap()'.
+ */
+void iommu_vunmap(struct iommu *obj, void *da)
+{
+	BUG_ON(in_interrupt());
+
+	mutex_lock(&obj->mmap_lock);
+	__iommu_vunmap(obj, da);
+	mutex_unlock(&obj->mmap_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_vunmap);
+
+/**
+ *	iommu_vmalloc  -  (d)-(p)-(v) address mapper/allocator
+ *	@obj:		objective iommu
+ *	@size:		allocation size
+ *	@flags:		iovma and page property
+ *
+ *	Allocates @size of 'pa' region and creates 1-n-1 mapping and
+ *	returns @da.
+ */
+void *iommu_vmalloc(struct iommu *obj, size_t bytes, u32 flags)
+{
+	int err;
+	void *va;
+	struct iovm_struct *new;
+	struct sg_table *sgt = NULL;
+
+	if (!obj || !bytes)
+		return ERR_PTR(-EINVAL);
+
+	bytes = PAGE_ALIGN(bytes);
+
+	va = vmalloc(bytes);
+	if (!va) {
+		err = -ENOMEM;
+		goto err_vmalloc;
+	}
+
+	sgt = sgtable_alloc_sb(bytes, SGTABLE_NORMAL);
+	if (IS_ERR(sgt)) {
+		err = PTR_ERR(sgt);
+		goto err_sg_table;
+	}
+
+	sgtable_fill_vmalloc(sgt, va);
+
+	mutex_lock(&obj->mmap_lock);
+
+	new = alloc_iovm_anonymous(obj, bytes, flags | IOVMF_PAGE);
+	if (IS_ERR(new)) {
+		err = PTR_ERR(new);
+		goto err_alloc_iova;
+	}
+
+	new->flags &= ~IOVMF_LINEAR_MASK;
+	new->flags |= IOVMF_SGLIST;
+	new->va = va;
+
+	err = map_iovma_sgtable(obj, new, sgt, new->flags);
+	if (err)
+		goto err_map;
+
+	dev_dbg(obj->dev, "%s: da:%08x(%x) %08x va:%p\n", __func__,
+		new->da_start, new->da_end - new->da_start, new->flags, va);
+
+	mutex_unlock(&obj->mmap_lock);
+	return (void *)new->da_start;
+
+err_map:
+	free_iovm_anonymous(obj, new);
+err_alloc_iova:
+	sgtable_drain_vmalloc(sgt);
+err_vmalloc:
+	sgtable_free_sb(sgt);
+err_sg_table:
+	vfree(va);
+
+	mutex_unlock(&obj->mmap_lock);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(iommu_vmalloc);
+
+/**
+ *	iommu_vfree  -  release memory allocated by 'iommu_vmalloc()'
+ *	@obj:		objective iommu
+ *	@da:		iommu device virtual address
+ *
+ *	Frees the iommu virtually continuous memory area starting at
+ *	@da, as obtained from 'iommu_vmalloc()'.
+ */
+void iommu_vfree(struct iommu *obj, const void *da)
+{
+	BUG_ON(in_interrupt());
+
+	mutex_lock(&obj->mmap_lock);
+	__iommu_vunmap(obj, da);
+	mutex_unlock(&obj->mmap_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_vfree);
+
+/**
+ *	iommu_mmap  -  (d)-(p)-(v) address mapper/allocator
+ *	@obj:		objective iommu
+ *	@da:		contiguous iommu virtual memory
+ *	@pa:		contiguous physical memory
+ *	@va:		contiguous mpu virtual memory
+ *	@flags:		iovma and page property
+ *
+ *	Creates 1-1-1 mapping and returns @da again, which can be
+ *	adjusted if 'IOVMF_ANON' is set.
+ */
+void *iommu_mmap(struct iommu *obj, u32 da, u32 pa, size_t len, u32 flags)
+{
+	int err = -ENOMEM;
+	void *va;
+	struct sg_table *sgt;
+	struct iovm_struct *new;
+
+	if (!obj || !obj->dev || !len)
+		return ERR_PTR(-EINVAL);
+
+	len = PAGE_ALIGN(len);
+
+	switch (flags & IOVMF_ALLOC_MASK) {
+	case IOVMF_PAGE:
+		va = kmalloc(len, GFP_KERNEL | GFP_DMA);
+		if (!va)
+			return ERR_PTR(-ENOMEM);
+		pa = virt_to_phys(va);
+		break;
+	case IOVMF_MMIO:
+		va = ioremap(pa, len);
+		if (!va)
+			return ERR_PTR(-ENOMEM);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+		break;
+	}
+	flags |= IOVMF_LINEAR;
+
+	dev_dbg(obj->dev, "%s: da:%08x pa:%08x va:%p (%x) %08x\n",
+		__func__, da, pa, va, len, flags);
+
+	mutex_lock(&obj->mmap_lock);
+
+	new = alloc_iovm_area(obj, da, len, flags);
+	if (IS_ERR(new))
+		goto err_alloc;
+	new->va = va;
+
+	sgt = sgtable_alloc_sb(len, SGTABLE_SUPER);
+	if (IS_ERR(sgt))
+		goto err_sg_table;
+
+	err = sgtable_fill_kmalloc(sgt, (void *)pa, len);
+	if (err)
+		goto err_sg_remap;
+
+	err = map_iovma_sgtable(obj, new, sgt, new->flags);
+	if (err)
+		goto err_map_sg;
+
+	mutex_unlock(&obj->mmap_lock);
+
+	return (void *)new->da_start;
+
+err_map_sg:
+	sgtable_drain_kmalloc(sgt);
+err_sg_remap:
+	sgtable_free_sb(sgt);
+err_sg_table:
+	free_iovm_area(obj, new);
+err_alloc:
+	if (flags & IOVMF_PAGE)
+		kfree(va);
+	else if (flags & IOVMF_MMIO)
+		iounmap(va);
+	else
+		BUG();
+
+	mutex_unlock(&obj->mmap_lock);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(iommu_mmap);
+
+/**
+ *	iommu_munmap  -  release virtual mapping obtained by 'iommu_mmap()'
+ *	@obj:		objective iommu
+ *	@da:		iommu device virtual address
+ *
+ *	Frees the iommu virtually contiguous memory area starting at
+ *	@da, which was passed to and was returned by'iommu_mmap()'.
+ */
+void iommu_munmap(struct iommu *obj, void *da)
+{
+	BUG_ON(in_interrupt());
+
+	mutex_lock(&obj->mmap_lock);
+	__iommu_vunmap(obj, da);
+	mutex_unlock(&obj->mmap_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_munmap);
+
+static int __init iommu_mmap_init(void)
+{
+	const unsigned long flags = SLAB_HWCACHE_ALIGN;
+	struct kmem_cache *p;
+
+	p = kmem_cache_create("iovm_area_cache", sizeof(struct iovm_struct), 0,
+			      flags, NULL);
+	if (!p)
+		return -ENOMEM;
+	iovm_area_cachep = p;
+
+	return 0;
+}
+module_init(iommu_mmap_init);
+
+static void __exit iommu_mmap_exit(void)
+{
+	kmem_cache_destroy(iovm_area_cachep);
+}
+module_exit(iommu_mmap_exit);
+
+MODULE_DESCRIPTION("omap iommu: simple virtual address space management");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.6.0.2.229.g1293c

