From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 13/17] DSPBRIDGE: check the status of DMM_GetHandle
Date: Tue, 15 Dec 2009 00:19:54 -0600
Message-ID: <1260857998-19349-14-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbZLOGMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:53 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Check the status of DMM_GetHandle

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index ab0b913..89b1ff3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1833,16 +1833,19 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
 	}
 
 	status = DMM_GetHandle(hProcessor, &hDmmMgr);
-	/* Critical section */
-	(void)SYNC_EnterCS(hProcLock);
 	if (DSP_FAILED(status)) {
 		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-			 "Failed to get DMM Mgr handle: 0x%x\n", status);
-	} else {
-		/* Update DMM structures. Get the size to unmap.
-		 This function returns error if the VA is not mapped */
-		status = DMM_UnMapMemory(hDmmMgr, (u32) vaAlign, &sizeAlign);
+			"Failed to get DMM Mgr handle: 0x%x\n", status);
+		goto func_end;
 	}
+
+	/* Critical section */
+	(void)SYNC_EnterCS(hProcLock);
+	/*
+	 * Update DMM structures. Get the size to unmap.
+	 * This function returns error if the VA is not mapped
+	 */
+	status = DMM_UnMapMemory(hDmmMgr, (u32) vaAlign, &sizeAlign);
 	/* Remove mapping from the page tables. */
 	if (DSP_SUCCEEDED(status)) {
 		status = (*pProcObject->pIntfFxns->pfnBrdMemUnMap)
-- 
1.6.2.4

