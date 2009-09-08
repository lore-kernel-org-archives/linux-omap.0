From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv3 3/3] dspbridge: Don't use LST_Create() and LST_Delete()
Date: Tue,  8 Sep 2009 15:12:16 +0300
Message-ID: <1252411936-25722-4-git-send-email-andy.shevchenko@gmail.com>
References: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
 <1252411936-25722-2-git-send-email-andy.shevchenko@gmail.com>
 <1252411936-25722-3-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38753 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbZIHMMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 08:12:41 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n88CBUj2007641
	for <linux-omap@vger.kernel.org>; Tue, 8 Sep 2009 07:12:05 -0500
In-Reply-To: <1252411936-25722-3-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Change LST_Create() to the MEM_Calloc() and INIT_LIST_HEAD() pair in optimal way.

Use MEM_Free() instead of LST_Delete(). We can use it without checking because
MEM_Free() validates input parameter.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   64 ---------------------------
 drivers/dsp/bridge/pmgr/cmm.c               |   27 +++++++----
 drivers/dsp/bridge/pmgr/dev.c               |    9 +++-
 drivers/dsp/bridge/rmgr/drv.c               |   18 +++++---
 drivers/dsp/bridge/rmgr/node.c              |    6 ++-
 drivers/dsp/bridge/rmgr/rmm.c               |    7 ++-
 drivers/dsp/bridge/services/ntfy.c          |    6 ++-
 drivers/dsp/bridge/wmd/chnl_sm.c            |    5 +-
 drivers/dsp/bridge/wmd/msg_sm.c             |   26 ++++++++---
 9 files changed, 70 insertions(+), 98 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index f382b20..1110baa 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -22,8 +22,6 @@
  *      of inline list management functions.
  *
  *  Public Functions:
- *      LST_Create
- *      LST_Delete
  *      LST_First
  *      LST_GetHead
  *      LST_InitElem
@@ -49,8 +47,6 @@
 #define LIST_
 
 #include <dspbridge/host_os.h>
-/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
-#include <dspbridge/mem.h>
 #include <linux/list.h>
 
 #define LST_IsEmpty(l)      list_empty(&(l)->head)
@@ -60,66 +56,6 @@ struct LST_LIST {
 };
 
 /*
- *  ======== LST_Create ========
- *  Purpose:
- *      Allocates and initializes a circular list.
- *  Details:
- *      Uses portable MEM_Calloc() function to allocate a list containing
- *      a single element and initializes that element to indicate that it
- *      is the "end of the list" (i.e., the list is empty).
- *      An empty list is indicated by the "next" pointer in the element
- *      at the head of the list pointing to the head of the list, itself.
- *  Parameters:
- *  Returns:
- *      Pointer to beginning of created list (success)
- *      NULL --> Allocation failed
- *  Requires:
- *      LST initialized.
- *  Ensures:
- *  Notes:
- *      The created list contains a single element.  This element is the
- *      "empty" element, because its "next" and "prev" pointers point at
- *      the same location (the element itself).
- */
-static inline struct LST_LIST *LST_Create(void)
-{
-	struct LST_LIST *pList;
-
-	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
-		MEM_NONPAGED);
-	if (pList != NULL)
-		INIT_LIST_HEAD(&pList->head);
-
-	return pList;
-}
-
-/*
- *  ======== LST_Delete ========
- *  Purpose:
- *      Removes a list by freeing its control structure's memory space.
- *  Details:
- *      Uses portable MEM_Free() function to deallocate the memory
- *      block pointed at by the input parameter.
- *  Parameters:
- *      pList:  Pointer to list control structure of list to be deleted
- *  Returns:
- *      Void
- *  Requires:
- *      - LST initialized.
- *      - pList != NULL.
- *  Ensures:
- *  Notes:
- *      Must ONLY be used for empty lists, because it does not walk the
- *      chain of list elements.  Calling this function on a non-empty list
- *      will cause a memory leak.
- */
-static inline void LST_Delete(struct LST_LIST *pList)
-{
-	if (pList != NULL)
-		MEM_Free(pList);
-}
-
-/*
  *  ======== LST_First ========
  *  Purpose:
  *      Returns a pointer to the first element of the list, or NULL if the list
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 571aa12..fce46fc 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -359,12 +359,15 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 		 * MEM_AllocObject */
 		if (DSP_SUCCEEDED(status)) {
 			/* create node free list */
-			pCmmObject->pNodeFreeListHead = LST_Create();
+			pCmmObject->pNodeFreeListHead = MEM_Calloc(sizeof(struct
+				LST_LIST), MEM_NONPAGED);
 			if (pCmmObject->pNodeFreeListHead == NULL) {
 				GT_0trace(CMM_debugMask, GT_7CLASS,
-					  "CMM_Create: LST_Create() "
-					  "failed \n");
+					  "CMM_Create: Out of memory \n");
 				status = DSP_EMEMORY;
+			} else {
+				INIT_LIST_HEAD(&pCmmObject->pNodeFreeListHead->
+					head);
 			}
 		}
 		if (DSP_SUCCEEDED(status))
@@ -433,7 +436,7 @@ DSP_STATUS CMM_Destroy(struct CMM_OBJECT *hCmmMgr, bool bForce)
 			MEM_Free(pNode);
 		}
 		/* delete NodeFreeList list */
-		LST_Delete(pCmmMgr->pNodeFreeListHead);
+		MEM_Free(pCmmMgr->pNodeFreeListHead);
 	}
 	SYNC_LeaveCS(pCmmMgr->hCmmLock);
 	if (DSP_SUCCEEDED(status)) {
@@ -698,25 +701,29 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 			/* return the actual segment identifier */
 			*pulSegId = (u32) nSlot + 1;
 			/* create memory free list */
-			pSMA->pFreeListHead = LST_Create();
+			pSMA->pFreeListHead = MEM_Calloc(sizeof(struct
+				LST_LIST), MEM_NONPAGED);
 			if (pSMA->pFreeListHead == NULL) {
 				GT_0trace(CMM_debugMask, GT_7CLASS,
 					  "CMM_RegisterGPPSMSeg: "
-					  "Out Of Memory \n");
+					  "Out Of Memory 1 \n");
 				status = DSP_EMEMORY;
 				goto func_end;
 			}
+			INIT_LIST_HEAD(&pSMA->pFreeListHead->head);
 		}
 		if (DSP_SUCCEEDED(status)) {
 			/* create memory in-use list */
-			pSMA->pInUseListHead = LST_Create();
+			pSMA->pInUseListHead = MEM_Calloc(sizeof(struct
+				LST_LIST), MEM_NONPAGED);
 			if (pSMA->pInUseListHead == NULL) {
 				GT_0trace(CMM_debugMask, GT_7CLASS,
 					  "CMM_RegisterGPPSMSeg: "
-					  "LST_Create failed\n");
+					  "Out of memory 2 \n");
 				status = DSP_EMEMORY;
 				goto func_end;
 			}
+			INIT_LIST_HEAD(&pSMA->pInUseListHead->head);
 		}
 		if (DSP_SUCCEEDED(status)) {
 			/* Get a mem node for this hunk-o-memory */
@@ -826,7 +833,7 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		LST_Delete(pSMA->pFreeListHead);	/* delete freelist */
+		MEM_Free(pSMA->pFreeListHead);		/* delete freelist */
 		/* free nodes on InUse list */
 		pCurNode = (struct CMM_MNODE *)LST_First(pSMA->pInUseListHead);
 		while (pCurNode) {
@@ -839,7 +846,7 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		LST_Delete(pSMA->pInUseListHead);	/* delete InUse list */
+		MEM_Free(pSMA->pInUseListHead);		/* delete InUse list */
 	}
 	if ((void *) pSMA->dwVmBase != NULL)
 		MEM_UnmapLinearAddress((void *) pSMA->dwVmBase);
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 8ba3a7f..a206f7f 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -374,11 +374,14 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	}
 	/* Create the Processor List */
 	if (DSP_SUCCEEDED(status)) {
-		pDevObject->procList = LST_Create();
+		pDevObject->procList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		if (!(pDevObject->procList)) {
 			status = DSP_EFAIL;
 			GT_0trace(debugMask, GT_7CLASS, "DEV_Create: "
 				 "Failed to Create Proc List");
+		} else {
+			INIT_LIST_HEAD(&pDevObject->procList->head);
 		}
 	}
 	 /*  If all went well, return a handle to the dev object;
@@ -390,7 +393,7 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 			 "0x%x\n", pDevObject);
 	} else {
 		if (pDevObject && pDevObject->procList)
-			LST_Delete(pDevObject->procList);
+			MEM_Free(pDevObject->procList);
 
 		if (pDevObject && pDevObject->hCodMgr)
 			COD_Delete(pDevObject->hCodMgr);
@@ -546,7 +549,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 			status = DSP_EFAIL;
 		if (DSP_SUCCEEDED(status)) {
 			if (pDevObject->procList) {
-				LST_Delete(pDevObject->procList);
+				MEM_Free(pDevObject->procList);
 				pDevObject->procList = NULL;
 			}
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index ca774c9..bc357bd 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -708,15 +708,21 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 	MEM_AllocObject(pDRVObject, struct DRV_OBJECT, SIGNATURE);
 	if (pDRVObject) {
 		/* Create and Initialize List of device objects */
-		pDRVObject->devList = LST_Create();
+		pDRVObject->devList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		if (pDRVObject->devList) {
 			/* Create and Initialize List of device Extension */
-			pDRVObject->devNodeString = LST_Create();
+			pDRVObject->devNodeString = MEM_Calloc(sizeof(struct
+				LST_LIST), MEM_NONPAGED);
 			if (!(pDRVObject->devNodeString)) {
 				status = DSP_EFAIL;
 				GT_0trace(curTrace, GT_7CLASS,
 					 "Failed to Create DRV_EXT list ");
 				MEM_FreeObject(pDRVObject);
+			} else {
+				INIT_LIST_HEAD(&pDRVObject->devNodeString->
+					head);
+				INIT_LIST_HEAD(&pDRVObject->devList->head);
 			}
 		} else {
 			status = DSP_EFAIL;
@@ -792,11 +798,11 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
 	 */
 	if (pDRVObject->devList) {
 		/* Could assert if the list is not empty  */
-		LST_Delete(pDRVObject->devList);
+		MEM_Free(pDRVObject->devList);
 	}
 	if (pDRVObject->devNodeString) {
 		/* Could assert if the list is not empty */
-		LST_Delete(pDRVObject->devNodeString);
+		MEM_Free(pDRVObject->devNodeString);
 	}
 	MEM_FreeObject(pDRVObject);
 	/* Update the DRV Object in Registry to be 0 */
@@ -1037,7 +1043,7 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
 	}
 	/* Remove list if empty. */
 	if (LST_IsEmpty(pDRVObject->devList)) {
-		LST_Delete(pDRVObject->devList);
+		MEM_Free(pDRVObject->devList);
 		pDRVObject->devList = NULL;
 	}
 	DBC_Ensure((pDRVObject->devList == NULL) ||
@@ -1155,7 +1161,7 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 		}
 		/* Delete the List if it is empty */
 		if (LST_IsEmpty(pDRVObject->devNodeString)) {
-			LST_Delete(pDRVObject->devNodeString);
+			MEM_Free(pDRVObject->devNodeString);
 			pDRVObject->devNodeString = NULL;
 		}
 	}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 3bf14c9..f11f110 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1489,7 +1489,8 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 	MEM_AllocObject(pNodeMgr, struct NODE_MGR, NODEMGR_SIGNATURE);
 	if (pNodeMgr) {
 		pNodeMgr->hDevObject = hDevObject;
-		pNodeMgr->nodeList = LST_Create();
+		pNodeMgr->nodeList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		pNodeMgr->pipeMap = GB_create(MAXPIPES);
 		pNodeMgr->pipeDoneMap = GB_create(MAXPIPES);
 		if (pNodeMgr->nodeList == NULL || pNodeMgr->pipeMap == NULL ||
@@ -1499,6 +1500,7 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 				 "NODE_CreateMgr: Memory "
 				 "allocation failed\n");
 		} else {
+			INIT_LIST_HEAD(&pNodeMgr->nodeList->head);
 			status = NTFY_Create(&pNodeMgr->hNtfy);
 		}
 		pNodeMgr->uNumCreated = 0;
@@ -2959,7 +2961,7 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 					DeleteNode(hNode, NULL);
 
 			DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
-			LST_Delete(hNodeMgr->nodeList);
+			MEM_Free(hNodeMgr->nodeList);
 		}
 		if (hNodeMgr->hNtfy)
 			NTFY_Delete(hNodeMgr->hNtfy);
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index f048728..9e24e6a 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -268,11 +268,14 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 func_cont:
 	/* Initialize overlay memory list */
 	if (DSP_SUCCEEDED(status)) {
-		target->ovlyList = LST_Create();
+		target->ovlyList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		if (target->ovlyList == NULL) {
 			GT_0trace(RMM_debugMask, GT_6CLASS,
 				 "RMM_create: Memory allocation failed\n");
 			status = DSP_EMEMORY;
+		} else {
+			INIT_LIST_HEAD(&target->ovlyList->head);
 		}
 	}
 
@@ -315,7 +318,7 @@ void RMM_delete(struct RMM_TargetObj *target)
 			MEM_Free(pSect);
 		}
 		DBC_Assert(LST_IsEmpty(target->ovlyList));
-		LST_Delete(target->ovlyList);
+		MEM_Free(target->ovlyList);
 	}
 
 	if (target->freeList != NULL) {
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 5182bfa..5c7219f 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -117,12 +117,14 @@ DSP_STATUS NTFY_Create(struct NTFY_OBJECT **phNtfy)
 
 		status = SYNC_InitializeDPCCS(&pNtfy->hSync);
 		if (DSP_SUCCEEDED(status)) {
-			pNtfy->notifyList = LST_Create();
+			pNtfy->notifyList = MEM_Calloc(sizeof(struct LST_LIST),
+				MEM_NONPAGED);
 			if (pNtfy->notifyList == NULL) {
 				(void) SYNC_DeleteCS(pNtfy->hSync);
 				MEM_FreeObject(pNtfy);
 				status = DSP_EMEMORY;
 			} else {
+				INIT_LIST_HEAD(&pNtfy->notifyList->head);
 				*phNtfy = pNtfy;
 			}
 		}
@@ -155,7 +157,7 @@ void NTFY_Delete(struct NTFY_OBJECT *hNtfy)
 			DeleteNotify(pNotify);
 		}
 		DBC_Assert(LST_IsEmpty(hNtfy->notifyList));
-		LST_Delete(hNtfy->notifyList);
+		MEM_Free(hNtfy->notifyList);
 	}
 	if (hNtfy->hSync)
 		(void)SYNC_DeleteCS(hNtfy->hSync);
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 9007e13..11463cd 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -1024,9 +1024,10 @@ static struct LST_LIST *CreateChirpList(u32 uChirps)
 	struct CHNL_IRP *pChirp;
 	u32 i;
 
-	pChirpList = LST_Create();
+	pChirpList = MEM_Calloc(sizeof(struct LST_LIST), MEM_NONPAGED);
 
 	if (pChirpList) {
+		INIT_LIST_HEAD(&pChirpList->head);
 		/* Make N chirps and place on queue. */
 		for (i = 0; (i < uChirps) && ((pChirp = MakeNewChirp()) !=
 		    NULL); i++) {
@@ -1055,7 +1056,7 @@ static void FreeChirpList(struct LST_LIST *pChirpList)
 	while (!LST_IsEmpty(pChirpList))
 		MEM_Free(LST_GetHead(pChirpList));
 
-	LST_Delete(pChirpList);
+	MEM_Free(pChirpList);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 333a41a..6e2d388 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -103,16 +103,24 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 		pMsgMgr->onExit = msgCallback;
 		pMsgMgr->hIOMgr = hIOMgr;
 		/* List of MSG_QUEUEs */
-		pMsgMgr->queueList = LST_Create();
+		pMsgMgr->queueList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		 /*  Queues of message frames for messages to the DSP. Message
 		  * frames will only be added to the free queue when a
 		  * MSG_QUEUE object is created.  */
-		pMsgMgr->msgFreeList = LST_Create();
-		pMsgMgr->msgUsedList = LST_Create();
+		pMsgMgr->msgFreeList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
+		pMsgMgr->msgUsedList = MEM_Calloc(sizeof(struct LST_LIST),
+			MEM_NONPAGED);
 		if (pMsgMgr->queueList == NULL ||
 		    pMsgMgr->msgFreeList == NULL ||
 		    pMsgMgr->msgUsedList == NULL)
 			status = DSP_EMEMORY;
+		else {
+			INIT_LIST_HEAD(&pMsgMgr->queueList->head);
+			INIT_LIST_HEAD(&pMsgMgr->msgFreeList->head);
+			INIT_LIST_HEAD(&pMsgMgr->msgUsedList->head);
+		}
 		if (DSP_SUCCEEDED(status))
 			status = SYNC_InitializeDPCCS(&pMsgMgr->hSyncCS);
 
@@ -166,10 +174,14 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
 	pMsgQ->hArg = hArg;	/* Node handle */
 	pMsgQ->dwId = dwId;	/* Node env (not valid yet) */
 	/* Queues of Message frames for messages from the DSP */
-	pMsgQ->msgFreeList = LST_Create();
-	pMsgQ->msgUsedList = LST_Create();
+	pMsgQ->msgFreeList = MEM_Calloc(sizeof(struct LST_LIST), MEM_NONPAGED);
+	pMsgQ->msgUsedList = MEM_Calloc(sizeof(struct LST_LIST), MEM_NONPAGED);
 	if (pMsgQ->msgFreeList == NULL || pMsgQ->msgUsedList == NULL)
 		status = DSP_EMEMORY;
+	else {
+		INIT_LIST_HEAD(&pMsgQ->msgFreeList->head);
+		INIT_LIST_HEAD(&pMsgQ->msgUsedList->head);
+	}
 
 	 /*  Create event that will be signalled when a message from
 	 *  the DSP is available.  */
@@ -564,7 +576,7 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 
 	if (hMsgMgr->queueList) {
                if (LST_IsEmpty(hMsgMgr->queueList)) {
-                       LST_Delete(hMsgMgr->queueList);
+			MEM_Free(hMsgMgr->queueList);
                        hMsgMgr->queueList = NULL;
                }
 	}
@@ -662,7 +674,7 @@ static void FreeMsgList(struct LST_LIST *msgList)
 
 	DBC_Assert(LST_IsEmpty(msgList));
 
-	LST_Delete(msgList);
+	MEM_Free(msgList);
 func_end:
        return;
 }
-- 
1.5.6.5

