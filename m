From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Only memset() is available in 2.6.29 kernel
Date: Thu, 26 Mar 2009 16:39:32 +0200
Message-ID: <1238078372-13406-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22807 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbZCZOkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 10:40:21 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2QEeDw6024898
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 16:40:16 +0200
Received: from localhost.localdomain (esdhcp03572.research.nokia.com [172.21.35.72])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2QEdTic019527
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 16:39:29 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index d7506f1..09ee2d4 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -770,7 +770,7 @@ func_cont:
 			 (u8 *)hIOMgr->pMsgOutput);
 		DBG_Trace(DBG_LEVEL7, "** (proc) MAX MSGS IN SHARED MEMORY: "
 			 "0x%x\n", hMsgMgr->uMaxMsgs);
-		memzero((void *) hIOMgr->pSharedMem, sizeof(struct SHM));
+		memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
 	}
 #ifndef DSP_TRACEBUF_DISABLED
 	if (DSP_SUCCEEDED(status)) {
-- 
1.5.6.3

