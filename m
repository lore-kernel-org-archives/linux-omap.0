From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 4/5] DSPBRIDGE: Remove multiple initializations of REG module
Date: Tue, 26 Jan 2010 18:57:27 -0600
Message-ID: <1264553848-23555-5-git-send-email-omar.ramirez@ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-2-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-3-git-send-email-omar.ramirez@ti.com>
 <1264553848-23555-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42290 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab0A0Aqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 19:46:46 -0500
In-Reply-To: <1264553848-23555-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

REG module should be only initialized by services layer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index cb244f4..caa57f1 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -350,7 +350,6 @@ void DCD_Exit(void)
 
 	cRefs--;
 	if (cRefs == 0) {
-		REG_Exit();
 		COD_Exit();
 	}
 
@@ -821,7 +820,6 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
  */
 bool DCD_Init(void)
 {
-	bool fInitREG;
 	bool fInitCOD;
 	bool fInit = true;
 
@@ -833,18 +831,13 @@ bool DCD_Init(void)
 	if (cRefs == 0) {
 		/* Initialize required modules. */
 		fInitCOD = COD_Init();
-		fInitREG = REG_Init();
 
-		if (!fInitCOD || !fInitREG) {
+		if (!fInitCOD) {
 			fInit = false;
 			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
 			/* Exit initialized modules. */
 			if (fInitCOD)
 				COD_Exit();
-
-			if (fInitREG)
-				REG_Exit();
-
 		}
 	}
 
-- 
1.6.2.4

