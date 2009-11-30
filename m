From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 14/20] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Mon, 30 Nov 2009 15:54:55 -0600
Message-ID: <1259618101-8972-15-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-14-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47758 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbZK3VtB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:49:01 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn7Of028748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-14-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

- Use standard convention to define ioctls.
- Removed runtime check for ioctl matching table number.
- Added __deprectaed marker to functions that are not used anymore.

Currently 'DB' is used as identifier for dspbridge.

Added TODOs for removing the function table and, deprecated
and not implemented ioctls, this can be done when all the ioctls
are accessed through a switch instead of a pointer to function.

*** NOTE: An update in api ioctl definitions is required. ***

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |  144 ++++++++++-------------
 drivers/dsp/bridge/pmgr/wcd.c                   |  131 ++++++++++-----------
 2 files changed, 128 insertions(+), 147 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 397361c..f2fb408 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -391,83 +391,69 @@ union Trapped_Args {
 	} ARGS_UTIL_TESTDLL;
 } ;
 
-#define CMD_BASE		    101
-
-/* MGR module offsets */
-#define CMD_MGR_BASE_OFFSET	     CMD_BASE
-#define CMD_MGR_ENUMNODE_INFO_OFFSET    (CMD_MGR_BASE_OFFSET + 0)
-#define CMD_MGR_ENUMPROC_INFO_OFFSET    (CMD_MGR_BASE_OFFSET + 1)
-#define CMD_MGR_REGISTEROBJECT_OFFSET   (CMD_MGR_BASE_OFFSET + 2)
-#define CMD_MGR_UNREGISTEROBJECT_OFFSET (CMD_MGR_BASE_OFFSET + 3)
-#define CMD_MGR_WAIT_OFFSET	     (CMD_MGR_BASE_OFFSET + 4)
-
-#ifndef RES_CLEANUP_DISABLE
-#define CMD_MGR_RESOUCES_OFFSET	 (CMD_MGR_BASE_OFFSET + 5)
-#define CMD_MGR_END_OFFSET	      CMD_MGR_RESOUCES_OFFSET
-#else
-#define CMD_MGR_END_OFFSET	      CMD_MGR_WAIT_OFFSET
-#endif
-
-#define CMD_PROC_BASE_OFFSET	    (CMD_MGR_END_OFFSET + 1)
-#define CMD_PROC_ATTACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 0)
-#define CMD_PROC_CTRL_OFFSET	    (CMD_PROC_BASE_OFFSET + 1)
-#define CMD_PROC_DETACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 2)
-#define CMD_PROC_ENUMNODE_OFFSET	(CMD_PROC_BASE_OFFSET + 3)
-#define CMD_PROC_ENUMRESOURCES_OFFSET   (CMD_PROC_BASE_OFFSET + 4)
-#define CMD_PROC_GETSTATE_OFFSET	(CMD_PROC_BASE_OFFSET + 5)
-#define CMD_PROC_GETTRACE_OFFSET	(CMD_PROC_BASE_OFFSET + 6)
-#define CMD_PROC_LOAD_OFFSET	    (CMD_PROC_BASE_OFFSET + 7)
-#define CMD_PROC_REGISTERNOTIFY_OFFSET  (CMD_PROC_BASE_OFFSET + 8)
-#define CMD_PROC_START_OFFSET	   (CMD_PROC_BASE_OFFSET + 9)
-#define CMD_PROC_RSVMEM_OFFSET	  (CMD_PROC_BASE_OFFSET + 10)
-#define CMD_PROC_UNRSVMEM_OFFSET	(CMD_PROC_BASE_OFFSET + 11)
-#define CMD_PROC_MAPMEM_OFFSET	  (CMD_PROC_BASE_OFFSET + 12)
-#define CMD_PROC_UNMAPMEM_OFFSET	(CMD_PROC_BASE_OFFSET + 13)
-#define CMD_PROC_FLUSHMEMORY_OFFSET      (CMD_PROC_BASE_OFFSET + 14)
-#define CMD_PROC_STOP_OFFSET	    (CMD_PROC_BASE_OFFSET + 15)
-#define CMD_PROC_INVALIDATEMEMORY_OFFSET (CMD_PROC_BASE_OFFSET + 16)
-#define CMD_PROC_END_OFFSET	     CMD_PROC_INVALIDATEMEMORY_OFFSET
-
-
-#define CMD_NODE_BASE_OFFSET	    (CMD_PROC_END_OFFSET + 1)
-#define CMD_NODE_ALLOCATE_OFFSET	(CMD_NODE_BASE_OFFSET + 0)
-#define CMD_NODE_ALLOCMSGBUF_OFFSET     (CMD_NODE_BASE_OFFSET + 1)
-#define CMD_NODE_CHANGEPRIORITY_OFFSET  (CMD_NODE_BASE_OFFSET + 2)
-#define CMD_NODE_CONNECT_OFFSET	 (CMD_NODE_BASE_OFFSET + 3)
-#define CMD_NODE_CREATE_OFFSET	  (CMD_NODE_BASE_OFFSET + 4)
-#define CMD_NODE_DELETE_OFFSET	  (CMD_NODE_BASE_OFFSET + 5)
-#define CMD_NODE_FREEMSGBUF_OFFSET      (CMD_NODE_BASE_OFFSET + 6)
-#define CMD_NODE_GETATTR_OFFSET	 (CMD_NODE_BASE_OFFSET + 7)
-#define CMD_NODE_GETMESSAGE_OFFSET      (CMD_NODE_BASE_OFFSET + 8)
-#define CMD_NODE_PAUSE_OFFSET	   (CMD_NODE_BASE_OFFSET + 9)
-#define CMD_NODE_PUTMESSAGE_OFFSET      (CMD_NODE_BASE_OFFSET + 10)
-#define CMD_NODE_REGISTERNOTIFY_OFFSET  (CMD_NODE_BASE_OFFSET + 11)
-#define CMD_NODE_RUN_OFFSET	     (CMD_NODE_BASE_OFFSET + 12)
-#define CMD_NODE_TERMINATE_OFFSET       (CMD_NODE_BASE_OFFSET + 13)
-#define CMD_NODE_GETUUIDPROPS_OFFSET    (CMD_NODE_BASE_OFFSET + 14)
-#define CMD_NODE_END_OFFSET	     CMD_NODE_GETUUIDPROPS_OFFSET
-
-#define CMD_STRM_BASE_OFFSET	    (CMD_NODE_END_OFFSET + 1)
-#define CMD_STRM_ALLOCATEBUFFER_OFFSET  (CMD_STRM_BASE_OFFSET + 0)
-#define CMD_STRM_CLOSE_OFFSET	   (CMD_STRM_BASE_OFFSET + 1)
-#define CMD_STRM_FREEBUFFER_OFFSET      (CMD_STRM_BASE_OFFSET + 2)
-#define CMD_STRM_GETEVENTHANDLE_OFFSET  (CMD_STRM_BASE_OFFSET + 3)
-#define CMD_STRM_GETINFO_OFFSET	 (CMD_STRM_BASE_OFFSET + 4)
-#define CMD_STRM_IDLE_OFFSET	    (CMD_STRM_BASE_OFFSET + 5)
-#define CMD_STRM_ISSUE_OFFSET	   (CMD_STRM_BASE_OFFSET + 6)
-#define CMD_STRM_OPEN_OFFSET	    (CMD_STRM_BASE_OFFSET + 7)
-#define CMD_STRM_RECLAIM_OFFSET	 (CMD_STRM_BASE_OFFSET + 8)
-#define CMD_STRM_REGISTERNOTIFY_OFFSET  (CMD_STRM_BASE_OFFSET + 9)
-#define CMD_STRM_SELECT_OFFSET	  (CMD_STRM_BASE_OFFSET + 10)
-#define CMD_STRM_END_OFFSET	     CMD_STRM_SELECT_OFFSET
-
-/* Communication Memory Manager (UCMM) */
-#define CMD_CMM_BASE_OFFSET	     (CMD_STRM_END_OFFSET + 1)
-#define CMD_CMM_ALLOCBUF_OFFSET	 (CMD_CMM_BASE_OFFSET + 0)
-#define CMD_CMM_FREEBUF_OFFSET	  (CMD_CMM_BASE_OFFSET + 1)
-#define CMD_CMM_GETHANDLE_OFFSET	(CMD_CMM_BASE_OFFSET + 2)
-#define CMD_CMM_GETINFO_OFFSET	  (CMD_CMM_BASE_OFFSET + 3)
-#define CMD_CMM_END_OFFSET	      CMD_CMM_GETINFO_OFFSET
-
-#define CMD_BASE_END_OFFSET	CMD_CMM_END_OFFSET
+/* TODO: Remove deprecated and not implemented */
+
+/* MGR module */
+#define MGR_ENUMNODE_INFO	_IOWR('DB', 0, unsigned long)
+#define MGR_ENUMPROC_INFO	_IOWR('DB', 1, unsigned long)
+#define MGR_REGISTEROBJECT	_IOWR('DB', 2, unsigned long)
+#define MGR_UNREGISTEROBJECT	_IOWR('DB', 3, unsigned long)	/* Deprecated */
+#define MGR_WAIT		_IOWR('DB', 4, unsigned long)
+#define MGR_GET_PROC_RES	_IOR('DB', 5, unsigned long)	/* Deprecated */
+
+/* PROC Module */
+#define PROC_ATTACH		_IOWR('DB', 6, unsigned long)
+#define PROC_CTRL		_IOR('DB', 7, unsigned long)
+#define PROC_DETACH		_IOR('DB', 8, unsigned long)	/* Deprecated */
+#define PROC_ENUMNODE		_IOWR('DB', 9, unsigned long)
+#define PROC_ENUMRESOURCES	_IOWR('DB', 10, unsigned long)
+#define PROC_GET_STATE		_IOWR('DB', 11, unsigned long)
+#define PROC_GET_TRACE		_IOWR('DB', 12, unsigned long)
+#define PROC_LOAD		_IOW('DB', 13, unsigned long)
+#define PROC_REGISTERNOTIFY	_IOWR('DB', 14, unsigned long)
+#define PROC_START		_IOW('DB', 15, unsigned long)
+#define PROC_RSVMEM		_IOWR('DB', 16, unsigned long)
+#define PROC_UNRSVMEM		_IOW('DB', 17, unsigned long)
+#define PROC_MAPMEM		_IOWR('DB', 18, unsigned long)
+#define PROC_UNMAPMEM		_IOR('DB', 19, unsigned long)
+#define PROC_FLUSHMEMORY	_IOW('DB', 20, unsigned long)
+#define PROC_STOP		_IOWR('DB', 21, unsigned long)
+#define PROC_INVALIDATEMEMORY	_IOW('DB', 22, unsigned long)
+
+/* NODE Module */
+#define NODE_ALLOCATE		_IOWR('DB', 23, unsigned long)
+#define NODE_ALLOCMSGBUF	_IOWR('DB', 24, unsigned long)
+#define NODE_CHANGEPRIORITY	_IOW('DB', 25, unsigned long)
+#define NODE_CONNECT		_IOW('DB', 26, unsigned long)
+#define NODE_CREATE		_IOW('DB', 27, unsigned long)
+#define NODE_DELETE		_IOW('DB', 28, unsigned long)
+#define NODE_FREEMSGBUF		_IOW('DB', 29, unsigned long)
+#define NODE_GETATTR		_IOWR('DB', 30, unsigned long)
+#define NODE_GETMESSAGE		_IOWR('DB', 31, unsigned long)
+#define NODE_PAUSE		_IOW('DB', 32, unsigned long)
+#define NODE_PUTMESSAGE		_IOW('DB', 33, unsigned long)
+#define NODE_REGISTERNOTIFY	_IOWR('DB', 34, unsigned long)
+#define NODE_RUN		_IOW('DB', 35, unsigned long)
+#define NODE_TERMINATE		_IOWR('DB', 36, unsigned long)
+#define NODE_GETUUIDPROPS	_IOWR('DB', 37, unsigned long)
+
+/* STRM Module */
+#define STRM_ALLOCATEBUFFER	_IOWR('DB', 38, unsigned long)
+#define STRM_CLOSE		_IOW('DB', 39, unsigned long)
+#define STRM_FREEBUFFER		_IOWR('DB', 40, unsigned long)
+#define STRM_GETEVENTHANDLE	_IO('DB', 41)			/* Not Impl'd */
+#define STRM_GETINFO		_IOWR('DB', 42, unsigned long)
+#define STRM_IDLE		_IOW('DB', 43, unsigned long)
+#define STRM_ISSUE		_IOW('DB', 44, unsigned long)
+#define STRM_OPEN		_IOWR('DB', 45, unsigned long)
+#define STRM_RECLAIM		_IOWR('DB', 46, unsigned long)
+#define STRM_REGISTERNOTIFY	_IOWR('DB', 47, unsigned long)
+#define STRM_SELECT		_IOWR('DB', 48, unsigned long)
+
+/* CMM Module */
+#define CMM_ALLOCBUF		_IO('DB', 49)			/* Not Impl'd */
+#define CMM_FREEBUF		_IO('DB', 50)			/* Not Impl'd */
+#define CMM_GETHANDLE		_IOR('DB', 51, unsigned long)
+#define CMM_GETINFO		_IOR('DB', 52, unsigned long)
+
 #endif				/* WCDIOCTL_ */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index dd0dcdc..fb83da9 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -88,6 +88,7 @@ static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
 #endif
 static u32 WCD_cRefs;
 
+/* TODO: Remove function table */
 /*
  *  Function table.
  *  The order of these functions MUST be the same as the order of the command
@@ -96,65 +97,65 @@ static u32 WCD_cRefs;
  */
 static struct WCD_Cmd WCD_cmdTable[] = {
 	/* MGR module */
-	{MGRWRAP_EnumNode_Info, CMD_MGR_ENUMNODE_INFO_OFFSET},
-	{MGRWRAP_EnumProc_Info, CMD_MGR_ENUMPROC_INFO_OFFSET},
-	{MGRWRAP_RegisterObject, CMD_MGR_REGISTEROBJECT_OFFSET},
-	{MGRWRAP_UnregisterObject, CMD_MGR_UNREGISTEROBJECT_OFFSET},
-	{MGRWRAP_WaitForBridgeEvents, CMD_MGR_WAIT_OFFSET},
+	{MGRWRAP_EnumNode_Info},		/* MGR_ENUMNODE_INFO */
+	{MGRWRAP_EnumProc_Info},		/* MGR_ENUMPROC_INFO */
+	{MGRWRAP_RegisterObject},		/* MGR_REGISTEROBJECT */
+	{MGRWRAP_UnregisterObject},		/* MGR_UNREGISTEROBJECT */
+	{MGRWRAP_WaitForBridgeEvents},		/* MGR_WAIT */
 #ifndef RES_CLEANUP_DISABLE
-	{MGRWRAP_GetProcessResourcesInfo, CMD_MGR_RESOUCES_OFFSET},
+	{MGRWRAP_GetProcessResourcesInfo},	/* MGR_GET_PROC_RES */
 #endif
 	/* PROC Module */
-	{PROCWRAP_Attach, CMD_PROC_ATTACH_OFFSET},
-	{PROCWRAP_Ctrl, CMD_PROC_CTRL_OFFSET},
-	{PROCWRAP_Detach, CMD_PROC_DETACH_OFFSET},
-	{PROCWRAP_EnumNode_Info, CMD_PROC_ENUMNODE_OFFSET},
-	{PROCWRAP_EnumResources, CMD_PROC_ENUMRESOURCES_OFFSET},
-	{PROCWRAP_GetState, CMD_PROC_GETSTATE_OFFSET},
-	{PROCWRAP_GetTrace, CMD_PROC_GETTRACE_OFFSET},
-	{PROCWRAP_Load, CMD_PROC_LOAD_OFFSET},
-	{PROCWRAP_RegisterNotify, CMD_PROC_REGISTERNOTIFY_OFFSET},
-	{PROCWRAP_Start, CMD_PROC_START_OFFSET},
-	{PROCWRAP_ReserveMemory, CMD_PROC_RSVMEM_OFFSET},
-	{PROCWRAP_UnReserveMemory, CMD_PROC_UNRSVMEM_OFFSET},
-	{PROCWRAP_Map, CMD_PROC_MAPMEM_OFFSET},
-	{PROCWRAP_UnMap, CMD_PROC_UNMAPMEM_OFFSET},
-	{PROCWRAP_FlushMemory, CMD_PROC_FLUSHMEMORY_OFFSET},
-	{PROCWRAP_Stop, CMD_PROC_STOP_OFFSET},
-	{PROCWRAP_InvalidateMemory, CMD_PROC_INVALIDATEMEMORY_OFFSET},
+	{PROCWRAP_Attach},			/* PROC_ATTACH */
+	{PROCWRAP_Ctrl},			/* PROC_CTRL */
+	{PROCWRAP_Detach},			/* PROC_DETACH */
+	{PROCWRAP_EnumNode_Info},		/* PROC_ENUMNODE */
+	{PROCWRAP_EnumResources},		/* PROC_ENUMRESOURCES */
+	{PROCWRAP_GetState},			/* PROC_GET_STATE */
+	{PROCWRAP_GetTrace},			/* PROC_GET_TRACE */
+	{PROCWRAP_Load},			/* PROC_LOAD */
+	{PROCWRAP_RegisterNotify},		/* PROC_REGISTERNOTIFY */
+	{PROCWRAP_Start},			/* PROC_START */
+	{PROCWRAP_ReserveMemory},		/* PROC_RSVMEM */
+	{PROCWRAP_UnReserveMemory},		/* PROC_UNRSVMEM */
+	{PROCWRAP_Map},				/* PROC_MAPMEM */
+	{PROCWRAP_UnMap},			/* PROC_UNMAPMEM */
+	{PROCWRAP_FlushMemory},			/* PROC_FLUSHMEMORY */
+	{PROCWRAP_Stop},			/* PROC_STOP */
+	{PROCWRAP_InvalidateMemory},		/* PROC_INVALIDATEMEMORY */
 	/* NODE Module */
-	{NODEWRAP_Allocate, CMD_NODE_ALLOCATE_OFFSET},
-	{NODEWRAP_AllocMsgBuf, CMD_NODE_ALLOCMSGBUF_OFFSET},
-	{NODEWRAP_ChangePriority, CMD_NODE_CHANGEPRIORITY_OFFSET},
-	{NODEWRAP_Connect, CMD_NODE_CONNECT_OFFSET},
-	{NODEWRAP_Create, CMD_NODE_CREATE_OFFSET},
-	{NODEWRAP_Delete, CMD_NODE_DELETE_OFFSET},
-	{NODEWRAP_FreeMsgBuf, CMD_NODE_FREEMSGBUF_OFFSET},
-	{NODEWRAP_GetAttr, CMD_NODE_GETATTR_OFFSET},
-	{NODEWRAP_GetMessage, CMD_NODE_GETMESSAGE_OFFSET},
-	{NODEWRAP_Pause, CMD_NODE_PAUSE_OFFSET},
-	{NODEWRAP_PutMessage, CMD_NODE_PUTMESSAGE_OFFSET},
-	{NODEWRAP_RegisterNotify, CMD_NODE_REGISTERNOTIFY_OFFSET},
-	{NODEWRAP_Run, CMD_NODE_RUN_OFFSET},
-	{NODEWRAP_Terminate, CMD_NODE_TERMINATE_OFFSET},
-	{NODEWRAP_GetUUIDProps, CMD_NODE_GETUUIDPROPS_OFFSET},
+	{NODEWRAP_Allocate},			/* NODE_ALLOCATE */
+	{NODEWRAP_AllocMsgBuf},			/* NODE_ALLOCMSGBUF */
+	{NODEWRAP_ChangePriority},		/* NODE_CHANGEPRIORITY */
+	{NODEWRAP_Connect},			/* NODE_CONNECT */
+	{NODEWRAP_Create},			/* NODE_CREATE */
+	{NODEWRAP_Delete},			/* NODE_DELETE */
+	{NODEWRAP_FreeMsgBuf},			/* NODE_FREEMSGBUF */
+	{NODEWRAP_GetAttr},			/* NODE_GETATTR */
+	{NODEWRAP_GetMessage},			/* NODE_GETMESSAGE */
+	{NODEWRAP_Pause},			/* NODE_PAUSE */
+	{NODEWRAP_PutMessage},			/* NODE_PUTMESSAGE */
+	{NODEWRAP_RegisterNotify},		/* NODE_REGISTERNOTIFY */
+	{NODEWRAP_Run},				/* NODE_RUN */
+	{NODEWRAP_Terminate},			/* NODE_TERMINATE */
+	{NODEWRAP_GetUUIDProps},		/* NODE_GETUUIDPROPS */
 	/* STRM wrapper functions */
-	{STRMWRAP_AllocateBuffer, CMD_STRM_ALLOCATEBUFFER_OFFSET},
-	{STRMWRAP_Close, CMD_STRM_CLOSE_OFFSET},
-	{STRMWRAP_FreeBuffer, CMD_STRM_FREEBUFFER_OFFSET},
-	{STRMWRAP_GetEventHandle, CMD_STRM_GETEVENTHANDLE_OFFSET},
-	{STRMWRAP_GetInfo, CMD_STRM_GETINFO_OFFSET},
-	{STRMWRAP_Idle, CMD_STRM_IDLE_OFFSET},
-	{STRMWRAP_Issue, CMD_STRM_ISSUE_OFFSET},
-	{STRMWRAP_Open, CMD_STRM_OPEN_OFFSET},
-	{STRMWRAP_Reclaim, CMD_STRM_RECLAIM_OFFSET},
-	{STRMWRAP_RegisterNotify, CMD_STRM_REGISTERNOTIFY_OFFSET},
-	{STRMWRAP_Select, CMD_STRM_SELECT_OFFSET},
+	{STRMWRAP_AllocateBuffer},		/* STRM_ALLOCATEBUFFER */
+	{STRMWRAP_Close},			/* STRM_CLOSE */
+	{STRMWRAP_FreeBuffer},			/* STRM_FREEBUFFER */
+	{STRMWRAP_GetEventHandle},		/* STRM_GETEVENTHANDLE */
+	{STRMWRAP_GetInfo},			/* STRM_GETINFO */
+	{STRMWRAP_Idle},			/* STRM_IDLE */
+	{STRMWRAP_Issue},			/* STRM_ISSUE */
+	{STRMWRAP_Open},			/* STRM_OPEN */
+	{STRMWRAP_Reclaim},			/* STRM_RECLAIM */
+	{STRMWRAP_RegisterNotify},		/* STRM_REGISTERNOTIFY */
+	{STRMWRAP_Select},			/* STRM_SELECT */
 	/* CMM module */
-	{CMMWRAP_CallocBuf, CMD_CMM_ALLOCBUF_OFFSET},
-	{CMMWRAP_FreeBuf, CMD_CMM_FREEBUF_OFFSET},
-	{CMMWRAP_GetHandle, CMD_CMM_GETHANDLE_OFFSET},
-	{CMMWRAP_GetInfo, CMD_CMM_GETINFO_OFFSET}
+	{CMMWRAP_CallocBuf},			/* CMM_ALLOCBUF */
+	{CMMWRAP_FreeBuf},			/* CMM_FREEBUF */
+	{CMMWRAP_GetHandle},			/* CMM_GETHANDLE */
+	{CMMWRAP_GetInfo},			/* CMM_GETINFO */
 };
 
 static inline void __cp_fm_usr(void *to, const void __user *from,
@@ -237,8 +238,7 @@ static int memory_check_vma(void *start_addr, u32 len)
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
 				    u32 *pResult, void *pr_ctxt)
 {
-	cmd -= CMD_BASE;
-
+	cmd = _IOC_NR(cmd);
 	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
 		/* make the fxn call via the cmd table */
 		*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
@@ -287,14 +287,7 @@ bool WCD_Init(void)
 	bool fInit = true;
 	bool fDRV, fDEV, fCOD, fSERVICES, fCHNL, fMSG, fIO;
 	bool fMGR, fPROC, fNODE, fDISP, fNTFY, fSTRM, fRMM;
-#ifdef DEBUG
-	/* runtime check of Device IOCtl array. */
-	u32 i;
-	int cmdtable = ARRAY_SIZE(WCD_cmdTable);
 
-	for (i = 0; i < cmdtable; i++)
-		DBC_Assert(WCD_cmdTable[i].dwIndex == i + CMD_BASE);
-#endif
 	if (WCD_cRefs == 0) {
 		/* initialize all SERVICES modules */
 		fSERVICES = SERVICES_Init();
@@ -423,6 +416,8 @@ DSP_STATUS WCD_InitComplete2(void)
 	return status;
 }
 
+/* TODO: Remove deprecated and not implemented ioctl wrappers */
+
 /*
  * ======== MGRWRAP_EnumNode_Info ========
  */
@@ -574,7 +569,7 @@ func_end:
 /*
  * ======== MGRWRAP_UnregisterObject ========
  */
-u32 MGRWRAP_UnregisterObject(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated MGRWRAP_UnregisterObject(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This API is deprecated */
 	return DSP_SOK;
@@ -625,7 +620,7 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== MGRWRAP_GetProcessResourceInfo ========
  */
-u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
 {
     DSP_STATUS status = DSP_SOK;
     u32 uSize = 0;
@@ -728,7 +723,7 @@ func_end:
 /*
  * ======== PROCWRAP_Detach ========
  */
-u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 {
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_Detach: entered args\n0x%x "
@@ -1648,7 +1643,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== STRMWRAP_GetEventHandle ========
  */
-u32 STRMWRAP_GetEventHandle(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated STRMWRAP_GetEventHandle(union Trapped_Args *args, void *pr_ctxt)
 {
 	return DSP_ENOTIMPL;
 }
@@ -1846,7 +1841,7 @@ u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== CMMWRAP_CallocBuf ========
  */
-u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	return DSP_ENOTIMPL;
@@ -1855,7 +1850,7 @@ u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== CMMWRAP_FreeBuf ========
  */
-u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	return DSP_ENOTIMPL;
-- 
1.6.2.4

