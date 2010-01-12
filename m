From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 7/7] DSPBRIDGE: remove WCD_Cmd structure
Date: Mon, 11 Jan 2010 19:00:41 -0600
Message-ID: <1263258041-16836-8-git-send-email-omar.ramirez@ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-4-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-5-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-6-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47219 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab0ALAvQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 19:51:16 -0500
In-Reply-To: <1263258041-16836-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Remove WCD_Cmd structure given that only one member is being
used (fxn call), this structure is replaced for a definition
of an array of function pointers for each dspbridge ioctl
module.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |  134 +++++++++++++++++++---------------------
 1 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 27e8e8e..37d1f8a 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -147,12 +147,6 @@
 /* Used to get dspbridge ioctl table */
 #define DB_GET_IOC_TABLE(cmd)	(DB_GET_MODULE(cmd) >> DB_MODULE_SHIFT)
 
-/* Device IOCtl function pointer */
-struct WCD_Cmd {
-	u32(*fxn)(union Trapped_Args *args, void *pr_ctxt);
-	u32 dwIndex;
-} ;
-
 /*  ----------------------------------- Globals */
 #if GT_TRACE
 static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
@@ -167,80 +161,80 @@ static u32 WCD_cRefs;
  */
 
 /* MGR wrapper functions */
-static struct WCD_Cmd mgr_cmd[] = {
-	{MGRWRAP_EnumNode_Info},		/* MGR_ENUMNODE_INFO */
-	{MGRWRAP_EnumProc_Info},		/* MGR_ENUMPROC_INFO */
-	{MGRWRAP_RegisterObject},		/* MGR_REGISTEROBJECT */
-	{MGRWRAP_UnregisterObject},		/* MGR_UNREGISTEROBJECT */
-	{MGRWRAP_WaitForBridgeEvents},		/* MGR_WAIT */
+static u32 (*mgr_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {
+	MGRWRAP_EnumNode_Info,			/* MGR_ENUMNODE_INFO */
+	MGRWRAP_EnumProc_Info,			/* MGR_ENUMPROC_INFO */
+	MGRWRAP_RegisterObject,			/* MGR_REGISTEROBJECT */
+	MGRWRAP_UnregisterObject,		/* MGR_UNREGISTEROBJECT */
+	MGRWRAP_WaitForBridgeEvents,		/* MGR_WAIT */
 #ifndef RES_CLEANUP_DISABLE
-	{MGRWRAP_GetProcessResourcesInfo},	/* MGR_GET_PROC_RES */
+	MGRWRAP_GetProcessResourcesInfo,	/* MGR_GET_PROC_RES */
 #else
-	{NULL},
+	NULL,
 #endif
 };
 
 /* PROC wrapper functions */
-static struct WCD_Cmd proc_cmd[] = {
-	{PROCWRAP_Attach},			/* PROC_ATTACH */
-	{PROCWRAP_Ctrl},			/* PROC_CTRL */
-	{PROCWRAP_Detach},			/* PROC_DETACH */
-	{PROCWRAP_EnumNode_Info},		/* PROC_ENUMNODE */
-	{PROCWRAP_EnumResources},		/* PROC_ENUMRESOURCES */
-	{PROCWRAP_GetState},			/* PROC_GET_STATE */
-	{PROCWRAP_GetTrace},			/* PROC_GET_TRACE */
-	{PROCWRAP_Load},			/* PROC_LOAD */
-	{PROCWRAP_RegisterNotify},		/* PROC_REGISTERNOTIFY */
-	{PROCWRAP_Start},			/* PROC_START */
-	{PROCWRAP_ReserveMemory},		/* PROC_RSVMEM */
-	{PROCWRAP_UnReserveMemory},		/* PROC_UNRSVMEM */
-	{PROCWRAP_Map},				/* PROC_MAPMEM */
-	{PROCWRAP_UnMap},			/* PROC_UNMAPMEM */
-	{PROCWRAP_FlushMemory},			/* PROC_FLUSHMEMORY */
-	{PROCWRAP_Stop},			/* PROC_STOP */
-	{PROCWRAP_InvalidateMemory},		/* PROC_INVALIDATEMEMORY */
+static u32 (*proc_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {
+	PROCWRAP_Attach,			/* PROC_ATTACH */
+	PROCWRAP_Ctrl,				/* PROC_CTRL */
+	PROCWRAP_Detach,			/* PROC_DETACH */
+	PROCWRAP_EnumNode_Info,			/* PROC_ENUMNODE */
+	PROCWRAP_EnumResources,			/* PROC_ENUMRESOURCES */
+	PROCWRAP_GetState,			/* PROC_GET_STATE */
+	PROCWRAP_GetTrace,			/* PROC_GET_TRACE */
+	PROCWRAP_Load,				/* PROC_LOAD */
+	PROCWRAP_RegisterNotify,		/* PROC_REGISTERNOTIFY */
+	PROCWRAP_Start,				/* PROC_START */
+	PROCWRAP_ReserveMemory,			/* PROC_RSVMEM */
+	PROCWRAP_UnReserveMemory,		/* PROC_UNRSVMEM */
+	PROCWRAP_Map,				/* PROC_MAPMEM */
+	PROCWRAP_UnMap,				/* PROC_UNMAPMEM */
+	PROCWRAP_FlushMemory,			/* PROC_FLUSHMEMORY */
+	PROCWRAP_Stop,				/* PROC_STOP */
+	PROCWRAP_InvalidateMemory,		/* PROC_INVALIDATEMEMORY */
 };
 
 /* NODE wrapper functions */
-static struct WCD_Cmd node_cmd[] = {
-	{NODEWRAP_Allocate},			/* NODE_ALLOCATE */
-	{NODEWRAP_AllocMsgBuf},			/* NODE_ALLOCMSGBUF */
-	{NODEWRAP_ChangePriority},		/* NODE_CHANGEPRIORITY */
-	{NODEWRAP_Connect},			/* NODE_CONNECT */
-	{NODEWRAP_Create},			/* NODE_CREATE */
-	{NODEWRAP_Delete},			/* NODE_DELETE */
-	{NODEWRAP_FreeMsgBuf},			/* NODE_FREEMSGBUF */
-	{NODEWRAP_GetAttr},			/* NODE_GETATTR */
-	{NODEWRAP_GetMessage},			/* NODE_GETMESSAGE */
-	{NODEWRAP_Pause},			/* NODE_PAUSE */
-	{NODEWRAP_PutMessage},			/* NODE_PUTMESSAGE */
-	{NODEWRAP_RegisterNotify},		/* NODE_REGISTERNOTIFY */
-	{NODEWRAP_Run},				/* NODE_RUN */
-	{NODEWRAP_Terminate},			/* NODE_TERMINATE */
-	{NODEWRAP_GetUUIDProps},		/* NODE_GETUUIDPROPS */
+static u32 (*node_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {
+	NODEWRAP_Allocate,			/* NODE_ALLOCATE */
+	NODEWRAP_AllocMsgBuf,			/* NODE_ALLOCMSGBUF */
+	NODEWRAP_ChangePriority,		/* NODE_CHANGEPRIORITY */
+	NODEWRAP_Connect,			/* NODE_CONNECT */
+	NODEWRAP_Create,			/* NODE_CREATE */
+	NODEWRAP_Delete,			/* NODE_DELETE */
+	NODEWRAP_FreeMsgBuf,			/* NODE_FREEMSGBUF */
+	NODEWRAP_GetAttr,			/* NODE_GETATTR */
+	NODEWRAP_GetMessage,			/* NODE_GETMESSAGE */
+	NODEWRAP_Pause,			/* NODE_PAUSE */
+	NODEWRAP_PutMessage,			/* NODE_PUTMESSAGE */
+	NODEWRAP_RegisterNotify,		/* NODE_REGISTERNOTIFY */
+	NODEWRAP_Run,				/* NODE_RUN */
+	NODEWRAP_Terminate,			/* NODE_TERMINATE */
+	NODEWRAP_GetUUIDProps,		/* NODE_GETUUIDPROPS */
 };
 
 /* STRM wrapper functions */
-static struct WCD_Cmd strm_cmd[] = {
-	{STRMWRAP_AllocateBuffer},		/* STRM_ALLOCATEBUFFER */
-	{STRMWRAP_Close},			/* STRM_CLOSE */
-	{STRMWRAP_FreeBuffer},			/* STRM_FREEBUFFER */
-	{STRMWRAP_GetEventHandle},		/* STRM_GETEVENTHANDLE */
-	{STRMWRAP_GetInfo},			/* STRM_GETINFO */
-	{STRMWRAP_Idle},			/* STRM_IDLE */
-	{STRMWRAP_Issue},			/* STRM_ISSUE */
-	{STRMWRAP_Open},			/* STRM_OPEN */
-	{STRMWRAP_Reclaim},			/* STRM_RECLAIM */
-	{STRMWRAP_RegisterNotify},		/* STRM_REGISTERNOTIFY */
-	{STRMWRAP_Select},			/* STRM_SELECT */
+static u32 (*strm_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {
+	STRMWRAP_AllocateBuffer,		/* STRM_ALLOCATEBUFFER */
+	STRMWRAP_Close,			/* STRM_CLOSE */
+	STRMWRAP_FreeBuffer,			/* STRM_FREEBUFFER */
+	STRMWRAP_GetEventHandle,		/* STRM_GETEVENTHANDLE */
+	STRMWRAP_GetInfo,			/* STRM_GETINFO */
+	STRMWRAP_Idle,			/* STRM_IDLE */
+	STRMWRAP_Issue,			/* STRM_ISSUE */
+	STRMWRAP_Open,			/* STRM_OPEN */
+	STRMWRAP_Reclaim,			/* STRM_RECLAIM */
+	STRMWRAP_RegisterNotify,		/* STRM_REGISTERNOTIFY */
+	STRMWRAP_Select,			/* STRM_SELECT */
 };
 
 /* CMM wrapper functions */
-static struct WCD_Cmd cmm_cmd[] = {
-	{CMMWRAP_CallocBuf},			/* CMM_ALLOCBUF */
-	{CMMWRAP_FreeBuf},			/* CMM_FREEBUF */
-	{CMMWRAP_GetHandle},			/* CMM_GETHANDLE */
-	{CMMWRAP_GetInfo},			/* CMM_GETINFO */
+static u32 (*cmm_cmd[])(union Trapped_Args *args, void *pr_ctxt) = {
+	CMMWRAP_CallocBuf,			/* CMM_ALLOCBUF */
+	CMMWRAP_FreeBuf,			/* CMM_FREEBUF */
+	CMMWRAP_GetHandle,			/* CMM_GETHANDLE */
+	CMMWRAP_GetInfo,			/* CMM_GETINFO */
 };
 
 /* Array used to store ioctl table sizes. It can hold up to 8 entries */
@@ -323,19 +317,19 @@ inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
 
 	switch (DB_GET_MODULE(cmd)) {
 	case DB_MGR:
-		ioctl_cmd = mgr_cmd[i].fxn;
+		ioctl_cmd = mgr_cmd[i];
 		break;
 	case DB_PROC:
-		ioctl_cmd = proc_cmd[i].fxn;
+		ioctl_cmd = proc_cmd[i];
 		break;
 	case DB_NODE:
-		ioctl_cmd = node_cmd[i].fxn;
+		ioctl_cmd = node_cmd[i];
 		break;
 	case DB_STRM:
-		ioctl_cmd = strm_cmd[i].fxn;
+		ioctl_cmd = strm_cmd[i];
 		break;
 	case DB_CMM:
-		ioctl_cmd = cmm_cmd[i].fxn;
+		ioctl_cmd = cmm_cmd[i];
 		break;
 	}
 
-- 
1.6.2.4

