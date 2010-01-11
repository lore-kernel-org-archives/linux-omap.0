From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/6] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Mon, 11 Jan 2010 14:12:46 -0600
Message-ID: <1263240766-13000-7-git-send-email-omar.ramirez@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-3-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-4-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-5-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32993 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab0AKUDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 15:03:22 -0500
In-Reply-To: <1263240766-13000-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

- Use standard convention to define ioctls.

Currently 0xDB is used as identifier for dspbridge.

Discussion:
http://marc.info/?l=linux-omap&m=126297631603035&w=2

WARNING:
An update in api ioctl definitions is required, usually replacing
to a new libbridge (with ioctl patch) should be enough. Other
clients (not using libbridge) need to update their ioctl numbers
manually.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |  164 +++++++++++----------
 drivers/dsp/bridge/pmgr/wcd.c                   |  182 ++++++++++++++---------
 drivers/dsp/bridge/rmgr/drv_interface.c         |    3 -
 3 files changed, 200 insertions(+), 149 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 4b9dd0a..452be83 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -437,86 +437,92 @@ union Trapped_Args {
 	} ARGS_UTIL_TESTDLL;
 } ;
 
-#define CMD_BASE		    1
+/* Ioctl driver name */
+#define DB		0xDB
+
+/* Ioctl module masks */
+#define DB_MGR		0x0
+#define DB_PROC		0x20
+#define DB_NODE		0x40
+#define DB_STRM		0x60
+#define DB_CMM		0x80
+
+/*
+ * Following are used to distinguish between module ioctls, this is needed
+ * in case new ioctls are introduced.
+ */
+#define DB_MODULE_MASK		0xE0
+#define DB_IOC_MASK		0x1F
+
+/* Macro used to calculate the ioctl per dspbridge module */
+#define DB_IOC(module, num) \
+			(((module) & DB_MODULE_MASK) | ((num) & DB_IOC_MASK))
 
 /* TODO: Remove deprecated and not implemented */
 
-/* MGR module offsets */
-#define CMD_MGR_BASE_OFFSET	     CMD_BASE
-#define CMD_MGR_ENUMNODE_INFO_OFFSET    (CMD_MGR_BASE_OFFSET + 0)
-#define CMD_MGR_ENUMPROC_INFO_OFFSET    (CMD_MGR_BASE_OFFSET + 1)
-#define CMD_MGR_REGISTEROBJECT_OFFSET   (CMD_MGR_BASE_OFFSET + 2)
-#define CMD_MGR_UNREGISTEROBJECT_OFFSET (CMD_MGR_BASE_OFFSET + 3)
-#define CMD_MGR_WAIT_OFFSET	     (CMD_MGR_BASE_OFFSET + 4)
-
-#ifndef RES_CLEANUP_DISABLE
-#define CMD_MGR_RESOUCES_OFFSET	 (CMD_MGR_BASE_OFFSET + 5)    /* Deprecated */
-#define CMD_MGR_END_OFFSET	      CMD_MGR_RESOUCES_OFFSET
-#else
-#define CMD_MGR_END_OFFSET	      CMD_MGR_WAIT_OFFSET
-#endif
-
-#define CMD_PROC_BASE_OFFSET	    (CMD_MGR_END_OFFSET + 1)
-#define CMD_PROC_ATTACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 0)
-#define CMD_PROC_CTRL_OFFSET	    (CMD_PROC_BASE_OFFSET + 1)
-#define CMD_PROC_DETACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 2)  /* Deprecated */
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
-/* Not Impl'd */
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
-#define CMD_CMM_ALLOCBUF_OFFSET	 (CMD_CMM_BASE_OFFSET + 0)    /* Not Impl'd */
-#define CMD_CMM_FREEBUF_OFFSET	  (CMD_CMM_BASE_OFFSET + 1)   /* Not Impl'd */
-#define CMD_CMM_GETHANDLE_OFFSET	(CMD_CMM_BASE_OFFSET + 2)
-#define CMD_CMM_GETINFO_OFFSET	  (CMD_CMM_BASE_OFFSET + 3)
-#define CMD_CMM_END_OFFSET	      CMD_CMM_GETINFO_OFFSET
-
-#define CMD_BASE_END_OFFSET	CMD_CMM_END_OFFSET
+/* MGR Module */
+#define MGR_ENUMNODE_INFO	_IOWR(DB, DB_IOC(DB_MGR, 0), unsigned long)
+#define MGR_ENUMPROC_INFO	_IOWR(DB, DB_IOC(DB_MGR, 1), unsigned long)
+#define MGR_REGISTEROBJECT	_IOWR(DB, DB_IOC(DB_MGR, 2), unsigned long)
+#define MGR_UNREGISTEROBJECT	_IOWR(DB, DB_IOC(DB_MGR, 3), unsigned long)
+#define MGR_WAIT		_IOWR(DB, DB_IOC(DB_MGR, 4), unsigned long)
+	/* Deprecated */
+#define MGR_GET_PROC_RES	_IOR(DB, DB_IOC(DB_MGR, 5), unsigned long)
+
+/* PROC Module */
+#define PROC_ATTACH		_IOWR(DB, DB_IOC(DB_PROC, 0), unsigned long)
+#define PROC_CTRL		_IOR(DB, DB_IOC(DB_PROC, 1), unsigned long)
+	/* Deprecated */
+#define PROC_DETACH		_IOR(DB, DB_IOC(DB_PROC, 2), unsigned long)
+#define PROC_ENUMNODE		_IOWR(DB, DB_IOC(DB_PROC, 3), unsigned long)
+#define PROC_ENUMRESOURCES	_IOWR(DB, DB_IOC(DB_PROC, 4), unsigned long)
+#define PROC_GET_STATE		_IOWR(DB, DB_IOC(DB_PROC, 5), unsigned long)
+#define PROC_GET_TRACE		_IOWR(DB, DB_IOC(DB_PROC, 6), unsigned long)
+#define PROC_LOAD		_IOW(DB, DB_IOC(DB_PROC, 7), unsigned long)
+#define PROC_REGISTERNOTIFY	_IOWR(DB, DB_IOC(DB_PROC, 8), unsigned long)
+#define PROC_START		_IOW(DB, DB_IOC(DB_PROC, 9), unsigned long)
+#define PROC_RSVMEM		_IOWR(DB, DB_IOC(DB_PROC, 10), unsigned long)
+#define PROC_UNRSVMEM		_IOW(DB, DB_IOC(DB_PROC, 11), unsigned long)
+#define PROC_MAPMEM		_IOWR(DB, DB_IOC(DB_PROC, 12), unsigned long)
+#define PROC_UNMAPMEM		_IOR(DB, DB_IOC(DB_PROC, 13), unsigned long)
+#define PROC_FLUSHMEMORY	_IOW(DB, DB_IOC(DB_PROC, 14), unsigned long)
+#define PROC_STOP		_IOWR(DB, DB_IOC(DB_PROC, 15), unsigned long)
+#define PROC_INVALIDATEMEMORY	_IOW(DB, DB_IOC(DB_PROC, 16), unsigned long)
+
+/* NODE Module */
+#define NODE_ALLOCATE		_IOWR(DB, DB_IOC(DB_NODE, 0), unsigned long)
+#define NODE_ALLOCMSGBUF	_IOWR(DB, DB_IOC(DB_NODE, 1), unsigned long)
+#define NODE_CHANGEPRIORITY	_IOW(DB, DB_IOC(DB_NODE, 2), unsigned long)
+#define NODE_CONNECT		_IOW(DB, DB_IOC(DB_NODE, 3), unsigned long)
+#define NODE_CREATE		_IOW(DB, DB_IOC(DB_NODE, 4), unsigned long)
+#define NODE_DELETE		_IOW(DB, DB_IOC(DB_NODE, 5), unsigned long)
+#define NODE_FREEMSGBUF		_IOW(DB, DB_IOC(DB_NODE, 6), unsigned long)
+#define NODE_GETATTR		_IOWR(DB, DB_IOC(DB_NODE, 7), unsigned long)
+#define NODE_GETMESSAGE		_IOWR(DB, DB_IOC(DB_NODE, 8), unsigned long)
+#define NODE_PAUSE		_IOW(DB, DB_IOC(DB_NODE, 9), unsigned long)
+#define NODE_PUTMESSAGE		_IOW(DB, DB_IOC(DB_NODE, 10), unsigned long)
+#define NODE_REGISTERNOTIFY	_IOWR(DB, DB_IOC(DB_NODE, 11), unsigned long)
+#define NODE_RUN		_IOW(DB, DB_IOC(DB_NODE, 12), unsigned long)
+#define NODE_TERMINATE		_IOWR(DB, DB_IOC(DB_NODE, 13), unsigned long)
+#define NODE_GETUUIDPROPS	_IOWR(DB, DB_IOC(DB_NODE, 14), unsigned long)
+
+/* STRM Module */
+#define STRM_ALLOCATEBUFFER	_IOWR(DB, DB_IOC(DB_STRM, 0), unsigned long)
+#define STRM_CLOSE		_IOW(DB, DB_IOC(DB_STRM, 1), unsigned long)
+#define STRM_FREEBUFFER		_IOWR(DB, DB_IOC(DB_STRM, 2)98, unsigned long)
+#define STRM_GETEVENTHANDLE	_IO(DB, DB_IOC(DB_STRM, 3)	/* Not Impl'd */
+#define STRM_GETINFO		_IOWR(DB, DB_IOC(DB_STRM, 4), unsigned long)
+#define STRM_IDLE		_IOW(DB, DB_IOC(DB_STRM, 5), unsigned long)
+#define STRM_ISSUE		_IOW(DB, DB_IOC(DB_STRM, 6), unsigned long)
+#define STRM_OPEN		_IOWR(DB, DB_IOC(DB_STRM, 7), unsigned long)
+#define STRM_RECLAIM		_IOWR(DB, DB_IOC(DB_STRM, 8), unsigned long)
+#define STRM_REGISTERNOTIFY	_IOWR(DB, DB_IOC(DB_STRM, 9), unsigned long)
+#define STRM_SELECT		_IOWR(DB, DB_IOC(DB_STRM, 10), unsigned long)
+
+/* CMM Module */
+#define CMM_ALLOCBUF		_IO(DB, DB_IOC(DB_CMM, 0))	/* Not Impl'd */
+#define CMM_FREEBUF		_IO(DB, DB_IOC(DB_CMM, 1))	/* Not Impl'd */
+#define CMM_GETHANDLE		_IOR(DB, DB_IOC(DB_CMM, 2), unsigned long)
+#define CMM_GETINFO		_IOR(DB, DB_IOC(DB_CMM, 3), unsigned long)
+
 #endif				/* WCDIOCTL_ */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 02def74..f52b7b8 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -157,72 +157,85 @@ static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
 static u32 WCD_cRefs;
 
 /*
- *  Function table.
+ *  Function tables.
  *  The order of these functions MUST be the same as the order of the command
  *  numbers defined in wcdioctl.h  This is how an IOCTL number in user mode
  *  turns into a function call in kernel mode.
  */
-static struct WCD_Cmd WCD_cmdTable[] = {
-	/* MGR module */
-	{MGRWRAP_EnumNode_Info, CMD_MGR_ENUMNODE_INFO_OFFSET},
-	{MGRWRAP_EnumProc_Info, CMD_MGR_ENUMPROC_INFO_OFFSET},
-	{MGRWRAP_RegisterObject, CMD_MGR_REGISTEROBJECT_OFFSET},
-	{MGRWRAP_UnregisterObject, CMD_MGR_UNREGISTEROBJECT_OFFSET},
-	{MGRWRAP_WaitForBridgeEvents, CMD_MGR_WAIT_OFFSET},
-#ifndef RES_CLEANUP_DISABLE
-	{MGRWRAP_GetProcessResourcesInfo, CMD_MGR_RESOUCES_OFFSET},
-#endif
-	/* PROC Module */
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
-	/* NODE Module */
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
-	/* STRM wrapper functions */
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
-	/* CMM module */
-	{CMMWRAP_CallocBuf, CMD_CMM_ALLOCBUF_OFFSET},
-	{CMMWRAP_FreeBuf, CMD_CMM_FREEBUF_OFFSET},
-	{CMMWRAP_GetHandle, CMD_CMM_GETHANDLE_OFFSET},
-	{CMMWRAP_GetInfo, CMD_CMM_GETINFO_OFFSET}
+
+/* MGR wrapper functions */
+static struct WCD_Cmd mgr_cmd[] = {
+	{MGRWRAP_EnumNode_Info},		/* MGR_ENUMNODE_INFO */
+	{MGRWRAP_EnumProc_Info},		/* MGR_ENUMPROC_INFO */
+	{MGRWRAP_RegisterObject},		/* MGR_REGISTEROBJECT */
+	{MGRWRAP_UnregisterObject},		/* MGR_UNREGISTEROBJECT */
+	{MGRWRAP_WaitForBridgeEvents},		/* MGR_WAIT */
+ #ifndef RES_CLEANUP_DISABLE
+	{MGRWRAP_GetProcessResourcesInfo},	/* MGR_GET_PROC_RES */
+ #endif
+};
+
+/* PROC wrapper functions */
+static struct WCD_Cmd proc_cmd[] = {
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
+};
+
+/* NODE wrapper functions */
+static struct WCD_Cmd node_cmd[] = {
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
+};
+
+/* STRM wrapper functions */
+static struct WCD_Cmd strm_cmd[] = {
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
+};
+
+/* CMM wrapper functions */
+static struct WCD_Cmd cmm_cmd[] = {
+	{CMMWRAP_CallocBuf},			/* CMM_ALLOCBUF */
+	{CMMWRAP_FreeBuf},			/* CMM_FREEBUF */
+	{CMMWRAP_GetHandle},			/* CMM_GETHANDLE */
+	{CMMWRAP_GetInfo},			/* CMM_GETINFO */
 };
 
 static inline void __cp_fm_usr(void *to, const void __user *from,
@@ -273,13 +286,48 @@ static inline void __cp_to_usr(void __user *to, const void *from,
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
 				    u32 *result, void *pr_ctxt)
 {
-	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
-		/* make the fxn call via the cmd table */
-		*result = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
-		return DSP_SOK;
+	u32(*ioctl_cmd)(union Trapped_Args *args, void *pr_ctxt);
+	int i;
+
+	if (_IOC_TYPE(cmd) != DB) {
+		pr_err("%s: Incompatible dspbridge ioctl number\n", __func__);
+		goto err;
 	}
 
-	return DSP_EINVALIDARG;
+	/* Retrieve the fxn via the cmd table */
+	i = cmd & DB_IOC_MASK;
+	switch (cmd & DB_MODULE_MASK) {
+	case DB_MGR:
+		ioctl_cmd = mgr_cmd[i].fxn;
+		break;
+	case DB_PROC:
+		ioctl_cmd = proc_cmd[i].fxn;
+		break;
+	case DB_NODE:
+		ioctl_cmd = node_cmd[i].fxn;
+		break;
+	case DB_STRM:
+		ioctl_cmd = strm_cmd[i].fxn;
+		break;
+	case DB_CMM:
+		ioctl_cmd = cmm_cmd[i].fxn;
+		break;
+	default:
+		pr_err("%s: unknown dspbridge ioctl\n", __func__);
+		goto err;
+	}
+
+	if (!ioctl_cmd) {
+		pr_err("%s: requested ioctl not defined\n", __func__);
+		goto err;
+	} else {
+		*result = (*ioctl_cmd)(args, pr_ctxt);
+	}
+
+	return DSP_SOK;
+
+err:
+	return -EINVAL;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index efce35d..78ecec4 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -611,9 +611,6 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 
 	GT_0trace(driverTrace, GT_ENTER, " -> driver_ioctl\n");
 
-	/* Deduct one for the CMD_BASE. */
-	code = (code - 1);
-
 	status = copy_from_user(&pBufIn, (union Trapped_Args *)args,
 				sizeof(union Trapped_Args));
 
-- 
1.6.2.4

