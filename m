From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Wed,  2 Sep 2009 21:59:42 +0300
Message-ID: <1251917982-23690-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37413 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZIBS7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 14:59:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com

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

