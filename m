From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] DSPBRIDGE: remove unsed piece of code
Date: Thu,  3 Sep 2009 14:44:29 +0300
Message-ID: <1251978269-26597-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22501 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbZICLo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 07:44:59 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n83Bihhf027570
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 14:44:52 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

I doubt about usefulness of removed piece of code. But it seems to be not used
because of unchanged value of bJustWokeDSP.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/node.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index e213b22..a156182 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1278,7 +1278,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	enum NODE_TYPE nodeType;
 	DSP_STATUS status = DSP_SOK;
 	DSP_STATUS status1 = DSP_SOK;
-	bool bJustWokeDSP = false;
 	struct DSP_CBDATA cbData;
 	u32 procId = 255;
 	struct DSP_PROCESSORSTATE procStatus;
@@ -1429,22 +1428,6 @@ func_cont2:
 		/* Put back in NODE_ALLOCATED state if error occurred */
 		NODE_SetState(hNode, NODE_ALLOCATED);
 	}
-	if (procId == DSP_UNIT) {
-		/* If node create failed, see if should sleep DSP now */
-		if (bJustWokeDSP == true) {
-			/* Check to see if partial create happened on DSP */
-			if (hNode->nodeEnv == (u32)NULL) {
-				/* No environment allocated on DSP, re-sleep
-				 * DSP now */
-				PROC_Ctrl(hNode->hProcessor, WMDIOCTL_DEEPSLEEP,
-					 &cbData);
-			} else {
-				/* Increment count, sleep later when node fully
-				 * deleted */
-				hNodeMgr->uNumCreated++;
-			}
-		}
-	}
 func_cont:
 		/* Free access to node dispatcher */
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
-- 
1.5.6.5

