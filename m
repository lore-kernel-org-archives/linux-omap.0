From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Avoid saving mailbox settings on constraint request
Date: Tue, 22 Dec 2009 00:11:42 -0600
Message-ID: <1261462303-29437-2-git-send-email-omar.ramirez@ti.com>
References: <1261462303-29437-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59194 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZLVGEA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Dec 2009 01:04:00 -0500
In-Reply-To: <1261462303-29437-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

There is no need to save the mailbox settings if a request
to set the OPP constraint comes from the DSP.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index fd6097d..68b6993 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -80,18 +80,13 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 *pConstraintVal;
-	DSP_STATUS status = DSP_SOK;
-	struct CFG_HOSTRES resources;
 	struct dspbridge_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
-	status = CFG_GetHostResources(
-		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
 	pConstraintVal = (u32 *)(pArgs);
 	/* Read the target value requested by DSP  */
 	DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
 		"opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
-	status = HW_MBOX_saveSettings(resources.dwMboxBase);
 
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
-- 
1.6.2.4

