From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: improve constraint_value handling
Date: Wed, 20 Jan 2010 23:45:09 -0600
Message-ID: <1264052710-30337-2-git-send-email-nm@ti.com>
References: <[PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq>
 <1264052710-30337-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38492 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0AUFpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 00:45:22 -0500
In-Reply-To: <1264052710-30337-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

currently pConstraint value is a pointer which is dereferenced
twice(when debug is enabled) to get to the opp index. instead
dereference it correctly once. since the meaning of the variable
changes, rename it as opp_idx

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 084f406..5dfbef8 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -66,18 +66,20 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 				  IN void *pArgs)
 {
 #ifdef CONFIG_BRIDGE_DVFS
-	u32 *pConstraintVal;
+	u32 opp_idx;
 	struct dspbridge_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
-	pConstraintVal = (u32 *)(pArgs);
+	/* pick up the opp index */
+	opp_idx = *(((u32 *)(pArgs)) + 1);
+
 	/* Read the target value requested by DSP  */
 	DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
-		"opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
+		"opp requested = 0x%x\n", opp_idx);
 
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
-		(*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
+		(*pdata->dsp_set_min_opp)(opp_idx);
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 	return DSP_SOK;
 }
-- 
1.6.3.3

