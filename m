From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 5/9] ASoC: omap-abe-twl6040: Add complete DAPM routing
Date: Thu, 22 Dec 2011 21:34:30 +0200
Message-ID: <1324582474-18181-6-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37575 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755684Ab1LVTfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 14:35:48 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id u2so3476322lag.9
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 11:35:47 -0800 (PST)
In-Reply-To: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

SDP4430 is a reference platform, and as such it has all possible
audio routing implemented.
Correct the DAPM routing to be complete.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   46 ++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 18a25b0..cf3cb08 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -113,38 +113,48 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 
 /* SDP4430 machine DAPM */
 static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Ext Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	/* Outputs */
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
-	SND_SOC_DAPM_INPUT("FM Stereo In"),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_SPK("Vibrator", NULL),
+
+	/* Inputs */
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Main Handset Mic", NULL),
+	SND_SOC_DAPM_MIC("Sub Handset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
-	/* External Mics: MAINMIC, SUBMIC with bias*/
-	{"MAINMIC", NULL, "Ext Mic"},
-	{"SUBMIC", NULL, "Ext Mic"},
-	{"Ext Mic", NULL, "Main Mic Bias"},
+	/* Routings for outputs */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+
+	{"Earphone Spk", NULL, "EP"},
 
-	/* External Speakers: HFL, HFR */
 	{"Ext Spk", NULL, "HFL"},
 	{"Ext Spk", NULL, "HFR"},
 
-	/* Headset Mic: HSMIC with bias */
+	{"Line Out", NULL, "AUXL"},
+	{"Line Out", NULL, "AUXR"},
+
+	{"Vibrator", NULL, "VIBRAL"},
+	{"Vibrator", NULL, "VIBRAR"},
+
+	/* Routings for inputs */
 	{"HSMIC", NULL, "Headset Mic"},
 	{"Headset Mic", NULL, "Headset Mic Bias"},
 
-	/* Headset Stereophone (Headphone): HSOL, HSOR */
-	{"Headset Stereophone", NULL, "HSOL"},
-	{"Headset Stereophone", NULL, "HSOR"},
+	{"MAINMIC", NULL, "Main Handset Mic"},
+	{"Main Handset Mic", NULL, "Main Mic Bias"},
 
-	/* Earphone speaker */
-	{"Earphone Spk", NULL, "EP"},
+	{"SUBMIC", NULL, "Sub Handset Mic"},
+	{"Sub Handset Mic", NULL, "Main Mic Bias"},
 
-	/* Aux/FM Stereo In: AFML, AFMR */
-	{"AFML", NULL, "FM Stereo In"},
-	{"AFMR", NULL, "FM Stereo In"},
+	{"AFML", NULL, "Line In"},
+	{"AFMR", NULL, "Line In"},
 };
 
 static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.7.8.1

