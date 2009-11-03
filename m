From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 5/6] DSPBRIDGE: Set vdd1 to OPP3 always in DSP wake up
Date: Tue, 3 Nov 2009 17:06:31 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6921175@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55913 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbZKCXG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:06:28 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3N6XGN019710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:06:33 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3N6XBP007225
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:06:33 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3N6WBa011520
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:06:32 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 424104463b418172a2c7c66c0b9ace83681b1fb9 Mon Sep 17 00:00:00 2001
From: Fernando Guzman <x0095840@ti.com>
Date: Thu, 15 Oct 2009 20:09:36 -0500
Subject: [PATCH 5/6] DSPBRIDGE: Set vdd1 to OPP3 always in DSP wake up

This patch set the vdd1 to OPP3 always in DSP wake up.
Signed-off-by: Fernando Guzman <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index e793ad3..34e5a74 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -797,24 +797,24 @@ void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
 DSP_STATUS tiomap3430_bump_dsp_opp_level(void)
 {
 #ifdef CONFIG_BRIDGE_DVFS
-	u32 opplevel;
-
+	struct WMD_DEV_CONTEXT *dwContext;
+	struct DEV_OBJECT *hDevObject = DRV_GetFirstDevObject();
 	struct dspbridge_platform_data *pdata =
 			omap_dspbridge_dev->dev.platform_data;
 
-	if (pdata->dsp_get_opp && pdata->dsp_set_min_opp)
-		opplevel = (*pdata->dsp_get_opp)();
+	if (DSP_FAILED(DEV_GetWMDContext(hDevObject, &dwContext)))
+		return DSP_EFAIL;
 
+	if (dwContext->dwBrdState == BRD_DSP_HIBERNATION ||
+	    dwContext->dwBrdState == BRD_HIBERNATION) {
 		/*
-		 * If OPP is at minimum level, increase it before waking
-		 * up the DSP.
+		 * Increase OPP before waking up the DSP.
 		 */
-		if (opplevel < min_active_opp) {
-			(*pdata->dsp_set_min_opp)(min_active_opp);
-			DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: Setting "
-				"the vdd1 constraint level to %d before "
-				"waking DSP \n", min_active_opp);
-		}
+		(*pdata->dsp_set_min_opp)(min_active_opp);
+		DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: Setting "
+			"the vdd1 constraint level to %d before "
+			"waking DSP \n", min_active_opp);
+	}
 #endif
 	return DSP_SOK;
 }
-- 
1.6.2.4

