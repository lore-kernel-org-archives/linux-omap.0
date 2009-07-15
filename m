From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 08/13] DSPBRIDGE: Prevent memory access during hibernation
Date: Wed, 15 Jul 2009 17:56:31 +0300
Message-ID: <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35450 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbZGOO44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:56 -0400
In-Reply-To: <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

If DSP is in hibernated then WakeDSP() returns without waking it up, which
results in flush_all function access IVA MMU while IVA is hibernated.

[Hiroshi DOYU: split the original to logical ones]

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   65 +++++++++++--------------------
 drivers/dsp/bridge/wmd/tiomap_sm.c      |   32 +++++++--------
 2 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index a725548..7cc29b7 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -295,59 +295,40 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
  */
 DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
-	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
-	struct CFG_HOSTRES resources;
+	DSP_STATUS status = DSP_SOK;
+#ifdef CONFIG_BRIDGE_DEBUG
 	enum HW_PwrState_t pwrState;
-	u32 temp;
+	struct CFG_HOSTRES resources;
 
 	status = CFG_GetHostResources(
 		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status))
 		return status;
-	/* check the BRD/WMD state, if it is not 'SLEEP' then return failure */
+#endif /* CONFIG_BRIDGE_DEBUG */
+
+	/* Check the BRD/WMD state, if it is not 'SLEEP' then return failure */
 	if (pDevContext->dwBrdState == BRD_RUNNING ||
-		pDevContext->dwBrdState == BRD_STOPPED ||
-		pDevContext->dwBrdState == BRD_DSP_HIBERNATION) {
+	    pDevContext->dwBrdState == BRD_STOPPED) {
 		/* The Device is in 'RET' or 'OFF' state and WMD state is not
 		 * 'SLEEP', this means state inconsistency, so return  */
-		status = DSP_SOK;
-		return status;
-	}
-	/* Enable the DSP peripheral clocks and load monitor timer
-	 * before waking the DSP */
-	DBG_Trace(DBG_LEVEL6, "WakeDSP: enable DSP Peripheral Clks = 0x%x \n",
-		 pDevContext->uDspPerClks);
-	status = DSP_PeripheralClocks_Enable(pDevContext, NULL);
-
-	/* Enabling Dppll in lock mode */
-		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwCmBase) + 0x34));
-		temp = (temp & 0xFFFFFFFE) | 0x1;
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
-						(u32) temp;
-		temp = (u32) *((REG_UWORD32 *)
-			((u32) (resources.dwCmBase) + 0x4));
-		temp = (temp & 0xFFFFFC8) | 0x37;
-
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
-						(u32) temp;
-
-	udelay(10);
-	if (DSP_SUCCEEDED(status)) {
-		/* Send a message to DSP to wake up */
-		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
-		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
-				    &pwrState);
-		DBG_Trace(DBG_LEVEL7,
-			 "\nWakeDSP: Power State After sending Interrupt "
-			 "to DSP %x\n", pwrState);
-		/* set the device state to RUNNIG */
-		pDevContext->dwBrdState = BRD_RUNNING;
-	} else {
-		DBG_Trace(DBG_LEVEL6, "WakeDSP: FAILED\n");
+		return DSP_SOK;
 	}
-#endif
+
+	/* Send a wakeup message to DSP */
+	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+
+#ifdef CONFIG_BRIDGE_DEBUG
+	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
+			&pwrState);
+	DBG_Trace(DBG_LEVEL7,
+			"\nWakeDSP: Power State After sending Interrupt "
+			"to DSP %x\n", pwrState);
+#endif /* CONFIG_BRIDGE_DEBUG */
+
+	/* Set the device state to RUNNIG */
+	pDevContext->dwBrdState = BRD_RUNNING;
+#endif /* CONFIG_PM */
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index a6d5d62..b5d3d6d 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -126,24 +126,22 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 
 	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
 	    pDevContext->dwBrdState == BRD_HIBERNATION) {
+		/* Restart the peripheral clocks */
+		DSP_PeripheralClocks_Enable(pDevContext, NULL);
+
 		/* Restore mailbox settings */
-		/* Restart the peripheral clocks that were disabled only
-		 * in DSP initiated Hibernation case.*/
-		if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION) {
-			DSP_PeripheralClocks_Enable(pDevContext, NULL);
-			/* Enabling Dpll in lock mode*/
-			temp = (u32) *((REG_UWORD32 *)
-				       ((u32) (resources.dwCmBase) + 0x34));
-			temp = (temp & 0xFFFFFFFE) | 0x1;
-			*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
-				(u32) temp;
-			temp = (u32) *((REG_UWORD32 *)
-				       ((u32) (resources.dwCmBase) + 0x4));
-			temp = (temp & 0xFFFFFC8) | 0x37;
-
-			*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
-				(u32) temp;
-		}
+		/* Enabling Dpll in lock mode*/
+		temp = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCmBase) + 0x34));
+		temp = (temp & 0xFFFFFFFE) | 0x1;
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+			(u32) temp;
+		temp = (u32) *((REG_UWORD32 *)
+				((u32) (resources.dwCmBase) + 0x4));
+		temp = (temp & 0xFFFFFC8) | 0x37;
+
+		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
+			(u32) temp;
 		HW_MBOX_restoreSettings(resources.dwMboxBase);
 
 		/*  Access MMU SYS CONFIG register to generate a short wakeup */
-- 
1.6.2.4

