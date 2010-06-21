From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH] DSPBRIDGE: decrease message pending in case of timeout
Date: Mon, 21 Jun 2010 14:36:02 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC32E9FCC@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35193 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757566Ab0FUTgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 15:36:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From f9f553588f8e3bf391bab72e59ee2593ee5f5f9b Mon Sep 17 00:00:00 2001
From: armando uribe <x0095078@ti.com>
Date: Wed, 16 Jun 2010 20:15:04 -0500
Subject: [PATCH] DSPBRIDGE: decrease message pending in case of timeout

In the function bridge_msg_put() the pending message counter was not being drecreased in case of timeout, leading MPU get stalled in delete_node()

Signed-off-by: armando <x0095078@ti.com>
---
 drivers/dsp/bridge/wmd/msg_sm.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c index b505c5e..d56b46b 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -446,12 +446,16 @@ int bridge_msg_put(struct msg_queue *msg_queue_obj,
 		syncs[1] = msg_queue_obj->sync_done;
 		status = sync_wait_on_multiple_events(syncs, 2, utimeout,
 						      &index);
-		if (DSP_FAILED(status))
-			goto func_end;
 		/* Enter critical section */
 		spin_lock_bh(&hmsg_mgr->msg_mgr_lock);
+		msg_queue_obj->io_msg_pend--;
+
+		if (DSP_FAILED(status)) {
+			spin_unlock_bh(&hmsg_mgr->msg_mgr_lock);
+			goto func_end;
+		}
+
 		if (msg_queue_obj->done) {
-			msg_queue_obj->io_msg_pend--;
 			/* Exit critical section */
 			spin_unlock_bh(&hmsg_mgr->msg_mgr_lock);
 			/*  Signal that we're not going to access msg_queue_obj @@ -484,7 +488,6 @@ int bridge_msg_put(struct msg_queue *msg_queue_obj,
 				iosm_schedule(hmsg_mgr->hio_mgr);
 			}
 
-			msg_queue_obj->io_msg_pend--;
 			/* Reset event if there are still frames available */
 			if (!LST_IS_EMPTY(hmsg_mgr->msg_free_list))
 				sync_set_event(hmsg_mgr->sync_event);
--
1.6.3.3

