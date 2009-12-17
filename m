From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: Validate Processor Handle from user.
Date: Wed, 16 Dec 2009 19:32:01 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008B7694AD@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55608 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936006AbZLQBcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 20:32:04 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBH1W36r024384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:32:03 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBH1W2FE010416
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:32:02 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBH1W2XX012843
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:32:02 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 84b37fc98b56b91ab364c40114d9cf072bbef345 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 16 Dec 2009 18:09:14 -0600
Subject: [PATCH] DSPBRIDGE: Validate Processor Handle from user.

Add check to validate the Processor handle received
from user.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |   81 +++++++++++-
 drivers/dsp/bridge/rmgr/proc.c |  300 ++++++++++++++--------------------------
 2 files changed, 184 insertions(+), 197 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 917e549..55b436a 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -701,6 +701,7 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
                        args->ARGS_PROC_CTRL.pArgs;
        u8 *pArgs = NULL;
        DSP_STATUS status = DSP_SOK;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_3trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_Ctrl: entered args:\n 0x%x"
@@ -708,6 +709,10 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_CTRL.hProcessor,
                 args->ARGS_PROC_CTRL.dwCmd,
                 args->ARGS_PROC_CTRL.pArgs);
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor) {
+               status = DSP_EHANDLE;
+               goto func_end;
+       }
        if (pSize) {
                if (get_user(cbDataSize, pSize)) {
                        status = DSP_EFAIL;
@@ -759,6 +764,7 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
        DSP_HNODE aNodeTab[MAX_NODES];
        u32 uNumNodes;
        u32 uAllocated;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_5trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_EnumNode_Info:entered args:\n0x"
@@ -770,6 +776,9 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
                 args->ARGS_PROC_ENUMNODE_INFO.puAllocated);

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (!args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize)
                return DSP_ESIZE;

@@ -792,9 +801,13 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_FlushMemory: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_FLUSHMEMORY.ulFlags > PROC_WRBK_INV_ALL)
                return DSP_EINVALIDARG;

@@ -812,10 +825,14 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_InvalidateMemory:entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_InvalidateMemory(
                                  args->ARGS_PROC_INVALIDATEMEMORY.hProcessor,
                                  args->ARGS_PROC_INVALIDATEMEMORY.pMpuAddr,
@@ -831,6 +848,7 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_RESOURCEINFO pResourceInfo;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_4trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_EnumResources: entered args:\n"
@@ -841,6 +859,9 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
                 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize <
                sizeof(struct DSP_RESOURCEINFO))
                return DSP_ESIZE;
@@ -864,8 +885,13 @@ u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_PROCESSORSTATE procStatus;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetState: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_GETSTATE.uStateInfoSize <
                sizeof(struct DSP_PROCESSORSTATE))
                return DSP_ESIZE;
@@ -884,9 +910,13 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        u8 *pBuf;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetTrace: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_GETTRACE.uMaxSize > MAX_TRACEBUFLEN)
                return DSP_ESIZE;

@@ -915,6 +945,12 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
        char *temp;
        s32 count = args->ARGS_PROC_LOAD.iArgc;
        u8 **argv = NULL, **envp = NULL;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor) {
+               status = DSP_EHANDLE;
+               goto func_cont;
+       }

        if (count <= 0 || count > MAX_LOADARGS) {
                status = DSP_EINVALIDARG;
@@ -1033,9 +1069,13 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pMapAddr;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Map: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (!args->ARGS_PROC_MAPMEM.ulSize)
                return DSP_ESIZE;

@@ -1062,10 +1102,14 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_NOTIFICATION notification;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_RegisterNotify: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        /* Initialize the notification data structure  */
        notification.psName = NULL;
        notification.handle = NULL;
@@ -1086,12 +1130,17 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pRsvAddr;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
+       GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;

        if ((args->ARGS_PROC_RSVMEM.ulSize <= 0) ||
                (args->ARGS_PROC_RSVMEM.ulSize & (PG_SIZE_4K - 1)) != 0)
                return DSP_ESIZE;

-       GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
        status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
                                   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
        if (DSP_SUCCEEDED(status)) {
@@ -1110,8 +1159,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Start: entered\n");
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        retVal = PROC_Start(args->ARGS_PROC_START.hProcessor);
        return retVal;
 }
@@ -1122,8 +1176,13 @@ u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_UnMap: entered\n");
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_UnMap(args->ARGS_PROC_UNMAPMEM.hProcessor,
                           args->ARGS_PROC_UNMAPMEM.pMapAddr, pr_ctxt);
        return status;
@@ -1135,9 +1194,14 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_UnReserveMemory: entered\n");
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_UnReserveMemory(args->ARGS_PROC_UNRSVMEM.hProcessor,
                                     args->ARGS_PROC_UNRSVMEM.pRsvAddr);
        return status;
@@ -1149,8 +1213,13 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Stop: entered\n");
+
+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        retVal = PROC_Stop(args->ARGS_PROC_STOP.hProcessor);

        return retVal;
@@ -1168,9 +1237,15 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
        u8 *pArgs = NULL;
        struct DSP_NODEATTRIN attrIn, *pAttrIn = NULL;
        struct NODE_OBJECT *hNode;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Allocate: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor) {
+               status =  DSP_EHANDLE;
+               goto func_cont;
+       }
+
        /* Optional argument */
        if (pSize) {
                if (get_user(cbDataSize, pSize))
@@ -1504,10 +1579,14 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct DSP_UUID nodeId;
        struct DSP_NDBPROPS    *pnodeProps = NULL;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_GetUUIDPropste: entered\n");

+       if (args->ARGS_PROC_CTRL.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
        if (DSP_FAILED(status))
                goto func_cont;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bf89ad0..4af2f3d 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -528,42 +528,38 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
                 "Entered PROC_Ctrl, args:\n\thProcessor:"
                 " 0x%x\n\tdwCmd: 0x%x\n\targ: 0x%x\n", hProcessor, dwCmd, arg);

-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               /* intercept PWR deep sleep command */
-               if (dwCmd == WMDIOCTL_DEEPSLEEP) {
-                       timeout = arg->cbData;
-                       status = PWR_SleepDSP(PWR_DEEPSLEEP, timeout);
-               }
-               /* intercept PWR emergency sleep command */
-               else if (dwCmd == WMDIOCTL_EMERGENCYSLEEP) {
-                       timeout = arg->cbData;
-                       status = PWR_SleepDSP(PWR_EMERGENCYDEEPSLEEP, timeout);
-               } else if (dwCmd == PWR_DEEPSLEEP) {
-                       /* timeout = arg->cbData; */
-                       status = PWR_SleepDSP(PWR_DEEPSLEEP, timeout);
-               }
-               /* intercept PWR wake commands */
-               else if (dwCmd == WMDIOCTL_WAKEUP) {
-                       timeout = arg->cbData;
-                       status = PWR_WakeDSP(timeout);
-               } else if (dwCmd == PWR_WAKEUP) {
-                       /* timeout = arg->cbData; */
-                       status = PWR_WakeDSP(timeout);
-               } else
-                   if (DSP_SUCCEEDED
-                       ((*pProcObject->pIntfFxns->pfnDevCntrl)
-                               (pProcObject->hWmdContext, dwCmd, arg))) {
-                       status = DSP_SOK;
-               } else {
-                       status = DSP_EFAIL;
-                       GT_0trace(PROC_DebugMask, GT_7CLASS,
-                                "PROC_Ctrl: Failed \n");
-               }
+
+       /* intercept PWR deep sleep command */
+       if (dwCmd == WMDIOCTL_DEEPSLEEP) {
+               timeout = arg->cbData;
+               status = PWR_SleepDSP(PWR_DEEPSLEEP, timeout);
+       }
+       /* intercept PWR emergency sleep command */
+       else if (dwCmd == WMDIOCTL_EMERGENCYSLEEP) {
+               timeout = arg->cbData;
+               status = PWR_SleepDSP(PWR_EMERGENCYDEEPSLEEP, timeout);
+       } else if (dwCmd == PWR_DEEPSLEEP) {
+               /* timeout = arg->cbData; */
+               status = PWR_SleepDSP(PWR_DEEPSLEEP, timeout);
+       }
+       /* intercept PWR wake commands */
+       else if (dwCmd == WMDIOCTL_WAKEUP) {
+               timeout = arg->cbData;
+               status = PWR_WakeDSP(timeout);
+       } else if (dwCmd == PWR_WAKEUP) {
+               /* timeout = arg->cbData; */
+               status = PWR_WakeDSP(timeout);
+       } else
+           if (DSP_SUCCEEDED
+               ((*pProcObject->pIntfFxns->pfnDevCntrl)
+                       (pProcObject->hWmdContext, dwCmd, arg))) {
+               status = DSP_SOK;
        } else {
-               status = DSP_EHANDLE;
+               status = DSP_EFAIL;
                GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_Ctrl: InValid Processor Handle \n");
+                        "PROC_Ctrl: Failed \n");
        }
+
        GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Ctrl, 0x%x\n",
                 status);
        return status;
@@ -587,28 +583,23 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
                "pr_ctxt->phProcessor:  0x%x\n", *pProcObject);

-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               /* Notify the Client */
-               NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
-               /* Remove the notification memory */
-               if (pProcObject->hNtfy)
-                       NTFY_Delete(pProcObject->hNtfy);
+       /* Notify the Client */
+       NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
+       /* Remove the notification memory */
+       if (pProcObject->hNtfy)
+               NTFY_Delete(pProcObject->hNtfy);

-               if (pProcObject->g_pszLastCoff) {
-                       MEM_Free(pProcObject->g_pszLastCoff);
-                       pProcObject->g_pszLastCoff = NULL;
-               }
-               /* Remove the Proc from the DEV List */
-               (void)DEV_RemoveProcObject(pProcObject->hDevObject,
-                       (u32)pProcObject);
-               /* Free the Processor Object */
-               MEM_FreeObject(pProcObject);
-               pr_ctxt->hProcessor = NULL;
-       } else {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_Detach: InValid Processor Handle \n");
+       if (pProcObject->g_pszLastCoff) {
+               MEM_Free(pProcObject->g_pszLastCoff);
+               pProcObject->g_pszLastCoff = NULL;
        }
+       /* Remove the Proc from the DEV List */
+       (void)DEV_RemoveProcObject(pProcObject->hDevObject,
+               (u32)pProcObject);
+       /* Free the Processor Object */
+       MEM_FreeObject(pProcObject);
+       pr_ctxt->hProcessor = NULL;
+
        GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Detach, 0x%x\n",
                 status);
        return status;
@@ -638,21 +629,17 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
                        " 0x%x\n\t puNumNodes 0x%x\n\t puAllocated: 0x%x\n",
                        hProcessor, aNodeTab, uNodeTabSize, puNumNodes,
                        puAllocated);
-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               if (DSP_SUCCEEDED(DEV_GetNodeManager(pProcObject->hDevObject,
-                                &hNodeMgr))) {
-                       if (hNodeMgr) {
-                               status = NODE_EnumNodes(hNodeMgr, aNodeTab,
-                                                       uNodeTabSize,
-                                                       puNumNodes,
-                                                       puAllocated);
-                       }
+
+       if (DSP_SUCCEEDED(DEV_GetNodeManager(pProcObject->hDevObject,
+                        &hNodeMgr))) {
+               if (hNodeMgr) {
+                       status = NODE_EnumNodes(hNodeMgr, aNodeTab,
+                                               uNodeTabSize,
+                                               puNumNodes,
+                                               puAllocated);
                }
-       } else {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_EnumNodes: "
-                        "InValid Processor Handle \n");
        }
+
        GT_6trace(PROC_DebugMask, GT_ENTER, "Exit PROC_EnumNodes, args:\n\t"
                        "hProcessor:  0x%x\n\taNodeTab:  0x%x\n\tuNodeTabSize: "
                        " 0x%x\n\t puNumNodes 0x%x\n\t puAllocated: 0x%x\n\t "
@@ -701,7 +688,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 {
        /* Keep STATUS here for future additions to this function */
        DSP_STATUS status = DSP_SOK;
-       struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;

        DBC_Require(cRefs > 0);
        GT_5trace(PROC_DebugMask, GT_ENTER,
@@ -718,13 +704,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
        }
 #endif /* CONFIG_BRIDGE_CHECK_ALIGN_128 */

-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               GT_1trace(PROC_DebugMask, GT_7CLASS,
-                         "%s: InValid Processor Handle\n", __func__);
-               status = DSP_EHANDLE;
-               goto err_out;
-       }
-
        if (memory_check_vma((u32)pMpuAddr, ulSize)) {
                GT_3trace(PROC_DebugMask, GT_7CLASS,
                          "%s: InValid address parameters\n",
@@ -792,13 +771,7 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
                 "hProcessor:  0x%x\n\tuResourceType:  0x%x\n\tpResourceInfo:"
                 " 0x%x\n\t uResourceInfoSize 0x%x\n", hProcessor,
                 uResourceType, pResourceInfo, uResourceInfoSize);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_GetResourceInfo: InValid "
-                        "Processor Handle \n");
-               goto func_end;
-       }
+
        switch (uResourceType) {
        case DSP_RESOURCE_DYNDARAM:
        case DSP_RESOURCE_DYNSARAM:
@@ -875,13 +848,8 @@ DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
        DBC_Require(cRefs > 0);
        DBC_Require(phDevObject != NULL);

-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               *phDevObject = pProcObject->hDevObject;
-               status = DSP_SOK;
-       } else {
-               *phDevObject = NULL;
-               status = DSP_EHANDLE;
-       }
+       *phDevObject = pProcObject->hDevObject;
+       status = DSP_SOK;

        DBC_Ensure((DSP_SUCCEEDED(status) && *phDevObject != NULL) ||
                   (DSP_FAILED(status) && *phDevObject == NULL));
@@ -910,57 +878,53 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
        GT_3trace(PROC_DebugMask, GT_ENTER, "Entering PROC_GetState, args:\n\t"
                 "pProcStatus: 0x%x\n\thProcessor: 0x%x\n\t uStateInfoSize"
                 " 0x%x\n", pProcStatus, hProcessor, uStateInfoSize);
-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               /* First, retrieve BRD state information */
-               if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
-                  (pProcObject->hWmdContext, &brdStatus))) {
-                       switch (brdStatus) {
-                       case BRD_STOPPED:
-                               pProcStatus->iState = PROC_STOPPED;
-                               break;
-                       case BRD_DSP_HIBERNATION:
-                               /* Fall through */
-                       case BRD_RUNNING:
-                               pProcStatus->iState = PROC_RUNNING;
-                               break;
-                       case BRD_LOADED:
-                               pProcStatus->iState = PROC_LOADED;
-                               break;
-                       case BRD_ERROR:
-                               pProcStatus->iState = PROC_ERROR;
-                               break;
-                       default:
-                               pProcStatus->iState = 0xFF;
-                               status = DSP_EFAIL;
-                               break;
-                       }
-               } else {
+
+       /* First, retrieve BRD state information */
+       if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
+          (pProcObject->hWmdContext, &brdStatus))) {
+               switch (brdStatus) {
+               case BRD_STOPPED:
+                       pProcStatus->iState = PROC_STOPPED;
+                       break;
+               case BRD_DSP_HIBERNATION:
+                       /* Fall through */
+               case BRD_RUNNING:
+                       pProcStatus->iState = PROC_RUNNING;
+                       break;
+               case BRD_LOADED:
+                       pProcStatus->iState = PROC_LOADED;
+                       break;
+               case BRD_ERROR:
+                       pProcStatus->iState = PROC_ERROR;
+                       break;
+               default:
+                       pProcStatus->iState = 0xFF;
                        status = DSP_EFAIL;
-                       GT_0trace(PROC_DebugMask, GT_7CLASS,
-                                "PROC_GetState: General Failure"
-                                " to read the PROC Status \n");
+                       break;
                }
-               /* Next, retrieve error information, if any */
-               status = DEV_GetDehMgr(pProcObject->hDevObject, &hDehMgr);
-               if (DSP_SUCCEEDED(status) && hDehMgr) {
-                       status = (*pProcObject->pIntfFxns->pfnDehGetInfo)
-                                (hDehMgr, &(pProcStatus->errInfo));
-                       if (DSP_FAILED(status)) {
-                               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                                        "PROC_GetState: Failed "
-                                        "retrieve exception info.\n");
-                       }
-               } else {
-                       status = DSP_EFAIL;
+       } else {
+               status = DSP_EFAIL;
+               GT_0trace(PROC_DebugMask, GT_7CLASS,
+                        "PROC_GetState: General Failure"
+                        " to read the PROC Status \n");
+       }
+       /* Next, retrieve error information, if any */
+       status = DEV_GetDehMgr(pProcObject->hDevObject, &hDehMgr);
+       if (DSP_SUCCEEDED(status) && hDehMgr) {
+               status = (*pProcObject->pIntfFxns->pfnDehGetInfo)
+                        (hDehMgr, &(pProcStatus->errInfo));
+               if (DSP_FAILED(status)) {
                        GT_0trace(PROC_DebugMask, GT_7CLASS,
-                                "PROC_GetState: Failed to "
-                                "retrieve DEH handle.\n");
+                                "PROC_GetState: Failed "
+                                "retrieve exception info.\n");
                }
        } else {
-               status = DSP_EHANDLE;
+               status = DSP_EFAIL;
                GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_GetState:InValid Processor Handle \n");
+                        "PROC_GetState: Failed to "
+                        "retrieve DEH handle.\n");
        }
+
        GT_2trace(PROC_DebugMask, GT_ENTER,
                 "Exiting PROC_GetState, results:\n\t"
                 "status:  0x%x\n\tpProcStatus: 0x%x\n", status,
@@ -1065,12 +1029,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
        GT_2trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Load, args:\n\t"
                 "hProcessor:  0x%x\taArgv: 0x%x\n", hProcessor, aArgv[0]);
        /* Call the WMD_BRD_Load Fxn */
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_1CLASS,
-                        "PROC_Load: Invalid Processor Handle..\n");
-               goto func_end;
-       }
+
        if (pProcObject->bIsAlreadyAttached) {
                GT_0trace(PROC_DebugMask, GT_7CLASS,
                         "PROC_Load GPP "
@@ -1386,12 +1345,6 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
        GT_3trace(PROC_DebugMask, GT_ENTER, "PROC_Map: vaAlign %x, paAlign %x, "
                 "sizeAlign %x\n", vaAlign, paAlign, sizeAlign);

-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
-                        "InValid Processor Handle \n");
-               goto func_end;
-       }
        /* Critical section */
        (void)SYNC_EnterCS(hProcLock);
        status = DMM_GetHandle(pProcObject, &hDmmMgr);
@@ -1425,7 +1378,6 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
                                (u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
        }
 #endif
-func_end:
        GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
        return status;
 }
@@ -1452,14 +1404,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
                 " 0x%x\n\t hNotification 0x%x\n", hProcessor, uEventMask,
                 uNotifyType, hNotification);

-       /* Check processor handle */
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_1trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_RegsiterNotify Invalid "
-                        "ProcessorHandle 0x%x\n", hProcessor);
-               goto func_end;
-       }
        /* Check if event mask is a valid processor related event */
        if (uEventMask & ~(DSP_PROCESSORSTATECHANGE | DSP_PROCESSORATTACH |
           DSP_PROCESSORDETACH | DSP_PROCESSORRESTART | DSP_MMUFAULT |
@@ -1509,7 +1453,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,

                }
        }
-func_end:
        return status;
 }

@@ -1529,12 +1472,7 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
                 "Entered PROC_ReserveMemory, args:\n\t"
                 "hProcessor: 0x%x ulSize: 0x%x ppRsvAddr: 0x%x\n", hProcessor,
                 ulSize, ppRsvAddr);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
-                        "InValid Processor Handle \n");
-               goto func_end;
-       }
+
        status = DMM_GetHandle(pProcObject, &hDmmMgr);
        if (DSP_FAILED(status)) {
                GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
@@ -1544,7 +1482,6 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,

        GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
                 status);
-func_end:
        return status;
 }

@@ -1565,12 +1502,7 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
        DBC_Require(cRefs > 0);
        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Start, args:\n\t"
                 "hProcessor:  0x%x\n", hProcessor);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_Start :InValid Handle \n");
-               goto func_end;
-       }
+
        /* Call the WMD_BRD_Start */
        if (pProcObject->sState != PROC_LOADED) {
                GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1665,12 +1597,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
        DBC_Require(cRefs > 0);
        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Stop, args:\n\t"
                 "hProcessor:  0x%x\n", hProcessor);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_Stop :InValid Handle \n");
-               goto func_end;
-       }
+
        if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
           (pProcObject->hWmdContext, &uBrdState))) {
                if (uBrdState == BRD_ERROR)
@@ -1722,7 +1649,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
                GT_0trace(PROC_DebugMask, GT_7CLASS,
                         "PROC_Stop Failed to Stop the processor/device \n");
        }
-func_end:
+
        GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Stop, status  0x%x\n",
                 status);

@@ -1750,12 +1677,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
                 "0x%x pMapAddr: 0x%x\n", hProcessor, pMapAddr);

        vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-                        "InValid Processor Handle \n");
-               goto func_end;
-       }

        status = DMM_GetHandle(hProcessor, &hDmmMgr);
        if (DSP_FAILED(status)) {
@@ -1808,12 +1729,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
        GT_2trace(PROC_DebugMask, GT_ENTER,
                 "Entered PROC_UnReserveMemory, args:\n\t"
                 "hProcessor: 0x%x pRsvAddr: 0x%x\n", hProcessor, pRsvAddr);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-                        "InValid Processor Handle \n");
-               goto func_end;
-       }
+
        status = DMM_GetHandle(pProcObject, &hDmmMgr);
        if (DSP_FAILED(status))
                GT_1trace(PROC_DebugMask, GT_7CLASS,
@@ -1825,7 +1741,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
        GT_1trace(PROC_DebugMask, GT_ENTER,
                 "Leaving PROC_UnReserveMemory [0x%x]",
                 status);
-func_end:
+
        return status;
 }

@@ -1856,7 +1772,6 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 #endif

        DBC_Require(cRefs > 0);
-       DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));

        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Monitor, args:\n\t"
                 "hProcessor: 0x%x\n", hProcObject);
@@ -1956,20 +1871,13 @@ DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;

-       DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
        DBC_Require(IsValidProcEvent(uEvents));
        DBC_Require(cRefs > 0);
-       if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_NotifyClients: "
-                        "InValid Processor Handle \n");
-               goto func_end;
-       }

        NTFY_Notify(pProcObject->hNtfy, uEvents);
        GT_0trace(PROC_DebugMask, GT_1CLASS,
                 "PROC_NotifyClients :Signaled. \n");
-func_end:
+
        return status;
 }

--
1.5.4.5

