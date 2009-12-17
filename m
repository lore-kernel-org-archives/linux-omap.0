From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCHv3 1/3] DSPBRIDGE: Interface tightening to check for invalid
 input
Date: Wed, 16 Dec 2009 19:28:39 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008B7694A9@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55411 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934817AbZLQB2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 20:28:42 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBH1SegF022491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:28:41 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBH1SecH026970
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:28:40 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBH1SeGd012240
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:28:40 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From b55f8999690d6502d82b61fe2854d9f0e32cf8be Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 16 Dec 2009 16:20:11 -0600
Subject: [PATCHv3 1/3] DSPBRIDGE: Interface tightening to check for invalid input parameters.

Add more error checking and range to address usecases
accessing kernel API directly.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    4 +-
 drivers/dsp/bridge/pmgr/wcd.c                 |   90 +++++++++++++++++++-----
 drivers/dsp/bridge/services/mem.c             |    4 -
 3 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 3570171..6c78c8f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -217,7 +217,9 @@
 		DSP_DCDLIBRARYTYPE,
 		DSP_DCDCREATELIBTYPE,
 		DSP_DCDEXECUTELIBTYPE,
-		DSP_DCDDELETELIBTYPE
+		DSP_DCDDELETELIBTYPE,
+		DSP_DCDMAXOBJTYPE	/* Don't add enum values after this */
+					/* it should the last DCD object type */
 	} ;
 
 /* Processor states */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index dc65f07..ab18740 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -479,6 +479,10 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 		 args->ARGS_MGR_ENUMNODE_INFO.pNDBProps,
 		 args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize,
 		 args->ARGS_MGR_ENUMNODE_INFO.puNumNodes);
+
+	if (size < sizeof(struct DSP_NDBPROPS))
+		return DSP_ESIZE;
+
 	pNDBProps = MEM_Alloc(size, MEM_NONPAGED);
 	if (pNDBProps == NULL)
 		status = DSP_EMEMORY;
@@ -516,6 +520,10 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 		 args->ARGS_MGR_ENUMPROC_INFO.pProcessorInfo,
 		 args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize,
 		 args->ARGS_MGR_ENUMPROC_INFO.puNumProcs);
+
+	if (size < sizeof(struct DSP_PROCESSORINFO))
+		return DSP_ESIZE;
+
 	pProcessorInfo = MEM_Alloc(size, MEM_NONPAGED);
 	if (pProcessorInfo == NULL)
 		status = DSP_EMEMORY;
@@ -548,6 +556,11 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 	char *pszPathName = NULL;
 	DSP_STATUS status = DSP_SOK;
 
+
+	GT_1trace(WCD_debugMask, GT_ENTER,
+		 "MGRWRAP_RegisterObject: entered "
+		 "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
+
 	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -565,9 +578,9 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 		goto func_end;
 	}
 
-	GT_1trace(WCD_debugMask, GT_ENTER,
-		 "MGRWRAP_RegisterObject: entered pg2hMsg "
-		 "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
+	if (args->ARGS_MGR_REGISTEROBJECT.objType >= DSP_DCDMAXOBJTYPE)
+		return DSP_EINVALIDARG;
+
 	status = DCD_RegisterObject(&pUuid,
 				args->ARGS_MGR_REGISTEROBJECT.objType,
 				(char *)pszPathName);
@@ -756,7 +769,10 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 		 args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize,
 		 args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
 		 args->ARGS_PROC_ENUMNODE_INFO.puAllocated);
-	DBC_Require(args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize <= MAX_NODES);
+
+	if (!args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize)
+		return DSP_ESIZE;
+
 	status = PROC_EnumNodes(args->ARGS_PROC_ENUMNODE_INFO.hProcessor,
 				aNodeTab,
 				args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize,
@@ -779,6 +795,9 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_FlushMemory: entered\n");
 
+	if (args->ARGS_PROC_FLUSHMEMORY.ulFlags > PROC_WRBK_INV_ALL)
+		return DSP_EINVALIDARG;
+
 	status = PROC_FlushMemory(args->ARGS_PROC_FLUSHMEMORY.hProcessor,
 				 args->ARGS_PROC_FLUSHMEMORY.pMpuAddr,
 				 args->ARGS_PROC_FLUSHMEMORY.ulSize,
@@ -813,9 +832,6 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_RESOURCEINFO pResourceInfo;
 
-	if (DSP_FAILED(status))
-		goto func_end;
-
 	GT_4trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_EnumResources: entered args:\n"
 		 "0x%x hProcessor: 0x%x\tuResourceMask: 0x%x\tpResourceInfo"
@@ -824,15 +840,19 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 		 args->ARGS_PROC_ENUMRESOURCES.uResourceType,
 		 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
 		 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
+
+	if (args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize <
+		sizeof(struct DSP_RESOURCEINFO))
+		return DSP_ESIZE;
+
 	status = PROC_GetResourceInfo(args->ARGS_PROC_ENUMRESOURCES.hProcessor,
 			args->ARGS_PROC_ENUMRESOURCES.uResourceType,
 			&pResourceInfo,
 			args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
-	if (DSP_FAILED(status))
-		goto func_end;
+
 	cp_to_usr(args->ARGS_PROC_ENUMRESOURCES.pResourceInfo, &pResourceInfo,
 						status, 1);
-func_end:
+
 	return status;
 
 }
@@ -845,6 +865,11 @@ u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	struct DSP_PROCESSORSTATE procStatus;
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetState: entered\n");
+
+	if (args->ARGS_PROC_GETSTATE.uStateInfoSize <
+		sizeof(struct DSP_PROCESSORSTATE))
+		return DSP_ESIZE;
+
 	status = PROC_GetState(args->ARGS_PROC_GETSTATE.hProcessor, &procStatus,
 			      args->ARGS_PROC_GETSTATE.uStateInfoSize);
 	cp_to_usr(args->ARGS_PROC_GETSTATE.pProcStatus, &procStatus, status, 1);
@@ -862,7 +887,8 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetTrace: entered\n");
 
-	DBC_Require(args->ARGS_PROC_GETTRACE.uMaxSize <= MAX_TRACEBUFLEN);
+	if (args->ARGS_PROC_GETTRACE.uMaxSize > MAX_TRACEBUFLEN)
+		return DSP_ESIZE;
 
 	pBuf = MEM_Calloc(args->ARGS_PROC_GETTRACE.uMaxSize, MEM_NONPAGED);
 	if (pBuf != NULL) {
@@ -888,10 +914,12 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	char *temp;
 	s32 count = args->ARGS_PROC_LOAD.iArgc;
-	u8 **argv, **envp = NULL;
+	u8 **argv = NULL, **envp = NULL;
 
-	DBC_Require(count > 0);
-	DBC_Require(count <= MAX_LOADARGS);
+	if (count <= 0 || count > MAX_LOADARGS) {
+		status = DSP_EINVALIDARG;
+		goto func_cont;
+	}
 
 	argv = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
 	if (!argv) {
@@ -1007,6 +1035,10 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 	void *pMapAddr;
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Map: entered\n");
+
+	if (!args->ARGS_PROC_MAPMEM.ulSize)
+		return DSP_ESIZE;
+
 	status = PROC_Map(args->ARGS_PROC_MAPMEM.hProcessor,
 			 args->ARGS_PROC_MAPMEM.pMpuAddr,
 			 args->ARGS_PROC_MAPMEM.ulSize,
@@ -1052,6 +1084,10 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	void *pRsvAddr;
 
+	if ((args->ARGS_PROC_RSVMEM.ulSize <= 0) ||
+		(args->ARGS_PROC_RSVMEM.ulSize & (PG_SIZE_4K - 1)) != 0)
+		return DSP_ESIZE;
+
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
 	status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
 				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
@@ -1178,6 +1214,9 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 	struct DSP_BUFFERATTR attr;
 	u8 *pBuffer = NULL;
 
+	if (!args->ARGS_NODE_ALLOCMSGBUF.uSize)
+		return DSP_ESIZE;
+
 	if (args->ARGS_NODE_ALLOCMSGBUF.pAttr) {	/* Optional argument */
 		cp_fm_usr(&attr, args->ARGS_NODE_ALLOCMSGBUF.pAttr, status, 1);
 		if (DSP_SUCCEEDED(status))
@@ -1303,6 +1342,10 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 			pAttr = &attr;
 
 	}
+
+	if (!args->ARGS_NODE_FREEMSGBUF.pBuffer)
+		return DSP_EPOINTER;
+
 	if (DSP_SUCCEEDED(status)) {
 		status = NODE_FreeMsgBuf(args->ARGS_NODE_FREEMSGBUF.hNode,
 					args->ARGS_NODE_FREEMSGBUF.pBuffer,
@@ -1452,7 +1495,6 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
 	GT_0trace(WCD_debugMask, GT_ENTER,
 		 "NODEWRAP_GetUUIDPropste: entered\n");
 
-
 	cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
 	if (DSP_FAILED(status))
 		goto func_cont;
@@ -1480,7 +1522,8 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 	u8 **apBuffer = NULL;
 	u32 uNumBufs = args->ARGS_STRM_ALLOCATEBUFFER.uNumBufs;
 
-	DBC_Require(uNumBufs <= MAX_BUFS);
+	if (uNumBufs > MAX_BUFS)
+		return DSP_EINVALIDARG;
 
 	apBuffer = MEM_Alloc((uNumBufs * sizeof(u8 *)), MEM_NONPAGED);
 
@@ -1512,7 +1555,8 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 	u8 **apBuffer = NULL;
 	u32 uNumBufs = args->ARGS_STRM_FREEBUFFER.uNumBufs;
 
-	DBC_Require(uNumBufs <= MAX_BUFS);
+	if (uNumBufs > MAX_BUFS)
+		return DSP_EINVALIDARG;
 
 	apBuffer = MEM_Alloc((uNumBufs * sizeof(u8 *)), MEM_NONPAGED);
 
@@ -1583,6 +1627,10 @@ u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt)
 u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
+
+	if (!args->ARGS_STRM_ISSUE.pBuffer)
+		return DSP_EPOINTER;
+
 	/* No need of doing cp_fm_usr for the user buffer (pBuffer)
 	as this is done in Bridge internal function WMD_CHNL_AddIOReq
 	in chnl_sm.c */
@@ -1609,8 +1657,11 @@ u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
 
 	if (attr.pStreamAttrIn != NULL) {	/* Optional argument */
 		cp_fm_usr(&strmAttrIn, attr.pStreamAttrIn, status, 1);
-		if (DSP_SUCCEEDED(status))
+		if (DSP_SUCCEEDED(status)) {
 			attr.pStreamAttrIn = &strmAttrIn;
+			if (attr.pStreamAttrIn->lMode == STRMMODE_LDMA)
+				return DSP_ENOTIMPL;
+		}
 
 	}
 	status = STRM_Open(args->ARGS_STRM_OPEN.hNode,
@@ -1680,7 +1731,8 @@ u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
 	struct STRM_OBJECT *aStrmTab[MAX_STREAMS];
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(args->ARGS_STRM_SELECT.nStreams <= MAX_STREAMS);
+	if (args->ARGS_STRM_SELECT.nStreams > MAX_STREAMS)
+		return DSP_EINVALIDARG;
 
 	cp_fm_usr(aStrmTab, args->ARGS_STRM_SELECT.aStreamTab, status,
 		 args->ARGS_STRM_SELECT.nStreams);
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 7abea72..2aaa1bf 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -496,10 +496,6 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, u32 FlushType)
 	/* Writeback and Invalidate all */
 	case PROC_WRBK_INV_ALL:
 		__cpuc_flush_kern_all();
-		break;
-	default:
-		GT_1trace(MEM_debugMask, GT_6CLASS, "MEM_FlushCache: invalid "
-			  "FlushMemType 0x%x\n", FlushType);
 	break;
 	}
 
-- 
1.5.4.5

