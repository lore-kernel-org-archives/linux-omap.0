From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Validate Processor Handle from user
Date: Tue, 9 Feb 2010 11:07:16 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C89E954@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44939 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927Ab0BIRHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:07:22 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>

>From 07b9f6d30c9d363ba0c4cefded8068662e1048c4 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 3 Feb 2010 19:43:31 -0600
Subject: [PATCH] DSPBRIDGE: Validate Processor Handle from user.

Add check to validate the Processor handle received
from user.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |   86 ++++++++++++-
 drivers/dsp/bridge/rmgr/proc.c |  280 ++++++++++++++--------------------------
 2 files changed, 179 insertions(+), 187 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 78c7acd..020abbc 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -608,6 +608,7 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
                        args->ARGS_PROC_CTRL.pArgs;
        u8 *pArgs = NULL;
        DSP_STATUS status = DSP_SOK;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_3trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_Ctrl: entered args:\n 0x%x"
@@ -615,6 +616,10 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
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
@@ -669,6 +674,7 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
        DSP_HNODE aNodeTab[MAX_NODES];
        u32 uNumNodes;
        u32 uAllocated;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_5trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_EnumNode_Info:entered args:\n0x"
@@ -680,6 +686,9 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
                 args->ARGS_PROC_ENUMNODE_INFO.puAllocated);

+       if (args->ARGS_PROC_ENUMNODE_INFO.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (!args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize)
                return DSP_ESIZE;

@@ -702,9 +711,13 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_FlushMemory: entered\n");

+       if (args->ARGS_PROC_FLUSHMEMORY.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_FLUSHMEMORY.ulFlags > PROC_WRBK_INV_ALL)
                return DSP_EINVALIDARG;

@@ -722,10 +735,14 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_InvalidateMemory:entered\n");

+       if (args->ARGS_PROC_INVALIDATEMEMORY.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_InvalidateMemory(
                                  args->ARGS_PROC_INVALIDATEMEMORY.hProcessor,
                                  args->ARGS_PROC_INVALIDATEMEMORY.pMpuAddr,
@@ -741,6 +758,7 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_RESOURCEINFO pResourceInfo;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_4trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_EnumResources: entered args:\n"
@@ -751,6 +769,9 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
                 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);

+       if (args->ARGS_PROC_ENUMRESOURCES.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize <
                sizeof(struct DSP_RESOURCEINFO))
                return DSP_ESIZE;
@@ -774,8 +795,13 @@ u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_PROCESSORSTATE procStatus;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetState: entered\n");

+       if (args->ARGS_PROC_GETSTATE.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_GETSTATE.uStateInfoSize <
                sizeof(struct DSP_PROCESSORSTATE))
                return DSP_ESIZE;
@@ -794,9 +820,13 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        u8 *pBuf;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetTrace: entered\n");

+       if (args->ARGS_PROC_GETTRACE.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (args->ARGS_PROC_GETTRACE.uMaxSize > MAX_TRACEBUFLEN)
                return DSP_ESIZE;

@@ -825,6 +855,12 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
        char *temp;
        s32 count = args->ARGS_PROC_LOAD.iArgc;
        u8 **argv = NULL, **envp = NULL;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
+       if (args->ARGS_PROC_LOAD.hProcessor != pCtxt->hProcessor) {
+               status = DSP_EHANDLE;
+               goto func_cont;
+       }

        if (count <= 0 || count > MAX_LOADARGS) {
                status = DSP_EINVALIDARG;
@@ -943,9 +979,13 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pMapAddr;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Map: entered\n");

+       if (args->ARGS_PROC_MAPMEM.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        if (!args->ARGS_PROC_MAPMEM.ulSize)
                return DSP_ESIZE;

@@ -972,10 +1012,14 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_NOTIFICATION notification;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_RegisterNotify: entered\n");

+       if (args->ARGS_PROC_REGISTER_NOTIFY.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        /* Initialize the notification data structure  */
        notification.psName = NULL;
        notification.handle = NULL;
@@ -996,12 +1040,17 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pRsvAddr;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
+       GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
+
+       if (args->ARGS_PROC_RSVMEM.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;

        if ((args->ARGS_PROC_RSVMEM.ulSize <= 0) ||
                (args->ARGS_PROC_RSVMEM.ulSize & (PG_SIZE_4K - 1)) != 0)
                return DSP_ESIZE;

-       GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
        status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
                                   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
        if (DSP_SUCCEEDED(status)) {
@@ -1020,8 +1069,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Start: entered\n");
+
+       if (args->ARGS_PROC_START.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        retVal = PROC_Start(args->ARGS_PROC_START.hProcessor);
        return retVal;
 }
@@ -1032,8 +1086,13 @@ u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_UnMap: entered\n");
+
+       if (args->ARGS_PROC_UNMAPMEM.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_UnMap(args->ARGS_PROC_UNMAPMEM.hProcessor,
                           args->ARGS_PROC_UNMAPMEM.pMapAddr, pr_ctxt);
        return status;
@@ -1045,9 +1104,14 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_UnReserveMemory: entered\n");
+
+       if (args->ARGS_PROC_UNRSVMEM.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        status = PROC_UnReserveMemory(args->ARGS_PROC_UNRSVMEM.hProcessor,
                                     args->ARGS_PROC_UNRSVMEM.pRsvAddr);
        return status;
@@ -1059,8 +1123,13 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Stop: entered\n");
+
+       if (args->ARGS_PROC_STOP.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        retVal = PROC_Stop(args->ARGS_PROC_STOP.hProcessor);

        return retVal;
@@ -1096,9 +1165,15 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
        u8 *pArgs = NULL;
        struct DSP_NODEATTRIN attrIn, *pAttrIn = NULL;
        struct NODE_OBJECT *hNode;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Allocate: entered\n");

+       if (args->ARGS_NODE_ALLOCATE.hProcessor != pCtxt->hProcessor) {
+               status =  DSP_EHANDLE;
+               goto func_cont;
+       }
+
        /* Optional argument */
        if (pSize) {
                if (get_user(cbDataSize, pSize))
@@ -1495,10 +1570,14 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct DSP_UUID nodeId;
        struct DSP_NDBPROPS    *pnodeProps = NULL;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_GetUUIDPropste: entered\n");

+       if (args->ARGS_NODE_GETUUIDPROPS.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;
+
        cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
        if (DSP_FAILED(status))
                goto func_cont;
@@ -1829,6 +1908,11 @@ u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct CMM_OBJECT *hCmmMgr;
+       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
+
+       if (args->ARGS_CMM_GETHANDLE.hProcessor &&
+               args->ARGS_CMM_GETHANDLE.hProcessor != pCtxt->hProcessor)
+               return DSP_EHANDLE;

        status = CMM_GetHandle(args->ARGS_CMM_GETHANDLE.hProcessor, &hCmmMgr);

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 4187d72..a1d06dc 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -443,42 +443,38 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
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
@@ -500,28 +496,23 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)

        pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;

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
@@ -551,21 +542,17 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
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
@@ -614,7 +601,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 {
        /* Keep STATUS here for future additions to this function */
        DSP_STATUS status = DSP_SOK;
-       struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;

        DBC_Require(cRefs > 0);
        GT_5trace(PROC_DebugMask, GT_ENTER,
@@ -631,13 +617,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
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
@@ -705,13 +684,7 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
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
@@ -790,13 +763,8 @@ DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
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
@@ -825,37 +793,37 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
        GT_3trace(PROC_DebugMask, GT_ENTER, "Entering PROC_GetState, args:\n\t"
                 "pProcStatus: 0x%x\n\thProcessor: 0x%x\n\t uStateInfoSize"
                 " 0x%x\n", pProcStatus, hProcessor, uStateInfoSize);
-       if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-               /* First, retrieve BRD state information */
-               status = (*pProcObject->pIntfFxns->pfnBrdStatus)
-                                  (pProcObject->hWmdContext, &brdStatus);
-               if (DSP_SUCCEEDED(status)) {
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
-                       GT_0trace(PROC_DebugMask, GT_7CLASS,
-                                "PROC_GetState: General Failure"
-                                " to read the PROC Status \n");
+
+       /* First, retrieve BRD state information */
+       status = (*pProcObject->pIntfFxns->pfnBrdStatus)
+                          (pProcObject->hWmdContext, &brdStatus);
+       if (DSP_SUCCEEDED(status)) {
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
+                       status = DSP_EFAIL;
                }
-               /* Next, retrieve error information, if any */
+       } else {
+               GT_0trace(PROC_DebugMask, GT_7CLASS,
+                        "PROC_GetState: General Failure"
+                        " to read the PROC Status \n");
+       }
+       /* Next, retrieve error information, if any */
+       if (DSP_SUCCEEDED(status)) {
                status = DEV_GetDehMgr(pProcObject->hDevObject, &hDehMgr);
                if (DSP_SUCCEEDED(status) && hDehMgr) {
                        status = (*pProcObject->pIntfFxns->pfnDehGetInfo)
@@ -870,10 +838,6 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
                                 "PROC_GetState: Failed to "
                                 "retrieve DEH handle.\n");
                }
-       } else {
-               status = DSP_EHANDLE;
-               GT_0trace(PROC_DebugMask, GT_7CLASS,
-                        "PROC_GetState:InValid Processor Handle \n");
        }
        GT_2trace(PROC_DebugMask, GT_ENTER,
                 "Exiting PROC_GetState, results:\n\t"
@@ -979,12 +943,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
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
@@ -1286,12 +1245,6 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
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
@@ -1323,7 +1276,6 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
                DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
                                (u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
        }
-func_end:
        GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
        return status;
 }
@@ -1350,14 +1302,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
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
@@ -1405,7 +1349,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,

                }
        }
-func_end:
        return status;
 }

@@ -1425,12 +1368,7 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
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
@@ -1440,7 +1378,6 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,

        GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
                 status);
-func_end:
        return status;
 }

@@ -1461,12 +1398,7 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
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
@@ -1557,12 +1489,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
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
@@ -1614,7 +1541,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
                GT_0trace(PROC_DebugMask, GT_7CLASS,
                         "PROC_Stop Failed to Stop the processor/device \n");
        }
-func_end:
+
        GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Stop, status  0x%x\n",
                 status);

@@ -1642,12 +1569,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
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
@@ -1698,12 +1619,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
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
@@ -1715,7 +1631,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
        GT_1trace(PROC_DebugMask, GT_ENTER,
                 "Leaving PROC_UnReserveMemory [0x%x]",
                 status);
-func_end:
+
        return status;
 }

@@ -1746,7 +1662,6 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 #endif

        DBC_Require(cRefs > 0);
-       DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));

        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Monitor, args:\n\t"
                 "hProcessor: 0x%x\n", hProcObject);
@@ -1846,20 +1761,13 @@ DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
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

