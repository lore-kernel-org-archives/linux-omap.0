From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: Set VDD1 OPP1 while MPU initiated OFF mode
Date: Fri, 24 Jul 2009 10:01:21 +0300
Message-ID: <1248418882-28164-2-git-send-email-ameya.palande@nokia.com>
References: <1248272767-29223-1-git-send-email-ameya.palande@nokia.com>
 <1248418882-28164-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51720 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZGXHBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 03:01:45 -0400
In-Reply-To: <1248418882-28164-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 7aa58d1..dfac5b6 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -292,8 +292,21 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 
 		/* Turn off DSP Peripheral clocks  */
 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
-		if (DSP_FAILED(status))
+		if (DSP_FAILED(status)) {
 			DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
+			return status;
+		}
+#ifdef CONFIG_BRIDGE_DVFS
+		else if (targetPwrState == HW_PWR_STATE_OFF) {
+			struct dspbridge_platform_data *pdata =
+				omap_dspbridge_dev->dev.platform_data;
+			/*
+			 * Set the OPP to low level before moving to OFF mode
+			 */
+			if (pdata->dsp_set_min_opp)
+				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
+		}
+#endif /* CONFIG_BRIDGE_DVFS */
 	}
 #endif /* CONFIG_PM */
 	return status;
-- 
1.6.2.4

