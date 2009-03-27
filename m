From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] [OMAPZOOM] DSPBRIDGE: Add DSP_MMU_DEBUG
Date: Thu, 26 Mar 2009 20:11:44 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2BC64@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48209 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763134AbZC0BLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 21:11:52 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2R1Bksd025530
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:11:51 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2R1Bksh002334
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 20:11:46 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 1e8c0757f37656273772ef0e53914c99ace9a5d0 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Thu, 26 Mar 2009 16:38:10 -0500
Subject: [PATCH] DSPBRIDGE: Add DSP_MMU_DEBUG

This patch enables to monitor the usage of DSP Virtual memory by printing the
used memory region, free memory region, and the largest contiguous memory
region.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/pmgr/dmm.c  |   46 ++++++++++++++++++++++++++++++++++++++++
 drivers/dsp/bridge/rmgr/node.c |   23 ++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index be1567a..803de93
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -121,6 +121,9 @@ static u32  TableSize;/* The size of virtual and physical pages tables */
 static struct MapPage *GetRegion(u32 addr);
 static struct MapPage *GetFreeRegion(u32 aSize);
 static struct MapPage *GetMappedRegion(u32 aAddr);
+#ifdef DSP_DMM_DEBUG
+u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr);
+#endif
 
 /*  ======== DMM_CreateTables ========
  *  Purpose:
@@ -644,3 +647,46 @@ u32 *DMM_GetPhysicalAddrTable(void)
 			pPhysicalAddrTable);
 	return pPhysicalAddrTable;
 }
+
+#ifdef DSP_DMM_DEBUG
+u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr)
+{
+	struct MapPage *curNode = NULL;
+	u32 i;
+	u32 freemem = 0;
+	u32 bigsize = 0;
+
+	SYNC_EnterCS(hDmmMgr->hDmmLock);
+
+	if (pVirtualMappingTable != NULL) {
+		for (i = 0; i < TableSize; i +=
+				pVirtualMappingTable[i].RegionSize) {
+			curNode = pVirtualMappingTable + i;
+			if (curNode->bReserved == TRUE)	{
+				/*printk("RESERVED size = 0x%x, "
+					"Map size = 0x%x\n",
+					(curNode->RegionSize * PG_SIZE_4K),
+					(curNode->bMapped == false) ? 0 :
+					(curNode->MappedSize * PG_SIZE_4K));
+*/
+			} else {
+/*				printk("UNRESERVED size = 0x%x\n",
+					(curNode->RegionSize * PG_SIZE_4K));
+*/
+				freemem += (curNode->RegionSize * PG_SIZE_4K);
+				if (curNode->RegionSize > bigsize)
+					bigsize = curNode->RegionSize;
+			}
+		}
+	}
+	printk(KERN_INFO "Total DSP VA FREE memory = %d Mbytes\n",
+			freemem/(1024*1024));
+	printk(KERN_INFO "Total DSP VA USED memory= %d Mbytes \n",
+			(((TableSize * PG_SIZE_4K)-freemem))/(1024*1024));
+	printk(KERN_INFO "DSP VA - Biggest FREE block = %d Mbytes \n\n",
+			(bigsize*PG_SIZE_4K/(1024*1024)));
+	SYNC_LeaveCS(hDmmMgr->hDmmLock);
+
+	return 0;
+}
+#endif
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 2a6590e..1fae5d9 100755
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -359,6 +359,10 @@ static u32 Write(void *pPrivRef, u32 ulDspAddr, void *pBuf,
 static struct GT_Mask NODE_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif
 
+#ifdef DSP_DMM_DEBUG
+extern u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr);
+#endif
+
 static u32 cRefs;		/* module reference count */
 
 /* Dynamic loader functions. */
@@ -425,6 +429,10 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	struct CFG_HOSTRES hostRes;
 	u32 pMappedAddr = 0;
 	u32 mapAttrs = 0x0;
+#ifdef DSP_DMM_DEBUG
+	struct DMM_OBJECT *hDmmMgr;
+	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+#endif
 
 #ifndef RES_CLEANUP_DISABLE
 
@@ -547,6 +555,11 @@ func_cont:
 			 "NODE_Allocate: DSPProcessor_Reserve"
 			 " Memory successful: 0x%x\n", status);
 	}
+#ifdef DSP_DMM_DEBUG
+	status = DMM_GetHandle(pProcObject, &hDmmMgr);
+	if (DSP_SUCCEEDED(status))
+		DMM_MemMapDump(hDmmMgr);
+#endif
 	if (DSP_FAILED(status))
 		goto func_cont3;
 
@@ -2824,6 +2837,11 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 	struct STREAM stream;
 	struct NODE_MSGARGS msgArgs;
 	struct NODE_TASKARGS taskArgs;
+#ifdef DSP_DMM_DEBUG
+	struct DMM_OBJECT *hDmmMgr;
+	struct PROC_OBJECT *pProcObject =
+			(struct PROC_OBJECT *)hNode->hProcessor;
+#endif
 	DSP_STATUS status;
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
 	hNodeMgr = hNode->hNodeMgr;
@@ -2909,6 +2927,11 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 					 "failed. Status = 0x%x\n",
 					 (u32)status);
 			}
+#ifdef DSP_DMM_DEBUG
+			status = DMM_GetHandle(pProcObject, &hDmmMgr);
+			if (DSP_SUCCEEDED(status))
+				DMM_MemMapDump(hDmmMgr);
+#endif
 		}
 	}
 	if (nodeType != NODE_MESSAGE) {
-- 
1.5.6.4

