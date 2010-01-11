From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/6] DSPBRIDGE: Mark unused ioctls as deprecated
Date: Mon, 11 Jan 2010 14:12:43 -0600
Message-ID: <1263240766-13000-4-git-send-email-omar.ramirez@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0AKUDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 15:03:17 -0500
In-Reply-To: <1263240766-13000-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Mark unused ioctls as deprecated for future removal.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   11 ++++--
 drivers/dsp/bridge/pmgr/wcd.c                   |   38 +++++++++--------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 04b13ab..4b9dd0a 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -439,6 +439,8 @@ union Trapped_Args {
 
 #define CMD_BASE		    1
 
+/* TODO: Remove deprecated and not implemented */
+
 /* MGR module offsets */
 #define CMD_MGR_BASE_OFFSET	     CMD_BASE
 #define CMD_MGR_ENUMNODE_INFO_OFFSET    (CMD_MGR_BASE_OFFSET + 0)
@@ -448,7 +450,7 @@ union Trapped_Args {
 #define CMD_MGR_WAIT_OFFSET	     (CMD_MGR_BASE_OFFSET + 4)
 
 #ifndef RES_CLEANUP_DISABLE
-#define CMD_MGR_RESOUCES_OFFSET	 (CMD_MGR_BASE_OFFSET + 5)
+#define CMD_MGR_RESOUCES_OFFSET	 (CMD_MGR_BASE_OFFSET + 5)    /* Deprecated */
 #define CMD_MGR_END_OFFSET	      CMD_MGR_RESOUCES_OFFSET
 #else
 #define CMD_MGR_END_OFFSET	      CMD_MGR_WAIT_OFFSET
@@ -457,7 +459,7 @@ union Trapped_Args {
 #define CMD_PROC_BASE_OFFSET	    (CMD_MGR_END_OFFSET + 1)
 #define CMD_PROC_ATTACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 0)
 #define CMD_PROC_CTRL_OFFSET	    (CMD_PROC_BASE_OFFSET + 1)
-#define CMD_PROC_DETACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 2)
+#define CMD_PROC_DETACH_OFFSET	  (CMD_PROC_BASE_OFFSET + 2)  /* Deprecated */
 #define CMD_PROC_ENUMNODE_OFFSET	(CMD_PROC_BASE_OFFSET + 3)
 #define CMD_PROC_ENUMRESOURCES_OFFSET   (CMD_PROC_BASE_OFFSET + 4)
 #define CMD_PROC_GETSTATE_OFFSET	(CMD_PROC_BASE_OFFSET + 5)
@@ -497,6 +499,7 @@ union Trapped_Args {
 #define CMD_STRM_ALLOCATEBUFFER_OFFSET  (CMD_STRM_BASE_OFFSET + 0)
 #define CMD_STRM_CLOSE_OFFSET	   (CMD_STRM_BASE_OFFSET + 1)
 #define CMD_STRM_FREEBUFFER_OFFSET      (CMD_STRM_BASE_OFFSET + 2)
+/* Not Impl'd */
 #define CMD_STRM_GETEVENTHANDLE_OFFSET  (CMD_STRM_BASE_OFFSET + 3)
 #define CMD_STRM_GETINFO_OFFSET	 (CMD_STRM_BASE_OFFSET + 4)
 #define CMD_STRM_IDLE_OFFSET	    (CMD_STRM_BASE_OFFSET + 5)
@@ -509,8 +512,8 @@ union Trapped_Args {
 
 /* Communication Memory Manager (UCMM) */
 #define CMD_CMM_BASE_OFFSET	     (CMD_STRM_END_OFFSET + 1)
-#define CMD_CMM_ALLOCBUF_OFFSET	 (CMD_CMM_BASE_OFFSET + 0)
-#define CMD_CMM_FREEBUF_OFFSET	  (CMD_CMM_BASE_OFFSET + 1)
+#define CMD_CMM_ALLOCBUF_OFFSET	 (CMD_CMM_BASE_OFFSET + 0)    /* Not Impl'd */
+#define CMD_CMM_FREEBUF_OFFSET	  (CMD_CMM_BASE_OFFSET + 1)   /* Not Impl'd */
 #define CMD_CMM_GETHANDLE_OFFSET	(CMD_CMM_BASE_OFFSET + 2)
 #define CMD_CMM_GETINFO_OFFSET	  (CMD_CMM_BASE_OFFSET + 3)
 #define CMD_CMM_END_OFFSET	      CMD_CMM_GETINFO_OFFSET
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 7226b5a..f95980b 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -456,6 +456,8 @@ DSP_STATUS WCD_InitComplete2(void)
 	return status;
 }
 
+/* TODO: Remove deprecated and not implemented ioctl wrappers */
+
 /*
  * ======== MGRWRAP_EnumNode_Info ========
  */
@@ -634,21 +636,11 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== MGRWRAP_GetProcessResourceInfo ========
  */
-u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
+						void *pr_ctxt)
 {
-    DSP_STATUS status = DSP_SOK;
-    u32 uSize = 0;
-    u8 *pBuf = MEM_Alloc(8092, MEM_NONPAGED);
-    GT_1trace(WCD_debugMask, GT_ENTER,
-	     "MGRWRAP_GetProcessResourcesInfo:uSize=%d :\n", uSize);
-    cp_to_usr(args->ARGS_PROC_GETTRACE.pBuf, pBuf, status, uSize);
-    GT_0trace(WCD_debugMask, GT_ENTER, "\n***********"
-	     "123MGRWRAP_GetProcessResourcesInfo:**************\n");
-    GT_0trace(WCD_debugMask, GT_ENTER, "\n***********"
-	     "456MGRWRAP_GetProcessResourcesInfo:**************\n");
-    cp_to_usr(args->ARGS_PROC_GETTRACE.pSize, &uSize, status, 1);
-    MEM_Free(pBuf);
-    return status;
+	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
+	return DSP_SOK;
 }
 #endif
 
@@ -732,14 +724,10 @@ func_end:
 /*
  * ======== PROCWRAP_Detach ========
  */
-u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 {
-	GT_1trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_Detach: entered args\n0x%x "
-		 "hProceesor \n", args->ARGS_PROC_DETACH.hProcessor);
-
 	/* PROC_Detach called at bridge_release only */
-
+	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
 	return DSP_SOK;
 }
 
@@ -1540,8 +1528,10 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== STRMWRAP_GetEventHandle ========
  */
-u32 STRMWRAP_GetEventHandle(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated STRMWRAP_GetEventHandle(union Trapped_Args *args,
+					void *pr_ctxt)
 {
+	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
 	return DSP_ENOTIMPL;
 }
 
@@ -1703,18 +1693,20 @@ u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
 /*
  * ======== CMMWRAP_CallocBuf ========
  */
-u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
+	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
 	return DSP_ENOTIMPL;
 }
 
 /*
  * ======== CMMWRAP_FreeBuf ========
  */
-u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
+u32 __deprecated CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
+	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
 	return DSP_ENOTIMPL;
 }
 
-- 
1.6.2.4

