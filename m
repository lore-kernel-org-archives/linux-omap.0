From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 7/7] DSPBRIDGE: Move PROC object abstraction to proc.c
Date: Wed, 16 Dec 2009 21:45:58 -0600
Message-ID: <1261021558-19036-8-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-5-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-6-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933252AbZLQDik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:40 -0500
In-Reply-To: <1261021558-19036-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Move object structure to PROC module.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/proc.h |   24 ------------------------
 drivers/dsp/bridge/rmgr/proc.c              |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 935afd0..d63c5cf 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -66,30 +66,6 @@
 #include <dspbridge/devdefs.h>
 #include <dspbridge/drv.h>
 
-/* The PROC_OBJECT structure.   */
-struct PROC_OBJECT {
-	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
-	u32 dwSignature;		/* Used for object validation */
-	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
-	u32 hProcess;			/* Process owning this Processor */
-	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
-	u32 uAttachCount;		/* Processor attach count */
-	u32 uProcessor;			/* Processor number */
-	u32 uTimeout;			/* Time out count */
-	enum DSP_PROCSTATE sState;	/* Processor state */
-	u32 ulUnit;			/* DDSP unit number */
-	bool bIsAlreadyAttached;	/*
-					 * True if the Device below has
-					 * GPP Client attached
-					 */
-	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
-	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
-	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to WMD */
-	char *g_pszLastCoff;
-	struct list_head proc_object;
-};
-
-
 /*
  *  ======== PROC_Attach ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 8501b06..3055078 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -166,6 +166,29 @@ extern char *iva_img;
 static struct GT_Mask PROC_DebugMask = { NULL, NULL };	/* WCD MGR Mask */
 #endif
 
+/* The PROC_OBJECT structure.   */
+struct PROC_OBJECT {
+	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
+	u32 dwSignature;		/* Used for object validation */
+	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
+	u32 hProcess;			/* Process owning this Processor */
+	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
+	u32 uAttachCount;		/* Processor attach count */
+	u32 uProcessor;			/* Processor number */
+	u32 uTimeout;			/* Time out count */
+	enum DSP_PROCSTATE sState;	/* Processor state */
+	u32 ulUnit;			/* DDSP unit number */
+	bool bIsAlreadyAttached;	/*
+					 * True if the Device below has
+					 * GPP Client attached
+					 */
+	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
+	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
+	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to WMD */
+	char *g_pszLastCoff;
+	struct list_head proc_object;
+};
+
 static u32 cRefs;
 
 struct SYNC_CSOBJECT *hProcLock;	/* For critical sections */
-- 
1.6.2.4

