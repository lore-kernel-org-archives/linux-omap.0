From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 4/6] DSPBRIDGE: New state for DSP transition to hibernation
Date: Tue, 3 Nov 2009 17:05:41 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6921171@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57843 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbZKCXFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:05:38 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3N5hHU001164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:05:43 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3N5gin009786
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:05:42 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3N5g8C011262
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:05:42 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From da109a546582dac475510a74f050120b2ccbf486 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 30 Oct 2009 18:53:39 -0600
Subject: [PATCH 4/6] DSPBRIDGE: New state for DSP transition to hibernation

This patch fixes the issue when we are waiting for DSP
to go to hibernation and in that momment we send a mailbox
interrupt to the DSP, now there is a new state to avoid
sending messange when DSP tries to go to hibernation

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index da7d4f3..e793ad3 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -114,6 +114,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 #ifdef CONFIG_PM
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	enum HW_PwrState_t pwrState;
+	u32  prev_state;
 #ifdef BRIDGE_NTFY_PWRERR
 	struct DEH_MGR *hDehMgr;
 #endif /* #ifdef BRIDGE_NTFY_PWRERR */
@@ -124,6 +125,9 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				omap_dspbridge_dev->dev.platform_data;
 #endif
 
+	prev_state = pDevContext->dwBrdState;
+	pDevContext->dwBrdState = BRD_SLEEP_TRANSITION;
+
 	HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 			    &pwrState);
 	/* Wait for DSP to move into OFF state */
@@ -136,6 +140,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				    &pwrState);
 	}
 	if (timeout == 0) {
+		pDevContext->dwBrdState = prev_state;
 		pr_err("Timed out waiting for DSP self hibernation\n");
 #ifdef BRIDGE_NTFY_PWRERR
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
@@ -177,6 +182,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 			status = DSP_SOK;
 #endif /* CONFIG_BRIDGE_DVFS */
 		} else {
+			pDevContext->dwBrdState = prev_state;
 			DBG_Trace(DBG_LEVEL7,
 				 "handle_hibernation_fromDSP- FAILED\n");
 		}
@@ -198,6 +204,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	struct DEH_MGR *hDehMgr;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 	u16 timeout = PWRSTST_TIMEOUT / 10;
+	u32 prev_state;
 	enum HW_PwrState_t pwrState, targetPwrState;
 
 	DBG_Trace(DBG_LEVEL7, "SleepDSP- Enter function \n");
@@ -223,6 +230,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 					     MBX_PM_DSPRETENTION);
 			targetPwrState = HW_PWR_STATE_RET;
 		}
+		prev_state = BRD_RUNNING;
 		break;
 	case BRD_RETENTION:
 		status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
@@ -232,6 +240,8 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			targetPwrState = HW_PWR_STATE_OFF;
 		} else
 			return DSP_SOK;
+
+		prev_state = BRD_RETENTION;
 		break;
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
@@ -248,7 +258,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			 "SleepDSP- Bridge in Illegal state\n");
 			return DSP_EFAIL;
 	}
-
+	pDevContext->dwBrdState = BRD_SLEEP_TRANSITION;
 	/* Get the PRCM DSP power domain status */
 	HW_PWR_IVA2StateGet(pDevContext->prmbase, HW_PWR_DOMAIN_DSP,
 			&pwrState);
@@ -264,6 +274,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	}
 
 	if (!timeout) {
+		pDevContext->dwBrdState = prev_state;
 		pr_err("Timed out waiting for DSP suspend %x\n", pwrState);
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
@@ -506,7 +517,8 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 		voltage_domain, level);
 	if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
 			(pDevContext->dwBrdState == BRD_RETENTION) ||
-			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
+			(pDevContext->dwBrdState == BRD_DSP_HIBERNATION) ||
+			(pDevContext->dwBrdState == BRD_SLEEP_TRANSITION)) {
 		/* Update the OPP value in shared memory */
 		IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
 		DBG_Trace(DBG_LEVEL7,
-- 
1.6.2.4

