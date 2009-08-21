From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 1/6] dsp: bridge: use ARRAY_SIZE
Date: Fri, 21 Aug 2009 13:23:34 +0300
Message-ID: <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23703 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbZHUKZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:25:54 -0400
In-Reply-To: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

trivial patch using ARRAY_SIZE.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 859043d..7434f43 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -256,7 +256,7 @@ static struct WCD_Cmd WCD_cmdTable[] = {
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
 				    u32 *pResult)
 {
-	if ((cmd < (sizeof(WCD_cmdTable) / sizeof(struct WCD_Cmd)))) {
+	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
 		/* make the fxn call via the cmd table */
 		*pResult = (*WCD_cmdTable[cmd].fxn) (args);
 		return DSP_SOK;
@@ -307,7 +307,7 @@ bool WCD_Init(void)
 #ifdef DEBUG
 	/* runtime check of Device IOCtl array. */
 	u32 i;
-	for (i = 1; i < (sizeof(WCD_cmdTable) / sizeof(struct WCD_Cmd)); i++)
+	for (i = 1; i < ARRAY_SIZE(WCD_cmdTable); i++)
 		DBC_Assert(WCD_cmdTable[i - 1].dwIndex == i);
 
 #endif
-- 
1.6.3.3.385.g60647

