From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 4/7][OMAP 3/4+] BRIDGE tiomap unmap fix
Date: Fri, 12 Sep 2008 23:04:39 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344A4F04D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbYIMEEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 00:04:46 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8D44fUK027915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:04:46 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8D44fgH009619
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:04:41 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Haslam, Axel" <axelhaslam@ti.com>

From: Axel Haslam <axelhaslam@ti.com>
Date: Fri, 12 Sep 2008 19:09:01 -0500
Subject: [PATCH] BRIDGE tiomap unmap fix

Fixed unexpected return value when calling DSPProcessor_UnMap,
now it provides only DSP_xxx return codes

Signed-off-by: Axel Haslam <axelhaslam@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   40 ++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index e5c235d..5ff3670 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1506,12 +1506,17 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 				/* vaCurr aligned to pteSize? */
 				if ((pteSize != 0) && (remBytesL2 >= pteSize) &&
 				   !(vaCurr & (pteSize - 1))) {
-					HW_MMU_PteClear(pteAddrL2, vaCurr,
-							 pteSize);
-					remBytesL2 -= pteSize;
-					vaCurr += pteSize;
-					pteAddrL2 += (pteSize >> 12) *
-						      sizeof(u32);
+					if (HW_MMU_PteClear(pteAddrL2,
+						vaCurr, pteSize) == RET_OK) {
+						status = DSP_SOK;
+						remBytesL2 -= pteSize;
+						vaCurr += pteSize;
+						pteAddrL2 += (pteSize >> 12) *
+								sizeof(u32);
+					} else {
+						status = DSP_EFAIL;
+						goto EXIT_LOOP;
+					}
 				} else {
 					status = DSP_EFAIL;
 				}
@@ -1522,9 +1527,13 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 				if (pt->pgInfo[L2PageNum].numEntries == 0) {
 					/* Clear the L1 PTE pointing to the
 					 * L2 PT */
-					status = HW_MMU_PteClear(L1BaseVa,
-						 vaCurrOrig,
-						 HW_MMU_COARSE_PAGE_SIZE);
+					if (RET_OK == HW_MMU_PteClear(L1BaseVa,
+					vaCurrOrig, HW_MMU_COARSE_PAGE_SIZE))
+						status = DSP_SOK;
+					else {
+						status = DSP_EFAIL;
+						goto EXIT_LOOP;
+					}
 				}
 				remBytes -= pteCount * PG_SIZE_4K;
 			} else {
@@ -1540,15 +1549,22 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 			/* pteSize = 1 MB or 16 MB */
 			if ((pteSize != 0) && (remBytes >= pteSize) &&
 			   !(vaCurr & (pteSize - 1))) {
-				HW_MMU_PteClear(L1BaseVa, vaCurr, pteSize);
-				remBytes -= pteSize;
-				vaCurr += pteSize;
+				if (HW_MMU_PteClear(L1BaseVa,
+					vaCurr, pteSize) == RET_OK) {
+					status = DSP_SOK;
+					remBytes -= pteSize;
+					vaCurr += pteSize;
+				} else {
+					status = DSP_EFAIL;
+					goto EXIT_LOOP;
+				}
 		} else {
 			status = DSP_EFAIL;
 		}
 	}
 	 /* It is better to flush the TLB here, so that any stale old entries
 	 * get flushed */
+EXIT_LOOP:
 	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
-- 
1.5.5.4

