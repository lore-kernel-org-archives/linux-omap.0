From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 2/5] DSPBRIDGE: remove crefs for SERVICES[Init|Exit]
Date: Tue, 26 Jan 2010 18:57:25 -0600
Message-ID: <1264553848-23555-3-git-send-email-omar.ramirez@ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab0A0Aqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 19:46:46 -0500
In-Reply-To: <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

No point in having a module counter if these are called
only once.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/services.c |  100 ++++++++++++--------------------
 1 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index c3e11b4..3db08e4 100644
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
@@ -53,26 +51,16 @@ static u32 cRefs;		/* SERVICES module reference count */
  */
 void SERVICES_Exit(void)
 {
-	DBC_Require(cRefs > 0);
-
-	GT_1trace(SERVICES_debugMask, GT_5CLASS, "SERVICES_Exit: cRefs 0x%x\n",
-		 cRefs);
-
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
-
-	DBC_Ensure(cRefs >= 0);
+	/* Uninitialize all SERVICES modules here */
+	NTFY_Exit();
+	SYNC_Exit();
+	CLK_Exit();
+	REG_Exit();
+	DBG_Exit();
+	CFG_Exit();
+	MEM_Exit();
+
+	GT_exit();
 }
 
 /*
@@ -86,61 +74,47 @@ bool SERVICES_Init(void)
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
-	GT_1trace(SERVICES_debugMask, GT_5CLASS, "SERVICES_Init: cRefs 0x%x\n",
-		 cRefs);
-
-	DBC_Ensure((fInit && (cRefs > 0)) || (!fInit && (cRefs >= 0)));
-
 	return fInit;
 }
 
-- 
1.6.2.4

