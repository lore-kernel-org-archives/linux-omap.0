From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 08/18] DSPBRIDGE: Remove long busy-wait loops on PWRST transitions
Date: Wed, 16 Dec 2009 20:15:53 -0600
Message-ID: <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36708 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763913AbZLQCIt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 21:08:49 -0500
In-Reply-To: <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove busy waiting on suspend and self hibernation paths by
removing udelays.

Decrease the total timer waiting on power transitions to be less
than 3 seconds, defined to wait for power transition approx. 200 msecs

Change required for:
http://android.git.kernel.org/?p=kernel/omap.git;a=commit;h=c8853459b739e5f43da0badc1605a0a0c0c8195d

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/_tiomap_util.h   |    6 ++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   24 +++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index 47e1e5d..bd1b571 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -31,6 +31,12 @@
 /* Time out Values in uSeconds*/
 #define TIHELEN_ACKTIMEOUT  10000
 
+/*
+ * Time out for power state transition (in msecs), due to system
+ * latencies and HZ resolution this timer can vary.
+ */
+#define PWRSTST_TIMEOUT		200
+
 /*  Time delay for HOM->SAM transition. */
 #define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 2d7be1c..da59e4b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -110,7 +110,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
-	u16 usCount = TIHELEN_ACKTIMEOUT;
+	u16 usCount = PWRSTST_TIMEOUT / 10;
 	struct CFG_HOSTRES resources;
 	enum HW_PwrState_t pwrState;
 #ifdef CONFIG_BRIDGE_DVFS
@@ -127,10 +127,12 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 
 	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 			    &pwrState);
-	/* Wait for DSP to move into Off state,  how much time should
-	 * we wait? */
+	/* Wait for DSP to move into OFF state */
 	while ((pwrState != HW_PWR_STATE_OFF) && --usCount) {
-		udelay(500);
+		if (msleep_interruptible(10)) {
+			pr_err("Waiting for DSP OFF mode interrupted\n");
+			return DSP_EFAIL;
+		}
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
@@ -195,7 +197,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	struct DEH_MGR *hDehMgr;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
-	u16 usCount = TIHELEN_ACKTIMEOUT;
+	u16 usCount = PWRSTST_TIMEOUT / 10;
 	enum HW_PwrState_t pwrState, targetPwrState;
 
 	DBG_Trace(DBG_LEVEL7, "SleepDSP- Enter function \n");
@@ -256,12 +258,12 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 			&pwrState);
 
-	/*
-	 * Wait for DSP to move into Standby state,  how much time
-	 * should we wait?
-	 */
-	while ((pwrState != targetPwrState) && --usCount) {
-		udelay(500);
+	/* Wait for DSP to move into target power state */
+	while ((pwrState != targetPwrState) && usCount--) {
+		if (msleep_interruptible(10)) {
+			pr_err("Waiting for DSP to Suspend interrupted\n");
+			return DSP_EFAIL;
+		}
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
-- 
1.6.2.4

