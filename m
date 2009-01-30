From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH 6/6] DSPBRIDGE: Avoid kill task command when dsp
 crashed
Date: Thu, 29 Jan 2009 18:25:35 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52CC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56650 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZA3AZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 19:25:42 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0U0PabU026053
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:25:41 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0U0Park021368
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:25:36 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez Luna <x00omar@ti.com>
Date: Wed, 28 Jan 2009 19:11:45 -0600
Subject: [PATCH] DSPBRIDGE: Avoid kill task command when dsp crashed

Node_Terminate will not attempt to send a kill task
message if DSP is already in error state.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 61f5d14..31d8de9 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2667,6 +2667,7 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 	DSP_STATUS status = DSP_SOK;
 	u32 procId, killTimeOut;
 	struct DEH_MGR *hDehMgr;
+	struct DSP_PROCESSORSTATE procStatus;
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pStatus != NULL);
@@ -2720,6 +2721,20 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 		 */
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Terminate: env = 0x%x\n", hNode->nodeEnv);
+
+		status = PROC_GetState(pNode->hProcessor, &procStatus,
+					sizeof(struct DSP_PROCESSORSTATE));
+		if (DSP_FAILED(status))
+			goto func_cont;
+		/* If processor is in error state then don't attempt to send
+		 * A kill task command */
+		if (procStatus.iState == PROC_ERROR) {
+			GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Terminate:"
+				" proc Status 0x%x\n", procStatus.iState);
+			status = DSP_EFAIL;
+			goto func_cont;
+		}
+
 		msg.dwCmd = RMS_EXIT;
 		msg.dwArg1 = hNode->nodeEnv;
 		killmsg.dwCmd = RMS_KILLTASK;
@@ -2771,6 +2786,7 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 				status = DSP_SOK;
 		}
 	}
+func_cont:
 	if (DSP_SUCCEEDED(status)) {
 		/* Enter CS before getting exit status, in case node was
 		 * deleted. */
-- 
1.5.4.3

