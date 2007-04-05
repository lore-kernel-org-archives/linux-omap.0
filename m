From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] ARM:OMAP: Add initial TWL support for non-MPU MMU
	framework
Date: Thu,  5 Apr 2007 12:49:53 +0300
Message-ID: <11757665933290-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This enables non-MPU MMU(camere,iva,dsp) to use H/W page table
walk. It will be free from the limitation of TLB entries in order to
manage device's vm area.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.h       |    3 +
 arch/arm/mach-omap2/mmu.c       |   23 ++++-
 arch/arm/mach-omap2/mmu.h       |    2 +
 arch/arm/plat-omap/mmu.c        |  212 +++++++++++++++++++++++++++++++++++++--
 include/asm-arm/arch-omap/mmu.h |    9 ++
 include/asm-arm/pgtable.h       |    1 +
 6 files changed, 237 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 9bda297..d86d966 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -67,6 +67,7 @@
 #define OMAP_MMU_CAM_PAGESIZE_64KB	OMAP_MMU_CAM_L_PAGESIZE_64KB
 #define OMAP_MMU_CAM_PAGESIZE_4KB	OMAP_MMU_CAM_L_PAGESIZE_4KB
 #define OMAP_MMU_CAM_PAGESIZE_1KB	OMAP_MMU_CAM_L_PAGESIZE_1KB
+#define OMAP_MMU_CAM_PAGESIZE_16MB	-1 /* unused in omap1 */
 
 #define OMAP_MMU_RAM_L_RAM_LSB_MASK	0xfc00
 #define OMAP_MMU_RAM_L_AP_MASK		0x0300
@@ -83,6 +84,7 @@ do {							\
 	(ent)->pgsz	= (ps);				\
 	(ent)->prsvd	= 0;				\
 	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
+	(ent)->tlb	= 1;				\
 } while (0)
 
 #define INIT_TLB_ENTRY_4KB_PRESERVED(ent,v,p)		\
@@ -102,6 +104,7 @@ struct omap_mmu_tlb_entry {
 	unsigned int pgsz, prsvd, valid;
 
 	u16 ap;
+	unsigned int tlb;
 };
 
 static inline unsigned short
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index f94057e..2a52907 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -3,11 +3,13 @@
  *
  * Support for non-MPU OMAP2 MMUs.
  *
- * Copyright (C) 2002-2005 Nokia Corporation
+ * Copyright (C) 2002-2007 Nokia Corporation
  *
  * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
  *        and Paul Mundt <paul.mundt@nokia.com>
  *
+ * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -64,7 +66,7 @@ static void exmap_setup_iomap_page(struct omap_mmu *mmu, unsigned long phys,
 	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, NULL, virt);
 	INIT_TLB_ENTRY_4KB_ES32_PRESERVED(&tlb_ent, dspadr, phys);
-	omap_mmu_load_tlb_entry(mmu, &tlb_ent);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
 }
 
 static void exmap_clear_iomap_page(struct omap_mmu *mmu,
@@ -138,8 +140,7 @@ static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
 	(OMAP_MMU_IRQ_MULTIHITFAULT | \
 	 OMAP_MMU_IRQ_TABLEWALKFAULT | \
 	 OMAP_MMU_IRQ_EMUMISS | \
-	 OMAP_MMU_IRQ_TRANSLATIONFAULT | \
-	 OMAP_MMU_IRQ_TLBMISS)
+	 OMAP_MMU_IRQ_TRANSLATIONFAULT)
 
 static int omap2_mmu_startup(struct omap_mmu *mmu)
 {
@@ -297,6 +298,19 @@ static void omap2_mmu_interrupt(struct omap_mmu *mmu)
 	mmu->fault_address = va;
 	schedule_work(&mmu->irq_work);
 }
+
+static pgprot_t omap2_mmu_pte_get_attr(struct omap_mmu_tlb_entry *entry)
+{
+	u32 attr;
+
+	attr = entry->mixed << 5;
+	attr |= entry->endian;
+	attr |= entry->elsz >> 3;
+	attr <<= ((entry->pgsz & OMAP_MMU_CAM_PAGESIZE_4KB) ? 0:6);
+
+	return attr;
+}
+
 struct omap_mmu_ops omap2_mmu_ops = {
 	.startup	= omap2_mmu_startup,
 	.shutdown	= omap2_mmu_shutdown,
@@ -307,6 +321,7 @@ struct omap_mmu_ops omap2_mmu_ops = {
 	.cam_ram_alloc	= omap2_mmu_cam_ram_alloc,
 	.cam_ram_valid	= omap2_mmu_cam_ram_valid,
 	.interrupt	= omap2_mmu_interrupt,
+	.pte_get_attr	= omap2_mmu_pte_get_attr,
 };
 EXPORT_SYMBOL_GPL(omap2_mmu_ops);
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 6e721fd..cbc82af 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -48,6 +48,7 @@ do {								\
 	(ent)->endian	= OMAP_MMU_RAM_ENDIANNESS_LITTLE;	\
 	(ent)->elsz	= OMAP_MMU_RAM_ELEMENTSIZE_16;		\
 	(ent)->mixed	= 0;					\
+	(ent)->tlb	= 1;					\
 } while (0)
 
 #define INIT_TLB_ENTRY_4KB_PRESERVED(ent,v,p) \
@@ -80,6 +81,7 @@ struct omap_mmu_tlb_entry {
 	unsigned int pgsz, prsvd, valid;
 
 	u32 endian, elsz, mixed;
+	unsigned int tlb;
 };
 
 static inline unsigned long
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 3f572fd..819e4be 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -3,10 +3,12 @@
  *
  * OMAP MMU management framework
  *
- * Copyright (C) 2002-2005 Nokia Corporation
+ * Copyright (C) 2002-2006 Nokia Corporation
  *
  * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *        and Paul Mundt <paul.mundt@nokia.com>
+ *        and Paul Mundt <lethal@linux-sh.org>
+ *
+ * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,6 +61,10 @@
 #define ORDER_64KB	(16 - PAGE_SHIFT)
 #define ORDER_4KB	(12 - PAGE_SHIFT)
 
+#define MMU_CNTL_EMUTLBUPDATE	(1<<3)
+#define MMU_CNTL_TWLENABLE	(1<<2)
+#define MMU_CNTL_MMUENABLE	(1<<1)
+
 static mempool_t *mempool_1M;
 static mempool_t *mempool_64K;
 
@@ -366,7 +372,141 @@ omap_mmu_virt_to_phys(struct omap_mmu *mmu, void *vadr, size_t *len)
 EXPORT_SYMBOL_GPL(omap_mmu_virt_to_phys);
 
 /*
- * MMU operations
+ * PTE operations
+ */
+static inline void
+omap_mmu_alloc_section(struct mm_struct *mm, unsigned long virt,
+		       unsigned long phys, int prot)
+{
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+	if (virt & (1 << SECTION_SHIFT))
+		pmdp++;
+	*pmdp = __pmd((phys & SECTION_MASK) | prot | PMD_TYPE_SECT);
+	flush_pmd_entry(pmdp);
+}
+
+static inline void
+omap_mmu_alloc_supersection(struct mm_struct *mm, unsigned long virt,
+			    unsigned long phys, int prot)
+{
+	int i;
+	for (i = 0; i < 16; i += 1) {
+		omap_mmu_alloc_section(mm, virt, phys, prot | PMD_SECT_SUPER);
+		virt += (PGDIR_SIZE / 2);
+	}
+}
+
+static inline int
+omap_mmu_alloc_page(struct mm_struct *mm, unsigned long virt,
+		    unsigned long phys, pgprot_t prot)
+{
+	pte_t *ptep;
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+
+	if (!(prot & PTE_TYPE_MASK))
+		prot |= PTE_TYPE_SMALL;
+
+	if (pmd_none(*pmdp)) {
+		ptep = pte_alloc_one_kernel(mm, virt);
+		if (ptep == NULL)
+			return -ENOMEM;
+		pmd_populate_kernel(mm, pmdp, ptep);
+	}
+	ptep = pte_offset_kernel(pmdp, virt);
+	ptep -= PTRS_PER_PTE;
+	*ptep = pfn_pte(phys >> PAGE_SHIFT, prot);
+	flush_pmd_entry((pmd_t *)ptep);
+	return 0;
+}
+
+static inline int
+omap_mmu_alloc_largepage(struct mm_struct *mm, unsigned long virt,
+			 unsigned long phys, pgprot_t prot)
+{
+	int i, ret;
+	for (i = 0; i < 16; i += 1) {
+		ret = omap_mmu_alloc_page(mm, virt, phys,
+					  prot | PTE_TYPE_LARGE);
+		if (ret)
+			return -ENOMEM; /* only 1st time */
+		virt += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static int omap_mmu_load_pte(struct omap_mmu *mmu,
+			     struct omap_mmu_tlb_entry *e)
+{
+	int ret = 0;
+	struct mm_struct *mm = mmu->twl_mm;
+	const unsigned long va = e->va;
+	const unsigned long pa = e->pa;
+	const pgprot_t prot = mmu->ops->pte_get_attr(e);
+
+	spin_lock(&mm->page_table_lock);
+
+	switch (e->pgsz) {
+	case OMAP_MMU_CAM_PAGESIZE_16MB:
+		omap_mmu_alloc_supersection(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_1MB:
+		omap_mmu_alloc_section(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_64KB:
+		ret = omap_mmu_alloc_largepage(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_4KB:
+		ret = omap_mmu_alloc_page(mm, va, pa, prot);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	spin_unlock(&mm->page_table_lock);
+
+	return ret;
+}
+
+static void omap_mmu_clear_pte(struct omap_mmu *mmu, unsigned long virt)
+{
+	pte_t *ptep, *end;
+	pmd_t *pmdp;
+	struct mm_struct *mm = mmu->twl_mm;
+
+	spin_lock(&mm->page_table_lock);
+
+	pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+
+	if (pmd_none(*pmdp))
+		goto out;
+
+	if (!pmd_table(*pmdp))
+		goto invalidate_pmd;
+
+	ptep = pte_offset_kernel(pmdp, virt);
+	pte_clear(mm, virt, ptep);
+	flush_pmd_entry((pmd_t *)ptep);
+
+	/* zap pte */
+	end = pmd_page_vaddr(*pmdp);
+	ptep = end - PTRS_PER_PTE;
+	while (ptep < end) {
+		if (!pte_none(*ptep))
+			goto out;
+		ptep++;
+	}
+	pte_free_kernel(pmd_page_vaddr(*pmdp));
+
+ invalidate_pmd:
+	pmd_clear(pmdp);
+	flush_pmd_entry(pmdp);
+ out:
+	spin_lock(&mm->page_table_lock);
+}
+
+/*
+ * TLB operations
  */
 static struct cam_ram_regset *
 omap_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
@@ -539,6 +679,33 @@ static void omap_mmu_gflush(struct omap_mmu *mmu)
 	clk_disable(mmu->clk);
 }
 
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry)
+{
+	int ret = -1;
+	if ((!entry->prsvd) && (mmu->ops->pte_get_attr)) {
+		/*XXX use PG_flag for prsvd */
+		ret = omap_mmu_load_pte(mmu, entry);
+		if (ret)
+			return ret;
+	}
+	if (entry->tlb)
+		ret = omap_mmu_load_tlb_entry(mmu, entry);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_load_pte_entry);
+
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr)
+{
+	int ret = omap_mmu_clear_tlb_entry(mmu, vadr);
+	if (ret)
+		return ret;
+	if (mmu->ops->pte_get_attr)
+		omap_mmu_clear_pte(mmu, vadr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_clear_pte_entry);
+
 /*
  * omap_mmu_exmap()
  *
@@ -680,9 +847,9 @@ found_free:
 	if (status < 0)
 		goto fail;
 
-	/* loading DSP TLB entry */
+	/* loading DSP PTE entry */
 	INIT_TLB_ENTRY(&tlb_ent, _dspadr, _padr, pgsz);
-	status = omap_mmu_load_tlb_entry(mmu, &tlb_ent);
+	status = omap_mmu_load_pte_entry(mmu, &tlb_ent);
 	if (status < 0) {
 		exmap_clear_armmmu((unsigned long)_vadr, unit);
 		goto fail;
@@ -764,8 +931,8 @@ found_map:
 		up_write(&mmu->exmap_sem);
 		return -EINVAL;
 	}
-	/* clearing DSP TLB entry */
-	omap_mmu_clear_tlb_entry(mmu, dspadr);
+	/* clearing DSP PTE entry */
+	omap_mmu_clear_pte_entry(mmu, dspadr);
 
 	/* clear ARM MMU and free buffer */
 	size = unmap_free_arm(ent);
@@ -833,7 +1000,7 @@ void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
 	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, buf, virt);
 	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, dspadr, phys);
-	omap_mmu_load_tlb_entry(mmu, &tlb_ent);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
 }
 EXPORT_SYMBOL_GPL(exmap_setup_preserved_mem_page);
 
@@ -865,10 +1032,18 @@ EXPORT_SYMBOL_GPL(omap_mmu_disable);
 
 void omap_mmu_enable(struct omap_mmu *mmu, int reset)
 {
+	u32 val = MMU_CNTL_MMUENABLE;
+	u32 pa = (u32)virt_to_phys(mmu->twl_mm->pgd);
+
 	if (likely(reset))
 		omap_mmu_reset(mmu);
 
-	omap_mmu_write_reg(mmu, 0x2, MMU_CNTL);
+	if (mmu->ops->pte_get_attr) {
+		omap_mmu_write_reg(mmu, pa, MMU_TTB);
+		val |= MMU_CNTL_TWLENABLE;
+	}
+
+	omap_mmu_write_reg(mmu, val, MMU_CNTL);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_enable);
 
@@ -1282,6 +1457,15 @@ int omap_mmu_register(struct omap_mmu *mmu)
 	if (!mmu->exmap_tbl)
 		return -ENOMEM;
 
+	if (mmu->ops->pte_get_attr) {
+		struct mm_struct *mm =  mm_alloc();
+		if (!mm) {
+			ret = -ENOMEM;
+			goto err_mm_alloc;
+		}
+		mmu->twl_mm = mm;
+	}
+
 	ret = device_register(&mmu->dev);
 	if (unlikely(ret))
 		goto err_dev_register;
@@ -1322,6 +1506,9 @@ err_dev_create_mmu:
 err_mmu_init:
 	device_unregister(&mmu->dev);
 err_dev_register:
+	kfree(mmu->twl_mm);
+	mmu->twl_mm = NULL;
+err_mm_alloc:
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
 	return ret;
@@ -1343,6 +1530,13 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
 
+	if (mmu->ops->pte_get_attr) {
+		if (mmu->twl_mm) {
+			__mmdrop(mmu->twl_mm);
+			mmu->twl_mm = NULL;
+		}
+	}
+
 	device_unregister(&mmu->dev);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_unregister);
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index 62b0fa5..bff433b 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -97,6 +97,9 @@ struct omap_mmu_ops {
 	int (*mem_disable)(struct omap_mmu *, void *);
 
 	void (*interrupt)(struct omap_mmu *);
+
+	/* PTE attribute operations */
+	pgprot_t (*pte_get_attr)(struct omap_mmu_tlb_entry *);
 };
 
 struct omap_mmu {
@@ -117,6 +120,8 @@ struct omap_mmu {
 	unsigned int nr_tlb_entries;
 	unsigned int nr_exmap_preserved;
 
+	struct mm_struct *twl_mm;
+
 	/* Size of virtual address space, in bits */
 	unsigned int addrspace;
 
@@ -178,6 +183,10 @@ void omap_mmu_read_tlb(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock,
 int omap_mmu_load_tlb_entry(struct omap_mmu *, struct omap_mmu_tlb_entry *);
 int omap_mmu_clear_tlb_entry(struct omap_mmu *, unsigned long vadr);
 
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry);
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr);
+
 int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size);
 void omap_mmu_kmem_release(void);
 
diff --git a/include/asm-arm/pgtable.h b/include/asm-arm/pgtable.h
index 7b2bafc..06efc4b 100644
--- a/include/asm-arm/pgtable.h
+++ b/include/asm-arm/pgtable.h
@@ -295,6 +295,7 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
-- 
1.5.1.rc3.30.ga8f4
