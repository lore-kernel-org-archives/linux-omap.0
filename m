From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 3/3][OMAP 3/4] remove __user sparse warnings
Date: Thu, 28 Aug 2008 20:35:01 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A534486D6A6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44841 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbYH2BfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 21:35:09 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7T1Z3mY014391
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:35:08 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7T1Z3IJ003471
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 20:35:03 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Remove sparse __user space related warnings from wcd.c

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---

Index: omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:19:35.000000000 -0500
+++ omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:19:42.000000000 -0500
@@ -76,16 +76,16 @@
 	/* MGR Module */
 	struct {
 		u32 uNode;
-		struct DSP_NDBPROPS *pNDBProps;
+		struct DSP_NDBPROPS __user *pNDBProps;
 		u32 uNDBPropsSize;
-		u32 *puNumNodes;
+		u32 __user *puNumNodes;
 	} ARGS_MGR_ENUMNODE_INFO;
 
 	struct {
 		u32 uProcessor;
-		struct DSP_PROCESSORINFO *pProcessorInfo;
+		struct DSP_PROCESSORINFO __user *pProcessorInfo;
 		u32 uProcessorInfoSize;
-		u32 *puNumProcs;
+		u32 __user *puNumProcs;
 	} ARGS_MGR_ENUMPROC_INFO;
 
 	struct {
@@ -100,23 +100,23 @@
 	} ARGS_MGR_UNREGISTEROBJECT;
 
 	struct {
-		struct DSP_NOTIFICATION **aNotifications;
+		struct DSP_NOTIFICATION  __user*__user *aNotifications;
 		u32 uCount;
-		u32 *puIndex;
+		u32 __user *puIndex;
 		u32 uTimeout;
 	} ARGS_MGR_WAIT;
 
 	/* PROC Module */
 	struct {
 		u32 uProcessor;
-		struct DSP_PROCESSORATTRIN *pAttrIn;
-		DSP_HPROCESSOR *phProcessor;
+		struct DSP_PROCESSORATTRIN __user *pAttrIn;
+		DSP_HPROCESSOR __user *phProcessor;
 	} ARGS_PROC_ATTACH;
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		u32 dwCmd;
-		struct DSP_CBDATA *pArgs;
+		struct DSP_CBDATA __user *pArgs;
 	} ARGS_PROC_CTRL;
 
 	struct {
@@ -125,10 +125,10 @@
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		DSP_HNODE *aNodeTab;
+		DSP_HNODE __user *aNodeTab;
 		u32 uNodeTabSize;
-		u32 *puNumNodes;
-		u32 *puAllocated;
+		u32 __user *puNumNodes;
+		u32 __user *puAllocated;
 	} ARGS_PROC_ENUMNODE_INFO;
 
 	struct {
@@ -140,16 +140,16 @@
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		struct DSP_PROCESSORSTATE *pProcStatus;
+		struct DSP_PROCESSORSTATE __user *pProcStatus;
 		u32 uStateInfoSize;
 	} ARGS_PROC_GETSTATE;
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		u8 *pBuf;
+		u8 __user *pBuf;
 
 	#ifndef RES_CLEANUP_DISABLE
-	    u8 *pSize;
+	    u8 __user *pSize;
     #endif
 		u32 uMaxSize;
 	} ARGS_PROC_GETTRACE;
@@ -157,15 +157,15 @@
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		s32 iArgc;
-		char **aArgv;
-		char **aEnvp;
+		char __user*__user *aArgv;
+		char *__user *aEnvp;
 	} ARGS_PROC_LOAD;
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		u32 uEventMask;
 		u32 uNotifyType;
-		struct DSP_NOTIFICATION *hNotification;
+		struct DSP_NOTIFICATION __user *hNotification;
 	} ARGS_PROC_REGISTER_NOTIFY;
 
 	struct {
@@ -175,7 +175,7 @@
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		u32 ulSize;
-		void **ppRsvAddr;
+		void *__user *ppRsvAddr;
 	} ARGS_PROC_RSVMEM;
 
 	struct {
@@ -189,7 +189,7 @@
 		void *pMpuAddr;
 		u32 ulSize;
 		void *pReqAddr;
-		void **ppMapAddr;
+		void *__user *ppMapAddr;
 		u32 ulMapAttr;
 	} ARGS_PROC_MAPMEM;
 
@@ -220,17 +220,17 @@
 	/* NODE Module */
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		struct DSP_UUID *pNodeID;
-		struct DSP_CBDATA *pArgs;
-		struct DSP_NODEATTRIN *pAttrIn;
-		DSP_HNODE *phNode;
+		struct DSP_UUID __user *pNodeID;
+		struct DSP_CBDATA __user *pArgs;
+		struct DSP_NODEATTRIN __user *pAttrIn;
+		DSP_HNODE __user *phNode;
 	} ARGS_NODE_ALLOCATE;
 
 	struct {
 		DSP_HNODE hNode;
 		u32 uSize;
-		struct DSP_BUFFERATTR *pAttr;
-		u8 **pBuffer;
+		struct DSP_BUFFERATTR __user *pAttr;
+		u8 *__user *pBuffer;
 	} ARGS_NODE_ALLOCMSGBUF;
 
 	struct {
@@ -243,8 +243,8 @@
 		u32 uStream;
 		DSP_HNODE hOtherNode;
 		u32 uOtherStream;
-		struct DSP_STRMATTR *pAttrs;
-		struct DSP_CBDATA *pConnParam;
+		struct DSP_STRMATTR __user *pAttrs;
+		struct DSP_CBDATA __user *pConnParam;
 	} ARGS_NODE_CONNECT;
 
 	struct {
@@ -257,19 +257,19 @@
 
 	struct {
 		DSP_HNODE hNode;
-		struct DSP_BUFFERATTR *pAttr;
+		struct DSP_BUFFERATTR __user *pAttr;
 		u8 *pBuffer;
 	} ARGS_NODE_FREEMSGBUF;
 
 	struct {
 		DSP_HNODE hNode;
-		struct DSP_NODEATTR *pAttr;
+		struct DSP_NODEATTR __user *pAttr;
 		u32 uAttrSize;
 	} ARGS_NODE_GETATTR;
 
 	struct {
 		DSP_HNODE hNode;
-		struct DSP_MSG *pMessage;
+		struct DSP_MSG __user *pMessage;
 		u32 uTimeout;
 	} ARGS_NODE_GETMESSAGE;
 
@@ -279,7 +279,7 @@
 
 	struct {
 		DSP_HNODE hNode;
-		struct DSP_MSG *pMessage;
+		struct DSP_MSG __user *pMessage;
 		u32 uTimeout;
 	} ARGS_NODE_PUTMESSAGE;
 
@@ -287,7 +287,7 @@
 		DSP_HNODE hNode;
 		u32 uEventMask;
 		u32 uNotifyType;
-		struct DSP_NOTIFICATION *hNotification;
+		struct DSP_NOTIFICATION __user *hNotification;
 	} ARGS_NODE_REGISTERNOTIFY;
 
 	struct {
@@ -296,13 +296,13 @@
 
 	struct {
 		DSP_HNODE hNode;
-		DSP_STATUS *pStatus;
+		DSP_STATUS __user *pStatus;
 	} ARGS_NODE_TERMINATE;
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		struct DSP_UUID *pNodeID;
-		struct DSP_NDBPROPS *pNodeProps;
+		struct DSP_UUID __user *pNodeID;
+		struct DSP_NDBPROPS __user *pNodeProps;
 	} ARGS_NODE_GETUUIDPROPS;
 
 	/* STRM module */
@@ -310,7 +310,7 @@
 	struct {
 		DSP_HSTREAM hStream;
 		u32 uSize;
-		u8 **apBuffer;
+		u8 *__user *apBuffer;
 		u32 uNumBufs;
 	} ARGS_STRM_ALLOCATEBUFFER;
 
@@ -320,7 +320,7 @@
 
 	struct {
 		DSP_HSTREAM hStream;
-		u8 **apBuffer;
+		u8 *__user *apBuffer;
 		u32 uNumBufs;
 	} ARGS_STRM_FREEBUFFER;
 
@@ -331,7 +331,7 @@
 
 	struct {
 		DSP_HSTREAM hStream;
-		struct STRM_INFO *pStreamInfo;
+		struct STRM_INFO __user *pStreamInfo;
 		u32 uStreamInfoSize;
 	} ARGS_STRM_GETINFO;
 
@@ -352,29 +352,29 @@
 		DSP_HNODE hNode;
 		u32 uDirection;
 		u32 uIndex;
-		struct STRM_ATTR *pAttrIn;
-		DSP_HSTREAM *phStream;
+		struct STRM_ATTR __user *pAttrIn;
+		DSP_HSTREAM __user *phStream;
 	} ARGS_STRM_OPEN;
 
 	struct {
 		DSP_HSTREAM hStream;
-		u8 **pBufPtr;
-		u32 *pBytes;
-		u32 *pBufSize;
-		u32 *pdwArg;
+		u8 *__user *pBufPtr;
+		u32 __user *pBytes;
+		u32 __user *pBufSize;
+		u32 __user *pdwArg;
 	} ARGS_STRM_RECLAIM;
 
 	struct {
 		DSP_HSTREAM hStream;
 		u32 uEventMask;
 		u32 uNotifyType;
-		struct DSP_NOTIFICATION *hNotification;
+		struct DSP_NOTIFICATION __user *hNotification;
 	} ARGS_STRM_REGISTERNOTIFY;
 
 	struct {
-		DSP_HSTREAM *aStreamTab;
+		DSP_HSTREAM __user *aStreamTab;
 		u32 nStreams;
-		u32 *pMask;
+		u32 __user *pMask;
 		u32 uTimeout;
 	} ARGS_STRM_SELECT;
 
@@ -394,12 +394,12 @@
 
 	struct {
 		DSP_HPROCESSOR hProcessor;
-		struct CMM_OBJECT **phCmmMgr;
+		struct CMM_OBJECT *__user *phCmmMgr;
 	} ARGS_CMM_GETHANDLE;
 
 	struct {
 		struct CMM_OBJECT *hCmmMgr;
-		struct CMM_INFO *pCmmInfo;
+		struct CMM_INFO __user *pCmmInfo;
 	} ARGS_CMM_GETINFO;
 
 	/* MEM Module */
Index: omapkernel/drivers/dsp/bridge/pmgr/wcd.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/pmgr/wcd.c	2008-08-22 19:19:19.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/pmgr/wcd.c	2008-08-22 19:19:42.000000000 -0500
@@ -567,7 +567,7 @@
 
 	/* get the array of pointers to user structures */
 	cp_fm_usr(aNotifications, args->ARGS_MGR_WAIT.aNotifications,
-		 status, uCount);
+	 status, uCount);
 	/* get the events */
 	for (i = 0; i < uCount; i++) {
 		cp_fm_usr(&notifications[i], aNotifications[i], status, 1);
@@ -642,7 +642,8 @@
  */
 u32 PROCWRAP_Ctrl(union Trapped_Args *args)
 {
-	u32 cbDataSize, *pSize = (u32 *)args->ARGS_PROC_CTRL.pArgs;
+	u32 cbDataSize, __user *pSize = (u32 __user *)
+			args->ARGS_PROC_CTRL.pArgs;
 	u8 *pArgs = NULL;
 	DSP_STATUS status = DSP_SOK;
 
@@ -835,10 +836,12 @@
 {
 	s32 i, len;
 	DSP_STATUS status = DSP_SOK;
-	u8 *temp;
+	u8 __user *temp;
+	u8 *temp1;
 	s32 argc = args->ARGS_PROC_LOAD.iArgc;
 	u8 **argv, **envp = NULL;
 
+
 	DBC_Require(argc > 0);
 	DBC_Require(argc <= MAX_LOADARGS);
 
@@ -850,7 +853,7 @@
 	for (i = 0; DSP_SUCCEEDED(status) && (i < argc); i++) {
 		if (argv[i] != NULL) {
 			temp = argv[i];	/* User space pointer to argument */
-			len = strlen_user((char *)temp);
+			len = strlen_user(temp);
 			/* Kernel space pointer to argument */
 			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (argv[i] == NULL) {
@@ -866,8 +869,8 @@
 		len = 0;
 		do {
 			len++;
-			get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
-		} while (temp);
+			get_user(temp1, args->ARGS_PROC_LOAD.aEnvp);
+		} while (temp1);
 		envp = MEM_Alloc(len * sizeof(u8 *), MEM_NONPAGED);
 		if (envp == NULL)
 			status = DSP_EMEMORY;
@@ -875,7 +878,7 @@
 		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, len);
 		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
 			temp = envp[i];	/* User space pointer to argument */
-			len = strlen_user((char *)temp);
+			len = strlen_user(temp);
 			/* Kernel space pointer to argument */
 			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (envp[i] == NULL) {
@@ -1037,7 +1040,7 @@
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_UUID nodeId;
 	u32 cbDataSize;
-	u32 *pSize = (u32 *)args->ARGS_NODE_ALLOCATE.pArgs;
+	u32 __user *pSize = (u32 __user *)args->ARGS_NODE_ALLOCATE.pArgs;
 	u8 *pArgs = NULL;
 	struct DSP_NODEATTRIN attrIn, *pAttrIn = NULL;
 	struct NODE_OBJECT *hNode;
@@ -1130,7 +1133,7 @@
 	struct DSP_STRMATTR attrs;
 	struct DSP_STRMATTR *pAttrs = NULL;
 	u32 cbDataSize;
-	u32 *pSize = (u32 *)args->ARGS_NODE_CONNECT.pConnParam;
+	u32 __user *pSize = (u32 __user *)args->ARGS_NODE_CONNECT.pConnParam;
 	u8 *pArgs = NULL;
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Connect: entered\n");
