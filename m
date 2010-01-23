From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] DSPBRIDGE: Use enable_off_mode variable instead of dsp_test_sleepstate
Date: Sat, 23 Jan 2010 12:19:45 +0200
Message-ID: <1264241986-29071-2-git-send-email-felipe.contreras@gmail.com>
References: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64164 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab0AWKUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jan 2010 05:20:08 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1661440bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 23 Jan 2010 02:20:04 -0800 (PST)
In-Reply-To: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    5 -----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    9 ++++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a02a32a..b20f77e 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -78,8 +78,6 @@ s32 dsp_debug;
 
 struct platform_device *omap_dspbridge_dev;
 
-/* This is a test variable used by Bridge to test different sleep states */
-s32 dsp_test_sleepstate;
 struct bridge_dev {
 	struct cdev cdev;
 };
@@ -129,9 +127,6 @@ module_param(dsp_debug, int, 0);
 MODULE_PARM_DESC(dsp_debug, "Wait after loading DSP image. default = false");
 #endif
 
-module_param(dsp_test_sleepstate, int, 0);
-MODULE_PARM_DESC(dsp_test_sleepstate, "DSP Sleep state = 0");
-
 module_param(base_img, charp, 0);
 MODULE_PARM_DESC(base_img, "DSP base image, default = NULL");
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 084f406..c0e0994 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -54,10 +54,9 @@
 #include <mach-omap2/cm-regbits-34xx.h>
 
 #ifdef CONFIG_PM
-extern s32 dsp_test_sleepstate;
+extern unsigned short enable_off_mode;
 #endif
 extern struct MAILBOX_CONTEXT mboxsetting;
-
 /*
  *  ======== handle_constraints_set ========
  *  	Sets new DSP constraint
@@ -196,7 +195,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	switch (pDevContext->dwBrdState) {
 	case BRD_RUNNING:
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
-		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
+		if (enable_off_mode) {
 			CHNLSM_InterruptDSP2(pDevContext,
 					     MBX_PM_DSPHIBERNATE);
 			DBG_Trace(DBG_LEVEL7,
@@ -211,7 +210,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		break;
 	case BRD_RETENTION:
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
-		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
+		if (enable_off_mode) {
 			CHNLSM_InterruptDSP2(pDevContext,
 					     MBX_PM_DSPHIBERNATE);
 			targetPwrState = HW_PWR_STATE_OFF;
@@ -261,7 +260,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			 pwrState);
 
 		/* Update the Bridger Driver state */
-		if (dsp_test_sleepstate == HW_PWR_STATE_OFF)
+		if (enable_off_mode)
 			pDevContext->dwBrdState = BRD_HIBERNATION;
 		else
 			pDevContext->dwBrdState = BRD_RETENTION;
-- 
1.6.6.1

