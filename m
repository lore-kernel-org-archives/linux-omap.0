From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP: IOMMU driver: Core part
Date: Mon, 8 Sep 2008 11:46:50 +0100
Message-ID: <20080908104650.GB14832@flint.arm.linux.org.uk>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com> <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34446 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYIHKrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 06:47:06 -0400
Content-Disposition: inline
In-Reply-To: <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com

On Mon, Sep 08, 2008 at 08:56:30AM +0300, Hiroshi DOYU wrote:
> +/* MMU object handler */
> +struct iommu {
> +	/* MMU */
> +	int		type;
> +	char		*name;
> +	struct clk	*clk;
> +	void __iomem	*regbase;
> +	unsigned long	regsize;
> +	unsigned long	flag;
> +	struct device	*dev;
> +
> +	/* TWL */
> +	struct mm_struct	*twl_mm;

mm_struct is a non-trivial size - why do you need it?

> +	void (*isr)(struct iommu *obj);
> +
> +	/* TLB */
> +	int		nr_tlb_entries;
> +	int		irq;
> +};
> +
> +struct cr_regs {
> +	union {
> +		struct {
> +			u16 cam_l;
> +			u16 cam_h;
> +		};
> +		u32 cam;
> +	};
> +	union {
> +		struct {
> +			u16 ram_l;
> +			u16 ram_h;
> +		};
> +		u32 ram;
> +	};

Making assumptions about the endianness - is OMAP guaranteed to always be
little endian?

> +};
> +
> +struct iotlb_lock {
> +	int base;
> +	int victim;
> +};
> +
> +struct iotlb_entry;
> +
> +/* Absorb the differences amang MMU versions */
> +struct iommu_functions {
> +	/* MMU common */
> +	int (*startup)(struct iommu *obj);
> +	void (*shutdown)(struct iommu *obj);
> +	int (*enable)(struct iommu *obj);
> +	void (*disable)(struct iommu *obj);
> +	void (*isr)(struct iommu *obj);
> +
> +	/* TLB operations */
> +	void (*tlb_cr_read)(struct iommu *obj, struct cr_regs *cr);
> +	void (*tlb_cr_load)(struct iommu *obj, struct cr_regs *cr);
> +
> +	/* CAM / RAM operations */
> +	struct cr_regs *(*cr_alloc)(struct iommu *obj, struct iotlb_entry *e);
> +	int (*cr_valid)(struct cr_regs *cr);
> +	unsigned long (*cr_to_virt)(struct cr_regs *cr);
> +
> +	/* PTE attribute operations */
> +	pgprot_t (*pte_attr_get)(struct iotlb_entry *e);
> +
> +	/* debug */
> +	void (*regs_show)(struct iommu *obj);
> +	ssize_t (*tlb_show)(struct iommu *obj, char *, struct iotlb_lock *lock);
> +};
> +
> +struct iommu_pdata {
> +	const char	*name;
> +	int		nr_tlb_entries;
> +	struct clk	*clk;
> +	char		*clk_name;
> +	struct resource	*res;
> +	int		n_res;
> +};
> +
> +/* Generic */
> +struct iommu *iommu_get(const char *name);
> +int iommu_put(struct iommu *obj);
> +int iommu_enable(struct iommu *obj);
> +void iommu_disable(struct iommu *obj);
> +int iommu_arch_init(struct iommu_functions *ops);
> +
> +/* TLB */
> +void iotlb_cr_read(struct iommu *obj, struct iotlb_lock *l, struct cr_regs *cr);
> +void iotlb_cr_load(struct iommu *obj, struct cr_regs *cr);
> +void iotlb_flush_all(struct iommu *obj);
> +int iotlb_entry_load(struct iommu *obj, struct iotlb_entry *e);
> +void iotlb_entry_flush(struct iommu *obj, unsigned long vadr);
> +
> +/* TWL */
> +int iotwl_pte_set(struct iommu *obj, struct iotlb_entry *e);
> +void iotwl_pte_clear(struct iommu *obj, unsigned long virt);
> +int iotwl_mm_alloc(struct iommu *obj);
> +void iotwl_mm_free(struct iommu *obj);
> +
> +/* VMA */
> +unsigned long ioget_unmapped_area(struct iommu *obj, unsigned long len);
> +dma_addr_t iomap_region(struct iommu *obj, struct iotlb_entry *e);
> +void iounmap_region(struct iommu *obj, unsigned long iova, size_t len);
> +
> +/* omap mmu version of cpu_set_pte_ext() */
> +void ioset_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
> +
> +#include "iommu2.h" /* REVISIT */
> +
> +#endif /* __IOMMU_H */
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> new file mode 100644
> index 0000000..1b25f65
> --- /dev/null
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -0,0 +1,510 @@
> +/*
> + * OMAP peripheral device common IOMMU driver
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
> + *		Paul Mundt and Toshihiro Kobayashi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +
> +#include <asm/pgalloc.h>
> +
> +#include <mach/clock.h>
> +#include <mach/iommu.h>
> +
> +static struct iommu_functions *arch_iommu;
> +static struct platform_driver iommu_driver;
> +
> +/*
> + *	TLB helper functions
> + */
> +static inline void tlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
> +{
> +	unsigned long val;
> +	val = iommu_read_reg(obj, MMU_LOCK);
> +	l->base = MMU_LOCK_BASE(val);
> +	l->victim = MMU_LOCK_VICTIM(val);
> +}
> +
> +static inline void tlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
> +{
> +	u32 val;
> +	val = (l->base << MMU_LOCK_BASE_SHIFT) |
> +		(l->victim << MMU_LOCK_VICTIM_SHIFT);
> +	iommu_write_reg(obj, val, MMU_LOCK);
> +}
> +
> +static inline void tlb_entry_flush(struct iommu *obj)
> +{
> +	iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> +}
> +
> +static inline void tlb_ldtlb(struct iommu *obj)
> +{
> +	iommu_write_reg(obj, 1, MMU_LD_TLB);
> +}
> +
> +/*
> + *
> + *	TLB operations
> + *
> + */
> +void iotlb_cr_read(struct iommu *obj, struct iotlb_lock *l, struct cr_regs *cr)
> +{
> +	tlb_lock_set(obj, l);
> +	arch_iommu->tlb_cr_read(obj, cr);
> +}
> +EXPORT_SYMBOL(iotlb_cr_read);
> +
> +void iotlb_cr_load(struct iommu *obj, struct cr_regs *cr)
> +{
> +	arch_iommu->tlb_cr_load(obj, cr);
> +	tlb_entry_flush(obj);
> +	tlb_ldtlb(obj);
> +}
> +EXPORT_SYMBOL(iotlb_cr_load);
> +
> +void iotlb_flush_all(struct iommu *obj)
> +{
> +	struct iotlb_lock l;
> +	iommu_write_reg(obj, 1, MMU_GFLUSH);
> +	l.base = 0;
> +	l.victim = 0;
> +	tlb_lock_set(obj, &l);
> +}
> +EXPORT_SYMBOL(iotlb_flush_all);
> +
> +int iotlb_entry_load(struct iommu *obj, struct iotlb_entry *e)
> +{
> +	struct iotlb_lock l;
> +	struct cr_regs *cr;
> +
> +	tlb_lock_get(obj, &l);
> +	for (l.victim = 0; l.victim < l.base; l.victim++) {
> +		struct cr_regs tmp;
> +		iotlb_cr_read(obj, &l, &tmp);
> +		if (!arch_iommu->cr_valid(&tmp))
> +			goto found;
> +	}
> +	tlb_lock_set(obj, &l);
> +found:
> +	if (l.victim == (obj->nr_tlb_entries - 1)) {
> +		dev_err(obj->dev, "TLB is full\n");
> +		return -EBUSY;
> +	}
> +	cr = arch_iommu->cr_alloc(obj, e);
> +	if (IS_ERR(cr))
> +		return PTR_ERR(cr);
> +	iotlb_cr_load(obj, cr);
> +	kfree(cr);
> +	if (l.victim == l.base)
> +		l.base++;
> +	tlb_lock_set(obj, &l);
> +	return 0;
> +}
> +EXPORT_SYMBOL(iotlb_entry_load);
> +
> +void iotlb_entry_flush(struct iommu *obj, unsigned long va)
> +{
> +	struct iotlb_lock l;
> +	int i;
> +	int max_valid = 0;
> +
> +	tlb_lock_get(obj, &l);
> +	for (i = 0; i < l.base; i++) {
> +		struct cr_regs cr;
> +		l.victim = i;
> +		iotlb_cr_read(obj, &l, &cr);
> +		if (!arch_iommu->cr_valid(&cr))
> +			continue;
> +		if (arch_iommu->cr_to_virt(&cr) == va)
> +			tlb_entry_flush(obj);
> +		else
> +			max_valid = i;
> +	}
> +	l.base = l.victim = max_valid + 1;
> +	tlb_lock_set(obj, &l);
> +}
> +EXPORT_SYMBOL(iotlb_entry_flush);
> +
> +static irqreturn_t mm_fault_handler(int irq, void *data)
> +{
> +	struct iommu *obj = data;
> +	if (obj->isr)
> +		obj->isr(obj);
> +	else
> +		arch_iommu->isr(obj);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + *
> + *	TWL operations (H/W pagetable)
> + *
> + */
> +static inline void twl_alloc_section(struct mm_struct *mm, unsigned long va,
> +				     unsigned long pa, int prot)
> +{
> +	pmd_t *pmdp = pmd_offset(pgd_offset(mm, va), va);
> +	if (va & (1 << SECTION_SHIFT))
> +		pmdp++;
> +	*pmdp = __pmd((pa & SECTION_MASK) | prot | PMD_TYPE_SECT);
> +	flush_pmd_entry(pmdp);

Using own accessor macros rather than the kernel's page table accessors
would be better, and insulate you from changes made there.  I'd also
suggest replacing 'va' with something else (maybe 'da') to make it
obvious that we're not talking about the host CPU's virtual address space.

> +}
> +
> +static inline void twl_alloc_super(struct mm_struct *mm, unsigned long va,
> +				   unsigned long pa, int prot)
> +{
> +	int i;
> +	for (i = 0; i < 16; i += 1) {
> +		twl_alloc_section(mm, va, pa, prot | PMD_SECT_SUPER);
> +		va += (PGDIR_SIZE / 2);
> +	}

And then you can avoid repeatedly flushing when setting up a supersection
mapping.

> +}
> +
> +static inline int twl_alloc_page(struct mm_struct *mm, unsigned long va,
> +				 unsigned long pa, pgprot_t prot)
> +{
> +	pte_t *ptep;
> +	pmd_t *pmdp = pmd_offset(pgd_offset(mm, va), va);
> +
> +	if (!(prot & PTE_TYPE_MASK))
> +		prot |= PTE_TYPE_SMALL;
> +
> +	if (pmd_none(*pmdp)) {
> +		ptep = pte_alloc_one_kernel(mm, va);
> +		if (ptep == NULL)
> +			return -ENOMEM;
> +		pmd_populate_kernel(mm, pmdp, ptep);
> +	}
> +	ptep = pte_offset_kernel(pmdp, va);
> +	ioset_pte_ext(ptep, pfn_pte(pa >> PAGE_SHIFT, prot),
> +		      L_PTE_PRESENT);
> +	return 0;
> +}
> +
> +static inline int twl_alloc_large(struct mm_struct *mm, unsigned long va,
> +				  unsigned long pa, pgprot_t prot)
> +{
> +	int i;
> +	for (i = 0; i < 16; i += 1) {
> +		int err;
> +		err = twl_alloc_page(mm, va, pa, prot | PTE_TYPE_LARGE);
> +		if (err)
> +			return -ENOMEM;
> +		va += PAGE_SIZE;
> +	}
> +	return 0;
> +}
> +
> +static inline int twl_pte_set(struct iommu *obj, struct iotlb_entry *e)
> +{

A better name for this might be: twl_pagetable_set, since 'pte' generally
means the last level of page tables, and this function doesn't necessarily
touch the last level.

> +	int err = 0;
> +	struct mm_struct *mm = obj->twl_mm;
> +	const unsigned long va = e->va;
> +	const unsigned long pa = e->pa;
> +	const pgprot_t prot = arch_iommu->pte_attr_get(e);
> +
> +	spin_lock(&mm->page_table_lock);

Use your own lock:
	spin_lock(&obj->page_table_lock);

> +
> +	switch (e->pgsz) {
> +	case MMU_CAM_PAGESIZE_16MB:
> +		twl_alloc_super(mm, va, pa, prot);
> +		break;
> +	case MMU_CAM_PAGESIZE_1MB:
> +		twl_alloc_section(mm, va, pa, prot);
> +		break;
> +	case MMU_CAM_PAGESIZE_64KB:
> +		err = twl_alloc_large(mm, va, pa, prot);
> +		break;
> +	case MMU_CAM_PAGESIZE_4KB:
> +		err = twl_alloc_page(mm, va, pa, prot);
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +	spin_unlock(&mm->page_table_lock);

	spin_unlock(&obj->page_table_lock);

> +	return err;
> +}

So, this all becomes something like (untested):

#define IOPGD_SHIFT		20
#define IOPTE_SHIFT		12
#define IOPTE_SIZE		(1 << (IOPGD_SHIFT - IOPTE_SHIFT))
#define IOSECTION_MASK		(~((1 << IOPGD_SHIFT) - 1))
#define IOPAGE_MASK		(~((1 << IOPTE_SHIFT) - 1))
#define IOPGD_TABLE		(1 << 0)
#define IOPGD_SECTION		(2 << 0)
#define IOPGD_SUPERSECTION	(1 << 18 | 2 << 0)
#define IOPTE_SMALL		(2 << 0)
#define IOPTE_LARGE		(1 << 0)

#define iopgd_index(va)		((va) >> IOPGD_SHIFT)
#define iopgd_offset(obj, va)	((obj)->iopgd + iopgd_index(va))
#define iopte_index(va)		(((va) >> IOPTE_SHIFT) & (IOPTE_SIZE - 1))
#define iopte_offset(iopgd, va)	((u32 *)(((*iopgd) + ((va) >> IOPTE_SHIFT)) & ~IOPGD_TABLE))

/*
 * Needs iopte_cache, a slab cache with a constructor creating zero'd
 * and flushed iopte's.
 */

static void flush_iopgd_range(u32 *first, u32 *last)
{
	do {
		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
		   : : "r" (first));
		first += L1_CACHE_BYTES >> 2;
	} while (first <= last);
}

static void flush_iopte_range(u32 *first, u32 *last)
{
	do {
		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
		   : : "r" (first));
		first += L1_CACHE_BYTES >> 2;
	} while (first <= last);
}

static void iopte_free(u32 *iopte)
{
	/* Note: freed iopte's must be clean ready for re-use */
	kmem_cache_free(iopte_cache, iopte);
}

static u32 *iopte_alloc(struct iommu *obj, u32 *iopgd, unsigned long va)
{
	u32 *iopte;

	/*
	 * do the allocation outside the page table lock
	 */
	spin_unlock(&obj->page_table_lock);
	iopte = kmem_cache_alloc(iopte_cache, GFP_KERNEL);
	spin_lock(&obj->page_table_lock);

	if (!*iopgd) {
		if (iopte == NULL)
			return -ENOMEM;
		*iopgd = (u32)iopte | IOPGD_TABLE;
		flush_iopgd_range(iopgd, iopgd);
	} else {
		/* We raced, free the redundant table */
		iopte_free(iopte);
	}
	return iopte_offset(iopgd, va);
}

static int twl_alloc_section(struct iommu *obj, unsigned long va,
			     unsigned long pa, unsigned long prot)
{
	u32 *iopgd = iopgd_offset(obj, va);

	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
	flush_iopgd_range(iopgd, iopgd);
	return 0;
}


static int twl_alloc_super(struct iommu *obj, unsigned long va,
			   unsigned long pa, unsigned long prot)
{
	u32 *iopgd = iopgd_offset(obj, va) + 15;
	int i;

	for (i = 0; i < 16; i++)
		*iopgd-- = (pa & IOSUPERSECTION_MASK) | prot | IOPGD_SUPER;
	flush_iopgd_range(iopgd, iopgd + 15);
	return 0;
}

static int twl_alloc_page(struct iommu *obj, unsigned long va,
			   unsigned long pa, unsigned long prot)
{
	u32 *iopgd = iopgd_offset(obj, va);
	u32 *iopte = iopte_alloc(obj, iopgd, va);

	if (!iopte)
		return -ENOMEM;

	*iopte = (pa & IOPAGE_MASK) | prot | IOPTE_SMALL;
	flush_iopte_range(iopte, iopte);
	return 0;
}

static int twl_alloc_large(struct iommu *obj, unsigned long va,
			   unsigned long pa, unsigned long prot)
{
	u32 *iopgd = iopgd_offset(obj, va);
	u32 *iopte = iopte_alloc(obj, iopgd, va);
	int i;

	if (!iopte)
		return -ENOMEM;

	for (i = 0; i < 16; i++)
		*iopte-- = (pa & IOLARGEPAGE_MASK) | prot | IOPTE_LARGE;
	flush_iopte_range(iopte, iopte + 15);
	return 0;
}

static int twl_pagetable_set(struct iommu *obj, struct iotlb_entry *e)
{
	int (*fn)(struct iommu *, unsigned long, unsigned long, unsigned long);
	unsigned long prot = arch_iommu->pte_attr_get(e);
	int err;

	switch (e->pgsz) {
	case MMU_CAM_PAGESIZE_16MB:
		fn = twl_alloc_super;
		break;
	case MMU_CAM_PAGESIZE_1MB:
		fn = twl_alloc_section;
		break;
	case MMU_CAM_PAGESIZE_64KB:
		fn = twl_alloc_large;
		break;
	case MMU_CAM_PAGESIZE_4KB:
		fn = twl_alloc_page;
		break;
	default:
		BUG();
		break;
	}

	spin_lock(&obj->page_table_lock);
	err = fn(iommu, e->va, e->pa, prot);
	spin_unlock(&obj->page_table_lock);

	return err;
}

Note also that the compiler will generally decide to inline where
appropriate - 'inline' should be viewed as a 'I really really want
this to be inlined' flag.

> +
> +int iotwl_pte_set(struct iommu *obj, struct iotlb_entry *e)
> +{
> +	iotlb_entry_flush(obj, e->va);
> +	return twl_pte_set(obj, e);
> +}
> +EXPORT_SYMBOL(iotwl_pte_set);
> +
> +static inline void twl_pte_clear(struct iommu *obj, unsigned long va)
> +{
> +	pte_t *ptep, *end;
> +	pmd_t *pmdp;
> +	struct mm_struct *mm = obj->twl_mm;
> +
> +	pmdp = pmd_offset(pgd_offset(mm, va), va);
> +	if (pmd_none(*pmdp))
> +		return;
> +	if (!pmd_table(*pmdp)) {
> +		pmd_clear(pmdp);
> +		return;
> +	}
> +	ptep = pte_offset_kernel(pmdp, va);
> +	pte_clear(mm, va, ptep);
> +	/* zap pte */
> +	ptep = pmd_page_vaddr(*pmdp);
> +	end = ptep + PTRS_PER_PTE;
> +	while (ptep < end) {
> +		if (!pte_none(*ptep))
> +			return;
> +		ptep++;
> +	}
> +	pte_free_kernel(mm, pmd_page_vaddr(*pmdp));

Freeing the page table, leaving a reference to it inside the page
table structure.  So when the page gets re-used, the IOMMU ends up
trying to walk whatever new data is in that page.  Not nice.

	u32 *iopgd = iopgd_offset(obj, va);

	if (!*iopgd)
		return;	

	if ((u32)*iopgd & IOPGD_TABLE) {
		u32 *iopte = iopte_offset(iopgd, va);
		*iopte = 0;
		flush_iopte_range(iopte, iopte);
		
		iopte = iopte_offset(iopgd, 0);
		for (i = 0; i < IOPTE_SIZE; i++)
			if (iopte[i])
				return;
		iopte_free(iopte);
	}
	*iopgd = NULL;
	flush_iopgd_range(iopgd, iopgd);

However, how often is a single entry cleared?  Would it be better not to
free the page table, but to have a function which walks the entire page
table tree freeing all the tables?

> +}
> +
> +void iotwl_pte_clear(struct iommu *obj, unsigned long va)
> +{
> +	struct mm_struct *mm = obj->twl_mm;
> +
> +	spin_lock(&mm->page_table_lock);
> +
> +	twl_pte_clear(obj, va);
> +	iotlb_entry_flush(obj, va);
> +
> +	spin_unlock(&mm->page_table_lock);
> +}
> +EXPORT_SYMBOL(iotwl_pte_clear);
> +
> +static void twl_pte_clear_all(struct iommu *obj)
> +{
> +	int i;
> +	pte_t *ptep, *end;
> +	pmd_t *pmdp;
> +	struct mm_struct *mm = obj->twl_mm;
> +
> +	spin_lock(&mm->page_table_lock);
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> +		unsigned long va;
> +
> +		va = i << PGDIR_SHIFT;
> +		pmdp = pmd_offset(pgd_offset(mm, va), va);
> +		if (pmd_none(*pmdp))
> +			continue;
> +		if (!pmd_table(*pmdp)) {
> +			pmd_clear(pmdp);
> +			continue;
> +		}
> +		/* zap pte */
> +		ptep = pmd_page_vaddr(*pmdp);
> +		end = ptep + PTRS_PER_PTE;
> +		while (ptep < end) {
> +			if (!pte_none(*ptep))
> +				pte_clear(mm, va, ptep);
> +			ptep++;
> +		}
> +		pte_free_kernel(mm, pmd_page_vaddr(*pmdp));
> +	}
> +	iotlb_flush_all(obj);
> +	spin_unlock(&mm->page_table_lock);
> +}
> +
> +int iotwl_mm_alloc(struct iommu *obj)
> +{
> +	if (obj->twl_mm) {
> +		dev_err(obj->dev, "twl_mm already existed\n");
> +		return -EIO;
> +	}
> +	obj->twl_mm = mm_alloc();
> +	if (!obj->twl_mm)
> +		return -ENOMEM;
> +	obj->twl_mm->free_area_cache = 0;
> +	twl_pte_clear_all(obj); /* FIXME */

With the structure I suggest above, this becomes unnecessary.  In fact,
you just need to allocate the 1st level page table and ensure that it's
cleared.

> +	return 0;
> +}
> +EXPORT_SYMBOL(iotwl_mm_alloc);
> +
> +void iotwl_mm_free(struct iommu *obj)
> +{
> +	if (!obj->twl_mm)
> +		return;

How is it ensured that the page tables have been freed?  Who is responsible
for ensuring that?

> +	__mmdrop(obj->twl_mm);
> +	obj->twl_mm = NULL;
> +}
> +EXPORT_SYMBOL(iotwl_mm_free);
> +
> +/*
> + *
> + *	Device MMU generic operations
> + *
> + */
> +static int match_by_alias(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iommu *obj = platform_get_drvdata(pdev);
> +	const char *name = data;
> +	return strcmp(obj->name, name) == 0;
> +}
> +
> +struct iommu *iommu_get(const char *name)
> +{
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct iommu *obj;
> +
> +	dev = driver_find_device(&iommu_driver.driver, NULL, (void *)name,
> +				 match_by_alias);
> +	if (!dev)
> +		return NULL;
> +	pdev = to_platform_device(dev);
> +	obj = platform_get_drvdata(pdev);
> +	if (test_and_set_bit(0, &obj->flag))
> +		return NULL;
> +	return obj;
> +}
> +EXPORT_SYMBOL(iommu_get);
> +
> +int iommu_put(struct iommu *obj)
> +{
> +	if (test_and_clear_bit(0, &obj->flag))
> +		return 0;
> +	return -EIO;
> +}
> +EXPORT_SYMBOL(iommu_put);
> +
> +int iommu_arch_init(struct iommu_functions *ops)
> +{
> +	BUG_ON(!ops);

BUG_ON(arch_iommu) maybe, to catch two people calling this?

> +	arch_iommu = ops;
> +	return 0;
> +}
> +EXPORT_SYMBOL(iommu_arch_init);
> +
> +int iommu_enable(struct iommu *obj)
> +{
> +	WARN_ON(!arch_iommu);

BUG_ON would be better, since you're going to be crashing anyway.

> +	if (!arch_iommu->enable)
> +		return -ENODEV;
> +	return arch_iommu->enable(obj);
> +}
> +EXPORT_SYMBOL(iommu_enable);
> +
> +void iommu_disable(struct iommu *obj)
> +{
> +	if (arch_iommu->disable)
> +		arch_iommu->disable(obj);
> +}
> +EXPORT_SYMBOL(iommu_disable);
> +
> +/*
> + *
> + *	Device MMU detection
> + *
> + */
> +static int __init omap_iommu_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct iommu *obj;
> +	struct resource *res;
> +	struct iommu_pdata *pdata;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;
> +	pdata = pdev->dev.platform_data;
> +	obj->nr_tlb_entries = pdata->nr_tlb_entries;
> +	obj->name = (char *)pdata->name;
> +	obj->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -ENODEV;
> +		goto err_mem;
> +	}
> +	obj->regsize = res->end - res->start;
> +	obj->regbase = ioremap(res->start, obj->regsize);
> +	if (!obj->regbase) {
> +		err = -ENODEV;
> +		goto err_mem;
> +	}
> +
> +	res = devm_request_mem_region(&pdev->dev, res->start, obj->regsize,
> +				      dev_name(&pdev->dev));
> +	if (!res) {
> +		err = -EIO;
> +		goto err_mem;
> +	}
> +
> +	obj->irq = platform_get_irq(pdev, 0);
> +	if (obj->irq < 0) {
> +		err = -ENODEV;
> +		goto err_irq;
> +	}
> +	err = devm_request_irq(&pdev->dev, obj->irq, mm_fault_handler,
> +			       IRQF_DISABLED,  dev_name(&pdev->dev), obj);
> +	if (err < 0)
> +		goto err_irq;
> +	platform_set_drvdata(pdev, obj);
> +
> +	/* FIXME: register generic MMU device class */
> +	if (err)
> +		goto err_mm;
> +	return 0;
> +
> +err_mm:
> +	devm_free_irq(&pdev->dev, obj->irq, obj);
> +err_irq:
> +	devm_release_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
> +				obj->regsize);
> +	iounmap(obj->regbase);
> +err_mem:
> +	kfree(obj);
> +	return err;
> +}
> +
> +static int omap_iommu_remove(struct platform_device *pdev)
> +{
> +	struct iommu *obj;
> +
> +	obj = platform_get_drvdata(pdev);
> +	devm_free_irq(&pdev->dev, obj->irq, obj);
> +	devm_release_mem_region(&pdev->dev, (resource_size_t)obj->regbase,
> +				obj->regsize);
> +	iounmap(obj->regbase);
> +	kfree(obj);
> +	return 0;
> +}
> +
> +static struct platform_driver omap_iommu_driver = {
> +	.probe	= omap_iommu_probe,
> +	.remove	= omap_iommu_remove,
> +	.driver	= {
> +		.name	= DEV_NAME,
> +	},
> +};
> +
> +static int __init omap_iommu_driver_init(void)
> +{
> +	return platform_driver_register(&omap_iommu_driver);
> +}
> +static void __exit omap_iommu_driver_exit(void)
> +{
> +	platform_driver_unregister(&omap_iommu_driver);
> +}
> +module_init(omap_iommu_driver_init);
> +module_exit(omap_iommu_driver_exit);
> +
> +MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>"
> +	      "Paul Mundt and Toshihiro Kobayashi");
> +MODULE_DESCRIPTION("OMAP peripheral device common IOMMU driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:"DEVNAME);
> diff --git a/arch/arm/plat-omap/proc-iommu.S b/arch/arm/plat-omap/proc-iommu.S
> new file mode 100644
> index 0000000..9759cb6
> --- /dev/null
> +++ b/arch/arm/plat-omap/proc-iommu.S
> @@ -0,0 +1,33 @@
> +/*
> + * OMAP peripheral device common IOMMU driver
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <asm/asm-offsets.h>
> +/*
> + *	ioset_pte_ext(ptep, pte, ext)
> + *
> + *	Set a level 2 translation table entry.
> + *
> + *	- ptep  - pointer to level 2 translation table entry
> + *		  (hardware version is stored at -1024 bytes)
> + *	- pte   - PTE value to store
> + *	- ext	- value for extended PTE bits (unused)
> + */
> +ENTRY(ioset_pte_ext)
> +	str	r1, [r0], #-2048		@ linux version
> +	str	r2, [r0]
> +	/*
> +	 * Insert whatever needed here
> +	 */
> +	mcr	p15, 0, r0, c7, c10, 1 @ flush_pte
> +	mov	pc, lr
> +
> +
> -- 
> 1.5.5.1.357.g1af8b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
