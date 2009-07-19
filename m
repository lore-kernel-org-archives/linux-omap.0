From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE: less code nesting for MemUnMap
Date: Sun, 19 Jul 2009 02:15:43 -0500
Message-ID: <1247987744-18373-2-git-send-email-omar.ramirez@ti.com>
References: <1247987744-18373-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39299 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZGSHJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 03:09:01 -0400
In-Reply-To: <1247987744-18373-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

less code nesting for MemUnMap

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |  271 +++++++++++++++++------------------
 1 files changed, 130 insertions(+), 141 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 449de01..268de07 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1612,157 +1612,146 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 		pteAddrL1 = HW_MMU_PteAddrL1(L1BaseVa, vaCurr);
 		pteVal = *(u32 *)pteAddrL1;
 		pteSize = HW_MMU_PteSizeL1(pteVal);
-		if (pteSize == HW_MMU_COARSE_PAGE_SIZE) {
-			/*
-			 * Get the L2 PA from the L1 PTE, and find
-			 * corresponding L2 VA
-			 */
-			L2BasePa = HW_MMU_PteCoarseL1(pteVal);
-			L2BaseVa = L2BasePa - pt->L2BasePa + pt->L2BaseVa;
-			L2PageNum = (L2BasePa - pt->L2BasePa) /
-				    HW_MMU_COARSE_PAGE_SIZE;
-			/*
-			 * Find the L2 PTE address from which we will start
-			 * clearing, the number of PTEs to be cleared on this
-			 * page, and the size of VA space that needs to be
-			 * cleared on this L2 page
-			 */
-			pteAddrL2 = HW_MMU_PteAddrL2(L2BaseVa, vaCurr);
-			pteCount = pteAddrL2 & (HW_MMU_COARSE_PAGE_SIZE - 1);
-			pteCount = (HW_MMU_COARSE_PAGE_SIZE - pteCount) /
-				    sizeof(u32);
-			if (remBytes < (pteCount * PG_SIZE_4K))
-				pteCount = remBytes / PG_SIZE_4K;
-
-			remBytesL2 = pteCount * PG_SIZE_4K;
-			DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2BasePa %x, "
-				  "L2BaseVa %x pteAddrL2 %x, remBytesL2 %x\n",
-				  L2BasePa, L2BaseVa, pteAddrL2, remBytesL2);
-			/*
-			 * Unmap the VA space on this L2 PT. A quicker way
-			 * would be to clear pteCount entries starting from
-			 * pteAddrL2. However, below code checks that we don't
-			 * clear invalid entries or less than 64KB for a 64KB
-			 * entry. Similar checking is done for L1 PTEs too
-			 * below
-			 */
-			while (remBytesL2 && (DSP_SUCCEEDED(status))) {
-				pteVal = *(u32 *)pteAddrL2;
-				pteSize = HW_MMU_PteSizeL2(pteVal);
-				/* vaCurr aligned to pteSize? */
-				if ((pteSize != 0) && (remBytesL2 >= pteSize) &&
-				   !(vaCurr & (pteSize - 1))) {
-					/* Collect Physical addresses from VA */
-					pAddr = (pteVal & ~(pteSize - 1));
-					if (pteSize == HW_PAGE_SIZE_64KB)
-						numof4KPages = 16;
-					else
-						numof4KPages = 1;
-					temp = 0;
-					while (temp++ < numof4KPages) {
-						if (!pfn_valid(__phys_to_pfn(
-								pAddr))) {
-							pAddr +=
-							    HW_PAGE_SIZE_4KB;
-							continue;
-						}
-						pg = phys_to_page(pAddr);
-						if (page_count(pg) < 1) {
-							pr_info("DSPBRIDGE:"
-							    "UNMAP function: "
-							    "COUNT 0 FOR PA "
-							    "0x%x, size = "
-							    "0x%x\n", pAddr,
-							    ulNumBytes);
-							bad_page_dump(pAddr,
-									pg);
-						}
-						SetPageDirty(pg);
-						page_cache_release(pg);
-						pAddr += HW_PAGE_SIZE_4KB;
-					}
-					if (HW_MMU_PteClear(pteAddrL2,
-						vaCurr, pteSize) == RET_OK) {
-						status = DSP_SOK;
-						remBytesL2 -= pteSize;
-						vaCurr += pteSize;
-						pteAddrL2 += (pteSize >> 12) *
-								sizeof(u32);
-					} else {
-						status = DSP_EFAIL;
-						goto EXIT_LOOP;
-					}
-				} else {
-					status = DSP_EFAIL;
-				}
-			}
-			SYNC_EnterCS(pt->hCSObj);
-			if (remBytesL2 == 0) {
-				pt->pgInfo[L2PageNum].numEntries -= pteCount;
-				if (pt->pgInfo[L2PageNum].numEntries == 0) {
-					/*
-					 * Clear the L1 PTE pointing to the
-					 * L2 PT
-					 */
-					if (RET_OK == HW_MMU_PteClear(L1BaseVa,
-					vaCurrOrig, HW_MMU_COARSE_PAGE_SIZE))
-						status = DSP_SOK;
-					else {
-						status = DSP_EFAIL;
-						SYNC_LeaveCS(pt->hCSObj);
-						goto EXIT_LOOP;
-					}
-				}
-				remBytes -= pteCount * PG_SIZE_4K;
-			} else {
+
+		if (pteSize != HW_MMU_COARSE_PAGE_SIZE)
+			goto skip_coarse_page;
+
+		/*
+		 * Get the L2 PA from the L1 PTE, and find
+		 * corresponding L2 VA
+		 */
+		L2BasePa = HW_MMU_PteCoarseL1(pteVal);
+		L2BaseVa = L2BasePa - pt->L2BasePa + pt->L2BaseVa;
+		L2PageNum = (L2BasePa - pt->L2BasePa) / HW_MMU_COARSE_PAGE_SIZE;
+		/*
+		 * Find the L2 PTE address from which we will start
+		 * clearing, the number of PTEs to be cleared on this
+		 * page, and the size of VA space that needs to be
+		 * cleared on this L2 page
+		 */
+		pteAddrL2 = HW_MMU_PteAddrL2(L2BaseVa, vaCurr);
+		pteCount = pteAddrL2 & (HW_MMU_COARSE_PAGE_SIZE - 1);
+		pteCount = (HW_MMU_COARSE_PAGE_SIZE - pteCount) / sizeof(u32);
+		if (remBytes < (pteCount * PG_SIZE_4K))
+			pteCount = remBytes / PG_SIZE_4K;
+		remBytesL2 = pteCount * PG_SIZE_4K;
+		DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2BasePa %x, "
+			  "L2BaseVa %x pteAddrL2 %x, remBytesL2 %x\n",
+			  L2BasePa, L2BaseVa, pteAddrL2, remBytesL2);
+		/*
+		 * Unmap the VA space on this L2 PT. A quicker way
+		 * would be to clear pteCount entries starting from
+		 * pteAddrL2. However, below code checks that we don't
+		 * clear invalid entries or less than 64KB for a 64KB
+		 * entry. Similar checking is done for L1 PTEs too
+		 * below
+		 */
+		while (remBytesL2 && (DSP_SUCCEEDED(status))) {
+			pteVal = *(u32 *)pteAddrL2;
+			pteSize = HW_MMU_PteSizeL2(pteVal);
+			/* vaCurr aligned to pteSize? */
+			if (pteSize == 0 || remBytesL2 < pteSize ||
+						vaCurr & (pteSize - 1)) {
 				status = DSP_EFAIL;
+				break;
 			}
-			DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2PageNum %x, "
-				  "numEntries %x, pteCount %x, status: 0x%x\n",
-				  L2PageNum, pt->pgInfo[L2PageNum].numEntries,
-				  pteCount, status);
-			SYNC_LeaveCS(pt->hCSObj);
-		} else
-			/* vaCurr aligned to pteSize? */
-			/* pteSize = 1 MB or 16 MB */
-			if ((pteSize != 0) && (remBytes >= pteSize) &&
-			   !(vaCurr & (pteSize - 1))) {
-				if (pteSize == HW_PAGE_SIZE_1MB)
-					numof4KPages = 256;
-				else
-					numof4KPages = 4096;
-				temp = 0;
-				/* Collect Physical addresses from VA */
-				pAddr = (pteVal & ~(pteSize - 1));
-				while (temp++ < numof4KPages) {
-					if (pfn_valid(__phys_to_pfn(pAddr))) {
-						pg = phys_to_page(pAddr);
-						if (page_count(pg) < 1) {
-							pr_info("DSPBRIDGE:"
-							    "UNMAP function: "
-							    "COUNT 0 FOR PA"
-							    " 0x%x, size = "
-							    "0x%x\n",
-							    pAddr, ulNumBytes);
-							bad_page_dump(pAddr,
-									pg);
-						}
-						SetPageDirty(pg);
-						page_cache_release(pg);
-					}
+
+			/* Collect Physical addresses from VA */
+			pAddr = (pteVal & ~(pteSize - 1));
+			if (pteSize == HW_PAGE_SIZE_64KB)
+				numof4KPages = 16;
+			else
+				numof4KPages = 1;
+			temp = 0;
+			while (temp++ < numof4KPages) {
+				if (!pfn_valid(__phys_to_pfn(pAddr))) {
 					pAddr += HW_PAGE_SIZE_4KB;
+					continue;
+				}
+				pg = phys_to_page(pAddr);
+				if (page_count(pg) < 1) {
+					pr_info("DSPBRIDGE: UNMAP function: "
+						"COUNT 0 FOR PA 0x%x, size = "
+						"0x%x\n", pAddr, ulNumBytes);
+					bad_page_dump(pAddr, pg);
 				}
-				if (HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize)
-					       == RET_OK) {
+				SetPageDirty(pg);
+				page_cache_release(pg);
+				pAddr += HW_PAGE_SIZE_4KB;
+			}
+			if (HW_MMU_PteClear(pteAddrL2, vaCurr, pteSize)
+							 == RET_FAIL) {
+				status = DSP_EFAIL;
+				goto EXIT_LOOP;
+			}
+
+			status = DSP_SOK;
+			remBytesL2 -= pteSize;
+			vaCurr += pteSize;
+			pteAddrL2 += (pteSize >> 12) * sizeof(u32);
+		}
+		SYNC_EnterCS(pt->hCSObj);
+		if (remBytesL2 == 0) {
+			pt->pgInfo[L2PageNum].numEntries -= pteCount;
+			if (pt->pgInfo[L2PageNum].numEntries == 0) {
+				/*
+				 * Clear the L1 PTE pointing to the L2 PT
+				 */
+				if (HW_MMU_PteClear(L1BaseVa, vaCurrOrig,
+					    HW_MMU_COARSE_PAGE_SIZE) == RET_OK)
 					status = DSP_SOK;
-					remBytes -= pteSize;
-					vaCurr += pteSize;
-				} else {
+				else {
 					status = DSP_EFAIL;
+					SYNC_LeaveCS(pt->hCSObj);
 					goto EXIT_LOOP;
 				}
+			}
+			remBytes -= pteCount * PG_SIZE_4K;
+		} else
+			status = DSP_EFAIL;
+		DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap L2PageNum %x, "
+			  "numEntries %x, pteCount %x, status: 0x%x\n",
+			  L2PageNum, pt->pgInfo[L2PageNum].numEntries,
+			  pteCount, status);
+		SYNC_LeaveCS(pt->hCSObj);
+		continue;
+skip_coarse_page:
+		/* vaCurr aligned to pteSize? */
+		/* pteSize = 1 MB or 16 MB */
+		if (pteSize == 0 || remBytes < pteSize ||
+						 vaCurr & (pteSize - 1)) {
+			status = DSP_EFAIL;
+			break;
+		}
+
+		if (pteSize == HW_PAGE_SIZE_1MB)
+			numof4KPages = 256;
+		else
+			numof4KPages = 4096;
+		temp = 0;
+		/* Collect Physical addresses from VA */
+		pAddr = (pteVal & ~(pteSize - 1));
+		while (temp++ < numof4KPages) {
+			if (pfn_valid(__phys_to_pfn(pAddr))) {
+				pg = phys_to_page(pAddr);
+				if (page_count(pg) < 1) {
+					pr_info("DSPBRIDGE: UNMAP function: "
+						"COUNT 0 FOR PA 0x%x, size = "
+						"0x%x\n", pAddr, ulNumBytes);
+					bad_page_dump(pAddr, pg);
+				}
+				SetPageDirty(pg);
+				page_cache_release(pg);
+			}
+			pAddr += HW_PAGE_SIZE_4KB;
+		}
+		if (HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize) == RET_OK) {
+			status = DSP_SOK;
+			remBytes -= pteSize;
+			vaCurr += pteSize;
 		} else {
 			status = DSP_EFAIL;
+			goto EXIT_LOOP;
 		}
 	}
 	/*
-- 
1.6.2.4

