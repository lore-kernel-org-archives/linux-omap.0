From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 5/7] DSPBRIDGE: Rename pResult to result for WCD_CallDevIOCtl
Date: Mon, 11 Jan 2010 19:00:39 -0600
Message-ID: <1263258041-16836-6-git-send-email-omar.ramirez@ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-4-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab0ALAvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 19:51:14 -0500
In-Reply-To: <1263258041-16836-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Trivial cleanup, rename pResult to result for WCD_CallDevIOCtl

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 960b3cb..02def74 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -271,11 +271,11 @@ static inline void __cp_to_usr(void __user *to, const void *from,
  *      Call the (wrapper) function for the corresponding WCD IOCTL.
  */
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
-				    u32 *pResult, void *pr_ctxt)
+				    u32 *result, void *pr_ctxt)
 {
 	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
 		/* make the fxn call via the cmd table */
-		*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
+		*result = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
 		return DSP_SOK;
 	}
 
-- 
1.6.2.4

