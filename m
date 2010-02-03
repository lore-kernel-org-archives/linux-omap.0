From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/3] DSPBRIDGE: Get rid of MEM_CHECK mechanism
Date: Thu,  4 Feb 2010 01:32:24 +0200
Message-ID: <a6ecbd848415c68bd5651109ac755c34debbbce3.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60680 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0BCXcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 18:32:39 -0500
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

kmemleak offeres the same functionality as custom MEM_CHECK
mechanism, so get rid of MEM_CHECK.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |  212 +------------------------------------
 1 files changed, 2 insertions(+), 210 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index cee646a..c4b1fe1 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -34,11 +34,6 @@
 
 /*  ----------------------------------- Defines */
 #define MEM_512MB   0x1fffffff
-#define memInfoSign 0x464E494D	/* "MINF" (in reverse). */
-
-#ifdef CONFIG_BRIDGE_DEBUG
-#define MEM_CHECK		/* Use to detect source of memory leaks */
-#endif
 
 /*  ----------------------------------- Globals */
 #if GT_TRACE
@@ -56,85 +51,6 @@ struct extPhysMemPool {
 
 static struct extPhysMemPool extMemPool;
 
-/*  Information about each element allocated on heap */
-struct memInfo {
-	struct list_head link;		/* Must be first */
-	size_t size;
-	void *caller;
-	u32 dwSignature;	/* Should be last */
-};
-
-#ifdef MEM_CHECK
-
-/*
- *  This structure holds a linked list to all memory elements allocated on
- *  heap by DSP/BIOS Bridge. This is used to report memory leaks and free
- *  such elements while removing the DSP/BIOS Bridge driver
- */
-struct memMan {
-	struct LST_LIST lst;
-	spinlock_t lock;
-};
-
-static struct memMan mMan;
-
-/*
- *  These functions are similar to LST_PutTail and LST_RemoveElem and are
- *  duplicated here to make MEM independent of LST
- */
-static inline void MLST_PutTail(struct LST_LIST *pList, struct list_head *pElem)
-{
-	pElem->prev = pList->head.prev;
-	pElem->next = &pList->head;
-	pList->head.prev = pElem;
-	pElem->prev->next = pElem;
-}
-
-static inline void MLST_RemoveElem(struct LST_LIST *pList,
-				   struct list_head *pCurElem)
-{
-	pCurElem->prev->next = pCurElem->next;
-	pCurElem->next->prev = pCurElem->prev;
-	pCurElem->next = NULL;
-	pCurElem->prev = NULL;
-}
-
-static void MEM_Check(void)
-{
-	struct memInfo *pMem;
-	struct list_head *last = &mMan.lst.head;
-	struct list_head *curr = last->next;
-
-	if (!LST_IsEmpty(&mMan.lst)) {
-		GT_0trace(MEM_debugMask, GT_7CLASS, "*** MEMORY LEAK ***\n");
-		GT_0trace(MEM_debugMask, GT_7CLASS,
-			  "Addr      Size      Caller\n");
-		while (curr != last) {
-			pMem = (struct memInfo *)curr;
-			curr = curr->next;
-			if ((u32)pMem > PAGE_OFFSET &&
-			    MEM_IsValidHandle(pMem, memInfoSign)) {
-				GT_3trace(MEM_debugMask, GT_7CLASS,
-					"%lx  %d\t [<%p>]\n",
-					(u32) pMem + sizeof(struct memInfo),
-					pMem->size, pMem->caller);
-				MLST_RemoveElem(&mMan.lst,
-						(struct list_head *)pMem);
-				kfree(pMem);
-			} else {
-				GT_1trace(MEM_debugMask, GT_7CLASS,
-					  "Invalid allocation or "
-					  "Buffer underflow at %x\n",
-					  (u32)pMem +	sizeof(struct memInfo));
-				break;
-			}
-		}
-	}
-	DBC_Ensure(LST_IsEmpty(&mMan.lst));
-}
-
-#endif
-
 void MEM_ExtPhysPoolInit(u32 poolPhysBase, u32 poolSize)
 {
 	u32 poolVirtBase;
@@ -233,7 +149,7 @@ static void *MEM_ExtPhysMemAlloc(u32 bytes, u32 align, OUT u32 *pPhysAddr)
  */
 void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 {
-	struct memInfo *pMem = NULL;
+	void *pMem = NULL;
 
 	GT_2trace(MEM_debugMask, GT_ENTER,
 		  "MEM_Alloc: cBytes 0x%x\ttype 0x%x\n", cBytes, type);
@@ -242,46 +158,11 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_NONPAGED:
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
-#ifndef MEM_CHECK
 			pMem = kmalloc(cBytes,
 				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-#else
-			pMem = kmalloc(cBytes + sizeof(struct memInfo),
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-			if (pMem) {
-				pMem->size = cBytes;
-				pMem->caller = __builtin_return_address(0);
-				pMem->dwSignature = memInfoSign;
-
-				spin_lock(&mMan.lock);
-				MLST_PutTail(&mMan.lst,
-					    (struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-
-				pMem = (void *)((u32)pMem +
-					sizeof(struct memInfo));
-			}
-#endif
 			break;
 		case MEM_LARGEVIRTMEM:
-#ifndef MEM_CHECK
 			pMem = vmalloc(cBytes);
-#else
-			pMem = vmalloc(cBytes + sizeof(struct memInfo));
-			if (pMem) {
-				pMem->size = cBytes;
-				pMem->caller = __builtin_return_address(0);
-				pMem->dwSignature = memInfoSign;
-
-				spin_lock(&mMan.lock);
-				MLST_PutTail(&mMan.lst,
-					    (struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-
-				pMem = (void *)((u32)pMem +
-					sizeof(struct memInfo));
-			}
-#endif
 			break;
 
 		default:
@@ -335,7 +216,7 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
  */
 void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 {
-	struct memInfo *pMem = NULL;
+	void *pMem = NULL;
 
 	GT_2trace(MEM_debugMask, GT_ENTER,
 		  "MEM_Calloc: cBytes 0x%x\ttype 0x%x\n",
@@ -346,51 +227,16 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_NONPAGED:
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
-#ifndef MEM_CHECK
 			pMem = kmalloc(cBytes,
 				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
 			if (pMem)
 				memset(pMem, 0, cBytes);
 
-#else
-			pMem = kmalloc(cBytes + sizeof(struct memInfo),
-				(in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
-			if (pMem) {
-				memset((void *)((u32)pMem +
-					sizeof(struct memInfo)), 0, cBytes);
-				pMem->size = cBytes;
-				pMem->caller = __builtin_return_address(0);
-				pMem->dwSignature = memInfoSign;
-				spin_lock(&mMan.lock);
-				MLST_PutTail(&mMan.lst,
-					(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem = (void *)((u32)pMem +
-					sizeof(struct memInfo));
-			}
-#endif
 			break;
 		case MEM_LARGEVIRTMEM:
-#ifndef MEM_CHECK
 			pMem = vmalloc(cBytes);
 			if (pMem)
 				memset(pMem, 0, cBytes);
-#else
-			pMem = vmalloc(cBytes + sizeof(struct memInfo));
-			if (pMem) {
-				memset((void *)((u32)pMem +
-					sizeof(struct memInfo)), 0, cBytes);
-				pMem->size = cBytes;
-				pMem->caller = __builtin_return_address(0);
-				pMem->dwSignature = memInfoSign;
-				spin_lock(&mMan.lock);
-				MLST_PutTail(&mMan.lst,
-						(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem = (void *)((u32)pMem +
-					sizeof(struct memInfo));
-			}
-#endif
 			break;
 		default:
 			GT_1trace(MEM_debugMask, GT_6CLASS,
@@ -410,9 +256,6 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
  */
 void MEM_Exit(void)
 {
-#ifdef MEM_CHECK
-	MEM_Check();
-#endif
 }
 
 /*
@@ -455,35 +298,13 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
  */
 void MEM_VFree(IN void *pMemBuf)
 {
-#ifdef MEM_CHECK
-	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
-#endif
-
 	DBC_Require(pMemBuf != NULL);
 
 	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_VFree: pMemBufs 0x%x\n",
 		  pMemBuf);
 
 	if (pMemBuf) {
-#ifndef MEM_CHECK
 		vfree(pMemBuf);
-#else
-		if (pMem) {
-			if (pMem->dwSignature == memInfoSign) {
-				spin_lock(&mMan.lock);
-				MLST_RemoveElem(&mMan.lst,
-						(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem->dwSignature = 0;
-				vfree(pMem);
-			} else {
-				GT_1trace(MEM_debugMask, GT_7CLASS,
-					"Invalid allocation or "
-					"Buffer underflow at %x\n",
-					(u32) pMem + sizeof(struct memInfo));
-			}
-		}
-#endif
 	}
 }
 
@@ -494,35 +315,13 @@ void MEM_VFree(IN void *pMemBuf)
  */
 void MEM_Free(IN void *pMemBuf)
 {
-#ifdef MEM_CHECK
-	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
-#endif
-
 	DBC_Require(pMemBuf != NULL);
 
 	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_Free: pMemBufs 0x%x\n",
 		  pMemBuf);
 
 	if (pMemBuf) {
-#ifndef MEM_CHECK
 		kfree(pMemBuf);
-#else
-		if (pMem) {
-			if (pMem->dwSignature == memInfoSign) {
-				spin_lock(&mMan.lock);
-				MLST_RemoveElem(&mMan.lst,
-						(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem->dwSignature = 0;
-				kfree(pMem);
-			} else {
-				GT_1trace(MEM_debugMask, GT_7CLASS,
-					"Invalid allocation or "
-					"Buffer underflow at %x\n",
-					(u32) pMem + sizeof(struct memInfo));
-			}
-		}
-#endif
 	}
 }
 
@@ -552,12 +351,5 @@ void MEM_FreePhysMem(void *pVirtualAddress, u32 pPhysicalAddress,
 bool MEM_Init(void)
 {
 	GT_create(&MEM_debugMask, "MM");	/* MM for MeM module */
-
-#ifdef MEM_CHECK
-	mMan.lst.head.next = &mMan.lst.head;
-	mMan.lst.head.prev = &mMan.lst.head;
-	spin_lock_init(&mMan.lock);
-#endif
-
 	return true;
 }
-- 
1.6.3.3

