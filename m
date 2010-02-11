From: <ameya.palande@nokia.com>
Subject: RE: [PATCH v3] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Thu, 11 Feb 2010 20:41:15 +0100
Message-ID: <DDE834F1D8D96540B7373DFF675BF56C1B8A2B5AAD@NOK-EUMSG-03.mgdnok.nokia.com>
References: <1265916121-5601-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25318 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab0BKTnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 14:43:52 -0500
In-Reply-To: <1265916121-5601-1-git-send-email-deepak.chitriki@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: deepak.chitriki@ti.com, linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com

Hi Deepak,

I can't see NTFY_Notify() getting removed in this patch :(
It is just removing braces around if and else!

Cheers,
Ameya.
________________________________________
From: ext Deepak Chitriki [deepak.chitriki@ti.com]
Sent: Thursday, February 11, 2010 9:22 PM
To: linux-omap
Cc: Deepak Chitriki; Palande Ameya (Nokia-D/Helsinki); Omar Ramirez Luna; Nishanth Menon
Subject: [PATCH v3] DSPBRIDGE: Fix to avoid possible recursive locking

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
-                       else {
+                       else
                                SYNC_SetEvent(hMsgQueue->hSyncEvent);
-                       }

                        fGotMsg = true;
                }
@@ -345,9 +344,9 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
                        }
                        hMsgQueue->refCount--;
                        /* Reset the event if there are still queued messages */
-                       if (!LST_IsEmpty(hMsgQueue->msgUsedList)) {
+                       if (!LST_IsEmpty(hMsgQueue->msgUsedList))
                                SYNC_SetEvent(hMsgQueue->hSyncEvent);
-                       }
+
                        /* Exit critical section */
                        (void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
                }
--
1.6.3.3