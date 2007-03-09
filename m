From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] OMAP: Add TWL support for omap mmu framework
Date: Fri,  9 Mar 2007 19:53:55 +0200
Message-ID: <11734628353340-git-send-email-Hiroshi.DOYU@nokia.com>
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

This enables MMU hardware page table walk and can be used for DSP,
IVA?, CAMERA devices.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.h       |    2 +-
 arch/arm/mach-omap2/mmu.c       |   26 ++++++-
 arch/arm/mach-omap2/mmu.h       |    2 +-
 arch/arm/plat-omap/mmu.c        |  147 +++++++++++++++++++++++++++++++++++++--
 include/asm-arm/arch-omap/mmu.h |   12 +++
 5 files changed, 177 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 3acbb84..74542e4 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -110,7 +110,7 @@ omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
 	return __raw_readw(mmu->base + reg);
 }
 
-static void omap_mmu_write_reg(struct omap_mmu *mmu,
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 			       unsigned short val, unsigned long reg)
 {
 	__raw_writew(val, mmu->base + reg);
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index be8764d..a66ee0d 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -63,7 +63,7 @@ static void exmap_setup_iomap_page(struct omap_mmu *mmu, unsigned long phys,
 	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, NULL, virt);
 	INIT_TLB_ENTRY_4KB_ES32_PRESERVED(&tlb_ent, dspadr, phys);
-	omap_mmu_load_tlb_entry(mmu, &tlb_ent);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
 }
 
 static void exmap_clear_iomap_page(struct omap_mmu *mmu,
@@ -137,8 +137,7 @@ static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
 	(OMAP_MMU_IRQ_MULTIHITFAULT | \
 	 OMAP_MMU_IRQ_TABLEWALKFAULT | \
 	 OMAP_MMU_IRQ_EMUMISS | \
-	 OMAP_MMU_IRQ_TRANSLATIONFAULT | \
-	 OMAP_MMU_IRQ_TLBMISS)
+	 OMAP_MMU_IRQ_TRANSLATIONFAULT)
 
 static int omap2_mmu_startup(struct omap_mmu *mmu)
 {
@@ -276,6 +275,26 @@ static inline int omap2_mmu_cam_ram_valid(struct cam_ram_regset *cr)
 	return cr->cam & OMAP_MMU_CAM_V;
 }
 
+static u32 omap2_mmu_pte_attr(struct omap_mmu_tlb_entry *e)
+{
+	u32 val, attr;
+	const unsigned int pgsz = e->pgsz;
+
+	attr = e->mixed << 5;
+	attr |= e->endian;
+	attr |= e->elsz >> 3;
+	attr <<= (istwll2(pgsz)? 0:6);
+
+	/* 64KB? */
+	val = (istwll2(pgsz) && istwllarge(pgsz)) ? 1:2;
+	/* 16MB? */
+	val |= ((!istwll2(pgsz) && istwllarge(pgsz)) ? (1<<18):0);
+
+	BUG_ON(attr&val);
+	val |= attr;
+	return val;
+}
+
 struct omap_mmu_ops omap2_mmu_ops = {
 	.startup	= omap2_mmu_startup,
 	.shutdown	= omap2_mmu_shutdown,
@@ -285,6 +304,7 @@ struct omap_mmu_ops omap2_mmu_ops = {
 	.cam_va		= omap2_mmu_cam_va,
 	.cam_ram_alloc	= omap2_mmu_cam_ram_alloc,
 	.cam_ram_valid	= omap2_mmu_cam_ram_valid,
+	.pte_attr	= omap2_mmu_pte_attr,
 };
 EXPORT_SYMBOL_GPL(omap2_mmu_ops);
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 56b7055..3f8d950 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -88,7 +88,7 @@ omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
 	return __raw_readl(mmu->base + reg);
 }
 
-static void omap_mmu_write_reg(struct omap_mmu *mmu,
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 			       unsigned long val, unsigned long reg)
 {
 	__raw_writel(val, mmu->base + reg);
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index a7c0642..0cac9e6 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -8,6 +8,8 @@
  * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
  *        and Paul Mundt <paul.mundt@nokia.com>
  *
+ * Added TWL support by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -58,6 +60,20 @@
 #define ORDER_64KB	(16 - PAGE_SHIFT)
 #define ORDER_4KB	(12 - PAGE_SHIFT)
 
+#define NUM4KBIN64KB	(ORDER_64KB - ORDER_4KB)
+#define NUM1MBIN16MB	(NUM4KBIN64KB)
+#define TWLL1INX_OFFSET 20
+#define TWLL2INX_OFFSET 12
+#define TWLL2INX_SIZE	8
+#define NUMTWL1TBLENT	4096
+#define TWL1TBLSZ	(4*NUMTWL1TBLENT)
+#define NUMTWL2TBLENT	256
+#define TWL2TBLSZ	(4*NUMTWL2TBLENT)
+
+#define MMU_CNTL_EMUTLBUPDATE	(1<<3)
+#define MMU_CNTL_TWLENABLE	(1<<2)
+#define MMU_CNTL_MMUENABLE	(1<<1)
+
 static mempool_t *mempool_1M;
 static mempool_t *mempool_64K;
 
@@ -365,7 +381,75 @@ omap_mmu_virt_to_phys(struct omap_mmu *mmu, void *vadr, size_t *len)
 EXPORT_SYMBOL_GPL(omap_mmu_virt_to_phys);
 
 /*
- * MMU operations
+ * PTE operations
+ */
+static int omap_mmu_load_pte(struct omap_mmu *mmu,
+			     struct omap_mmu_tlb_entry *e)
+{
+	u32 val, num, pa, pa_offset;
+	u32 *pte = (u32 *)mmu->twl_tbl + (e->va >> TWLL1INX_OFFSET);
+
+	/* L2? */
+	if (istwll2(e->pgsz)) {
+		u32 *l2v;
+		if (*pte) {
+			if (((*pte)&3) != 1)
+				return -EBADSLT;
+			l2v = (u32 *)phys_to_virt((*pte) & ~((1<<TWLL2INX_OFFSET) - 1));
+		} else {
+			u32 temp;
+			l2v = kzalloc(TWL2TBLSZ, GFP_KERNEL);
+			if (!l2v)
+				return -ENOMEM;
+			temp = virt_to_phys(l2v);
+			temp |= 1; /* mark page */
+			*pte = temp;
+		}
+		/* Shift L2 entry */
+		l2v += ((e->va >> TWLL2INX_OFFSET) & ((1<<TWLL2INX_SIZE)-1));
+		pte = l2v;
+	}
+
+	pa_offset = istwll2(e->pgsz)? TWLL2INX_OFFSET:TWLL1INX_OFFSET;
+	pa = e->pa & ~((1<<pa_offset) - 1);
+
+	val = mmu->ops->pte_attr(e);
+
+	BUG_ON(val&pa);
+
+	val |= pa;
+
+	num = istwllarge(e->pgsz) ? NUM4KBIN64KB:1;/* same as NUM1MBIN16MB */
+	while (num--)
+		*pte++ = val;
+
+	return 0;
+}
+
+static int omap_mmu_clear_pte(struct omap_mmu *mmu, unsigned long vadr)
+{
+	u32 val, num;
+	u32 *pte = (u32 *)mmu->twl_tbl + (vadr >> TWLL1INX_OFFSET);
+
+	val = *pte;
+	if (cpu_is_omap24xx()) /* XXX mach ops? */
+		num = (val&(1<<18)) ? NUM1MBIN16MB:1;
+
+	/* L2? */
+	if ((val&0x3) == 1) {
+		pte = (u32 *)phys_to_virt((*pte) & ~((1<<TWLL2INX_OFFSET) - 1));
+		pte += ((vadr >> TWLL2INX_OFFSET) & ((1<<TWLL2INX_SIZE)-1));
+		val = *pte;
+		num = (val&2) ? NUM4KBIN64KB:1;/* same as NUM1MBIN16MB */
+	}
+
+	while (num--)
+		*pte++ = 0;
+	return 0;
+}
+
+/*
+ * TLB operations
  */
 static struct cam_ram_regset *
 omap_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
@@ -538,6 +622,37 @@ static void omap_mmu_gflush(struct omap_mmu *mmu)
 	clk_disable(mmu->clk);
 }
 
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry)
+{
+	int ret;
+	if (mmu->ops->pte_attr) {
+		ret = omap_mmu_load_pte(mmu, entry);
+		if (ret)
+			return ret;
+	}
+	ret = omap_mmu_load_tlb_entry(mmu, entry);
+	if (ret)
+		return ret;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_load_pte_entry);
+
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr)
+{
+	int ret;
+	if (mmu->ops->pte_attr) {
+		ret = omap_mmu_clear_pte(mmu, vadr);
+		if (ret)
+			return ret;
+	}
+	ret = omap_mmu_clear_tlb_entry(mmu, vadr);
+	if (ret)
+		return ret;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_clear_pte_entry);
+
 /*
  * omap_mmu_exmap()
  *
@@ -679,9 +794,9 @@ found_free:
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
@@ -763,8 +878,8 @@ found_map:
 		up_write(&mmu->exmap_sem);
 		return -EINVAL;
 	}
-	/* clearing DSP TLB entry */
-	omap_mmu_clear_tlb_entry(mmu, dspadr);
+	/* clearing DSP PTE entry */
+	omap_mmu_clear_pte_entry(mmu, dspadr);
 
 	/* clear ARM MMU and free buffer */
 	size = unmap_free_arm(ent);
@@ -832,7 +947,7 @@ void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
 	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, buf, virt);
 	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, dspadr, phys);
-	omap_mmu_load_tlb_entry(mmu, &tlb_ent);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
 }
 EXPORT_SYMBOL_GPL(exmap_setup_preserved_mem_page);
 
@@ -864,10 +979,19 @@ EXPORT_SYMBOL_GPL(omap_mmu_disable);
 
 void omap_mmu_enable(struct omap_mmu *mmu, int reset)
 {
+	u32 pa = (u32)virt_to_phys(mmu->twl_tbl);
+	BUG_ON(!is_aligned(pa, TWL1TBLSZ));
+
 	if (likely(reset))
 		omap_mmu_reset(mmu);
 
-	omap_mmu_write_reg(mmu, 0x2, MMU_CNTL);
+	omap_mmu_write_reg(mmu,
+			   pa,
+			   MMU_TTB);
+
+	omap_mmu_write_reg(mmu,
+			   (MMU_CNTL_TWLENABLE | MMU_CNTL_MMUENABLE),
+			   MMU_CNTL);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_enable);
 
@@ -1261,6 +1385,12 @@ int omap_mmu_register(struct omap_mmu *mmu)
 	if (!mmu->exmap_tbl)
 		return -ENOMEM;
 
+	mmu->twl_tbl = kzalloc(TWL1TBLSZ, GFP_KERNEL);
+	if (!mmu->twl_tbl) {
+		ret = -ENOMEM;
+		goto err_alloc_twl;
+	}
+
 	ret = device_register(&mmu->dev);
 	if (unlikely(ret))
 		goto err_dev_register;
@@ -1301,6 +1431,8 @@ err_dev_create_mmu:
 err_mmu_init:
 	device_unregister(&mmu->dev);
 err_dev_register:
+	kfree(mmu->twl_tbl);
+err_alloc_twl:
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
 	return ret;
@@ -1321,6 +1453,7 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
+	kfree(mmu->twl_tbl);
 
 	device_unregister(&mmu->dev);
 }
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index dd2a09a..38547ef 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -94,6 +94,9 @@ struct omap_mmu_ops {
 	/* Memory operations */
 	int (*mem_enable)(struct omap_mmu *, void *);
 	int (*mem_disable)(struct omap_mmu *, void *);
+
+	/* PTE attribute operations */
+	u32 (*pte_attr)(struct omap_mmu_tlb_entry *);
 };
 
 struct omap_mmu {
@@ -114,6 +117,8 @@ struct omap_mmu {
 	unsigned int nr_tlb_entries;
 	unsigned int nr_exmap_preserved;
 
+	unsigned long *twl_tbl;
+
 	/* Size of virtual address space, in bits */
 	unsigned int addrspace;
 
@@ -150,6 +155,9 @@ do {							\
 	(ent)->link.prev	= -1;			\
 } while (0)
 
+#define istwllarge(x)	(x&1)
+#define istwll2(x)	((x&1)^(x>>1))
+
 #define omap_mmu_to_virt(mmu, db)	((void *)((mmu)->membase + (db)))
 #define virt_to_omap_mmu(mmu, va) \
 	(((unsigned long)(va) - (mmu)->membase))
@@ -170,6 +178,10 @@ void omap_mmu_read_tlb(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock,
 int omap_mmu_load_tlb_entry(struct omap_mmu *, struct omap_mmu_tlb_entry *);
 int omap_mmu_clear_tlb_entry(struct omap_mmu *, unsigned long vadr);
 
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry);
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr);
+
 int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size);
 void omap_mmu_kmem_release(void);
 
-- 
1.5.0.3.271.g5ced
