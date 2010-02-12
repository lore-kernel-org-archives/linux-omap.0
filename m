From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 2/2] dspbridge: proc: fix a double-free on 2 error paths
Date: Fri, 12 Feb 2010 18:26:54 +0200
Message-ID: <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com>
References: <1265992014-7917-1-git-send-email-ext-phil.2.carmody@nokia.com>
 <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63301 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157Ab0BLQZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:25:59 -0500
In-Reply-To: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
In-Reply-To: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
References: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

We free in the tail cleanup, so don't free before jumping there.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 7bc1bcd..e89077b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -349,13 +349,11 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		status = DEV_GetWMDContext(hDevObject,
 					&pProcObject->hWmdContext);
 		if (DSP_FAILED(status)) {
-			MEM_FreeObject(pProcObject);
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_AutoStart: Failed "
 				 "to get WMD Context \n");
 		}
 	} else {
-		MEM_FreeObject(pProcObject);
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_AutoStart: Failed to "
 			 "get IntFxns \n");
@@ -377,6 +375,10 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "CFG_GetAutoStart DSP_FAILED \n");
 		goto func_cont;
 	}
+
+	/* paranoid - must be able to kfree this on remaining error paths */
+	pProcObject->g_pszLastCoff = NULL;
+
 	/* Get the default executable for this board... */
 	DEV_GetDevType(hDevObject, (u32 *)&devType);
 	pProcObject->uProcessor = devType;
@@ -406,9 +408,9 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_AutoStart: "
 			 "No Exec file found \n");
 	}
-func_cont:
 	kfree(pProcObject->g_pszLastCoff);
 	pProcObject->g_pszLastCoff = NULL;
+func_cont:
 	MEM_FreeObject(pProcObject);
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
-- 
1.6.0.4

