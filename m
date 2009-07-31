From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/5] dspbridge: static code analysis issues - dead code path
Date: Fri, 31 Jul 2009 13:39:24 +0300
Message-ID: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31851 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZGaKjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 06:39:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Phil Carmody <ext-phil.2.carmody@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

Pointless dead code path - there is nothing to fail before the
DSP_SUCCEEDED check.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index ee15b02..9c3fe6f 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -709,14 +709,11 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args)
 			goto func_end;
 		}
 		cbDataSize += sizeof(u32);
-		if (DSP_SUCCEEDED(status)) {
-			pArgs = MEM_Alloc(cbDataSize, MEM_NONPAGED);
-			if (pArgs == NULL) {
-				status = DSP_EMEMORY;
-				goto func_end;
-			}
-		} else
+		pArgs = MEM_Alloc(cbDataSize, MEM_NONPAGED);
+		if (pArgs == NULL) {
+			status = DSP_EMEMORY;
 			goto func_end;
+		}
 
 		cp_fm_usr(pArgs, args->ARGS_PROC_CTRL.pArgs, status,
 			 cbDataSize);
-- 
1.6.0.4

