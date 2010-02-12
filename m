From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Resend: Patch] DSPBRIDGE: Remove conditional check from the
 InputMsg function
Date: Fri, 12 Feb 2010 23:10:31 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96DBBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992Ab0BLRkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 12:40:37 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CHeYWG003312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 11:40:36 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1CHeYWV008780
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 23:10:34 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Shivananda Hebbar <x0hebbar@ti.com>

This patch removes conditional check for uMaxMsgs for the below reasons.
1)1st conditional check.
MPU Bridge stops processing messages from DSP, if uMaxMsgs (currently 8) are sent in one shot. The check (>=) will make it to return from function without processing any messages. So DSP will be waiting forever to get the ack from MPU saying that MPU has read the messages. If this happens, the communication from DSP to MPU is broken forever.
2)2nd conditional check
- This patch also removes unnecessary check because DSP never sends messages more than uMaxMsgs.

Discovered-by: Bhavin Shah <bshah@ti.com>
Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c index 39b37a6..b2092a2 100644
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

