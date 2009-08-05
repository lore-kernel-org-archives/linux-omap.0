From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 3/3] DSPBRIDGE: Use TGID instead of PID for resource accounting
Date: Wed,  5 Aug 2009 16:25:17 +0300
Message-ID: <1249478717-4446-3-git-send-email-ameya.palande@nokia.com>
References: <1249478717-4446-1-git-send-email-ameya.palande@nokia.com>
 <1249478717-4446-2-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23730 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934322AbZHENZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 09:25:46 -0400
In-Reply-To: <1249478717-4446-2-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, x0095840@ti.com, omar.ramirez@ti.com, roman.tereshonkov@nokia.com, suyog@ti.com

This patch uses TGID instead of PID for accounting resources tied to a
user space process. This should fix all the issues related to user space
multithreading and resource cleanup.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/pmgr/cmm.c           |    4 ++--
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 drivers/dsp/bridge/rmgr/node.c          |   12 ++++++------
 drivers/dsp/bridge/rmgr/proc.c          |   22 +++++++++++-----------
 drivers/dsp/bridge/rmgr/strm.c          |   16 ++++++++--------
 drivers/dsp/bridge/services/kfile.c     |    7 ++-----
 drivers/dsp/bridge/wmd/chnl_sm.c        |    4 ++--
 7 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 99a2432..7dea18c 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -284,8 +284,8 @@ void *CMM_CallocBuf(struct CMM_OBJECT *hCmmMgr, u32 uSize,
 			 * We'll need to free up a process's alloc'd SM if the
 			 * client process goes away.
 			 */
-                       /* Return PID instead of process handle */
-                       pNode->hClientProc = current->pid;
+			/* Return TGID instead of process handle */
+			pNode->hClientProc = current->tgid;
 
 			/* put our node on InUse list */
 			LST_PutTail(pAllocator->pInUseListHead,
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 2fcd6f9..80c0eeb 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -584,7 +584,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 		DRV_InsertProcContext(hDrvObject, &pr_ctxt);
 		if (pr_ctxt) {
 			DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
-			DRV_ProcSetPID(pr_ctxt, current->pid);
+			DRV_ProcSetPID(pr_ctxt, current->tgid);
 		} else {
 			status = -ENOMEM;
 		}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 53a42bf..5ff87e9 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -789,8 +789,8 @@ func_cont2:
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+		/* Return TGID instead of process handle */
+		hProcess = current->tgid;
 
 		res_status = CFG_GetObject((u32 *)&hDrvObject,
 					  REG_DRV_OBJECT);
@@ -813,8 +813,8 @@ func_cont2:
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+		/* Return TGID instead of process handle */
+		hProcess = current->tgid;
 		res_status = CFG_GetObject((u32 *)&hDrvObject,
 					REG_DRV_OBJECT);
 		if (DSP_SUCCEEDED(res_status)) {
@@ -1793,8 +1793,8 @@ func_cont1:
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
 #ifndef RES_CLEANUP_DISABLE
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
 		goto func_cont;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 0af05eb..469cf21 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -215,7 +215,7 @@ DSP_STATUS PROC_CleanupAllResources(void)
 		goto func_end;
 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
 	while (pCtxtclosed != NULL) {
-		if (current->pid != pCtxtclosed->pid) {
+		if (current->tgid != pCtxtclosed->pid) {
 			GT_1trace(PROC_DebugMask, GT_5CLASS,
 				 "***Cleanup of "
 				 "process***%d\n", pCtxtclosed->pid);
@@ -308,8 +308,8 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	pProcObject->hMgrObject = hMgrObject;
 	pProcObject->uProcessor = devType;
 	/* Get Caller Process and store it */
-       /* Return PID instead of process handle */
-       pProcObject->hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	pProcObject->hProcess = current->tgid;
 
 	if (pAttrIn)
 		pProcObject->uTimeout = pAttrIn->uTimeout;
@@ -385,8 +385,8 @@ func_end:
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
@@ -402,8 +402,8 @@ func_end:
 		}
 	}
 func_cont:
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(res_status)) {
@@ -1468,8 +1468,8 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
 		/* Update the node and stream resource status */
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+		/* Return TGID instead of process handle */
+		hProcess = current->tgid;
 
 		res_status = CFG_GetObject((u32 *)&hDrvObject,
 					  REG_DRV_OBJECT);
@@ -1847,8 +1847,8 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
 		goto func_end;
 
 	/* Update the node and stream resource status */
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index bd55fd3..b6dbe46 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -203,8 +203,8 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
@@ -277,8 +277,8 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm)
 		goto func_end;
 
 	/* Update the node and stream resource status */
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
@@ -430,8 +430,8 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 	}
 #ifndef RES_CLEANUP_DISABLE
 	/* Update the node and stream resource status */
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(res_status)) {
@@ -779,8 +779,8 @@ func_cont:
 		(void)DeleteStrm(pStrm);
 
 #ifndef RES_CLEANUP_DISABLE
-       /* Return PID instead of process handle */
-       hProcess = current->pid;
+	/* Return TGID instead of process handle */
+	hProcess = current->tgid;
 
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(res_status)) {
diff --git a/drivers/dsp/bridge/services/kfile.c b/drivers/dsp/bridge/services/kfile.c
index d29bc22..dd2a962 100644
--- a/drivers/dsp/bridge/services/kfile.c
+++ b/drivers/dsp/bridge/services/kfile.c
@@ -92,7 +92,6 @@ s32 KFILE_Close(struct KFILE_FileObj *hFile)
 {
 	s32 cRetVal = 0;	/* 0 indicates success */
 	s32 fRetVal = 0;
-	__kernel_pid_t curr_pid;
 
 	GT_1trace(KFILE_debugMask, GT_ENTER, "KFILE_Close: hFile 0x%x\n",
 		  hFile);
@@ -101,8 +100,6 @@ s32 KFILE_Close(struct KFILE_FileObj *hFile)
 	if (MEM_IsValidHandle(hFile, SIGNATURE)) {
 		/* Close file only if opened by the same process (id). Otherwise
 		 * Linux closes all open file handles when process exits.*/
-               /* Return PID instead of process handle */
-               curr_pid = (__kernel_pid_t)current->pid;
 		fRetVal = filp_close(hFile->fileDesc, NULL) ;
 		if (fRetVal) {
 			cRetVal = E_KFILE_ERROR;
@@ -181,8 +178,8 @@ struct KFILE_FileObj *KFILE_Open(CONST char *pszFileName, CONST char *pszMode)
 			hFile->size = fileDesc->f_op->llseek(fileDesc, 0,
 							    SEEK_END);
 			fileDesc->f_op->llseek(fileDesc, 0, SEEK_SET);
-                       /* Return PID instead of process handle */
-                       hFile->owner_pid = current->pid;
+			/* Return TGID instead of process handle */
+			hFile->owner_pid = current->tgid;
 
 			status = DSP_SOK;
 		}
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index e8ffb2f..c70dba8 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -933,8 +933,8 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
 			pChnl->uMode = uMode;
 			pChnl->hUserEvent = hSyncEvent;	/* for Linux */
 			pChnl->hSyncEvent = hSyncEvent;
-                       /* get the process handle */
-                       pChnl->hProcess = current->pid;
+			/* Return TGID instead of process handle */
+			pChnl->hProcess = current->tgid;
 			pChnl->pCBArg = 0;
 			pChnl->cBytesMoved = 0;
 			/* Default to proc-copy */
-- 
1.6.2.4

