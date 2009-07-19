From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: DSPBRIDGE: create DMM table using vmalloc instead of kmalloc
Date: Sun, 19 Jul 2009 17:20:25 -0500
Message-ID: <1248042025-11227-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39430 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbZGSWNh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jul 2009 18:13:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Replace the physical contiguos allocation for DMM tables as the
required space might not available after some time, use virtual memory
allocation instead.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |   17 +++++++++
 drivers/dsp/bridge/pmgr/dmm.c              |    6 ++--
 drivers/dsp/bridge/services/mem.c          |   55 +++++++++++++++++++++-------
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 535ac3a..38c760b 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -203,6 +203,23 @@
 	extern void MEM_Free(IN void *pMemBuf);
 
 /*
+ *  ======== MEM_VFree ========
+ *  Purpose:
+ *      Free the given block of system memory in virtual space.
+ *  Parameters:
+ *      pMemBuf:    Pointer to memory allocated by MEM_Calloc/Alloc()
+ *		    using vmalloc.
+ *  Returns:
+ *  Requires:
+ *      MEM initialized.
+ *      pMemBuf is a valid memory address returned by MEM_Calloc/Alloc()
+ *	using vmalloc.
+ *  Ensures:
+ *      pMemBuf is no longer a valid pointer to memory.
+ */
+	extern void MEM_VFree(IN void *pMemBuf);
+
+/*
  *  ======== MEM_FreePhysMem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 0f82935..f878855 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -143,10 +143,10 @@ DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 	if (DSP_SUCCEEDED(status)) {
 		SYNC_EnterCS(pDmmObj->hDmmLock);
 		dynMemMapBeg = addr;
-		TableSize = (size/PG_SIZE_4K) + 1;
+		TableSize = PG_ALIGN_HIGH(size, PG_SIZE_4K)/PG_SIZE_4K;
 		/*  Create the free list */
 		pVirtualMappingTable = (struct MapPage *) MEM_Calloc
-		(TableSize*sizeof(struct MapPage), MEM_NONPAGED);
+			(TableSize * sizeof(struct MapPage), MEM_LARGEVIRTMEM);
 		if (pVirtualMappingTable == NULL)
 			status = DSP_EMEMORY;
 		else {
@@ -255,7 +255,7 @@ DSP_STATUS DMM_DeleteTables(struct DMM_OBJECT *hDmmMgr)
 		SYNC_EnterCS(pDmmObj->hDmmLock);
 
 		if (pVirtualMappingTable != NULL)
-			MEM_Free(pVirtualMappingTable);
+			MEM_VFree(pVirtualMappingTable);
 
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
 	} else
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 47ec09b..22f382b 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -303,13 +303,9 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 			break;
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
-			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem = __vmalloc(cBytes,
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = vmalloc(cBytes);
 #else
-			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem = __vmalloc((cBytes + sizeof(struct memInfo)),
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = vmalloc(cBytes + sizeof(struct memInfo));
 			if (pMem) {
 				pMem->size = cBytes;
 				pMem->caller = __builtin_return_address(0);
@@ -416,16 +412,11 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 			break;
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
-			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem = __vmalloc(cBytes,
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = vmalloc(cBytes);
 			if (pMem)
 				memset(pMem, 0, cBytes);
-
 #else
-			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem = __vmalloc(cBytes + sizeof(struct memInfo),
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL, PAGE_KERNEL);
+			pMem = vmalloc(cBytes + sizeof(struct memInfo));
 			if (pMem) {
 				memset((void *)((u32)pMem +
 					sizeof(struct memInfo)), 0, cBytes);
@@ -509,6 +500,44 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
 
 }
 
+/*
+ *  ======== MEM_VFree ========
+ *  Purpose:
+ *      Free the given block of system memory in virtual space.
+ */
+void MEM_VFree(IN void *pMemBuf)
+{
+#ifdef MEM_CHECK
+	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
+#endif
+
+	DBC_Require(pMemBuf != NULL);
+
+	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_VFree: pMemBufs 0x%x\n",
+		  pMemBuf);
+
+	if (pMemBuf) {
+#ifndef MEM_CHECK
+		vfree(pMemBuf);
+#else
+		if (pMem) {
+			if (pMem->dwSignature == memInfoSign) {
+				spin_lock(&mMan.lock);
+				MLST_RemoveElem(&mMan.lst,
+						(struct LST_ELEM *) pMem);
+				spin_unlock(&mMan.lock);
+				pMem->dwSignature = 0;
+				vfree(pMem);
+			} else {
+				GT_1trace(MEM_debugMask, GT_7CLASS,
+					"Invalid allocation or "
+					"Buffer underflow at %x\n",
+					(u32) pMem + sizeof(struct memInfo));
+			}
+		}
+#endif
+	}
+}
 
 /*
  *  ======== MEM_Free ========
-- 
1.6.2.4

