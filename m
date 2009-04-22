From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH] DSPBRIDGE: Replacing custom implementation for Mapping
Date: Tue, 21 Apr 2009 23:00:01 -0500
Message-ID: <1240372801-16785-1-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZDVD5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 23:57:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <x0084701@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ameya Palande <ameya.palande@nokia.com>

From: Omar Ramirez Luna <x0084701@ti.com>

Currently, we walk through the entire page table
translating the addresses from virtual to physical
whenever we map a buffer. This custom implementation
is meant to be optimized for performance, but it bypasses
the standard memory management subsystem.

This patch removes the custom implementation and uses
the kernel APIs to get the virtual to physical maps.

                Map times for DMM

 Buffer | Kernel APIs  | Custom Implement. |
  Size  | time (usec)  |    time (usec)    |
  4  KB |         427  |            396    |
 64  KB |        1038  |            824    |
  1  MB |        9827  |           7110    |
  4  MB |       37811  |          26916    |
  6  MB |       56366  |          39978    |

This patch also contains the following cleanup by Ameya Palande.
1. Coding style improvements
2. Performance improvement by removal of duplicate code, and variables.
3. Bugfix for missing SYNC_LeaveCS() call
4. Extra error checking

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <x0084701@ti.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |  646 ++++++++++++-----------------------
 1 files changed, 219 insertions(+), 427 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index df350c6..9bffc97 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1,4 +1,3 @@
-
 /*
  * tiomap.c
  *
@@ -133,9 +132,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT *pDevContext, u32 dwCmd,
 			IN OUT void *pArgs);
 static DSP_STATUS WMD_DEV_Destroy(struct WMD_DEV_CONTEXT *pDevContext);
-static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
-			u32 ulNumBytes, u32 *numOfTableEntries,
-			u32 *physicalAddrTable);
+static u32 user_va2pa(struct mm_struct *mm, u32 address);
 static DSP_STATUS PteUpdate(struct WMD_DEV_CONTEXT *hDevContext, u32 pa,
 			u32 va, u32 size,
 			struct HW_MMUMapAttrs_t *mapAttrs);
@@ -143,7 +140,7 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 			u32 size, struct HW_MMUMapAttrs_t *attrs);
 static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			u32 ulMpuAddr, u32 ulVirtAddr,
-			u32 ulNumBytes, u32 ulMapAttr);
+			u32 ulNumBytes, struct HW_MMUMapAttrs_t *hwAttrs);
 static DSP_STATUS run_IdleBoot(u32 prcm_base, u32 cm_base,
 			u32 sysctrl_base);
 void GetHWRegs(u32 prcm_base, u32 cm_base);
@@ -270,6 +267,19 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 		tlb_flush_all(pDevContext->dwDSPMmuBase);
 }
 
+static void bad_page_dump(u32 pa, struct page *pg)
+{
+	pr_emerg("DSPBRIDGE: MAP function: COUNT 0 FOR PA 0x%x\n", pa);
+	pr_emerg("Bad page state in process '%s'\n"
+		"page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
+		"Backtrace:\n",
+		current->comm, pg, (int)(2*sizeof(unsigned long)),
+		(unsigned long)pg->flags, pg->mapping,
+		page_mapcount(pg), page_count(pg));
+	dump_stack();
+	BUG();
+}
+
 /*
  *  ======== WMD_DRV_Entry ========
  *  purpose:
@@ -1352,11 +1362,16 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	struct HW_MMUMapAttrs_t hwAttrs;
-	u32 numOfActualTabEntries = 0;
-	u32 *pPhysAddrPageTbl = NULL;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	u32 temp = 0;
+	u32 write = 0;
+	u32 numUsrPgs = 0;
+	struct page *mappedPage, *pg;
+	s32 pgNum;
+	u32 va = ulVirtAddr;
+	struct task_struct *curr_task = current;
+	u32 pgI = 0;
+	u32 mpuAddr, pa;
 
 	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
 		 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
@@ -1394,7 +1409,8 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			hwAttrs.elementSize = HW_ELEM_SIZE_64BIT;
 		} else {
 			/* Mixedsize isn't enabled, so size can't be
-			 * zero here */
+			 * zero here
+			 */
 			DBG_Trace(DBG_LEVEL7,
 				 "WMD_BRD_MemMap: MMU element size is zero\n");
 			return DSP_EINVALIDARG;
@@ -1406,93 +1422,151 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 		hwAttrs.donotlockmpupage = 0;
 
 	if (attrs & DSP_MAPVMALLOCADDR) {
-		status = MemMapVmalloc(hDevContext, ulMpuAddr, ulVirtAddr,
-				       ulNumBytes, ulMapAttr);
-		return status;
+		return MemMapVmalloc(hDevContext, ulMpuAddr, ulVirtAddr,
+				       ulNumBytes, &hwAttrs);
 	}
-	 /* Do OS-specific user-va to pa translation.
+	/*
+	 * Do OS-specific user-va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
-	 * Pass the translated pa to PteUpdate.  */
+	 * Pass the translated pa to PteUpdate.
+	 */
 	if ((attrs & DSP_MAPPHYSICALADDR)) {
 		status = PteUpdate(pDevContext, ulMpuAddr, ulVirtAddr,
 			 ulNumBytes, &hwAttrs);
 		goto func_cont;
 	}
 
-	/* Important Note: ulMpuAddr is mapped from user application process
+	/*
+	 * Important Note: ulMpuAddr is mapped from user application process
 	 * to current process - it must lie completely within the current
-	 * virtual memory address space in order to be of use to us here!  */
+	 * virtual memory address space in order to be of use to us here!
+	 */
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, ulMpuAddr);
-	up_read(&mm->mmap_sem);
 	if (vma)
 		DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf: ulMpuAddr=%x, "
 			"ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x \n",
 			ulMpuAddr, ulNumBytes, vma->vm_start,
 			vma->vm_end, vma->vm_flags);
 
-	/* It is observed that under some circumstances, the user buffer is
+	/*
+	 * It is observed that under some circumstances, the user buffer is
 	 * spread across several VMAs. So loop through and check if the entire
-	 * user buffer is covered */
+	 * user buffer is covered
+	 */
 	while ((vma != NULL) && (ulMpuAddr + ulNumBytes > vma->vm_end)) {
 		/* jump to the next VMA region */
-		down_read(&mm->mmap_sem);
 		vma = find_vma(mm, vma->vm_end + 1);
-		up_read(&mm->mmap_sem);
 		DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf ulMpuAddr=%x, "
                        "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
                        ulMpuAddr, ulNumBytes, vma->vm_start,
                        vma->vm_end, vma->vm_flags);
 	}
-	if (vma == NULL) {
+	if (!vma) {
 		DBG_Trace(DBG_LEVEL7, "Failed to get the VMA region for "
 			  "MPU Buffer !!! \n");
 		status = DSP_EINVALIDARG;
-	}
-	if (DSP_FAILED(status))
+		up_read(&mm->mmap_sem);
 		goto func_cont;
-	pPhysAddrPageTbl = DMM_GetPhysicalAddrTable();
-	/* Build the array with virtual to physical translations */
-	status = TIOMAP_VirtToPhysical(mm, ulMpuAddr, ulNumBytes,
-				&numOfActualTabEntries, pPhysAddrPageTbl);
-	if (DSP_FAILED(status)) {
-		DBG_Trace(DBG_LEVEL7,
-			 "WMD_BRD_MemMap: TIOMAP_VirtToPhysical",
-			 " failed\n");
-		return DSP_EFAIL;
 	}
-	temp = 0;
-	DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap: numOfActualTabEntries=%d, "
-		  "ulNumBytes= %d\n",  numOfActualTabEntries, ulNumBytes);
-	/* Update the DSP MMU table with the physical addresses received from
-       from translation function */
-	while (temp < numOfActualTabEntries) {
-		status = PteSet(pDevContext->pPtAttrs, pPhysAddrPageTbl[temp++],
-				ulVirtAddr, HW_PAGE_SIZE_4KB, &hwAttrs);
-		if (DSP_FAILED(status)) {
-			DBG_Trace(DBG_LEVEL7,
-				 "WMD_BRD_MemMap: FAILED IN PTESET \n");
-			return DSP_EFAIL;
+
+	if (vma->vm_flags & VM_IO) {
+		numUsrPgs =  ulNumBytes / PG_SIZE_4K;
+		mpuAddr = ulMpuAddr;
+		DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap:numOfActualTabEntries=%d,"
+			  "ulNumBytes= %d\n",  numUsrPgs, ulNumBytes);
+		/* Get the physical addresses for user buffer */
+		for (pgI = 0; pgI < numUsrPgs; pgI++) {
+			pa = user_va2pa(mm, mpuAddr);
+			if (!pa) {
+				status = DSP_EFAIL;
+				pr_err("DSPBRIDGE: VM_IO mapping physical"
+						"address is invalid\n");
+				break;
+			}
+			if (pfn_valid(__phys_to_pfn(pa))) {
+				pg = phys_to_page(pa);
+				get_page(pg);
+				if (page_count(pg) < 1) {
+					pr_err("Bad page in VM_IO buffer\n");
+					bad_page_dump(pa, pg);
+				}
+			}
+			status = PteSet(pDevContext->pPtAttrs, pa,
+					va, HW_PAGE_SIZE_4KB, &hwAttrs);
+			if (DSP_FAILED(status)) {
+				DBG_Trace(DBG_LEVEL7,
+					"WMD_BRD_MemMap: FAILED IN VM_IO"
+					"PTESET \n");
+				break;
+			}
+			va += HW_PAGE_SIZE_4KB;
+			mpuAddr += HW_PAGE_SIZE_4KB;
+			pa += HW_PAGE_SIZE_4KB;
+		}
+	} else {
+		numUsrPgs =  ulNumBytes / PG_SIZE_4K;
+		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
+			write = 1;
+
+		for (pgI = 0; pgI < numUsrPgs; pgI++) {
+			pgNum = get_user_pages(curr_task, mm, ulMpuAddr, 1,
+						write, 1, &mappedPage, NULL);
+			if (pgNum > 0) {
+				if (page_count(mappedPage) < 1) {
+					pr_err("Bad page count after doing"
+							"get_user_pages on"
+							"user buffer\n");
+					bad_page_dump(page_to_phys(mappedPage),
+								mappedPage);
+				}
+				status = PteSet(pDevContext->pPtAttrs,
+					page_to_phys(mappedPage), va,
+					HW_PAGE_SIZE_4KB, &hwAttrs);
+				if (DSP_FAILED(status)) {
+					DBG_Trace(DBG_LEVEL7,
+					"WMD_BRD_MemMap: FAILED IN PTESET \n");
+					break;
+				}
+				va += HW_PAGE_SIZE_4KB;
+				ulMpuAddr += HW_PAGE_SIZE_4KB;
+			} else {
+				pr_err("DSPBRIDGE: get_user_pages FAILED,"
+						"MPU addr = 0x%x,"
+						"vma->vm_flags = 0x%lx,"
+						"get_user_pages Err"
+						"Value = %d, Buffer"
+						"size=0x%x\n", ulMpuAddr,
+						vma->vm_flags, pgNum,
+						ulNumBytes);
+				status = DSP_EFAIL;
+				break;
+			}
 		}
-		ulVirtAddr += HW_PAGE_SIZE_4KB;
 	}
-	if (DSP_FAILED(status))
-		DBG_Trace(DBG_LEVEL5, "WMD_BRD_MemMap: PteSet failed \n");
-	else
-		DBG_Trace(DBG_LEVEL5, "WMD_BRD_MemMap: PteSet passed \n");
-
+	up_read(&mm->mmap_sem);
 func_cont:
 	/* Don't propogate Linux or HW status to upper layers */
 	if (DSP_SUCCEEDED(status)) {
 		status = DSP_SOK;
 	} else {
 		DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap status %x\n", status);
+		/*
+		 * Roll out the mapped pages incase it failed in middle of
+		 * mapping
+		 */
+		if (pgI) {
+			WMD_BRD_MemUnMap(pDevContext, ulVirtAddr,
+						(pgI * PG_SIZE_4K));
+		}
 		status = DSP_EFAIL;
 	}
-	 /* In any case, flush the TLB
+	/*
+	 * In any case, flush the TLB
 	 * This is called from here instead from PteUpdate to avoid unnecessary
 	 * repetition while mapping non-contiguous physical regions of a virtual
-	 * region */
+	 * region
+	 */
 	flush_all(pDevContext);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
 	return status;
@@ -1550,16 +1624,20 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 		pteVal = *(u32 *)pteAddrL1;
 		pteSize = HW_MMU_PteSizeL1(pteVal);
 		if (pteSize == HW_MMU_COARSE_PAGE_SIZE) {
-			/* Get the L2 PA from the L1 PTE, and find
-			 * corresponding L2 VA */
+			/*
+			 * Get the L2 PA from the L1 PTE, and find
+			 * corresponding L2 VA
+			 */
 			L2BasePa = HW_MMU_PteCoarseL1(pteVal);
 			L2BaseVa = L2BasePa - pt->L2BasePa + pt->L2BaseVa;
 			L2PageNum = (L2BasePa - pt->L2BasePa) /
 				    HW_MMU_COARSE_PAGE_SIZE;
-			 /* Find the L2 PTE address from which we will start
+			/*
+			 * Find the L2 PTE address from which we will start
 			 * clearing, the number of PTEs to be cleared on this
 			 * page, and the size of VA space that needs to be
-			 * cleared on this L2 page */
+			 * cleared on this L2 page
+			 */
 			pteAddrL2 = HW_MMU_PteAddrL2(L2BaseVa, vaCurr);
 			pteCount = pteAddrL2 & (HW_MMU_COARSE_PAGE_SIZE - 1);
 			pteCount = (HW_MMU_COARSE_PAGE_SIZE - pteCount) /
@@ -1571,12 +1649,14 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2BasePa %x, "
 				  "L2BaseVa %x pteAddrL2 %x, remBytesL2 %x\n",
 				  L2BasePa, L2BaseVa, pteAddrL2, remBytesL2);
-			 /* Unmap the VA space on this L2 PT. A quicker way
+			/*
+			 * Unmap the VA space on this L2 PT. A quicker way
 			 * would be to clear pteCount entries starting from
 			 * pteAddrL2. However, below code checks that we don't
 			 * clear invalid entries or less than 64KB for a 64KB
 			 * entry. Similar checking is done for L1 PTEs too
-			 * below */
+			 * below
+			 */
 			while (remBytesL2 && (DSP_SUCCEEDED(status))) {
 				pteVal = *(u32 *)pteAddrL2;
 				pteSize = HW_MMU_PteSizeL2(pteVal);
@@ -1595,7 +1675,6 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 									pAddr;
 						pAddr += HW_PAGE_SIZE_4KB;
 					}
-
 					if (HW_MMU_PteClear(pteAddrL2,
 						vaCurr, pteSize) == RET_OK) {
 						status = DSP_SOK;
@@ -1615,13 +1694,16 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			if (remBytesL2 == 0) {
 				pt->pgInfo[L2PageNum].numEntries -= pteCount;
 				if (pt->pgInfo[L2PageNum].numEntries == 0) {
-					/* Clear the L1 PTE pointing to the
-					 * L2 PT */
+					/*
+					 * Clear the L1 PTE pointing to the
+					 * L2 PT
+					 */
 					if (RET_OK == HW_MMU_PteClear(L1BaseVa,
 					vaCurrOrig, HW_MMU_COARSE_PAGE_SIZE))
 						status = DSP_SOK;
 					else {
 						status = DSP_EFAIL;
+						SYNC_LeaveCS(pt->hCSObj);
 						goto EXIT_LOOP;
 					}
 				}
@@ -1639,8 +1721,19 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			/* pteSize = 1 MB or 16 MB */
 			if ((pteSize != 0) && (remBytes >= pteSize) &&
 			   !(vaCurr & (pteSize - 1))) {
-				if (HW_MMU_PteClear(L1BaseVa,
-					vaCurr, pteSize) == RET_OK) {
+				if (pteSize == HW_PAGE_SIZE_1MB)
+					numof4KPages = 256;
+				else
+					numof4KPages = 4096;
+				temp = 0;
+				/* Collect Physical addresses from VA */
+				pAddr = (pteVal & ~(pteSize - 1));
+				while (temp++ < numof4KPages) {
+					pPhysAddrPageTbl[pacount++] = pAddr;
+					pAddr += HW_PAGE_SIZE_4KB;
+				}
+				if (HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize)
+					       == RET_OK) {
 					status = DSP_SOK;
 					remBytes -= pteSize;
 					vaCurr += pteSize;
@@ -1652,23 +1745,25 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			status = DSP_EFAIL;
 		}
 	}
-	 /* It is better to flush the TLB here, so that any stale old entries
-	 * get flushed */
+	/*
+	 * It is better to flush the TLB here, so that any stale old entries
+	 * get flushed
+	 */
 EXIT_LOOP:
 	flush_all(pDevContext);
-	temp = 0;
-	while (temp < pacount) {
+	for (temp = 0; temp < pacount; temp++) {
 		patemp = pPhysAddrPageTbl[temp];
 		if (pfn_valid(__phys_to_pfn(patemp))) {
 			pg = phys_to_page(patemp);
-			if (page_count(pg) < 1)
-				printk(KERN_INFO "DSPBRIDGE:UNMAP function: "
-					"COUNT 0 FOR PA 0x%x, size = 0x%x\n",
-					patemp, ulNumBytes);
+			if (page_count(pg) < 1) {
+				pr_info("DSPBRIDGE:UNMAP function: COUNT 0"
+						"FOR PA 0x%x, size = 0x%x\n",
+						patemp, ulNumBytes);
+				bad_page_dump(patemp, pg);
+			}
 			SetPageDirty(pg);
 			page_cache_release(pg);
 		}
-		temp++;
 	}
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
@@ -1676,263 +1771,36 @@ EXIT_LOOP:
 		  "remBytesL2 %x\n", status, remBytes, remBytesL2);
 	return status;
 }
+
 /*
- * ========= TIOMAP_VirtToPhysical ==========
- * Purpose:
- * 		This function builds the array with virtual to physical
- *	    address translation
+ *  ======== user_va2pa ========
+ *  Purpose:
+ *      This function walks through the Linux page tables to convert a userland
+ *      virtual address to physical address
  */
-static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
-					u32 ulNumBytes,
-					u32 *numOfTableEntries,
-					u32 *physicalAddrTable)
+static u32 user_va2pa(struct mm_struct *mm, u32 address)
 {
-	u32 pAddr;
-	u32 chunkSz;
-	DSP_STATUS status = DSP_SOK;
-	volatile u32 pteVal;
-	u32 pteSize;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	volatile pte_t *ptep;
-	u32 numEntries = 0;
-	u32 numof4KPages = 0;
-	u32 phyEntryCounter = 0;
-	u32 temp = 0;
-	u32 numUsrPgs;
-	struct task_struct *curr_task = current;
-	struct vm_area_struct *vma;
-	u32  write = 0;
-
-
-	DBG_Trace(DBG_ENTER, "TIOMAP_VirtToPhysical: START:ulMpuAddr=%x, "
-		  "ulNumBytes=%x\n", ulMpuAddr, ulNumBytes);
-	if (physicalAddrTable == NULL)
-		return DSP_EMEMORY;
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, ulMpuAddr);
-	up_read(&mm->mmap_sem);
-
-	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
-		write = 1;
-	while (ulNumBytes) {
-		DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:Read the next PGD "
-			  "and PMD entry\n");
-		numEntries = 0;
-		/* Get the first level page table entry information */
-		/* Read the pointer to first level page table entry */
-		pgd = pgd_offset(mm, ulMpuAddr);
-		/* Read the value in the first level page table entry */
-		pteVal = *(u32 *)pgd;
-		/* Find the page size that is pointed by the first level page
-		 * table entry */
-		pteSize = HW_MMU_PteSizeL1(pteVal); /* update 16 or 1 */
-		/* If pteSize is zero, then call the get_user_pages to create
-		 * the page table entries for this buffer
-		 */
-		if (!pteSize) {
-			down_read(&mm->mmap_sem);
-			/* This call invokes handle_mmu _fault call, which
-			 *causes all pages to be created before we scan the
-			 * page tables
-			 */
-			numUsrPgs = get_user_pages(curr_task, mm, ulMpuAddr, 1,
-							write, 1, NULL, NULL);
-			up_read(&mm->mmap_sem);
-			/* Get the first level page table entry information */
-			/* Read the pointer to first level page table entry */
-			pgd = pgd_offset(mm, ulMpuAddr);
-			/* Read the value in the first level page table entry*/
-			pteVal = *(u32 *)pgd;
-			/* Find the page size that is pointed by the first level
-			 * page table entry
-			 */
-			pteSize = HW_MMU_PteSizeL1(pteVal);
-			DBG_Trace(DBG_LEVEL4, "First level  get_user_pages "
-							"called\n");
-		}
-		/* If the page size is 4K or 64K, then we have to traverse to
-		 * second level page table */
-		if (pteSize == HW_MMU_COARSE_PAGE_SIZE) {
-			DBG_Trace(DBG_LEVEL5, "Read the next PMD entry\n");
-			/* Get the second level page table information */
-			pmd = pmd_offset(pgd, ulMpuAddr);
-			ptep = pte_offset_map(pmd, ulMpuAddr);
-			do {
-				ptep = ptep+numEntries;
-				/* Read the value of second level page table
-				 * entry */
-				pteVal = *(u32 *)ptep;
-				/* Find the size of page the second level
-				 * table entry is pointing */
-				/* update 64 or 4 */
-				pteSize = HW_MMU_PteSizeL2(pteVal);
-				/* If pteSize is invalid, then call
-				 * get_user_pages to create the
-				 * page table entries
-				 */
-				if (!pteSize) {
-					numUsrPgs =
-						(ulNumBytes/HW_PAGE_SIZE_4KB);
-					down_read(&mm->mmap_sem);
-					/* This call invokes
-					 *handle_mmu _fault call, which causes
-					 *all pages to be created before we scan
-					 * the page tables */
-					if (numUsrPgs <= PAGES_II_LVL_TABLE) {
-						get_user_pages(curr_task, mm,
-						ulMpuAddr, numUsrPgs, write,  1,
-						NULL, NULL);
-						DBG_Trace(DBG_LEVEL4,
-						"get_user_pages, numUsrPgs"
-						"= %d\n", numUsrPgs);
-					} else {
-						get_user_pages(curr_task, mm,
-						ulMpuAddr, PAGES_II_LVL_TABLE,
-						write, 1, NULL, NULL);
-						DBG_Trace(DBG_LEVEL4,
-						"get_user_pages, numUsrPgs"
-						"= %d\n", PAGES_II_LVL_TABLE);
-					}
-					up_read(&mm->mmap_sem);
-					/* Read the value of second level page
-					 * table  entry */
-					pteVal = *(u32 *)ptep;
-					/* Find the size of page the second
-					 * level table entry is pointing */
-					pteSize = HW_MMU_PteSizeL2(pteVal);
-				}
-				DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:"
-					"*pmd=%x, *pgd=%x, ptep = %x, pteVal="
-					" %x, pteSize=%x\n", *pmd,
-					*(u32 *)pgd, (u32)ptep, pteVal,
-					pteSize);
-
-				/* Extract the physical Addresses */
-				switch (pteSize) {
-				case HW_PAGE_SIZE_64KB:
-					pAddr = pteVal & MMU_LARGE_PAGE_MASK;
-					chunkSz = HW_PAGE_SIZE_64KB;
-					numEntries = 16;
-					if (ulNumBytes >= HW_PAGE_SIZE_64KB)
-						numof4KPages = 16;
-					else {
-						numof4KPages = ulNumBytes /
-							HW_PAGE_SIZE_4KB;
-					}
-					break;
-				case HW_PAGE_SIZE_4KB:
-					pAddr = pteVal & MMU_SMALL_PAGE_MASK;
-					chunkSz = HW_PAGE_SIZE_4KB;
-					numEntries = 1;
-					numof4KPages = 1;
-					break;
-				default:
-					DBG_Trace(DBG_LEVEL7,
-						"TIOMAP_VirtToPhysical:"
-						"Descriptor"
-						"Format Fault-II level,"
-						" PTE size = %x\n",
-						pteSize);
-					return DSP_EFAIL;
-				}
-				temp = 0;
-				while (temp++ < numof4KPages) {
-					physicalAddrTable[phyEntryCounter++] =
-									pAddr;
-					DBG_Trace(DBG_LEVEL4,
-						 "TIOMAP_VirtToPhysical:"
-						 "physicalAddrTable[%d]= %x\n",
-						 (phyEntryCounter-1), pAddr);
-					pAddr += HW_PAGE_SIZE_4KB;
-				}
-				if (DSP_SUCCEEDED(status)) {
-					/* Go to the next page */
-					ulMpuAddr += chunkSz;
-					/* Update the number of bytes that
-					 * are copied */
-					if (chunkSz > ulNumBytes)
-						ulNumBytes = 0;
-					else
-						ulNumBytes -= chunkSz;
-					DBG_Trace(DBG_LEVEL4,
-						"TIOMAP_VirtToPhysical: mpuCurr"
-						" = %x, pagesize = %x, "
-						"numBytesRem=%x\n",
-						ulMpuAddr, chunkSz, ulNumBytes);
-				} else {
-					DBG_Trace(DBG_LEVEL7,
-					     " TIOMAP_VirtToPhysical:PTEupdate"
-					     "failed\n");
-				}
-			/* It is observed that the pgd value (first level page
-			 * table entry) is changed after reading the 512
-			 * entries in second level table. So, call the pgd
-			 * functions after reaching 512 entries in second
-			 * level table */
-			} while ((ulMpuAddr & 0x001ff000) && (ulNumBytes));
-		} else {
-			/* Extract the Address to update the IVA MMU table
-			 * with */
-			switch (pteSize) {
-			case HW_PAGE_SIZE_16MB:
-				pAddr = pteVal & MMU_SSECTION_ADDR_MASK;
-				if (ulNumBytes >= HW_PAGE_SIZE_16MB) {
-					chunkSz = HW_PAGE_SIZE_16MB;
-					numEntries = 16;
-					numof4KPages = 4096;
-				} else {
-					chunkSz = HW_PAGE_SIZE_1MB;
-					numEntries = 1;
-					numof4KPages = 256;
-				}
-				break;
-			case HW_PAGE_SIZE_1MB:
-				pAddr = pteVal & MMU_SECTION_ADDR_MASK;
-					chunkSz = HW_PAGE_SIZE_1MB;
-					numEntries = 1;
-					numof4KPages = 256;
-					break;
-			default:
-				DBG_Trace(DBG_LEVEL7,
-				     "TIOMAP_VirtToPhysical:Descriptor"
-				     "Format Faul-I level, PTE size = "
-				     "%x\n", pteSize);
-				return DSP_EFAIL;
+	pte_t *ptep, pte;
+
+	pgd = pgd_offset(mm, address);
+	if (!(pgd_none(*pgd) || pgd_bad(*pgd))) {
+		pmd = pmd_offset(pgd, address);
+		if (!(pmd_none(*pmd) || pmd_bad(*pmd))) {
+			ptep = pte_offset_map(pmd, address);
+			if (ptep) {
+				pte = *ptep;
+				if (pte_present(pte))
+					return pte & PAGE_MASK;
 			}
-			temp = 0;
-			while (temp++ < numof4KPages) {
-					physicalAddrTable[phyEntryCounter++] =
-									 pAddr;
-					DBG_Trace(DBG_LEVEL4,
-						 "TIOMAP_VirtToPhysical:"
-						 "physicalAddrTable[%d]= %x\n",
-						 (phyEntryCounter-1), pAddr);
-					pAddr += HW_PAGE_SIZE_4KB;
-			}
-			if (DSP_SUCCEEDED(status)) {
-				/* Go to the next page */
-				ulMpuAddr += chunkSz;
-				/* Update the number of bytes that are copied */
-				ulNumBytes -= chunkSz;
-				DBG_Trace(DBG_LEVEL4,
-					 "TIOMAP_VirtToPhysical: mpuCurr = %x, "
-					 "pagesize = %x, numBytesRem=%x\n",
-					 ulMpuAddr, chunkSz, ulNumBytes);
-			} else {
-				DBG_Trace(DBG_LEVEL7,
-					 " TIOMAP_VirtToPhysical:PTEupdate"
-					 "failed\n");
-			}
-
 		}
 	}
-	*numOfTableEntries = phyEntryCounter;
-	DBG_Trace(DBG_LEVEL4, " TIOMAP_VirtToPhysical:numofTableEntries=%d\n",
-		  phyEntryCounter);
-	return status;
+
+	return 0;
 }
 
+
 /*
  *  ======== PteUpdate ========
  *      This function calculates the optimum page-aligned addresses and sizes
@@ -2000,64 +1868,9 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 	u32 L2BaseVa = 0;
 	u32 L2BasePa = 0;
 	u32 L2PageNum = 0;
-	u32 num4KEntries = 0;
-	u32 temp = 0;
-	struct page *pg = NULL;
-	u32 patemp;
-
 	DSP_STATUS status = DSP_SOK;
 	DBG_Trace(DBG_ENTER, "> PteSet pPgTableAttrs %x, pa %x, va %x, "
 		 "size %x, attrs %x\n", pt, pa, va, size, attrs);
-	/* Lock the MPU pages that are getting mapped if this
-	 * attribute is set */
-	if (attrs->donotlockmpupage == 0) {
-		switch (size) {
-		case HW_PAGE_SIZE_64KB:
-			num4KEntries = 16;
-			break;
-		case HW_PAGE_SIZE_4KB:
-			num4KEntries = 1;
-			break;
-		case HW_PAGE_SIZE_16MB:
-			num4KEntries = 4096;
-			break;
-		case HW_PAGE_SIZE_1MB:
-			num4KEntries = 256;
-			break;
-		default:
-			return DSP_EFAIL;
-		}
-		patemp = pa;
-		while (temp++ < num4KEntries) {
-			/* FIXME: This is a hack to avoid getting pages for
-			 *  video overlay		*/
-			if (pfn_valid(__phys_to_pfn(patemp))) {
-				pg = phys_to_page(patemp);
-				get_page(pg);
-			}
-			if (page_count(pg) < 1) {
-				printk(KERN_EMERG "DSPBRIDGE:MAP  function: "
-					"COUNT 0 FOR PA 0x%x\n", patemp);
-				printk(KERN_EMERG "Bad page state"
-					KERN_EMERG "in process '%s'\n"
-					KERN_EMERG "page:%p flags:0x%0*lx "
-					KERN_EMERG "mapping:%p mapcount:%d "
-					KERN_EMERG "count:%d\n"
-					KERN_EMERG "Trying to fix it up, but "
-					KERN_EMERG "a reboot is needed\n"
-					KERN_EMERG "Backtrace:\n",
-					current->comm, pg,
-					(int)(2*sizeof(unsigned long)),
-					(unsigned long)pg->flags, pg->mapping,
-					page_mapcount(pg), page_count(pg));
-				dump_stack();
-				BUG_ON(1);
-			}
-
-			patemp += HW_PAGE_SIZE_4KB;
-		}
-	}
-	attrs->donotlockmpupage = 0;
 	L1BaseVa = pt->L1BaseVa;
 	pgTblVa = L1BaseVa;
 	if ((size == HW_PAGE_SIZE_64KB) || (size == HW_PAGE_SIZE_4KB)) {
@@ -2108,7 +1921,6 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 				pt->pgInfo[L2PageNum].numEntries += 16;
 			else
 				pt->pgInfo[L2PageNum].numEntries++;
-
 			DBG_Trace(DBG_LEVEL1, "L2 BaseVa %x, BasePa %x, "
 				 "PageNum %x numEntries %x\n", L2BaseVa,
 				 L2BasePa, L2PageNum,
@@ -2129,14 +1941,11 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
-				u32 ulMpuAddr, u32 ulVirtAddr,
-				u32 ulNumBytes, u32 ulMapAttr)
+static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
+				u32 ulMpuAddr, u32 ulVirtAddr, u32 ulNumBytes,
+				struct HW_MMUMapAttrs_t *hwAttrs)
 {
-	u32 attrs = ulMapAttr;
 	DSP_STATUS status = DSP_SOK;
-	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-	struct HW_MMUMapAttrs_t hwAttrs;
 	struct page *pPage[1];
 	u32 i;
 	u32 paCurr;
@@ -2144,59 +1953,35 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 vaCurr;
 	u32 sizeCurr;
 	u32 numPages;
+	u32 pa;
+	u32 numOf4KPages;
+	u32 temp = 0;
 
 	DBG_Trace(DBG_ENTER, "> MemMapVmalloc hDevContext %x, pa %x, va %x, "
-		  "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr,
-		  ulVirtAddr, ulNumBytes, ulMapAttr);
-	/* Take mapping properties */
-	if (attrs & DSP_MAPBIGENDIAN)
-		hwAttrs.endianism = HW_BIG_ENDIAN;
-	else
-		hwAttrs.endianism = HW_LITTLE_ENDIAN;
+		  "size %x\n", pDevContext, ulMpuAddr, ulVirtAddr, ulNumBytes);
 
-	hwAttrs.mixedSize = (enum HW_MMUMixedSize_t)
-			     ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
-	/* Ignore elementSize if mixedSize is enabled */
-	if (hwAttrs.mixedSize == 0) {
-		if (attrs & DSP_MAPELEMSIZE8) {
-			/* Size is 8 bit */
-			hwAttrs.elementSize = HW_ELEM_SIZE_8BIT;
-		} else if (attrs & DSP_MAPELEMSIZE16) {
-			/* Size is 16 bit */
-			hwAttrs.elementSize = HW_ELEM_SIZE_16BIT;
-		} else if (attrs & DSP_MAPELEMSIZE32) {
-			/* Size is 32 bit */
-			hwAttrs.elementSize = HW_ELEM_SIZE_32BIT;
-		} else if (attrs & DSP_MAPELEMSIZE64) {
-			/* Size is 64 bit */
-			hwAttrs.elementSize = HW_ELEM_SIZE_64BIT;
-		} else {
-			/* Mixedsize isn't enabled, so size can't be zero
-			 * here */
-			DBG_Trace(DBG_LEVEL7, "WMD_BRD_MemMap: MMU element "
-				 "size is zero\n");
-			return DSP_EINVALIDARG;
-		}
-	}
-	 /* Do Kernel va to pa translation.
+	/*
+	 * Do Kernel va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
-	 * Pass the translated pa to PteUpdate.  */
+	 * Pass the translated pa to PteUpdate.
+	 */
 	numPages = ulNumBytes / PAGE_SIZE; /* PAGE_SIZE = OS page size */
-	if (DSP_FAILED(status))
-		goto func_cont;
-
 	i = 0;
 	vaCurr = ulMpuAddr;
 	pPage[0] = vmalloc_to_page((void *)vaCurr);
 	paNext = page_to_phys(pPage[0]);
 	while (DSP_SUCCEEDED(status) && (i < numPages)) {
-		/* Reuse paNext from the previous iteraion to avoid
-		 * an extra va2pa call */
+		/*
+		 * Reuse paNext from the previous iteraion to avoid
+		 * an extra va2pa call
+		 */
 		paCurr = paNext;
 		sizeCurr = PAGE_SIZE;
-		/* If the next page is physically contiguous,
+		/*
+		 * If the next page is physically contiguous,
 		 * map it with the current one by increasing
-		 * the size of the region to be mapped */
+		 * the size of the region to be mapped
+		 */
 		while (++i < numPages) {
 			pPage[0] = vmalloc_to_page((void *)(vaCurr + sizeCurr));
 			paNext = page_to_phys(pPage[0]);
@@ -2212,11 +1997,16 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			status = DSP_EMEMORY;
 			break;
 		}
+		pa = paCurr;
+		numOf4KPages = sizeCurr / HW_PAGE_SIZE_4KB;
+		while (temp++ < numOf4KPages) {
+			get_page(phys_to_page(pa));
+			pa += HW_PAGE_SIZE_4KB;
+		}
 		status = PteUpdate(pDevContext, paCurr, ulVirtAddr +
-				  (vaCurr - ulMpuAddr), sizeCurr, &hwAttrs);
+				  (vaCurr - ulMpuAddr), sizeCurr, hwAttrs);
 		vaCurr += sizeCurr;
 	}
-func_cont:
 	/* Don't propogate Linux or HW status to upper layers */
 	if (DSP_SUCCEEDED(status)) {
 		status = DSP_SOK;
@@ -2226,12 +2016,14 @@ func_cont:
 		DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap status %x\n", status);
 		status = DSP_EFAIL;
 	}
-	 /* In any case, flush the TLB
+	/*
+	 * In any case, flush the TLB
 	 * This is called from here instead from PteUpdate to avoid unnecessary
 	 * repetition while mapping non-contiguous physical regions of a virtual
-	 * region */
+	 * region
+	 */
 	flush_all(pDevContext);
-	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", status);
+	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap at end status %x\n", status);
 	return status;
 }
 
-- 
1.5.4.3

