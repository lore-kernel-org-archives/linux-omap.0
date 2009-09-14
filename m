From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv3 2/3] dspbridge: Change LST_ELEM to list_head entirely
Date: Mon, 14 Sep 2009 18:59:40 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A6121F1E@dlee06.ent.ti.com>
References: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
 <1252411936-25722-2-git-send-email-andy.shevchenko@gmail.com>
 <1252411936-25722-3-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42541 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZINX7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 19:59:41 -0400
In-Reply-To: <1252411936-25722-3-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>



Hi,

        It looks good for me,

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Tuesday, September 08, 2009 7:12 AM
>To: linux-omap@vger.kernel.org
>Cc: hiroshi.doyu@nokia.com; Andy Shevchenko
>Subject: [PATCHv3 2/3] dspbridge: Change LST_ELEM to list_head entirely
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>* Change struct LST_ELEM to struct list_head in whole dsp bridge driver
>* Remove useless commentaries
>* Minor change in the services/mem.c:
>  ...
>    struct list_head *last = &mMan.lst.head;
>    struct list_head *curr = last->next; /* was: mMan.lst.head.next */
>  ...
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
> arch/arm/plat-omap/include/dspbridge/list.h     |    1 -
> arch/arm/plat-omap/include/dspbridge/proc.h     |    2 +-
> drivers/dsp/bridge/pmgr/cmm.c                   |   55 +++++++++++--------
>----
> drivers/dsp/bridge/pmgr/dev.c                   |    8 ++--
> drivers/dsp/bridge/rmgr/drv.c                   |   14 +++---
> drivers/dsp/bridge/rmgr/node.c                  |   10 ++--
> drivers/dsp/bridge/rmgr/rmm.c                   |   16 +++---
> drivers/dsp/bridge/services/cfg.c               |    2 +-
> drivers/dsp/bridge/services/mem.c               |   26 +++++-----
> drivers/dsp/bridge/services/ntfy.c              |   12 +++---
> drivers/dsp/bridge/wmd/_msg_sm.h                |    4 +-
> drivers/dsp/bridge/wmd/chnl_sm.c                |   12 +++---
> drivers/dsp/bridge/wmd/io_sm.c                  |   10 ++--
> drivers/dsp/bridge/wmd/msg_sm.c                 |   21 ++++-----
> 15 files changed, 96 insertions(+), 99 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
>b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
>index 28af799..cc768c9 100644
>--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
>+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
>@@ -197,7 +197,7 @@ struct loadMonStruct {
>
> /* I/O Request/completion packet: */
>       struct CHNL_IRP {
>-              struct LST_ELEM link;   /* Link to next CHIRP in queue. */
>+              struct list_head link;  /* Link to next CHIRP in queue.  */
>               /* Buffer to be filled/emptied. (User)   */
>               u8 *pHostUserBuf;
>               /* Buffer to be filled/emptied. (System) */
>diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-
>omap/include/dspbridge/list.h
>index 414579f..f382b20 100644
>--- a/arch/arm/plat-omap/include/dspbridge/list.h
>+++ b/arch/arm/plat-omap/include/dspbridge/list.h
>@@ -53,7 +53,6 @@
> #include <dspbridge/mem.h>
> #include <linux/list.h>
>
>-#define LST_ELEM            list_head
> #define LST_IsEmpty(l)      list_empty(&(l)->head)
>
> struct LST_LIST {
>diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-
>omap/include/dspbridge/proc.h
>index d4896d5..eaf36a6 100644
>--- a/arch/arm/plat-omap/include/dspbridge/proc.h
>+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
>@@ -68,7 +68,7 @@
>
> /* The PROC_OBJECT structure.   */
> struct PROC_OBJECT {
>-      struct LST_ELEM link;           /* Link to next PROC_OBJECT */
>+      struct list_head link;          /* Link to next PROC_OBJECT */
>       u32 dwSignature;                /* Used for object validation */
>       struct DEV_OBJECT *hDevObject;  /* Device this PROC represents */
>       u32 hProcess;                   /* Process owning this Processor */
>diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
>index 9b19be2..571aa12 100644
>--- a/drivers/dsp/bridge/pmgr/cmm.c
>+++ b/drivers/dsp/bridge/pmgr/cmm.c
>@@ -199,7 +199,7 @@ static struct CMM_XLATORATTRS CMM_DFLTXLATORATTRS = {
>
> /* SM node representing a block of memory. */
> struct CMM_MNODE {
>-      struct LST_ELEM link;           /* must be 1st element */
>+      struct list_head link;          /* must be 1st element */
>       u32 dwPA;               /* Phys addr */
>       u32 dwVA;               /* Virtual address in device process context */
>       u32 ulSize;             /* SM block size in bytes */
>@@ -289,7 +289,7 @@ void *CMM_CallocBuf(struct CMM_OBJECT *hCmmMgr, u32
>uSize,
>
>                       /* put our node on InUse list */
>                       LST_PutTail(pAllocator->pInUseListHead,
>-                                 (struct LST_ELEM *)pNode);
>+                                 (struct list_head *)pNode);
>                       pBufPA = (void *)pNode->dwPA;   /* physical address */
>                       /* clear mem */
>                       pByte = (u8 *)pNode->dwVA;
>@@ -428,8 +428,6 @@ DSP_STATUS CMM_Destroy(struct CMM_OBJECT *hCmmMgr, bool
>bForce)
>       if (pCmmMgr->pNodeFreeListHead != NULL) {
>               /* Free the free nodes */
>               while (!LST_IsEmpty(pCmmMgr->pNodeFreeListHead)) {
>-                      /* (struct LST_ELEM*) pNode =
>-                       * LST_GetHead(pCmmMgr->pNodeFreeListHead);*/
>                       pNode = (struct CMM_MNODE *)LST_GetHead(pCmmMgr->
>                                pNodeFreeListHead);
>                       MEM_Free(pNode);
>@@ -496,7 +494,7 @@ DSP_STATUS CMM_FreeBuf(struct CMM_OBJECT *hCmmMgr, void
>*pBufPA, u32 ulSegId)
>                       if ((u32)pBufPA == pCurNode->dwPA) {
>                               /* Found it */
>                               LST_RemoveElem(pAllocator->pInUseListHead,
>-                                            (struct LST_ELEM *)pCurNode);
>+                                            (struct list_head *)pCurNode);
>                               /* back to freelist */
>                               AddToFreeList(pAllocator, pCurNode);
>                               status = DSP_SOK;       /* all right! */
>@@ -504,7 +502,8 @@ DSP_STATUS CMM_FreeBuf(struct CMM_OBJECT *hCmmMgr, void
>*pBufPA, u32 ulSegId)
>                       }
>                       /* next node. */
>                       pCurNode = (struct CMM_MNODE *)LST_Next(pAllocator->
>-                                 pInUseListHead, (struct LST_ELEM *)pCurNode);
>+                                      pInUseListHead,
>+                                      (struct list_head *)pCurNode);
>               }
>               SYNC_LeaveCS(pCmmMgr->hCmmLock);
>       }
>@@ -590,7 +589,7 @@ DSP_STATUS CMM_GetInfo(struct CMM_OBJECT *hCmmMgr,
>                               /* next node. */
>                               pCurNode = (struct CMM_MNODE *)LST_Next(pAltr->
>                                       pInUseListHead,
>-                                      (struct LST_ELEM *)pCurNode);
>+                                      (struct list_head *)pCurNode);
>                       }
>               }
>       }               /* end for */
>@@ -726,7 +725,7 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT
>*hCmmMgr, u32 dwGPPBasePA,
>                       /* Place node on the SM allocator's free list */
>                       if (pNewNode) {
>                               LST_PutTail(pSMA->pFreeListHead,
>-                                         (struct LST_ELEM *)pNewNode);
>+                                         (struct list_head *)pNewNode);
>                       } else {
>                               status = DSP_EMEMORY;
>                               goto func_end;
>@@ -820,9 +819,9 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR
>*pSMA)
>               while (pCurNode) {
>                       pNextNode = (struct CMM_MNODE *)LST_Next(pSMA->
>                                    pFreeListHead,
>-                                  (struct LST_ELEM *)pCurNode);
>+                                  (struct list_head *)pCurNode);
>                       LST_RemoveElem(pSMA->pFreeListHead,
>-                                    (struct LST_ELEM *)pCurNode);
>+                                    (struct list_head *)pCurNode);
>                       MEM_Free((void *) pCurNode);
>                       /* next node. */
>                       pCurNode = pNextNode;
>@@ -833,9 +832,9 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR
>*pSMA)
>               while (pCurNode) {
>                       pNextNode = (struct CMM_MNODE *)LST_Next(pSMA->
>                                   pInUseListHead,
>-                                  (struct LST_ELEM *)pCurNode);
>+                                  (struct list_head *)pCurNode);
>                       LST_RemoveElem(pSMA->pInUseListHead,
>-                                    (struct LST_ELEM *)pCurNode);
>+                                    (struct list_head *)pCurNode);
>                       MEM_Free((void *) pCurNode);
>                       /* next node. */
>                       pCurNode = pNextNode;
>@@ -893,17 +892,15 @@ static struct CMM_MNODE *GetNode(struct CMM_OBJECT
>*pCmmMgr, u32 dwPA,
>                       MEM_PAGED);
>       } else {
>               /* surely a valid element */
>-              /* (struct LST_ELEM*) pNode = LST_GetHead(pCmmMgr->
>-               * pNodeFreeListHead);*/
>               pNode = (struct CMM_MNODE *)LST_GetHead(pCmmMgr->
>                       pNodeFreeListHead);
>       }
>       if (pNode == NULL) {
>               GT_0trace(CMM_debugMask, GT_7CLASS, "GetNode: Out Of
>Memory\n");
>       } else {
>-              LST_InitElem((struct LST_ELEM *) pNode);        /* set self */
>-              pNode->dwPA = dwPA;     /* Physical addr of start of block */
>-              pNode->dwVA = dwVA;     /* Virtual   "            "        */
>+              LST_InitElem((struct list_head *)pNode);        /* set self */
>+              pNode->dwPA = dwPA;     /* Physical addr of start of block  */
>+              pNode->dwVA = dwVA;     /* Virtual   "            "         */
>               pNode->ulSize = ulSize; /* Size of block */
>       }
>       return pNode;
>@@ -918,8 +915,8 @@ static struct CMM_MNODE *GetNode(struct CMM_OBJECT
>*pCmmMgr, u32 dwPA,
> static void DeleteNode(struct CMM_OBJECT *pCmmMgr, struct CMM_MNODE
>*pNode)
> {
>       DBC_Require(pNode != NULL);
>-      LST_InitElem((struct LST_ELEM *) pNode);        /* init .self ptr */
>-      LST_PutTail(pCmmMgr->pNodeFreeListHead, (struct LST_ELEM *) pNode);
>+      LST_InitElem((struct list_head *)pNode);        /* init .self ptr */
>+      LST_PutTail(pCmmMgr->pNodeFreeListHead, (struct list_head *)pNode);
> }
>
> /*
>@@ -937,12 +934,13 @@ static struct CMM_MNODE *GetFreeBlock(struct
>CMM_ALLOCATOR *pAllocator,
>               while (pCurNode) {
>                       if (uSize <= (u32) pCurNode->ulSize) {
>                               LST_RemoveElem(pAllocator->pFreeListHead,
>-                                            (struct LST_ELEM *)pCurNode);
>+                                            (struct list_head *)pCurNode);
>                               return pCurNode;
>                       }
>                       /* next node. */
>                       pCurNode = (struct CMM_MNODE *)LST_Next(pAllocator->
>-                                  pFreeListHead, (struct LST_ELEM *)pCurNode);
>+                                      pFreeListHead,
>+                                      (struct list_head *)pCurNode);
>               }
>       }
>       return NULL;
>@@ -977,7 +975,8 @@ static void AddToFreeList(struct CMM_ALLOCATOR
>*pAllocator,
>               if ((pNodePrev == NULL) || (pNodeNext == NULL)) {
>                       /* next node. */
>                       pCurNode = (struct CMM_MNODE *)LST_Next(pAllocator->
>-                                  pFreeListHead, (struct LST_ELEM *)pCurNode);
>+                                      pFreeListHead,
>+                                      (struct list_head *)pCurNode);
>               } else {
>                       /* got 'em */
>                       break;
>@@ -986,7 +985,7 @@ static void AddToFreeList(struct CMM_ALLOCATOR
>*pAllocator,
>       if (pNodePrev != NULL) {
>               /* combine with previous block */
>               LST_RemoveElem(pAllocator->pFreeListHead,
>-                            (struct LST_ELEM *)pNodePrev);
>+                            (struct list_head *)pNodePrev);
>               /* grow node to hold both */
>               pNode->ulSize += pNodePrev->ulSize;
>               pNode->dwPA = pNodePrev->dwPA;
>@@ -997,7 +996,7 @@ static void AddToFreeList(struct CMM_ALLOCATOR
>*pAllocator,
>       if (pNodeNext != NULL) {
>               /* combine with next block */
>               LST_RemoveElem(pAllocator->pFreeListHead,
>-                            (struct LST_ELEM *)pNodeNext);
>+                            (struct list_head *)pNodeNext);
>               /* grow da node */
>               pNode->ulSize += pNodeNext->ulSize;
>               /* place node on mgr nodeFreeList */
>@@ -1011,17 +1010,17 @@ static void AddToFreeList(struct CMM_ALLOCATOR
>*pAllocator,
>
>               /* next node. */
>               pCurNode = (struct CMM_MNODE *)LST_Next(pAllocator->
>-                         pFreeListHead, (struct LST_ELEM *)pCurNode);
>+                         pFreeListHead, (struct list_head *)pCurNode);
>       }
>       /* if pCurNode is NULL then add our pNode to the end of the freelist
>*/
>       if (pCurNode == NULL) {
>               LST_PutTail(pAllocator->pFreeListHead,
>-                         (struct LST_ELEM *)pNode);
>+                         (struct list_head *)pNode);
>       } else {
>               /* insert our node before the current traversed node */
>               LST_InsertBefore(pAllocator->pFreeListHead,
>-                              (struct LST_ELEM *)pNode,
>-                              (struct LST_ELEM *)pCurNode);
>+                              (struct list_head *)pNode,
>+                              (struct list_head *)pCurNode);
>       }
> }
>
>diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
>index 206def0..8ba3a7f 100644
>--- a/drivers/dsp/bridge/pmgr/dev.c
>+++ b/drivers/dsp/bridge/pmgr/dev.c
>@@ -162,7 +162,7 @@
> /* The WMD device object: */
> struct DEV_OBJECT {
>       /* LST requires "link" to be first field!                        */
>-      struct LST_ELEM link;           /* Link to next DEV_OBJECT.      */
>+      struct list_head link;          /* Link to next DEV_OBJECT.      */
>       u32 devType;            /* Device Type */
>       u32 dwSignature;        /* Used for object validation.   */
>       struct CFG_DEVNODE *hDevNode;   /* Platform specific device id   */
>@@ -1045,7 +1045,7 @@ DSP_STATUS DEV_NotifyClients(struct DEV_OBJECT
>*hDevObject, u32 ulStatus)
>       for (hProcObject = (DSP_HPROCESSOR)LST_First(pDevObject->procList);
>               hProcObject != NULL;
>               hProcObject = (DSP_HPROCESSOR)LST_Next(pDevObject->procList,
>-                                              (struct LST_ELEM *)hProcObject))
>+                                      (struct list_head *)hProcObject))
>               PROC_NotifyClients(hProcObject, (u32) ulStatus);
>
>       return status;
>@@ -1302,7 +1302,7 @@ DSP_STATUS DEV_InsertProcObject(struct DEV_OBJECT
>*hDevObject,
>               *pbAlreadyAttached = true;
>
>       /* Add DevObject to tail. */
>-      LST_PutTail(pDevObject->procList, (struct LST_ELEM *)hProcObject);
>+      LST_PutTail(pDevObject->procList, (struct list_head *)hProcObject);
>
>       GT_1trace(debugMask, GT_ENTER,
>                "Exiting DEV_InsetProcObject status 0x%x\n", status);
>@@ -1333,7 +1333,7 @@ DSP_STATUS DEV_RemoveProcObject(struct DEV_OBJECT
>*hDevObject,
>                                    u32 hProcObject)
> {
>       DSP_STATUS status = DSP_EFAIL;
>-      struct LST_ELEM *pCurElem;
>+      struct list_head *pCurElem;
>       struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)hDevObject;
>
>       DBC_Require(IsValidHandle(pDevObject));
>diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
>index 6a264ed..ca774c9 100644
>--- a/drivers/dsp/bridge/rmgr/drv.c
>+++ b/drivers/dsp/bridge/rmgr/drv.c
>@@ -139,7 +139,7 @@ struct DRV_OBJECT {
>  *  DRV_ since it is living in this module
>  */
> struct DRV_EXT {
>-      struct LST_ELEM link;
>+      struct list_head link;
>       char szString[MAXREGPATHLENGTH];
> };
>
>@@ -916,7 +916,7 @@ u32 DRV_GetNextDevObject(u32 hDevObject)
>               if ((pDrvObject->devList != NULL) &&
>                  !LST_IsEmpty(pDrvObject->devList)) {
>                       dwNextDevObject = (u32)LST_Next(pDrvObject->devList,
>-                                        (struct LST_ELEM *)hDevObject);
>+                                        (struct list_head *)hDevObject);
>               }
>       }
>       return dwNextDevObject;
>@@ -943,7 +943,7 @@ u32 DRV_GetNextDevExtension(u32 hDevExtension)
>                  !LST_IsEmpty(pDrvObject->devNodeString)) {
>                       dwDevExtension = (u32)LST_Next(pDrvObject->
>                               devNodeString,
>-                              (struct LST_ELEM *)hDevExtension);
>+                              (struct list_head *)hDevExtension);
>               }
>       }
>
>@@ -992,7 +992,7 @@ DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT
>*hDRVObject,
>                "Entering DRV_InsertProcObject hDRVObject "
>                "0x%x\n, hDevObject 0x%x\n", hDRVObject, hDevObject);
>
>-      LST_PutTail(pDRVObject->devList, (struct LST_ELEM *)hDevObject);
>+      LST_PutTail(pDRVObject->devList, (struct list_head *)hDevObject);
>
>       GT_1trace(curTrace, GT_ENTER,
>                "Exiting InsertDevObject status 0x%x\n", status);
>@@ -1013,7 +1013,7 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT
>*hDRVObject,
> {
>       DSP_STATUS status = DSP_EFAIL;
>       struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDRVObject;
>-      struct LST_ELEM *pCurElem;
>+      struct list_head *pCurElem;
>
>       DBC_Require(cRefs > 0);
>       DBC_Require(MEM_IsValidHandle(pDRVObject, SIGNATURE));
>@@ -1077,7 +1077,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32
>*pDevNodeString)
>                       /* Update the Driver Object List */
>                       *pDevNodeString = (u32)pszdevNode->szString;
>                       LST_PutTail(pDRVObject->devNodeString,
>-                              (struct LST_ELEM *)pszdevNode);
>+                                 (struct list_head *)pszdevNode);
>               } else {
>                       GT_0trace(curTrace, GT_7CLASS,
>                               "Failed to Allocate Memory devNodeString ");
>@@ -1149,7 +1149,7 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct
>DRV_OBJECT *hDrvObject)
>                       /* Found it */
>                       /* Delete from the Driver object list */
>                       LST_RemoveElem(pDRVObject->devNodeString,
>-                                    (struct LST_ELEM *)pszdevNode);
>+                                    (struct list_head *)pszdevNode);
>                       MEM_Free((void *) pszdevNode);
>                       break;
>               }
>diff --git a/drivers/dsp/bridge/rmgr/node.c
>b/drivers/dsp/bridge/rmgr/node.c
>index e5233a0..3bf14c9 100644
>--- a/drivers/dsp/bridge/rmgr/node.c
>+++ b/drivers/dsp/bridge/rmgr/node.c
>@@ -268,7 +268,7 @@ struct STREAM {
>  *  ======== NODE_OBJECT ========
>  */
> struct NODE_OBJECT {
>-      struct LST_ELEM listElem;
>+      struct list_head listElem;
>       u32 dwSignature;        /* For object validation */
>       struct NODE_MGR *hNodeMgr;      /* The manager of this node */
>       struct PROC_OBJECT *hProcessor; /* Back pointer to processor */
>@@ -754,14 +754,14 @@ func_cont2:
>       if (DSP_SUCCEEDED(status)) {
>               /* Add the node to the node manager's list of allocated
>                * nodes. */
>-              LST_InitElem((struct LST_ELEM *)pNode);
>+              LST_InitElem((struct list_head *)pNode);
>               NODE_SetState(pNode, NODE_ALLOCATED);
>
>               status = SYNC_EnterCS(hNodeMgr->hSync);
>
>               if (DSP_SUCCEEDED(status)) {
>                       LST_PutTail(hNodeMgr->nodeList,
>-                      (struct LST_ELEM *) pNode);
>+                                 (struct list_head *)pNode);
>                       ++(hNodeMgr->uNumNodes);
>               }
>
>@@ -1743,7 +1743,7 @@ func_cont1:
>       }
>       /* Free host side resources even if a failure occurred */
>       /* Remove node from hNodeMgr->nodeList */
>-      LST_RemoveElem(hNodeMgr->nodeList, (struct LST_ELEM *) hNode);
>+      LST_RemoveElem(hNodeMgr->nodeList, (struct list_head *)hNode);
>       hNodeMgr->uNumNodes--;
>       /* Decrement count of nodes created on DSP */
>       if ((state != NODE_ALLOCATED) || ((state == NODE_ALLOCATED) &&
>@@ -1836,7 +1836,7 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr,
>IN DSP_HNODE *aNodeTab,
>                               aNodeTab[i] = hNode;
>                               hNode = (struct NODE_OBJECT *)LST_Next
>                                       (hNodeMgr->nodeList,
>-                                      (struct LST_ELEM *)hNode);
>+                                      (struct list_head *)hNode);
>                       }
>                       *puAllocated = *puNumNodes = hNodeMgr->uNumNodes;
>               }
>diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
>index 575f675..f048728 100644
>--- a/drivers/dsp/bridge/rmgr/rmm.c
>+++ b/drivers/dsp/bridge/rmgr/rmm.c
>@@ -84,7 +84,7 @@ struct RMM_Header {
>  *  Keeps track of memory occupied by overlay section.
>  */
> struct RMM_OvlySect {
>-      struct LST_ELEM listElem;
>+      struct list_head listElem;
>       u32 addr;               /* Start of memory section */
>       u32 size;               /* Length (target MAUs) of section */
>       s32 page;               /* Memory page */
>@@ -161,7 +161,7 @@ DSP_STATUS RMM_alloc(struct RMM_TargetObj *target, u32
>segid, u32 size,
>               }
>               prevSect = sect;
>               sect = (struct RMM_OvlySect *)LST_Next(target->ovlyList,
>-                      (struct LST_ELEM *)sect);
>+                      (struct list_head *)sect);
>       }
>       if (DSP_SUCCEEDED(status)) {
>               /* No overlap - allocate list element for new section. */
>@@ -169,19 +169,19 @@ DSP_STATUS RMM_alloc(struct RMM_TargetObj *target,
>u32 segid, u32 size,
>               if (newSect == NULL) {
>                       status = DSP_EMEMORY;
>               } else {
>-                      LST_InitElem((struct LST_ELEM *)newSect);
>+                      LST_InitElem((struct list_head *)newSect);
>                       newSect->addr = addr;
>                       newSect->size = size;
>                       newSect->page = segid;
>                       if (sect == NULL) {
>                               /* Put new section at the end of the list */
>                               LST_PutTail(target->ovlyList,
>-                                         (struct LST_ELEM *)newSect);
>+                                         (struct list_head *)newSect);
>                       } else {
>                               /* Put new section just before sect */
>                               LST_InsertBefore(target->ovlyList,
>-                                              (struct LST_ELEM *)newSect,
>-                                              (struct LST_ELEM *)sect);
>+                                              (struct list_head *)newSect,
>+                                              (struct list_head *)sect);
>                       }
>               }
>       }
>@@ -388,12 +388,12 @@ bool RMM_free(struct RMM_TargetObj *target, u32
>segid, u32 addr, u32 size,
>                               DBC_Assert(size == sect->size);
>                               /* Remove from list */
>                               LST_RemoveElem(target->ovlyList,
>-                                            (struct LST_ELEM *)sect);
>+                                            (struct list_head *)sect);
>                               MEM_Free(sect);
>                               break;
>                       }
>                       sect = (struct RMM_OvlySect *)LST_Next(target->ovlyList,
>-                             (struct LST_ELEM *)sect);
>+                             (struct list_head *)sect);
>               }
>               if (sect == NULL)
>                       retVal = false;
>diff --git a/drivers/dsp/bridge/services/cfg.c
>b/drivers/dsp/bridge/services/cfg.c
>index 67656bf..4a39ccb 100644
>--- a/drivers/dsp/bridge/services/cfg.c
>+++ b/drivers/dsp/bridge/services/cfg.c
>@@ -93,7 +93,7 @@
> #include <dspbridge/list.h>
>
> struct DRV_EXT {
>-      struct LST_ELEM link;
>+      struct list_head link;
>       char szString[MAXREGPATHLENGTH];
> };
>
>diff --git a/drivers/dsp/bridge/services/mem.c
>b/drivers/dsp/bridge/services/mem.c
>index ff507d6..64f8c30 100644
>--- a/drivers/dsp/bridge/services/mem.c
>+++ b/drivers/dsp/bridge/services/mem.c
>@@ -95,7 +95,7 @@ static struct extPhysMemPool extMemPool;
>
> /*  Information about each element allocated on heap */
> struct memInfo {
>-      struct LST_ELEM link;           /* Must be first */
>+      struct list_head link;          /* Must be first */
>       size_t size;
>       void *caller;
>       u32 dwSignature;        /* Should be last */
>@@ -119,7 +119,7 @@ static struct memMan mMan;
>  *  These functions are similar to LST_PutTail and LST_RemoveElem and are
>  *  duplicated here to make MEM independent of LST
>  */
>-static inline void MLST_PutTail(struct LST_LIST *pList, struct LST_ELEM
>*pElem)
>+static inline void MLST_PutTail(struct LST_LIST *pList, struct list_head
>*pElem)
> {
>       pElem->prev = pList->head.prev;
>       pElem->next = &pList->head;
>@@ -128,7 +128,7 @@ static inline void MLST_PutTail(struct LST_LIST *pList,
>struct LST_ELEM *pElem)
> }
>
> static inline void MLST_RemoveElem(struct LST_LIST *pList,
>-                                 struct LST_ELEM *pCurElem)
>+                                 struct list_head *pCurElem)
> {
>       pCurElem->prev->next = pCurElem->next;
>       pCurElem->next->prev = pCurElem->prev;
>@@ -139,8 +139,8 @@ static inline void MLST_RemoveElem(struct LST_LIST
>*pList,
> static void MEM_Check(void)
> {
>       struct memInfo *pMem;
>-      struct LST_ELEM *last = &mMan.lst.head;
>-      struct LST_ELEM *curr = mMan.lst.head.next;
>+      struct list_head *last = &mMan.lst.head;
>+      struct list_head *curr = last->next;
>
>       if (!LST_IsEmpty(&mMan.lst)) {
>               GT_0trace(MEM_debugMask, GT_7CLASS, "*** MEMORY LEAK ***\n");
>@@ -156,7 +156,7 @@ static void MEM_Check(void)
>                                       (u32) pMem + sizeof(struct memInfo),
>                                       pMem->size, pMem->caller);
>                               MLST_RemoveElem(&mMan.lst,
>-                                              (struct LST_ELEM *) pMem);
>+                                              (struct list_head *)pMem);
>                               kfree(pMem);
>                       } else {
>                               GT_1trace(MEM_debugMask, GT_7CLASS,
>@@ -292,7 +292,7 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
>
>                               spin_lock(&mMan.lock);
>                               MLST_PutTail(&mMan.lst,
>-                                          (struct LST_ELEM *)pMem);
>+                                          (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>
>                               pMem = (void *)((u32)pMem +
>@@ -312,7 +312,7 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
>
>                               spin_lock(&mMan.lock);
>                               MLST_PutTail(&mMan.lst,
>-                                          (struct LST_ELEM *) pMem);
>+                                          (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>
>                               pMem = (void *)((u32)pMem +
>@@ -402,7 +402,7 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
>                               pMem->dwSignature = memInfoSign;
>                               spin_lock(&mMan.lock);
>                               MLST_PutTail(&mMan.lst,
>-                                      (struct LST_ELEM *) pMem);
>+                                      (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>                               pMem = (void *)((u32)pMem +
>                                       sizeof(struct memInfo));
>@@ -423,8 +423,8 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
>                               pMem->caller = __builtin_return_address(0);
>                               pMem->dwSignature = memInfoSign;
>                               spin_lock(&mMan.lock);
>-                              MLST_PutTail(&mMan.lst, (struct LST_ELEM *)
>-                                      pMem);
>+                              MLST_PutTail(&mMan.lst,
>+                                          (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>                               pMem = (void *)((u32)pMem +
>                                       sizeof(struct memInfo));
>@@ -528,7 +528,7 @@ void MEM_VFree(IN void *pMemBuf)
>                       if (pMem->dwSignature == memInfoSign) {
>                               spin_lock(&mMan.lock);
>                               MLST_RemoveElem(&mMan.lst,
>-                                              (struct LST_ELEM *) pMem);
>+                                              (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>                               pMem->dwSignature = 0;
>                               vfree(pMem);
>@@ -567,7 +567,7 @@ void MEM_Free(IN void *pMemBuf)
>                       if (pMem->dwSignature == memInfoSign) {
>                               spin_lock(&mMan.lock);
>                               MLST_RemoveElem(&mMan.lst,
>-                                              (struct LST_ELEM *) pMem);
>+                                              (struct list_head *)pMem);
>                               spin_unlock(&mMan.lock);
>                               pMem->dwSignature = 0;
>                               kfree(pMem);
>diff --git a/drivers/dsp/bridge/services/ntfy.c
>b/drivers/dsp/bridge/services/ntfy.c
>index 2eff3eb..5182bfa 100644
>--- a/drivers/dsp/bridge/services/ntfy.c
>+++ b/drivers/dsp/bridge/services/ntfy.c
>@@ -77,7 +77,7 @@ struct NTFY_OBJECT {
>  *  This object will be created when a client registers for events.
>  */
> struct NOTIFICATION {
>-      struct LST_ELEM listElem;
>+      struct list_head listElem;
>       u32 uEventMask; /* Events to be notified about */
>       u32 uNotifyType;        /* Type of notification to be sent */
>
>@@ -216,7 +216,7 @@ void NTFY_Notify(struct NTFY_OBJECT *hNtfy, u32
>uEventMask)
>
>               }
>               pNotify = (struct NOTIFICATION *)LST_Next(hNtfy->notifyList,
>-                        (struct LST_ELEM *)pNotify);
>+                        (struct list_head *)pNotify);
>       }
>
>       (void) SYNC_LeaveCS(hNtfy->hSync);
>@@ -265,7 +265,7 @@ DSP_STATUS NTFY_Register(struct NTFY_OBJECT *hNtfy,
>                       break;
>               }
>               pNotify = (struct NOTIFICATION *)LST_Next(hNtfy->notifyList,
>-                        (struct LST_ELEM *)pNotify);
>+                        (struct list_head *)pNotify);
>       }
>       if (pNotify == NULL) {
>               /* Not registered */
>@@ -280,7 +280,7 @@ DSP_STATUS NTFY_Register(struct NTFY_OBJECT *hNtfy,
>
>               }
>               if (DSP_SUCCEEDED(status)) {
>-                      LST_InitElem((struct LST_ELEM *) pNotify);
>+                      LST_InitElem((struct list_head *)pNotify);
>                        /* If there is more than one notification type, each
>                        * type may require its own handler code. */
>                       status = SYNC_OpenEvent(&pNotify->hSync, &syncAttrs);
>@@ -290,7 +290,7 @@ DSP_STATUS NTFY_Register(struct NTFY_OBJECT *hNtfy,
>                               pNotify->uEventMask = uEventMask;
>                               pNotify->uNotifyType = uNotifyType;
>                               LST_PutTail(hNtfy->notifyList,
>-                                         (struct LST_ELEM *)pNotify);
>+                                         (struct list_head *)pNotify);
>                       } else {
>                               DeleteNotify(pNotify);
>                       }
>@@ -300,7 +300,7 @@ DSP_STATUS NTFY_Register(struct NTFY_OBJECT *hNtfy,
>               if (uEventMask == 0) {
>                       /* Remove from list and free */
>                       LST_RemoveElem(hNtfy->notifyList,
>-                                    (struct LST_ELEM *)pNotify);
>+                                    (struct list_head *)pNotify);
>                       DeleteNotify(pNotify);
>               } else {
>                       /* Update notification mask (type shouldn't change) */
>diff --git a/drivers/dsp/bridge/wmd/_msg_sm.h
>b/drivers/dsp/bridge/wmd/_msg_sm.h
>index fa5e9ee..db39fd2 100644
>--- a/drivers/dsp/bridge/wmd/_msg_sm.h
>+++ b/drivers/dsp/bridge/wmd/_msg_sm.h
>@@ -121,7 +121,7 @@ struct MSG_MGR {
>  *  The MSG_QUEUE's hSynEvent gets posted when a message is ready.
>  */
> struct MSG_QUEUE {
>-      struct LST_ELEM listElem;
>+      struct list_head listElem;
>       u32 dwSignature;
>       struct MSG_MGR *hMsgMgr;
>       u32 uMaxMsgs;   /* Node message depth */
>@@ -150,7 +150,7 @@ struct MSG_DSPMSG {
>  *  ======== MSG_FRAME ========
>  */
> struct MSG_FRAME {
>-      struct LST_ELEM listElem;
>+      struct list_head listElem;
>       struct MSG_DSPMSG msgData;
> } ;
>
>diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c
>b/drivers/dsp/bridge/wmd/chnl_sm.c
>index e8ffb2f..9007e13 100644
>--- a/drivers/dsp/bridge/wmd/chnl_sm.c
>+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
>@@ -275,8 +275,8 @@ func_cont:
>                       pChirp->dwArg = dwArg;
>                       pChirp->status = (fIsEOS ? CHNL_IOCSTATEOS :
>                                        CHNL_IOCSTATCOMPLETE);
>-                      LST_PutTail(pChnl->pIORequests, (struct LST_ELEM *)
>-                                 pChirp);
>+                      LST_PutTail(pChnl->pIORequests,
>+                                 (struct list_head *)pChirp);
>                       pChnl->cIOReqs++;
>                       DBC_Assert(pChnl->cIOReqs <= pChnl->cChirps);
>                       /* If end of stream, update the channel state to prevent
>@@ -361,7 +361,7 @@ DSP_STATUS WMD_CHNL_CancelIO(struct CHNL_OBJECT *hChnl)
>                       pChirp->cBytes = 0;
>                       pChirp->status |= CHNL_IOCSTATCANCEL;
>                       LST_PutTail(pChnl->pIOCompletions,
>-                                 (struct LST_ELEM *)pChirp);
>+                                 (struct list_head *)pChirp);
>                       pChnl->cIOCs++;
>                       pChnl->cIOReqs--;
>                       DBC_Assert(pChnl->cIOReqs >= 0);
>@@ -715,8 +715,8 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl,
>u32 dwTimeOut,
>                       ioc.dwArg = pChirp->dwArg;
>                       ioc.status |= pChirp->status;
>                       /* Place the used chirp on the free list: */
>-                      LST_PutTail(pChnl->pFreeList, (struct LST_ELEM *)
>-                                 pChirp);
>+                      LST_PutTail(pChnl->pFreeList,
>+                                 (struct list_head *)pChirp);
>               } else {
>                       ioc.pBuf = NULL;
>                       ioc.cBytes = 0;
>@@ -1030,7 +1030,7 @@ static struct LST_LIST *CreateChirpList(u32 uChirps)
>               /* Make N chirps and place on queue. */
>               for (i = 0; (i < uChirps) && ((pChirp = MakeNewChirp()) !=
>                   NULL); i++) {
>-                      LST_PutTail(pChirpList, (struct LST_ELEM *)pChirp);
>+                      LST_PutTail(pChirpList, (struct list_head *)pChirp);
>               }
>
>               /* If we couldn't allocate all chirps, free those allocated: */
>diff --git a/drivers/dsp/bridge/wmd/io_sm.c
>b/drivers/dsp/bridge/wmd/io_sm.c
>index 5a1d3ed..2ee7b7b 100644
>--- a/drivers/dsp/bridge/wmd/io_sm.c
>+++ b/drivers/dsp/bridge/wmd/io_sm.c
>@@ -1355,8 +1355,8 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct
>MSG_MGR *hMsgMgr)
>                                        if (hMsgQueue->msgUsedList && pMsg)
>{
>                                               pMsg->msgData = msg;
>                                               LST_PutTail(hMsgQueue->
>-                                                    msgUsedList,
>-                                                    (struct LST_ELEM *)pMsg);
>+                                                  msgUsedList,
>+                                                  (struct list_head *)pMsg);
>                                               NTFY_Notify(hMsgQueue->hNtfy,
>                                                       DSP_NODEMESSAGEREADY);
>                                               SYNC_SetEvent(hMsgQueue->
>@@ -1375,7 +1375,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct
>MSG_MGR *hMsgMgr)
>                        if (!hMsgMgr->queueList || !hMsgQueue)
>                                goto func_end;
>                       hMsgQueue = (struct MSG_QUEUE *)LST_Next(hMsgMgr->
>-                                  queueList, (struct LST_ELEM *)hMsgQueue);
>+                                  queueList, (struct list_head *)hMsgQueue);
>               }
>       }
>       /* Set the post SWI flag */
>@@ -1412,7 +1412,7 @@ static void NotifyChnlComplete(struct CHNL_OBJECT
>*pChnl,
>         *  WMD_CHNL_GetIOC().  */
>       fSignalEvent = LST_IsEmpty(pChnl->pIOCompletions);
>       /* Enqueue the IO completion info for the client: */
>-      LST_PutTail(pChnl->pIOCompletions, (struct LST_ELEM *) pChirp);
>+      LST_PutTail(pChnl->pIOCompletions, (struct list_head *)pChirp);
>       pChnl->cIOCs++;
>
>       if (pChnl->cIOCs > pChnl->cChirps)
>@@ -1569,7 +1569,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct
>MSG_MGR *hMsgMgr)
>                                if (!hMsgMgr->msgFreeList)
>                                        goto func_end;
>                               LST_PutTail(hMsgMgr->msgFreeList,
>-                                         (struct LST_ELEM *) pMsg);
>+                                         (struct list_head *)pMsg);
>                               SYNC_SetEvent(hMsgMgr->hSyncEvent);
>                       } else {
>                               DBG_Trace(DBG_LEVEL3, "pMsg is NULL\n");
>diff --git a/drivers/dsp/bridge/wmd/msg_sm.c
>b/drivers/dsp/bridge/wmd/msg_sm.c
>index 0231f65..333a41a 100644
>--- a/drivers/dsp/bridge/wmd/msg_sm.c
>+++ b/drivers/dsp/bridge/wmd/msg_sm.c
>@@ -160,7 +160,7 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
>               status = DSP_EMEMORY;
>               goto func_end;
>       }
>-      LST_InitElem((struct LST_ELEM *) pMsgQ);
>+      LST_InitElem((struct list_head *)pMsgQ);
>       pMsgQ->uMaxMsgs = uMaxMsgs;
>       pMsgQ->hMsgMgr = hMsgMgr;
>       pMsgQ->hArg = hArg;     /* Node handle */
>@@ -212,7 +212,7 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
>                       DeleteMsgQueue(pMsgQ, uNumAllocated);
>               } else {
>                       LST_PutTail(hMsgMgr->queueList,
>-                                 (struct LST_ELEM *)pMsgQ);
>+                                 (struct list_head *)pMsgQ);
>                       *phMsgQueue = pMsgQ;
>                       /* Signal that free frames are now available */
>                       if (!LST_IsEmpty(hMsgMgr->msgFreeList))
>@@ -264,7 +264,7 @@ void WMD_MSG_DeleteQueue(struct MSG_QUEUE *hMsgQueue)
>       }
>       /* Remove message queue from hMsgMgr->queueList */
>       (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
>-      LST_RemoveElem(hMsgMgr->queueList, (struct LST_ELEM *)hMsgQueue);
>+      LST_RemoveElem(hMsgMgr->queueList, (struct list_head *)hMsgQueue);
>       /* Free the message queue object */
>       DeleteMsgQueue(hMsgQueue, hMsgQueue->uMaxMsgs);
>        if (!hMsgMgr->msgFreeList)
>@@ -311,7 +311,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>               if (pMsgFrame != NULL) {
>                       *pMsg = pMsgFrame->msgData.msg;
>                       LST_PutTail(hMsgQueue->msgFreeList,
>-                                 (struct LST_ELEM *)pMsgFrame);
>+                                 (struct list_head *)pMsgFrame);
>                       if (LST_IsEmpty(hMsgQueue->msgUsedList))
>                               SYNC_ResetEvent(hMsgQueue->hSyncEvent);
>
>@@ -356,7 +356,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
>                               if (pMsgFrame != NULL) {
>                                       *pMsg = pMsgFrame->msgData.msg;
>                                       LST_PutTail(hMsgQueue->msgFreeList,
>-                                      (struct LST_ELEM *)pMsgFrame);
>+                                      (struct list_head *)pMsgFrame);
>                               }
>                       }
>                       hMsgQueue->refCount--;
>@@ -407,8 +407,8 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
>               if (pMsgFrame != NULL) {
>                       pMsgFrame->msgData.msg = *pMsg;
>                       pMsgFrame->msgData.dwId = hMsgQueue->dwId;
>-                      LST_PutTail(hMsgMgr->msgUsedList, (struct LST_ELEM *)
>-                                 pMsgFrame);
>+                      LST_PutTail(hMsgMgr->msgUsedList,
>+                                 (struct list_head *)pMsgFrame);
>                       hMsgMgr->uMsgsPending++;
>                       fPutMsg = true;
>               }
>@@ -460,8 +460,7 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
>                                       pMsgFrame->msgData.dwId =
>                                               hMsgQueue->dwId;
>                                       LST_PutTail(hMsgMgr->msgUsedList,
>-                                                 (struct LST_ELEM *)
>-                                                 pMsgFrame);
>+                                              (struct list_head *)pMsgFrame);
>                                       hMsgMgr->uMsgsPending++;
>                                       /* Schedule a DPC, to do the actual
>                                        * data transfer: */
>@@ -546,8 +545,8 @@ static DSP_STATUS AddNewMsg(struct LST_LIST *msgList)
>       pMsg = (struct MSG_FRAME *)MEM_Calloc(sizeof(struct MSG_FRAME),
>               MEM_PAGED);
>       if (pMsg != NULL) {
>-              LST_InitElem((struct LST_ELEM *) pMsg);
>-              LST_PutTail(msgList, (struct LST_ELEM *) pMsg);
>+              LST_InitElem((struct list_head *)pMsg);
>+              LST_PutTail(msgList, (struct list_head *)pMsg);
>       } else {
>               status = DSP_EMEMORY;
>       }
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

