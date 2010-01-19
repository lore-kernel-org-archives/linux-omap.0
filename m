From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/6] DSPBRIDGE: remove wrong comment from RequestBridgeResources
Date: Tue, 19 Jan 2010 14:54:08 -0600
Message-ID: <1263934449-16891-6-git-send-email-omar.ramirez@ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-3-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-4-git-send-email-omar.ramirez@ti.com>
 <1263934449-16891-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab0ASUoG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 15:44:06 -0500
In-Reply-To: <1263934449-16891-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch removes a wrong pointer and set to NULL dwSysCtrlBase
as it shouldn't be used anymore after iounmap.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 56ceb6c..9b07f25 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1138,11 +1138,9 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				iounmap((void *)pResources->dwPerPmBase);
 			if (pResources->dwCorePmBase)
 				iounmap((void *)pResources->dwCorePmBase);
-			if (pResources->dwSysCtrlBase) {
+			if (pResources->dwSysCtrlBase)
 				iounmap(pResources->dwSysCtrlBase);
-				/* don't set pResources->dwSysCtrlBase to null
-				 * as it is used in BOARD_Stop */
-			}
+
 			pResources->dwPrmBase = NULL;
 			pResources->dwCmBase = NULL;
 			pResources->dwMboxBase = NULL;
@@ -1152,6 +1150,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			pResources->dwMemBase[4] = (u32) NULL;
 			pResources->dwWdTimerDspBase = NULL;
 			pResources->dwDmmuBase = NULL;
+			pResources->dwSysCtrlBase = NULL;
 
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
 			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
-- 
1.6.2.4

