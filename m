From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Tue,  9 Feb 2010 19:01:17 -0600
Message-ID: <1265763677-7012-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55284 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0BJBBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 20:01:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>

This patch fixes possible recursive locking detection.The implementation
in which the spinlock is acquired and released is rectified in WMD_MSG_Get()
to avoid locking contention.
Added SYNC_EnterCS() and SYNC_LeaveCS()in WMD_MSG_Get()function.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Nishanth Menon <nm@ti.com>

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
---
 drivers/dsp/bridge/wmd/msg_sm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 50201e5..8faf5ad 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -300,8 +300,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			if (LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
 			else {
+				(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 				NTFY_Notify(hMsgQueue->hNtfy,
 					DSP_NODEMESSAGEREADY);
+				(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
 			}
 
@@ -352,8 +354,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			hMsgQueue->refCount--;
 			/* Reset the event if there are still queued messages */
 			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
+				(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
 				NTFY_Notify(hMsgQueue->hNtfy,
 					DSP_NODEMESSAGEREADY);
+				(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
 			}
 			/* Exit critical section */
-- 
1.6.3.3

