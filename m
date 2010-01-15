From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 06/10] DSPBRIDGE: checkpatch - space required before open parenthesis
Date: Fri, 15 Jan 2010 15:28:37 -0600
Message-ID: <1263590921-24357-7-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-3-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-4-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34196 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757307Ab0AOVSy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 16:18:54 -0500
In-Reply-To: <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

ERROR: space required before the open parenthesis '('

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/dev.c     |    2 +-
 drivers/dsp/bridge/services/dbg.c |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c    |    4 ++--
 drivers/dsp/bridge/wmd/msg_sm.c   |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index a9cce95..5c5e056 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -441,7 +441,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 
 		/* Call the driver's WMD_DEV_Destroy() function: */
 		/* Require of DevDestroy */
-		if(pDevObject->hWmdContext) {
+		if (pDevObject->hWmdContext) {
 			status = (*pDevObject->intfFxns.pfnDevDestroy)
 				(pDevObject->hWmdContext);
 			pDevObject->hWmdContext = NULL;
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index bc57fa8..bc5c8cd 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -33,7 +33,7 @@
 static struct GT_Mask DBG_debugMask = { NULL, NULL };	/* GT trace var. */
 #endif
 
-#if (defined(DEBUG) || defined (DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 
 /*
  *  ======== DBG_Init ========
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 8cdc83e..45d90d1 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -197,7 +197,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image.  */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
-	if(!hWmdContext) {
+	if (!hWmdContext) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -1102,7 +1102,7 @@ func_end:
  */
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
-	if(!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		return;
 
 	DPC_Schedule(pIOMgr->hDPC);
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index c29b64e..ad716ab 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -65,7 +65,7 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 		goto func_end;
 	}
 	DEV_GetIOMgr(hDevObject, &hIOMgr);
-	if(!hIOMgr) {
+	if (!hIOMgr) {
 		status = DSP_EPOINTER;
 		goto func_end;
 	}
-- 
1.6.2.4

