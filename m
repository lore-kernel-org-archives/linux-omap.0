From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/4] dspbridge: Don't use LST_Create() and LST_Delete()
Date: Fri, 22 Jan 2010 21:23:14 -0600
Message-ID: <1264216995-7863-3-git-send-email-omar.ramirez@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com>
 <1264216995-7863-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab0AWDMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 22:12:53 -0500
In-Reply-To: <1264216995-7863-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Change LST_Create() to the MEM_Calloc() and INIT_LIST_HEAD() pair in optimal way.

Use MEM_Free() instead of LST_Delete(). We can use it without checking because
MEM_Free() validates input parameter.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   63 ---------------------------
 drivers/dsp/bridge/pmgr/cmm.c               |   27 +++++++----
 drivers/dsp/bridge/pmgr/dev.c               |    9 +++-
 drivers/dsp/bridge/rmgr/drv.c               |   18 +++++---
 drivers/dsp/bridge/rmgr/node.c              |    6 ++-
 drivers/dsp/bridge/rmgr/rmm.c               |    7 ++-
 drivers/dsp/bridge/services/ntfy.c          |    6 ++-
 drivers/dsp/bridge/wmd/chnl_sm.c            |    5 +-
 drivers/dsp/bridge/wmd/msg_sm.c             |   29 ++++++++----
 9 files changed, 71 insertions(+), 99 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index 2cdc4e4..2c2e8a8 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -21,9 +21,6 @@
 #define LIST_
 
 #include <dspbridge/host_os.h>
-
-/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
-#include <dspbridge/mem.h>
 #include <linux/list.h>
 
 #define LST_IsEmpty(l)      list_empty(&(l)->head)
@@ -33,66 +30,6 @@ struct LST_LIST {
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
index f0efc89..225e5fd 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -296,12 +296,15 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
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
+					  "CMM_Create: Out of memory\n");
 				status = DSP_EMEMORY;
+			} else {
+				INIT_LIST_HEAD(&pCmmObject->pNodeFreeListHead->
+					head);
 			}
 		}
 		if (DSP_SUCCEEDED(status))
@@ -370,7 +373,7 @@ DSP_STATUS CMM_Destroy(struct CMM_OBJECT *hCmmMgr, bool bForce)
 			MEM_Free(pNode);
 		}
 		/* delete NodeFreeList list */
-		LST_Delete(pCmmMgr->pNodeFreeListHead);
+		MEM_Free(pCmmMgr->pNodeFreeListHead);
 	}
 	SYNC_LeaveCS(pCmmMgr->hCmmLock);
 	if (DSP_SUCCEEDED(status)) {
@@ -635,25 +638,29 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
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
+					  "Out Of Memory 1\n");
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
+					  "Out of memory 2\n");
 				status = DSP_EMEMORY;
 				goto func_end;
 			}
+			INIT_LIST_HEAD(&pSMA->pInUseListHead->head);
 		}
 		if (DSP_SUCCEEDED(status)) {
 			/* Get a mem node for this hunk-o-memory */
@@ -763,7 +770,7 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		LST_Delete(pSMA->pFreeListHead);	/* delete freelist */
+		MEM_Free(pSMA->pFreeListHead);		/* delete freelist */
 		/* free nodes on InUse list */
 		pCurNode = (struct CMM_MNODE *)LST_First(pSMA->pInUseListHead);
 		while (pCurNode) {
@@ -776,7 +783,7 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		LST_Delete(pSMA->pInUseListHead);	/* delete InUse list */
+		MEM_Free(pSMA->pInUseListHead);		/* delete InUse list */
 	}
 	if ((void *) pSMA->dwVmBase != NULL)
 		MEM_UnmapLinearAddress((void *) pSMA->dwVmBase);
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 3decf32..2b2d669 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -277,11 +277,14 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
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
@@ -293,7 +296,7 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 			 "0x%x\n", pDevObject);
 	} else {
 		if (pDevObject && pDevObject->procList)
-			LST_Delete(pDevObject->procList);
+			MEM_Free(pDevObject->procList);
 
 		if (pDevObject && pDevObject->hCodMgr)
 			COD_Delete(pDevObject->hCodMgr);
@@ -449,7 +452,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 			status = DSP_EFAIL;
 		if (DSP_SUCCEEDED(status)) {
 			if (pDevObject->procList) {
-				LST_Delete(pDevObject->procList);
+				MEM_Free(pDevObject->procList);
 				pDevObject->procList = NULL;
 			}
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 17f8b1c..c69e3af 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -606,15 +606,21 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
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
 			status = DSP_EMEMORY;
@@ -689,11 +695,11 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
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
@@ -933,7 +939,7 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
 	}
 	/* Remove list if empty. */
 	if (LST_IsEmpty(pDRVObject->devList)) {
-		LST_Delete(pDRVObject->devList);
+		MEM_Free(pDRVObject->devList);
 		pDRVObject->devList = NULL;
 	}
 	DBC_Ensure((pDRVObject->devList == NULL) ||
@@ -1054,7 +1060,7 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 		}
 		/* Delete the List if it is empty */
 		if (LST_IsEmpty(pDRVObject->devNodeString)) {
-			LST_Delete(pDRVObject->devNodeString);
+			MEM_Free(pDRVObject->devNodeString);
 			pDRVObject->devNodeString = NULL;
 		}
 	}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 016c788..5cbe161 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1380,7 +1380,8 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 	MEM_AllocObject(pNodeMgr, struct NODE_MGR, NODEMGR_SIGNATURE);
 	if (pNodeMgr) {
 		pNodeMgr->hDevObject = hDevObject;
-		pNodeMgr->nodeList = LST_Create();
+		pNodeMgr->nodeList = MEM_Calloc(sizeof(struct LST_LIST),
+						MEM_NONPAGED);
 		pNodeMgr->pipeMap = GB_create(MAXPIPES);
 		pNodeMgr->pipeDoneMap = GB_create(MAXPIPES);
 		if (pNodeMgr->nodeList == NULL || pNodeMgr->pipeMap == NULL ||
@@ -1390,6 +1391,7 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 				 "NODE_CreateMgr: Memory "
 				 "allocation failed\n");
 		} else {
+			INIT_LIST_HEAD(&pNodeMgr->nodeList->head);
 			status = NTFY_Create(&pNodeMgr->hNtfy);
 		}
 		pNodeMgr->uNumCreated = 0;
@@ -2841,7 +2843,7 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 					DeleteNode(hNode, NULL);
 
 			DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
-			LST_Delete(hNodeMgr->nodeList);
+			MEM_Free(hNodeMgr->nodeList);
 		}
 		if (hNodeMgr->hNtfy)
 			NTFY_Delete(hNodeMgr->hNtfy);
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index acdd124..cdd987a 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -254,11 +254,14 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
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
 
@@ -301,7 +304,7 @@ void RMM_delete(struct RMM_TargetObj *target)
 			MEM_Free(pSect);
 		}
 		DBC_Assert(LST_IsEmpty(target->ovlyList));
-		LST_Delete(target->ovlyList);
+		MEM_Free(target->ovlyList);
 	}
 
 	if (target->freeList != NULL) {
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 42ebb0f..539cbae 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -93,12 +93,14 @@ DSP_STATUS NTFY_Create(struct NTFY_OBJECT **phNtfy)
 
 		status = SYNC_InitializeDPCCS(&pNtfy->hSync);
 		if (DSP_SUCCEEDED(status)) {
-			pNtfy->notifyList = LST_Create();
+			pNtfy->notifyList = MEM_Calloc(sizeof(struct LST_LIST),
+							MEM_NONPAGED);
 			if (pNtfy->notifyList == NULL) {
 				(void) SYNC_DeleteCS(pNtfy->hSync);
 				MEM_FreeObject(pNtfy);
 				status = DSP_EMEMORY;
 			} else {
+				INIT_LIST_HEAD(&pNtfy->notifyList->head);
 				*phNtfy = pNtfy;
 			}
 		}
@@ -131,7 +133,7 @@ void NTFY_Delete(struct NTFY_OBJECT *hNtfy)
 			DeleteNotify(pNotify);
 		}
 		DBC_Assert(LST_IsEmpty(hNtfy->notifyList));
-		LST_Delete(hNtfy->notifyList);
+		MEM_Free(hNtfy->notifyList);
 	}
 	if (hNtfy->hSync)
 		(void)SYNC_DeleteCS(hNtfy->hSync);
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 00ed088..99c876d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -942,9 +942,10 @@ static struct LST_LIST *CreateChirpList(u32 uChirps)
 	struct CHNL_IRP *pChirp;
 	u32 i;
 
-	pChirpList = LST_Create();
+	pChirpList = MEM_Calloc(sizeof(struct LST_LIST), MEM_NONPAGED);
 
 	if (pChirpList) {
+		INIT_LIST_HEAD(&pChirpList->head);
 		/* Make N chirps and place on queue. */
 		for (i = 0; (i < uChirps) && ((pChirp = MakeNewChirp()) !=
 		    NULL); i++) {
@@ -973,7 +974,7 @@ static void FreeChirpList(struct LST_LIST *pChirpList)
 	while (!LST_IsEmpty(pChirpList))
 		MEM_Free(LST_GetHead(pChirpList));
 
-	LST_Delete(pChirpList);
+	MEM_Free(pChirpList);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index d8d2257..50201e5 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -77,18 +77,25 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
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
+					MEM_NONPAGED);
+		pMsgMgr->msgUsedList = MEM_Calloc(sizeof(struct LST_LIST),
+					MEM_NONPAGED);
 		if (pMsgMgr->queueList == NULL ||
 		    pMsgMgr->msgFreeList == NULL ||
-		    pMsgMgr->msgUsedList == NULL)
+		    pMsgMgr->msgUsedList == NULL) {
 			status = DSP_EMEMORY;
-		else
+		} else {
+			INIT_LIST_HEAD(&pMsgMgr->queueList->head);
+			INIT_LIST_HEAD(&pMsgMgr->msgFreeList->head);
+			INIT_LIST_HEAD(&pMsgMgr->msgUsedList->head);
 			status = SYNC_InitializeDPCCS(&pMsgMgr->hSyncCS);
+		}
 
 		 /*  Create an event to be used by WMD_MSG_Put() in waiting
 		 *  for an available free frame from the message manager.  */
@@ -140,10 +147,14 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
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
@@ -548,7 +559,7 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 
 	if (hMsgMgr->queueList) {
 		if (LST_IsEmpty(hMsgMgr->queueList)) {
-			LST_Delete(hMsgMgr->queueList);
+			MEM_Free(hMsgMgr->queueList);
 			hMsgMgr->queueList = NULL;
 		}
 	}
@@ -646,7 +657,7 @@ static void FreeMsgList(struct LST_LIST *msgList)
 
 	DBC_Assert(LST_IsEmpty(msgList));
 
-	LST_Delete(msgList);
+	MEM_Free(msgList);
 func_end:
 	return;
 }
-- 
1.6.2.4

