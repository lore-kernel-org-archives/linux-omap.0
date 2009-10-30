From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Fix flood of messages from DSP
Date: Fri, 30 Oct 2009 18:08:22 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA0600848E0C3C@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060AbZJ3XIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 19:08:18 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9UN8NU6026164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 18:08:23 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9UN8Md4027931
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 18:08:23 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9UN8Mc8019152
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 18:08:22 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 577c4e8e647ca503518914302889dced3e898b04 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Thu, 29 Oct 2009 13:10:30 -0600
Subject: [PATCH] DSPBRIDGE: Fix flood of messages from DSP

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

