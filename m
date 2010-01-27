From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 1/5] DSPBRIDGE: Avoid multiple calls to SERVICES_[Init|Exit]
Date: Tue, 26 Jan 2010 18:57:24 -0600
Message-ID: <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab0A0Aqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 19:46:46 -0500
In-Reply-To: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Avoid calling multiple times to SERVICES_[Init|Exit] functions,
these should be called once at probe and exit respectively.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 962cac6..2afe222 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -302,7 +302,6 @@ void WCD_Exit(void)
 		MGR_Exit();
 		RMM_exit();
 		DRV_Exit();
-		SERVICES_Exit();
 	}
 	DBC_Ensure(WCD_cRefs >= 0);
 }
@@ -315,12 +314,10 @@ void WCD_Exit(void)
 bool WCD_Init(void)
 {
 	bool fInit = true;
-	bool fDRV, fDEV, fCOD, fSERVICES, fCHNL, fMSG, fIO;
+	bool fDRV, fDEV, fCOD, fCHNL, fMSG, fIO;
 	bool fMGR, fPROC, fNODE, fDISP, fNTFY, fSTRM, fRMM;
 
 	if (WCD_cRefs == 0) {
-		/* initialize all SERVICES modules */
-		fSERVICES = SERVICES_Init();
 		/* initialize debugging module */
 		DBC_Assert(!WCD_debugMask.flags);
 		GT_create(&WCD_debugMask, "CD");    /* CD for class driver */
@@ -338,13 +335,10 @@ bool WCD_Init(void)
 		fIO = IO_Init();
 		fDEV = DEV_Init();
 		fCOD = COD_Init();
-		fInit = fSERVICES && fDRV && fDEV && fCHNL && fCOD &&
+		fInit = fDRV && fDEV && fCHNL && fCOD &&
 			fMSG && fIO;
 		fInit = fInit && fMGR && fPROC && fRMM;
 		if (!fInit) {
-			if (fSERVICES)
-				SERVICES_Exit();
-
 			if (fDRV)
 				DRV_Exit();
 
-- 
1.6.2.4

