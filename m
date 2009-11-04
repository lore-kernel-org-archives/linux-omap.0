From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [RESEND][PATCH 2/6] DSPBRIDGE: Fix flood of messages from DSP
Date: Tue, 3 Nov 2009 19:27:49 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426AACD26@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbZKDB1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 20:27:45 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA41Ro5P031387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 19:27:50 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA41RouR000380
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 19:27:50 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA41Rnxg013987
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 19:27:50 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

From: Ernesto Ramos <ernesto@ti.com>

This patch fixes an issue in dspbridge when several messages are sent
in one shot but MPU was only able to process one message.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
Signed-off by: Bhavin Shah <bshah@ti.com>
---
 drivers/dsp/bridge/wmd/msg_sm.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 0231f65..16eab74 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -314,6 +314,11 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 				   (struct LST_ELEM *)pMsgFrame);
 			if (LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
+			else {
+				NTFY_Notify(hMsgQueue->hNtfy,
+					DSP_NODEMESSAGEREADY);
+				SYNC_SetEvent(hMsgQueue->hSyncEvent);
+			}
 
 			fGotMsg = true;
 		}
@@ -361,9 +366,11 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			}
 			hMsgQueue->refCount--;
 			/* Reset the event if there are still queued messages */
-			if (!LST_IsEmpty(hMsgQueue->msgUsedList))
+			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
+				NTFY_Notify(hMsgQueue->hNtfy,
+					DSP_NODEMESSAGEREADY);
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
-
+			}
 			/* Exit critical section */
 			(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 		}
-- 
1.6.2.4

