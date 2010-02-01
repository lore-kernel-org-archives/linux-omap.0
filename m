From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2] DSPBRIDGE: Fix memory leak in PROC_AutoStart()
Date: Mon,  1 Feb 2010 19:36:34 +0200
Message-ID: <ea29f699c0916873d206c498bbf41a610a53492d.1265045613.git.ameya.palande@nokia.com>
References: <1265045493.1997.26.camel@sanganak>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52759 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0BARhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 12:37:13 -0500
In-Reply-To: <1265045493.1997.26.camel@sanganak>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, deepak.chitriki@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 491661f..ff3329f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -411,6 +411,8 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "No Exec file found \n");
 	}
 func_cont:
+	MEM_Free(hProcObject->g_pszLastCoff);
+	hProcObject->g_pszLastCoff = NULL;
 	MEM_FreeObject(hProcObject);
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
-- 
1.6.3.3

