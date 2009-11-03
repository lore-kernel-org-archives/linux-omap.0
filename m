From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 3/6] DSPBRIDGE: Report and print errors during OFF
Date: Tue, 3 Nov 2009 17:20:26 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA0600849F9522@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56582 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbZKCXUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:20:23 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3NKSir020910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:20:28 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3NKRnp014321
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:20:28 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3NKRtS015499
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:20:27 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 17a071cb82e3c9d69abc7366cc50ca316cc33e6b Mon Sep 17 00:00:00 2001
From: Ernest Ramos Falcon <ernesto@ti.com>
Date: Fri, 30 Oct 2009 17:20:36 -0600
Subject: [PATCH 3/6] DSPBRIDGE: Report and print errors during OFF transitions

Report a PWRERR event (if enabled) during self hibernation
transitions, alos print if any of the suspend or self hibernation
routines fail.

Signed-off-by: Ernest Ramos Falcon <ernesto@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 2eb379f..da7d4f3 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -114,6 +114,9 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 #ifdef CONFIG_PM
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	enum HW_PwrState_t pwrState;
+#ifdef BRIDGE_NTFY_PWRERR
+	struct DEH_MGR *hDehMgr;
+#endif /* #ifdef BRIDGE_NTFY_PWRERR */
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 opplevel;
 	struct IO_MGR *hIOMgr;
@@ -133,9 +136,12 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				    &pwrState);
 	}
 	if (timeout == 0) {
-		DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP Off mode \n");
+		pr_err("Timed out waiting for DSP self hibernation\n");
+#ifdef BRIDGE_NTFY_PWRERR
+		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
+		WMD_DEH_Notify(hDehMgr, DSP_PWRERROR, 0);
+#endif /* #ifdef BRIDGE_NTFY_PWRERR */
 		status = WMD_E_TIMEOUT;
-		return status;
 	} else {
 		/* Save mailbox settings */
 		status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
@@ -258,8 +264,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	}
 
 	if (!timeout) {
-		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
-			 " STANDBY %x \n", pwrState);
+		pr_err("Timed out waiting for DSP suspend %x\n", pwrState);
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
 		WMD_DEH_Notify(hDehMgr, DSP_PWRERROR, 0);
-- 
1.6.2.4

