From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 09/18] DSPBRIDGE: Rename usCount to timeout
Date: Wed, 16 Dec 2009 20:15:54 -0600
Message-ID: <1261016163-11091-10-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43915 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763887AbZLQCIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 21:08:49 -0500
In-Reply-To: <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Rename usCount to timeout

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c     |    6 +++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 018a5f4..65a21b2 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -2089,14 +2089,14 @@ void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,
  */
 bool WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
 {
-	u16 usCount = TIHELEN_ACKTIMEOUT;
+	u16 timeout = TIHELEN_ACKTIMEOUT;
 
 	/*  Wait for response from board */
-	while (*((volatile u16 *)dwSyncAddr) && --usCount)
+	while (*((volatile u16 *)dwSyncAddr) && --timeout)
 		udelay(10);
 
 	/*  If timed out: return FALSE */
-	if (!usCount) {
+	if (!timeout) {
 		DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP to Start\n");
 		return FALSE;
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index da59e4b..ea299a0 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -110,7 +110,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
-	u16 usCount = PWRSTST_TIMEOUT / 10;
+	u16 timeout = PWRSTST_TIMEOUT / 10;
 	struct CFG_HOSTRES resources;
 	enum HW_PwrState_t pwrState;
 #ifdef CONFIG_BRIDGE_DVFS
@@ -128,7 +128,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 			    &pwrState);
 	/* Wait for DSP to move into OFF state */
-	while ((pwrState != HW_PWR_STATE_OFF) && --usCount) {
+	while ((pwrState != HW_PWR_STATE_OFF) && --timeout) {
 		if (msleep_interruptible(10)) {
 			pr_err("Waiting for DSP OFF mode interrupted\n");
 			return DSP_EFAIL;
@@ -136,7 +136,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
-	if (usCount == 0) {
+	if (timeout == 0) {
 		DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP Off mode \n");
 		status = WMD_E_TIMEOUT;
 		return status;
@@ -197,7 +197,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	struct DEH_MGR *hDehMgr;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
-	u16 usCount = PWRSTST_TIMEOUT / 10;
+	u16 timeout = PWRSTST_TIMEOUT / 10;
 	enum HW_PwrState_t pwrState, targetPwrState;
 
 	DBG_Trace(DBG_LEVEL7, "SleepDSP- Enter function \n");
@@ -259,7 +259,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			&pwrState);
 
 	/* Wait for DSP to move into target power state */
-	while ((pwrState != targetPwrState) && usCount--) {
+	while ((pwrState != targetPwrState) && timeout--) {
 		if (msleep_interruptible(10)) {
 			pr_err("Waiting for DSP to Suspend interrupted\n");
 			return DSP_EFAIL;
@@ -268,7 +268,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 				    &pwrState);
 	}
 
-	if (!usCount) {
+	if (!timeout) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
 			 " STANDBY %x \n", pwrState);
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
-- 
1.6.2.4

