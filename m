From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 09/13] DSPBRIDGE: fix incorrect mask of DPLL in CHNLSM_InterruptDSP2()
Date: Wed, 15 Jul 2009 17:56:32 +0300
Message-ID: <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61039 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbZGOO4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:47 -0400
In-Reply-To: <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

This patch also contains indentation fixes and cleanups for
CHNLSM_InterruptDSP2().

[Hiroshi DOYU: split the original to logical ones]

Reported-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   56 +++++++++++++++++------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index b5d3d6d..7d389e3 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -108,60 +108,58 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 	unsigned long timeout;
 	u32 temp;
 
-	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				      &resources);
+	status = CFG_GetHostResources((struct CFG_DEVNODE *)
+			DRV_GetFirstDevExtension(), &resources);
 	if (DSP_FAILED(status))
 		return DSP_EFAIL;
-#ifdef CONFIG_BRIDGE_DVFS
+
 	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
 	    pDevContext->dwBrdState == BRD_HIBERNATION) {
+#ifdef CONFIG_BRIDGE_DVFS
 		if (pdata->dsp_get_opp)
 			opplevel = (*pdata->dsp_get_opp)();
-		if (opplevel == 1) {
+		if (opplevel == VDD1_OPP1) {
 			if (pdata->dsp_set_min_opp)
-				(*pdata->dsp_set_min_opp)(opplevel+1);
+				(*pdata->dsp_set_min_opp)(VDD1_OPP2);
 		}
-	}
 #endif
-
-	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
-	    pDevContext->dwBrdState == BRD_HIBERNATION) {
 		/* Restart the peripheral clocks */
 		DSP_PeripheralClocks_Enable(pDevContext, NULL);
 
+		/*
+		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
+		 *     in CM_AUTOIDLE_PLL_IVA2 register
+		 */
+		*(REG_UWORD32 *)(resources.dwCmBase + 0x34) = 0x1;
+
+		/*
+		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
+		 *     0.75 MHz - 1.0 MHz
+		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
+		 */
+		temp = *(REG_UWORD32 *)(resources.dwCmBase + 0x4);
+		temp = (temp & 0xFFFFFF08) | 0x37;
+		*(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
+
 		/* Restore mailbox settings */
-		/* Enabling Dpll in lock mode*/
-		temp = (u32) *((REG_UWORD32 *)
-				((u32) (resources.dwCmBase) + 0x34));
-		temp = (temp & 0xFFFFFFFE) | 0x1;
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
-			(u32) temp;
-		temp = (u32) *((REG_UWORD32 *)
-				((u32) (resources.dwCmBase) + 0x4));
-		temp = (temp & 0xFFFFFC8) | 0x37;
-
-		*((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
-			(u32) temp;
 		HW_MBOX_restoreSettings(resources.dwMboxBase);
 
-		/*  Access MMU SYS CONFIG register to generate a short wakeup */
-		temp = (u32) *((REG_UWORD32 *) ((u32)
-						(resources.dwDmmuBase) + 0x10));
+		/* Access MMU SYS CONFIG register to generate a short wakeup */
+		temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
+
 	timeout = jiffies + msecs_to_jiffies(1);
 	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
 		if (time_after(jiffies, timeout)) {
-			printk(KERN_ERR "dspbridge: timed out waiting for mailbox\n");
+			pr_err("dspbridge: timed out waiting for mailbox\n");
 			return WMD_E_TIMEOUT;
 		}
 	}
-	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
-		  wMbVal);
 
-	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-			 wMbVal);
+	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
+	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP, wMbVal);
 	return DSP_SOK;
 }
 
-- 
1.6.2.4

