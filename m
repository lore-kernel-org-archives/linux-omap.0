From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCHv1] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Wed, 10 Feb 2010 18:29:49 -0600
Message-ID: <1265848189-10697-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942Ab0BKAaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 19:30:17 -0500
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

Ref:
v0:http://marc.info/?l=linux-omap&m=126584779011493&w=2
v1:Comment fixes from v0
---
 drivers/dsp/bridge/wmd/msg_sm.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 3a275f1..7de3705 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -296,8 +296,6 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			if (LST_IsEmpty(hMsgQueue->msgUsedList))
 				SYNC_ResetEvent(hMsgQueue->hSyncEvent);
 			else {
-				NTFY_Notify(hMsgQueue->hNtfy,
-					DSP_NODEMESSAGEREADY);
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
 			}
 
@@ -348,8 +346,6 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 			hMsgQueue->refCount--;
 			/* Reset the event if there are still queued messages */
 			if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
-				NTFY_Notify(hMsgQueue->hNtfy,
-					DSP_NODEMESSAGEREADY);
 				SYNC_SetEvent(hMsgQueue->hSyncEvent);
 			}
 			/* Exit critical section */
-- 
1.6.3.3

