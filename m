From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [DSPBRIGDE PATCH 1/6] dsp: bridge: use ARRAY_SIZE
Date: Fri, 28 Aug 2009 15:57:43 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF29F9@dlee06.ent.ti.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46978 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZH1U5w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 16:57:52 -0400
In-Reply-To: <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
Sent: Friday, August 21, 2009 5:24 AM
To: Hiroshi DOYU
Cc: Ameya Palande; Guzman Lugo, Fernando; Linux OMAP Mailing List; Felipe Balbi
Subject: [DSPBRIGDE PATCH 1/6] dsp: bridge: use ARRAY_SIZE

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


