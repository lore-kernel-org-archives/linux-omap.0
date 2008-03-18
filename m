From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] OMAP: MMU: Fix inconsistency to unregister device MMU
Date: Tue, 18 Mar 2008 12:28:40 +0200
Message-ID: <1205836120-29625-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36300 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYCRK3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 06:29:39 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2IATVPb020687
	for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2008 12:29:37 +0200
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m2IASeh8008674
	for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2008 12:28:40 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was a problem that kernel counldn't find struct device for
device MMU when unregistering it for class. This is because device
MMUs are the pseudo devices and they were not created when registering
into MMU class. This patch will create struct device when registering
device MMU into class and will fix the problem that "dspctl cleanup"
encountered kernel Oops.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.c       |    4 +-
 arch/arm/mach-omap2/mmu.c       |    4 +-
 arch/arm/plat-omap/mmu.c        |   78 ++++++++++++++++++---------------------
 include/asm-arm/arch-omap/mmu.h |    2 +-
 4 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 3bb3efe..a894ca2 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -198,7 +198,7 @@ static int omap1_mmu_startup(struct omap_mmu *mmu)
 {
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+		dev_err(mmu->dev, "MMU %s: failed to allocate memory "
 			"for vector table\n", mmu->name);
 		return -ENOMEM;
 	}
@@ -240,7 +240,7 @@ omap1_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+		dev_err(mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
 			" an aligned boundary\n", mmu->name, entry->va);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index f8bb6df..66f5a3e 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -143,7 +143,7 @@ static int omap2_mmu_startup(struct omap_mmu *mmu)
 
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
-		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+		dev_err(mmu->dev, "MMU %s: failed to allocate memory "
 			"for vector table\n", mmu->name);
 		return -ENOMEM;
 	}
@@ -256,7 +256,7 @@ omap2_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
 	struct cam_ram_regset *cr;
 
 	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
-		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+		dev_err(mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
 			" an aligned boundary\n", mmu->name, entry->va);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 191cb55..988eedd 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -106,14 +106,14 @@ int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size)
 
 	/* alignment check */
 	if (!is_aligned(size, SZ_64K)) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: size(0x%lx) is not multiple of 64KB.\n",
 			mmu->name, size);
 		return -EINVAL;
 	}
 
 	if (size > (1 << mmu->addrspace)) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: size(0x%lx) is larger than external device "
 			" memory space size (0x%x.\n", mmu->name, size,
 			(1 << mmu->addrspace));
@@ -199,7 +199,7 @@ int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
 	pte_t *ptep;
 	int prot_pmd, prot_pte;
 
-	dev_dbg(&mmu->dev,
+	dev_dbg(mmu->dev,
 		"MMU %s: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
 		mmu->name, virt, phys, size);
 
@@ -236,7 +236,7 @@ void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	dev_dbg(&mmu->dev,
+	dev_dbg(mmu->dev,
 		"MMU %s: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
 		mmu->name, virt, size);
 
@@ -599,7 +599,7 @@ int omap_mmu_load_tlb_entry(struct omap_mmu *mmu,
 found_victim:
 	/* The last entry cannot be locked? */
 	if (lock.victim == (mmu->nr_tlb_entries - 1)) {
-		dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
+		dev_err(mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
 		return -EBUSY;
 	}
 
@@ -744,19 +744,19 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long devadr,
 	 * alignment check
 	 */
 	if (!is_aligned(size, MINIMUM_PAGESZ)) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: size(0x%lx) is not multiple of 4KB.\n",
 			mmu->name, size);
 		return -EINVAL;
 	}
 	if (!is_aligned(devadr, MINIMUM_PAGESZ)) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: external device address(0x%lx) is not"
 			" aligned.\n", mmu->name, devadr);
 		return -EINVAL;
 	}
 	if (!is_aligned(padr, MINIMUM_PAGESZ)) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: physical address(0x%lx) is not aligned.\n",
 			mmu->name, padr);
 		return -EINVAL;
@@ -765,7 +765,7 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long devadr,
 	/* address validity check */
 	if ((devadr < mmu->memsize) ||
 	    (devadr >= (1 << mmu->addrspace))) {
-		dev_err(&mmu->dev,
+		dev_err(mmu->dev,
 			"MMU %s: illegal address/size for %s().\n",
 			mmu->name, __FUNCTION__);
 		return -EINVAL;
@@ -782,7 +782,7 @@ int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long devadr,
 		mapsize = 1 << (tmp_ent->order + PAGE_SHIFT);
 		if ((_vadr + size > tmp_ent->vadr) &&
 		    (_vadr < tmp_ent->vadr + mapsize)) {
-			dev_err(&mmu->dev, "MMU %s: exmap page overlap!\n",
+			dev_err(mmu->dev, "MMU %s: exmap page overlap!\n",
 				mmu->name);
 			up_write(&mmu->exmap_sem);
 			return -EINVAL;
@@ -796,7 +796,7 @@ start:
 		if (!mmu->exmap_tbl[idx].valid)
 			goto found_free;
 
-	dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
+	dev_err(mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
 	status = -EBUSY;
 	goto fail;
 
@@ -900,7 +900,7 @@ static unsigned long unmap_free_arm(struct omap_mmu *mmu,
 	/* freeing allocated memory */
 	if (ent->type == EXMAP_TYPE_MEM) {
 		omap_mmu_free_pages((unsigned long)ent->buf, ent->order);
-		dev_dbg(&mmu->dev, "MMU %s: freeing 0x%lx bytes @ adr 0x%8p\n",
+		dev_dbg(mmu->dev, "MMU %s: freeing 0x%lx bytes @ adr 0x%8p\n",
 			mmu->name, size, ent->buf);
 	}
 
@@ -926,13 +926,13 @@ int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long devadr)
 			goto found_map;
 	}
 	up_write(&mmu->exmap_sem);
-	dev_warn(&mmu->dev, "MMU %s: address %06lx not found in exmap_tbl.\n",
+	dev_warn(mmu->dev, "MMU %s: address %06lx not found in exmap_tbl.\n",
 		 mmu->name, devadr);
 	return -EINVAL;
 
 found_map:
 	if (ent->usecount > 0) {
-		dev_err(&mmu->dev, "MMU %s: exmap reference count is not 0.\n"
+		dev_err(mmu->dev, "MMU %s: exmap reference count is not 0.\n"
 			"   idx=%d, vadr=%p, order=%d, usecount=%d\n",
 			mmu->name, idx, ent->vadr, ent->order, ent->usecount);
 		up_write(&mmu->exmap_sem);
@@ -960,7 +960,7 @@ found_map:
 	if (ent->vadr == vadr)
 		goto found_map;	/* continue */
 
-	dev_err(&mmu->dev, "MMU %s: illegal exmap_tbl grouping!\n"
+	dev_err(mmu->dev, "MMU %s: illegal exmap_tbl grouping!\n"
 		"expected vadr = %p, exmap_tbl[%d].vadr = %p\n",
 		mmu->name, vadr, idx, ent->vadr);
 	up_write(&mmu->exmap_sem);
@@ -1083,7 +1083,7 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
 			  mmu->name,  mmu);
 	if (ret < 0) {
-		dev_err(&mmu->dev, "MMU %s: failed to register MMU interrupt:"
+		dev_err(mmu->dev, "MMU %s: failed to register MMU interrupt:"
 			" %d\n", mmu->name, ret);
 		goto fail;
 	}
@@ -1175,7 +1175,7 @@ static ssize_t exmem_read(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		dev_err(&mmu->dev, "MMU %s: external device address %08lx / "
+		dev_err(mmu->dev, "MMU %s: external device address %08lx / "
 			"size %08x is not valid!\n", mmu->name, p, count);
 		return -EFAULT;
 	}
@@ -1242,7 +1242,7 @@ static ssize_t exmem_write(struct omap_mmu *mmu, char *buf, size_t count,
 	void *vadr = omap_mmu_to_virt(mmu, p);
 
 	if (!exmap_valid(mmu, vadr, count)) {
-		dev_err(&mmu->dev, "MMU %s: external device address %08lx "
+		dev_err(mmu->dev, "MMU %s: external device address %08lx "
 			"/ size %08x is not valid!\n", mmu->name, p, count);
 		return -EFAULT;
 	}
@@ -1294,7 +1294,7 @@ ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu,
 			    struct bin_attribute *attr,
 			    char *buf, loff_t offset, size_t count)
 {
-	return omap_mmu_mem_read(&mmu->dev.kobj, attr, buf, offset, count);
+	return omap_mmu_mem_read(&mmu->dev->kobj, attr, buf, offset, count);
 }
 EXPORT_SYMBOL_GPL(__omap_mmu_mem_read);
 
@@ -1302,7 +1302,7 @@ ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu,
 			     struct bin_attribute *attr,
 			     char *buf, loff_t offset, size_t count)
 {
-	return omap_mmu_mem_write(&mmu->dev.kobj, attr, buf, offset, count);
+	return omap_mmu_mem_write(&mmu->dev->kobj, attr, buf, offset, count);
 }
 EXPORT_SYMBOL_GPL(__omap_mmu_mem_write);
 
@@ -1464,11 +1464,12 @@ int omap_mmu_register(struct omap_mmu *mmu)
 {
 	int ret;
 
-	mmu->dev.class = &omap_mmu_class;
-	strlcpy(mmu->dev.bus_id, mmu->name, KOBJ_NAME_LEN);
-	dev_set_drvdata(&mmu->dev, mmu);
+	mmu->dev = device_create(&omap_mmu_class, NULL, 0, "%s", mmu->name);
+	if (unlikely(IS_ERR(mmu->dev)))
+		return PTR_ERR(mmu->dev);
+	dev_set_drvdata(mmu->dev, mmu);
 
-	mmu->exmap_tbl = kzalloc(sizeof(struct exmap_tbl) * mmu->nr_tlb_entries,
+	mmu->exmap_tbl = kcalloc(mmu->nr_tlb_entries, sizeof(struct exmap_tbl),
 				 GFP_KERNEL);
 	if (!mmu->exmap_tbl)
 		return -ENOMEM;
@@ -1479,47 +1480,41 @@ int omap_mmu_register(struct omap_mmu *mmu)
 		goto err_mm_alloc;
 	}
 
-	ret = device_register(&mmu->dev);
-	if (unlikely(ret))
-		goto err_dev_register;
-
 	init_rwsem(&mmu->exmap_sem);
 
 	ret = omap_mmu_init(mmu);
 	if (unlikely(ret))
 		goto err_mmu_init;
 
-	ret = device_create_file(&mmu->dev, &dev_attr_mmu);
+	ret = device_create_file(mmu->dev, &dev_attr_mmu);
 	if (unlikely(ret))
 		goto err_dev_create_mmu;
-	ret = device_create_file(&mmu->dev, &dev_attr_exmap);
+	ret = device_create_file(mmu->dev, &dev_attr_exmap);
 	if (unlikely(ret))
 		goto err_dev_create_exmap;
 
 	if (likely(mmu->membase)) {
 		dev_attr_mem.size = mmu->memsize;
-		ret = device_create_bin_file(&mmu->dev,
+		ret = device_create_bin_file(mmu->dev,
 					     &dev_attr_mem);
 		if (unlikely(ret))
 			goto err_bin_create_mem;
 	}
-
 	return 0;
 
 err_bin_create_mem:
-	device_remove_file(&mmu->dev, &dev_attr_exmap);
+	device_remove_file(mmu->dev, &dev_attr_exmap);
 err_dev_create_exmap:
-	device_remove_file(&mmu->dev, &dev_attr_mmu);
+	device_remove_file(mmu->dev, &dev_attr_mmu);
 err_dev_create_mmu:
 	omap_mmu_shutdown(mmu);
 err_mmu_init:
-	device_unregister(&mmu->dev);
-err_dev_register:
 	kfree(mmu->twl_mm);
 	mmu->twl_mm = NULL;
 err_mm_alloc:
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
+	device_unregister(mmu->dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_mmu_register);
@@ -1529,12 +1524,13 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 	omap_mmu_shutdown(mmu);
 	omap_mmu_kmem_release();
 
-	device_remove_file(&mmu->dev, &dev_attr_mmu);
-	device_remove_file(&mmu->dev, &dev_attr_exmap);
+	device_remove_file(mmu->dev, &dev_attr_mmu);
+	device_remove_file(mmu->dev, &dev_attr_exmap);
 
 	if (likely(mmu->membase))
-		device_remove_bin_file(&mmu->dev,
-					     &dev_attr_mem);
+		device_remove_bin_file(mmu->dev, &dev_attr_mem);
+
+	device_unregister(mmu->dev);
 
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
@@ -1543,8 +1539,6 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 		__mmdrop(mmu->twl_mm);
 		mmu->twl_mm = NULL;
 	}
-
-	device_unregister(&mmu->dev);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_unregister);
 
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index 714ee1d..efacb6f 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -104,7 +104,7 @@ struct omap_mmu {
 
 	enum omap_mmu_type type;
 
-	struct device dev;
+	struct device *dev;
 
 	struct rw_semaphore exmap_sem;
 	struct exmap_tbl *exmap_tbl;
-- 
1.5.4.3.325.g6d216

