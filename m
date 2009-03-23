From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fix error handling in NODE_GetUUIDProps
Date: Mon, 23 Mar 2009 15:15:07 +0200
Message-ID: <1237814107-19422-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63935 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209AbZCWNPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 09:15:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Seth Forshee <seth.forshee@gmail.com>

From: Seth Forshee <seth.forshee@gmail.com>

The error handling is ineffective and can lead to an oops.

Acked-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
---
 drivers/dsp/bridge/rmgr/node.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 357d1cf..243e14b 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3285,16 +3285,23 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		 pNodeId, pNodeProps);
 
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
-	if (DSP_SUCCEEDED(status)) {
-		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
-		if (hNodeMgr == NULL)
-			status = DSP_EFAIL;
+	if (DSP_FAILED(status))
+		goto func_end;
+
+	status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
+	if (DSP_FAILED(status))
+		goto func_end;
+	if (hNodeMgr == NULL) {
+		status = DSP_EFAIL;
+		goto func_end;
 	}
 
-	/*  Enter the critical section.  This is needed because
-	* DCD_GetObjectDef will ultimately end up calling DBLL_open/close,
-	* which needs to be protected in order to not corrupt the zlib manager
-	* (COD). */
+	/*
+	 * Enter the critical section. This is needed because
+	 * DCD_GetObjectDef will ultimately end up calling DBLL_open/close,
+	 * which needs to be protected in order to not corrupt the zlib manager
+	 * (COD).
+	 */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
 
 	if (DSP_SUCCEEDED(status)) {
@@ -3323,9 +3330,8 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		}
 		/*  Leave the critical section, we're done.  */
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
-
 	}
-
+func_end:
 	return status;
 }
 
-- 
1.5.6.3

