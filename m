From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH v4] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Thu, 11 Feb 2010 15:54:44 -0600
Message-ID: <1265925284-7536-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0BKVyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 16:54:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>

Removed NTFY_Notify() in WMD_MSG_Get() to avoid locking contention
as NTFY_Notify() is already invoked in InputMsg().

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Nishanth Menon <nm@ti.com>

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>

---
Ref:
v0:http://marc.info/?l=linux-omap&m=126584779011493&w=2
v1:http://marc.info/?l=linux-omap&m=126586224627725&w=2
v2:http://marc.info/?l=linux-omap&m=126591341909124&w=2
v3:http://marc.info/?l=linux-omap&m=126591743315572&w=2
v4:Comment fixes from v3

 drivers/dsp/bridge/wmd/msg_sm.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 3a275f1..8475e20 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -295,11 +295,8 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 				   (struct list_head *)pMsgFrame);
 			if (LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
-			else {
-				NTFY_Notify(hMsgQueue->hNtfy,
-					DSP_NODEMESSAGEREADY);
+			else
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
-			}
 
 			fGotMsg = true;
 		}
@@ -347,11 +344,8 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			}
 			hMsgQueue->refCount--;
 			/* Reset the event if there are still queued messages */
-			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
-				NTFY_Notify(hMsgQueue->hNtfy,
-					DSP_NODEMESSAGEREADY);
+			if (!LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
-			}
 			/* Exit critical section */
 			(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 		}
-- 
1.6.3.3

