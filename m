From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] DSPBRIDGE: replace init_timer with init_timer_on_stack
Date: Tue, 19 Jan 2010 18:45:11 -0600
Message-ID: <1263948311-22140-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58058 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab0ATAp0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 19:45:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

With LOCK_DEP enabled and DEBUG_OBJECTS_TIMERS, DSPBridge
SYNC_WaitOnMultipleEvents will fail with message
"ODEBUG: object is on stack, but not annotated"
since the timeout timer is on the stack, we should rightly use
init_timer_on_stack.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/dsp/bridge/services/sync.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index c2d79c7..d246656 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -330,7 +330,7 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 	if (Wp->state != wo_signalled && dwTimeout > 0) {
 		struct timer_list timeout;
 		if (dwTimeout != SYNC_INFINITE) {
-			init_timer(&timeout);
+			init_timer_on_stack(&timeout);
 			timeout.function = timeout_callback;
 			timeout.data = (unsigned long)Wp;
 			timeout.expires = jiffies + dwTimeout * HZ / 1000;
-- 
1.6.3.3

