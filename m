From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
Date: Thu, 26 Mar 2009 20:08:09 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2BC62@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47960 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934171AbZC0BIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 21:08:18 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2R18BSF023379
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:08:16 -0500
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2R18BQr007186
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:08:11 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 81c5b93ad42c40179c2b271f61814f0b4035440c Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Thu, 26 Mar 2009 15:47:50 -0500
Subject: [PATCH] DSPBRIDGE: Memory lock for DMM.

Lock down the pages that are mapped to DSP virtual memory to prevent from
getting swapped out

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +
 drivers/dsp/bridge/hw/hw_mmu.h                |    1 +
 drivers/dsp/bridge/wmd/io_sm.c                |   24 +++--
 drivers/dsp/bridge/wmd/tiomap3430.c           |  133 +++++++++++++++++++++++-
 4 files changed, 144 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 7f5a2bf..9782693
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -571,6 +571,9 @@ bit 6 - MMU element size = 64bit (valid only for non mixed page entries)
 
 #define DSP_MAPVMALLOCADDR         0x00000080
 
+#define DSP_MAPDONOTLOCK	   0x00000100
+
+
 #define GEM_CACHE_LINE_SIZE     128
 #define GEM_L1P_PREFETCH_SIZE   128
 
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 065f0dd..b1e2458
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -51,6 +51,7 @@ struct HW_MMUMapAttrs_t {
 	enum HW_Endianism_t     endianism;
 	enum HW_ElementSize_t   elementSize;
 	enum HW_MMUMixedSize_t  mixedSize;
+	bool donotlockmpupage;
 } ;
 
 extern HW_STATUS HW_MMU_Enable(const void __iomem *baseAddress);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index bd936eb..301bd72 100755
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -553,6 +553,8 @@ func_cont1:
 	mapAttrs = DSP_MAPLITTLEENDIAN;
 	mapAttrs |= DSP_MAPPHYSICALADDR;
 	mapAttrs |= DSP_MAPELEMSIZE32;
+	mapAttrs |= DSP_MAPDONOTLOCK;
+
 	while (numBytes && DSP_SUCCEEDED(status)) {
 		/* To find the max. page size with which both PA & VA are
 		 * aligned */
@@ -690,18 +692,18 @@ func_cont:
 	mapAttrs = DSP_MAPLITTLEENDIAN;
 	mapAttrs |= DSP_MAPPHYSICALADDR;
 	mapAttrs |= DSP_MAPELEMSIZE32;
+	mapAttrs |= DSP_MAPDONOTLOCK;
+
 	/* Map the L4 peripherals */
-	{
-		i = 0;
-		while (L4PeripheralTable[i].physAddr && DSP_SUCCEEDED(status)) {
-				status = hIOMgr->pIntfFxns->pfnBrdMemMap
-					(hIOMgr->hWmdContext,
-					L4PeripheralTable[i].physAddr,
-					L4PeripheralTable[i].dspVirtAddr,
-					HW_PAGE_SIZE_4KB, mapAttrs);
-				DBC_Assert(DSP_SUCCEEDED(status));
-				i++;
-		}
+	i = 0;
+	while (L4PeripheralTable[i].physAddr && DSP_SUCCEEDED(status)) {
+		status = hIOMgr->pIntfFxns->pfnBrdMemMap
+			(hIOMgr->hWmdContext, L4PeripheralTable[i].physAddr,
+			L4PeripheralTable[i].dspVirtAddr, HW_PAGE_SIZE_4KB,
+			mapAttrs);
+		if (DSP_FAILED(status))
+			break;
+		i++;
 	}
 
 	if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 7f20574..1a97305 100755
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -28,6 +28,8 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
 #include "../arch/arm/mach-omap2/prcm-regs.h"
 #include "../arch/arm/mach-omap2/cm-regbits-34xx.h"
 #include "../arch/arm/mach-omap2/ti-compat.h"
@@ -90,6 +92,7 @@
 #define MMU_LARGE_PAGE_MASK      0xFFFF0000
 #define MMU_SMALL_PAGE_MASK      0xFFFFF000
 #define PAGES_II_LVL_TABLE   512
+#define phys_to_page(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
 
 #define MMU_GFLUSH 0x60
 
@@ -1372,6 +1375,11 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 			return DSP_EINVALIDARG;
 		}
 	}
+	if (attrs & DSP_MAPDONOTLOCK)
+		hwAttrs.donotlockmpupage = 1;
+	else
+		hwAttrs.donotlockmpupage = 0;
+
 	if (attrs & DSP_MAPVMALLOCADDR) {
 		status = MemMapVmalloc(hDevContext, ulMpuAddr, ulVirtAddr,
 				       ulNumBytes, ulMapAttr);
@@ -1488,12 +1496,20 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	u32 remBytes;
 	u32 remBytesL2;
 	u32 vaCurr;
+	struct page *pg;
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	struct PgTableAttrs *pt = pDevContext->pPtAttrs;
+	u32 pacount = 0;
+	u32 *pPhysAddrPageTbl = NULL;
+	u32 temp;
+	u32 patemp = 0;
+	u32 pAddr;
+	u32 numof4KPages = 0;
 
 	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemUnMap hDevContext %x, va %x, "
 		  "NumBytes %x\n", hDevContext, ulVirtAddr, ulNumBytes);
+	pPhysAddrPageTbl = DMM_GetPhysicalAddrTable();
 	vaCurr = ulVirtAddr;
 	remBytes = ulNumBytes;
 	remBytesL2 = 0;
@@ -1542,6 +1558,19 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 				/* vaCurr aligned to pteSize? */
 				if ((pteSize != 0) && (remBytesL2 >= pteSize) &&
 				   !(vaCurr & (pteSize - 1))) {
+					/* Collect Physical addresses from VA */
+					pAddr = (pteVal & ~(pteSize - 1));
+					if (pteSize == HW_PAGE_SIZE_64KB)
+						numof4KPages = 16;
+					else
+						numof4KPages = 1;
+					temp = 0;
+					while (temp++ < numof4KPages) {
+						pPhysAddrPageTbl[pacount++] =
+									pAddr;
+						pAddr += HW_PAGE_SIZE_4KB;
+					}
+
 					if (HW_MMU_PteClear(pteAddrL2,
 						vaCurr, pteSize) == RET_OK) {
 						status = DSP_SOK;
@@ -1602,6 +1631,20 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	 * get flushed */
 EXIT_LOOP:
 	flush_all(pDevContext);
+	temp = 0;
+	while (temp < pacount) {
+		patemp = pPhysAddrPageTbl[temp];
+		if (pfn_valid(__phys_to_pfn(patemp))) {
+			pg = phys_to_page(patemp);
+			if (page_count(pg) <= 0)
+				printk(KERN_INFO "DSPBRIDGE:UNMAP function:
+					COUNT 0 FOR PA 0x%x, size = 0x%x\n",
+					patemp, ulNumBytes);
+			SetPageDirty(pg);
+			page_cache_release(pg);
+		}
+		temp++;
+	}
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemUnMap status %x remBytes %x, "
@@ -1633,11 +1676,20 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 	u32 temp = 0;
 	u32 numUsrPgs;
 	struct task_struct *curr_task = current;
+	struct vm_area_struct *vma;
+	u32  write = 0;
+
 
 	DBG_Trace(DBG_ENTER, "TIOMAP_VirtToPhysical: START:ulMpuAddr=%x, "
 		  "ulNumBytes=%x\n", ulMpuAddr, ulNumBytes);
 	if (physicalAddrTable == NULL)
 		return DSP_EMEMORY;
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, ulMpuAddr);
+	up_read(&mm->mmap_sem);
+
+	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
+		write = 1;
 	while (ulNumBytes) {
 		DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:Read the next PGD "
 			  "and PMD entry\n");
@@ -1660,7 +1712,7 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 			 * page tables
 			 */
 			numUsrPgs = get_user_pages(curr_task, mm, ulMpuAddr, 1,
-							true, 0, NULL, NULL);
+							write, 1, NULL, NULL);
 			up_read(&mm->mmap_sem);
 			/* Get the first level page table entry information */
 			/* Read the pointer to first level page table entry */
@@ -1704,7 +1756,7 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 					 * the page tables */
 					if (numUsrPgs <= PAGES_II_LVL_TABLE) {
 						get_user_pages(curr_task, mm,
-						ulMpuAddr, numUsrPgs, true,  0,
+						ulMpuAddr, numUsrPgs, write,  1,
 						NULL, NULL);
 						DBG_Trace(DBG_LEVEL4,
 						"get_user_pages, numUsrPgs"
@@ -1712,7 +1764,7 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 					} else {
 						get_user_pages(curr_task, mm,
 						ulMpuAddr, PAGES_II_LVL_TABLE,
-						true, 0, NULL, NULL);
+						write, 1, NULL, NULL);
 						DBG_Trace(DBG_LEVEL4,
 						"get_user_pages, numUsrPgs"
 						"= %d\n", PAGES_II_LVL_TABLE);
@@ -1737,7 +1789,12 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 					pAddr = pteVal & MMU_LARGE_PAGE_MASK;
 					chunkSz = HW_PAGE_SIZE_64KB;
 					numEntries = 16;
-					numof4KPages = 16;
+					if (ulNumBytes >= HW_PAGE_SIZE_64KB)
+						numof4KPages = 16;
+					else {
+						numof4KPages = ulNumBytes /
+							HW_PAGE_SIZE_4KB;
+					}
 					break;
 				case HW_PAGE_SIZE_4KB:
 					pAddr = pteVal & MMU_SMALL_PAGE_MASK;
@@ -1769,7 +1826,10 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 					ulMpuAddr += chunkSz;
 					/* Update the number of bytes that
 					 * are copied */
-					ulNumBytes -= chunkSz;
+					if (chunkSz > ulNumBytes)
+						ulNumBytes = 0;
+					else
+						ulNumBytes -= chunkSz;
 					DBG_Trace(DBG_LEVEL4,
 						"TIOMAP_VirtToPhysical: mpuCurr"
 						" = %x, pagesize = %x, "
@@ -1792,10 +1852,16 @@ static DSP_STATUS TIOMAP_VirtToPhysical(struct mm_struct *mm, u32 ulMpuAddr,
 			switch (pteSize) {
 			case HW_PAGE_SIZE_16MB:
 				pAddr = pteVal & MMU_SSECTION_ADDR_MASK;
+				if (ulNumBytes >= HW_PAGE_SIZE_16MB) {
 					chunkSz = HW_PAGE_SIZE_16MB;
 					numEntries = 16;
 					numof4KPages = 4096;
-					break;
+				} else {
+					chunkSz = HW_PAGE_SIZE_1MB;
+					numEntries = 1;
+					numof4KPages = 256;
+				}
+				break;
 			case HW_PAGE_SIZE_1MB:
 				pAddr = pteVal & MMU_SECTION_ADDR_MASK;
 					chunkSz = HW_PAGE_SIZE_1MB;
@@ -1909,9 +1975,64 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 	u32 L2BaseVa = 0;
 	u32 L2BasePa = 0;
 	u32 L2PageNum = 0;
+	u32 num4KEntries = 0;
+	u32 temp = 0;
+	struct page *pg;
+	u32 patemp;
+
 	DSP_STATUS status = DSP_SOK;
 	DBG_Trace(DBG_ENTER, "> PteSet pPgTableAttrs %x, pa %x, va %x, "
 		 "size %x, attrs %x\n", pt, pa, va, size, attrs);
+	/* Lock the MPU pages that are getting mapped if this
+	 * attribute is set */
+	if (attrs->donotlockmpupage == 0) {
+		switch (size) {
+		case HW_PAGE_SIZE_64KB:
+			num4KEntries = 16;
+			break;
+		case HW_PAGE_SIZE_4KB:
+			num4KEntries = 1;
+			break;
+		case HW_PAGE_SIZE_16MB:
+			num4KEntries = 4096;
+			break;
+		case HW_PAGE_SIZE_1MB:
+			num4KEntries = 256;
+			break;
+		default:
+			return DSP_EFAIL;
+		}
+		patemp = pa;
+		while (temp++ < num4KEntries) {
+			/* FIXME: This is a hack to avoid getting pages for
+			 *  video overlay		*/
+			if (pfn_valid(__phys_to_pfn(patemp))) {
+				pg = phys_to_page(patemp);
+				get_page(pg);
+			}
+			if (page_count(pg) <= 1) {
+				printk(KERN_EMERG "DSPBRIDGE:MAP  function: "
+					"COUNT 0 FOR PA 0x%x\n", patemp);
+				printk(KERN_EMERG "Bad page state"
+					KERN_EMERG "in process '%s'\n"
+					KERN_EMERG "page:%p flags:0x%0*lx "
+					KERN_EMERG "mapping:%p mapcount:%d "
+					KERN_EMERG "count:%d\n"
+					KERN_EMERG "Trying to fix it up, but "
+					KERN_EMERG "a reboot is needed\n"
+					KERN_EMERG "Backtrace:\n",
+					current->comm, pg,
+					(int)(2*sizeof(unsigned long)),
+					(unsigned long)pg->flags, pg->mapping,
+					page_mapcount(pg), page_count(pg));
+				dump_stack();
+				BUG_ON(1);
+			}
+
+			patemp += HW_PAGE_SIZE_4KB;
+		}
+	}
+	attrs->donotlockmpupage = 0;
 	L1BaseVa = pt->L1BaseVa;
 	pgTblVa = L1BaseVa;
 	if ((size == HW_PAGE_SIZE_64KB) || (size == HW_PAGE_SIZE_4KB)) {
-- 
1.5.6.4

