From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/4] [OMAPZOOM] DSPBRIDGE: Added checks for valid
 handles in critical places.
Date: Thu, 26 Mar 2009 21:38:47 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2BC77@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39894 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbZC0Ciz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 22:38:55 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2R2cn03029829
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 21:38:54 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2R2cnCW018162
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 21:38:49 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

        Reseding this patch the previous one has some warnings.

>From f9bbaeaef757b913eb1e50738f796259fa4d9237 Mon Sep 17 00:00:00 2001
From: Omar Ramirez Luna <x00omar@ti.com>
Date: Thu, 26 Mar 2009 16:21:07 -0500
Subject: [PATCH] DSPBRIDGE: Added checks for valid handles in critical places.

This patch adds checks for valid handles in critical places.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c  |   84 ++++++++++++++++++++++++++++----------
 drivers/dsp/bridge/wmd/io_sm.c  |   55 ++++++++++++++++++-------
 drivers/dsp/bridge/wmd/msg_sm.c |   73 ++++++++++++++++++++++++++++------
 3 files changed, 163 insertions(+), 49 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 887fd49..2a6590e
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -384,8 +384,14 @@ extern struct constraint_handle *mpu_constraint_handle;

 enum NODE_STATE NODE_GetState(HANDLE hNode)
 {
-   struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
-   return pNode->nState;
+       struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
+       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
+               GT_1trace(NODE_debugMask, GT_5CLASS,
+                "NODE_GetState:hNode 0x%x\n", pNode);
+               return  -1;
+       } else
+               return pNode->nState;
+
 }

 /*
@@ -1335,10 +1341,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
                status = DSP_EFAIL;
                goto func_end;
        }
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
        /* create struct DSP_CBDATA struct for PWR calls */
        cbData.cbData = PWR_TIMEOUT;
        nodeType = NODE_GetType(hNode);
@@ -2185,8 +2187,13 @@ enum NLDR_LOADTYPE NODE_GetLoadType(struct NODE_OBJECT *hNode)

        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-
-       return hNode->dcdProps.objData.nodeObj.usLoadType;
+       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+               GT_1trace(NODE_debugMask, GT_5CLASS,
+                        "NODE_GetLoadType: Failed. hNode:"
+                         " 0x%x\n", hNode);
+               return -1;
+       } else
+               return hNode->dcdProps.objData.nodeObj.usLoadType;
 }

 /*
@@ -2198,8 +2205,13 @@ u32 NODE_GetTimeout(struct NODE_OBJECT *hNode)
 {
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-
-       return hNode->uTimeout;
+       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+               GT_1trace(NODE_debugMask, GT_5CLASS,
+                        "NODE_GetTimeout: Failed. hNode:"
+                         " 0x%x\n", hNode);
+               return 0;
+       } else
+               return hNode->uTimeout;
 }

 /*
@@ -2214,8 +2226,10 @@ enum NODE_TYPE NODE_GetType(struct NODE_OBJECT *hNode)
        if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
                nodeType = NODE_GPP;
        else {
-               DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-               nodeType = hNode->nType;
+               if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
+                       nodeType = -1;
+               else
+                       nodeType = hNode->nType;
        }
        return nodeType;
 }
@@ -2813,6 +2827,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
        DSP_STATUS status;
        DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
        hNodeMgr = hNode->hNodeMgr;
+       if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
+               return;
        hXlator = hNode->hXlator;
        nodeType = NODE_GetType(hNode);
        if (nodeType != NODE_DEVICE) {
@@ -2824,6 +2840,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                if (hNode->hMsgQueue) {
                        pIntfFxns = hNodeMgr->pIntfFxns;
                        (*pIntfFxns->pfnMsgDeleteQueue) (hNode->hMsgQueue);
+                       hNode->hMsgQueue = NULL;
+
                }
                if (hNode->hSyncDone)
                        (void) SYNC_CloseEvent(hNode->hSyncDone);
@@ -2835,6 +2853,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                                FreeStream(hNodeMgr, stream);
                        }
                        MEM_Free(hNode->inputs);
+                       hNode->inputs = NULL;
                }
                if (hNode->outputs) {
                        for (i = 0; i < MaxOutputs(hNode); i++) {
@@ -2842,6 +2861,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                                FreeStream(hNodeMgr, stream);
                        }
                        MEM_Free(hNode->outputs);
+                       hNode->outputs = NULL;
                }
                taskArgs = hNode->createArgs.asa.taskArgs;
                if (taskArgs.strmInDef) {
@@ -2849,6 +2869,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                                if (taskArgs.strmInDef[i].szDevice) {
                                        MEM_Free(taskArgs.strmInDef[i].
                                                szDevice);
+                                       taskArgs.strmInDef[i].szDevice = NULL;
                                }
                        }
                        MEM_Free(taskArgs.strmInDef);
@@ -2859,6 +2880,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                                if (taskArgs.strmOutDef[i].szDevice) {
                                        MEM_Free(taskArgs.strmOutDef[i].
                                                szDevice);
+                                       taskArgs.strmOutDef[i].szDevice = NULL;
                                }
                        }
                        MEM_Free(taskArgs.strmOutDef);
@@ -2890,37 +2912,55 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
                }
        }
        if (nodeType != NODE_MESSAGE) {
-               if (hNode->streamConnect)
+               if (hNode->streamConnect) {
                        MEM_Free(hNode->streamConnect);
-
+                       hNode->streamConnect = NULL;
+               }
        }
-       if (hNode->pstrDevName)
+       if (hNode->pstrDevName) {
                MEM_Free(hNode->pstrDevName);
+               hNode->pstrDevName = NULL;
+       }

-       if (hNode->hNtfy)
+       if (hNode->hNtfy) {
                NTFY_Delete(hNode->hNtfy);
+               hNode->hNtfy = NULL;
+       }

        /* These were allocated in DCD_GetObjectDef (via NODE_Allocate) */
-       if (hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn)
+       if (hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn) {
                MEM_Free(hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn);
+               hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn = NULL;
+       }

-       if (hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn)
+       if (hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn) {
                MEM_Free(hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn);
+               hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn = NULL;
+       }

-       if (hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn)
+       if (hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn) {
                MEM_Free(hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn);
+               hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn = NULL;
+       }

-       if (hNode->dcdProps.objData.nodeObj.pstrIAlgName)
+       if (hNode->dcdProps.objData.nodeObj.pstrIAlgName) {
                MEM_Free(hNode->dcdProps.objData.nodeObj.pstrIAlgName);
+               hNode->dcdProps.objData.nodeObj.pstrIAlgName = NULL;
+       }

        /* Free all SM address translator resources */
-       if (hXlator)
+       if (hXlator) {
                (void) CMM_XlatorDelete(hXlator, TRUE); /* force free */
+               hXlator = NULL;
+       }

-       if (hNode->hNldrNode)
+       if (hNode->hNldrNode) {
                hNodeMgr->nldrFxns.pfnFree(hNode->hNldrNode);
+               hNode->hNldrNode = NULL;
+       }

        MEM_FreeObject(hNode);
+       hNode = NULL;
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 301bd72..2613bd1 100755
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -339,16 +339,16 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
        if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
                /* Unplug IRQ:    */
                /* Disable interrupts from the board:  */
-               if (DSP_SUCCEEDED(DEV_GetWMDContext(hIOMgr->hDevObject,
-                  &hWmdContext)))
-                       DBC_Assert(hWmdContext);
-
+               status = DEV_GetWMDContext(hIOMgr->hDevObject,
+                               &hWmdContext);
+               if (DSP_SUCCEEDED(status))
+                       (void)CHNLSM_DisableInterrupt(hWmdContext);
                (void)CHNLSM_DisableInterrupt(hWmdContext);
-
                flush_workqueue(bridge_workqueue);
                /* Linux function to uninstall ISR */
                free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
-               (void)DPC_Destroy(hIOMgr->hDPC);
+               if (hIOMgr->hDPC)
+                       (void)DPC_Destroy(hIOMgr->hDPC);
 #ifndef DSP_TRACEBUF_DISABLED
                if (hIOMgr->pMsg)
                        MEM_Free(hIOMgr->pMsg);
@@ -1186,6 +1186,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
        pChnl = pChnlMgr->apChannel[chnlId];
        if ((pChnl != NULL) && CHNL_IsInput(pChnl->uMode)) {
                if ((pChnl->dwState & ~CHNL_STATEEOS) == CHNL_STATEREADY) {
+                       if (!pChnl->pIORequests)
+                               goto func_end;
                        /* Get the I/O request, and attempt a transfer:  */
                        pChirp = (struct CHNL_IRP *)LST_GetHead(pChnl->
                                 pIORequests);
@@ -1225,6 +1227,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
                                                 "chnl = 0x%x\n", pChnl);
                                }
                                /* Tell DSP if no more I/O buffers available: */
+                               if (!pChnl->pIORequests)
+                                       goto func_end;
                                if (LST_IsEmpty(pChnl->pIORequests)) {
                                        IO_AndValue(pIOMgr->hWmdContext,
                                                   struct SHM, sm, hostFreeMask,
@@ -1296,6 +1300,9 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                addr = (u32)&(((struct MSG_DSPMSG *)pMsgInput)->dwId);
                msg.dwId = ReadExt32BitDspData(pIOMgr->hWmdContext, addr);
                pMsgInput += sizeof(struct MSG_DSPMSG);
+               if (!hMsgMgr->queueList)
+                       goto func_end;
+
                /* Determine which queue to put the message in */
                hMsgQueue = (struct MSG_QUEUE *)LST_First(hMsgMgr->queueList);
                DBG_Trace(DBG_LEVEL7, "InputMsg RECVD: dwCmd=0x%x dwArg1=0x%x "
@@ -1304,8 +1311,8 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                 /*  Interrupt may occur before shared memory and message
                 *  input locations have been set up. If all nodes were
                 *  cleaned up, hMsgMgr->uMaxMsgs should be 0.  */
-               if (hMsgQueue)
-                       DBC_Assert(uMsgs <= hMsgMgr->uMaxMsgs);
+               if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
+                       goto func_end;

                while (hMsgQueue != NULL) {
                        if (msg.dwId == hMsgQueue->dwId) {
@@ -1320,9 +1327,11 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                                } else {
                                        /* Not an exit acknowledgement, queue
                                         * the message */
+                                       if (!hMsgQueue->msgFreeList)
+                                               goto func_end;
                                        pMsg = (struct MSG_FRAME *)LST_GetHead
                                                (hMsgQueue->msgFreeList);
-                                       if (pMsg) {
+                                       if (hMsgQueue->msgUsedList && pMsg) {
                                                pMsg->msgData = msg;
                                                LST_PutTail(hMsgQueue->
                                                      msgUsedList,
@@ -1341,6 +1350,9 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                                }
                                break;
                        }
+
+                       if (!hMsgMgr->queueList || !hMsgQueue)
+                               goto func_end;
                        hMsgQueue = (struct MSG_QUEUE *)LST_Next(hMsgMgr->
                                    queueList, (struct LST_ELEM *)hMsgQueue);
                }
@@ -1354,6 +1366,9 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                           true);
                CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
        }
+func_end:
+       return;
+
 }

 /*
@@ -1418,9 +1433,8 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
                goto func_end;

        pChnl = pChnlMgr->apChannel[chnlId];
-       if (!pChnl) {
+       if (!pChnl || !pChnl->pIORequests) {
                /* Shouldn't get here: */
-               DBC_Assert(pChnl == NULL);
                goto func_end;
        }
        /* Get the I/O request, and attempt a transfer:  */
@@ -1429,7 +1443,9 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
                goto func_end;

        pChnl->cIOReqs--;
-       DBC_Assert(pChnl->cIOReqs >= 0);
+       if (pChnl->cIOReqs < 0 || !pChnl->pIORequests)
+               goto func_end;
+
        /* Record fact that no more I/O buffers available:  */
        if (LST_IsEmpty(pChnl->pIORequests))
                pChnlMgr->dwOutputMask &= ~(1 << chnlId);
@@ -1492,9 +1508,13 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                pMsgOutput = pIOMgr->pMsgOutput;
                /* Copy uMsgs messages into shared memory */
                for (i = 0; i < uMsgs; i++) {
-                       pMsg = (struct MSG_FRAME *)LST_GetHead(hMsgMgr->
-                               msgUsedList);
-                       DBC_Assert(pMsg != NULL);
+                       if (!hMsgMgr->msgUsedList) {
+                               DBG_Trace(DBG_LEVEL3, "msgUsedList is NULL\n");
+                               pMsg = NULL;
+                               goto func_end;
+                       } else
+                               pMsg = (struct MSG_FRAME *)LST_GetHead(
+                                       hMsgMgr->msgUsedList);
                        if (pMsg != NULL) {
                                val = (pMsg->msgData).dwId;
                                addr = (u32)&(((struct MSG_DSPMSG *)
@@ -1519,6 +1539,8 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                                WriteExt32BitDspData(pIOMgr->hWmdContext, addr,
                                                    val);
                                pMsgOutput += sizeof(struct MSG_DSPMSG);
+                               if (!hMsgMgr->msgFreeList)
+                                       goto func_end;
                                LST_PutTail(hMsgMgr->msgFreeList,
                                           (struct LST_ELEM *) pMsg);
                                SYNC_SetEvent(hMsgMgr->hSyncEvent);
@@ -1546,6 +1568,9 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
                                        MBX_PCPY_CLASS);
                }
        }
+func_end:
+       return;
+
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 19fa135..53d34d9
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -184,6 +184,10 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
                status = SYNC_OpenEvent(&pMsgQ->hSyncDoneAck, NULL);

        if (DSP_SUCCEEDED(status)) {
+               if (!hMsgMgr->msgFreeList) {
+                       status = DSP_EHANDLE;
+                       goto func_end;
+               }
                /* Enter critical section */
                (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
                /* Initialize message frames and put in appropriate queues */
@@ -252,10 +256,12 @@ void WMD_MSG_DeleteQueue(struct MSG_QUEUE *hMsgQueue)
        LST_RemoveElem(hMsgMgr->queueList, (struct LST_ELEM *)hMsgQueue);
        /* Free the message queue object */
        DeleteMsgQueue(hMsgQueue, hMsgQueue->uMaxMsgs);
+       if (!hMsgMgr->msgFreeList)
+               goto func_cont;
        if (LST_IsEmpty(hMsgMgr->msgFreeList))
                SYNC_ResetEvent(hMsgMgr->hSyncEvent);
-
+func_cont:
        (void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 }

 /*
@@ -276,6 +285,11 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
        DBC_Require(pMsg != NULL);

        hMsgMgr = hMsgQueue->hMsgMgr;
+       if (!hMsgQueue->msgUsedList) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
+
        /* Enter critical section */
        (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
        /* If a message is already there, get it */
@@ -342,6 +356,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
                        (void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
                }
        }
+func_end:
        return status;
 }

@@ -364,6 +379,12 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,

        hMsgMgr = hMsgQueue->hMsgMgr;

+       if (!hMsgMgr->msgFreeList) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
+
+
        (void) SYNC_EnterCS(hMsgMgr->hSyncCS);

        /* If a message frame is available, use it */
@@ -412,7 +433,10 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
                        status = DSP_EFAIL;
                } else {
                        if (DSP_SUCCEEDED(status)) {
-                               DBC_Assert(!LST_IsEmpty(hMsgMgr->msgFreeList));
+                               if (LST_IsEmpty(hMsgMgr->msgFreeList)) {
+                                       status = DSP_EPOINTER;
+                                       goto func_cont;
+                               }
                                /* Get msg from free list */
                                pMsgFrame = (struct MSG_FRAME *)
                                            LST_GetHead(hMsgMgr->msgFreeList);
@@ -435,11 +459,12 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
                        /* Reset event if there are still frames available */
                        if (!LST_IsEmpty(hMsgMgr->msgFreeList))
                                SYNC_SetEvent(hMsgMgr->hSyncEvent);
-
+func_cont:
                        /* Exit critical section */
                        (void) SYNC_LeaveCS(hMsgMgr->hSyncCS);
                }
        }
+func_end:
        return status;
 }

@@ -517,15 +542,21 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
        DBC_Require(MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE));

        if (hMsgMgr->queueList) {
-               DBC_Assert(LST_IsEmpty(hMsgMgr->queueList));
-               LST_Delete(hMsgMgr->queueList);
+               if (LST_IsEmpty(hMsgMgr->queueList)) {
+                       LST_Delete(hMsgMgr->queueList);
+                       hMsgMgr->queueList = NULL;
+               }
        }

-       if (hMsgMgr->msgFreeList)
+       if (hMsgMgr->msgFreeList) {
                FreeMsgList(hMsgMgr->msgFreeList);
+               hMsgMgr->msgFreeList = NULL;
+       }

-       if (hMsgMgr->msgUsedList)
+       if (hMsgMgr->msgUsedList) {
                FreeMsgList(hMsgMgr->msgUsedList);
+               hMsgMgr->msgUsedList = NULL;
+       }

        if (hMsgMgr->hSyncEvent)
                SYNC_CloseEvent(hMsgMgr->hSyncEvent);
@@ -541,11 +575,15 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
  */
 static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
 {
-       struct MSG_MGR *hMsgMgr = hMsgQueue->hMsgMgr;
+       struct MSG_MGR *hMsgMgr;
        struct MSG_FRAME *pMsg;
        u32 i;

-       DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
+       if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE)
+               || !hMsgQueue->hMsgMgr || !hMsgQueue->hMsgMgr->msgFreeList)
+               goto func_end;
+       hMsgMgr = hMsgQueue->hMsgMgr;
+

        /* Pull off uNumToDSP message frames from Msg manager and free */
        for (i = 0; i < uNumToDSP; i++) {
@@ -560,11 +598,16 @@ static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
                }
        }

-       if (hMsgQueue->msgFreeList)
+       if (hMsgQueue->msgFreeList) {
                FreeMsgList(hMsgQueue->msgFreeList);
+               hMsgQueue->msgFreeList = NULL;
+       }

-       if (hMsgQueue->msgUsedList)
+       if (hMsgQueue->msgUsedList) {
                FreeMsgList(hMsgQueue->msgUsedList);
+               hMsgQueue->msgUsedList = NULL;
+       }
+

        if (hMsgQueue->hNtfy)
                NTFY_Delete(hMsgQueue->hNtfy);
@@ -579,6 +622,9 @@ static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
                SYNC_CloseEvent(hMsgQueue->hSyncDoneAck);

        MEM_FreeObject(hMsgQueue);
+func_end:
+       return;
+
 }

 /*
@@ -588,7 +634,8 @@ static void FreeMsgList(struct LST_LIST *msgList)
 {
        struct MSG_FRAME *pMsg;

-       DBC_Require(msgList != NULL);
+       if (!msgList)
+               goto func_end;

        while ((pMsg = (struct MSG_FRAME *)LST_GetHead(msgList)) != NULL)
                MEM_Free(pMsg);
@@ -596,5 +643,7 @@ static void FreeMsgList(struct LST_LIST *msgList)
        DBC_Assert(LST_IsEmpty(msgList));

        LST_Delete(msgList);
+func_end:
+       return;
 }

--
1.5.6.4

