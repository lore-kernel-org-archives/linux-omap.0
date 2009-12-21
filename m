From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/4] DSPBRIDGE: remove NLDR_Free wrapper function
Date: Mon, 21 Dec 2009 16:51:29 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9F8ABD6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51125 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948AbZLUWvb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 17:51:31 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBLMpVLA023857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:51:31 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBLMpU9L011300
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:51:30 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBLMpUDN006283
	for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 16:51:30 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 7e60e301595911595daa466d3994be4aed1fc79e Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 2 Dec 2009 18:03:25 -0600
Subject: [PATCH] DSPBRIDGE: remove NLDR_Free wrapper function

This patch removes the NLDR_Free which is a wrapper function

Signed-off-by: Fernando Guzman Lugo <x0095849@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/nldr.h     |    1 -
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    1 -
 drivers/dsp/bridge/rmgr/nldr.c                  |   15 +--------------
 drivers/dsp/bridge/rmgr/node.c                  |    3 +--
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/nldr.h b/arch/arm/plat-omap/include/dspbridge/nldr.h
index 5a0538a..4f0639a 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldr.h
@@ -38,7 +38,6 @@
 
 	extern void NLDR_Delete(struct NLDR_OBJECT *hNldr);
 	extern void NLDR_Exit(void);
-	extern void NLDR_Free(struct NLDR_NODEOBJECT *hNldrNode);
 
 	extern DSP_STATUS NLDR_GetFxnAddr(struct NLDR_NODEOBJECT *hNldrNode,
 					  char *pstrFxn, u32 *pulAddr);
diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index 18d3bb9..b0646fa 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -287,7 +287,6 @@
 		NLDR_CREATEFXN pfnCreate;
 		NLDR_DELETEFXN pfnDelete;
 		NLDR_EXITFXN pfnExit;
-		NLDR_FREEFXN pfnFree;
 		NLDR_GETFXNADDRFXN pfnGetFxnAddr;
 		NLDR_INITFXN pfnInit;
 		NLDR_LOADFXN pfnLoad;
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 2f45c2d..d0a0ca7 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -435,7 +435,7 @@ DSP_STATUS NLDR_Allocate(struct NLDR_OBJECT *hNldr, void *pPrivRef,
 	}
 	/* Cleanup on failure */
 	if (DSP_FAILED(status) && pNldrNode)
-		NLDR_Free((struct NLDR_NODEOBJECT *) pNldrNode);
+		MEM_FreeObject(pNldrNode);
 
 	DBC_Ensure((DSP_SUCCEEDED(status) &&
 		  MEM_IsValidHandle(((struct NLDR_NODEOBJECT *)(*phNldrNode)),
@@ -718,19 +718,6 @@ void NLDR_Exit(void)
 }
 
 /*
- *  ======== NLDR_Free ========
- */
-void NLDR_Free(struct NLDR_NODEOBJECT *hNldrNode)
-{
-	DBC_Require(cRefs > 0);
-	DBC_Require(MEM_IsValidHandle(hNldrNode, NLDR_NODESIGNATURE));
-
-	GT_1trace(NLDR_debugMask, GT_ENTER, "NLDR_Free(0x%x)\n", hNldrNode);
-
-	MEM_FreeObject(hNldrNode);
-}
-
-/*
  *  ======== NLDR_GetFxnAddr ========
  */
 DSP_STATUS NLDR_GetFxnAddr(struct NLDR_NODEOBJECT *hNldrNode, char *pstrFxn,
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 3cc0bad..da887a1 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -284,7 +284,6 @@ static struct NLDR_FXNS nldrFxns = {
 	NLDR_Create,
 	NLDR_Delete,
 	NLDR_Exit,
-	NLDR_Free,
 	NLDR_GetFxnAddr,
 	NLDR_Init,
 	NLDR_Load,
@@ -2808,7 +2807,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 	}
 
 	if (hNode->hNldrNode) {
-		hNodeMgr->nldrFxns.pfnFree(hNode->hNldrNode);
+		MEM_Free(hNode->hNldrNode);
 		hNode->hNldrNode = NULL;
 	}
 	hNode->hNodeMgr = NULL;
-- 
1.6.0.4

