From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Remove conditional check from the InputMsg function
Date: Tue, 26 Jan 2010 19:44:32 -0600
Message-ID: <1264556672-27492-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab0A0BeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 20:34:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>

From: Shivananda Hebbar <x0hebbar@ti.com>

This patch removes the conditional check which can result in
message skip.

Discovered-by: Bhavin Shah <bshah@ti.com>
Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 39b37a6..b2092a2 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1328,7 +1328,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 	fInputEmpty = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				 bufEmpty);
 	uMsgs = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, size);
-	if (fInputEmpty || uMsgs >= hMsgMgr->uMaxMsgs)
+	if (fInputEmpty)
 		goto func_end;
 
 	pMsgInput = pIOMgr->pMsgInput;
@@ -1356,9 +1356,6 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		 * input locations have been set up. If all nodes were
 		 * cleaned up, hMsgMgr->uMaxMsgs should be 0.
 		 */
-		if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
-			goto func_end;
-
 		while (hMsgQueue != NULL) {
 			if (msg.dwId == hMsgQueue->dwId) {
 				/* Found it */
-- 
1.6.2.4

