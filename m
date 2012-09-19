From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 14/15] tidspbridge: Use correct types to describe physical, MPU, DSP addresses
Date: Wed, 19 Sep 2012 14:07:02 +0200
Message-ID: <1348056423-25573-15-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab2ISMGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:43 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Physical addresses: name them 'pa' and use the phys_addr_t type
MPU virtual addresses: name them 'va' and use the unsigned long type
DSP virtual addresses: name them 'da' and use the u32 type

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |  180 ++++++++++----------
 drivers/staging/tidspbridge/hw/hw_mmu.c            |   74 ++++-----
 drivers/staging/tidspbridge/hw/hw_mmu.h            |   24 +--
 .../tidspbridge/include/dspbridge/dspdefs.h        |   24 ++--
 4 files changed, 140 insertions(+), 162 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 7d074fc..c9d240c 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -988,8 +988,8 @@ static int bridge_brd_mem_write(struct bridge_dev_context *dev_ctxt,
  *      This function calculates PTE address (MPU virtual) to be updated
  *      It also manages the L2 page tables
  */
-static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
-			  u32 size, struct hw_mmu_map_attrs_t *attrs)
+static int pte_set(struct pg_table_attrs *pt, phys_addr_t pa, u32 da,
+		   size_t size, struct hw_mmu_map_attrs_t *attrs)
 {
 	u32 i;
 	u32 pte_val;
@@ -1010,7 +1010,7 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 	pg_tbl_va = l1_base_va;
 	if (size == SZ_64K || size == SZ_4K) {
 		/* Find whether the L1 PTE points to a valid L2 PT */
-		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va);
+		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, da);
 		if (pte_addr_l1 <= (pt->l1_base_va + pt->l1_size)) {
 			pte_val = *(u32 *) pte_addr_l1;
 			pte_size = hw_mmu_pte_size_l1(pte_val);
@@ -1043,7 +1043,7 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 				/* Endianness attributes are ignored for
 				 * HW_MMU_COARSE_PAGE_SIZE */
 				status =
-				    hw_mmu_pte_set(l1_base_va, l2_base_pa, va,
+				    hw_mmu_pte_set(l1_base_va, l2_base_pa, da,
 						   HW_MMU_COARSE_PAGE_SIZE,
 						   attrs);
 			} else {
@@ -1068,18 +1068,18 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 		spin_unlock(&pt->pg_lock);
 	}
 	if (!status) {
-		dev_dbg(bridge, "PTE: pg_tbl_va %x, pa %x, va %x, size %x\n",
-			pg_tbl_va, pa, va, size);
+		dev_dbg(bridge, "PTE: pg_tbl_va %x, pa %x, da %x, size %x\n",
+			pg_tbl_va, pa, da, size);
 		dev_dbg(bridge, "PTE: endianism %x, element_size %x, "
 			"mixed_size %x\n", attrs->endianism,
 			attrs->element_size, attrs->mixed_size);
-		status = hw_mmu_pte_set(pg_tbl_va, pa, va, size, attrs);
+		status = hw_mmu_pte_set(pg_tbl_va, pa, da, size, attrs);
 	}
 
 	return status;
 }
 
-static unsigned max_alignment(u32 addr, u32 size)
+static unsigned max_alignment(u32 addr, size_t size)
 {
 	unsigned pagesize[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K, };
 	unsigned int i;
@@ -1097,24 +1097,24 @@ static unsigned max_alignment(u32 addr, u32 size)
  *      This function calculates the optimum page-aligned addresses and sizes
  *      Caller must pass page-aligned values
  */
-static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa, u32 va,
-		      u32 size, struct hw_mmu_map_attrs_t *map_attrs)
+static int pte_update(struct bridge_dev_context *dev_ctxt, phys_addr_t pa, u32 da,
+		      size_t size, struct hw_mmu_map_attrs_t *map_attrs)
 {
 	while (size) {
 		/* To find the max. page size with which both PA & VA are
 		 * aligned */
-		unsigned int ent_sz = max_alignment(va | pa, size);
+		unsigned int ent_sz = max_alignment(da | pa, size);
 		int ret;
 
 		if (WARN_ON(ent_sz == 0))
 			return -EINVAL;
 
-		ret = pte_set(dev_ctxt->pt_attrs, pa, va, ent_sz, map_attrs);
+		ret = pte_set(dev_ctxt->pt_attrs, pa, da, ent_sz, map_attrs);
 		if (ret < 0)
 			return ret;
 
 		pa += ent_sz;
-		va += ent_sz;
+		da += ent_sz;
 		size -= ent_sz;
 	}
 
@@ -1127,26 +1127,26 @@ static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa, u32 va,
  *      This function walks through the page tables to convert a userland
  *      virtual address to physical address
  */
-static u32 user_va2_pa(struct mm_struct *mm, u32 address)
+static u32 user_va2_pa(struct mm_struct *mm, unsigned long va)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
-	pgd = pgd_offset(mm, address);
+	pgd = pgd_offset(mm, va);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		return 0;
 
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, va);
 	if (pud_none(*pud) || pud_bad(*pud))
 		return 0;
 
-	pmd = pmd_offset(pud, address);
+	pmd = pmd_offset(pud, va);
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		return 0;
 
-	ptep = pte_offset_map(pmd, address);
+	ptep = pte_offset_map(pmd, va);
 	if (ptep) {
 		pte = *ptep;
 		if (pte_present(pte))
@@ -1166,8 +1166,8 @@ static inline void flush_all(struct bridge_dev_context *dev_ctxt)
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt, u32 mpu_addr,
-			   u32 virt_addr, size_t num_bytes,
+static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
+			   unsigned long va, u32 da, size_t bytes,
 			   struct hw_mmu_map_attrs_t *hw_attrs)
 {
 	struct page *page_next;
@@ -1178,9 +1178,9 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt, u32 mpu_addr,
 	 * Combine physically contiguous regions to reduce TLBs.
 	 * Pass the translated pa to pte_update.
 	 */
-	page_next = vmalloc_to_page((void *)mpu_addr);
+	page_next = vmalloc_to_page((void *)va);
 
-	while (num_bytes > 0) {
+	while (bytes > 0) {
 		struct page *page = page_next;
 		size_t chunk_size = PAGE_SIZE;
 		u32 num_pages = 1;
@@ -1191,9 +1191,8 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt, u32 mpu_addr,
 		 * If the next page is physically contiguous, map it with the
 		 * current one by increasing the size of the region to be mapped.
 		 */
-		while (chunk_size < num_bytes) {
-			page_next =
-			    vmalloc_to_page((void *)mpu_addr + chunk_size);
+		while (chunk_size < bytes) {
+			page_next = vmalloc_to_page((void *)va + chunk_size);
 			if (page_next != page + num_pages)
 				break;
 
@@ -1208,14 +1207,14 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt, u32 mpu_addr,
 			break;
 		}
 
-		ret = pte_update(dev_ctxt, page_to_phys(page), virt_addr,
+		ret = pte_update(dev_ctxt, page_to_phys(page), da,
 				 chunk_size, hw_attrs);
 		if (ret)
 			break;
 
-		mpu_addr += chunk_size;
-		virt_addr += chunk_size;
-		num_bytes -= chunk_size;
+		va += chunk_size;
+		da += chunk_size;
+		bytes -= chunk_size;
 	}
 
 	/*
@@ -1243,7 +1242,7 @@ static void bad_page_dump(u32 pa, struct page *pg)
 }
 
 /* Release all pages associated with a physical addresses range. */
-static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes,
+static void bridge_release_pages(phys_addr_t pa, u32 pte_size, size_t bytes,
 				 struct dmm_map_object *map_obj)
 {
 	struct page *pg;
@@ -1251,17 +1250,17 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes,
 
 	num_pages = pte_size / PAGE_SIZE;
 
-	for (; num_pages > 0; --num_pages, paddr += SZ_4K) {
-		if (!pfn_valid(__phys_to_pfn(paddr)) ||
+	for (; num_pages > 0; --num_pages, pa += SZ_4K) {
+		if (!pfn_valid(__phys_to_pfn(pa)) ||
 		    (map_obj && map_obj->vm_flags & VM_PFNMAP))
 			continue;
 
-		pg = PHYS_TO_PAGE(paddr);
+		pg = PHYS_TO_PAGE(pa);
 		if (page_count(pg) < 1) {
 			pr_info("DSPBRIDGE: UNMAP function: "
 				"COUNT 0 FOR PA 0x%x, size = "
-				"0x%x\n", paddr, num_bytes);
-			bad_page_dump(paddr, pg);
+				"0x%x\n", pa, bytes);
+			bad_page_dump(pa, pg);
 		} else {
 			set_page_dirty(pg);
 			page_cache_release(pg);
@@ -1278,7 +1277,7 @@ static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes,
  *      we clear consecutive PTEs until we unmap all the bytes
  */
 static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
-				 u32 virt_addr, u32 num_bytes,
+				 u32 da, size_t bytes,
 				 struct dmm_map_object *map_obj)
 {
 	u32 l1_base_va;
@@ -1295,18 +1294,18 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 	int status = 0;
 	struct pg_table_attrs *pt = dev_ctxt->pt_attrs;
 
-	rem_bytes = num_bytes;
+	rem_bytes = bytes;
 	rem_bytes_l2 = 0;
 	l1_base_va = pt->l1_base_va;
-	pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, virt_addr);
-	dev_dbg(bridge, "%s dev_ctxt %p, va %x, NumBytes %x l1_base_va %x, "
-		"pte_addr_l1 %x\n", __func__, dev_ctxt, virt_addr,
-		num_bytes, l1_base_va, pte_addr_l1);
+	pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, da);
+	dev_dbg(bridge, "%s dev_ctxt %p, da %x, NumBytes %x l1_base_va %x, "
+		"pte_addr_l1 %x\n", __func__, dev_ctxt, da,
+		bytes, l1_base_va, pte_addr_l1);
 
 	while (rem_bytes && !status) {
-		u32 virt_addr_orig = virt_addr;
+		u32 da_orig = da;
 		/* Find whether the L1 PTE points to a valid L2 PT */
-		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, virt_addr);
+		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, da);
 		pte_val = *(u32 *) pte_addr_l1;
 		pte_size = hw_mmu_pte_size_l1(pte_val);
 
@@ -1327,7 +1326,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		 * page, and the size of VA space that needs to be
 		 * cleared on this L2 page
 		 */
-		pte_addr_l2 = hw_mmu_pte_addr_l2(l2_base_va, virt_addr);
+		pte_addr_l2 = hw_mmu_pte_addr_l2(l2_base_va, da);
 		pte_count = pte_addr_l2 & (HW_MMU_COARSE_PAGE_SIZE - 1);
 		pte_count = (HW_MMU_COARSE_PAGE_SIZE - pte_count) / sizeof(u32);
 		if (rem_bytes < (pte_count * PG_SIZE4K))
@@ -1345,24 +1344,24 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		while (rem_bytes_l2 && !status) {
 			pte_val = *(u32 *) pte_addr_l2;
 			pte_size = hw_mmu_pte_size_l2(pte_val);
-			/* virt_addr aligned to pte_size? */
+			/* da aligned to pte_size? */
 			if (pte_size == 0 || rem_bytes_l2 < pte_size ||
-			    virt_addr & (pte_size - 1)) {
+			    da & (pte_size - 1)) {
 				status = -EPERM;
 				break;
 			}
 
 			bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-					     num_bytes, map_obj);
+					     bytes, map_obj);
 
-			if (hw_mmu_pte_clear(pte_addr_l2, virt_addr, pte_size)) {
+			if (hw_mmu_pte_clear(pte_addr_l2, da, pte_size)) {
 				status = -EPERM;
 				goto EXIT_LOOP;
 			}
 
 			status = 0;
 			rem_bytes_l2 -= pte_size;
-			virt_addr += pte_size;
+			da += pte_size;
 			pte_addr_l2 += (pte_size >> 12) * sizeof(u32);
 		}
 		spin_lock(&pt->pg_lock);
@@ -1372,7 +1371,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 				/*
 				 * Clear the L1 PTE pointing to the L2 PT
 				 */
-				if (!hw_mmu_pte_clear(l1_base_va, virt_addr_orig,
+				if (!hw_mmu_pte_clear(l1_base_va, da_orig,
 						     HW_MMU_COARSE_PAGE_SIZE))
 					status = 0;
 				else {
@@ -1388,21 +1387,21 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		spin_unlock(&pt->pg_lock);
 		continue;
 skip_coarse_page:
-		/* virt_addr aligned to pte_size? */
+		/* da aligned to pte_size? */
 		/* pte_size = 1 MB or 16 MB */
 		if (pte_size == 0 || rem_bytes < pte_size ||
-		    virt_addr & (pte_size - 1)) {
+		    da & (pte_size - 1)) {
 			status = -EPERM;
 			break;
 		}
 
 		bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
-				     num_bytes, map_obj);
+				     bytes, map_obj);
 
-		if (!hw_mmu_pte_clear(l1_base_va, virt_addr, pte_size)) {
+		if (!hw_mmu_pte_clear(l1_base_va, da, pte_size)) {
 			status = 0;
 			rem_bytes -= pte_size;
-			virt_addr += pte_size;
+			da += pte_size;
 		} else {
 			status = -EPERM;
 			goto EXIT_LOOP;
@@ -1415,8 +1414,8 @@ skip_coarse_page:
 EXIT_LOOP:
 	flush_all(dev_ctxt);
 	dev_dbg(bridge,
-		"%s: virt_addr %x, pte_addr_l1 %x pte_addr_l2 %x rem_bytes %x,"
-		" rem_bytes_l2 %x status %x\n", __func__, virt_addr, pte_addr_l1,
+		"%s: da %x, pte_addr_l1 %x pte_addr_l2 %x rem_bytes %x,"
+		" rem_bytes_l2 %x status %x\n", __func__, da, pte_addr_l1,
 		pte_addr_l2, rem_bytes, rem_bytes_l2, status);
 	return status;
 }
@@ -1431,7 +1430,7 @@ EXIT_LOOP:
  *  TODO: Disable MMU while updating the page tables (but that'll stall DSP)
  */
 static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
-			      u32 mpu_addr, u32 virt_addr, u32 num_bytes,
+			      unsigned long va, u32 da, size_t bytes,
 			      u32 map_attr, struct dmm_map_object *map_obj)
 {
 	u32 attrs;
@@ -1447,10 +1446,10 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	u32 pa;
 
 	dev_dbg(bridge,
-		"%s hDevCtxt %p, pa %x, va %x, size %x, map_attr %x\n",
-		__func__, dev_ctxt, mpu_addr, virt_addr, num_bytes,
+		"%s hDevCtxt %p, va %lx, da %x, size %x, map_attr %x\n",
+		__func__, dev_ctxt, va, da, bytes,
 		map_attr);
-	if (num_bytes == 0)
+	if (bytes == 0)
 		return -EINVAL;
 
 	if (map_attr & DSP_MAP_DIR_MASK) {
@@ -1491,8 +1490,7 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	}
 
 	if (attrs & DSP_MAPVMALLOCADDR) {
-		return mem_map_vmalloc(dev_ctxt, mpu_addr, virt_addr,
-				       num_bytes, &hw_attrs);
+		return mem_map_vmalloc(dev_ctxt, va, da, bytes, &hw_attrs);
 	}
 	/*
 	 * Do OS-specific user-va to pa translation.
@@ -1500,40 +1498,40 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	 * Pass the translated pa to pte_update.
 	 */
 	if ((attrs & DSP_MAPPHYSICALADDR)) {
-		status = pte_update(dev_ctxt, mpu_addr, virt_addr,
-				    num_bytes, &hw_attrs);
+		status = pte_update(dev_ctxt, (phys_addr_t)va, da,
+				    bytes, &hw_attrs);
 		goto func_cont;
 	}
 
 	/*
-	 * Important Note: mpu_addr is mapped from user application process
+	 * Important Note: va is mapped from user application process
 	 * to current process - it must lie completely within the current
 	 * virtual memory address space in order to be of use to us here!
 	 */
 	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, mpu_addr);
+	vma = find_vma(mm, va);
 	if (vma)
 		dev_dbg(bridge,
-			"VMAfor UserBuf: mpu_addr=%x, num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", mpu_addr,
-			num_bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
+			"VMAfor UserBuf: va=%lx, bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", va,
+			bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
 
 	/*
 	 * It is observed that under some circumstances, the user buffer is
 	 * spread across several VMAs. So loop through and check if the entire
 	 * user buffer is covered
 	 */
-	while ((vma) && (mpu_addr + num_bytes > vma->vm_end)) {
+	while ((vma) && (va + bytes > vma->vm_end)) {
 		/* jump to the next VMA region */
 		vma = find_vma(mm, vma->vm_end + 1);
 		dev_dbg(bridge,
-			"VMA for UserBuf mpu_addr=%x num_bytes=%x, "
-			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", mpu_addr,
-			num_bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
+			"VMA for UserBuf va=%lx bytes=%x, "
+			"vm_start=%lx, vm_end=%lx, vm_flags=%lx\n", va,
+			bytes, vma->vm_start, vma->vm_end, vma->vm_flags);
 	}
 	if (!vma) {
-		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
-		       __func__, mpu_addr, num_bytes);
+		pr_err("%s: Failed to get VMA region for 0x%lx (%d)\n",
+		       __func__, va, bytes);
 		status = -EINVAL;
 		up_read(&mm->mmap_sem);
 		goto func_cont;
@@ -1543,11 +1541,11 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 		map_obj->vm_flags = vma->vm_flags;
 
 	if (vma->vm_flags & VM_IO) {
-		num_usr_pgs = num_bytes / PG_SIZE4K;
+		num_usr_pgs = bytes / PG_SIZE4K;
 
 		/* Get the physical addresses for user buffer */
 		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pa = user_va2_pa(mm, mpu_addr);
+			pa = user_va2_pa(mm, va);
 			if (!pa) {
 				status = -EPERM;
 				pr_err("DSPBRIDGE: VM_IO mapping physical"
@@ -1563,22 +1561,22 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					bad_page_dump(pa, pg);
 				}
 			}
-			status = pte_set(dev_ctxt->pt_attrs, pa, virt_addr,
+			status = pte_set(dev_ctxt->pt_attrs, pa, da,
 					 SZ_4K, &hw_attrs);
 			if (status)
 				break;
 
-			virt_addr += SZ_4K;
-			mpu_addr += SZ_4K;
+			da += SZ_4K;
+			va += SZ_4K;
 			pa += SZ_4K;
 		}
 	} else {
-		num_usr_pgs = num_bytes / PG_SIZE4K;
+		num_usr_pgs = bytes / PG_SIZE4K;
 		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
 			write = 1;
 
 		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pg_num = get_user_pages(current, mm, mpu_addr, 1,
+			pg_num = get_user_pages(current, mm, va, 1,
 						write, 1, &pg, NULL);
 			if (pg_num > 0) {
 				if (page_count(pg) < 1) {
@@ -1588,24 +1586,24 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 					bad_page_dump(page_to_phys(pg), pg);
 				}
 				status = pte_set(dev_ctxt->pt_attrs,
-						 page_to_phys(pg),
-						 virt_addr, SZ_4K, &hw_attrs);
+						 page_to_phys(pg), da,
+						 SZ_4K, &hw_attrs);
 				if (status)
 					break;
 
 				if (map_obj)
 					map_obj->pages[pg_i] = pg;
 
-				virt_addr += SZ_4K;
-				mpu_addr += SZ_4K;
+				da += SZ_4K;
+				va += SZ_4K;
 			} else {
 				pr_err("DSPBRIDGE: get_user_pages FAILED,"
-				       "MPU addr = 0x%x,"
+				       "va = 0x%lx,"
 				       "vma->vm_flags = 0x%lx,"
 				       "get_user_pages Err"
 				       "Value = %d, Buffer"
-				       "size=0x%x\n", mpu_addr,
-				       vma->vm_flags, pg_num, num_bytes);
+				       "size=0x%x\n", va,
+				       vma->vm_flags, pg_num, bytes);
 				status = -EPERM;
 				break;
 			}
@@ -1619,7 +1617,7 @@ func_cont:
 		 * mapping
 		 */
 		if (pg_i)
-			bridge_brd_mem_un_map(dev_ctxt, virt_addr,
+			bridge_brd_mem_un_map(dev_ctxt, da,
 					      pg_i * PG_SIZE4K, map_obj);
 		status = -EPERM;
 	}
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index a5766f6..34c2054 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
@@ -55,9 +55,9 @@
  *       Description     : It indicates the TLB entry is valid entry or not
  *
  *
- *       Identifier      : virtual_addr_tag
+ *       Identifier      : da_tag
  *       Type	    	: const u32
- *       Description     : virtual Address
+ *       Description     : device virtual Address
  *
  * RETURNS:
  *
@@ -76,12 +76,12 @@ static hw_status mmu_set_cam_entry(const void __iomem *base_address,
 				   const u32 page_sz,
 				   const u32 preserved_bit,
 				   const u32 valid_bit,
-				   const u32 virtual_addr_tag)
+				   const u32 da_tag)
 {
 	hw_status status = 0;
 	u32 mmu_cam_reg;
 
-	mmu_cam_reg = (virtual_addr_tag << 12);
+	mmu_cam_reg = (da_tag << 12);
 	mmu_cam_reg = (mmu_cam_reg) | (page_sz) | (valid_bit << 2) |
 	    (preserved_bit << 3);
 
@@ -100,8 +100,8 @@ static hw_status mmu_set_cam_entry(const void __iomem *base_address,
  *       Type	    	: const u32
  *       Description     : Base Address of instance of MMU module
  *
- *       Identifier      : physical_addr
- *       Type	    	: const u32
+ *       Identifier      : pa
+ *       Type	    	: phys_addr_t
  *       Description     : Physical Address to which the corresponding
  *			 virtual   Address shouldpoint
  *
@@ -131,14 +131,14 @@ static hw_status mmu_set_cam_entry(const void __iomem *base_address,
  * METHOD:	       : Check the Input parameters and set the RAM entry.
  */
 static hw_status mmu_set_ram_entry(const void __iomem *base_address,
-				   const u32 physical_addr,
+				   phys_addr_t pa,
 				   enum hw_endianism_t endianism,
 				   enum hw_element_size_t element_size,
 				   enum hw_mmu_mixed_size_t mixed_size)
 {
 	u32 mmu_ram_reg;
 
-	mmu_ram_reg = (physical_addr & IOPAGE_MASK);
+	mmu_ram_reg = (pa & IOPAGE_MASK);
 	mmu_ram_reg = (mmu_ram_reg) | ((endianism << 9) | (element_size << 7) |
 				       (mixed_size << 6));
 
@@ -270,17 +270,14 @@ hw_status hw_mmu_twl_disable(const void __iomem *base_address)
 	return status;
 }
 
-hw_status hw_mmu_tlb_add(const void __iomem *base_address,
-			 u32 physical_addr,
-			 u32 virtual_addr,
-			 u32 page_sz,
-			 u32 entry_num,
+hw_status hw_mmu_tlb_add(const void __iomem *base_address, phys_addr_t pa,
+			 u32 da, u32 page_sz, u32 entry_num,
 			 struct hw_mmu_map_attrs_t *map_attrs,
 			 s8 preserved_bit, s8 valid_bit)
 {
 	hw_status status = 0;
 	u32 lock_reg;
-	u32 virtual_addr_tag;
+	u32 da_tag;
 	u32 mmu_pg_size;
 
 	/*Check the input Parameters */
@@ -308,15 +305,15 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 	lock_reg = MMUMMU_LOCK_READ_REGISTER32(base_address);
 
 	/* Generate the 20-bit tag from virtual address */
-	virtual_addr_tag = ((virtual_addr & IOPAGE_MASK) >> 12);
+	da_tag = ((da & IOPAGE_MASK) >> 12);
 
 	/* Write the fields in the CAM Entry Register */
 	mmu_set_cam_entry(base_address, mmu_pg_size, preserved_bit, valid_bit,
-			  virtual_addr_tag);
+			  da_tag);
 
 	/* Write the different fields of the RAM Entry Register */
 	/* endianism of the page,Element Size of the page (8, 16, 32, 64 bit) */
-	mmu_set_ram_entry(base_address, physical_addr, map_attrs->endianism,
+	mmu_set_ram_entry(base_address, pa, map_attrs->endianism,
 			  map_attrs->element_size, map_attrs->mixed_size);
 
 	/* Update the MMU Lock Register */
@@ -332,9 +329,7 @@ hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 	return status;
 }
 
-hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
-			 u32 physical_addr,
-			 u32 virtual_addr,
+hw_status hw_mmu_pte_set(const u32 pg_tbl_va, phys_addr_t pa, u32 da,
 			 u32 page_sz, struct hw_mmu_map_attrs_t *map_attrs)
 {
 	hw_status status = 0;
@@ -343,10 +338,9 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 
 	switch (page_sz) {
 	case SZ_4K:
-		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr & IOPAGE_MASK);
+		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOPAGE_MASK);
 		pte_val =
-		    ((physical_addr & IOPAGE_MASK) |
+		    ((pa & IOPAGE_MASK) |
 		     (map_attrs->endianism << 9) | (map_attrs->
 						    element_size << 4) |
 		     (map_attrs->mixed_size << 11) | IOPTE_SMALL);
@@ -354,20 +348,18 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 
 	case SZ_64K:
 		num_entries = 16;
-		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr & IOLARGE_MASK);
+		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOLARGE_MASK);
 		pte_val =
-		    ((physical_addr & IOLARGE_MASK) |
+		    ((pa & IOLARGE_MASK) |
 		     (map_attrs->endianism << 9) | (map_attrs->
 						    element_size << 4) |
 		     (map_attrs->mixed_size << 11) | IOPTE_LARGE);
 		break;
 
 	case SZ_1M:
-		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr & IOSECTION_MASK);
+		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSECTION_MASK);
 		pte_val =
-		    ((((physical_addr & IOSECTION_MASK) |
+		    ((((pa & IOSECTION_MASK) |
 		       (map_attrs->endianism << 15) | (map_attrs->
 						       element_size << 10) |
 		       (map_attrs->mixed_size << 17)) & ~0x40000) |
@@ -376,10 +368,9 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 
 	case SZ_16M:
 		num_entries = 16;
-		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr & IOSUPER_MASK);
+		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSUPER_MASK);
 		pte_val =
-		    (((physical_addr & IOSUPER_MASK) |
+		    (((pa & IOSUPER_MASK) |
 		      (map_attrs->endianism << 15) | (map_attrs->
 						      element_size << 10) |
 		      (map_attrs->mixed_size << 17)
@@ -387,9 +378,8 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 		break;
 
 	case HW_MMU_COARSE_PAGE_SIZE:
-		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr & IOPGD_TABLE_MASK);
-		pte_val = (physical_addr & IOPGD_TABLE_MASK) | IOPGD_TABLE;
+		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOPGD_TABLE_MASK);
+		pte_val = (pa & IOPGD_TABLE_MASK) | IOPGD_TABLE;
 		break;
 
 	default:
@@ -402,7 +392,7 @@ hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 	return status;
 }
 
-hw_status hw_mmu_pte_clear(const u32 pg_tbl_va, u32 virtual_addr, u32 page_size)
+hw_status hw_mmu_pte_clear(const u32 pg_tbl_va, u32 da, u32 page_size)
 {
 	hw_status status = 0;
 	u32 pte_addr;
@@ -410,26 +400,22 @@ hw_status hw_mmu_pte_clear(const u32 pg_tbl_va, u32 virtual_addr, u32 page_size)
 
 	switch (page_size) {
 	case SZ_4K:
-		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr & IOPAGE_MASK);
+		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOPAGE_MASK);
 		break;
 
 	case SZ_64K:
 		num_entries = 16;
-		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va,
-					      virtual_addr & IOLARGE_MASK);
+		pte_addr = hw_mmu_pte_addr_l2(pg_tbl_va, da & IOLARGE_MASK);
 		break;
 
 	case SZ_1M:
 	case HW_MMU_COARSE_PAGE_SIZE:
-		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr & IOSECTION_MASK);
+		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSECTION_MASK);
 		break;
 
 	case SZ_16M:
 		num_entries = 16;
-		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va,
-					      virtual_addr & IOSUPER_MASK);
+		pte_addr = hw_mmu_pte_addr_l1(pg_tbl_va, da & IOSUPER_MASK);
 		break;
 
 	default:
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index b034f28..b4f476f 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
@@ -81,42 +81,38 @@ extern hw_status hw_mmu_twl_enable(const void __iomem *base_address);
 extern hw_status hw_mmu_twl_disable(const void __iomem *base_address);
 
 extern hw_status hw_mmu_tlb_add(const void __iomem *base_address,
-				u32 physical_addr,
-				u32 virtual_addr,
-				u32 page_sz,
+				phys_addr_t pa, u32 da, u32 page_sz,
 				u32 entry_num,
 				struct hw_mmu_map_attrs_t *map_attrs,
 				s8 preserved_bit, s8 valid_bit);
 
 /* For PTEs */
-extern hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
-				u32 physical_addr,
-				u32 virtual_addr,
+extern hw_status hw_mmu_pte_set(const u32 pg_tbl_va, phys_addr_t pa, u32 da,
 				u32 page_sz,
 				struct hw_mmu_map_attrs_t *map_attrs);
 
 extern hw_status hw_mmu_pte_clear(const u32 pg_tbl_va,
-				  u32 virtual_addr, u32 page_size);
+				  u32 da, u32 page_size);
 
 void hw_mmu_tlb_flush_all(const void __iomem *base);
 
-static inline u32 hw_mmu_pte_addr_l1(u32 l1_base, u32 va)
+static inline u32 hw_mmu_pte_addr_l1(u32 l1_base, u32 da)
 {
 	u32 pte_addr;
-	u32 va31_to20;
+	u32 da31_to20;
 
-	va31_to20 = va >> (20 - 2);	/* Left-shift by 2 here itself */
-	va31_to20 &= 0xFFFFFFFCUL;
-	pte_addr = l1_base + va31_to20;
+	da31_to20 = da >> (20 - 2);	/* Left-shift by 2 here itself */
+	da31_to20 &= 0xFFFFFFFCUL;
+	pte_addr = l1_base + da31_to20;
 
 	return pte_addr;
 }
 
-static inline u32 hw_mmu_pte_addr_l2(u32 l2_base, u32 va)
+static inline u32 hw_mmu_pte_addr_l2(u32 l2_base, unsigned long da)
 {
 	u32 pte_addr;
 
-	pte_addr = (l2_base & 0xFFFFFC00) | ((va >> 10) & 0x3FC);
+	pte_addr = (l2_base & 0xFFFFFC00) | ((da >> 10) & 0x3FC);
 
 	return pte_addr;
 }
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
index 0d28436..64291cc 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dspdefs.h
@@ -162,10 +162,10 @@ typedef int(*fxn_brd_memwrite) (struct bridge_dev_context
  *      Map a MPU memory region to a DSP/IVA memory space
  *  Parameters:
  *      dev_ctxt:    Handle to Bridge driver defined device info.
- *      ul_mpu_addr:      MPU memory region start address.
- *      virt_addr:      DSP/IVA memory region u8 address.
- *      ul_num_bytes:     Number of bytes to map.
- *      map_attrs:       Mapping attributes (e.g. endianness).
+ *      va:          MPU memory region start address.
+ *      da:          DSP/IVA memory region u8 address.
+ *      bytes:       Number of bytes to map.
+ *      map_attrs:   Mapping attributes (e.g. endianness).
  *  Returns:
  *      0:        Success.
  *      -EPERM:      Other, unspecified error.
@@ -173,11 +173,9 @@ typedef int(*fxn_brd_memwrite) (struct bridge_dev_context
  *      dev_ctxt != NULL;
  *  Ensures:
  */
-typedef int(*fxn_brd_memmap) (struct bridge_dev_context
-				     * dev_ctxt, u32 ul_mpu_addr,
-				     u32 virt_addr, u32 ul_num_bytes,
-				     u32 map_attr,
-				     struct dmm_map_object *map_obj);
+typedef int(*fxn_brd_memmap) (struct bridge_dev_context *dev_ctxt,
+			      unsigned long va, u32 da, size_t bytes,
+			      u32 map_attr, struct dmm_map_object *map_obj);
 
 /*
  *  ======== bridge_brd_mem_un_map ========
@@ -185,8 +183,8 @@ typedef int(*fxn_brd_memmap) (struct bridge_dev_context
  *      UnMap an MPU memory region from DSP/IVA memory space
  *  Parameters:
  *      dev_ctxt:    Handle to Bridge driver defined device info.
- *      virt_addr:      DSP/IVA memory region u8 address.
- *      ul_num_bytes:     Number of bytes to unmap.
+ *      da:          DSP/IVA memory region u8 address.
+ *      bytes:       Number of bytes to unmap.
  *  Returns:
  *      0:        Success.
  *      -EPERM:      Other, unspecified error.
@@ -195,8 +193,8 @@ typedef int(*fxn_brd_memmap) (struct bridge_dev_context
  *  Ensures:
  */
 typedef int(*fxn_brd_memunmap) (struct bridge_dev_context *dev_ctxt,
-				u32 virt_addr, u32 ul_num_bytes,
-				 struct dmm_map_object *map_obj);
+				u32 da, size_t bytes,
+				struct dmm_map_object *map_obj);
 
 /*
  *  ======== bridge_brd_stop ========
-- 
1.7.8.6

