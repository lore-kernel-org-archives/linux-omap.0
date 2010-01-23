From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/5] DSPBRIDGE: Remove multiple initializations of NTFY module
Date: Fri, 22 Jan 2010 21:33:24 -0600
Message-ID: <1264217604-8021-6-git-send-email-omar.ramirez@ti.com>
References: <1264217604-8021-1-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-2-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-3-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-4-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49720 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887Ab0AWDW7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 22:22:59 -0500
In-Reply-To: <1264217604-8021-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

NTFY module should be only initialized by services layer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 2afe222..b92386a 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -295,7 +295,6 @@ void WCD_Exit(void)
 		MSG_Exit();
 		IO_Exit();
 		STRM_Exit();
-		NTFY_Exit();
 		DISP_Exit();
 		NODE_Exit();
 		PROC_Exit();
@@ -315,7 +314,7 @@ bool WCD_Init(void)
 {
 	bool fInit = true;
 	bool fDRV, fDEV, fCOD, fCHNL, fMSG, fIO;
-	bool fMGR, fPROC, fNODE, fDISP, fNTFY, fSTRM, fRMM;
+	bool fMGR, fPROC, fNODE, fDISP, fSTRM, fRMM;
 
 	if (WCD_cRefs == 0) {
 		/* initialize debugging module */
@@ -327,7 +326,6 @@ bool WCD_Init(void)
 		fPROC = PROC_Init();
 		fNODE = NODE_Init();
 		fDISP = DISP_Init();
-		fNTFY = NTFY_Init();
 		fSTRM = STRM_Init();
 		fRMM = RMM_init();
 		fCHNL = CHNL_Init();
@@ -357,9 +355,6 @@ bool WCD_Init(void)
 			if (fDISP)
 				DISP_Exit();
 
-			if (fNTFY)
-				NTFY_Exit();
-
 			if (fCHNL)
 				CHNL_Exit();
 
-- 
1.6.2.4

