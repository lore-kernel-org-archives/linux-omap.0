From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 06/12] DSPBRIDGE: Remove GT_trace variables for rmgr
Date: Thu, 18 Feb 2010 15:37:57 -0600
Message-ID: <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0BRVZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:25:28 -0500
In-Reply-To: <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes variables used to store masks and flags
used for the previous debug implementation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c         |    2 --
 drivers/dsp/bridge/rmgr/disp.c          |   10 ----------
 drivers/dsp/bridge/rmgr/drv.c           |    4 ----
 drivers/dsp/bridge/rmgr/drv_interface.c |    5 -----
 drivers/dsp/bridge/rmgr/dspdrv.c        |    5 -----
 drivers/dsp/bridge/rmgr/mgr.c           |    9 ---------
 drivers/dsp/bridge/rmgr/nldr.c          |   11 ++---------
 drivers/dsp/bridge/rmgr/node.c          |    9 ---------
 drivers/dsp/bridge/rmgr/proc.c          |   10 +---------
 drivers/dsp/bridge/rmgr/rmm.c           |   10 ----------
 drivers/dsp/bridge/rmgr/strm.c          |   10 ----------
 11 files changed, 3 insertions(+), 82 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 067f7a0..9fd05a0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -67,8 +67,6 @@ struct DCD_MANAGER {
 static u32 cRefs;
 static u32 cEnumRefs;
 
-extern struct GT_Mask curTrace;
-
 /* Helper function prototypes. */
 static s32 Atoi(char *pszBuf);
 static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 8c05593..6ae3bcb 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -81,11 +81,6 @@ struct DISP_OBJECT {
 
 static u32 cRefs;
 
-/* Debug msgs: */
-#if GT_TRACE
-static struct GT_Mask DISP_DebugMask = { NULL, NULL };
-#endif
-
 static void DeleteDisp(struct DISP_OBJECT *hDisp);
 static DSP_STATUS FillStreamDef(RMS_WORD *pdwBuf, u32 *ptotal, u32 offset,
 				struct NODE_STRMDEF strmDef, u32 max,
@@ -219,11 +214,6 @@ bool DISP_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!DISP_DebugMask.flags);
-		GT_create(&DISP_DebugMask, "DI");  /* "DI" for DIspatcher */
-	}
-
 	if (fRetVal)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index f3e2632..177d676 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -66,10 +66,6 @@ struct DRV_EXT {
 /*  ----------------------------------- Globals */
 static s32 cRefs;
 
-#if GT_TRACE
-extern struct GT_Mask curTrace;
-#endif
-
 /*  ----------------------------------- Function Prototypes */
 static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 fRequest);
 static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 4045784..24246d5 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -149,10 +149,6 @@ MODULE_VERSION(DSPBRIDGE_VERSION);
 
 static char *driver_name = DRIVER_NAME;
 
-#ifdef CONFIG_BRIDGE_DEBUG
-static struct GT_Mask driverTrace;
-#endif /* CONFIG_BRIDGE_DEBUG */
-
 static struct file_operations bridge_fops = {
 	.open		= bridge_open,
 	.release	= bridge_release,
@@ -261,7 +257,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 			NULL, "DspBridge");
 
 	GT_init();
-	GT_create(&driverTrace, "LD");
 
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (GT_str)
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 59c2ecb..0fdb150 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -44,9 +44,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/dspdrv.h>
 
-/*  ----------------------------------- Globals */
-struct GT_Mask curTrace;
-
 /*
  *  ======== DSP_Init ========
  *  	Allocates bridge resources. Loads a base image onto DSP, if specified.
@@ -59,8 +56,6 @@ u32 DSP_Init(OUT u32 *initStatus)
 	u32 deviceNode;
 	u32 deviceNodeString;
 
-	GT_create(&curTrace, "DD");
-
 	if (!WCD_Init())
 		goto func_cont;
 
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 73d7a66..e63aaa1 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -50,10 +50,6 @@ struct MGR_OBJECT {
 };
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask MGR_DebugMask = { NULL, NULL };
-#endif
-
 static u32 cRefs;
 
 /*
@@ -355,11 +351,6 @@ bool MGR_Init(void)
 	DBC_Require(cRefs >= 0);
 
 	if (cRefs == 0) {
-
-		/* Set the Trace mask */
-		DBC_Assert(!MGR_DebugMask.flags);
-
-		GT_create(&MGR_DebugMask, "MG");	/* "MG" for Manager */
 		fInitDCD = DCD_Init();	/*  DCD Module */
 
 		if (!fInitDCD)
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index fb5a788..5c1266d 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -292,7 +292,6 @@ static struct DBLL_Fxns dbllFxns = {
 	(DBLL_UnloadSectFxn) DBLL_unloadSect,
 };
 
-static struct GT_Mask NLDR_debugMask = { NULL, NULL };	/* GT trace variable */
 static u32 cRefs;		/* module reference count */
 
 static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
@@ -679,10 +678,8 @@ void NLDR_Exit(void)
 
 	cRefs--;
 
-	if (cRefs == 0) {
+	if (cRefs == 0)
 		RMM_exit();
-		NLDR_debugMask.flags = NULL;
-	}
 
 	DBC_Ensure(cRefs >= 0);
 }
@@ -801,12 +798,8 @@ bool NLDR_Init(void)
 {
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!NLDR_debugMask.flags);
-		GT_create(&NLDR_debugMask, "NL");	/* "NL" for NLdr */
-
+	if (cRefs == 0)
 		RMM_init();
-	}
 
 	cRefs++;
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 48a7728..cb3d324 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -266,10 +266,6 @@ static u32 Ovly(void *pPrivRef, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 static u32 Write(void *pPrivRef, u32 ulDspAddr, void *pBuf,
 			u32 ulNumBytes, u32 nMemSpace);
 
-#if GT_TRACE
-static struct GT_Mask NODE_debugMask = { NULL, NULL };  /* GT trace variable */
-#endif
-
 #ifdef DSP_DMM_DEBUG
 extern u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr);
 #endif
@@ -1930,11 +1926,6 @@ bool NODE_Init(void)
 {
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!NODE_debugMask.flags);
-		GT_create(&NODE_debugMask, "NO");	/* "NO" for NOde */
-	}
-
 	cRefs++;
 
 	return true;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index d8137c8..8489cd3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -72,9 +72,6 @@
 extern char *iva_img;
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask PROC_DebugMask = { NULL, NULL };	/* WCD MGR Mask */
-#endif
 
 /* The PROC_OBJECT structure.   */
 struct PROC_OBJECT {
@@ -785,13 +782,8 @@ bool PROC_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		/* Set the Trace mask */
-		DBC_Assert(!PROC_DebugMask.flags);
-		GT_create(&PROC_DebugMask, "PR");  /* "PR" for Processor */
-
+	if (cRefs == 0)
 		(void)SYNC_InitializeCS(&hProcLock);
-	}
 
 	if (fRetval)
 		cRefs++;
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 8cf66ce..188faba 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -87,10 +87,6 @@ struct RMM_TargetObj {
 	struct LST_LIST *ovlyList;	/* List of overlay memory in use */
 };
 
-#if GT_TRACE
-static struct GT_Mask RMM_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
-
 static u32 cRefs;		/* module reference count */
 
 static bool allocBlock(struct RMM_TargetObj *target, u32 segid, u32 size,
@@ -367,12 +363,6 @@ bool RMM_init(void)
 {
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!RMM_debugMask.flags);
-		GT_create(&RMM_debugMask, "RM");	/* "RM" for RMm */
-
-	}
-
 	cRefs++;
 
 	return true;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 909a2b1..6b62e41 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -91,9 +91,6 @@ struct STRM_MGR {
 } ;
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask STRM_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
 static u32 cRefs;		/* module reference count */
 
 /*  ----------------------------------- Function Prototypes */
@@ -412,13 +409,6 @@ bool STRM_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-#if GT_TRACE
-		DBC_Assert(!STRM_debugMask.flags);
-		GT_create(&STRM_debugMask, "ST");	/* "ST" for STrm */
-#endif
-	}
-
 	if (fRetVal)
 		cRefs++;
 
-- 
1.6.2.4

