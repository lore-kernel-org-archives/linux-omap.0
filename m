From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/2] [OMAP MMU FWK] Translate printk to dev_* and break
	lines with more than 80 char
Date: Thu, 13 Sep 2007 15:21:18 -0400
Message-ID: <11897112792849-git-send-email-edubezval@gmail.com>
References: <11897112792637-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11897112792637-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch:

- Translates printk to dev_*
- Breaks lines with more than 80 columns

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/mmu.c       |   10 ++--
 arch/arm/mach-omap2/mmu.c       |   29 ++++++----
 arch/arm/plat-omap/mmu.c        |  107 +++++++++++++++++++--------------------
 include/asm-arm/arch-omap/mmu.h |   15 ++++--
 4 files changed, 85 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 66aa0d4..baa8c16 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -201,8 +201,8 @@ static int omap1_mmu_startup(struct omap_mmu *mmu)
 {
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		printk(KERN_ERR "MMU: failed to allocate memory "
-				"for dsp vector table\n");
+		dev_err(&mmu->dev, "MMU: failed to allocate memory "
+			"for dsp vector table\n");
 		return -ENOMEM;
 	}
 
@@ -238,13 +238,13 @@ static inline unsigned long omap1_mmu_cam_va(struct cam_ram_regset *cr)
 }
 
 static struct cam_ram_regset *
-omap1_mmu_cam_ram_alloc(struct omap_mmu_tlb_entry *entry)
+omap1_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 {
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		printk(KERN_ERR "MMU: mapping vadr (0x%06lx) is not on an "
-		       "aligned boundary\n", entry->va);
+		dev_err(&mmu->dev, "MMU: mapping vadr (0x%06lx) is not on an "
+			"aligned boundary\n", entry->va);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index d505fb8..a4e7eb5 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -64,7 +64,7 @@ static void exmap_setup_iomap_page(struct omap_mmu *mmu, unsigned long phys,
 
 	dspadr = (IOMAP_VAL << 18) + (dsp_io_adr << 1);
 	virt = omap_mmu_to_virt(mmu, dspadr);
-	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
+	exmap_set_armmmu(mmu, (unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, NULL, virt);
 	INIT_TLB_ENTRY_4KB_ES32_PRESERVED(&tlb_ent, dspadr, phys);
 	omap_mmu_load_pte_entry(mmu, &tlb_ent);
@@ -78,7 +78,7 @@ static void exmap_clear_iomap_page(struct omap_mmu *mmu,
 
 	dspadr = (IOMAP_VAL << 18) + (dsp_io_adr << 1);
 	virt = omap_mmu_to_virt(mmu, dspadr);
-	exmap_clear_armmmu((unsigned long)virt, PAGE_SIZE);
+	exmap_clear_armmmu(mmu, (unsigned long)virt, PAGE_SIZE);
 	/* DSP MMU is shutting down. not handled here. */
 }
 
@@ -153,8 +153,8 @@ static int omap2_mmu_startup(struct omap_mmu *mmu)
 
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		printk(KERN_ERR "MMU: failed to allocate memory "
-				"for dsp vector table\n");
+		dev_err(&mmu->dev, "MMU: failed to allocate memory "
+			"for dsp vector table\n");
 		return -ENOMEM;
 	}
 
@@ -261,13 +261,13 @@ static inline unsigned long omap2_mmu_cam_va(struct cam_ram_regset *cr)
 }
 
 static struct cam_ram_regset *
-omap2_mmu_cam_ram_alloc(struct omap_mmu_tlb_entry *entry)
+omap2_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 {
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		printk(KERN_ERR "MMU: mapping vadr (0x%06lx) is not on an "
-		       "aligned boundary\n", entry->va);
+		dev_err(&mmu->dev, "MMU: mapping vadr (0x%06lx) is not on an "
+			"aligned boundary\n", entry->va);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -292,11 +292,16 @@ static void omap2_mmu_interrupt(struct omap_mmu *mmu)
 	status = MMU_IRQ_MASK & omap_mmu_read_reg(mmu, OMAP_MMU_IRQSTATUS);
 	va = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD);
 
-	pr_info("%s\n", (status & OMAP_MMU_IRQ_MULTIHITFAULT)		? "multi hit":"");
-	pr_info("%s\n", (status & OMAP_MMU_IRQ_TABLEWALKFAULT)		? "table walk fault":"");
-	pr_info("%s\n", (status & OMAP_MMU_IRQ_EMUMISS)			? "EMU miss":"");
-	pr_info("%s\n", (status & OMAP_MMU_IRQ_TRANSLATIONFAULT)	? "translation fault":"");
-	pr_info("%s\n", (status & OMAP_MMU_IRQ_TLBMISS)			? "TLB miss":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_MULTIHITFAULT)?
+		"multi hit":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TABLEWALKFAULT)?
+		"table walk fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_EMUMISS)?
+		"EMU miss":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TRANSLATIONFAULT)?
+		"translation fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TLBMISS)?
+		"TLB miss":"");
 	pr_info("fault address = %#08lx\n", va);
 
 	omap_mmu_disable(mmu);
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 359c2cf..a1487ea 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -115,15 +115,16 @@ int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size)
 
 	/* alignment check */
 	if (!is_aligned(size, SZ_64K)) {
-		printk(KERN_ERR
-		       "omapdsp: size(0x%lx) is not multiple of 64KB.\n", size);
+		dev_err(&mmu->dev,
+			"omapdsp: size(0x%lx) is not multiple of 64KB.\n",
+			size);
 		return -EINVAL;
 	}
 
 	if (size > (1 << mmu->addrspace)) {
-		printk(KERN_ERR
-		       "omapdsp: size(0x%lx) is larger than DSP memory space "
-		       "size (0x%x.\n", size, (1 << mmu->addrspace));
+		dev_err(&mmu->dev,
+			"omapdsp: size(0x%lx) is larger than DSP memory space "
+			"size (0x%x.\n", size, (1 << mmu->addrspace));
 		return -EINVAL;
 	}
 
@@ -197,7 +198,8 @@ static void omap_mmu_free_pages(unsigned long buf, unsigned int order)
 /*
  * ARM MMU operations
  */
-int exmap_set_armmmu(unsigned long virt, unsigned long phys, unsigned long size)
+int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
+		     unsigned long phys, unsigned long size)
 {
 	long off;
 	unsigned long sz_left;
@@ -205,9 +207,9 @@ int exmap_set_armmmu(unsigned long virt, unsigned long phys, unsigned long size)
 	pte_t *ptep;
 	int prot_pmd, prot_pte;
 
-	printk(KERN_DEBUG
-	       "MMU: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
-	       virt, phys, size);
+	dev_dbg(&mmu->dev,
+		"MMU: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
+		virt, phys, size);
 
 	prot_pmd = PMD_TYPE_TABLE | PMD_DOMAIN(DOMAIN_IO);
 	prot_pte = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_WRITE;
@@ -235,15 +237,16 @@ int exmap_set_armmmu(unsigned long virt, unsigned long phys, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(exmap_set_armmmu);
 
-void exmap_clear_armmmu(unsigned long virt, unsigned long size)
+void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
+			unsigned long size)
 {
 	unsigned long sz_left;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	printk(KERN_DEBUG
-	       "MMU: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
-	       virt, size);
+	dev_dbg(&mmu->dev,
+		"MMU: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
+		virt, size);
 
 	for (sz_left = size;
 	     sz_left >= PAGE_SIZE;
@@ -512,7 +515,7 @@ static void omap_mmu_clear_pte(struct omap_mmu *mmu, unsigned long virt)
 static struct cam_ram_regset *
 omap_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 {
-	return mmu->ops->cam_ram_alloc(entry);
+	return mmu->ops->cam_ram_alloc(mmu, entry);
 }
 
 static int omap_mmu_cam_ram_valid(struct omap_mmu *mmu,
@@ -601,7 +604,7 @@ int omap_mmu_load_tlb_entry(struct omap_mmu *mmu,
 found_victim:
 	/* The last entry cannot be locked? */
 	if (lock.victim == (mmu->nr_tlb_entries - 1)) {
-		printk(KERN_ERR "MMU: TLB is full.\n");
+		dev_err(&mmu->dev, "MMU: TLB is full.\n");
 		return -EBUSY;
 	}
 
@@ -738,18 +741,18 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 	 * alignment check
 	 */
 	if (!is_aligned(size, MINIMUM_PAGESZ)) {
-		printk(KERN_ERR
-		       "MMU: size(0x%lx) is not multiple of 4KB.\n", size);
+		dev_err(&mmu->dev,
+			"MMU: size(0x%lx) is not multiple of 4KB.\n", size);
 		return -EINVAL;
 	}
 	if (!is_aligned(dspadr, MINIMUM_PAGESZ)) {
-		printk(KERN_ERR
-		       "MMU: DSP address(0x%lx) is not aligned.\n", dspadr);
+		dev_err(&mmu->dev,
+			"MMU: DSP address(0x%lx) is not aligned.\n", dspadr);
 		return -EINVAL;
 	}
 	if (!is_aligned(padr, MINIMUM_PAGESZ)) {
-		printk(KERN_ERR
-		       "MMU: physical address(0x%lx) is not aligned.\n",
+		dev_err(&mmu->dev,
+			"MMU: physical address(0x%lx) is not aligned.\n",
 		       padr);
 		return -EINVAL;
 	}
@@ -757,8 +760,8 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 	/* address validity check */
 	if ((dspadr < mmu->memsize) ||
 	    (dspadr >= (1 << mmu->addrspace))) {
-		printk(KERN_ERR
-		       "MMU: illegal address/size for %s().\n",
+		dev_err(&mmu->dev,
+			"MMU: illegal address/size for %s().\n",
 		       __FUNCTION__);
 		return -EINVAL;
 	}
@@ -774,7 +777,7 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 		mapsize = 1 << (tmp_ent->order + PAGE_SHIFT);
 		if ((_vadr + size > tmp_ent->vadr) &&
 		    (_vadr < tmp_ent->vadr + mapsize)) {
-			printk(KERN_ERR "MMU: exmap page overlap!\n");
+			dev_err(&mmu->dev, "MMU: exmap page overlap!\n");
 			up_write(&mmu->exmap_sem);
 			return -EINVAL;
 		}
@@ -787,7 +790,7 @@ start:
 		if (!mmu->exmap_tbl[idx].valid)
 			goto found_free;
 
-	printk(KERN_ERR "MMU: DSP TLB is full.\n");
+	dev_err(&mmu->dev, "MMU: DSP TLB is full.\n");
 	status = -EBUSY;
 	goto fail;
 
@@ -842,7 +845,7 @@ found_free:
 	 * we should not access to the allocated memory through 'buf'
 	 * since this area should not be cached.
 	 */
-	status = exmap_set_armmmu((unsigned long)_vadr, _padr, unit);
+	status = exmap_set_armmmu(mmu, (unsigned long)_vadr, _padr, unit);
 	if (status < 0)
 		goto fail;
 
@@ -850,7 +853,7 @@ found_free:
 	INIT_TLB_ENTRY(&tlb_ent, _dspadr, _padr, pgsz);
 	status = omap_mmu_load_pte_entry(mmu, &tlb_ent);
 	if (status < 0) {
-		exmap_clear_armmmu((unsigned long)_vadr, unit);
+		exmap_clear_armmmu(mmu, (unsigned long)_vadr, unit);
 		goto fail;
 	}
 
@@ -879,20 +882,20 @@ fail:
 }
 EXPORT_SYMBOL_GPL(omap_mmu_exmap);
 
-static unsigned long unmap_free_arm(struct exmap_tbl *ent)
+static unsigned long unmap_free_arm(struct omap_mmu *mmu,
+				    struct exmap_tbl *ent)
 {
 	unsigned long size;
 
 	/* clearing ARM MMU */
 	size = 1 << (ent->order + PAGE_SHIFT);
-	exmap_clear_armmmu((unsigned long)ent->vadr, size);
+	exmap_clear_armmmu(mmu, (unsigned long)ent->vadr, size);
 
 	/* freeing allocated memory */
 	if (ent->type == EXMAP_TYPE_MEM) {
 		omap_mmu_free_pages((unsigned long)ent->buf, ent->order);
-		printk(KERN_DEBUG
-		       "MMU: freeing 0x%lx bytes @ adr 0x%8p\n",
-		       size, ent->buf);
+		dev_dbg(&mmu->dev, "MMU: freeing 0x%lx bytes @ adr 0x%8p\n",
+			size, ent->buf);
 	}
 
 	ent->valid = 0;
@@ -917,16 +920,15 @@ int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long dspadr)
 			goto found_map;
 	}
 	up_write(&mmu->exmap_sem);
-	printk(KERN_WARNING
-	       "MMU: address %06lx not found in exmap_tbl.\n", dspadr);
+	dev_warn(&mmu->dev, "MMU: address %06lx not found in exmap_tbl.\n",
+		 dspadr);
 	return -EINVAL;
 
 found_map:
 	if (ent->usecount > 0) {
-		printk(KERN_ERR
-		       "MMU: exmap reference count is not 0.\n"
-		       "   idx=%d, vadr=%p, order=%d, usecount=%d\n",
-		       idx, ent->vadr, ent->order, ent->usecount);
+		dev_err(&mmu->dev, "MMU: exmap reference count is not 0.\n"
+			"   idx=%d, vadr=%p, order=%d, usecount=%d\n",
+			idx, ent->vadr, ent->order, ent->usecount);
 		up_write(&mmu->exmap_sem);
 		return -EINVAL;
 	}
@@ -934,7 +936,7 @@ found_map:
 	omap_mmu_clear_pte_entry(mmu, dspadr);
 
 	/* clear ARM MMU and free buffer */
-	size = unmap_free_arm(ent);
+	size = unmap_free_arm(mmu, ent);
 	total += size;
 
 	/* we don't free PTEs */
@@ -952,10 +954,9 @@ found_map:
 	if (ent->vadr == vadr)
 		goto found_map;	/* continue */
 
-	printk(KERN_ERR
-	       "MMU: illegal exmap_tbl grouping!\n"
-	       "expected vadr = %p, exmap_tbl[%d].vadr = %p\n",
-	       vadr, idx, ent->vadr);
+	dev_err(&mmu->dev, "MMU: illegal exmap_tbl grouping!\n"
+		"expected vadr = %p, exmap_tbl[%d].vadr = %p\n",
+		vadr, idx, ent->vadr);
 	up_write(&mmu->exmap_sem);
 	return -EINVAL;
 
@@ -976,7 +977,7 @@ void omap_mmu_exmap_flush(struct omap_mmu *mmu)
 
 	omap_mmu_for_each_tlb_entry(mmu, ent)
 		if (ent->valid && !ent->prsvd)
-			unmap_free_arm(ent);
+			unmap_free_arm(mmu, ent);
 
 	/* flush TLB */
 	if (likely(mmu->membase))
@@ -996,7 +997,7 @@ void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
 
 	phys = __pa(buf);
 	virt = omap_mmu_to_virt(mmu, dspadr);
-	exmap_set_armmmu((unsigned long)virt, phys, PAGE_SIZE);
+	exmap_set_armmmu(mmu, (unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, buf, virt);
 	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, dspadr, phys);
 	omap_mmu_load_pte_entry(mmu, &tlb_ent);
@@ -1007,7 +1008,7 @@ void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long dspadr)
 {
 	void *virt = omap_mmu_to_virt(mmu, dspadr);
 
-	exmap_clear_armmmu((unsigned long)virt, PAGE_SIZE);
+	exmap_clear_armmmu(mmu, (unsigned long)virt, PAGE_SIZE);
 	/* DSP MMU is shutting down. not handled here. */
 }
 EXPORT_SYMBOL_GPL(exmap_clear_mem_page);
@@ -1073,8 +1074,8 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
 			  mmu->name,  mmu);
 	if (ret < 0) {
-		printk(KERN_ERR
-		       "failed to register MMU interrupt: %d\n", ret);
+		dev_err(&mmu->dev, "failed to register MMU interrupt: %d\n",
+			ret);
 		goto fail;
 	}
 
@@ -1164,9 +1165,8 @@ static ssize_t exmem_read(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		printk(KERN_ERR
-		       "MMU: DSP address %08lx / size %08x "
-		       "is not valid!\n", p, count);
+		dev_err(&mmu->dev, "MMU: DSP address %08lx / size %08x "
+			"is not valid!\n", p, count);
 		return -EFAULT;
 	}
 	if (count > (1 << mmu->addrspace) - p)
@@ -1232,9 +1232,8 @@ static ssize_t exmem_write(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		printk(KERN_ERR
-		       "MMU: DSP address %08lx / size %08x "
-		       "is not valid!\n", p, count);
+		dev_err(&mmu->dev, "MMU: DSP address %08lx / size %08x "
+			"is not valid!\n", p, count);
 		return -EFAULT;
 	}
 	if (count > (1 << mmu->addrspace) - p)
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index eec5696..6c5869c 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -69,7 +69,8 @@ struct omap_mmu_ops {
 	ssize_t (*show)(struct omap_mmu *, char *, struct omap_mmu_tlb_lock *);
 
 	/* CAM / RAM operations */
-	struct cam_ram_regset *(*cam_ram_alloc)(struct omap_mmu_tlb_entry *);
+	struct cam_ram_regset *(*cam_ram_alloc)(struct omap_mmu *,
+						struct omap_mmu_tlb_entry *);
 	int (*cam_ram_valid)(struct cam_ram_regset *);
 	unsigned long (*cam_va)(struct cam_ram_regset *);
 
@@ -182,15 +183,19 @@ void omap_mmu_exmap_flush(struct omap_mmu *mmu);
 void omap_mmu_exmap_use(struct omap_mmu *mmu, void *vadr, size_t len);
 void omap_mmu_exmap_unuse(struct omap_mmu *mmu, void *vadr, size_t len);
 
-int exmap_set_armmmu(unsigned long virt, unsigned long phys, unsigned long size);
-void exmap_clear_armmmu(unsigned long virt, unsigned long size);
+int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
+		     unsigned long phys, unsigned long size);
+void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
+			unsigned long size);
 void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
 				    unsigned long dspadr, int index);
 void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long dspadr);
 int exmap_valid(struct omap_mmu *mmu, void *vadr, size_t len);
 
 /* To be obsolete for backward compatibility */
-ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, struct bin_attribute *, char *buf, loff_t offset, size_t count);
-ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, struct bin_attribute *, char *buf, loff_t offset, size_t count);
+ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, struct bin_attribute *,
+			    char *buf, loff_t offset, size_t count);
+ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, struct bin_attribute *,
+			    char *buf, loff_t offset, size_t count);
 
 #endif /* __ARCH_OMAP_MMU_H */
-- 
1.5.3.rc6.17.g1911
