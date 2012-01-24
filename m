From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 07/13] ASoC: twl6040: Convert MICBIAS to SUPPLY widget
Date: Tue, 24 Jan 2012 13:52:24 +0200
Message-ID: <1327405950-6676-8-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:60612 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756427Ab2AXLw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:52:59 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id o2so2688468lag.2
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:52:57 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In order to avoid breakage change the omap-abe-twl6040
machine driver's routing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c        |   16 ++++++++--------
 sound/soc/omap/omap-abe-twl6040.c |   14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 5b9c79b..ece47ed 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1125,14 +1125,14 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_MICRCTL, 2, 0),
 
 	/* Microphone bias */
-	SND_SOC_DAPM_MICBIAS("Headset Mic Bias",
-			TWL6040_REG_AMICBCTL, 0, 0),
-	SND_SOC_DAPM_MICBIAS("Main Mic Bias",
-			TWL6040_REG_AMICBCTL, 4, 0),
-	SND_SOC_DAPM_MICBIAS("Digital Mic1 Bias",
-			TWL6040_REG_DMICBCTL, 0, 0),
-	SND_SOC_DAPM_MICBIAS("Digital Mic2 Bias",
-			TWL6040_REG_DMICBCTL, 4, 0),
+	SND_SOC_DAPM_SUPPLY("Headset Mic Bias",
+			    TWL6040_REG_AMICBCTL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Main Mic Bias",
+			    TWL6040_REG_AMICBCTL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Digital Mic1 Bias",
+			    TWL6040_REG_DMICBCTL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Digital Mic2 Bias",
+			    TWL6040_REG_DMICBCTL, 4, 0, NULL, 0),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback", SND_SOC_NOPM, 0, 0),
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 4ee0392..3b8d571 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -123,17 +123,17 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route audio_map[] = {
 	/* External Mics: MAINMIC, SUBMIC with bias*/
-	{"MAINMIC", NULL, "Main Mic Bias"},
-	{"SUBMIC", NULL, "Main Mic Bias"},
-	{"Main Mic Bias", NULL, "Ext Mic"},
+	{"MAINMIC", NULL, "Ext Mic"},
+	{"SUBMIC", NULL, "Ext Mic"},
+	{"Ext Mic", NULL, "Main Mic Bias"},
 
 	/* External Speakers: HFL, HFR */
 	{"Ext Spk", NULL, "HFL"},
 	{"Ext Spk", NULL, "HFR"},
 
 	/* Headset Mic: HSMIC with bias */
-	{"HSMIC", NULL, "Headset Mic Bias"},
-	{"Headset Mic Bias", NULL, "Headset Mic"},
+	{"HSMIC", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "Headset Mic Bias"},
 
 	/* Headset Stereophone (Headphone): HSOL, HSOR */
 	{"Headset Stereophone", NULL, "HSOL"},
@@ -182,8 +182,8 @@ static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route dmic_audio_map[] = {
-	{"DMic", NULL, "Digital Mic1 Bias"},
-	{"Digital Mic1 Bias", NULL, "Digital Mic"},
+	{"DMic", NULL, "Digital Mic"},
+	{"Digital Mic", NULL, "Digital Mic1 Bias"},
 };
 
 static int omapabe_dmic_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.7.8.3

