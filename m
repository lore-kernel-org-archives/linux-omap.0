From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while moving to off mode
Date: Wed, 15 Jul 2009 17:56:34 +0300
Message-ID: <1247669795-23895-12-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61042 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbZGOO4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:49 -0400
In-Reply-To: <1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 7cc29b7..7c7d9c4 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -167,17 +167,19 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 			if (DSP_FAILED(status))
 				return status;
 			IO_SHMsetting(hIOMgr, SHM_GETOPP, &opplevel);
-			/* Set the OPP to low level before moving to OFF mode */
 			if (opplevel != VDD1_OPP1) {
 				DBG_Trace(DBG_LEVEL5,
-					"Tiomap_pwr.c - DSP requested"
-					" OPP = %d, MPU requesting low"
-					" OPP %d instead\n", opplevel,
-					VDD1_OPP1);
-				if (pdata->dsp_set_min_opp)
-					(*pdata->dsp_set_min_opp)(VDD1_OPP1);
-				status = DSP_SOK;
+					" DSP requested OPP = %d, MPU"
+					" requesting low OPP %d instead\n",
+					opplevel, VDD1_OPP1);
 			}
+			/*
+			 * Set the OPP to low level before moving to OFF
+			 * mode
+			 */
+			if (pdata->dsp_set_min_opp)
+				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
+			status = DSP_SOK;
 #endif /* CONFIG_BRIDGE_DVFS */
 		} else {
 			DBG_Trace(DBG_LEVEL7,
-- 
1.6.2.4

