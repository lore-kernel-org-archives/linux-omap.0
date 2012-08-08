From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/11] ASoC: omap-mcbsp: Sidetone: Use SIDLE bits in SYSCONFIG register to select noidle mode
Date: Wed,  8 Aug 2012 12:11:37 +0300
Message-ID: <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:40963 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757914Ab2HHJMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:12:20 -0400
Received: by obbup19 with SMTP id up19so962190obb.26
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:12:19 -0700 (PDT)
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Instead of the callback (which modifies control module register) use the
McBSP module's SYSCONFIG register to disable smart-idle mode when the
sidetone is enabled.
Store the original SIDLEMODE configuration and restore it when the sidetone
has been disabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |   18 ++++++++++++++----
 sound/soc/omap/mcbsp.h |    1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index c870023..e008898 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -257,8 +257,15 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
 
-	if (mcbsp->pdata->enable_st_clock)
-		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
+	/*
+	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
+	 * are enabled or sidetones start sounding ugly.
+	 */
+	w = MCBSP_READ(mcbsp, SYSCON);
+	mcbsp->st_data->mcbsp_sidle = (w >> 3) & 0x3;
+	w &= ~SIDLEMODE(0x3);
+	w |= SIDLEMODE(0x1);
+	MCBSP_WRITE(mcbsp, SYSCON, w);
 
 	/* Enable McBSP Sidetone */
 	w = MCBSP_READ(mcbsp, SSELCR);
@@ -279,8 +286,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
 
-	if (mcbsp->pdata->enable_st_clock)
-		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
+	/* Restore the SIDLEMODE as it was before the ST has been started */
+	w = MCBSP_READ(mcbsp, SYSCON);
+	w &= ~SIDLEMODE(0x3);
+	w |= SIDLEMODE(mcbsp->st_data->mcbsp_sidle);
+	MCBSP_WRITE(mcbsp, SYSCON, w);
 }
 
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 49a6725..ba82846 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -280,6 +280,7 @@ struct omap_mcbsp_st_data {
 	int nr_taps;	/* Number of filter coefficients in use */
 	s16 ch0gain;
 	s16 ch1gain;
+	unsigned int mcbsp_sidle;
 };
 
 struct omap_mcbsp {
-- 
1.7.8.6

