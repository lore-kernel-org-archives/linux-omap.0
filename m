From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Various fixes for tiomap3430.c
Date: Tue, 21 Apr 2009 19:59:36 +0300
Message-ID: <1240333176-28612-1-git-send-email-ameya.palande@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A530404A77DC7@dlee03.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62175 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZDUQ75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 12:59:57 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530404A77DC7@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com
Cc: linux-omap@vger.kernel.org

This patch does following things:
1. Coding style improvements
2. Performance improvement by removal of duplicate code, and variables.
3. Bugfix for missing SYNC_LeaveCS() call
4. Extra error checking

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |  219 ++++++++++++++++-------------------
 1 files changed, 102 insertions(+), 117 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 6327c7d..c12017f 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -140,7 +140,7 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 			u32 size, struct HW_MMUMapAttrs_t *attrs);
 static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			u32 ulMpuAddr, u32 ulVirtAddr,
-			u32 ulNumBytes, u32 ulMapAttr);
+			u32 ulNumBytes, struct HW_MMUMapAttrs_t *hwAttrs);
 static DSP_STATUS run_IdleBoot(u32 prcm_base, u32 cm_base,
 			u32 sysctrl_base);
 void GetHWRegs(u32 prcm_base, u32 cm_base);
@@ -267,19 +267,17 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 		tlb_flush_all(pDevContext->dwDSPMmuBase);
 }
 
-void badpagedump(u32 pa, struct page *pg)
+static void bad_page_dump(u32 pa, struct page *pg)
 {
-	printk(KERN_EMERG "DSPBRIDGE:MAP  function: COUNT 0 FOR PA 0x%x\n", pa);
-	printk(KERN_EMERG "Bad page state in process '%s'\n"
+	pr_emerg("DSPBRIDGE: MAP function: COUNT 0 FOR PA 0x%x\n", pa);
+	pr_emerg("Bad page state in process '%s'\n"
 		"page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
-		"Trying to fix it up, but a reboot is needed\n"
 		"Backtrace:\n",
 		current->comm, pg, (int)(2*sizeof(unsigned long)),
 		(unsigned long)pg->flags, pg->mapping,
 		page_mapcount(pg), page_count(pg));
 	dump_stack();
-	BUG_ON(1);
-
+	BUG();
 }
 
 /*
@@ -1366,7 +1364,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 	struct HW_MMUMapAttrs_t hwAttrs;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	u32  write = 0;
+	u32 write = 0;
 	u32 numUsrPgs = 0;
 	struct page *mappedPage, *pg;
 	s32 pgNum;
@@ -1411,7 +1409,8 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			hwAttrs.elementSize = HW_ELEM_SIZE_64BIT;
 		} else {
 			/* Mixedsize isn't enabled, so size can't be
-			 * zero here */
+			 * zero here
+			 */
 			DBG_Trace(DBG_LEVEL7,
 				 "WMD_BRD_MemMap: MMU element size is zero\n");
 			return DSP_EINVALIDARG;
@@ -1423,22 +1422,25 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
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
 	if (vma)
@@ -1447,9 +1449,11 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
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
 		vma = find_vma(mm, vma->vm_end + 1);
@@ -1458,45 +1462,42 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
                        ulMpuAddr, ulNumBytes, vma->vm_start,
                        vma->vm_end, vma->vm_flags);
 	}
-	if (vma == NULL) {
+	if (!vma) {
 		DBG_Trace(DBG_LEVEL7, "Failed to get the VMA region for "
 			  "MPU Buffer !!! \n");
 		status = DSP_EINVALIDARG;
-	}
-	if (DSP_FAILED(status)) {
 		up_read(&mm->mmap_sem);
 		goto func_cont;
 	}
 
 	if (vma->vm_flags & VM_IO) {
-		numUsrPgs =  ulNumBytes/PG_SIZE_4K;
+		numUsrPgs =  ulNumBytes / PG_SIZE_4K;
 		mpuAddr = ulMpuAddr;
 		DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap:numOfActualTabEntries=%d,"
 			  "ulNumBytes= %d\n",  numUsrPgs, ulNumBytes);
 		/* Get the physical addresses for user buffer */
 		for (pgI = 0; pgI < numUsrPgs; pgI++) {
 			pa = user_va2pa(mm, mpuAddr);
-			if (pa == 0) {
+			if (!pa) {
 				status = DSP_EFAIL;
-				printk(KERN_ERR "DSPBRIDGE: VM_IO mapping"
-					"physicaladdress is invalid\n");
+				pr_err("DSPBRIDGE: VM_IO mapping physical"
+						"address is invalid\n");
 				break;
 			}
 			if (pfn_valid(__phys_to_pfn(pa))) {
 				pg = phys_to_page(pa);
 				get_page(pg);
 				if (page_count(pg) <= 1) {
-					printk(KERN_ERR "Bad page in VM_IO"
-						" buffer\n");
-					badpagedump(pa, pg);
+					pr_err("Bad page in VM_IO buffer\n");
+					bad_page_dump(pa, pg);
 				}
 			}
 			status = PteSet(pDevContext->pPtAttrs, pa,
 					va, HW_PAGE_SIZE_4KB, &hwAttrs);
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7,
-					 "WMD_BRD_MemMap: FAILED IN VM_IO"
-				"PTESET \n");
+					"WMD_BRD_MemMap: FAILED IN VM_IO"
+					"PTESET \n");
 				break;
 			}
 			va += HW_PAGE_SIZE_4KB;
@@ -1504,7 +1505,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			pa += HW_PAGE_SIZE_4KB;
 		}
 	} else {
-		numUsrPgs =  ulNumBytes/PG_SIZE_4K;
+		numUsrPgs =  ulNumBytes / PG_SIZE_4K;
 		if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
 			write = 1;
 
@@ -1513,10 +1514,10 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 						write, 1, &mappedPage, NULL);
 			if (pgNum > 0) {
 				if (page_count(mappedPage) <= 1) {
-					printk(KERN_ERR "Bad page count"
-						"after doing get_user_pages on"
-					"user buffer\n");
-					badpagedump(page_to_phys(mappedPage),
+					pr_err("Bad page count after doing"
+							"get_user_pages on"
+							"user buffer\n");
+					bad_page_dump(page_to_phys(mappedPage),
 								mappedPage);
 				}
 				status = PteSet(pDevContext->pPtAttrs,
@@ -1530,12 +1531,14 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 				va += HW_PAGE_SIZE_4KB;
 				ulMpuAddr += HW_PAGE_SIZE_4KB;
 			} else {
-				printk(KERN_ERR "DSPBRIDGE: get_user_pages"
-					"FAILED, MPU addr = 0x%x,"
-					"vma->vm_flags = 0x%lx,"
-					"get_user_pages Err Value = %d,"
-					"Buffer size=0x%x\n", ulMpuAddr,
-					vma->vm_flags, pgNum, ulNumBytes);
+				pr_err("DSPBRIDGE: get_user_pages FAILED,"
+						"MPU addr = 0x%x,"
+						"vma->vm_flags = 0x%lx,"
+						"get_user_pages Err"
+						"Value = %d, Buffer"
+						"size=0x%x\n", ulMpuAddr,
+						vma->vm_flags, pgNum,
+						ulNumBytes);
 				status = DSP_EFAIL;
 				break;
 			}
@@ -1556,13 +1559,14 @@ func_cont:
 			WMD_BRD_MemUnMap(pDevContext, ulVirtAddr,
 						(pgI * PG_SIZE_4K));
 		}
-
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
@@ -1620,16 +1624,20 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
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
@@ -1641,12 +1649,14 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
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
@@ -1684,13 +1694,16 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
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
@@ -1716,12 +1729,11 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 				/* Collect Physical addresses from VA */
 				pAddr = (pteVal & ~(pteSize - 1));
 				while (temp++ < numof4KPages) {
-					pPhysAddrPageTbl[pacount++] =
-								pAddr;
+					pPhysAddrPageTbl[pacount++] = pAddr;
 					pAddr += HW_PAGE_SIZE_4KB;
 				}
-				if (HW_MMU_PteClear(L1BaseVa,
-					vaCurr, pteSize) == RET_OK) {
+				if (HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize)
+					       == RET_OK) {
 					status = DSP_SOK;
 					remBytes -= pteSize;
 					vaCurr += pteSize;
@@ -1733,23 +1745,25 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
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
+	for (temp=0; temp < pacount; temp++) {
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
@@ -1757,6 +1771,7 @@ EXIT_LOOP:
 		  "remBytesL2 %x\n", status, remBytes, remBytesL2);
 	return status;
 }
+
 /*
  *  ======== user_va2pa ========
  *  Purpose:
@@ -1765,7 +1780,6 @@ EXIT_LOOP:
  */
 static u32 user_va2pa(struct mm_struct *mm, u32 address)
 {
-
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
@@ -1927,14 +1941,11 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
+static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *pDevContext,
 				u32 ulMpuAddr, u32 ulVirtAddr,
-				u32 ulNumBytes, u32 ulMapAttr)
+				u32 ulNumBytes, struct HW_MMUMapAttrs_t *hwAttrs)
 {
-	u32 attrs = ulMapAttr;
 	DSP_STATUS status = DSP_SOK;
-	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-	struct HW_MMUMapAttrs_t hwAttrs;
 	struct page *pPage[1];
 	u32 i;
 	u32 paCurr;
@@ -1947,57 +1958,30 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 temp = 0;
 
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
@@ -2014,16 +1998,15 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
 			break;
 		}
 		pa = paCurr;
-		numOf4KPages = sizeCurr/HW_PAGE_SIZE_4KB;
+		numOf4KPages = sizeCurr / HW_PAGE_SIZE_4KB;
 		while (temp++ < numOf4KPages) {
 			get_page(phys_to_page(pa));
 			pa += HW_PAGE_SIZE_4KB;
 		}
 		status = PteUpdate(pDevContext, paCurr, ulVirtAddr +
-				  (vaCurr - ulMpuAddr), sizeCurr, &hwAttrs);
+				  (vaCurr - ulMpuAddr), sizeCurr, hwAttrs);
 		vaCurr += sizeCurr;
 	}
-func_cont:
 	/* Don't propogate Linux or HW status to upper layers */
 	if (DSP_SUCCEEDED(status)) {
 		status = DSP_SOK;
@@ -2033,12 +2016,14 @@ func_cont:
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
1.6.2.4

