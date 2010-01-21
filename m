From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Thu, 21 Jan 2010 15:03:10 +0200
Message-ID: <1264078990-4829-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65379 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab0AUNEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 08:04:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omap.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a75b64a..91ab64f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -512,6 +512,10 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "No Exec file found \n");
 	}
 func_cont:
+	if (hProcObject->g_pszLastCoff) {
+		MEM_Free(hProcObject->g_pszLastCoff);
+		hProcObject->g_pszLastCoff = NULL;
+	}
 	MEM_FreeObject(hProcObject);
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
-- 
1.6.2.4

