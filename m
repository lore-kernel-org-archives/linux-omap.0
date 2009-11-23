From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
Date: Mon, 23 Nov 2009 14:12:08 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA060084FBDD1D@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57932 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZKWUMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 15:12:06 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From f28ec22e48a9b61ac00b7711e035e117bdc71aeb Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Mon, 23 Nov 2009 12:16:45 -0600
Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid inputs.

Move the error checking to kernel to address usecases
accessing kernel API directly.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c                 |  263 +++++++++++++++++++++++--
 drivers/dsp/bridge/rmgr/proc.c                |   42 ----
 3 files changed, 249 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 3570171..2de5ab6 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -217,7 +217,8 @@
                DSP_DCDLIBRARYTYPE,
                DSP_DCDCREATELIBTYPE,
                DSP_DCDEXECUTELIBTYPE,
-               DSP_DCDDELETELIBTYPE
+               DSP_DCDDELETELIBTYPE,
+               DSP_MAXOBJTYPE = DSP_DCDDELETELIBTYPE
        } ;

 /* Processor states */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 306164f..30cae21 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -268,6 +268,41 @@ static inline void __cp_to_usr(void __user *to, const void *from,
        }
 }

+/* Check if the given area blongs to process virtul memory address space */
+static int memory_check_vma(void *start_addr, u32 len)
+{
+       int err = 0;
+       u32 end;
+       u32 start = (u32)start_addr;
+       struct vm_area_struct *vma;
+
+       end = start + len;
+       if (end <= start)
+               return -EINVAL;
+
+       down_read(&current->mm->mmap_sem);
+
+       while ((vma = find_vma(current->mm, start)) != NULL) {
+
+               if (vma->vm_start > start) {
+                       err = -EINVAL;
+                       break;
+               }
+
+               if (end <= vma->vm_end)
+                       break;
+
+               start = vma->vm_end;
+       }
+
+       if (!vma)
+               err = -EINVAL;
+
+       up_read(&current->mm->mmap_sem);
+
+       return err;
+}
+
 /*
  *  ======== WCD_CallDevIOCtl ========
  *  Purpose:
@@ -470,7 +505,7 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
        u8 *pNDBProps;
        u32 uNumNodes;
        DSP_STATUS status = DSP_SOK;
-       u32 size = args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize;
+       u32 size;

        GT_4trace(WCD_debugMask, GT_ENTER,
                 "MGR_EnumNodeInfo: entered args:\n0x%x"
@@ -479,6 +514,20 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_MGR_ENUMNODE_INFO.pNDBProps,
                 args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize,
                 args->ARGS_MGR_ENUMNODE_INFO.puNumNodes);
+
+       if (memory_check_vma(args->ARGS_MGR_ENUMNODE_INFO.pNDBProps,
+               sizeof(struct DSP_NDBPROPS)))
+               return DSP_EPOINTER;
+
+       if (memory_check_vma(args->ARGS_MGR_ENUMNODE_INFO.puNumNodes,
+               sizeof(u32)))
+               return DSP_EPOINTER;
+
+       size = args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize;
+
+       if (size < sizeof(struct DSP_NDBPROPS))
+               return DSP_ESIZE;
+
        pNDBProps = MEM_Alloc(size, MEM_NONPAGED);
        if (pNDBProps == NULL)
                status = DSP_EMEMORY;
@@ -506,7 +555,7 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
        u8 *pProcessorInfo;
        u32 uNumProcs;
        DSP_STATUS status = DSP_SOK;
-       u32 size = args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize;
+       u32 size;

        GT_4trace(WCD_debugMask, GT_ENTER,
                 "MGRWRAP_EnumProc_Info: entered args:\n"
@@ -516,6 +565,20 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_MGR_ENUMPROC_INFO.pProcessorInfo,
                 args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize,
                 args->ARGS_MGR_ENUMPROC_INFO.puNumProcs);
+
+       if (memory_check_vma(args->ARGS_MGR_ENUMPROC_INFO.pProcessorInfo,
+               sizeof(struct DSP_PROCESSORINFO)))
+               return DSP_EPOINTER;
+
+       if (memory_check_vma(args->ARGS_MGR_ENUMPROC_INFO.puNumProcs,
+               sizeof(u32)))
+               return DSP_EPOINTER;
+
+       size = args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize;
+
+       if (size < sizeof(struct DSP_PROCESSORINFO))
+               return DSP_ESIZE;
+
        pProcessorInfo = MEM_Alloc(size, MEM_NONPAGED);
        if (pProcessorInfo == NULL)
                status = DSP_EMEMORY;
@@ -548,6 +611,11 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
        char *pszPathName = NULL;
        DSP_STATUS status = DSP_SOK;

+
+       GT_1trace(WCD_debugMask, GT_ENTER,
+                "MGRWRAP_RegisterObject: entered "
+                "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
+
        cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
        if (DSP_FAILED(status))
                goto func_end;
@@ -565,9 +633,9 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
                goto func_end;
        }

-       GT_1trace(WCD_debugMask, GT_ENTER,
-                "MGRWRAP_RegisterObject: entered pg2hMsg "
-                "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
+       if (args->ARGS_MGR_REGISTEROBJECT.objType > DSP_MAXOBJTYPE)
+               return DSP_EINVALIDARG;
+
        status = DCD_RegisterObject(&pUuid,
                                args->ARGS_MGR_REGISTEROBJECT.objType,
                                (char *)pszPathName);
@@ -604,6 +672,9 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
        if (uCount > MAX_EVENTS)
                status = DSP_EINVALIDARG;

+       if (memory_check_vma(args->ARGS_MGR_WAIT.puIndex, sizeof(u32)))
+               return DSP_EPOINTER;
+
        /* get the array of pointers to user structures */
        cp_fm_usr(aNotifications, args->ARGS_MGR_WAIT.aNotifications,
         status, uCount);
@@ -662,6 +733,11 @@ u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ATTACH.uProcessor,
                 args->ARGS_PROC_ATTACH.pAttrIn,
                 args->ARGS_PROC_ATTACH.phProcessor);
+
+       if (memory_check_vma(args->ARGS_PROC_ATTACH.phProcessor,
+               sizeof(DSP_HPROCESSOR)))
+               return DSP_EHANDLE;
+
        /* Optional argument */
        if (args->ARGS_PROC_ATTACH.pAttrIn) {
                cp_fm_usr(&attrIn, args->ARGS_PROC_ATTACH.pAttrIn, status, 1);
@@ -756,11 +832,27 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize,
                 args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
                 args->ARGS_PROC_ENUMNODE_INFO.puAllocated);
-       DBC_Require(args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize <= MAX_NODES);
+
+       if (memory_check_vma(args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
+               sizeof(u32)))
+               return DSP_EPOINTER;
+
+       if (memory_check_vma(args->ARGS_PROC_ENUMNODE_INFO.puAllocated,
+               sizeof(u32)))
+               return DSP_EPOINTER;
+
+       if (!args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize)
+               return DSP_ESIZE;
+
        status = PROC_EnumNodes(args->ARGS_PROC_ENUMNODE_INFO.hProcessor,
                                aNodeTab,
                                args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize,
                                &uNumNodes, &uAllocated);
+
+       if (memory_check_vma(args->ARGS_PROC_ENUMNODE_INFO.aNodeTab,
+               sizeof(DSP_HNODE) * uNumNodes))
+               return DSP_EHANDLE;
+
        cp_to_usr(args->ARGS_PROC_ENUMNODE_INFO.aNodeTab, aNodeTab, status,
                 uNumNodes);
        cp_to_usr(args->ARGS_PROC_ENUMNODE_INFO.puNumNodes, &uNumNodes,
@@ -779,6 +871,13 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_FlushMemory: entered\n");

+       if (memory_check_vma(args->ARGS_PROC_FLUSHMEMORY.pMpuAddr,
+               args->ARGS_PROC_FLUSHMEMORY.ulSize))
+               return DSP_EPOINTER;
+
+       if (args->ARGS_PROC_FLUSHMEMORY.ulFlags > PROC_WRBK_INV_ALL)
+               return DSP_EINVALIDARG;
+
        status = PROC_FlushMemory(args->ARGS_PROC_FLUSHMEMORY.hProcessor,
                                 args->ARGS_PROC_FLUSHMEMORY.pMpuAddr,
                                 args->ARGS_PROC_FLUSHMEMORY.ulSize,
@@ -797,6 +896,10 @@ u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_InvalidateMemory:entered\n");

+       if (memory_check_vma(args->ARGS_PROC_INVALIDATEMEMORY.pMpuAddr,
+               args->ARGS_PROC_INVALIDATEMEMORY.ulSize))
+               return DSP_EPOINTER;
+
        status = PROC_InvalidateMemory(
                                  args->ARGS_PROC_INVALIDATEMEMORY.hProcessor,
                                  args->ARGS_PROC_INVALIDATEMEMORY.pMpuAddr,
@@ -813,9 +916,6 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct DSP_RESOURCEINFO pResourceInfo;

-       if (DSP_FAILED(status))
-               goto func_end;
-
        GT_4trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_EnumResources: entered args:\n"
                 "0x%x hProcessor: 0x%x\tuResourceMask: 0x%x\tpResourceInfo"
@@ -824,6 +924,15 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
                 args->ARGS_PROC_ENUMRESOURCES.uResourceType,
                 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
                 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
+
+       if (memory_check_vma(args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
+               sizeof(struct DSP_RESOURCEINFO)))
+               return DSP_EPOINTER;
+
+       if (args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize <
+               sizeof(struct DSP_RESOURCEINFO))
+               return DSP_ESIZE;
+
        status = PROC_GetResourceInfo(args->ARGS_PROC_ENUMRESOURCES.hProcessor,
                        args->ARGS_PROC_ENUMRESOURCES.uResourceType,
                        &pResourceInfo,
@@ -845,6 +954,15 @@ u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status;
        struct DSP_PROCESSORSTATE procStatus;
        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetState: entered\n");
+
+       if (memory_check_vma(args->ARGS_PROC_GETSTATE.pProcStatus,
+               sizeof(struct DSP_PROCESSORSTATE)))
+               return DSP_EPOINTER;
+
+       if (args->ARGS_PROC_GETSTATE.uStateInfoSize <
+               sizeof(struct DSP_PROCESSORSTATE))
+               return DSP_ESIZE;
+
        status = PROC_GetState(args->ARGS_PROC_GETSTATE.hProcessor, &procStatus,
                              args->ARGS_PROC_GETSTATE.uStateInfoSize);
        cp_to_usr(args->ARGS_PROC_GETSTATE.pProcStatus, &procStatus, status, 1);
@@ -862,7 +980,12 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetTrace: entered\n");

-       DBC_Require(args->ARGS_PROC_GETTRACE.uMaxSize <= MAX_TRACEBUFLEN);
+       if (args->ARGS_PROC_GETTRACE.uMaxSize > MAX_TRACEBUFLEN)
+               return DSP_ESIZE;
+
+       if (memory_check_vma(args->ARGS_PROC_GETTRACE.pBuf,
+               args->ARGS_PROC_GETTRACE.uMaxSize))
+               return DSP_EPOINTER;

        pBuf = MEM_Calloc(args->ARGS_PROC_GETTRACE.uMaxSize, MEM_NONPAGED);
        if (pBuf != NULL) {
@@ -890,8 +1013,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
        s32 count = args->ARGS_PROC_LOAD.iArgc;
        u8 **argv, **envp = NULL;

-       DBC_Require(count > 0);
-       DBC_Require(count <= MAX_LOADARGS);
+       if (count <= 0 || count > MAX_LOADARGS)
+               return DSP_EINVALIDARG;

        argv = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
        if (!argv) {
@@ -1007,6 +1130,18 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
        void *pMapAddr;

        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Map: entered\n");
+
+       if (!args->ARGS_PROC_MAPMEM.ulSize)
+               return DSP_ESIZE;
+
+       if (memory_check_vma(args->ARGS_PROC_MAPMEM.pMpuAddr,
+               args->ARGS_PROC_MAPMEM.ulSize))
+               return DSP_EPOINTER;
+
+       if (memory_check_vma(args->ARGS_PROC_MAPMEM.ppMapAddr,
+               sizeof(u32)))
+               return DSP_EPOINTER;
+
        status = PROC_Map(args->ARGS_PROC_MAPMEM.hProcessor,
                         args->ARGS_PROC_MAPMEM.pMpuAddr,
                         args->ARGS_PROC_MAPMEM.ulSize,
@@ -1031,6 +1166,10 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
        GT_0trace(WCD_debugMask, GT_ENTER,
                 "PROCWRAP_RegisterNotify: entered\n");

+       if (memory_check_vma(args->ARGS_PROC_REGISTER_NOTIFY.hNotification,
+               sizeof(struct DSP_NOTIFICATION)))
+               return DSP_EHANDLE;
+
        /* Initialize the notification data structure  */
        notification.psName = NULL;
        notification.handle = NULL;
@@ -1052,6 +1191,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status;
        void *pRsvAddr;

+       if (memory_check_vma(args->ARGS_PROC_RSVMEM.ppRsvAddr, sizeof(void *)))
+               return DSP_EPOINTER;
+
+       if ((args->ARGS_PROC_RSVMEM.ulSize <= 0) ||
+               (args->ARGS_PROC_RSVMEM.ulSize & (PG_SIZE_4K - 1)) != 0)
+               return DSP_ESIZE;
+
        GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
        status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
                                   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
@@ -1128,6 +1274,10 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Allocate: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_ALLOCATE.phNode,
+               sizeof(DSP_HNODE)))
+               return DSP_EPOINTER;
+
        /* Optional argument */
        if (pSize) {
                if (get_user(cbDataSize, pSize))
@@ -1178,6 +1328,13 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
        struct DSP_BUFFERATTR attr;
        u8 *pBuffer = NULL;

+       if (!args->ARGS_NODE_ALLOCMSGBUF.uSize)
+               return DSP_ESIZE;
+
+       if (memory_check_vma(args->ARGS_NODE_ALLOCMSGBUF.pBuffer,
+               sizeof(u8 *)))
+               return DSP_EPOINTER;
+
        if (args->ARGS_NODE_ALLOCMSGBUF.pAttr) {        /* Optional argument */
                cp_fm_usr(&attr, args->ARGS_NODE_ALLOCMSGBUF.pAttr, status, 1);
                if (DSP_SUCCEEDED(status))
@@ -1303,6 +1460,10 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)
                        pAttr = &attr;

        }
+
+       if (!args->ARGS_NODE_FREEMSGBUF.pBuffer)
+               return DSP_EPOINTER;
+
        if (DSP_SUCCEEDED(status)) {
                status = NODE_FreeMsgBuf(args->ARGS_NODE_FREEMSGBUF.hNode,
                                        args->ARGS_NODE_FREEMSGBUF.pBuffer,
@@ -1322,6 +1483,10 @@ u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetAttr: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_GETATTR.pAttr,
+               sizeof(struct DSP_NODEATTR)))
+               return DSP_EPOINTER;
+
        status = NODE_GetAttr(args->ARGS_NODE_GETATTR.hNode, &attr,
                             args->ARGS_NODE_GETATTR.uAttrSize);
        cp_to_usr(args->ARGS_NODE_GETATTR.pAttr, &attr, status, 1);
@@ -1339,6 +1504,10 @@ u32 NODEWRAP_GetMessage(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetMessage: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_GETMESSAGE.pMessage,
+               sizeof(struct DSP_MSG)))
+               return DSP_EPOINTER;
+
        status = NODE_GetMessage(args->ARGS_NODE_GETMESSAGE.hNode, &msg,
                                args->ARGS_NODE_GETMESSAGE.uTimeout);

@@ -1391,6 +1560,10 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_RegisterNotify: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_REGISTERNOTIFY.hNotification,
+               sizeof(struct DSP_NOTIFICATION)))
+               return DSP_EHANDLE;
+
        /* Initialize the notification data structure  */
        notification.psName = NULL;
        notification.handle = NULL;
@@ -1432,6 +1605,10 @@ u32 NODEWRAP_Terminate(union Trapped_Args *args, void *pr_ctxt)

        GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Terminate: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_TERMINATE.pStatus,
+               sizeof(DSP_STATUS)))
+               return DSP_EPOINTER;
+
        status = NODE_Terminate(args->ARGS_NODE_TERMINATE.hNode, &tempstatus);

        cp_to_usr(args->ARGS_NODE_TERMINATE.pStatus, &tempstatus, status, 1);
@@ -1452,6 +1629,9 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_GetUUIDPropste: entered\n");

+       if (memory_check_vma(args->ARGS_NODE_GETUUIDPROPS.pNodeProps,
+               sizeof(struct DSP_NDBPROPS)))
+               return DSP_EPOINTER;

        cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
        if (DSP_FAILED(status))
@@ -1480,7 +1660,11 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
        u8 **apBuffer = NULL;
        u32 uNumBufs = args->ARGS_STRM_ALLOCATEBUFFER.uNumBufs;

-       DBC_Require(uNumBufs <= MAX_BUFS);
+       if (uNumBufs > MAX_BUFS)
+               return DSP_EINVALIDARG;
+
+       if (memory_check_vma(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, uNumBufs))
+               return DSP_EPOINTER;

        apBuffer = MEM_Alloc((uNumBufs * sizeof(u8 *)), MEM_NONPAGED);

@@ -1512,7 +1696,11 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
        u8 **apBuffer = NULL;
        u32 uNumBufs = args->ARGS_STRM_FREEBUFFER.uNumBufs;

-       DBC_Require(uNumBufs <= MAX_BUFS);
+       if (uNumBufs > MAX_BUFS)
+               return DSP_EINVALIDARG;
+
+       if (memory_check_vma(args->ARGS_STRM_FREEBUFFER.apBuffer, uNumBufs))
+               return DSP_EPOINTER;

        apBuffer = MEM_Alloc((uNumBufs * sizeof(u8 *)), MEM_NONPAGED);

@@ -1550,6 +1738,10 @@ u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
        struct DSP_STREAMINFO *temp;

        cp_fm_usr(&strmInfo, args->ARGS_STRM_GETINFO.pStreamInfo, status, 1);
+
+       if (memory_check_vma(strmInfo.pUser, sizeof(struct DSP_STREAMINFO)))
+               return DSP_EPOINTER;
+
        temp = strmInfo.pUser;

        strmInfo.pUser = &user;
@@ -1583,6 +1775,10 @@ u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt)
 u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
+
+       if (!args->ARGS_STRM_ISSUE.pBuffer)
+               return DSP_EPOINTER;
+
        /* No need of doing cp_fm_usr for the user buffer (pBuffer)
        as this is done in Bridge internal function WMD_CHNL_AddIOReq
        in chnl_sm.c */
@@ -1605,12 +1801,19 @@ u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
        struct STRM_OBJECT *pStrm;
        struct DSP_STREAMATTRIN strmAttrIn;

+       if (memory_check_vma(args->ARGS_STRM_OPEN.phStream,
+               sizeof(DSP_HSTREAM)))
+               return DSP_EPOINTER;
+
        cp_fm_usr(&attr, args->ARGS_STRM_OPEN.pAttrIn, status, 1);

        if (attr.pStreamAttrIn != NULL) {       /* Optional argument */
                cp_fm_usr(&strmAttrIn, attr.pStreamAttrIn, status, 1);
-               if (DSP_SUCCEEDED(status))
+               if (DSP_SUCCEEDED(status)) {
                        attr.pStreamAttrIn = &strmAttrIn;
+                       if (attr.pStreamAttrIn->lMode == STRMMODE_LDMA)
+                               return DSP_ENOTIMPL;
+               }

        }
        status = STRM_Open(args->ARGS_STRM_OPEN.hNode,
@@ -1632,6 +1835,18 @@ u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt)
        u32 dwArg;
        u32 ulBufSize;

+       if (memory_check_vma(args->ARGS_STRM_RECLAIM.pBufPtr,
+               sizeof(args->ARGS_STRM_RECLAIM.pBufPtr)))
+               return DSP_EPOINTER;
+       if (memory_check_vma(args->ARGS_STRM_RECLAIM.pBytes, sizeof(u32 *)))
+               return DSP_EPOINTER;
+       if (memory_check_vma(args->ARGS_STRM_RECLAIM.pdwArg, sizeof(u32 *)))
+               return DSP_EPOINTER;
+       if (args->ARGS_STRM_RECLAIM.pBufSize != NULL)
+               if (memory_check_vma(args->ARGS_STRM_RECLAIM.pBufSize,
+                       sizeof(u32 *)))
+                       return DSP_EPOINTER;
+
        status = STRM_Reclaim(args->ARGS_STRM_RECLAIM.hStream, &pBufPtr,
                             &ulBytes, &ulBufSize, &dwArg);
        cp_to_usr(args->ARGS_STRM_RECLAIM.pBufPtr, &pBufPtr, status, 1);
@@ -1657,6 +1872,10 @@ u32 STRMWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
        GT_0trace(WCD_debugMask, GT_ENTER,
                 "NODEWRAP_RegisterNotify: entered\n");

+       if (memory_check_vma(args->ARGS_STRM_REGISTERNOTIFY.hNotification,
+               sizeof(struct DSP_NOTIFICATION)))
+               return DSP_EHANDLE;
+
        /* Initialize the notification data structure  */
        notification.psName = NULL;
        notification.handle = NULL;
@@ -1680,7 +1899,11 @@ u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
        struct STRM_OBJECT *aStrmTab[MAX_STREAMS];
        DSP_STATUS status = DSP_SOK;

-       DBC_Require(args->ARGS_STRM_SELECT.nStreams <= MAX_STREAMS);
+       if (args->ARGS_STRM_SELECT.nStreams > MAX_STREAMS)
+               return DSP_EINVALIDARG;
+
+       if (memory_check_vma(args->ARGS_STRM_SELECT.pMask, sizeof(u32)))
+               return DSP_EPOINTER;

        cp_fm_usr(aStrmTab, args->ARGS_STRM_SELECT.aStreamTab, status,
                 args->ARGS_STRM_SELECT.nStreams);
@@ -1720,6 +1943,10 @@ u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct CMM_OBJECT *hCmmMgr;

+       if (memory_check_vma(args->ARGS_CMM_GETHANDLE.phCmmMgr,
+               sizeof(args->ARGS_CMM_GETHANDLE.phCmmMgr)))
+               return DSP_EPOINTER;
+
        status = CMM_GetHandle(args->ARGS_CMM_GETHANDLE.hProcessor, &hCmmMgr);

        cp_to_usr(args->ARGS_CMM_GETHANDLE.phCmmMgr, &hCmmMgr, status, 1);
@@ -1735,6 +1962,10 @@ u32 CMMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK;
        struct CMM_INFO cmmInfo;

+       if (memory_check_vma(args->ARGS_CMM_GETINFO.pCmmInfo,
+               sizeof(struct CMM_INFO)))
+               return DSP_EPOINTER;
+
        status = CMM_GetInfo(args->ARGS_CMM_GETINFO.hCmmMgr, &cmmInfo);

        cp_to_usr(args->ARGS_CMM_GETINFO.pCmmInfo, &cmmInfo, status, 1);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bf89ad0..f2330df 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -662,40 +662,6 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
        return status;
 }

-/* Check if the given area blongs to process virtul memory address space */
-static int memory_check_vma(unsigned long start, u32 len)
-{
-       int err = 0;
-       unsigned long end;
-       struct vm_area_struct *vma;
-
-       end = start + len;
-       if (end <= start)
-               return -EINVAL;
-
-       down_read(&current->mm->mmap_sem);
-
-       while ((vma = find_vma(current->mm, start)) != NULL) {
-
-               if (vma->vm_start > start) {
-                       err = -EINVAL;
-                       break;
-               }
-
-               if (end <= vma->vm_end)
-                       break;
-
-               start = vma->vm_end;
-       }
-
-       if (!vma)
-               err = -EINVAL;
-
-       up_read(&current->mm->mmap_sem);
-
-       return err;
-}
-
 static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
                                   u32 ulSize, u32 ulFlags)
 {
@@ -725,14 +691,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
                goto err_out;
        }

-       if (memory_check_vma((u32)pMpuAddr, ulSize)) {
-               GT_3trace(PROC_DebugMask, GT_7CLASS,
-                         "%s: InValid address parameters\n",
-                         __func__, pMpuAddr, ulSize);
-               status = DSP_EHANDLE;
-               goto err_out;
-       }
-
        (void)SYNC_EnterCS(hProcLock);
        MEM_FlushCache(pMpuAddr, ulSize, ulFlags);
        (void)SYNC_LeaveCS(hProcLock);
--
1.5.4.5

