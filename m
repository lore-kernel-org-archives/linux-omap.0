From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/5] omap iommu: tlb and pagetable primitives
Date: Tue, 25 Nov 2008 17:37:34 +0200
Message-ID: <1227627458-24412-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227627458-24412-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22787 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYKYPh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 10:37:59 -0500
In-Reply-To: <1227627458-24412-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This patch provides:

- iotlb_*()     : iommu tlb operations
- iopgtable_*() : iommu pagetable(twl) operations
- iommu_*()     : the other generic operations

and the entry points to register and acquire iommu object.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/iommu.h |  185 +++++++
 arch/arm/plat-omap/iommu.c              |  831 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h          |   70 +++
 3 files changed, 1086 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iopgtable.h

diff --git a/arch/arm/plat-omap/include/mach/iommu.h b/arch/arm/plat-omap/include/mach/iommu.h
new file mode 100644
index 0000000..3a7ba14
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/iommu.h
@@ -0,0 +1,185 @@
+/*
+ * omap iommu: main structures
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
+#ifndef __MACH_IOMMU_H
+#define __MACH_IOMMU_H
+
+#include <linux/vmalloc.h>
+#include <linux/scatterlist.h>
+
+struct iotlb_entry {
+	u32 da;
+	u32 pa;
+	unsigned int pgsz, prsvd, valid;
+	union {
+		u16 ap;
+		struct {
+			u32 endian, elsz, mixed;
+		};
+	};
+};
+
+struct iommu {
+	char		*name;
+	struct module	*owner;
+	u32		*flags;
+	struct clk	*clk;
+	void __iomem	*regbase;
+	unsigned int	regsize;
+	struct device	*dev;
+
+	unsigned int	refcount;
+	struct mutex	iommu_lock;	/* global for this whole object */
+
+	/*
+	 * We don't change iopgd for a situation like pgd for a task,
+	 * but share it globally for each iommu.
+	 */
+	u32		*iopgd;
+	spinlock_t	page_table_lock; /* protect iopgd */
+
+	int		nr_tlb_entries;
+	int		irq;
+
+	struct list_head	mmap;
+	struct mutex		mmap_lock; /* protect mmap */
+
+	int (*isr)(struct iommu *obj);
+
+	void *ctx; /* iommu context: registres saved area */
+};
+
+struct cr_regs {
+	union {
+		struct {
+			u16 cam_l;
+			u16 cam_h;
+		};
+		u32 cam;
+	};
+	union {
+		struct {
+			u16 ram_l;
+			u16 ram_h;
+		};
+		u32 ram;
+	};
+};
+
+struct iotlb_lock {
+	int base;
+	int vict;
+};
+
+/* architecture specific functions */
+struct iommu_functions {
+	unsigned long	version;
+
+	int (*enable)(struct iommu *obj);
+	void (*disable)(struct iommu *obj);
+	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
+
+	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
+	void (*tlb_load_cr)(struct iommu *obj, struct cr_regs *cr);
+
+	struct cr_regs *(*alloc_cr)(struct iommu *obj, struct iotlb_entry *e);
+	int (*cr_valid)(struct cr_regs *cr);
+	u32 (*cr_to_virt)(struct cr_regs *cr);
+	void (*cr_to_e)(struct cr_regs *cr, struct iotlb_entry *e);
+	ssize_t (*dump_cr)(struct iommu *obj, struct cr_regs *cr, char *buf);
+
+	pgprot_t (*get_pte_attr)(struct iotlb_entry *e);
+
+	void (*save_ctx)(struct iommu *obj);
+	void (*restore_ctx)(struct iommu *obj);
+	ssize_t (*dump_ctx)(struct iommu *obj, char *buf);
+};
+
+struct iommu_platform_data {
+	const char	*name;
+	int		nr_tlb_entries;
+	struct clk	*clk;
+	char		*clk_name;
+	struct resource	*res;
+	int		n_res;
+	struct iommu_functions	*ops;
+};
+
+#include <mach/iommu2.h>
+
+/*
+ * utilities for super page(16MB, 1MB, 64KB and 4KB)
+ */
+
+#define iopgsz_max(bytes)			\
+	(((bytes) >= SZ_16M) ? SZ_16M :		\
+	 ((bytes) >= SZ_1M)  ? SZ_1M  :		\
+	 ((bytes) >= SZ_64K) ? SZ_64K :		\
+	 ((bytes) >= SZ_4K)  ? SZ_4K  :	0)
+
+#define bytes_to_iopgsz(bytes)				\
+	(((bytes) == SZ_16M) ? MMU_CAM_PGSZ_16M :	\
+	 ((bytes) == SZ_1M)  ? MMU_CAM_PGSZ_1M  :	\
+	 ((bytes) == SZ_64K) ? MMU_CAM_PGSZ_64K :	\
+	 ((bytes) == SZ_4K)  ? MMU_CAM_PGSZ_4K  : -1)
+
+#define iopgsz_to_bytes(iopgsz)				\
+	(((iopgsz) == MMU_CAM_PGSZ_16M)	? SZ_16M :	\
+	 ((iopgsz) == MMU_CAM_PGSZ_1M)	? SZ_1M  :	\
+	 ((iopgsz) == MMU_CAM_PGSZ_64K)	? SZ_64K :	\
+	 ((iopgsz) == MMU_CAM_PGSZ_4K)	? SZ_4K  : 0)
+
+#define iopgsz_ok(bytes) (bytes_to_iopgsz(bytes) >= 0)
+
+/*
+ * global functions
+ */
+extern u32 iommu_arch_version(void);
+
+extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
+extern void flush_iotlb_page(struct iommu *obj, u32 da);
+extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
+extern void flush_iotlb_all(struct iommu *obj);
+
+extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
+extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
+
+extern struct iommu *iommu_get(const char *name);
+extern void iommu_put(struct iommu *obj);
+
+extern int iommu_enable(struct iommu *obj);
+extern void iommu_disable(struct iommu *obj);
+extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf);
+extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
+extern int iotlb_cr_valid(struct cr_regs *cr);
+extern struct cr_regs *iotlb_alloc_cr(struct iommu *obj, struct iotlb_entry *e);
+extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
+extern pgprot_t get_iopte_attr(struct iotlb_entry *e);
+extern void iommu_fault_report(struct iommu *obj);
+extern void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l);
+extern void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l);
+extern void iotlb_read_cr(struct iommu *obj, struct iotlb_lock *l,
+			  struct cr_regs *cr);
+extern void iotlb_load_cr(struct iommu *obj, struct cr_regs *cr);
+extern ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf);
+
+extern int iommu_register_sysfs(struct iommu *obj);
+extern void iommu_unregister_sysfs(struct iommu *obj);
+
+extern int io_remap_area(struct vm_struct *area, unsigned long pfn);
+extern void __iopgtable_follow_entry(struct iommu *obj, u32 da, u32 **ppgd,
+				     u32 **ppte);
+
+extern void iommu_save_ctx(struct iommu *obj);
+extern void iommu_restore_ctx(struct iommu *obj);
+
+#endif /* __MACH_IOMMU_H */
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
new file mode 100644
index 0000000..170348f
--- /dev/null
+++ b/arch/arm/plat-omap/iommu.c
@@ -0,0 +1,831 @@
+/*
+ * omap iommu: tlb and pagetable primitives
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *		Paul Mundt and Toshihiro Kobayashi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <asm/cacheflush.h>
+
+#include <mach/clock.h>
+#include <mach/iommu.h>
+#include <mach/iovmm.h>
+
+#include "iopgtable.h"
+
+#define DRV_NAME "omap-iommu"
+
+/* accommodate the difference between omap1 and omap2/3 */
+static struct iommu_functions *arch_iommu;
+
+static struct platform_driver omap_iommu_driver;
+static struct kmem_cache *iopte_cachep;
+
+void iommu_save_ctx(struct iommu *obj)
+{
+	arch_iommu->save_ctx(obj);
+}
+EXPORT_SYMBOL_GPL(iommu_save_ctx);
+
+void iommu_restore_ctx(struct iommu *obj)
+{
+	arch_iommu->restore_ctx(obj);
+}
+EXPORT_SYMBOL_GPL(iommu_restore_ctx);
+
+u32 iommu_arch_version(void)
+{
+	return arch_iommu->version;
+}
+EXPORT_SYMBOL_GPL(iommu_arch_version);
+
+int iommu_enable(struct iommu *obj)
+{
+	int err;
+
+	BUG_ON(!arch_iommu || !arch_iommu->enable);
+
+	if (!obj)
+		return -EINVAL;
+
+	clk_enable(obj->clk);
+
+	err = arch_iommu->enable(obj);
+
+	clk_disable(obj->clk);
+	return err;
+}
+EXPORT_SYMBOL_GPL(iommu_enable);
+
+void iommu_disable(struct iommu *obj)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->disable);
+
+	if (!obj)
+		return;
+
+	clk_enable(obj->clk);
+
+	arch_iommu->disable(obj);
+
+	clk_disable(obj->clk);
+}
+EXPORT_SYMBOL_GPL(iommu_disable);
+
+ssize_t iommu_dump_ctx(struct iommu *obj, char *buf)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->dump_ctx);
+
+	if (!obj || !buf)
+		return -EINVAL;
+
+	return arch_iommu->dump_ctx(obj, buf);
+}
+EXPORT_SYMBOL_GPL(iommu_dump_ctx);
+
+/*
+ *	TLB operations
+ */
+void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->cr_to_e || !cr || !e);
+
+	arch_iommu->cr_to_e(cr, e);
+}
+EXPORT_SYMBOL_GPL(iotlb_cr_to_e);
+
+int iotlb_cr_valid(struct cr_regs *cr)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->cr_valid);
+
+	if (!cr)
+		return -EINVAL;
+
+	return arch_iommu->cr_valid(cr);
+}
+EXPORT_SYMBOL_GPL(iotlb_cr_valid);
+
+struct cr_regs *iotlb_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->alloc_cr);
+
+	if (!e)
+		return NULL;
+
+	return arch_iommu->alloc_cr(obj, e);
+}
+EXPORT_SYMBOL_GPL(iotlb_alloc_cr);
+
+u32 iotlb_cr_to_virt(struct cr_regs *cr)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->cr_to_virt || !cr);
+
+	return arch_iommu->cr_to_virt(cr);
+}
+EXPORT_SYMBOL_GPL(iotlb_cr_to_virt);
+
+pgprot_t get_iopte_attr(struct iotlb_entry *e)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->get_pte_attr || !e);
+
+	return arch_iommu->get_pte_attr(e);
+}
+EXPORT_SYMBOL_GPL(get_iopte_attr);
+
+u32 iommu_report_fault(struct iommu *obj, u32 *da)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->fault_isr || !obj);
+
+	return arch_iommu->fault_isr(obj, da);
+}
+EXPORT_SYMBOL_GPL(iommu_report_fault);
+
+void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
+{
+	u32 val;
+
+	BUG_ON(!obj || !l);
+
+	val = iommu_read_reg(obj, MMU_LOCK);
+
+	l->base = MMU_LOCK_BASE(val);
+	l->vict = MMU_LOCK_VICT(val);
+}
+EXPORT_SYMBOL_GPL(iotlb_lock_get);
+
+void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
+{
+	u32 val;
+
+	BUG_ON(!obj || !l);
+
+	val = (l->base << MMU_LOCK_BASE_SHIFT);
+	val |= (l->vict << MMU_LOCK_VICT_SHIFT);
+
+	iommu_write_reg(obj, val, MMU_LOCK);
+}
+EXPORT_SYMBOL_GPL(iotlb_lock_set);
+
+void iotlb_read_cr(struct iommu *obj, struct iotlb_lock *l, struct cr_regs *cr)
+{
+	BUG_ON(!obj || !l || !cr);
+
+	iotlb_lock_set(obj, l);
+	arch_iommu->tlb_read_cr(obj, cr);
+}
+EXPORT_SYMBOL_GPL(iotlb_read_cr);
+
+void iotlb_load_cr(struct iommu *obj, struct cr_regs *cr)
+{
+	BUG_ON(!obj || !cr);
+
+	arch_iommu->tlb_load_cr(obj, cr);
+
+	iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
+	iommu_write_reg(obj, 1, MMU_LD_TLB);
+}
+EXPORT_SYMBOL_GPL(iotlb_load_cr);
+
+ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
+{
+	BUG_ON(!arch_iommu || !arch_iommu->dump_cr || !cr || !buf);
+
+	return arch_iommu->dump_cr(obj, cr, buf);
+}
+EXPORT_SYMBOL_GPL(iotlb_dump_cr);
+
+int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	struct iotlb_lock l;
+	struct cr_regs *cr;
+
+	if (!obj || !e)
+		return -EINVAL;
+
+	clk_enable(obj->clk);
+
+	iotlb_lock_get(obj, &l);
+	for (l.vict = 0; l.vict < l.base; l.vict++) {
+		struct cr_regs tmp;
+		iotlb_read_cr(obj, &l, &tmp);
+		if (!iotlb_cr_valid(&tmp))
+			goto found;
+	}
+	iotlb_lock_set(obj, &l);
+found:
+	if (l.vict == (obj->nr_tlb_entries - 1)) {
+		dev_err(obj->dev, "TLB is full\n");
+		clk_disable(obj->clk);
+		return -EBUSY;
+	}
+
+	cr = iotlb_alloc_cr(obj, e);
+	if (IS_ERR(cr)) {
+		clk_disable(obj->clk);
+		return PTR_ERR(cr);
+	}
+	iotlb_load_cr(obj, cr);
+	kfree(cr);
+
+	if (l.vict == l.base)
+		l.base++;
+	iotlb_lock_set(obj, &l);
+
+	clk_disable(obj->clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(load_iotlb_entry);
+
+void flush_iotlb_page(struct iommu *obj, u32 da)
+{
+	struct iotlb_lock l;
+	int i;
+	int max_valid = 0;
+
+	BUG_ON(!obj);
+
+	clk_enable(obj->clk);
+
+	iotlb_lock_get(obj, &l);
+
+	for (i = 0; i < l.base; i++) {
+		struct cr_regs cr;
+
+		l.vict = i;
+		iotlb_read_cr(obj, &l, &cr);
+
+		if (!iotlb_cr_valid(&cr))
+			continue;
+
+		if (iotlb_cr_to_virt(&cr) == da)
+			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
+		else
+			max_valid = i;
+	}
+
+	l.base = max_valid + 1;
+	l.base = l.vict;
+
+	iotlb_lock_set(obj, &l);
+	clk_disable(obj->clk);
+}
+EXPORT_SYMBOL_GPL(flush_iotlb_page);
+
+void flush_iotlb_range(struct iommu *obj, u32 start, u32 end)
+{
+	u32 da = start;
+
+	BUG_ON(!obj);
+
+	while (da < end) {
+		flush_iotlb_page(obj, da);
+		/* FIXME: Optimize for multiple page size */
+		da += IOPTE_SIZE;
+	}
+}
+EXPORT_SYMBOL_GPL(flush_iotlb_range);
+
+void flush_iotlb_all(struct iommu *obj)
+{
+	struct iotlb_lock l;
+
+	BUG_ON(!obj);
+
+	clk_enable(obj->clk);
+
+	iommu_write_reg(obj, 1, MMU_GFLUSH);
+	l.base = 0;
+	l.vict = 0;
+	iotlb_lock_set(obj, &l);
+
+	clk_disable(obj->clk);
+}
+EXPORT_SYMBOL_GPL(flush_iotlb_all);
+
+/*
+ *	H/W pagetable operations
+ */
+static void flush_iopgd_range(u32 *first, u32 *last)
+{
+	do {
+		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
+		    : : "r" (first));
+		first += L1_CACHE_BYTES >> 2;
+	} while (first <= last);
+}
+
+static void flush_iopte_range(u32 *first, u32 *last)
+{
+	do {
+		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
+		    : : "r" (first));
+		first += L1_CACHE_BYTES >> 2;
+	} while (first <= last);
+}
+
+static void iopte_free(u32 *iopte)
+{
+	BUG_ON(!iopte);
+	/* Note: freed iopte's must be clean ready for re-use */
+	kmem_cache_free(iopte_cachep, iopte);
+}
+
+static u32 *iopte_alloc(struct iommu *obj, u32 *iopgd, u32 da)
+{
+	u32 *iopte;
+
+	/* a table has already existed */
+	if (*iopgd)
+		goto pte_ready;
+
+	/*
+	 * do the allocation outside the page table lock
+	 */
+	spin_unlock(&obj->page_table_lock);
+	iopte = kmem_cache_zalloc(iopte_cachep, GFP_KERNEL);
+	spin_lock(&obj->page_table_lock);
+
+	if (!*iopgd) {
+		if (!iopte)
+			return ERR_PTR(-ENOMEM);
+
+		*iopgd = (u32)virt_to_phys(iopte) | IOPGD_TABLE;
+		flush_iopgd_range(iopgd, iopgd);
+
+#ifdef DEBUG_VERBOSE
+		dev_dbg(obj->dev, "%s:\ta new pte:%p\n", __func__, iopte);
+#endif
+	} else {
+		/* We raced, free the reduniovant table */
+		iopte_free(iopte);
+	}
+
+pte_ready:
+	iopte = iopte_offset(iopgd, da);
+
+#ifdef DEBUG_VERBOSE
+	dev_dbg(obj->dev,
+		"%s:\tda:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
+		__func__, da, iopgd, *iopgd, iopte, *iopte);
+#endif
+	return iopte;
+}
+
+static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
+{
+	u32 *iopgd = iopgd_offset(obj, da);
+
+	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
+	flush_iopgd_range(iopgd, iopgd);
+	return 0;
+}
+
+static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
+{
+	u32 *iopgd = iopgd_offset(obj, da);
+	int i;
+
+	for (i = 0; i < 16; i++)
+		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
+	flush_iopgd_range(iopgd, iopgd + 15);
+	return 0;
+}
+
+static int iopte_alloc_page(struct iommu *obj, u32 da, u32 pa, u32 prot)
+{
+	u32 *iopgd = iopgd_offset(obj, da);
+	u32 *iopte = iopte_alloc(obj, iopgd, da);
+
+	if (IS_ERR(iopte))
+		return PTR_ERR(iopte);
+
+	*iopte = (pa & IOPAGE_MASK) | prot | IOPTE_SMALL;
+	flush_iopte_range(iopte, iopte);
+
+#ifdef DEBUG_VERBOSE
+	dev_dbg(obj->dev, "%s:\tda:%08x pa:%08x pte:%p *pte:%08x\n",
+		__func__, da, pa, iopte, *iopte);
+#endif
+	return 0;
+}
+
+static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
+{
+	u32 *iopgd = iopgd_offset(obj, da);
+	u32 *iopte = iopte_alloc(obj, iopgd, da);
+	int i;
+
+	if (IS_ERR(iopte))
+		return PTR_ERR(iopte);
+
+	for (i = 0; i < 16; i++)
+		*(iopte + i) = (pa & IOLARGE_MASK) | prot | IOPTE_LARGE;
+	flush_iopte_range(iopte, iopte + 15);
+	return 0;
+}
+
+static int __iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	int (*fn)(struct iommu *, u32, u32, u32);
+	u32 prot;
+	int err;
+
+	if (!obj || !e)
+		return -EINVAL;
+
+	switch (e->pgsz) {
+	case MMU_CAM_PGSZ_16M:
+		fn = iopgd_alloc_super;
+		break;
+	case MMU_CAM_PGSZ_1M:
+		fn = iopgd_alloc_section;
+		break;
+	case MMU_CAM_PGSZ_64K:
+		fn = iopte_alloc_large;
+		break;
+	case MMU_CAM_PGSZ_4K:
+		fn = iopte_alloc_page;
+		break;
+	default:
+		fn = NULL;
+		BUG();
+		break;
+	}
+
+	prot = get_iopte_attr(e);
+
+	spin_lock(&obj->page_table_lock);
+	err = fn(obj, e->da, e->pa, prot);
+	spin_unlock(&obj->page_table_lock);
+
+	return err;
+}
+
+int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	flush_iotlb_page(obj, e->da);
+	return __iopgtable_store_entry(obj, e);
+}
+EXPORT_SYMBOL_GPL(iopgtable_store_entry);
+
+void __iopgtable_follow_entry(struct iommu *obj, u32 da, u32 **ppgd,
+			      u32 **ppte)
+{
+	u32 *iopgd, *iopte = NULL;
+
+	iopgd = iopgd_offset(obj, da);
+	if (!*iopgd)
+		goto out;
+
+	if ((u32)*iopgd & IOPGD_TABLE)
+		iopte = iopte_offset(iopgd, da);
+out:
+	*ppgd = iopgd;
+	*ppte = iopte;
+}
+EXPORT_SYMBOL_GPL(__iopgtable_follow_entry);
+
+static size_t __iopgtable_clear_entry(struct iommu *obj, u32 da)
+{
+	size_t bytes;
+	u32 *iopgd = iopgd_offset(obj, da);
+
+	if (!*iopgd)
+		return 0;
+
+	if ((u32)*iopgd & IOPGD_TABLE) {
+		int i;
+		u32 *iopte = iopte_offset(iopgd, da);
+
+		bytes = IOPTE_SIZE;
+		if (*iopte & IOPTE_LARGE)
+			bytes <<= 4;
+
+		*iopte = 0;
+		flush_iopte_range(iopte, iopte);
+
+		iopte = iopte_offset(iopgd, 0);
+		for (i = 0; i < PTRS_PER_IOPTE; i++)
+			if (iopte[i])
+				return bytes;
+		iopte_free(iopte);
+	} else {
+		bytes = IOPGD_SIZE;
+		if (*iopgd & IOPGD_SUPER)
+			bytes <<= 4;
+	}
+	*iopgd = 0;
+	flush_iopgd_range(iopgd, iopgd);
+
+	return bytes;
+}
+
+size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
+{
+	size_t bytes;
+
+	spin_lock(&obj->page_table_lock);
+
+	bytes = __iopgtable_clear_entry(obj, da);
+	flush_iotlb_page(obj, da);
+
+	spin_unlock(&obj->page_table_lock);
+
+	return bytes;
+}
+EXPORT_SYMBOL_GPL(iopgtable_clear_entry);
+
+static void iopgtable_clear_entry_all(struct iommu *obj)
+{
+	int i;
+
+	spin_lock(&obj->page_table_lock);
+
+	for (i = 0; i < PTRS_PER_IOPGD; i++) {
+		u32 da;
+		u32 *iopgd;
+
+		da = i << IOPGD_SHIFT;
+		iopgd = iopgd_offset(obj, da);
+
+		if (!*iopgd)
+			continue;
+
+		if ((u32)*iopgd & IOPGD_TABLE)
+			iopte_free(iopte_offset(iopgd, 0));
+
+		*iopgd = 0;
+		flush_iopgd_range(iopgd, iopgd);
+	}
+
+	flush_iotlb_all(obj);
+
+	spin_unlock(&obj->page_table_lock);
+}
+
+/*
+ *	Device IOMMU generic operations
+ */
+static irqreturn_t iommu_fault_handler(int irq, void *data)
+{
+	u32 stat, da;
+	u32 *iopgd, *iopte;
+	int err = -EIO;
+	struct iommu *obj = data;
+
+	BUG_ON(!obj);
+
+	/* Dynamic loading TLB or PTE */
+	if (obj->isr)
+		err = obj->isr(obj);
+
+	if (!err)
+		return IRQ_HANDLED;
+
+	stat = iommu_report_fault(obj, &da);
+	if (!stat)
+		return IRQ_HANDLED;
+
+	iopgd = iopgd_offset(obj, da);
+
+	if (!((u32)*iopgd & IOPGD_TABLE)) {
+		dev_err(obj->dev, "%s:\tda:%08x pgd:%p *pgd:%08x\n", __func__,
+			da, iopgd, *iopgd);
+		return IRQ_NONE;
+	}
+
+	iopte = iopte_offset(iopgd, da);
+
+	dev_err(obj->dev, "%s:\tda:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
+		__func__, da, iopgd, *iopgd, iopte, *iopte);
+
+	return IRQ_NONE;
+}
+
+static int device_match_by_alias(struct device *dev, void *data)
+{
+	struct iommu *obj = to_iommu(dev);
+	const char *name = data;
+
+	pr_debug("%s:\t%s %s\n", __func__, obj->name, name);
+
+	return strcmp(obj->name, name) == 0;
+}
+
+struct iommu *iommu_get(const char *name)
+{
+	int err = -ENOMEM;
+	struct device *dev;
+	struct iommu *obj;
+
+	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
+				 device_match_by_alias);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	obj = to_iommu(dev);
+
+	mutex_lock(&obj->iommu_lock);
+
+	if (obj->refcount++ == 0) {
+		err = iommu_enable(obj);
+		if (err)
+			goto err_enable;
+	}
+
+	if (!try_module_get(obj->owner))
+		goto err_module;
+
+	mutex_unlock(&obj->iommu_lock);
+
+	dev_dbg(obj->dev, "%s:\t%s\n", __func__, obj->name);
+	return obj;
+
+err_module:
+	if (obj->refcount == 1)
+		iommu_disable(obj);
+err_enable:
+	mutex_unlock(&obj->iommu_lock);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(iommu_get);
+
+void iommu_put(struct iommu *obj)
+{
+	if (!obj && IS_ERR(obj))
+		return;
+
+	mutex_lock(&obj->iommu_lock);
+
+	if (--obj->refcount == 0)
+		iommu_disable(obj);
+
+	module_put(obj->owner);
+
+	mutex_unlock(&obj->iommu_lock);
+
+	dev_dbg(obj->dev, "%s:\t%s\n", __func__, obj->name);
+}
+EXPORT_SYMBOL_GPL(iommu_put);
+
+/*
+ *	OMAP Device MMU(IOMMU) detection
+ */
+static int __devinit omap_iommu_probe(struct platform_device *pdev)
+{
+	int err;
+	void *p;
+	struct iommu *obj;
+	struct resource *res;
+	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+
+	BUG_ON(arch_iommu && (arch_iommu != pdata->ops));
+	arch_iommu = pdata->ops;
+
+	if (pdev->num_resources != 2)
+		return -EINVAL;
+
+	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	obj->nr_tlb_entries = pdata->nr_tlb_entries;
+	obj->name = (char *)pdata->name;
+	obj->dev = &pdev->dev;
+	obj->ctx = (void *)obj + sizeof(*obj);
+
+	mutex_init(&obj->iommu_lock);
+	mutex_init(&obj->mmap_lock);
+	spin_lock_init(&obj->page_table_lock);
+	INIT_LIST_HEAD(&obj->mmap);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -ENODEV;
+		goto err_mem;
+	}
+	obj->regsize = res->end - res->start;
+	obj->regbase = ioremap(res->start, obj->regsize);
+	if (!obj->regbase || !obj->regsize) {
+		err = -ENODEV;
+		goto err_mem;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
+				      obj->regsize, dev_name(&pdev->dev));
+	if (!res) {
+		err = -EIO;
+		goto err_mem;
+	}
+
+	obj->irq = platform_get_irq(pdev, 0);
+	if (obj->irq < 0) {
+		err = -ENODEV;
+		goto err_irq;
+	}
+	err = devm_request_irq(&pdev->dev, obj->irq, iommu_fault_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), obj);
+	if (err < 0)
+		goto err_irq;
+	platform_set_drvdata(pdev, obj);
+
+	p = (void *)__get_free_pages(GFP_KERNEL, get_order(IOPGD_TABLE_SIZE));
+	if (!p) {
+		err = -ENOMEM;
+		goto err_pgd;
+	}
+	memzero(p, IOPGD_TABLE_SIZE);
+	clean_dcache_area(p, IOPGD_TABLE_SIZE);
+	obj->iopgd = p;
+
+	BUG_ON(!IS_ALIGNED((unsigned long)obj->iopgd, IOPGD_TABLE_SIZE));
+
+	dev_info(&pdev->dev, "%s registered\n", obj->name);
+	return 0;
+
+err_pgd:
+	devm_free_irq(&pdev->dev, obj->irq, obj);
+err_irq:
+	devm_release_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
+				obj->regsize);
+	iounmap(obj->regbase);
+err_mem:
+	kfree(obj);
+	return err;
+}
+
+static int __devexit omap_iommu_remove(struct platform_device *pdev)
+{
+	struct iommu *obj = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	iopgtable_clear_entry_all(obj);
+	free_pages((unsigned long)obj->iopgd, get_order(IOPGD_TABLE_SIZE));
+
+	devm_free_irq(&pdev->dev, obj->irq, obj);
+	devm_release_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
+				obj->regsize);
+	iounmap(obj->regbase);
+
+	dev_info(&pdev->dev, "%s removed\n", obj->name);
+
+	kfree(obj);
+	return 0;
+}
+
+static struct platform_driver omap_iommu_driver = {
+	.probe	= omap_iommu_probe,
+	.remove	= __devexit_p(omap_iommu_remove),
+	.driver	= {
+		.name	= DRV_NAME,
+	},
+};
+
+static void iopte_cachep_ctor(void *iopte)
+{
+	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
+}
+
+static int __init omap_iommu_init(void)
+{
+	struct kmem_cache *p;
+	const unsigned long flags = SLAB_HWCACHE_ALIGN;
+
+	p = kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, 0, flags,
+			      iopte_cachep_ctor);
+	if (!p)
+		return -ENOMEM;
+	iopte_cachep = p;
+
+	return platform_driver_register(&omap_iommu_driver);
+}
+module_init(omap_iommu_init);
+
+static void __exit omap_iommu_exit(void)
+{
+	kmem_cache_destroy(iopte_cachep);
+
+	platform_driver_unregister(&omap_iommu_driver);
+}
+module_exit(omap_iommu_exit);
+
+MODULE_DESCRIPTION("omap iommu: tlb and pagetable primitives");
+MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_AUTHOR("Hiroshi DOYU, Paul Mundt and Toshihiro Kobayashi");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/iopgtable.h
new file mode 100644
index 0000000..2b42f53
--- /dev/null
+++ b/arch/arm/plat-omap/iopgtable.h
@@ -0,0 +1,70 @@
+/*
+ * omap iommu: pagetable definitions
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
+#ifndef __PLAT_OMAP_IOMMU_H
+#define __PLAT_OMAP_IOMMU_H
+
+#define IOPGD_SHIFT		20
+#define IOPGD_SIZE		(1 << IOPGD_SHIFT)
+#define IOPGD_MASK		(~(IOPGD_SIZE - 1))
+#define IOSECTION_MASK		IOPGD_MASK
+#define PTRS_PER_IOPGD		(1 << (32 - IOPGD_SHIFT))
+#define IOPGD_TABLE_SIZE	(PTRS_PER_IOPGD * sizeof(u32))
+
+#define IOSUPER_SIZE		(IOPGD_SIZE << 4)
+#define IOSUPER_MASK		(~(IOSUPER_SIZE - 1))
+
+#define IOPTE_SHIFT		12
+#define IOPTE_SIZE		(1 << IOPTE_SHIFT)
+#define IOPTE_MASK		(~(IOPTE_SIZE - 1))
+#define IOPAGE_MASK		IOPTE_MASK
+#define PTRS_PER_IOPTE		(1 << (IOPGD_SHIFT - IOPTE_SHIFT))
+#define IOPTE_TABLE_SIZE	(PTRS_PER_IOPTE * sizeof(u32))
+
+#define IOLARGE_SIZE		(IOPTE_SIZE << 4)
+#define IOLARGE_MASK		(~(IOLARGE_SIZE - 1))
+
+#define IOPGD_TABLE		(1 << 0)
+#define IOPGD_SECTION		(2 << 0)
+#define IOPGD_SUPER		(1 << 18 | 2 << 0)
+
+#define IOPTE_SMALL		(2 << 0)
+#define IOPTE_LARGE		(1 << 0)
+
+#define iopgd_index(da)		(((da) >> IOPGD_SHIFT) & (PTRS_PER_IOPGD - 1))
+#define iopgd_offset(obj, da)	((obj)->iopgd + iopgd_index(da))
+
+#define iopte_paddr(iopgd)	(*iopgd & ~((1 << 10) - 1))
+#define iopte_vaddr(iopgd)	((u32 *)phys_to_virt(iopte_paddr(iopgd)))
+
+#define iopte_index(da)		(((da) >> IOPTE_SHIFT) & (PTRS_PER_IOPTE - 1))
+#define iopte_offset(iopgd, da)	(iopte_vaddr(iopgd) + iopte_index(da))
+
+static inline u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
+				   u32 flags)
+{
+	e->da		= da;
+	e->pa		= pa;
+	e->valid	= 1;
+	/* FIXME: add OMAP1 support */
+	e->pgsz		= flags & MMU_CAM_PGSZ_MASK;
+	e->endian	= flags & MMU_RAM_ENDIAN_MASK;
+	e->elsz		= flags & MMU_RAM_ELSZ_MASK;
+	e->mixed	= flags & MMU_RAM_MIXED_MASK;
+
+	return iopgsz_to_bytes(e->pgsz);
+}
+
+#define to_iommu(dev)							\
+	(struct iommu *)platform_get_drvdata(to_platform_device(dev))
+
+#endif /* __PLAT_OMAP_IOMMU_H */
-- 
1.6.0.3.613.g9f8f13

