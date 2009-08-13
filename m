From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: Set VDD1 OPP1 while MPU initiated OFF
 mode
Date: Thu, 13 Aug 2009 01:37:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53041956F243@dlee03.ent.ti.com>
References: <1248272767-29223-1-git-send-email-ameya.palande@nokia.com>
 <1248418882-28164-1-git-send-email-ameya.palande@nokia.com>
 <1248418882-28164-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55629 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZHMGiE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 02:38:04 -0400
In-Reply-To: <1248418882-28164-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 2/2] DSPBRIDGE: Set VDD1 OPP1 while MPU initiated OFF mode
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

>---
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   15 ++++++++++++++-
> 1 files changed, 14 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>index 7aa58d1..dfac5b6 100644
>--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>@@ -292,8 +292,21 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
>
> 		/* Turn off DSP Peripheral clocks  */
> 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
>-		if (DSP_FAILED(status))
>+		if (DSP_FAILED(status)) {
> 			DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
>+			return status;
>+		}
>+#ifdef CONFIG_BRIDGE_DVFS
>+		else if (targetPwrState == HW_PWR_STATE_OFF) {
>+			struct dspbridge_platform_data *pdata =
>+				omap_dspbridge_dev->dev.platform_data;
>+			/*
>+			 * Set the OPP to low level before moving to OFF mode
>+			 */
>+			if (pdata->dsp_set_min_opp)
>+				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
>+		}
>+#endif /* CONFIG_BRIDGE_DVFS */
> 	}
> #endif /* CONFIG_PM */
> 	return status;
>--
>1.6.2.4
>

