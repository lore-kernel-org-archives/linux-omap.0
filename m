From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/5] DSPBRIDGE: Remove multiple initializations of REG module
Date: Fri, 22 Jan 2010 21:33:23 -0600
Message-ID: <1264217604-8021-5-git-send-email-omar.ramirez@ti.com>
References: <1264217604-8021-1-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-2-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-3-git-send-email-omar.ramirez@ti.com>
 <1264217604-8021-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab0AWDXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 22:23:01 -0500
In-Reply-To: <1264217604-8021-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

REG module should be only initialized by services layer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index cb244f4..d90aa83 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -350,7 +350,6 @@ void DCD_Exit(void)
 
 	cRefs--;
 	if (cRefs == 0) {
-		REG_Exit();
 		COD_Exit();
 	}
 
@@ -833,18 +832,13 @@ bool DCD_Init(void)
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

