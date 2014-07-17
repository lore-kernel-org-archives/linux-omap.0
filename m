From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] iommu/omap: Remove virtual memory manager
Date: Thu, 17 Jul 2014 13:09:15 +0200
Message-ID: <1405595355-7341-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:36135 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbaGQLJN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 07:09:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>

The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that
is has been ported to the DMA API, remove the unused virtual memory
manager.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Joerg, could you please pick this patch up for v3.17 if possible ?

 drivers/iommu/Kconfig            |  10 +-
 drivers/iommu/Makefile           |   1 -
 drivers/iommu/omap-iommu-debug.c | 114 ------
 drivers/iommu/omap-iommu.c       |   2 -
 drivers/iommu/omap-iommu.h       |   6 +-
 drivers/iommu/omap-iovmm.c       | 791 ---------------------------------------
 include/linux/omap-iommu.h       |  37 +-
 7 files changed, 8 insertions(+), 953 deletions(-)
 delete mode 100644 drivers/iommu/omap-iovmm.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d260605..a1f0fad 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -143,16 +143,12 @@ config OMAP_IOMMU
 	depends on ARCH_OMAP2PLUS
 	select IOMMU_API
 
-config OMAP_IOVMM
-	tristate "OMAP IO Virtual Memory Manager Support"
-	depends on OMAP_IOMMU
-
 config OMAP_IOMMU_DEBUG
-       tristate "Export OMAP IOMMU/IOVMM internals in DebugFS"
-       depends on OMAP_IOVMM && DEBUG_FS
+       tristate "Export OMAP IOMMU internals in DebugFS"
+       depends on DEBUG_FS
        help
          Select this to see extensive information about
-         the internal state of OMAP IOMMU/IOVMM in debugfs.
+         the internal state of OMAP IOMMU in debugfs.
 
          Say N unless you know you need this.
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8893bad..6a4a00e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu2.o
-obj-$(CONFIG_OMAP_IOVMM) += omap-iovmm.o
 obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
 obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
 obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 80fffba..531658d 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -213,116 +213,6 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 	return bytes;
 }
 
-static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
-			       size_t count, loff_t *ppos)
-{
-	struct device *dev = file->private_data;
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	char *p, *buf;
-	struct iovm_struct *tmp;
-	int uninitialized_var(i);
-	ssize_t bytes;
-
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	p += sprintf(p, "%-3s %-8s %-8s %6s %8s\n",
-		     "No", "start", "end", "size", "flags");
-	p += sprintf(p, "-------------------------------------------------\n");
-
-	mutex_lock(&iommu_debug_lock);
-
-	list_for_each_entry(tmp, &obj->mmap, list) {
-		size_t len;
-		const char *str = "%3d %08x-%08x %6x %8x\n";
-		const int maxcol = 39;
-
-		len = tmp->da_end - tmp->da_start;
-		p += snprintf(p, maxcol, str,
-			      i, tmp->da_start, tmp->da_end, len, tmp->flags);
-
-		if (PAGE_SIZE - (p - buf) < maxcol)
-			break;
-		i++;
-	}
-
-	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
-
-	mutex_unlock(&iommu_debug_lock);
-	free_page((unsigned long)buf);
-
-	return bytes;
-}
-
-static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
-{
-	struct device *dev = file->private_data;
-	char *p, *buf;
-	struct iovm_struct *area;
-	ssize_t bytes;
-
-	count = min_t(ssize_t, count, PAGE_SIZE);
-
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	mutex_lock(&iommu_debug_lock);
-
-	area = omap_find_iovm_area(dev, (u32)ppos);
-	if (!area) {
-		bytes = -EINVAL;
-		goto err_out;
-	}
-	memcpy(p, area->va, count);
-	p += count;
-
-	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
-err_out:
-	mutex_unlock(&iommu_debug_lock);
-	free_page((unsigned long)buf);
-
-	return bytes;
-}
-
-static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
-			       size_t count, loff_t *ppos)
-{
-	struct device *dev = file->private_data;
-	struct iovm_struct *area;
-	char *p, *buf;
-
-	count = min_t(size_t, count, PAGE_SIZE);
-
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	mutex_lock(&iommu_debug_lock);
-
-	if (copy_from_user(p, userbuf, count)) {
-		count =  -EFAULT;
-		goto err_out;
-	}
-
-	area = omap_find_iovm_area(dev, (u32)ppos);
-	if (!area) {
-		count = -EINVAL;
-		goto err_out;
-	}
-	memcpy(area->va, p, count);
-err_out:
-	mutex_unlock(&iommu_debug_lock);
-	free_page((unsigned long)buf);
-
-	return count;
-}
-
 #define DEBUG_FOPS(name)						\
 	static const struct file_operations debug_##name##_fops = {	\
 		.open = simple_open,					\
@@ -342,8 +232,6 @@ DEBUG_FOPS_RO(ver);
 DEBUG_FOPS_RO(regs);
 DEBUG_FOPS_RO(tlb);
 DEBUG_FOPS(pagetable);
-DEBUG_FOPS_RO(mmap);
-DEBUG_FOPS(mem);
 
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
@@ -389,8 +277,6 @@ static int iommu_debug_register(struct device *dev, void *data)
 	DEBUG_ADD_FILE_RO(regs);
 	DEBUG_ADD_FILE_RO(tlb);
 	DEBUG_ADD_FILE(pagetable);
-	DEBUG_ADD_FILE_RO(mmap);
-	DEBUG_ADD_FILE(mem);
 
 	return 0;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 895af06..71d015b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -981,9 +981,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	obj->ctx = (void *)obj + sizeof(*obj);
 
 	spin_lock_init(&obj->iommu_lock);
-	mutex_init(&obj->mmap_lock);
 	spin_lock_init(&obj->page_table_lock);
-	INIT_LIST_HEAD(&obj->mmap);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	obj->regbase = devm_ioremap_resource(obj->dev, res);
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index ea920c3..36a85f3 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -46,9 +46,6 @@ struct omap_iommu {
 
 	int		nr_tlb_entries;
 
-	struct list_head	mmap;
-	struct mutex		mmap_lock; /* protect mmap */
-
 	void *ctx; /* iommu context: registres saved area */
 	u32 da_start;
 	u32 da_end;
@@ -154,9 +151,12 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 #define MMU_RAM_PADDR_MASK \
 	((~0UL >> MMU_RAM_PADDR_SHIFT) << MMU_RAM_PADDR_SHIFT)
 
+#define MMU_RAM_ENDIAN_SHIFT	9
 #define MMU_RAM_ENDIAN_MASK	(1 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ENDIAN_LITTLE	(0 << MMU_RAM_ENDIAN_SHIFT)
 #define MMU_RAM_ENDIAN_BIG	(1 << MMU_RAM_ENDIAN_SHIFT)
 
+#define MMU_RAM_ELSZ_SHIFT	7
 #define MMU_RAM_ELSZ_MASK	(3 << MMU_RAM_ELSZ_SHIFT)
 #define MMU_RAM_ELSZ_8		(0 << MMU_RAM_ELSZ_SHIFT)
 #define MMU_RAM_ELSZ_16		(1 << MMU_RAM_ELSZ_SHIFT)
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
deleted file mode 100644
index d147259..0000000
--- a/drivers/iommu/omap-iovmm.c
+++ /dev/null
@@ -1,791 +0,0 @@
-/*
- * omap iommu: simple virtual address space management
- *
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/device.h>
-#include <linux/scatterlist.h>
-#include <linux/iommu.h>
-#include <linux/omap-iommu.h>
-#include <linux/platform_data/iommu-omap.h>
-
-#include <asm/cacheflush.h>
-#include <asm/mach/map.h>
-
-#include "omap-iopgtable.h"
-#include "omap-iommu.h"
-
-/*
- * IOVMF_FLAGS: attribute for iommu virtual memory area(iovma)
- *
- * lower 16 bit is used for h/w and upper 16 bit is for s/w.
- */
-#define IOVMF_SW_SHIFT		16
-
-/*
- * iovma: h/w flags derived from cam and ram attribute
- */
-#define IOVMF_CAM_MASK		(~((1 << 10) - 1))
-#define IOVMF_RAM_MASK		(~IOVMF_CAM_MASK)
-
-#define IOVMF_PGSZ_MASK		(3 << 0)
-#define IOVMF_PGSZ_1M		MMU_CAM_PGSZ_1M
-#define IOVMF_PGSZ_64K		MMU_CAM_PGSZ_64K
-#define IOVMF_PGSZ_4K		MMU_CAM_PGSZ_4K
-#define IOVMF_PGSZ_16M		MMU_CAM_PGSZ_16M
-
-#define IOVMF_ENDIAN_MASK	(1 << 9)
-#define IOVMF_ENDIAN_BIG	MMU_RAM_ENDIAN_BIG
-
-#define IOVMF_ELSZ_MASK		(3 << 7)
-#define IOVMF_ELSZ_16		MMU_RAM_ELSZ_16
-#define IOVMF_ELSZ_32		MMU_RAM_ELSZ_32
-#define IOVMF_ELSZ_NONE		MMU_RAM_ELSZ_NONE
-
-#define IOVMF_MIXED_MASK	(1 << 6)
-#define IOVMF_MIXED		MMU_RAM_MIXED
-
-/*
- * iovma: s/w flags, used for mapping and umapping internally.
- */
-#define IOVMF_MMIO		(1 << IOVMF_SW_SHIFT)
-#define IOVMF_ALLOC		(2 << IOVMF_SW_SHIFT)
-#define IOVMF_ALLOC_MASK	(3 << IOVMF_SW_SHIFT)
-
-/* "superpages" is supported just with physically linear pages */
-#define IOVMF_DISCONT		(1 << (2 + IOVMF_SW_SHIFT))
-#define IOVMF_LINEAR		(2 << (2 + IOVMF_SW_SHIFT))
-#define IOVMF_LINEAR_MASK	(3 << (2 + IOVMF_SW_SHIFT))
-
-#define IOVMF_DA_FIXED		(1 << (4 + IOVMF_SW_SHIFT))
-
-static struct kmem_cache *iovm_area_cachep;
-
-/* return the offset of the first scatterlist entry in a sg table */
-static unsigned int sgtable_offset(const struct sg_table *sgt)
-{
-	if (!sgt || !sgt->nents)
-		return 0;
-
-	return sgt->sgl->offset;
-}
-
-/* return total bytes of sg buffers */
-static size_t sgtable_len(const struct sg_table *sgt)
-{
-	unsigned int i, total = 0;
-	struct scatterlist *sg;
-
-	if (!sgt)
-		return 0;
-
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		size_t bytes;
-
-		bytes = sg->length + sg->offset;
-
-		if (!iopgsz_ok(bytes)) {
-			pr_err("%s: sg[%d] not iommu pagesize(%u %u)\n",
-			       __func__, i, bytes, sg->offset);
-			return 0;
-		}
-
-		if (i && sg->offset) {
-			pr_err("%s: sg[%d] offset not allowed in internal entries\n",
-				__func__, i);
-			return 0;
-		}
-
-		total += bytes;
-	}
-
-	return total;
-}
-#define sgtable_ok(x)	(!!sgtable_len(x))
-
-static unsigned max_alignment(u32 addr)
-{
-	int i;
-	unsigned pagesize[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K, };
-	for (i = 0; i < ARRAY_SIZE(pagesize) && addr & (pagesize[i] - 1); i++)
-		;
-	return (i < ARRAY_SIZE(pagesize)) ? pagesize[i] : 0;
-}
-
-/*
- * calculate the optimal number sg elements from total bytes based on
- * iommu superpages
- */
-static unsigned sgtable_nents(size_t bytes, u32 da, u32 pa)
-{
-	unsigned nr_entries = 0, ent_sz;
-
-	if (!IS_ALIGNED(bytes, PAGE_SIZE)) {
-		pr_err("%s: wrong size %08x\n", __func__, bytes);
-		return 0;
-	}
-
-	while (bytes) {
-		ent_sz = max_alignment(da | pa);
-		ent_sz = min_t(unsigned, ent_sz, iopgsz_max(bytes));
-		nr_entries++;
-		da += ent_sz;
-		pa += ent_sz;
-		bytes -= ent_sz;
-	}
-
-	return nr_entries;
-}
-
-/* allocate and initialize sg_table header(a kind of 'superblock') */
-static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags,
-							u32 da, u32 pa)
-{
-	unsigned int nr_entries;
-	int err;
-	struct sg_table *sgt;
-
-	if (!bytes)
-		return ERR_PTR(-EINVAL);
-
-	if (!IS_ALIGNED(bytes, PAGE_SIZE))
-		return ERR_PTR(-EINVAL);
-
-	if (flags & IOVMF_LINEAR) {
-		nr_entries = sgtable_nents(bytes, da, pa);
-		if (!nr_entries)
-			return ERR_PTR(-EINVAL);
-	} else
-		nr_entries =  bytes / PAGE_SIZE;
-
-	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
-	if (!sgt)
-		return ERR_PTR(-ENOMEM);
-
-	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
-	if (err) {
-		kfree(sgt);
-		return ERR_PTR(err);
-	}
-
-	pr_debug("%s: sgt:%p(%d entries)\n", __func__, sgt, nr_entries);
-
-	return sgt;
-}
-
-/* free sg_table header(a kind of superblock) */
-static void sgtable_free(struct sg_table *sgt)
-{
-	if (!sgt)
-		return;
-
-	sg_free_table(sgt);
-	kfree(sgt);
-
-	pr_debug("%s: sgt:%p\n", __func__, sgt);
-}
-
-/* map 'sglist' to a contiguous mpu virtual area and return 'va' */
-static void *vmap_sg(const struct sg_table *sgt)
-{
-	u32 va;
-	size_t total;
-	unsigned int i;
-	struct scatterlist *sg;
-	struct vm_struct *new;
-	const struct mem_type *mtype;
-
-	mtype = get_mem_type(MT_DEVICE);
-	if (!mtype)
-		return ERR_PTR(-EINVAL);
-
-	total = sgtable_len(sgt);
-	if (!total)
-		return ERR_PTR(-EINVAL);
-
-	new = __get_vm_area(total, VM_IOREMAP, VMALLOC_START, VMALLOC_END);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
-	va = (u32)new->addr;
-
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		size_t bytes;
-		u32 pa;
-		int err;
-
-		pa = sg_phys(sg) - sg->offset;
-		bytes = sg->length + sg->offset;
-
-		BUG_ON(bytes != PAGE_SIZE);
-
-		err = ioremap_page(va,  pa, mtype);
-		if (err)
-			goto err_out;
-
-		va += bytes;
-	}
-
-	flush_cache_vmap((unsigned long)new->addr,
-				(unsigned long)(new->addr + total));
-	return new->addr;
-
-err_out:
-	WARN_ON(1); /* FIXME: cleanup some mpu mappings */
-	vunmap(new->addr);
-	return ERR_PTR(-EAGAIN);
-}
-
-static inline void vunmap_sg(const void *va)
-{
-	vunmap(va);
-}
-
-static struct iovm_struct *__find_iovm_area(struct omap_iommu *obj,
-							const u32 da)
-{
-	struct iovm_struct *tmp;
-
-	list_for_each_entry(tmp, &obj->mmap, list) {
-		if ((da >= tmp->da_start) && (da < tmp->da_end)) {
-			size_t len;
-
-			len = tmp->da_end - tmp->da_start;
-
-			dev_dbg(obj->dev, "%s: %08x-%08x-%08x(%x) %08x\n",
-				__func__, tmp->da_start, da, tmp->da_end, len,
-				tmp->flags);
-
-			return tmp;
-		}
-	}
-
-	return NULL;
-}
-
-/**
- * omap_find_iovm_area  -  find iovma which includes @da
- * @dev:	client device
- * @da:		iommu device virtual address
- *
- * Find the existing iovma starting at @da
- */
-struct iovm_struct *omap_find_iovm_area(struct device *dev, u32 da)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	struct iovm_struct *area;
-
-	mutex_lock(&obj->mmap_lock);
-	area = __find_iovm_area(obj, da);
-	mutex_unlock(&obj->mmap_lock);
-
-	return area;
-}
-EXPORT_SYMBOL_GPL(omap_find_iovm_area);
-
-/*
- * This finds the hole(area) which fits the requested address and len
- * in iovmas mmap, and returns the new allocated iovma.
- */
-static struct iovm_struct *alloc_iovm_area(struct omap_iommu *obj, u32 da,
-					   size_t bytes, u32 flags)
-{
-	struct iovm_struct *new, *tmp;
-	u32 start, prev_end, alignment;
-
-	if (!obj || !bytes)
-		return ERR_PTR(-EINVAL);
-
-	start = da;
-	alignment = PAGE_SIZE;
-
-	if (~flags & IOVMF_DA_FIXED) {
-		/* Don't map address 0 */
-		start = obj->da_start ? obj->da_start : alignment;
-
-		if (flags & IOVMF_LINEAR)
-			alignment = iopgsz_max(bytes);
-		start = roundup(start, alignment);
-	} else if (start < obj->da_start || start > obj->da_end ||
-					obj->da_end - start < bytes) {
-		return ERR_PTR(-EINVAL);
-	}
-
-	tmp = NULL;
-	if (list_empty(&obj->mmap))
-		goto found;
-
-	prev_end = 0;
-	list_for_each_entry(tmp, &obj->mmap, list) {
-
-		if (prev_end > start)
-			break;
-
-		if (tmp->da_start > start && (tmp->da_start - start) >= bytes)
-			goto found;
-
-		if (tmp->da_end >= start && ~flags & IOVMF_DA_FIXED)
-			start = roundup(tmp->da_end + 1, alignment);
-
-		prev_end = tmp->da_end;
-	}
-
-	if ((start >= prev_end) && (obj->da_end - start >= bytes))
-		goto found;
-
-	dev_dbg(obj->dev, "%s: no space to fit %08x(%x) flags: %08x\n",
-		__func__, da, bytes, flags);
-
-	return ERR_PTR(-EINVAL);
-
-found:
-	new = kmem_cache_zalloc(iovm_area_cachep, GFP_KERNEL);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
-
-	new->iommu = obj;
-	new->da_start = start;
-	new->da_end = start + bytes;
-	new->flags = flags;
-
-	/*
-	 * keep ascending order of iovmas
-	 */
-	if (tmp)
-		list_add_tail(&new->list, &tmp->list);
-	else
-		list_add(&new->list, &obj->mmap);
-
-	dev_dbg(obj->dev, "%s: found %08x-%08x-%08x(%x) %08x\n",
-		__func__, new->da_start, start, new->da_end, bytes, flags);
-
-	return new;
-}
-
-static void free_iovm_area(struct omap_iommu *obj, struct iovm_struct *area)
-{
-	size_t bytes;
-
-	BUG_ON(!obj || !area);
-
-	bytes = area->da_end - area->da_start;
-
-	dev_dbg(obj->dev, "%s: %08x-%08x(%x) %08x\n",
-		__func__, area->da_start, area->da_end, bytes, area->flags);
-
-	list_del(&area->list);
-	kmem_cache_free(iovm_area_cachep, area);
-}
-
-/**
- * omap_da_to_va - convert (d) to (v)
- * @dev:	client device
- * @da:		iommu device virtual address
- * @va:		mpu virtual address
- *
- * Returns mpu virtual addr which corresponds to a given device virtual addr
- */
-void *omap_da_to_va(struct device *dev, u32 da)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	void *va = NULL;
-	struct iovm_struct *area;
-
-	mutex_lock(&obj->mmap_lock);
-
-	area = __find_iovm_area(obj, da);
-	if (!area) {
-		dev_dbg(obj->dev, "%s: no da area(%08x)\n", __func__, da);
-		goto out;
-	}
-	va = area->va;
-out:
-	mutex_unlock(&obj->mmap_lock);
-
-	return va;
-}
-EXPORT_SYMBOL_GPL(omap_da_to_va);
-
-static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
-{
-	unsigned int i;
-	struct scatterlist *sg;
-	void *va = _va;
-	void *va_end;
-
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		struct page *pg;
-		const size_t bytes = PAGE_SIZE;
-
-		/*
-		 * iommu 'superpage' isn't supported with 'omap_iommu_vmalloc()'
-		 */
-		pg = vmalloc_to_page(va);
-		BUG_ON(!pg);
-		sg_set_page(sg, pg, bytes, 0);
-
-		va += bytes;
-	}
-
-	va_end = _va + PAGE_SIZE * i;
-}
-
-static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
-{
-	/*
-	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readability.
-	 */
-	BUG_ON(!sgt);
-}
-
-/* create 'da' <-> 'pa' mapping from 'sgt' */
-static int map_iovm_area(struct iommu_domain *domain, struct iovm_struct *new,
-			const struct sg_table *sgt, u32 flags)
-{
-	int err;
-	unsigned int i, j;
-	struct scatterlist *sg;
-	u32 da = new->da_start;
-
-	if (!domain || !sgt)
-		return -EINVAL;
-
-	BUG_ON(!sgtable_ok(sgt));
-
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		u32 pa;
-		size_t bytes;
-
-		pa = sg_phys(sg) - sg->offset;
-		bytes = sg->length + sg->offset;
-
-		flags &= ~IOVMF_PGSZ_MASK;
-
-		if (bytes_to_iopgsz(bytes) < 0)
-			goto err_out;
-
-		pr_debug("%s: [%d] %08x %08x(%x)\n", __func__,
-			 i, da, pa, bytes);
-
-		err = iommu_map(domain, da, pa, bytes, flags);
-		if (err)
-			goto err_out;
-
-		da += bytes;
-	}
-	return 0;
-
-err_out:
-	da = new->da_start;
-
-	for_each_sg(sgt->sgl, sg, i, j) {
-		size_t bytes;
-
-		bytes = sg->length + sg->offset;
-
-		/* ignore failures.. we're already handling one */
-		iommu_unmap(domain, da, bytes);
-
-		da += bytes;
-	}
-	return err;
-}
-
-/* release 'da' <-> 'pa' mapping */
-static void unmap_iovm_area(struct iommu_domain *domain, struct omap_iommu *obj,
-						struct iovm_struct *area)
-{
-	u32 start;
-	size_t total = area->da_end - area->da_start;
-	const struct sg_table *sgt = area->sgt;
-	struct scatterlist *sg;
-	int i;
-	size_t unmapped;
-
-	BUG_ON(!sgtable_ok(sgt));
-	BUG_ON((!total) || !IS_ALIGNED(total, PAGE_SIZE));
-
-	start = area->da_start;
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		size_t bytes;
-
-		bytes = sg->length + sg->offset;
-
-		unmapped = iommu_unmap(domain, start, bytes);
-		if (unmapped < bytes)
-			break;
-
-		dev_dbg(obj->dev, "%s: unmap %08x(%x) %08x\n",
-				__func__, start, bytes, area->flags);
-
-		BUG_ON(!IS_ALIGNED(bytes, PAGE_SIZE));
-
-		total -= bytes;
-		start += bytes;
-	}
-	BUG_ON(total);
-}
-
-/* template function for all unmapping */
-static struct sg_table *unmap_vm_area(struct iommu_domain *domain,
-				      struct omap_iommu *obj, const u32 da,
-				      void (*fn)(const void *), u32 flags)
-{
-	struct sg_table *sgt = NULL;
-	struct iovm_struct *area;
-
-	if (!IS_ALIGNED(da, PAGE_SIZE)) {
-		dev_err(obj->dev, "%s: alignment err(%08x)\n", __func__, da);
-		return NULL;
-	}
-
-	mutex_lock(&obj->mmap_lock);
-
-	area = __find_iovm_area(obj, da);
-	if (!area) {
-		dev_dbg(obj->dev, "%s: no da area(%08x)\n", __func__, da);
-		goto out;
-	}
-
-	if ((area->flags & flags) != flags) {
-		dev_err(obj->dev, "%s: wrong flags(%08x)\n", __func__,
-			area->flags);
-		goto out;
-	}
-	sgt = (struct sg_table *)area->sgt;
-
-	unmap_iovm_area(domain, obj, area);
-
-	fn(area->va);
-
-	dev_dbg(obj->dev, "%s: %08x-%08x-%08x(%x) %08x\n", __func__,
-		area->da_start, da, area->da_end,
-		area->da_end - area->da_start, area->flags);
-
-	free_iovm_area(obj, area);
-out:
-	mutex_unlock(&obj->mmap_lock);
-
-	return sgt;
-}
-
-static u32 map_iommu_region(struct iommu_domain *domain, struct omap_iommu *obj,
-				u32 da, const struct sg_table *sgt, void *va,
-				size_t bytes, u32 flags)
-{
-	int err = -ENOMEM;
-	struct iovm_struct *new;
-
-	mutex_lock(&obj->mmap_lock);
-
-	new = alloc_iovm_area(obj, da, bytes, flags);
-	if (IS_ERR(new)) {
-		err = PTR_ERR(new);
-		goto err_alloc_iovma;
-	}
-	new->va = va;
-	new->sgt = sgt;
-
-	if (map_iovm_area(domain, new, sgt, new->flags))
-		goto err_map;
-
-	mutex_unlock(&obj->mmap_lock);
-
-	dev_dbg(obj->dev, "%s: da:%08x(%x) flags:%08x va:%p\n",
-		__func__, new->da_start, bytes, new->flags, va);
-
-	return new->da_start;
-
-err_map:
-	free_iovm_area(obj, new);
-err_alloc_iovma:
-	mutex_unlock(&obj->mmap_lock);
-	return err;
-}
-
-static inline u32
-__iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj,
-				u32 da, const struct sg_table *sgt,
-				void *va, size_t bytes, u32 flags)
-{
-	return map_iommu_region(domain, obj, da, sgt, va, bytes, flags);
-}
-
-/**
- * omap_iommu_vmap  -  (d)-(p)-(v) address mapper
- * @domain:	iommu domain
- * @dev:	client device
- * @sgt:	address of scatter gather table
- * @flags:	iovma and page property
- *
- * Creates 1-n-1 mapping with given @sgt and returns @da.
- * All @sgt element must be io page size aligned.
- */
-u32 omap_iommu_vmap(struct iommu_domain *domain, struct device *dev, u32 da,
-		const struct sg_table *sgt, u32 flags)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	size_t bytes;
-	void *va = NULL;
-
-	if (!obj || !obj->dev || !sgt)
-		return -EINVAL;
-
-	bytes = sgtable_len(sgt);
-	if (!bytes)
-		return -EINVAL;
-	bytes = PAGE_ALIGN(bytes);
-
-	if (flags & IOVMF_MMIO) {
-		va = vmap_sg(sgt);
-		if (IS_ERR(va))
-			return PTR_ERR(va);
-	}
-
-	flags |= IOVMF_DISCONT;
-	flags |= IOVMF_MMIO;
-
-	da = __iommu_vmap(domain, obj, da, sgt, va, bytes, flags);
-	if (IS_ERR_VALUE(da))
-		vunmap_sg(va);
-
-	return da + sgtable_offset(sgt);
-}
-EXPORT_SYMBOL_GPL(omap_iommu_vmap);
-
-/**
- * omap_iommu_vunmap  -  release virtual mapping obtained by 'omap_iommu_vmap()'
- * @domain:	iommu domain
- * @dev:	client device
- * @da:		iommu device virtual address
- *
- * Free the iommu virtually contiguous memory area starting at
- * @da, which was returned by 'omap_iommu_vmap()'.
- */
-struct sg_table *
-omap_iommu_vunmap(struct iommu_domain *domain, struct device *dev, u32 da)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	struct sg_table *sgt;
-	/*
-	 * 'sgt' is allocated before 'omap_iommu_vmalloc()' is called.
-	 * Just returns 'sgt' to the caller to free
-	 */
-	da &= PAGE_MASK;
-	sgt = unmap_vm_area(domain, obj, da, vunmap_sg,
-					IOVMF_DISCONT | IOVMF_MMIO);
-	if (!sgt)
-		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-	return sgt;
-}
-EXPORT_SYMBOL_GPL(omap_iommu_vunmap);
-
-/**
- * omap_iommu_vmalloc  -  (d)-(p)-(v) address allocator and mapper
- * @dev:	client device
- * @da:		contiguous iommu virtual memory
- * @bytes:	allocation size
- * @flags:	iovma and page property
- *
- * Allocate @bytes linearly and creates 1-n-1 mapping and returns
- * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set.
- */
-u32
-omap_iommu_vmalloc(struct iommu_domain *domain, struct device *dev, u32 da,
-						size_t bytes, u32 flags)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	void *va;
-	struct sg_table *sgt;
-
-	if (!obj || !obj->dev || !bytes)
-		return -EINVAL;
-
-	bytes = PAGE_ALIGN(bytes);
-
-	va = vmalloc(bytes);
-	if (!va)
-		return -ENOMEM;
-
-	flags |= IOVMF_DISCONT;
-	flags |= IOVMF_ALLOC;
-
-	sgt = sgtable_alloc(bytes, flags, da, 0);
-	if (IS_ERR(sgt)) {
-		da = PTR_ERR(sgt);
-		goto err_sgt_alloc;
-	}
-	sgtable_fill_vmalloc(sgt, va);
-
-	da = __iommu_vmap(domain, obj, da, sgt, va, bytes, flags);
-	if (IS_ERR_VALUE(da))
-		goto err_iommu_vmap;
-
-	return da;
-
-err_iommu_vmap:
-	sgtable_drain_vmalloc(sgt);
-	sgtable_free(sgt);
-err_sgt_alloc:
-	vfree(va);
-	return da;
-}
-EXPORT_SYMBOL_GPL(omap_iommu_vmalloc);
-
-/**
- * omap_iommu_vfree  -  release memory allocated by 'omap_iommu_vmalloc()'
- * @dev:	client device
- * @da:		iommu device virtual address
- *
- * Frees the iommu virtually continuous memory area starting at
- * @da, as obtained from 'omap_iommu_vmalloc()'.
- */
-void omap_iommu_vfree(struct iommu_domain *domain, struct device *dev,
-								const u32 da)
-{
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	struct sg_table *sgt;
-
-	sgt = unmap_vm_area(domain, obj, da, vfree,
-						IOVMF_DISCONT | IOVMF_ALLOC);
-	if (!sgt)
-		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-	sgtable_free(sgt);
-}
-EXPORT_SYMBOL_GPL(omap_iommu_vfree);
-
-static int __init iovmm_init(void)
-{
-	const unsigned long flags = SLAB_HWCACHE_ALIGN;
-	struct kmem_cache *p;
-
-	p = kmem_cache_create("iovm_area_cache", sizeof(struct iovm_struct), 0,
-			      flags, NULL);
-	if (!p)
-		return -ENOMEM;
-	iovm_area_cachep = p;
-
-	return 0;
-}
-module_init(iovmm_init);
-
-static void __exit iovmm_exit(void)
-{
-	kmem_cache_destroy(iovm_area_cachep);
-}
-module_exit(iovmm_exit);
-
-MODULE_DESCRIPTION("omap iommu: simple virtual address space management");
-MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/omap-iommu.h b/include/linux/omap-iommu.h
index cac78de..c1aede4 100644
--- a/include/linux/omap-iommu.h
+++ b/include/linux/omap-iommu.h
@@ -10,41 +10,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef _INTEL_IOMMU_H_
-#define _INTEL_IOMMU_H_
-
-struct iovm_struct {
-	struct omap_iommu	*iommu;	/* iommu object which this belongs to */
-	u32			da_start; /* area definition */
-	u32			da_end;
-	u32			flags; /* IOVMF_: see below */
-	struct list_head	list; /* linked in ascending order */
-	const struct sg_table	*sgt; /* keep 'page' <-> 'da' mapping */
-	void			*va; /* mpu side mapped address */
-};
-
-#define MMU_RAM_ENDIAN_SHIFT	9
-#define MMU_RAM_ENDIAN_LITTLE	(0 << MMU_RAM_ENDIAN_SHIFT)
-#define MMU_RAM_ELSZ_8		(0 << MMU_RAM_ELSZ_SHIFT)
-#define IOVMF_ENDIAN_LITTLE	MMU_RAM_ENDIAN_LITTLE
-#define MMU_RAM_ELSZ_SHIFT	7
-#define IOVMF_ELSZ_8		MMU_RAM_ELSZ_8
-
-struct iommu_domain;
-
-extern struct iovm_struct *omap_find_iovm_area(struct device *dev, u32 da);
-extern u32
-omap_iommu_vmap(struct iommu_domain *domain, struct device *dev, u32 da,
-			const struct sg_table *sgt, u32 flags);
-extern struct sg_table *omap_iommu_vunmap(struct iommu_domain *domain,
-				struct device *dev, u32 da);
-extern u32
-omap_iommu_vmalloc(struct iommu_domain *domain, struct device *dev,
-				u32 da, size_t bytes, u32 flags);
-extern void
-omap_iommu_vfree(struct iommu_domain *domain, struct device *dev,
-				const u32 da);
-extern void *omap_da_to_va(struct device *dev, u32 da);
+#ifndef _OMAP_IOMMU_H_
+#define _OMAP_IOMMU_H_
 
 extern void omap_iommu_save_ctx(struct device *dev);
 extern void omap_iommu_restore_ctx(struct device *dev);
-- 
Regards,

Laurent Pinchart

