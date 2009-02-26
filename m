From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/3] ASoC: Add DAPM machine widgets to SDP3430 driver
Date: Thu, 26 Feb 2009 01:57:32 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C04@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbZBZH5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 02:57:46 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Add DAPM machine domain widgets to SDP3430 machine driver.
Current interconection:
* Ext Mic: MAINMIC, SUBMIC
* Ext Spk: HFL, HFR
* Headset Jack: HSMIC, HSOL, HSOR

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index e226fa7..7a996d9 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -81,12 +81,73 @@ static struct snd_soc_ops sdp3430_ops = {
 	.hw_params = sdp3430_hw_params,
 };
 
+/* SDP3430 machine DAPM */
+static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Ext Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_HP("Headset Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* External Mics: MAINMIC, SUBMIC */
+	{"MAINMIC", NULL, "Ext Mic"},
+	{"SUBMIC", NULL, "Ext Mic"},
+
+	/* External Speakers: HFL, HFR */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset: HSMIC, HSOL, HSOR */
+	{"Headset Jack", NULL, "HSOL"},
+	{"Headset Jack", NULL, "HSOR"},
+	{"HSMIC", NULL, "Headset Jack"},
+};
+
+static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* SDP3430 connected pins */
+	snd_soc_dapm_enable_pin(codec, "Ext Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_enable_pin(codec, "Headset Jack");
+
+	/* TWL4030 not connected pins */
+	snd_soc_dapm_nc_pin(codec, "AUXL");
+	snd_soc_dapm_nc_pin(codec, "AUXR");
+	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
+
+	snd_soc_dapm_nc_pin(codec, "OUTL");
+	snd_soc_dapm_nc_pin(codec, "OUTR");
+	snd_soc_dapm_nc_pin(codec, "EARPIECE");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
+	snd_soc_dapm_nc_pin(codec, "CARKITL");
+	snd_soc_dapm_nc_pin(codec, "CARKITR");
+
+	/* Add SDP3430 specific widgets */
+	ret = snd_soc_dapm_new_controls(codec, sdp3430_twl4030_dapm_widgets,
+				ARRAY_SIZE(sdp3430_twl4030_dapm_widgets));
+	if (ret)
+		return ret;
+
+	/* Set up SDP3430 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	ret = snd_soc_dapm_sync(codec);
+
+	return ret;
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link sdp3430_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
 	.codec_dai = &twl4030_dai,
+	.init = sdp3430_twl4030_init,
 	.ops = &sdp3430_ops,
 };
 
-- 
1.5.4.3
