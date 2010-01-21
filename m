From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Fix BUG scheduling while atomic
Date: Thu, 21 Jan 2010 11:43:27 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DF3B7BA@dlee03.ent.ti.com>
References: <1264046462-2417-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab0AURne convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 12:43:34 -0500
In-Reply-To: <1264046462-2417-1-git-send-email-deepak.chitriki@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Chitriki Rudramuni, Deepak on Wednesday, January 20, 2010 10:01 PM
>
>From: Fernando Guzman Lugo <x0095840@ti.com>
>
>This patch fixes the BUG schedule/sleep while atomic which
>was in the IO_DPC function, this function runs as a tasklet
>and called a function that could be scheduled (OPP change).
>we use in_interrupt to detect this and handle accordingly
>
>Original Patch by Fernando:
>http://dev.omapzoom.org/?p=tidspbridge/kernel-
>dspbridge.git;a=commitdiff;h=2dcd1964a138c85b5545f687f96c96b489fe4a00

This patch was meant to be reworked before sending.

>
>Cc: Ameya Palande <ameya.palande@nokia.com>
>Cc: Felipe Contreras <felipe.contreras@nokia.com>
>Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
>Cc: Nishanth Menon <nm@ti.com>
>Cc: Omar Ramirez <omap.ramirez@ti.com>

mail is wrong :) it would be a nice nickname though

>
>Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
>---
> drivers/dsp/bridge/wmd/_tiomap_pwr.h    |    7 +++++++
> drivers/dsp/bridge/wmd/io_sm.c          |    2 +-
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   31 +++++++++++++++++++++++++++++++
> drivers/dsp/bridge/wmd/tiomap_sm.c      |   13 ++-----------
> 4 files changed, 41 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
>index da2e7d9..54d7ca4 100644
>--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
>+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
>@@ -89,5 +89,12 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
>  */
> void DSPClkWakeupEventCtrl(u32 ClkId, bool enable);
>
>+/**
>+ * tiomap3430_bump_dsp_opp_level() - bump up opp if required
>+ *
>+ * if the system is at a minimum opp, request for higher opp
>+ */
>+DSP_STATUS tiomap3430_bump_dsp_opp_level(void);

Why DSP_STATUS if nobody checks?

>+
> #endif				/* _TIOMAP_PWR_ */
>
>diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
>index 79a714a..3481beb 100644
>--- a/drivers/dsp/bridge/wmd/io_sm.c
>+++ b/drivers/dsp/bridge/wmd/io_sm.c
>@@ -1132,7 +1132,7 @@ void IO_Schedule(struct IO_MGR *pIOMgr)
> 	spin_lock_irqsave(&pIOMgr->dpc_lock, flags);
> 	pIOMgr->dpc_req++;
> 	spin_unlock_irqrestore(&pIOMgr->dpc_lock, flags);
>-
>+	tiomap3430_bump_dsp_opp_level();
> 	/* Schedule DPC */
> 	tasklet_schedule(&pIOMgr->dpc_tasklet);
> }

This looks like:
	Increase DPC counts
	* Bump opp
	Schedule DPC

Should look better:
	* Bump opp
	Increase DPC counts
	Schedule DPC

>diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>index 94b399f..54cba9f 100644
>--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>@@ -806,3 +806,34 @@ void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
> 	break;
> 	}
> }
>+
>+/**
>+ * tiomap3430_bump_dsp_opp_level() - bump up the opp if at minimum
>+ *
>+ * if we need a higher opp index, request for the same
>+ */
>+DSP_STATUS tiomap3430_bump_dsp_opp_level(void)
>+{
>+#ifndef CONFIG_BRIDGE_DVFS

Basically if DVFS is defined nothing is done, this was wrong in the original patch (like I mentioned offline).

>+	u32 opplevel;
>+
>+	struct dspbridge_platform_data *pdata =
>+			omap_dspbridge_dev->dev.platform_data;
>+
>+	if (pdata->dsp_get_opp) {
>+		opplevel = (*pdata->dsp_get_opp)();
>+
>+		/*
>+		 * If OPP is at minimum level, increase it before waking
>+		 * up the DSP.
>+		 */
>+		if (opplevel == 1 && pdata->dsp_set_min_opp) {
>+			(*pdata->dsp_set_min_opp)(opp_level + 1);
>+			DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: Setting "
>+				"the vdd1 constraint level to %d before "
>+				"waking DSP \n", opp_level + 1);
>+		}
>+	}
>+#endif
>+	return DSP_SOK;
>+}

Since we are reworking all of this can be changed (u32, opplevel == MAGIC_NUM), besides this was specific to 3430.

>diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
>index b04ed6d..1d2e5d7 100644
>--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
>+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
>@@ -96,11 +96,6 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
> DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
> 				u16 wMbVal)
> {
>-#ifdef CONFIG_BRIDGE_DVFS
>-	struct dspbridge_platform_data *pdata =
>-		omap_dspbridge_dev->dev.platform_data;
>-	u32 opplevel = 0;
>-#endif
> 	struct CFG_HOSTRES resources;
> 	DSP_STATUS status = DSP_SOK;
> 	unsigned long timeout;
>@@ -114,12 +109,8 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
> 	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
> 	    pDevContext->dwBrdState == BRD_HIBERNATION) {
> #ifdef CONFIG_BRIDGE_DVFS
>-		if (pdata->dsp_get_opp)
>-			opplevel = (*pdata->dsp_get_opp)();
>-		if (opplevel == VDD1_OPP1) {
>-			if (pdata->dsp_set_min_opp)
>-				(*pdata->dsp_set_min_opp)(VDD1_OPP2);
>-		}
>+		if (!in_interrupt())
>+			tiomap3430_bump_dsp_opp_level();
> #endif
> 		/* Restart the peripheral clocks */
> 		DSP_PeripheralClocks_Enable(pDevContext, NULL);
>--
>1.6.0.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
