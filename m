From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Get rid of mixed declaration code warning
Date: Wed, 23 Sep 2009 15:06:09 +0300
Message-ID: <1253707569-8160-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19714 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbZIWMG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 08:06:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com

This patch fixes following compiler warning:

drivers/dsp/bridge/rmgr/proc.c:1072: warning: ISO C90 forbids mixed
declarations and code

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a75b64a..b979c85 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1058,20 +1058,24 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #ifdef DEBUG
 	BRD_STATUS uBrdState;
 #endif
+
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	struct timeval tv1;
 	struct timeval tv2;
 #endif
+
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+	struct dspbridge_platform_data *pdata =
+				omap_dspbridge_dev->dev.platform_data;
+#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(iArgc > 0);
 	DBC_Require(aArgv != NULL);
+
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv1);
 #endif
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev->dev.platform_data;
-#endif
 	GT_2trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Load, args:\n\t"
 		 "hProcessor:  0x%x\taArgv: 0x%x\n", hProcessor, aArgv[0]);
 	/* Call the WMD_BRD_Load Fxn */
-- 
1.6.2.4

