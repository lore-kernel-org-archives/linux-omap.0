From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH ] DSPBRIDGE:Remove conditional check from the InputMsg
 function
Date: Tue, 29 Dec 2009 22:04:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277A9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47169 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbZL2QeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 11:34:23 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBTGYKoM019772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 10:34:22 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBTGYIoW026119
	for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 22:04:19 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 03b5f57849eda16fb659c4288ae2dc9a2d1582a9 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 17 Dec 2009 17:00:22 -0600
Subject: [PATCH] DSPBRIDGE: Remove conditional check from the InputMsg function

This patch removes the conditional check which can result in
message skip.

Discovered-by: Bhavin Shah	 <bshah@ti.com>
Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index a6c8e31..5b7b004 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1308,7 +1308,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 	fInputEmpty = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				 bufEmpty);
 	uMsgs = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, size);
-	if (fInputEmpty || uMsgs >= hMsgMgr->uMaxMsgs)
+	if (fInputEmpty)
 		goto func_end;
 
 	pMsgInput = pIOMgr->pMsgInput;
@@ -1331,12 +1331,11 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		DBG_Trace(DBG_LEVEL7, "InputMsg RECVD: dwCmd=0x%x dwArg1=0x%x "
 			 "dwArg2=0x%x dwId=0x%x \n", msg.msg.dwCmd,
 			 msg.msg.dwArg1, msg.msg.dwArg2, msg.dwId);
-		 /*  Interrupt may occur before shared memory and message
-		 *  input locations have been set up. If all nodes were
-		 *  cleaned up, hMsgMgr->uMaxMsgs should be 0.  */
-               if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
-                       goto func_end;
-
+		/*
+		 * Interrupt may occur before shared memory and message
+		 * input locations have been set up. If all nodes were
+		 * cleaned up, hMsgMgr->uMaxMsgs should be 0.
+		 */
 		while (hMsgQueue != NULL) {
 			if (msg.dwId == hMsgQueue->dwId) {
 				/* Found it */
-- 
1.6.0.4
