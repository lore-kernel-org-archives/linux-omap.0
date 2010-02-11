From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH v3] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Thu, 11 Feb 2010 13:22:01 -0600
Message-ID: <1265916121-5601-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756835Ab0BKTWM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Feb 2010 14:22:12 -0500
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
v3:Comment fixes from v2

 drivers/dsp/bridge/wmd/msg_sm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 7de3705..7414113 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -295,9 +295,8 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 				   (struct list_head *)pMsgFrame);
 			if (LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
-			else {
+			else
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
-			}
 
 			fGotMsg = true;
 		}
@@ -345,9 +344,9 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			}
 			hMsgQueue->refCount--;
 			/* Reset the event if there are still queued messages */
-			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
+			if (!LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
-			}
+
 			/* Exit critical section */
 			(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 		}
-- 
1.6.3.3

