From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 04/17] DSPBRIDGE: set PWRERROR notifications as an option
Date: Tue, 15 Dec 2009 00:19:45 -0600
Message-ID: <1260857998-19349-5-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZLOGMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:52 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch enables/disables the option to register to be
notified about bridge driver PWR errors, generally caused
because the timer expires waiting for the dsp to change from
active to retention or hibernation.

This event, if enabled, will be signaled as a fatal error,
bridge driver will be unusable until a recovery method
cleans the error state.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/Kconfig              |   11 +++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    4 ++++
 drivers/dsp/bridge/wmd/ue_deh.c         |    2 ++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 2fed82c..e494f02 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -34,3 +34,14 @@ config BRIDGE_DEBUG
 	depends on MPU_BRIDGE
 	help
 	  Say Y to enable Bridge debugging capabilities
+
+comment "Bridge Notifications"
+	depends on MPU_BRIDGE
+
+config BRIDGE_NTFY_PWRERR
+	bool "Notify DSP Power Error"
+	depends on MPU_BRIDGE
+	help
+	  Enable notifications to registered clients on the event of power errror
+	  trying to suspend bridge driver. Say Y, to signal this event as a fatal
+	  error, this will require a bridge restart to recover.
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index f30da74..2d7be1c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -192,7 +192,9 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
 	struct CFG_HOSTRES resources;
+#ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	struct DEH_MGR *hDehMgr;
+#endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 	u16 usCount = TIHELEN_ACKTIMEOUT;
 	enum HW_PwrState_t pwrState, targetPwrState;
 
@@ -267,8 +269,10 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	if (!usCount) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
 			 " STANDBY %x \n", pwrState);
+#ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
 		WMD_DEH_Notify(hDehMgr, DSP_PWRERROR, 0);
+#endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		return WMD_E_TIMEOUT;
 	} else {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: DSP STANDBY Pwr state %x \n",
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 483a9c3..d6d6043 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -280,6 +280,7 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 			HW_MMU_EventAck(resources.dwDmmuBase,
 					 HW_MMU_TRANSLATION_FAULT);
 			break;
+#ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		case DSP_PWRERROR:
 			/* reset errInfo structure before use */
 			pDehMgr->errInfo.dwErrMask = DSP_PWRERROR;
@@ -290,6 +291,7 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 			printk(KERN_ERR "WMD_DEH_Notify: DSP_PWRERROR, errInfo "
 					"= 0x%x\n", dwErrInfo);
 			break;
+#endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		default:
 			DBG_Trace(DBG_LEVEL6,
 				 "WMD_DEH_Notify: Unknown Error, errInfo = "
-- 
1.6.2.4

