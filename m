From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/6] DSPBRIDGE: Rename pResult to result for WCD_CallDevIOCtl
Date: Mon, 11 Jan 2010 14:12:45 -0600
Message-ID: <1263240766-13000-6-git-send-email-omar.ramirez@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-3-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-4-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab0AKUDS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 15:03:18 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0BK3HZe029831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 14:03:18 -0600
In-Reply-To: <1263240766-13000-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

Trivial cleanup, rename pResult to result for WCD_CallDevIOCtl

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
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

