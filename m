From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] DSPBRIDGE: cleanup for PROC_FlushMemory/PROC_InvalidateMemory
Date: Wed, 22 Jul 2009 11:22:49 +0300
Message-ID: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57263 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZGVIXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 04:23:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, ameya.palande@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Both functions are almost same structure except its flag passed to
MEM_FlushCache().

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   82 ++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f6045bb..3a2879f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -735,39 +735,51 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 	return status;
 }
 
-/*
- *  ======== PROC_FlushMemory ========
- *  Purpose:
- *     Flush cache
- */
-DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
-			   u32 ulSize, u32 ulFlags)
+
+static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
+				   u32 ulSize, u32 ulFlags,
+				   enum DSP_FLUSHTYPE FlushMemType)
 {
 	/* Keep STATUS here for future additions to this function */
 	DSP_STATUS status = DSP_SOK;
-	enum DSP_FLUSHTYPE FlushMemType = PROC_WRITEBACK_INVALIDATE_MEM;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+
 	DBC_Require(cRefs > 0);
+	GT_5trace(PROC_DebugMask, GT_ENTER,
+		  "Entered %s, args:\n\t"
+		  "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
+		  __func__, hProcessor, pMpuAddr, ulSize, ulFlags);
 
-	GT_4trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_FlushMemory, args:\n\t"
-		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
-		 hProcessor, pMpuAddr, ulSize, ulFlags);
-	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-		/* Critical section */
-		(void)SYNC_EnterCS(hProcLock);
-		MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-		(void)SYNC_LeaveCS(hProcLock);
-	} else {
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		GT_1trace(PROC_DebugMask, GT_7CLASS,
+			  "%s: InValid Processor Handle\n", __func__);
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_FlushMemory: "
-			 "InValid Processor Handle \n");
+		goto err_out;
 	}
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_FlushMemory [0x%x]",
-		 status);
+
+	(void)SYNC_EnterCS(hProcLock);
+	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
+	(void)SYNC_LeaveCS(hProcLock);
+
+err_out:
+	GT_2trace(PROC_DebugMask, GT_ENTER,
+		  "Leaving %s [0x%x]", __func__, status);
+
 	return status;
 }
 
+/*
+ *  ======== PROC_FlushMemory ========
+ *  Purpose:
+ *     Flush cache
+ */
+DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
+			    u32 ulSize, u32 ulFlags)
+{
+	enum DSP_FLUSHTYPE mtype = PROC_WRITEBACK_INVALIDATE_MEM;
+
+	return proc_memory_sync(hProcessor, pMpuAddr, ulSize, ulFlags, mtype);
+}
 
 /*
  *  ======== PROC_InvalidateMemory ========
@@ -775,29 +787,11 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
  *     Invalidates the memory specified
  */
 DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
-				u32 ulSize)
+				 u32 ulSize)
 {
-	/* Keep STATUS here for future additions to this function */
-	DSP_STATUS status = DSP_SOK;
-	enum DSP_FLUSHTYPE FlushMemType = PROC_INVALIDATE_MEM;
-	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-	DBC_Require(cRefs > 0);
-	GT_3trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_InvalidateMemory, args:\n\t"
-		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x\n", hProcessor,
-		 pMpuAddr, ulSize);
-	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-		(void)SYNC_EnterCS(hProcLock);
-		MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-		(void)SYNC_LeaveCS(hProcLock);
-	} else {
-		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_InvalidateMemory: "
-			 "InValid Processor Handle \n");
-	}
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Leaving PROC_InvalidateMemory [0x%x]", status);
-	return status;
+	enum DSP_FLUSHTYPE mtype = PROC_INVALIDATE_MEM;
+
+	return proc_memory_sync(hProcessor, pMpuAddr, ulSize, 0, mtype);
 }
 
 /*
-- 
1.6.0.4

