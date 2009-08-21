From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 2/6] dsp: bridge: wcd: else is unnecessary
Date: Fri, 21 Aug 2009 13:23:35 +0300
Message-ID: <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65327 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZHUKZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:25:55 -0400
In-Reply-To: <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

The return makes the use of else unnecessary, remove it

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 7434f43..01c9572 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -260,9 +260,9 @@ inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
 		/* make the fxn call via the cmd table */
 		*pResult = (*WCD_cmdTable[cmd].fxn) (args);
 		return DSP_SOK;
-	} else {
-		return DSP_EINVALIDARG;
 	}
+
+	return DSP_EINVALIDARG;
 }
 
 /*
-- 
1.6.3.3.385.g60647

