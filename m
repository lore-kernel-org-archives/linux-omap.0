From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 7/9] ASoC: omap-abe-twl6040: Configure card according to platform data
Date: Thu, 22 Dec 2011 14:42:46 +0200
Message-ID: <1324557768-8216-8-git-send-email-peter.ujfalusi@ti.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38881 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755243Ab1LVMnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 07:43:37 -0500
Received: by lahj13 with SMTP id j13so2845367lah.25
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 04:43:34 -0800 (PST)
In-Reply-To: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Disable the not connected pins on the board based on the
received platform data.
DO not register the jack function on boards, which does not have
means to detect it (jack is always connected).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   41 ++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 9e6e4c2..7a8fbe2 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -157,10 +157,29 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"AFMR", NULL, "Line In"},
 };
 
+#define twl6040_disconnect_pin(dapm, connected, pin)	\
+	if (!connected)					\
+		snd_soc_dapm_disable_pin(dapm, pin);
+
 static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	int ret, hs_trim;
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
+	int hs_trim;
+	int ret = 0;
+
+	/* Disable not connected paths if not used */
+	twl6040_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
+	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
+	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vinrator");
+	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_afm, "Line In");
 
 	/*
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
@@ -170,19 +189,17 @@ static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	omap_mcpdm_configure_dn_offsets(rtd, TWL6040_HSF_TRIM_LEFT(hs_trim),
 					TWL6040_HSF_TRIM_RIGHT(hs_trim));
 
-	/* Headset jack detection */
-	ret = snd_soc_jack_new(codec, "Headset Jack",
-				SND_JACK_HEADSET, &hs_jack);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
-				hs_jack_pins);
+	/* Headset jack detection only if it is supported */
+	if (pdata->jack_detection) {
+		ret = snd_soc_jack_new(codec, "Headset Jack",
+					SND_JACK_HEADSET, &hs_jack);
+		if (ret)
+			return ret;
 
-	if (machine_is_omap_4430sdp())
+		ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+					hs_jack_pins);
 		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
-	else
-		snd_soc_jack_report(&hs_jack, SND_JACK_HEADSET, SND_JACK_HEADSET);
+	}
 
 	return ret;
 }
-- 
1.7.8.1

