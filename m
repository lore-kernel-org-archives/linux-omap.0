From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/2] [OMAP MMU FWK] Improve debug messages and removed DSP
	references from MMU FW code
Date: Thu, 13 Sep 2007 15:21:19 -0400
Message-ID: <11897112793147-git-send-email-edubezval@gmail.com>
References: <11897112792637-git-send-email-edubezval@gmail.com>
	<11897112792849-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11897112792849-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

 As the code is expected to work with another mmu other than DSP mmu; "DSP"
string was removed from the code in the following situations:

- Debug messages
- Local variables name
- Comments

 Another improvement is done for debug messages. The MMU name is printed
in debug messages.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/mmu.c |    8 ++--
 arch/arm/mach-omap2/mmu.c |    8 ++--
 arch/arm/plat-omap/mmu.c  |  116 +++++++++++++++++++++++----------------------
 3 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index baa8c16..f1b682a 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -201,8 +201,8 @@ static int omap1_mmu_startup(struct omap_mmu *mmu)
 {
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		dev_err(&mmu->dev, "MMU: failed to allocate memory "
-			"for dsp vector table\n");
+		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+			"for vector table\n", mmu->name);
 		return -ENOMEM;
 	}
 
@@ -243,8 +243,8 @@ omap1_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		dev_err(&mmu->dev, "MMU: mapping vadr (0x%06lx) is not on an "
-			"aligned boundary\n", entry->va);
+		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+			" an aligned boundary\n", mmu->name, entry->va);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index a4e7eb5..08fbe6b 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -153,8 +153,8 @@ static int omap2_mmu_startup(struct omap_mmu *mmu)
 
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		dev_err(&mmu->dev, "MMU: failed to allocate memory "
-			"for dsp vector table\n");
+		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+			"for vector table\n", mmu->name);
 		return -ENOMEM;
 	}
 
@@ -266,8 +266,8 @@ omap2_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		dev_err(&mmu->dev, "MMU: mapping vadr (0x%06lx) is not on an "
-			"aligned boundary\n", entry->va);
+		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+			" an aligned boundary\n", mmu->name, entry->va);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index a1487ea..890a9c8 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -116,15 +116,16 @@ int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size)
 	/* alignment check */
 	if (!is_aligned(size, SZ_64K)) {
 		dev_err(&mmu->dev,
-			"omapdsp: size(0x%lx) is not multiple of 64KB.\n",
-			size);
+			"MMU %s: size(0x%lx) is not multiple of 64KB.\n",
+			mmu->name, size);
 		return -EINVAL;
 	}
 
 	if (size > (1 << mmu->addrspace)) {
 		dev_err(&mmu->dev,
-			"omapdsp: size(0x%lx) is larger than DSP memory space "
-			"size (0x%x.\n", size, (1 << mmu->addrspace));
+			"MMU %s: size(0x%lx) is larger than external device "
+			" memory space size (0x%x.\n", mmu->name, size,
+			(1 << mmu->addrspace));
 		return -EINVAL;
 	}
 
@@ -208,8 +209,8 @@ int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
 	int prot_pmd, prot_pte;
 
 	dev_dbg(&mmu->dev,
-		"MMU: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
-		virt, phys, size);
+		"MMU %s: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
+		mmu->name, virt, phys, size);
 
 	prot_pmd = PMD_TYPE_TABLE | PMD_DOMAIN(DOMAIN_IO);
 	prot_pte = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_WRITE;
@@ -245,8 +246,8 @@ void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
 	pte_t *ptep;
 
 	dev_dbg(&mmu->dev,
-		"MMU: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
-		virt, size);
+		"MMU %s: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
+		mmu->name, virt, size);
 
 	for (sz_left = size;
 	     sz_left >= PAGE_SIZE;
@@ -604,7 +605,7 @@ int omap_mmu_load_tlb_entry(struct omap_mmu *mmu,
 found_victim:
 	/* The last entry cannot be locked? */
 	if (lock.victim == (mmu->nr_tlb_entries - 1)) {
-		dev_err(&mmu->dev, "MMU: TLB is full.\n");
+		dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
 		return -EBUSY;
 	}
 
@@ -712,13 +713,13 @@ EXPORT_SYMBOL_GPL(omap_mmu_clear_pte_entry);
  * omap_mmu_exmap()
  *
  * MEM_IOCTL_EXMAP ioctl calls this function with padr=0.
- * In this case, the buffer for DSP is allocated in this routine,
+ * In this case, the buffer for external device is allocated in this routine,
  * then it is mapped.
  * On the other hand, for example - frame buffer sharing, calls
  * this function with padr set. It means some known address space
- * pointed with padr is going to be shared with DSP.
+ * pointed with padr is going to be shared with external device.
  */
-int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
+int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long devadr,
 		   unsigned long padr, unsigned long size,
 		   enum exmap_type type)
 {
@@ -727,9 +728,9 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 	unsigned int order = 0;
 	unsigned long unit;
 	int prev = -1;
-	unsigned long _dspadr = dspadr;
+	unsigned long _devadr = devadr;
 	unsigned long _padr = padr;
-	void *_vadr = omap_mmu_to_virt(mmu, dspadr);
+	void *_vadr = omap_mmu_to_virt(mmu, devadr);
 	unsigned long _size = size;
 	struct omap_mmu_tlb_entry tlb_ent;
 	struct exmap_tbl *exmap_ent, *tmp_ent;
@@ -742,27 +743,29 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 	 */
 	if (!is_aligned(size, MINIMUM_PAGESZ)) {
 		dev_err(&mmu->dev,
-			"MMU: size(0x%lx) is not multiple of 4KB.\n", size);
+			"MMU %s: size(0x%lx) is not multiple of 4KB.\n",
+			mmu->name, size);
 		return -EINVAL;
 	}
-	if (!is_aligned(dspadr, MINIMUM_PAGESZ)) {
+	if (!is_aligned(devadr, MINIMUM_PAGESZ)) {
 		dev_err(&mmu->dev,
-			"MMU: DSP address(0x%lx) is not aligned.\n", dspadr);
+			"MMU %s: external device address(0x%lx) is not"
+			" aligned.\n", mmu->name, devadr);
 		return -EINVAL;
 	}
 	if (!is_aligned(padr, MINIMUM_PAGESZ)) {
 		dev_err(&mmu->dev,
-			"MMU: physical address(0x%lx) is not aligned.\n",
-		       padr);
+			"MMU %s: physical address(0x%lx) is not aligned.\n",
+			mmu->name, padr);
 		return -EINVAL;
 	}
 
 	/* address validity check */
-	if ((dspadr < mmu->memsize) ||
-	    (dspadr >= (1 << mmu->addrspace))) {
+	if ((devadr < mmu->memsize) ||
+	    (devadr >= (1 << mmu->addrspace))) {
 		dev_err(&mmu->dev,
-			"MMU: illegal address/size for %s().\n",
-		       __FUNCTION__);
+			"MMU %s: illegal address/size for %s().\n",
+			mmu->name, __FUNCTION__);
 		return -EINVAL;
 	}
 
@@ -777,7 +780,8 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
 		mapsize = 1 << (tmp_ent->order + PAGE_SHIFT);
 		if ((_vadr + size > tmp_ent->vadr) &&
 		    (_vadr < tmp_ent->vadr + mapsize)) {
-			dev_err(&mmu->dev, "MMU: exmap page overlap!\n");
+			dev_err(&mmu->dev, "MMU %s: exmap page overlap!\n",
+				mmu->name);
 			up_write(&mmu->exmap_sem);
 			return -EINVAL;
 		}
@@ -790,7 +794,7 @@ start:
 		if (!mmu->exmap_tbl[idx].valid)
 			goto found_free;
 
-	dev_err(&mmu->dev, "MMU: DSP TLB is full.\n");
+	dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
 	status = -EBUSY;
 	goto fail;
 
@@ -799,12 +803,12 @@ found_free:
 
 	if ((_size >= SZ_1M) &&
 	    (is_aligned(_padr, SZ_1M) || (padr == 0)) &&
-	    is_aligned(_dspadr, SZ_1M)) {
+	    is_aligned(_devadr, SZ_1M)) {
 		unit = SZ_1M;
 		pgsz = OMAP_MMU_CAM_PAGESIZE_1MB;
 	} else if ((_size >= SZ_64K) &&
 		   (is_aligned(_padr, SZ_64K) || (padr == 0)) &&
-		   is_aligned(_dspadr, SZ_64K)) {
+		   is_aligned(_devadr, SZ_64K)) {
 		unit = SZ_64K;
 		pgsz = OMAP_MMU_CAM_PAGESIZE_64KB;
 	} else {
@@ -849,8 +853,8 @@ found_free:
 	if (status < 0)
 		goto fail;
 
-	/* loading DSP PTE entry */
-	INIT_TLB_ENTRY(&tlb_ent, _dspadr, _padr, pgsz);
+	/* loading external device PTE entry */
+	INIT_TLB_ENTRY(&tlb_ent, _devadr, _padr, pgsz);
 	status = omap_mmu_load_pte_entry(mmu, &tlb_ent);
 	if (status < 0) {
 		exmap_clear_armmmu(mmu, (unsigned long)_vadr, unit);
@@ -867,7 +871,7 @@ found_free:
 		return size;
 	}
 
-	_dspadr += unit;
+	_devadr += unit;
 	_vadr   += unit;
 	_padr = padr ? _padr + unit : 0;
 	prev = idx;
@@ -877,7 +881,7 @@ fail:
 	up_write(&mmu->exmap_sem);
 	if (buf)
 		omap_mmu_free_pages((unsigned long)buf, order);
-	omap_mmu_exunmap(mmu, dspadr);
+	omap_mmu_exunmap(mmu, devadr);
 	return status;
 }
 EXPORT_SYMBOL_GPL(omap_mmu_exmap);
@@ -894,15 +898,15 @@ static unsigned long unmap_free_arm(struct omap_mmu *mmu,
 	/* freeing allocated memory */
 	if (ent->type == EXMAP_TYPE_MEM) {
 		omap_mmu_free_pages((unsigned long)ent->buf, ent->order);
-		dev_dbg(&mmu->dev, "MMU: freeing 0x%lx bytes @ adr 0x%8p\n",
-			size, ent->buf);
+		dev_dbg(&mmu->dev, "MMU %s: freeing 0x%lx bytes @ adr 0x%8p\n",
+			mmu->name, size, ent->buf);
 	}
 
 	ent->valid = 0;
 	return size;
 }
 
-int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long dspadr)
+int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long devadr)
 {
 	void *vadr;
 	unsigned long size;
@@ -910,7 +914,7 @@ int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long dspadr)
 	struct exmap_tbl *ent;
 	int idx;
 
-	vadr = omap_mmu_to_virt(mmu, dspadr);
+	vadr = omap_mmu_to_virt(mmu, devadr);
 	down_write(&mmu->exmap_sem);
 	for (idx = 0; idx < mmu->nr_tlb_entries; idx++) {
 		ent = mmu->exmap_tbl + idx;
@@ -920,20 +924,20 @@ int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long dspadr)
 			goto found_map;
 	}
 	up_write(&mmu->exmap_sem);
-	dev_warn(&mmu->dev, "MMU: address %06lx not found in exmap_tbl.\n",
-		 dspadr);
+	dev_warn(&mmu->dev, "MMU %s: address %06lx not found in exmap_tbl.\n",
+		 mmu->name, devadr);
 	return -EINVAL;
 
 found_map:
 	if (ent->usecount > 0) {
-		dev_err(&mmu->dev, "MMU: exmap reference count is not 0.\n"
+		dev_err(&mmu->dev, "MMU %s: exmap reference count is not 0.\n"
 			"   idx=%d, vadr=%p, order=%d, usecount=%d\n",
-			idx, ent->vadr, ent->order, ent->usecount);
+			mmu->name, idx, ent->vadr, ent->order, ent->usecount);
 		up_write(&mmu->exmap_sem);
 		return -EINVAL;
 	}
-	/* clearing DSP PTE entry */
-	omap_mmu_clear_pte_entry(mmu, dspadr);
+	/* clearing external device PTE entry */
+	omap_mmu_clear_pte_entry(mmu, devadr);
 
 	/* clear ARM MMU and free buffer */
 	size = unmap_free_arm(mmu, ent);
@@ -949,14 +953,14 @@ found_map:
 	if (idx < 0)
 		goto up_out;	/* normal completion */
 	ent = mmu->exmap_tbl + idx;
-	dspadr += size;
+	devadr += size;
 	vadr   += size;
 	if (ent->vadr == vadr)
 		goto found_map;	/* continue */
 
-	dev_err(&mmu->dev, "MMU: illegal exmap_tbl grouping!\n"
+	dev_err(&mmu->dev, "MMU %s: illegal exmap_tbl grouping!\n"
 		"expected vadr = %p, exmap_tbl[%d].vadr = %p\n",
-		vadr, idx, ent->vadr);
+		mmu->name, vadr, idx, ent->vadr);
 	up_write(&mmu->exmap_sem);
 	return -EINVAL;
 
@@ -989,24 +993,24 @@ void omap_mmu_exmap_flush(struct omap_mmu *mmu)
 EXPORT_SYMBOL_GPL(omap_mmu_exmap_flush);
 
 void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
-				    unsigned long dspadr, int index)
+				    unsigned long devadr, int index)
 {
 	unsigned long phys;
 	void *virt;
 	struct omap_mmu_tlb_entry tlb_ent;
 
 	phys = __pa(buf);
-	virt = omap_mmu_to_virt(mmu, dspadr);
+	virt = omap_mmu_to_virt(mmu, devadr);
 	exmap_set_armmmu(mmu, (unsigned long)virt, phys, PAGE_SIZE);
 	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, buf, virt);
-	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, dspadr, phys);
+	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, devadr, phys);
 	omap_mmu_load_pte_entry(mmu, &tlb_ent);
 }
 EXPORT_SYMBOL_GPL(exmap_setup_preserved_mem_page);
 
-void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long dspadr)
+void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long devadr)
 {
-	void *virt = omap_mmu_to_virt(mmu, dspadr);
+	void *virt = omap_mmu_to_virt(mmu, devadr);
 
 	exmap_clear_armmmu(mmu, (unsigned long)virt, PAGE_SIZE);
 	/* DSP MMU is shutting down. not handled here. */
@@ -1074,8 +1078,8 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
 			  mmu->name,  mmu);
 	if (ret < 0) {
-		dev_err(&mmu->dev, "failed to register MMU interrupt: %d\n",
-			ret);
+		dev_err(&mmu->dev, "MMU %s: failed to register MMU interrupt:"
+			" %d\n", mmu->name, ret);
 		goto fail;
 	}
 
@@ -1165,8 +1169,8 @@ static ssize_t exmem_read(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		dev_err(&mmu->dev, "MMU: DSP address %08lx / size %08x "
-			"is not valid!\n", p, count);
+		dev_err(&mmu->dev, "MMU %s: external device address %08lx / "
+			"size %08x is not valid!\n", mmu->name, p, count);
 		return -EFAULT;
 	}
 	if (count > (1 << mmu->addrspace) - p)
@@ -1232,8 +1236,8 @@ static ssize_t exmem_write(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		dev_err(&mmu->dev, "MMU: DSP address %08lx / size %08x "
-			"is not valid!\n", p, count);
+		dev_err(&mmu->dev, "MMU %s: external device address %08lx "
+			"/ size %08x is not valid!\n", mmu->name, p, count);
 		return -EFAULT;
 	}
 	if (count > (1 << mmu->addrspace) - p)
@@ -1337,7 +1341,7 @@ static ssize_t exmap_show(struct device *dev, struct device_attribute *attr,
 	int i = 0;
 
 	down_read(&mmu->exmap_sem);
-	len = sprintf(buf, "  dspadr     size         buf     size uc\n");
+	len = sprintf(buf, "  devadr     size         buf     size uc\n");
 			 /* 0x300000 0x123000  0xc0171000 0x100000  0*/
 
 	omap_mmu_for_each_tlb_entry(mmu, ent) {
-- 
1.5.3.rc6.17.g1911
