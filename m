From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] DSPBRIDGE: Replacing custom implementation for Mapping
Date: Mon, 20 Apr 2009 21:56:30 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530404A77DC7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbZDUC4m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 22:56:42 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez Luna <x0084701@ti.com>
Date: Mon, 20 Apr 2009 21:45:46 -0500
Subject: [PATCH] DSPBRIDGE: Replacing custom implementation for Mapping

DSPBRIDGE: Replacing custom implementation for Mapping

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

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <x0084701@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |  484 +++++++++++------------------------
 1 files changed, 149 insertions(+), 335 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 208f752..c32ee78 100644
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
-                       u32 ulNumBytes, u32 *numOfTableEntries,
-                       u32 *physicalAddrTable);
+static u32 user_va2pa(struct mm_struct *mm, u32 address);
 static DSP_STATUS PteUpdate(struct WMD_DEV_CONTEXT *hDevContext, u32 pa,
                        u32 va, u32 size,
                        struct HW_MMUMapAttrs_t *mapAttrs);
@@ -270,6 +267,21 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
                tlb_flush_all(pDevContext->dwDSPMmuBase);
 }

+void badpagedump(u32 pa, struct page *pg)
+{
+       printk(KERN_EMERG "DSPBRIDGE:MAP  function: COUNT 0 FOR PA 0x%x\n", pa);
+       printk(KERN_EMERG "Bad page state in process '%s'\n"
+               "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
+               "Trying to fix it up, but a reboot is needed\n"
+               "Backtrace:\n",
+               current->comm, pg, (int)(2*sizeof(unsigned long)),
+               (unsigned long)pg->flags, pg->mapping,
+               page_mapcount(pg), page_count(pg));
+       dump_stack();
+       BUG_ON(1);
+
+}
+
 /*
  *  ======== WMD_DRV_Entry ========
  *  purpose:
@@ -1352,11 +1364,16 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
        DSP_STATUS status = DSP_SOK;
        struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
        struct HW_MMUMapAttrs_t hwAttrs;
-       u32 numOfActualTabEntries = 0;
-       u32 *pPhysAddrPageTbl = NULL;
        struct vm_area_struct *vma;
        struct mm_struct *mm = current->mm;
-       u32 temp = 0;
+       u32  write = 0;
+       u32 numUsrPgs = 0;
+       struct page *mappedPage, *pg;
+       s32 pgNum;
+       u32 va = ulVirtAddr;
+       struct task_struct *curr_task = current;
+       u32 pgI = 0;
+       u32 mpuAddr, pa;

        DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
                 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
@@ -1424,7 +1441,6 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
         * virtual memory address space in order to be of use to us here!  */
        down_read(&mm->mmap_sem);
        vma = find_vma(mm, ulMpuAddr);
-       up_read(&mm->mmap_sem);
        if (vma)
                DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf: ulMpuAddr=%x, "
                        "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x \n",
@@ -1436,9 +1452,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
         * user buffer is covered */
        while ((vma != NULL) && (ulMpuAddr + ulNumBytes > vma->vm_end)) {
                /* jump to the next VMA region */
-               down_read(&mm->mmap_sem);
                vma = find_vma(mm, vma->vm_end + 1);
-               up_read(&mm->mmap_sem);
                DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf ulMpuAddr=%x, "
                        "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
                        ulMpuAddr, ulNumBytes, vma->vm_start,
@@ -1449,44 +1463,100 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
                          "MPU Buffer !!! \n");
                status = DSP_EINVALIDARG;
        }
-       if (DSP_FAILED(status))
-               goto func_cont;
-       pPhysAddrPageTbl = DMM_GetPhysicalAddrTable();
-       /* Build the array with virtual to physical translations */
-       status = TIOMAP_VirtToPhysical(mm, ulMpuAddr, ulNumBytes,
-                               &numOfActualTabEntries, pPhysAddrPageTbl);
        if (DSP_FAILED(status)) {
-               DBG_Trace(DBG_LEVEL7,
-                        "WMD_BRD_MemMap: TIOMAP_VirtToPhysical",
-                        " failed\n");
-               return DSP_EFAIL;
+               up_read(&mm->mmap_sem);
+               goto func_cont;
        }
-       temp = 0;
-       DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap: numOfActualTabEntries=%d, "
-                 "ulNumBytes= %d\n",  numOfActualTabEntries, ulNumBytes);
-       /* Update the DSP MMU table with the physical addresses received from
-       from translation function */
-       while (temp < numOfActualTabEntries) {
-               status = PteSet(pDevContext->pPtAttrs, pPhysAddrPageTbl[temp++],
-                               ulVirtAddr, HW_PAGE_SIZE_4KB, &hwAttrs);
-               if (DSP_FAILED(status)) {
-                       DBG_Trace(DBG_LEVEL7,
-                                "WMD_BRD_MemMap: FAILED IN PTESET \n");
-                       return DSP_EFAIL;
+
+       if (vma->vm_flags & VM_IO) {
+               numUsrPgs =  ulNumBytes/PG_SIZE_4K;
+               mpuAddr = ulMpuAddr;
+               DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap:numOfActualTabEntries=%d,"
+                         "ulNumBytes= %d\n",  numUsrPgs, ulNumBytes);
+               /* Get the physical addresses for user buffer */
+               for (pgI = 0; pgI < numUsrPgs; pgI++) {
+                       pa = user_va2pa(mm, mpuAddr);
+                       if (pa == 0) {
+                               status = DSP_EFAIL;
+                               printk(KERN_ERR "DSPBRIDGE: VM_IO mapping"
+                                       "physicaladdress is invalid\n");
+                               break;
+                       }
+                       if (pfn_valid(__phys_to_pfn(pa))) {
+                               pg = phys_to_page(pa);
+                               get_page(pg);
+                               if (page_count(pg) <= 1) {
+                                       printk(KERN_ERR "Bad page in VM_IO"
+                                               " buffer\n");
+                                       badpagedump(pa, pg);
+                               }
+                       }
+                       status = PteSet(pDevContext->pPtAttrs, pa,
+                                       va, HW_PAGE_SIZE_4KB, &hwAttrs);
+                       if (DSP_FAILED(status)) {
+                               DBG_Trace(DBG_LEVEL7,
+                                        "WMD_BRD_MemMap: FAILED IN VM_IO"
+                               "PTESET \n");
+                               break;
+                       }
+                       va += HW_PAGE_SIZE_4KB;
+                       mpuAddr += HW_PAGE_SIZE_4KB;
+                       pa += HW_PAGE_SIZE_4KB;
+               }
+       } else {
+               numUsrPgs =  ulNumBytes/PG_SIZE_4K;
+               if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
+                       write = 1;
+
+               for (pgI = 0; pgI < numUsrPgs; pgI++) {
+                       pgNum = get_user_pages(curr_task, mm, ulMpuAddr, 1,
+                                               write, 1, &mappedPage, NULL);
+                       if (pgNum > 0) {
+                               if (page_count(mappedPage) <= 1) {
+                                       printk(KERN_ERR "Bad page count"
+                                               "after doing get_user_pages on"
+                                       "user buffer\n");
+                                       badpagedump(page_to_phys(mappedPage),
+                                                               mappedPage);
+                               }
+                               status = PteSet(pDevContext->pPtAttrs,
+                                       page_to_phys(mappedPage), va,
+                                       HW_PAGE_SIZE_4KB, &hwAttrs);
+                               if (DSP_FAILED(status)) {
+                                       DBG_Trace(DBG_LEVEL7,
+                                       "WMD_BRD_MemMap: FAILED IN PTESET \n");
+                                       break;
+                               }
+                               va += HW_PAGE_SIZE_4KB;
+                               ulMpuAddr += HW_PAGE_SIZE_4KB;
+                       } else {
+                               printk(KERN_ERR "DSPBRIDGE: get_user_pages"
+                                       "FAILED, MPU addr = 0x%x,"
+                                       "vma->vm_flags = 0x%lx,"
+                                       "get_user_pages Err Value = %d,"
+                                       "Buffer size=0x%x\n", ulMpuAddr,
+                                       vma->vm_flags, pgNum, ulNumBytes);
+                               status = DSP_EFAIL;
+                               break;
+                       }
                }
-               ulVirtAddr += HW_PAGE_SIZE_4KB;
        }
-       if (DSP_FAILED(status))
-               DBG_Trace(DBG_LEVEL5, "WMD_BRD_MemMap: PteSet failed \n");
-       else
-               DBG_Trace(DBG_LEVEL5, "WMD_BRD_MemMap: PteSet passed \n");
-
+       up_read(&mm->mmap_sem);
 func_cont:
        /* Don't propogate Linux or HW status to upper layers */
        if (DSP_SUCCEEDED(status)) {
                status = DSP_SOK;
        } else {
                DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap status %x\n", status);
+               /*
+                * Roll out the mapped pages incase it failed in middle of
+                * mapping
+                */
+               if (pgI) {
+                       WMD_BRD_MemUnMap(pDevContext, ulVirtAddr,
+                                               (pgI * PG_SIZE_4K));
+               }
+
                status = DSP_EFAIL;
        }
         /* In any case, flush the TLB
@@ -1595,7 +1665,6 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
                                                                        pAddr;
                                                pAddr += HW_PAGE_SIZE_4KB;
                                        }
-
                                        if (HW_MMU_PteClear(pteAddrL2,
                                                vaCurr, pteSize) == RET_OK) {
                                                status = DSP_SOK;
@@ -1639,6 +1708,18 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
                        /* pteSize = 1 MB or 16 MB */
                        if ((pteSize != 0) && (remBytes >= pteSize) &&
                           !(vaCurr & (pteSize - 1))) {
+                               if (pteSize == HW_PAGE_SIZE_1MB)
+                                       numof4KPages = 256;
+                               else
+                                       numof4KPages = 4096;
+                               temp = 0;
+                               /* Collect Physical addresses from VA */
+                               pAddr = (pteVal & ~(pteSize - 1));
+                               while (temp++ < numof4KPages) {
+                                       pPhysAddrPageTbl[pacount++] =
+                                                               pAddr;
+                                       pAddr += HW_PAGE_SIZE_4KB;
+                               }
                                if (HW_MMU_PteClear(L1BaseVa,
                                        vaCurr, pteSize) == RET_OK) {
                                        status = DSP_SOK;
@@ -1677,262 +1758,35 @@ EXIT_LOOP:
        return status;
 }
 /*
- * ========= TIOMAP_VirtToPhysical ==========
- * Purpose:
- *             This function builds the array with virtual to physical
- *         address translation
+ *  ======== user_va2pa ========
+ *  Purpose:
+ *      This function walks through the Linux page tables to convert a userland
+ *      virtual address to physical address
  */
-static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
-                                       u32 ulNumBytes,
-                                       u32 *numOfTableEntries,
-                                       u32 *physicalAddrTable)
+static u32 user_va2pa(struct mm_struct *mm, u32 address)
 {
-       u32 pAddr;
-       u32 chunkSz;
-       DSP_STATUS status = DSP_SOK;
-       volatile u32 pteVal;
-       u32 pteSize;
+
        pgd_t *pgd;
        pmd_t *pmd;
-       volatile pte_t *ptep;
-       u32 numEntries = 0;
-       u32 numof4KPages = 0;
-       u32 phyEntryCounter = 0;
-       u32 temp = 0;
-       u32 numUsrPgs;
-       struct task_struct *curr_task = current;
-       struct vm_area_struct *vma;
-       u32  write = 0;
-
-
-       DBG_Trace(DBG_ENTER, "TIOMAP_VirtToPhysical: START:ulMpuAddr=%x, "
-                 "ulNumBytes=%x\n", ulMpuAddr, ulNumBytes);
-       if (physicalAddrTable == NULL)
-               return DSP_EMEMORY;
-       down_read(&mm->mmap_sem);
-       vma = find_vma(mm, ulMpuAddr);
-       up_read(&mm->mmap_sem);
-
-       if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
-               write = 1;
-       while (ulNumBytes) {
-               DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:Read the next PGD "
-                         "and PMD entry\n");
-               numEntries = 0;
-               /* Get the first level page table entry information */
-               /* Read the pointer to first level page table entry */
-               pgd = pgd_offset(mm, ulMpuAddr);
-               /* Read the value in the first level page table entry */
-               pteVal = *(u32 *)pgd;
-               /* Find the page size that is pointed by the first level page
-                * table entry */
-               pteSize = HW_MMU_PteSizeL1(pteVal); /* update 16 or 1 */
-               /* If pteSize is zero, then call the get_user_pages to create
-                * the page table entries for this buffer
-                */
-               if (!pteSize) {
-                       down_read(&mm->mmap_sem);
-                       /* This call invokes handle_mmu _fault call, which
-                        *causes all pages to be created before we scan the
-                        * page tables
-                        */
-                       numUsrPgs = get_user_pages(curr_task, mm, ulMpuAddr, 1,
-                                                       write, 1, NULL, NULL);
-                       up_read(&mm->mmap_sem);
-                       /* Get the first level page table entry information */
-                       /* Read the pointer to first level page table entry */
-                       pgd = pgd_offset(mm, ulMpuAddr);
-                       /* Read the value in the first level page table entry*/
-                       pteVal = *(u32 *)pgd;
-                       /* Find the page size that is pointed by the first level
-                        * page table entry
-                        */
-                       pteSize = HW_MMU_PteSizeL1(pteVal);
-                       DBG_Trace(DBG_LEVEL4, "First level  get_user_pages "
-                                                       "called\n");
-               }
-               /* If the page size is 4K or 64K, then we have to traverse to
-                * second level page table */
-               if (pteSize == HW_MMU_COARSE_PAGE_SIZE) {
-                       DBG_Trace(DBG_LEVEL5, "Read the next PMD entry\n");
-                       /* Get the second level page table information */
-                       pmd = pmd_offset(pgd, ulMpuAddr);
-                       ptep = pte_offset_map(pmd, ulMpuAddr);
-                       do {
-                               ptep = ptep+numEntries;
-                               /* Read the value of second level page table
-                                * entry */
-                               pteVal = *(u32 *)ptep;
-                               /* Find the size of page the second level
-                                * table entry is pointing */
-                               /* update 64 or 4 */
-                               pteSize = HW_MMU_PteSizeL2(pteVal);
-                               /* If pteSize is invalid, then call
-                                * get_user_pages to create the
-                                * page table entries
-                                */
-                               if (!pteSize) {
-                                       numUsrPgs =
-                                               (ulNumBytes/HW_PAGE_SIZE_4KB);
-                                       down_read(&mm->mmap_sem);
-                                       /* This call invokes
-                                        *handle_mmu _fault call, which causes
-                                        *all pages to be created before we scan
-                                        * the page tables */
-                                       if (numUsrPgs <= PAGES_II_LVL_TABLE) {
-                                               get_user_pages(curr_task, mm,
-                                               ulMpuAddr, numUsrPgs, write,  1,
-                                               NULL, NULL);
-                                               DBG_Trace(DBG_LEVEL4,
-                                               "get_user_pages, numUsrPgs"
-                                               "= %d\n", numUsrPgs);
-                                       } else {
-                                               get_user_pages(curr_task, mm,
-                                               ulMpuAddr, PAGES_II_LVL_TABLE,
-                                               write, 1, NULL, NULL);
-                                               DBG_Trace(DBG_LEVEL4,
-                                               "get_user_pages, numUsrPgs"
-                                               "= %d\n", PAGES_II_LVL_TABLE);
-                                       }
-                                       up_read(&mm->mmap_sem);
-                                       /* Read the value of second level page
-                                        * table  entry */
-                                       pteVal = *(u32 *)ptep;
-                                       /* Find the size of page the second
-                                        * level table entry is pointing */
-                                       pteSize = HW_MMU_PteSizeL2(pteVal);
-                               }
-                               DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:"
-                                       "*pmd=%x, *pgd=%x, ptep = %x, pteVal="
-                                       " %x, pteSize=%x\n", *pmd,
-                                       *(u32 *)pgd, (u32)ptep, pteVal,
-                                       pteSize);
-
-                               /* Extract the physical Addresses */
-                               switch (pteSize) {
-                               case HW_PAGE_SIZE_64KB:
-                                       pAddr = pteVal & MMU_LARGE_PAGE_MASK;
-                                       chunkSz = HW_PAGE_SIZE_64KB;
-                                       numEntries = 16;
-                                       if (ulNumBytes >= HW_PAGE_SIZE_64KB)
-                                               numof4KPages = 16;
-                                       else {
-                                               numof4KPages = ulNumBytes /
-                                                       HW_PAGE_SIZE_4KB;
-                                       }
-                                       break;
-                               case HW_PAGE_SIZE_4KB:
-                                       pAddr = pteVal & MMU_SMALL_PAGE_MASK;
-                                       chunkSz = HW_PAGE_SIZE_4KB;
-                                       numEntries = 1;
-                                       numof4KPages = 1;
-                                       break;
-                               default:
-                                       DBG_Trace(DBG_LEVEL7,
-                                               "TIOMAP_VirtToPhysical:"
-                                               "Descriptor"
-                                               "Format Fault-II level,"
-                                               " PTE size = %x\n",
-                                               pteSize);
-                                       return DSP_EFAIL;
-                               }
-                               temp = 0;
-                               while (temp++ < numof4KPages) {
-                                       physicalAddrTable[phyEntryCounter++] =
-                                                                       pAddr;
-                                       DBG_Trace(DBG_LEVEL4,
-                                                "TIOMAP_VirtToPhysical:"
-                                                "physicalAddrTable[%d]= %x\n",
-                                                (phyEntryCounter-1), pAddr);
-                                       pAddr += HW_PAGE_SIZE_4KB;
-                               }
-                               if (DSP_SUCCEEDED(status)) {
-                                       /* Go to the next page */
-                                       ulMpuAddr += chunkSz;
-                                       /* Update the number of bytes that
-                                        * are copied */
-                                       if (chunkSz > ulNumBytes)
-                                               ulNumBytes = 0;
-                                       else
-                                               ulNumBytes -= chunkSz;
-                                       DBG_Trace(DBG_LEVEL4,
-                                               "TIOMAP_VirtToPhysical: mpuCurr"
-                                               " = %x, pagesize = %x, "
-                                               "numBytesRem=%x\n",
-                                               ulMpuAddr, chunkSz, ulNumBytes);
-                               } else {
-                                       DBG_Trace(DBG_LEVEL7,
-                                            " TIOMAP_VirtToPhysical:PTEupdate"
-                                            "failed\n");
-                               }
-                       /* It is observed that the pgd value (first level page
-                        * table entry) is changed after reading the 512
-                        * entries in second level table. So, call the pgd
-                        * functions after reaching 512 entries in second
-                        * level table */
-                       } while ((ulMpuAddr & 0x001ff000) && (ulNumBytes));
-               } else {
-                       /* Extract the Address to update the IVA MMU table
-                        * with */
-                       switch (pteSize) {
-                       case HW_PAGE_SIZE_16MB:
-                               pAddr = pteVal & MMU_SSECTION_ADDR_MASK;
-                               if (ulNumBytes >= HW_PAGE_SIZE_16MB) {
-                                       chunkSz = HW_PAGE_SIZE_16MB;
-                                       numEntries = 16;
-                                       numof4KPages = 4096;
-                               } else {
-                                       chunkSz = HW_PAGE_SIZE_1MB;
-                                       numEntries = 1;
-                                       numof4KPages = 256;
-                               }
-                               break;
-                       case HW_PAGE_SIZE_1MB:
-                               pAddr = pteVal & MMU_SECTION_ADDR_MASK;
-                                       chunkSz = HW_PAGE_SIZE_1MB;
-                                       numEntries = 1;
-                                       numof4KPages = 256;
-                                       break;
-                       default:
-                               DBG_Trace(DBG_LEVEL7,
-                                    "TIOMAP_VirtToPhysical:Descriptor"
-                                    "Format Faul-I level, PTE size = "
-                                    "%x\n", pteSize);
-                               return DSP_EFAIL;
-                       }
-                       temp = 0;
-                       while (temp++ < numof4KPages) {
-                                       physicalAddrTable[phyEntryCounter++] =
-                                                                        pAddr;
-                                       DBG_Trace(DBG_LEVEL4,
-                                                "TIOMAP_VirtToPhysical:"
-                                                "physicalAddrTable[%d]= %x\n",
-                                                (phyEntryCounter-1), pAddr);
-                                       pAddr += HW_PAGE_SIZE_4KB;
+       pte_t *ptep, pte;
+
+       pgd = pgd_offset(mm, address);
+       if (!(pgd_none(*pgd) || pgd_bad(*pgd))) {
+               pmd = pmd_offset(pgd, address);
+               if (!(pmd_none(*pmd) || pmd_bad(*pmd))) {
+                       ptep = pte_offset_map(pmd, address);
+                       if (ptep) {
+                               pte = *ptep;
+                               if (pte_present(pte))
+                                       return pte & PAGE_MASK;
                        }
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Go to the next page */
-                               ulMpuAddr += chunkSz;
-                               /* Update the number of bytes that are copied */
-                               ulNumBytes -= chunkSz;
-                               DBG_Trace(DBG_LEVEL4,
-                                        "TIOMAP_VirtToPhysical: mpuCurr = %x, "
-                                        "pagesize = %x, numBytesRem=%x\n",
-                                        ulMpuAddr, chunkSz, ulNumBytes);
-                       } else {
-                               DBG_Trace(DBG_LEVEL7,
-                                        " TIOMAP_VirtToPhysical:PTEupdate"
-                                        "failed\n");
-                       }
-
                }
        }
-       *numOfTableEntries = phyEntryCounter;
-       DBG_Trace(DBG_LEVEL4, " TIOMAP_VirtToPhysical:numofTableEntries=%d\n",
-                 phyEntryCounter);
-       return status;
+
+       return 0;
 }

+
 /*
  *  ======== PteUpdate ========
  *      This function calculates the optimum page-aligned addresses and sizes
@@ -2000,48 +1854,9 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
        u32 L2BaseVa = 0;
        u32 L2BasePa = 0;
        u32 L2PageNum = 0;
-       u32 num4KEntries = 0;
-       u32 temp = 0;
-       struct page *pg;
-       u32 patemp;
-
        DSP_STATUS status = DSP_SOK;
        DBG_Trace(DBG_ENTER, "> PteSet pPgTableAttrs %x, pa %x, va %x, "
                 "size %x, attrs %x\n", pt, pa, va, size, attrs);
-       /* Lock the MPU pages that are getting mapped if this
-        * attribute is set */
-       if (attrs->donotlockmpupage == 0) {
-               switch (size) {
-               case HW_PAGE_SIZE_64KB:
-                       num4KEntries = 16;
-                       break;
-               case HW_PAGE_SIZE_4KB:
-                       num4KEntries = 1;
-                       break;
-               case HW_PAGE_SIZE_16MB:
-                       num4KEntries = 4096;
-                       break;
-               case HW_PAGE_SIZE_1MB:
-                       num4KEntries = 256;
-                       break;
-               default:
-                       return DSP_EFAIL;
-               }
-               patemp = pa;
-               while (temp++ < num4KEntries) {
-                       /* FIXME: This is a hack to avoid getting pages for
-                        *  video overlay               */
-                       if (pfn_valid(__phys_to_pfn(patemp))) {
-                               pg = phys_to_page(patemp);
-                               get_page(pg);
-                               if (page_count(pg) < 1)
-                                       goto pg_cnt_err_out;
-                       }
-
-                       patemp += HW_PAGE_SIZE_4KB;
-               }
-       }
-       attrs->donotlockmpupage = 0;
        L1BaseVa = pt->L1BaseVa;
        pgTblVa = L1BaseVa;
        if ((size == HW_PAGE_SIZE_64KB) || (size == HW_PAGE_SIZE_4KB)) {
@@ -2092,7 +1907,6 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
                                pt->pgInfo[L2PageNum].numEntries += 16;
                        else
                                pt->pgInfo[L2PageNum].numEntries++;
-
                        DBG_Trace(DBG_LEVEL1, "L2 BaseVa %x, BasePa %x, "
                                 "PageNum %x numEntries %x\n", L2BaseVa,
                                 L2BasePa, L2PageNum,
@@ -2110,15 +1924,6 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
        }
        DBG_Trace(DBG_ENTER, "< PteSet status %x\n", status);
        return status;
-
-pg_cnt_err_out:
-       pr_emerg("DSPBRIDGE:MAP function: COUNT 0 FOR PA 0x%x\n", patemp);
-       pr_emerg("Bad page state in process '%s'\n page:%p flags:%lx "
-                       "mapping:%p mapcount:%d count:%d\n",
-                       current->comm, pg, pg->flags,
-                       pg->mapping, page_mapcount(pg), page_count(pg));
-       pr_emerg("Backtrace:\n");
-       BUG();
 }

 /* Memory map kernel VA -- memory allocated with vmalloc */
@@ -2137,6 +1942,9 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
        u32 vaCurr;
        u32 sizeCurr;
        u32 numPages;
+       u32 pa;
+       u32 numOf4KPages;
+       u32 temp = 0;

        DBG_Trace(DBG_ENTER, "> MemMapVmalloc hDevContext %x, pa %x, va %x, "
                  "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr,
@@ -2205,6 +2013,12 @@ static DSP_STATUS MemMapVmalloc(struct WMD_DEV_CONTEXT *hDevContext,
                        status = DSP_EMEMORY;
                        break;
                }
+               pa = paCurr;
+               numOf4KPages = sizeCurr/HW_PAGE_SIZE_4KB;
+               while (temp++ < numOf4KPages) {
+                       get_page(phys_to_page(pa));
+                       pa += HW_PAGE_SIZE_4KB;
+               }
                status = PteUpdate(pDevContext, paCurr, ulVirtAddr +
                                  (vaCurr - ulMpuAddr), sizeCurr, &hwAttrs);
                vaCurr += sizeCurr;
--
1.5.4.3
