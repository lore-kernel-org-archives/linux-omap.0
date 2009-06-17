From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/7] DSPBRIDGE: Handle properly user space pointers
Date: Wed, 17 Jun 2009 12:36:08 -0500
Message-ID: <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36930 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890AbZFQRbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 13:31:37 -0400
In-Reply-To: <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

This patch fixes bridge crash in UUID_UuidToString function. This
error was due to user pointers not handled properly.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |  147 ++++++++++++++++++++++++++++++-----------
 1 files changed, 109 insertions(+), 38 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index cd84e4e..995a833 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -519,15 +519,38 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args)
 u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
 {
 	u32 retVal;
+	struct DSP_UUID pUuid;
+	u32 pathSize = 0;
+	char *pszPathName = NULL;
+	DSP_STATUS status = DSP_SOK;
+
+	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
+	if (DSP_FAILED(status))
+		goto func_end;
+	pathSize = strlen_user((char *)
+				args->ARGS_MGR_REGISTEROBJECT.pszPathName);
+	pszPathName = MEM_Alloc(pathSize, MEM_NONPAGED);
+	if (!pszPathName)
+		goto func_end;
+	retVal = strncpy_from_user(pszPathName,
+			(char *)args->ARGS_MGR_REGISTEROBJECT.pszPathName,
+			pathSize);
+	if (!retVal) {
+		status = DSP_EPOINTER;
+		goto func_end;
+	}
+	pszPathName[pathSize] = '\0';
 
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "MGRWRAP_RegisterObject: entered pg2hMsg "
 		 "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
-	retVal = DCD_RegisterObject(WRAP_MAP2CALLER
-		    (args->ARGS_MGR_REGISTEROBJECT.pUuid),
-		    args->ARGS_MGR_REGISTEROBJECT.objType,
-		    WRAP_MAP2CALLER(args->ARGS_MGR_REGISTEROBJECT.pszPathName));
-	return retVal;
+	status = DCD_RegisterObject(&pUuid,
+				args->ARGS_MGR_REGISTEROBJECT.objType,
+				(char *)pszPathName);
+func_end:
+	if (pszPathName)
+		MEM_Free(pszPathName);
+	return status;
 }
 
 /*
@@ -535,16 +558,21 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
  */
 u32 MGRWRAP_UnregisterObject(union Trapped_Args *args)
 {
-	u32 retVal;
+	DSP_STATUS status = DSP_SOK;
+	struct DSP_UUID pUuid;
+
+	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
+	if (DSP_FAILED(status))
+		goto func_end;
 
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "MGRWRAP_UnregisterObject: entered pg2hMsg"
 		 " 0x%x\n", args->ARGS_MGR_UNREGISTEROBJECT.pUuid);
-	retVal = DCD_UnregisterObject(WRAP_MAP2CALLER
-			(args->ARGS_MGR_UNREGISTEROBJECT.pUuid),
+	status = DCD_UnregisterObject(&pUuid,
 			args->ARGS_MGR_UNREGISTEROBJECT.objType);
+func_end:
+	return status;
 
-	return retVal;
 }
 
 /*
@@ -628,11 +656,15 @@ u32 PROCWRAP_Attach(union Trapped_Args *args)
 		cp_fm_usr(&attrIn, args->ARGS_PROC_ATTACH.pAttrIn, status, 1);
 		if (DSP_SUCCEEDED(status))
 			pAttrIn = &attrIn;
+		else
+			goto func_end;
+
 
 	}
 	status = PROC_Attach(args->ARGS_PROC_ATTACH.uProcessor, pAttrIn,
 			    &processor);
 	cp_to_usr(args->ARGS_PROC_ATTACH.phProcessor, &processor, status, 1);
+func_end:
 	return status;
 }
 
@@ -653,16 +685,20 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args)
 		 args->ARGS_PROC_CTRL.dwCmd,
 		 args->ARGS_PROC_CTRL.pArgs);
 	if (pSize) {
-		if (get_user(cbDataSize, pSize))
+		if (get_user(cbDataSize, pSize)) {
 			status = DSP_EFAIL;
-
+			goto func_end;
+		}
 		cbDataSize += sizeof(u32);
 		if (DSP_SUCCEEDED(status)) {
 			pArgs = MEM_Alloc(cbDataSize, MEM_NONPAGED);
-			if (pArgs == NULL)
+			if (pArgs == NULL) {
 				status = DSP_EMEMORY;
+				goto func_end;
+			}
+		} else
+			goto func_end;
 
-		}
 		cp_fm_usr(pArgs, args->ARGS_PROC_CTRL.pArgs, status,
 			 cbDataSize);
 	}
@@ -675,7 +711,7 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args)
 	/* cp_to_usr(args->ARGS_PROC_CTRL.pArgs, pArgs, status, 1);*/
 	if (pArgs)
 		MEM_Free(pArgs);
-
+func_end:
 	return status;
 }
 
@@ -767,7 +803,11 @@ u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args)
  */
 u32 PROCWRAP_EnumResources(union Trapped_Args *args)
 {
-	u32 retVal;
+	DSP_STATUS status = DSP_SOK;
+	struct DSP_RESOURCEINFO pResourceInfo;
+
+	if (DSP_FAILED(status))
+		goto func_end;
 
 	GT_4trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_EnumResources: entered args:\n"
@@ -777,13 +817,17 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args)
 		 args->ARGS_PROC_ENUMRESOURCES.uResourceType,
 		 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
 		 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
-	retVal = PROC_GetResourceInfo(args->ARGS_PROC_ENUMRESOURCES.hProcessor,
+	status = PROC_GetResourceInfo(args->ARGS_PROC_ENUMRESOURCES.hProcessor,
 			args->ARGS_PROC_ENUMRESOURCES.uResourceType,
-			WRAP_MAP2CALLER(args->ARGS_PROC_ENUMRESOURCES.
-			pResourceInfo), args->ARGS_PROC_ENUMRESOURCES.
-			uResourceInfoSize);
+			&pResourceInfo,
+			args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
+	if (DSP_FAILED(status))
+		goto func_end;
+	cp_to_usr(args->ARGS_PROC_ENUMRESOURCES.pResourceInfo, &pResourceInfo,
+						status, 1);
+func_end:
+	return status;
 
-	return retVal;
 }
 
 /*
@@ -848,11 +892,14 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		status = DSP_EMEMORY;
 
 	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, argc);
+	if (DSP_FAILED(status))
+		goto func_cont;
+
 	for (i = 0; DSP_SUCCEEDED(status) && (i < argc); i++) {
 		if (argv[i] != NULL) {
-                        /* User space pointer to argument */
-                       temp = (char *) argv[i];
-                       len = strlen_user((char *)temp);
+			/* User space pointer to argument */
+			temp = (char *) argv[i];
+			len = strlen_user((char *)temp);
 			/* Kernel space pointer to argument */
 			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (argv[i] == NULL) {
@@ -860,6 +907,9 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 				break;
 			}
 			cp_fm_usr(argv[i], temp, status, len);
+			if (DSP_FAILED(status))
+				goto func_cont;
+
 		}
 	}
 	/* TODO: validate this */
@@ -868,17 +918,21 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 		len = 0;
 		do {
 			len++;
-                       get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
-               } while (temp);
+			get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
+		} while (temp);
 		envp = MEM_Alloc(len * sizeof(u8 *), MEM_NONPAGED);
-		if (envp == NULL)
+		if (envp == NULL) {
 			status = DSP_EMEMORY;
+			goto func_cont;
+		}
 
 		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, len);
+		if (DSP_FAILED(status))
+			goto func_cont;
 		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
-                        /* User space pointer to argument */
-                       temp = (char *)envp[i];
-                       len = strlen_user((char *)temp);
+			/* User space pointer to argument */
+			temp = (char *)envp[i];
+			len = strlen_user((char *)temp);
 			/* Kernel space pointer to argument */
 			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
 			if (envp[i] == NULL) {
@@ -886,6 +940,8 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 				break;
 			}
 			cp_fm_usr(envp[i], temp, status, len);
+			if (DSP_FAILED(status))
+				goto func_cont;
 		}
 	}
 	GT_5trace(WCD_debugMask, GT_ENTER,
@@ -899,6 +955,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 				  args->ARGS_PROC_LOAD.iArgc,
 				  (CONST char **)argv, (CONST char **)envp);
 	}
+func_cont:
 	if (envp != NULL) {
 		i = 0;
 		while (envp[i] != NULL)
@@ -1039,7 +1096,7 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_UUID nodeId;
-	u32 cbDataSize;
+	u32 cbDataSize = 0;
 	u32 __user *pSize = (u32 __user *)args->ARGS_NODE_ALLOCATE.pArgs;
 	u8 *pArgs = NULL;
 	struct DSP_NODEATTRIN attrIn, *pAttrIn = NULL;
@@ -1063,11 +1120,15 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args)
 			 cbDataSize);
 	}
 	cp_fm_usr(&nodeId, args->ARGS_NODE_ALLOCATE.pNodeID, status, 1);
+	if (DSP_FAILED(status))
+		goto func_cont;
 	/* Optional argument */
 	if (args->ARGS_NODE_ALLOCATE.pAttrIn) {
 		cp_fm_usr(&attrIn, args->ARGS_NODE_ALLOCATE.pAttrIn, status, 1);
 		if (DSP_SUCCEEDED(status))
 			pAttrIn = &attrIn;
+		else
+			status = DSP_EMEMORY;
 
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -1076,6 +1137,7 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args)
 				      pAttrIn, &hNode);
 	}
 	cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
+func_cont:
 	if (pArgs)
 		MEM_Free(pArgs);
 
@@ -1105,7 +1167,7 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args)
 					 args->ARGS_NODE_ALLOCMSGBUF.uSize,
 					 pAttr, &pBuffer);
 	}
-	cp_to_usr(args->ARGS_NODE_ALLOCMSGBUF.pBuffer, &pBuffer, status, 1)
+	cp_to_usr(args->ARGS_NODE_ALLOCMSGBUF.pBuffer, &pBuffer, status, 1);
 	return status;
 }
 
@@ -1146,12 +1208,16 @@ u32 NODEWRAP_Connect(union Trapped_Args *args)
 		cbDataSize += sizeof(u32);
 		if (DSP_SUCCEEDED(status)) {
 			pArgs = MEM_Alloc(cbDataSize, MEM_NONPAGED);
-			if (pArgs == NULL)
+			if (pArgs == NULL) {
 				status = DSP_EMEMORY;
+				goto func_cont;
+			}
 
 		}
 		cp_fm_usr(pArgs, args->ARGS_NODE_CONNECT.pConnParam, status,
 			 cbDataSize);
+		if (DSP_FAILED(status))
+			goto func_cont;
 	}
 	if (args->ARGS_NODE_CONNECT.pAttrs) {	/* Optional argument */
 		cp_fm_usr(&attrs, args->ARGS_NODE_CONNECT.pAttrs, status, 1);
@@ -1166,6 +1232,7 @@ u32 NODEWRAP_Connect(union Trapped_Args *args)
 				     args->ARGS_NODE_CONNECT.uOtherStream,
 				     pAttrs, (struct DSP_CBDATA *)pArgs);
 	}
+func_cont:
 	if (pArgs)
 		MEM_Free(pArgs);
 
@@ -1358,6 +1425,8 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args)
 
 
 	cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
+	if (DSP_FAILED(status))
+		goto func_cont;
 	pnodeProps = MEM_Alloc(sizeof(struct DSP_NDBPROPS), MEM_NONPAGED);
 	if (pnodeProps != NULL) {
 		status = NODE_GetUUIDProps(args->
@@ -1365,8 +1434,9 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args)
 					  &nodeId, pnodeProps);
 		cp_to_usr(args->ARGS_NODE_GETUUIDPROPS.pNodeProps, pnodeProps,
 			 status, 1);
-	}	else
+	} else
 		status = DSP_EMEMORY;
+func_cont:
 	if (pnodeProps)
 		MEM_Free(pnodeProps);
 	return status;
@@ -1487,16 +1557,17 @@ u32 STRMWRAP_Idle(union Trapped_Args *args)
  */
 u32 STRMWRAP_Issue(union Trapped_Args *args)
 {
-	u32 retVal;
-
-	retVal = STRM_Issue(args->ARGS_STRM_ISSUE.hStream,
+	DSP_STATUS status = DSP_SOK;
+	/* No need of doing cp_fm_usr for the user buffer (pBuffer)
+	as this is done in Bridge internal function WMD_CHNL_AddIOReq
+	in chnl_sm.c */
+	status = STRM_Issue(args->ARGS_STRM_ISSUE.hStream,
 			args->ARGS_STRM_ISSUE.pBuffer,
 			args->ARGS_STRM_ISSUE.dwBytes,
 			args->ARGS_STRM_ISSUE.dwBufSize,
 			args->ARGS_STRM_ISSUE.dwArg);
 
-	/* This is a user space pointer */
-	return retVal;
+	return status;
 }
 
 /*
-- 
1.6.2.4

