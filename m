From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Validate node handle from user
Date: Tue, 9 Feb 2010 11:08:30 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C89E95B@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256Ab0BIRIf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:08:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>

>From 8310b586b025b0703c3951560849c4ea0250b6e1 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 29 Jan 2010 16:21:59 -0600
Subject: [PATCH] DSPBRIDGE: Validate node handle from user.

Add checks to validate the node handles received from user.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |   91 ++++++++++++++++++++-
 drivers/dsp/bridge/rmgr/node.c |  174 +++++++++++++--------------------------
 2 files changed, 146 insertions(+), 119 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 74654dc..2e6eeb0 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1066,6 +1066,24 @@ u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
        return retVal;
 }

+bool validate_node_handle(struct NODE_OBJECT *hNode, void *pr_ctxt)
+{
+       bool retVal = false;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+       struct NODE_RES_OBJECT *pNode = pCtxt->pNodeList;
+
+       if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
+               retVal = true;
+
+       while (pNode && !retVal) {
+               if (hNode == pNode->hNode)
+                       retVal = true;
+               pNode = pNode->next;
+       }
+
+       return retVal;
+}
+
 /*
  * ======== NODEWRAP_Allocate ========
  */
@@ -1140,6 +1158,10 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
        if (!args->ARGS_NODE_ALLOCMSGBUF.uSize)
                return DSP_ESIZE;

+       if (!validate_node_handle(args->ARGS_NODE_ALLOCMSGBUF.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        if (args->ARGS_NODE_ALLOCMSGBUF.pAttr) {        /* Optional argument */
                cp_fm_usr(&attr, args->ARGS_NODE_ALLOCMSGBUF.pAttr, status, 1);
                if (DSP_SUCCEEDED(status))
@@ -1148,6 +1170,7 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
        }
        /* IN OUT argument */
        cp_fm_usr(&pBuffer, args->ARGS_NODE_ALLOCMSGBUF.pBuffer, status, 1);
+
        if (DSP_SUCCEEDED(status)) {
                status = NODE_AllocMsgBuf(args->ARGS_NODE_ALLOCMSGBUF.hNode,
                                         args->ARGS_NODE_ALLOCMSGBUF.uSize,
@@ -1166,6 +1189,11 @@ u32 NODEWRAP_ChangePriority(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_ChangePriority: entered\n");
+
+       if (!validate_node_handle(args->ARGS_NODE_CHANGEPRIORITY.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        retVal = NODE_ChangePriority(args->ARGS_NODE_CHANGEPRIORITY.hNode,
                        args->ARGS_NODE_CHANGEPRIORITY.iPriority);

@@ -1186,6 +1214,13 @@ u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Connect: entered\n");

+       if (!validate_node_handle(args->ARGS_NODE_CONNECT.hNode,
+               pr_ctxt) ||
+               !validate_node_handle(args->ARGS_NODE_CONNECT.hOtherNode,
+               pr_ctxt)) {
+               status = DSP_EHANDLE;
+               goto func_cont;
+       }
        /* Optional argument */
        if (pSize) {
                if (get_user(cbDataSize, pSize))
@@ -1211,6 +1246,7 @@ u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)
                        pAttrs = &attrs;

        }
+
        if (DSP_SUCCEEDED(status)) {
                status = NODE_Connect(args->ARGS_NODE_CONNECT.hNode,
                                     args->ARGS_NODE_CONNECT.uStream,
@@ -1233,6 +1269,11 @@ u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt)
        u32 retVal;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Create: entered\n");
+
+       if (!validate_node_handle(args->ARGS_NODE_CREATE.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        retVal = NODE_Create(args->ARGS_NODE_CREATE.hNode);

        return retVal;
@@ -1246,6 +1287,11 @@ u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
        u32 retVal;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Delete: entered\n");
+
+       if (!validate_node_handle(args->ARGS_NODE_DELETE.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode, pr_ctxt);

        return retVal;
@@ -1259,6 +1305,14 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct DSP_BUFFERATTR *pAttr = NULL;
        struct DSP_BUFFERATTR attr;
+
+       if (!args->ARGS_NODE_FREEMSGBUF.pBuffer)
+               return DSP_EPOINTER;
+
+       if (!validate_node_handle(args->ARGS_NODE_FREEMSGBUF.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        if (args->ARGS_NODE_FREEMSGBUF.pAttr) { /* Optional argument */
                cp_fm_usr(&attr, args->ARGS_NODE_FREEMSGBUF.pAttr, status, 1);
                if (DSP_SUCCEEDED(status))
@@ -1266,9 +1320,6 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)

        }

-       if (!args->ARGS_NODE_FREEMSGBUF.pBuffer)
-               return DSP_EPOINTER;
-
        if (DSP_SUCCEEDED(status)) {
                status = NODE_FreeMsgBuf(args->ARGS_NODE_FREEMSGBUF.hNode,
                                        args->ARGS_NODE_FREEMSGBUF.pBuffer,
@@ -1288,6 +1339,10 @@ u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetAttr: entered\n");

+       if (!validate_node_handle(args->ARGS_NODE_GETATTR.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        status = NODE_GetAttr(args->ARGS_NODE_GETATTR.hNode, &attr,
                             args->ARGS_NODE_GETATTR.uAttrSize);
        cp_to_usr(args->ARGS_NODE_GETATTR.pAttr, &attr, status, 1);
@@ -1305,6 +1360,10 @@ u32 NODEWRAP_GetMessage(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetMessage: entered\n");

+       if (!validate_node_handle(args->ARGS_NODE_GETMESSAGE.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        status = NODE_GetMessage(args->ARGS_NODE_GETMESSAGE.hNode, &msg,
                                args->ARGS_NODE_GETMESSAGE.uTimeout);

@@ -1321,6 +1380,11 @@ u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt)
        u32 retVal;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Pause: entered\n");
+
+       if (!validate_node_handle(args->ARGS_NODE_PAUSE.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        retVal = NODE_Pause(args->ARGS_NODE_PAUSE.hNode);

        return retVal;
@@ -1336,6 +1400,10 @@ u32 NODEWRAP_PutMessage(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_PutMessage: entered\n");

+       if (!validate_node_handle(args->ARGS_NODE_PUTMESSAGE.hNode,
+               pr_ctxt))
+               status = DSP_EHANDLE;
+
        cp_fm_usr(&msg, args->ARGS_NODE_PUTMESSAGE.pMessage, status, 1);

        if (DSP_SUCCEEDED(status)) {
@@ -1361,6 +1429,10 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
        notification.psName = NULL;
        notification.handle = NULL;

+       if (!validate_node_handle(args->ARGS_NODE_REGISTERNOTIFY.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        if (!args->ARGS_PROC_REGISTER_NOTIFY.uEventMask)
                cp_fm_usr(&notification,
                        args->ARGS_PROC_REGISTER_NOTIFY.hNotification,
@@ -1383,6 +1455,11 @@ u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt)
        u32 retVal;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Run: entered\n");
+
+       if (!validate_node_handle(args->ARGS_NODE_RUN.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        retVal = NODE_Run(args->ARGS_NODE_RUN.hNode);

        return retVal;
@@ -1398,6 +1475,10 @@ u32 NODEWRAP_Terminate(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Terminate: entered\n");

+       if (!validate_node_handle(args->ARGS_NODE_TERMINATE.hNode,
+               pr_ctxt))
+               return DSP_EHANDLE;
+
        status = NODE_Terminate(args->ARGS_NODE_TERMINATE.hNode, &tempstatus);

        cp_to_usr(args->ARGS_NODE_TERMINATE.pStatus, &tempstatus, status, 1);
@@ -1584,6 +1665,10 @@ u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
        struct STRM_OBJECT *pStrm;
        struct DSP_STREAMATTRIN strmAttrIn;

+       if (!validate_node_handle(args->ARGS_NODE_ALLOCMSGBUF.hNode,
+               pr_ctxt))
+               status = DSP_EHANDLE;
+
        cp_fm_usr(&attr, args->ARGS_STRM_OPEN.pAttrIn, status, 1);

        if (attr.pStreamAttrIn != NULL) {       /* Optional argument */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index a7816c2..972aba7 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -729,9 +729,7 @@ DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
                 " 0x%x\tpAttr: 0x%x\tpBuffer: %d\n", pNode, uSize, pAttr,
                 pBuffer);

-       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE))
-               status = DSP_EHANDLE;
-       else if (NODE_GetType(pNode) == NODE_DEVICE)
+       if (NODE_GetType(pNode) == NODE_DEVICE)
                status = DSP_ENODETYPE;

        if (DSP_FAILED(status))
@@ -820,7 +818,7 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
        GT_2trace(NODE_debugMask, GT_ENTER, "NODE_ChangePriority: "
                 "hNode: 0x%x\tnPriority: %d\n", hNode, nPriority);

-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
+       if (!hNode->hNodeMgr) {
                GT_1trace(NODE_debugMask, GT_7CLASS,
                         "Invalid NODE Handle: 0x%x\n", hNode);
                status = DSP_EHANDLE;
@@ -1199,10 +1197,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
        DBC_Require(cRefs > 0);
        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
                 hNode);
-       if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
+
        hProcessor = hNode->hProcessor;
        status = PROC_GetState(hProcessor, &procStatus,
                                        sizeof(struct DSP_PROCESSORSTATE));
@@ -1517,10 +1512,6 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
        DBC_Require(cRefs > 0);
        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Delete: hNode: 0x%x\n",
                  hNode);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
        /* create struct DSP_CBDATA struct for PWR call */
        cbData.cbData = PWR_TIMEOUT;
        hNodeMgr = hNode->hNodeMgr;
@@ -1765,10 +1756,6 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
        DBC_Require(pNode->hXlator != NULL);
        GT_3trace(NODE_debugMask, GT_ENTER, "NODE_FreeMsgBuf: hNode: 0x%x\t"
                 "pBuffer: 0x%x\tpAttr: 0x%x\n", hNode, pBuffer, pAttr);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
        status = PROC_GetProcessorId(pNode->hProcessor, &procId);
        if (procId == DSP_UNIT) {
                if (DSP_SUCCEEDED(status)) {
@@ -1786,7 +1773,7 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
        } else {
                DBC_Assert(NULL);       /* BUG */
        }
-func_end:
+
        return status;
 }

@@ -1807,34 +1794,32 @@ DSP_STATUS NODE_GetAttr(struct NODE_OBJECT *hNode,
        GT_3trace(NODE_debugMask, GT_ENTER, "NODE_GetAttr: hNode: "
                 "0x%x\tpAttr: 0x%x \tuAttrSize: 0x%x\n", hNode, pAttr,
                 uAttrSize);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-       } else {
-               hNodeMgr = hNode->hNodeMgr;
-                /* Enter hNodeMgr critical section (since we're accessing
-                 * data that could be changed by NODE_ChangePriority() and
-                 * NODE_Connect().  */
-               status = SYNC_EnterCS(hNodeMgr->hSync);
-               if (DSP_SUCCEEDED(status)) {
-                       pAttr->cbStruct = sizeof(struct DSP_NODEATTR);
-                       /* DSP_NODEATTRIN */
-                       pAttr->inNodeAttrIn.cbStruct =
-                                        sizeof(struct DSP_NODEATTRIN);
-                       pAttr->inNodeAttrIn.iPriority = hNode->nPriority;
-                       pAttr->inNodeAttrIn.uTimeout = hNode->uTimeout;
-                       pAttr->inNodeAttrIn.uHeapSize =
-                               hNode->createArgs.asa.taskArgs.uHeapSize;
-                       pAttr->inNodeAttrIn.pGPPVirtAddr = (void *)
-                               hNode->createArgs.asa.taskArgs.uGPPHeapAddr;
-                       pAttr->uInputs = hNode->uNumGPPInputs;
-                       pAttr->uOutputs = hNode->uNumGPPOutputs;
-                       /* DSP_NODEINFO */
-                       GetNodeInfo(hNode, &(pAttr->iNodeInfo));
-               }
-               /* end of SYNC_EnterCS */
-               /* Exit critical section */
-               (void)SYNC_LeaveCS(hNodeMgr->hSync);
+
+       hNodeMgr = hNode->hNodeMgr;
+        /* Enter hNodeMgr critical section (since we're accessing
+         * data that could be changed by NODE_ChangePriority() and
+         * NODE_Connect().  */
+       status = SYNC_EnterCS(hNodeMgr->hSync);
+       if (DSP_SUCCEEDED(status)) {
+               pAttr->cbStruct = sizeof(struct DSP_NODEATTR);
+               /* DSP_NODEATTRIN */
+               pAttr->inNodeAttrIn.cbStruct =
+                                sizeof(struct DSP_NODEATTRIN);
+               pAttr->inNodeAttrIn.iPriority = hNode->nPriority;
+               pAttr->inNodeAttrIn.uTimeout = hNode->uTimeout;
+               pAttr->inNodeAttrIn.uHeapSize =
+                       hNode->createArgs.asa.taskArgs.uHeapSize;
+               pAttr->inNodeAttrIn.pGPPVirtAddr = (void *)
+                       hNode->createArgs.asa.taskArgs.uGPPHeapAddr;
+               pAttr->uInputs = hNode->uNumGPPInputs;
+               pAttr->uOutputs = hNode->uNumGPPOutputs;
+               /* DSP_NODEINFO */
+               GetNodeInfo(hNode, &(pAttr->iNodeInfo));
        }
+       /* end of SYNC_EnterCS */
+       /* Exit critical section */
+       (void)SYNC_LeaveCS(hNodeMgr->hSync);
+
        return status;
 }

@@ -1855,10 +1840,6 @@ DSP_STATUS NODE_GetChannelId(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
        GT_4trace(NODE_debugMask, GT_ENTER, "NODE_GetChannelId: hNode: "
                 "0x%x\tuDir: %d\tuIndex: %d\tpulId: 0x%x\n", hNode, uDir,
                 uIndex, pulId);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               return status;
-       }
        nodeType = NODE_GetType(hNode);
        if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET) {
                status = DSP_ENODETYPE;
@@ -1904,10 +1885,7 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
        GT_3trace(NODE_debugMask, GT_ENTER,
                 "NODE_GetMessage: hNode: 0x%x\tpMsg: "
                 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
+
        hProcessor = hNode->hProcessor;
        status = PROC_GetState(hProcessor, &procStatus,
                                        sizeof(struct DSP_PROCESSORSTATE));
@@ -2002,10 +1980,7 @@ DSP_STATUS NODE_GetStrmMgr(struct NODE_OBJECT *hNode,

        DBC_Require(cRefs > 0);

-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-               status = DSP_EHANDLE;
-       else
-               *phStrmMgr = hNode->hNodeMgr->hStrmMgr;
+       *phStrmMgr = hNode->hNodeMgr->hStrmMgr;

        return status;
 }
@@ -2017,14 +1992,8 @@ enum NLDR_LOADTYPE NODE_GetLoadType(struct NODE_OBJECT *hNode)
 {
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               GT_1trace(NODE_debugMask, GT_5CLASS,
-                       "NODE_GetLoadType: Failed. hNode:"
-                       " 0x%x\n", hNode);
-               return -1;
-       } else {
-               return hNode->dcdProps.objData.nodeObj.usLoadType;
-       }
+
+       return hNode->dcdProps.objData.nodeObj.usLoadType;
 }

 /*
@@ -2036,14 +2005,8 @@ u32 NODE_GetTimeout(struct NODE_OBJECT *hNode)
 {
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               GT_1trace(NODE_debugMask, GT_5CLASS,
-                       "NODE_GetTimeout: Failed. hNode:"
-                       " 0x%x\n", hNode);
-               return 0;
-       } else {
-               return hNode->uTimeout;
-       }
+
+       return hNode->uTimeout;
 }

 /*
@@ -2057,12 +2020,8 @@ enum NODE_TYPE NODE_GetType(struct NODE_OBJECT *hNode)

        if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
                nodeType = NODE_GPP;
-       else {
-               if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-                       nodeType = -1;
-               else
-                       nodeType = hNode->nType;
-       }
+       else
+               nodeType = hNode->nType;
        return nodeType;
 }

@@ -2133,13 +2092,10 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)

        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Pause: hNode: 0x%x\n", hNode);

-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-       } else {
-               nodeType = NODE_GetType(hNode);
-               if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET)
-                       status = DSP_ENODETYPE;
-       }
+       nodeType = NODE_GetType(hNode);
+       if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET)
+               status = DSP_ENODETYPE;
+
        if (DSP_FAILED(status))
                goto func_end;

@@ -2231,10 +2187,7 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
        GT_3trace(NODE_debugMask, GT_ENTER,
                 "NODE_PutMessage: hNode: 0x%x\tpMsg: "
                 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
+
        hProcessor = hNode->hProcessor;
        status = PROC_GetState(hProcessor, &procStatus,
                                        sizeof(struct DSP_PROCESSORSTATE));
@@ -2332,24 +2285,21 @@ DSP_STATUS NODE_RegisterNotify(struct NODE_OBJECT *hNode, u32 uEventMask,
                 "uEventMask: 0x%x\tuNotifyType: 0x%x\thNotification: 0x%x\n",
                 hNode, uEventMask, uNotifyType, hNotification);

-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-       } else {
-               /* Check if event mask is a valid node related event */
-               if (uEventMask & ~(DSP_NODESTATECHANGE |
-                  DSP_NODEMESSAGEREADY))
-                       status = DSP_EVALUE;
+       /* Check if event mask is a valid node related event */
+       if (uEventMask & ~(DSP_NODESTATECHANGE |
+          DSP_NODEMESSAGEREADY))
+               status = DSP_EVALUE;

-               /* Check if notify type is valid */
-               if (uNotifyType != DSP_SIGNALEVENT)
-                       status = DSP_EVALUE;
+       /* Check if notify type is valid */
+       if (uNotifyType != DSP_SIGNALEVENT)
+               status = DSP_EVALUE;
+
+       /* Only one Notification can be registered at a
+        * time - Limitation */
+       if (uEventMask == (DSP_NODESTATECHANGE |
+          DSP_NODEMESSAGEREADY))
+               status = DSP_EVALUE;

-               /* Only one Notification can be registered at a
-                * time - Limitation */
-               if (uEventMask == (DSP_NODESTATECHANGE |
-                  DSP_NODEMESSAGEREADY))
-                       status = DSP_EVALUE;
-       }
        if (DSP_SUCCEEDED(status)) {
                if (uEventMask == DSP_NODESTATECHANGE) {
                        status = NTFY_Register(hNode->hNtfy, hNotification,
@@ -2390,10 +2340,7 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)

        DBC_Require(cRefs > 0);
        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Run: hNode: 0x%x\n", hNode);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               goto func_end;
-       }
+
        hProcessor = hNode->hProcessor;
        status = PROC_GetState(hProcessor, &procStatus,
                                        sizeof(struct DSP_PROCESSORSTATE));
@@ -2515,7 +2462,7 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)

        GT_1trace(NODE_debugMask, GT_ENTER,
                 "NODE_Terminate: hNode: 0x%x\n", hNode);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
+       if (!hNode->hNodeMgr) {
                status = DSP_EHANDLE;
                goto func_end;
        }
@@ -2667,8 +2614,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
                        (struct PROC_OBJECT *)hNode->hProcessor;
 #endif
        DSP_STATUS status;
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-               goto func_end;
+
        hNodeMgr = hNode->hNodeMgr;
        if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
                goto func_end;
@@ -3044,7 +2990,6 @@ void GetNodeInfo(struct NODE_OBJECT *hNode, struct DSP_NODEINFO *pNodeInfo)
 {
        u32 i;

-       DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
        DBC_Require(pNodeInfo != NULL);

        pNodeInfo->cbStruct = sizeof(struct DSP_NODEINFO);
@@ -3343,8 +3288,6 @@ static u32 Ovly(void *pPrivRef, u32 ulDspRunAddr, u32 ulDspLoadAddr,
        struct WMD_DEV_CONTEXT *hWmdContext;
        struct WMD_DRV_INTERFACE *pIntfFxns;    /* Function interface to WMD */

-       DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
-
        hNodeMgr = hNode->hNodeMgr;

        ulSize = ulNumBytes / hNodeMgr->uDSPWordSize;
@@ -3383,7 +3326,6 @@ static u32 Write(void *pPrivRef, u32 ulDspAddr, void *pBuf,
        struct WMD_DEV_CONTEXT *hWmdContext;
        struct WMD_DRV_INTERFACE *pIntfFxns;    /* Function interface to WMD */

-       DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
        DBC_Require(nMemSpace & DBLL_CODE || nMemSpace & DBLL_DATA);

        hNodeMgr = hNode->hNodeMgr;
--
1.5.4.5

