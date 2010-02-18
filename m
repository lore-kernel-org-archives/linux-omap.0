From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 08/12] DSPBRIDGE: Remove GT_trace variables for pmgr
Date: Thu, 18 Feb 2010 15:37:59 -0600
Message-ID: <1266529083-2358-9-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab0BRVZ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:28 -0500
In-Reply-To: <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes variables used to store masks and flags
used for the previous debug implementation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c |   10 ----------
 drivers/dsp/bridge/pmgr/cmm.c  |    9 ---------
 drivers/dsp/bridge/pmgr/cod.c  |    9 ---------
 drivers/dsp/bridge/pmgr/dbll.c |   15 ++-------------
 drivers/dsp/bridge/pmgr/dev.c  |    6 ------
 drivers/dsp/bridge/pmgr/dmm.c  |   10 ----------
 drivers/dsp/bridge/pmgr/io.c   |    9 ---------
 drivers/dsp/bridge/pmgr/msg.c  |    8 --------
 drivers/dsp/bridge/pmgr/wcd.c  |    6 ------
 9 files changed, 2 insertions(+), 80 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 14a060c..cfece9c 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -47,11 +47,6 @@
 
 /*  ----------------------------------- Globals */
 static u32 cRefs;
-#if GT_TRACE
-static struct GT_Mask CHNL_DebugMask = { NULL, NULL };	/* WCD CHNL Mask */
-#endif
-
-
 
 /*
  *  ======== CHNL_Create ========
@@ -165,11 +160,6 @@ bool CHNL_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!CHNL_DebugMask.flags);
-		GT_create(&CHNL_DebugMask, "CH");   /* "CH" for CHannel */
-	}
-
 	if (fRetval)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index b30b724..e8fed86 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -144,10 +144,6 @@ struct CMM_MNODE {
 
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask CMM_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
-
 static u32 cRefs;		/* module reference count */
 
 /*  ----------------------------------- Function Prototypes */
@@ -525,11 +521,6 @@ bool CMM_Init(void)
 	bool fRetval = true;
 
 	DBC_Require(cRefs >= 0);
-	if (cRefs == 0) {
-		/* Set the Trace mask */
-		/* "CM" for Comm Memory manager */
-		GT_create(&CMM_debugMask, "CM");
-	}
 	if (fRetval)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 62629e1..9552618 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -76,10 +76,6 @@ struct COD_LIBRARYOBJ {
 
 static u32 cRefs = 0L;
 
-#if GT_TRACE
-static struct GT_Mask COD_debugMask = { NULL, NULL };
-#endif
-
 static struct DBLL_Fxns dbllFxns = {
 	(DBLL_CloseFxn) DBLL_close,
 	(DBLL_CreateFxn) DBLL_create,
@@ -478,11 +474,6 @@ bool COD_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!COD_debugMask.flags);
-		GT_create(&COD_debugMask, "CO");
-	}
-
 	if (fRetVal)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 86832a3..0970974 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -199,10 +199,6 @@ static u16 nameHash(void *name, u16 maxBucket);
 static bool nameMatch(void *name, void *sp);
 static void symDelete(void *sp);
 
-#if GT_TRACE
-static struct GT_Mask DBLL_debugMask = { NULL, NULL };  /* GT trace variable */
-#endif
-
 static u32 cRefs; 		/* module reference count */
 
 /* Symbol Redefinition */
@@ -302,12 +298,8 @@ void DBLL_exit(void)
 
 	cRefs--;
 
-	if (cRefs == 0) {
+	if (cRefs == 0)
 		GH_exit();
-#if GT_TRACE
-		DBLL_debugMask.flags = NULL;
-#endif
-	}
 
 	DBC_Ensure(cRefs >= 0);
 }
@@ -455,11 +447,8 @@ bool DBLL_init(void)
 {
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!DBLL_debugMask.flags);
-		GT_create(&DBLL_debugMask, "DL"); 	/* "DL" for dbDL */
+	if (cRefs == 0)
 		GH_init();
-	}
 
 	cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index e4450bc..20faf87 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -89,9 +89,6 @@ struct DEV_OBJECT {
 
 /*  ----------------------------------- Globals */
 static u32 cRefs;		/* Module reference count */
-#if GT_TRACE
-static struct GT_Mask debugMask = { NULL, NULL };	/* For debugging */
-#endif
 
 /*  ----------------------------------- Function Prototypes */
 static DSP_STATUS FxnNotImplemented(int arg, ...);
@@ -775,9 +772,6 @@ bool DEV_Init(void)
 	DBC_Require(cRefs >= 0);
 
 	if (cRefs == 0) {
-		/* Set the Trace mask */
-		DBC_Assert(!debugMask.flags);
-		GT_create(&debugMask, "DV");	/* "DV" for DeVice */
 		fCmm = CMM_Init();
 		fDmm = DMM_Init();
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 098743f..9a1c6b0 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -63,10 +63,6 @@ struct DMM_OBJECT {
 
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask DMM_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
-
 static u32 cRefs;		/* module reference count */
 struct MapPage {
 	u32   RegionSize:15;
@@ -258,12 +254,6 @@ bool DMM_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		/* Set the Trace mask */
-		/*"DM" for Dymanic Memory Manager */
-		GT_create(&DMM_debugMask, "DM");
-	}
-
 	if (fRetval)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index c6a4168..846562a 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -43,10 +43,6 @@
 /*  ----------------------------------- Globals */
 static u32 cRefs;
 
-#if GT_TRACE
-static struct GT_Mask IO_DebugMask = { NULL, NULL };	/* WCD IO Mask */
-#endif
-
 /*
  *  ======== IO_Create ========
  *  Purpose:
@@ -140,11 +136,6 @@ bool IO_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!IO_DebugMask.flags);
-		GT_create(&IO_DebugMask, "IO");	/* "IO" for IO */
-	}
-
 	if (fRetval)
 		cRefs++;
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 34bac4e..b7f3fc4 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -42,9 +42,6 @@
 #include <dspbridge/msg.h>
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask MSG_debugMask = { NULL, NULL };	/* GT trace variable */
-#endif
 static u32 cRefs;		/* module reference count */
 
 /*
@@ -128,11 +125,6 @@ bool MSG_Init(void)
 {
 	DBC_Require(cRefs >= 0);
 
-	if (cRefs == 0) {
-		DBC_Assert(!MSG_debugMask.flags);
-		GT_create(&MSG_debugMask, "MS");	/* "MS" for MSg */
-	}
-
 	cRefs++;
 
 	DBC_Ensure(cRefs >= 0);
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 4b8ae3d..20a2b04 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -78,9 +78,6 @@ struct WCD_Cmd {
 } ;
 
 /*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
-#endif
 static u32 WCD_cRefs;
 
 /*
@@ -304,9 +301,6 @@ bool WCD_Init(void)
 	bool fMGR, fPROC, fNODE, fDISP, fSTRM, fRMM;
 
 	if (WCD_cRefs == 0) {
-		/* initialize debugging module */
-		DBC_Assert(!WCD_debugMask.flags);
-		GT_create(&WCD_debugMask, "CD");    /* CD for class driver */
 		/* initialize class driver and other modules */
 		fDRV = DRV_Init();
 		fMGR = MGR_Init();
-- 
1.6.2.4

