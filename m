From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 7/8] DSPBRIDGE: typedef cleanup -BRD_STATUS
Date: Sat, 6 Feb 2010 06:53:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A776238@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53533 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223Ab0BFBXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:23:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o161NbuB002382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:23:39 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o161Nabr001564
	for <linux-omap@vger.kernel.org>; Sat, 6 Feb 2010 06:53:36 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 75fabc1654f4671906f64c12a348aa38625d4f28 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 20:40:48 -0600
Subject: [PATCH] DSPBRIDGE: typedef cleanup - BRD_STATUS

This patch removes the typedef BRD_STATUS and replaces
it with the normal C type. Here it need not be u32 value.
So replacing it with int type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/brddefs.h |    1 -
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                 |   10 +++++-----
 drivers/dsp/bridge/wmd/tiomap3430.c            |    4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/brddefs.h b/arch/arm/plat-omap/include/dspbridge/brddefs.h
index ca503e2..ff83166 100644
--- a/arch/arm/plat-omap/include/dspbridge/brddefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/brddefs.h
@@ -32,7 +32,6 @@
 #define BRD_RETENTION     0x8       /* Retention mode */
 #define BRD_DSP_HIBERNATION     0x9       /* DSP initiated hibernation */
 #define BRD_ERROR		0xA       /* Board state is Error */
-	typedef u32 BRD_STATUS;
 
 /* BRD Object */
 	struct BRD_OBJECT;
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 748b1c6..70f3970 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -244,7 +244,7 @@
  */
        typedef DSP_STATUS(*
 			   WMD_BRD_STATUS) (struct WMD_DEV_CONTEXT *hDevContext,
-					    OUT BRD_STATUS * pdwState);
+					    int *pdwState);
 
 /*
  *  ======== WMD_BRD_Read ========
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 439dbe8..5a33df7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -808,7 +808,7 @@ DSP_STATUS PROC_GetState(void *hProcessor,
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-	BRD_STATUS brdStatus;
+	int brdStatus;
 	struct DEH_MGR *hDehMgr;
 
 	DBC_Require(cRefs > 0);
@@ -949,7 +949,7 @@ DSP_STATUS PROC_Load(void *hProcessor, IN CONST s32 iArgc,
 	u32 dwExtEnd;
 	u32 uProcId;
 #ifdef CONFIG_BRIDGE_DEBUG
-	BRD_STATUS uBrdState;
+	int uBrdState;
 #endif
 
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
@@ -1442,7 +1442,7 @@ DSP_STATUS PROC_Start(void *hProcessor)
 	struct COD_MANAGER *hCodMgr;	/* Code manager handle    */
 	u32 dwDspAddr;	/* Loaded code's entry point.    */
 #ifdef CONFIG_BRIDGE_DEBUG
-	BRD_STATUS uBrdState;
+	int uBrdState;
 #endif
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Start, args:\n\t"
@@ -1538,7 +1538,7 @@ DSP_STATUS PROC_Stop(void *hProcessor)
 	u32 uNodeTabSize = 1;
 	u32 uNumNodes = 0;
 	u32 uNodesAllocated = 0;
-	BRD_STATUS uBrdState;
+	int uBrdState;
 
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Stop, args:\n\t"
@@ -1730,7 +1730,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcObject;
 	struct MSG_MGR *hMsgMgr;
 #ifdef CONFIG_BRIDGE_DEBUG
-	BRD_STATUS uBrdState;
+	int uBrdState;
 #endif
 
 	DBC_Require(cRefs > 0);
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 3b9052e..a17a9ff 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -93,7 +93,7 @@ static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *pDevContext,
 static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *pDevContext,
 			u32 dwDSPAddr);
 static DSP_STATUS WMD_BRD_Status(struct WMD_DEV_CONTEXT *pDevContext,
-			OUT BRD_STATUS *pdwState);
+			int *pdwState);
 static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *pDevContext);
 static DSP_STATUS WMD_BRD_Write(struct WMD_DEV_CONTEXT *pDevContext,
 			IN u8 *pbHostBuf,
@@ -926,7 +926,7 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
  *      Returns the board status.
  */
 static DSP_STATUS WMD_BRD_Status(struct WMD_DEV_CONTEXT *hDevContext,
-				 OUT BRD_STATUS *pdwState)
+				 int *pdwState)
 {
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	*pdwState = pDevContext->dwBrdState;
-- 
1.6.0.4

