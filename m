From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/6] DSPBRIDGE: remove NLDR_Free wrapper function
Date: Tue, 19 Jan 2010 14:54:05 -0600
Message-ID: <1263934449-16891-3-git-send-email-omar.ramirez@ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0ASUoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 15:44:01 -0500
In-Reply-To: <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Fernando Guzman Lugo <x0095849@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

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
index 8d136ae..bdf7622 100644
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
index 2e24923..51156bd 100644
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
@@ -2810,7 +2809,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 	}
 
 	if (hNode->hNldrNode) {
-		hNodeMgr->nldrFxns.pfnFree(hNode->hNldrNode);
+		MEM_Free(hNode->hNldrNode);
 		hNode->hNldrNode = NULL;
 	}
 	hNode->hNodeMgr = NULL;
-- 
1.6.2.4

