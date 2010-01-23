From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/5] DSPBRIDGE: remove crefs for SERVICES[Init|Exit]
Date: Fri, 22 Jan 2010 21:33:21 -0600
Message-ID: <1264217604-8021-3-git-send-email-omar.ramirez@ti.com>
References: <1264217604-8021-1-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887Ab0AWDXA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 22:23:00 -0500
In-Reply-To: <1264217604-8021-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

No point in having a module counter if these are called
only once.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/services.c |   92 +++++++++++++-------------------
 1 files changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index c3e11b4..efcb0a1 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -43,8 +43,6 @@
 static struct GT_Mask SERVICES_debugMask = { NULL, NULL };  /* GT trace var. */
 #endif
 
-static u32 cRefs;		/* SERVICES module reference count */
-
 /*
  *  ======== SERVICES_Exit ========
  *  Purpose:
@@ -53,26 +51,21 @@ static u32 cRefs;		/* SERVICES module reference count */
  */
 void SERVICES_Exit(void)
 {
-	DBC_Require(cRefs > 0);
+
 
 	GT_1trace(SERVICES_debugMask, GT_5CLASS, "SERVICES_Exit: cRefs 0x%x\n",
 		 cRefs);
 
-	cRefs--;
-	if (cRefs == 0) {
-		/* Uninitialize all SERVICES modules here */
-		NTFY_Exit();
-		SYNC_Exit();
-		CLK_Exit();
-		REG_Exit();
-		DBG_Exit();
-		CFG_Exit();
-		MEM_Exit();
-
-		GT_exit();
-	}
+	/* Uninitialize all SERVICES modules here */
+	NTFY_Exit();
+	SYNC_Exit();
+	CLK_Exit();
+	REG_Exit();
+	DBG_Exit();
+	CFG_Exit();
+	MEM_Exit();
 
-	DBC_Ensure(cRefs >= 0);
+	GT_exit();
 }
 
 /*
@@ -86,61 +79,50 @@ bool SERVICES_Init(void)
 	bool fCFG, fDBG, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
-	DBC_Require(cRefs >= 0);
-
-	if (cRefs == 0) {
+	GT_init();
+	GT_create(&SERVICES_debugMask, "OS");	/* OS for OSal */
 
-		GT_init();
-		GT_create(&SERVICES_debugMask, "OS");	/* OS for OSal */
-
-		GT_0trace(SERVICES_debugMask, GT_ENTER,
+	GT_0trace(SERVICES_debugMask, GT_ENTER,
 			 "SERVICES_Init: entered\n");
 
-		/* Perform required initialization of SERVICES modules. */
-		fMEM = MEM_Init();
-		fREG = REG_Init();
-		fCFG = CFG_Init();
-		fDBG = DBG_Init();
-		fSYNC = SYNC_Init();
-		fCLK  = CLK_Init();
-		fNTFY = NTFY_Init();
+	/* Perform required initialization of SERVICES modules. */
+	fMEM = MEM_Init();
+	fREG = REG_Init();
+	fCFG = CFG_Init();
+	fDBG = DBG_Init();
+	fSYNC = SYNC_Init();
+	fCLK  = CLK_Init();
+	fNTFY = NTFY_Init();
 
-		fInit = fCFG && fDBG &&
-			fMEM && fREG && fSYNC && fCLK;
+	fInit = fCFG && fDBG && fMEM && fREG && fSYNC && fCLK;
 
-		if (!fInit) {
-			if (fNTFY)
-				NTFY_Exit();
+	if (!fInit) {
+		if (fNTFY)
+			NTFY_Exit();
 
-			if (fSYNC)
-				SYNC_Exit();
+		if (fSYNC)
+			SYNC_Exit();
 
-			if (fCLK)
-				CLK_Exit();
+		if (fCLK)
+			CLK_Exit();
 
-			if (fREG)
-				REG_Exit();
+		if (fREG)
+			REG_Exit();
 
-			if (fDBG)
-				DBG_Exit();
+		if (fDBG)
+			DBG_Exit();
 
-			if (fCFG)
-				CFG_Exit();
+		if (fCFG)
+			CFG_Exit();
 
-			if (fMEM)
-				MEM_Exit();
+		if (fMEM)
+			MEM_Exit();
 
-		}
 	}
 
-	if (fInit)
-		cRefs++;
-
 	GT_1trace(SERVICES_debugMask, GT_5CLASS, "SERVICES_Init: cRefs 0x%x\n",
 		 cRefs);
 
-	DBC_Ensure((fInit && (cRefs > 0)) || (!fInit && (cRefs >= 0)));
-
 	return fInit;
 }
 
-- 
1.6.2.4

