From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 06/20] DSPBRIDGE: checkpatch - space required before open parenthesis
Date: Mon, 30 Nov 2009 15:54:47 -0600
Message-ID: <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbZK3Vs7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:48:59 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn6UQ013073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:06 -0600
In-Reply-To: <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

ERROR: space required before the open parenthesis '('

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
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
index 396a10b..746689d 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -201,7 +201,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image.  */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
-	if(!hWmdContext) {
+	if (!hWmdContext) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -1106,7 +1106,7 @@ func_end:
  */
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
-	if(!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		return;
 	tiomap3430_bump_dsp_opp_level();
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

