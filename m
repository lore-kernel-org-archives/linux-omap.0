From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: Remove DMM physical addres table
Date: Sun, 19 Jul 2009 02:15:42 -0500
Message-ID: <1247987744-18373-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39306 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZGSHJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 03:09:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hari Kanigeri <h-kanigeri2@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

Physical address is not needed anymore since Mapping migration
to open source API, this patch removes the physical table entry.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dmm.h |    1 -
 drivers/dsp/bridge/pmgr/dmm.c              |   35 ------------------
 drivers/dsp/bridge/wmd/tiomap3430.c        |   55 +++++++++++++++++-----------
 3 files changed, 34 insertions(+), 57 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index ef37668..335edf8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
@@ -81,5 +81,4 @@
 
 	extern DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr,
 						u32 addr, u32 size);
-	extern u32 *DMM_GetPhysicalAddrTable(void);
 #endif				/* DMM_ */
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 803de93..f4fc6ec 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -113,7 +113,6 @@ struct MapPage {
 static struct MapPage *pVirtualMappingTable;
 static u32  iFreeRegion;	/* The index of free region */
 static u32  iFreeSize;
-static u32  *pPhysicalAddrTable;	/* Physical address of MPU buffer */
 static u32  dynMemMapBeg;	/* The Beginning of dynamic memory mapping */
 static u32  TableSize;/* The size of virtual and physical pages tables */
 
@@ -151,28 +150,11 @@ DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 		if (pVirtualMappingTable == NULL)
 			status = DSP_EMEMORY;
 		else {
-			/* This table will be used
-			* to store the virtual to physical
-			* address translations
-			*/
-			pPhysicalAddrTable = (u32 *)MEM_Calloc
-				(TableSize*sizeof(u32), MEM_NONPAGED);
-			GT_1trace(DMM_debugMask, GT_4CLASS,
-			"DMM_CreateTables: Allocate"
-			"memory for pPhysicalAddrTable=%d entries\n",
-			TableSize);
-			if (pPhysicalAddrTable == NULL) {
-				status = DSP_EMEMORY;
-				GT_0trace(DMM_debugMask, GT_7CLASS,
-				    "DMM_CreateTables: Memory allocation for "
-				    "pPhysicalAddrTable failed\n");
-			} else {
 			/* On successful allocation,
 			* all entries are zero ('free') */
 			iFreeRegion = 0;
 			iFreeSize = TableSize*PG_SIZE_4K;
 			pVirtualMappingTable[0].RegionSize = TableSize;
-			}
 		}
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
 	} else
@@ -275,9 +257,6 @@ DSP_STATUS DMM_DeleteTables(struct DMM_OBJECT *hDmmMgr)
 		if (pVirtualMappingTable != NULL)
 			MEM_Free(pVirtualMappingTable);
 
-		if (pPhysicalAddrTable != NULL)
-			MEM_Free(pPhysicalAddrTable);
-
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
 	} else
 		status = DSP_EHANDLE;
@@ -361,7 +340,6 @@ bool DMM_Init(void)
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	pVirtualMappingTable = NULL ;
-	pPhysicalAddrTable = NULL ;
 	TableSize = 0;
 
 	return fRetval;
@@ -635,19 +613,6 @@ static struct MapPage *GetMappedRegion(u32 aAddr)
 	return currRegion;
 }
 
-/*
- *  ======== DMM_GetPhysicalAddrTable ========
- *  Purpose:
- *  Returns the physical table address
- */
-u32 *DMM_GetPhysicalAddrTable(void)
-{
-	GT_1trace(DMM_debugMask, GT_ENTER, "Entered "
-			"DMM_GetPhysicalAddrTable()- pPhysicalAddrTable 0x%x\n",
-			pPhysicalAddrTable);
-	return pPhysicalAddrTable;
-}
-
 #ifdef DSP_DMM_DEBUG
 u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr)
 {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index b317015..449de01 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1592,16 +1592,12 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	struct PgTableAttrs *pt = pDevContext->pPtAttrs;
-	u32 pacount = 0;
-	u32 *pPhysAddrPageTbl = NULL;
 	u32 temp;
-	u32 patemp = 0;
 	u32 pAddr;
 	u32 numof4KPages = 0;
 
 	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemUnMap hDevContext %x, va %x, "
 		  "NumBytes %x\n", hDevContext, ulVirtAddr, ulNumBytes);
-	pPhysAddrPageTbl = DMM_GetPhysicalAddrTable();
 	vaCurr = ulVirtAddr;
 	remBytes = ulNumBytes;
 	remBytesL2 = 0;
@@ -1664,8 +1660,25 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 						numof4KPages = 1;
 					temp = 0;
 					while (temp++ < numof4KPages) {
-						pPhysAddrPageTbl[pacount++] =
-									pAddr;
+						if (!pfn_valid(__phys_to_pfn(
+								pAddr))) {
+							pAddr +=
+							    HW_PAGE_SIZE_4KB;
+							continue;
+						}
+						pg = phys_to_page(pAddr);
+						if (page_count(pg) < 1) {
+							pr_info("DSPBRIDGE:"
+							    "UNMAP function: "
+							    "COUNT 0 FOR PA "
+							    "0x%x, size = "
+							    "0x%x\n", pAddr,
+							    ulNumBytes);
+							bad_page_dump(pAddr,
+									pg);
+						}
+						SetPageDirty(pg);
+						page_cache_release(pg);
 						pAddr += HW_PAGE_SIZE_4KB;
 					}
 					if (HW_MMU_PteClear(pteAddrL2,
@@ -1722,7 +1735,21 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 				/* Collect Physical addresses from VA */
 				pAddr = (pteVal & ~(pteSize - 1));
 				while (temp++ < numof4KPages) {
-					pPhysAddrPageTbl[pacount++] = pAddr;
+					if (pfn_valid(__phys_to_pfn(pAddr))) {
+						pg = phys_to_page(pAddr);
+						if (page_count(pg) < 1) {
+							pr_info("DSPBRIDGE:"
+							    "UNMAP function: "
+							    "COUNT 0 FOR PA"
+							    " 0x%x, size = "
+							    "0x%x\n",
+							    pAddr, ulNumBytes);
+							bad_page_dump(pAddr,
+									pg);
+						}
+						SetPageDirty(pg);
+						page_cache_release(pg);
+					}
 					pAddr += HW_PAGE_SIZE_4KB;
 				}
 				if (HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize)
@@ -1744,20 +1771,6 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	 */
 EXIT_LOOP:
 	flush_all(pDevContext);
-	for (temp = 0; temp < pacount; temp++) {
-		patemp = pPhysAddrPageTbl[temp];
-		if (pfn_valid(__phys_to_pfn(patemp))) {
-			pg = phys_to_page(patemp);
-			if (page_count(pg) < 1) {
-				pr_info("DSPBRIDGE:UNMAP function: COUNT 0"
-						"FOR PA 0x%x, size = 0x%x\n",
-						patemp, ulNumBytes);
-				bad_page_dump(patemp, pg);
-			}
-			SetPageDirty(pg);
-			page_cache_release(pg);
-		}
-	}
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
 	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemUnMap status %x remBytes %x, "
-- 
1.6.2.4

