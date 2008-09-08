From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/4] ARM: OMAP: IOMMU driver: Core part
Date: Mon,  8 Sep 2008 08:56:30 +0300
Message-ID: <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27162 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYIHF4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 01:56:55 -0400
In-Reply-To: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, r-woodruff2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Some of OMAP series have the peripheral devices with their own Memory
Management Unit(IOMMU), which is composed of H/W pagetable(TWL) and
TLB. These MMUs doesn't depend on MPU(ARM) MMU at all but their
algorithms are quite similar and they share the same physical address
space. This patch provides such OMAP peripheral devices(Camera, IVA1,
IVA2, DSP and the later equivalent ones) with the common in-kernel
APIs to handle peripheral device IOMMUs in the same manner. The
following patches are composed of the following parts:

(1) device TLB operation
(2) device H/W pagetable(TWL) operation
(3) device Virtual address space management 	(*partialy implemented)
(4) Consistency between MPU MMU	and device IOMMUs (*not implemented yet)
(5) User application interface(sysfs)		(*partialy implemented)

Since all of peripheral device IOMMUs use the same algorithm as ARM
MMU does, this patch tries to apply linux in-kernel generic memory
management APIs to its MMU algorithm. "pgd_*()", "pmd_*()" and
"pte_*()" family are used for (1) and (2). "struct
vm_area_struct(VMA)" is used for (3). "struct mm_struct" is used to
keep (2) and (3) together.

Major APIs are sorted out like:

  iotlb_*(), ioset_pte_ext():	device TLB operations
  iotwl_*():			device TWL operations
  io<vma api>():		device VMA management(ex: ioget_unmapped_area())
  iommu_*():			the other operations for device IOMMU
  arch_iommu->*():     		absorb diffrence between omap1 and omap2

This patch has not included (4) yet. Since MPU MMU and device IOMMU
shares the same physical memory, this consistency has to be taken care
of if device IOMMU uses some of them. For example, reserving physical
memory for ARM not to access wrongly during device IOMMU
operation. These code is supposed to be implemented in client
driver/application side in the separate patches to afford these
differences easier. OMAP1 support is missing, too, for now.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/iommu.h |  118 +++++++
 arch/arm/plat-omap/iommu.c              |  510 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/proc-iommu.S         |   33 ++
 3 files changed, 661 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/proc-iommu.S

diff --git a/arch/arm/plat-omap/include/mach/iommu.h b/arch/arm/plat-omap/include/mach/iommu.h
new file mode 100644
index 0000000..909bf2f
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/iommu.h
@@ -0,0 +1,118 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ */
+#ifndef __IOMMU_H
+#define __IOMMU_H
+
+#define DEV_NAME	"iommu"
+
+/* MMU object handler */
+struct iommu {
+	/* MMU */
+	int		type;
+	char		*name;
+	struct clk	*clk;
+	void __iomem	*regbase;
+	unsigned long	regsize;
+	unsigned long	flag;
+	struct device	*dev;
+
+	/* TWL */
+	struct mm_struct	*twl_mm;
+	void (*isr)(struct iommu *obj);
+
+	/* TLB */
+	int		nr_tlb_entries;
+	int		irq;
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
+	int victim;
+};
+
+struct iotlb_entry;
+
+/* Absorb the differences amang MMU versions */
+struct iommu_functions {
+	/* MMU common */
+	int (*startup)(struct iommu *obj);
+	void (*shutdown)(struct iommu *obj);
+	int (*enable)(struct iommu *obj);
+	void (*disable)(struct iommu *obj);
+	void (*isr)(struct iommu *obj);
+
+	/* TLB operations */
+	void (*tlb_cr_read)(struct iommu *obj, struct cr_regs *cr);
+	void (*tlb_cr_load)(struct iommu *obj, struct cr_regs *cr);
+
+	/* CAM / RAM operations */
+	struct cr_regs *(*cr_alloc)(struct iommu *obj, struct iotlb_entry *e);
+	int (*cr_valid)(struct cr_regs *cr);
+	unsigned long (*cr_to_virt)(struct cr_regs *cr);
+
+	/* PTE attribute operations */
+	pgprot_t (*pte_attr_get)(struct iotlb_entry *e);
+
+	/* debug */
+	void (*regs_show)(struct iommu *obj);
+	ssize_t (*tlb_show)(struct iommu *obj, char *, struct iotlb_lock *lock);
+};
+
+struct iommu_pdata {
+	const char	*name;
+	int		nr_tlb_entries;
+	struct clk	*clk;
+	char		*clk_name;
+	struct resource	*res;
+	int		n_res;
+};
+
+/* Generic */
+struct iommu *iommu_get(const char *name);
+int iommu_put(struct iommu *obj);
+int iommu_enable(struct iommu *obj);
+void iommu_disable(struct iommu *obj);
+int iommu_arch_init(struct iommu_functions *ops);
+
+/* TLB */
+void iotlb_cr_read(struct iommu *obj, struct iotlb_lock *l, struct cr_regs *cr);
+void iotlb_cr_load(struct iommu *obj, struct cr_regs *cr);
+void iotlb_flush_all(struct iommu *obj);
+int iotlb_entry_load(struct iommu *obj, struct iotlb_entry *e);
+void iotlb_entry_flush(struct iommu *obj, unsigned long vadr);
+
+/* TWL */
+int iotwl_pte_set(struct iommu *obj, struct iotlb_entry *e);
+void iotwl_pte_clear(struct iommu *obj, unsigned long virt);
+int iotwl_mm_alloc(struct iommu *obj);
+void iotwl_mm_free(struct iommu *obj);
+
+/* VMA */
+unsigned long ioget_unmapped_area(struct iommu *obj, unsigned long len);
+dma_addr_t iomap_region(struct iommu *obj, struct iotlb_entry *e);
+void iounmap_region(struct iommu *obj, unsigned long iova, size_t len);
+
+/* omap mmu version of cpu_set_pte_ext() */
+void ioset_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
+
+#include "iommu2.h" /* REVISIT */
+
+#endif /* __IOMMU_H */
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
new file mode 100644
index 0000000..1b25f65
--- /dev/null
+++ b/arch/arm/plat-omap/iommu.c
@@ -0,0 +1,510 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *		Paul Mundt and Toshihiro Kobayashi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/pgalloc.h>
+
+#include <mach/clock.h>
+#include <mach/iommu.h>
+
+static struct iommu_functions *arch_iommu;
+static struct platform_driver iommu_driver;
+
+/*
+ *	TLB helper functions
+ */
+static inline void tlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
+{
+	unsigned long val;
+	val = iommu_read_reg(obj, MMU_LOCK);
+	l->base = MMU_LOCK_BASE(val);
+	l->victim = MMU_LOCK_VICTIM(val);
+}
+
+static inline void tlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
+{
+	u32 val;
+	val = (l->base << MMU_LOCK_BASE_SHIFT) |
+		(l->victim << MMU_LOCK_VICTIM_SHIFT);
+	iommu_write_reg(obj, val, MMU_LOCK);
+}
+
+static inline void tlb_entry_flush(struct iommu *obj)
+{
+	iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
+}
+
+static inline void tlb_ldtlb(struct iommu *obj)
+{
+	iommu_write_reg(obj, 1, MMU_LD_TLB);
+}
+
+/*
+ *
+ *	TLB operations
+ *
+ */
+void iotlb_cr_read(struct iommu *obj, struct iotlb_lock *l, struct cr_regs *cr)
+{
+	tlb_lock_set(obj, l);
+	arch_iommu->tlb_cr_read(obj, cr);
+}
+EXPORT_SYMBOL(iotlb_cr_read);
+
+void iotlb_cr_load(struct iommu *obj, struct cr_regs *cr)
+{
+	arch_iommu->tlb_cr_load(obj, cr);
+	tlb_entry_flush(obj);
+	tlb_ldtlb(obj);
+}
+EXPORT_SYMBOL(iotlb_cr_load);
+
+void iotlb_flush_all(struct iommu *obj)
+{
+	struct iotlb_lock l;
+	iommu_write_reg(obj, 1, MMU_GFLUSH);
+	l.base = 0;
+	l.victim = 0;
+	tlb_lock_set(obj, &l);
+}
+EXPORT_SYMBOL(iotlb_flush_all);
+
+int iotlb_entry_load(struct iommu *obj, struct iotlb_entry *e)
+{
+	struct iotlb_lock l;
+	struct cr_regs *cr;
+
+	tlb_lock_get(obj, &l);
+	for (l.victim = 0; l.victim < l.base; l.victim++) {
+		struct cr_regs tmp;
+		iotlb_cr_read(obj, &l, &tmp);
+		if (!arch_iommu->cr_valid(&tmp))
+			goto found;
+	}
+	tlb_lock_set(obj, &l);
+found:
+	if (l.victim == (obj->nr_tlb_entries - 1)) {
+		dev_err(obj->dev, "TLB is full\n");
+		return -EBUSY;
+	}
+	cr = arch_iommu->cr_alloc(obj, e);
+	if (IS_ERR(cr))
+		return PTR_ERR(cr);
+	iotlb_cr_load(obj, cr);
+	kfree(cr);
+	if (l.victim == l.base)
+		l.base++;
+	tlb_lock_set(obj, &l);
+	return 0;
+}
+EXPORT_SYMBOL(iotlb_entry_load);
+
+void iotlb_entry_flush(struct iommu *obj, unsigned long va)
+{
+	struct iotlb_lock l;
+	int i;
+	int max_valid = 0;
+
+	tlb_lock_get(obj, &l);
+	for (i = 0; i < l.base; i++) {
+		struct cr_regs cr;
+		l.victim = i;
+		iotlb_cr_read(obj, &l, &cr);
+		if (!arch_iommu->cr_valid(&cr))
+			continue;
+		if (arch_iommu->cr_to_virt(&cr) == va)
+			tlb_entry_flush(obj);
+		else
+			max_valid = i;
+	}
+	l.base = l.victim = max_valid + 1;
+	tlb_lock_set(obj, &l);
+}
+EXPORT_SYMBOL(iotlb_entry_flush);
+
+static irqreturn_t mm_fault_handler(int irq, void *data)
+{
+	struct iommu *obj = data;
+	if (obj->isr)
+		obj->isr(obj);
+	else
+		arch_iommu->isr(obj);
+	return IRQ_HANDLED;
+}
+
+/*
+ *
+ *	TWL operations (H/W pagetable)
+ *
+ */
+static inline void twl_alloc_section(struct mm_struct *mm, unsigned long va,
+				     unsigned long pa, int prot)
+{
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, va), va);
+	if (va & (1 << SECTION_SHIFT))
+		pmdp++;
+	*pmdp = __pmd((pa & SECTION_MASK) | prot | PMD_TYPE_SECT);
+	flush_pmd_entry(pmdp);
+}
+
+static inline void twl_alloc_super(struct mm_struct *mm, unsigned long va,
+				   unsigned long pa, int prot)
+{
+	int i;
+	for (i = 0; i < 16; i += 1) {
+		twl_alloc_section(mm, va, pa, prot | PMD_SECT_SUPER);
+		va += (PGDIR_SIZE / 2);
+	}
+}
+
+static inline int twl_alloc_page(struct mm_struct *mm, unsigned long va,
+				 unsigned long pa, pgprot_t prot)
+{
+	pte_t *ptep;
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, va), va);
+
+	if (!(prot & PTE_TYPE_MASK))
+		prot |= PTE_TYPE_SMALL;
+
+	if (pmd_none(*pmdp)) {
+		ptep = pte_alloc_one_kernel(mm, va);
+		if (ptep == NULL)
+			return -ENOMEM;
+		pmd_populate_kernel(mm, pmdp, ptep);
+	}
+	ptep = pte_offset_kernel(pmdp, va);
+	ioset_pte_ext(ptep, pfn_pte(pa >> PAGE_SHIFT, prot),
+		      L_PTE_PRESENT);
+	return 0;
+}
+
+static inline int twl_alloc_large(struct mm_struct *mm, unsigned long va,
+				  unsigned long pa, pgprot_t prot)
+{
+	int i;
+	for (i = 0; i < 16; i += 1) {
+		int err;
+		err = twl_alloc_page(mm, va, pa, prot | PTE_TYPE_LARGE);
+		if (err)
+			return -ENOMEM;
+		va += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static inline int twl_pte_set(struct iommu *obj, struct iotlb_entry *e)
+{
+	int err = 0;
+	struct mm_struct *mm = obj->twl_mm;
+	const unsigned long va = e->va;
+	const unsigned long pa = e->pa;
+	const pgprot_t prot = arch_iommu->pte_attr_get(e);
+
+	spin_lock(&mm->page_table_lock);
+
+	switch (e->pgsz) {
+	case MMU_CAM_PAGESIZE_16MB:
+		twl_alloc_super(mm, va, pa, prot);
+		break;
+	case MMU_CAM_PAGESIZE_1MB:
+		twl_alloc_section(mm, va, pa, prot);
+		break;
+	case MMU_CAM_PAGESIZE_64KB:
+		err = twl_alloc_large(mm, va, pa, prot);
+		break;
+	case MMU_CAM_PAGESIZE_4KB:
+		err = twl_alloc_page(mm, va, pa, prot);
+		break;
+	default:
+		BUG();
+		break;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return err;
+}
+
+int iotwl_pte_set(struct iommu *obj, struct iotlb_entry *e)
+{
+	iotlb_entry_flush(obj, e->va);
+	return twl_pte_set(obj, e);
+}
+EXPORT_SYMBOL(iotwl_pte_set);
+
+static inline void twl_pte_clear(struct iommu *obj, unsigned long va)
+{
+	pte_t *ptep, *end;
+	pmd_t *pmdp;
+	struct mm_struct *mm = obj->twl_mm;
+
+	pmdp = pmd_offset(pgd_offset(mm, va), va);
+	if (pmd_none(*pmdp))
+		return;
+	if (!pmd_table(*pmdp)) {
+		pmd_clear(pmdp);
+		return;
+	}
+	ptep = pte_offset_kernel(pmdp, va);
+	pte_clear(mm, va, ptep);
+	/* zap pte */
+	ptep = pmd_page_vaddr(*pmdp);
+	end = ptep + PTRS_PER_PTE;
+	while (ptep < end) {
+		if (!pte_none(*ptep))
+			return;
+		ptep++;
+	}
+	pte_free_kernel(mm, pmd_page_vaddr(*pmdp));
+}
+
+void iotwl_pte_clear(struct iommu *obj, unsigned long va)
+{
+	struct mm_struct *mm = obj->twl_mm;
+
+	spin_lock(&mm->page_table_lock);
+
+	twl_pte_clear(obj, va);
+	iotlb_entry_flush(obj, va);
+
+	spin_unlock(&mm->page_table_lock);
+}
+EXPORT_SYMBOL(iotwl_pte_clear);
+
+static void twl_pte_clear_all(struct iommu *obj)
+{
+	int i;
+	pte_t *ptep, *end;
+	pmd_t *pmdp;
+	struct mm_struct *mm = obj->twl_mm;
+
+	spin_lock(&mm->page_table_lock);
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		unsigned long va;
+
+		va = i << PGDIR_SHIFT;
+		pmdp = pmd_offset(pgd_offset(mm, va), va);
+		if (pmd_none(*pmdp))
+			continue;
+		if (!pmd_table(*pmdp)) {
+			pmd_clear(pmdp);
+			continue;
+		}
+		/* zap pte */
+		ptep = pmd_page_vaddr(*pmdp);
+		end = ptep + PTRS_PER_PTE;
+		while (ptep < end) {
+			if (!pte_none(*ptep))
+				pte_clear(mm, va, ptep);
+			ptep++;
+		}
+		pte_free_kernel(mm, pmd_page_vaddr(*pmdp));
+	}
+	iotlb_flush_all(obj);
+	spin_unlock(&mm->page_table_lock);
+}
+
+int iotwl_mm_alloc(struct iommu *obj)
+{
+	if (obj->twl_mm) {
+		dev_err(obj->dev, "twl_mm already existed\n");
+		return -EIO;
+	}
+	obj->twl_mm = mm_alloc();
+	if (!obj->twl_mm)
+		return -ENOMEM;
+	obj->twl_mm->free_area_cache = 0;
+	twl_pte_clear_all(obj); /* FIXME */
+	return 0;
+}
+EXPORT_SYMBOL(iotwl_mm_alloc);
+
+void iotwl_mm_free(struct iommu *obj)
+{
+	if (!obj->twl_mm)
+		return;
+	__mmdrop(obj->twl_mm);
+	obj->twl_mm = NULL;
+}
+EXPORT_SYMBOL(iotwl_mm_free);
+
+/*
+ *
+ *	Device MMU generic operations
+ *
+ */
+static int match_by_alias(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iommu *obj = platform_get_drvdata(pdev);
+	const char *name = data;
+	return strcmp(obj->name, name) == 0;
+}
+
+struct iommu *iommu_get(const char *name)
+{
+	struct platform_device *pdev;
+	struct device *dev;
+	struct iommu *obj;
+
+	dev = driver_find_device(&iommu_driver.driver, NULL, (void *)name,
+				 match_by_alias);
+	if (!dev)
+		return NULL;
+	pdev = to_platform_device(dev);
+	obj = platform_get_drvdata(pdev);
+	if (test_and_set_bit(0, &obj->flag))
+		return NULL;
+	return obj;
+}
+EXPORT_SYMBOL(iommu_get);
+
+int iommu_put(struct iommu *obj)
+{
+	if (test_and_clear_bit(0, &obj->flag))
+		return 0;
+	return -EIO;
+}
+EXPORT_SYMBOL(iommu_put);
+
+int iommu_arch_init(struct iommu_functions *ops)
+{
+	BUG_ON(!ops);
+	arch_iommu = ops;
+	return 0;
+}
+EXPORT_SYMBOL(iommu_arch_init);
+
+int iommu_enable(struct iommu *obj)
+{
+	WARN_ON(!arch_iommu);
+	if (!arch_iommu->enable)
+		return -ENODEV;
+	return arch_iommu->enable(obj);
+}
+EXPORT_SYMBOL(iommu_enable);
+
+void iommu_disable(struct iommu *obj)
+{
+	if (arch_iommu->disable)
+		arch_iommu->disable(obj);
+}
+EXPORT_SYMBOL(iommu_disable);
+
+/*
+ *
+ *	Device MMU detection
+ *
+ */
+static int __init omap_iommu_probe(struct platform_device *pdev)
+{
+	int err;
+	struct iommu *obj;
+	struct resource *res;
+	struct iommu_pdata *pdata;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+	pdata = pdev->dev.platform_data;
+	obj->nr_tlb_entries = pdata->nr_tlb_entries;
+	obj->name = (char *)pdata->name;
+	obj->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -ENODEV;
+		goto err_mem;
+	}
+	obj->regsize = res->end - res->start;
+	obj->regbase = ioremap(res->start, obj->regsize);
+	if (!obj->regbase) {
+		err = -ENODEV;
+		goto err_mem;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, res->start, obj->regsize,
+				      dev_name(&pdev->dev));
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
+	err = devm_request_irq(&pdev->dev, obj->irq, mm_fault_handler,
+			       IRQF_DISABLED,  dev_name(&pdev->dev), obj);
+	if (err < 0)
+		goto err_irq;
+	platform_set_drvdata(pdev, obj);
+
+	/* FIXME: register generic MMU device class */
+	if (err)
+		goto err_mm;
+	return 0;
+
+err_mm:
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
+static int omap_iommu_remove(struct platform_device *pdev)
+{
+	struct iommu *obj;
+
+	obj = platform_get_drvdata(pdev);
+	devm_free_irq(&pdev->dev, obj->irq, obj);
+	devm_release_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
+				obj->regsize);
+	iounmap(obj->regbase);
+	kfree(obj);
+	return 0;
+}
+
+static struct platform_driver omap_iommu_driver = {
+	.probe	= omap_iommu_probe,
+	.remove	= omap_iommu_remove,
+	.driver	= {
+		.name	= DEV_NAME,
+	},
+};
+
+static int __init omap_iommu_driver_init(void)
+{
+	return platform_driver_register(&omap_iommu_driver);
+}
+static void __exit omap_iommu_driver_exit(void)
+{
+	platform_driver_unregister(&omap_iommu_driver);
+}
+module_init(omap_iommu_driver_init);
+module_exit(omap_iommu_driver_exit);
+
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>"
+	      "Paul Mundt and Toshihiro Kobayashi");
+MODULE_DESCRIPTION("OMAP peripheral device common IOMMU driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:"DEVNAME);
diff --git a/arch/arm/plat-omap/proc-iommu.S b/arch/arm/plat-omap/proc-iommu.S
new file mode 100644
index 0000000..9759cb6
--- /dev/null
+++ b/arch/arm/plat-omap/proc-iommu.S
@@ -0,0 +1,33 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+/*
+ *	ioset_pte_ext(ptep, pte, ext)
+ *
+ *	Set a level 2 translation table entry.
+ *
+ *	- ptep  - pointer to level 2 translation table entry
+ *		  (hardware version is stored at -1024 bytes)
+ *	- pte   - PTE value to store
+ *	- ext	- value for extended PTE bits (unused)
+ */
+ENTRY(ioset_pte_ext)
+	str	r1, [r0], #-2048		@ linux version
+	str	r2, [r0]
+	/*
+	 * Insert whatever needed here
+	 */
+	mcr	p15, 0, r0, c7, c10, 1 @ flush_pte
+	mov	pc, lr
+
+
-- 
1.5.5.1.357.g1af8b

