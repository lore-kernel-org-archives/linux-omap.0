From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/8] ASoC: omap-twl4030: Add support for routing, voice port and jack detect
Date: Mon, 31 Dec 2012 11:51:48 +0100
Message-ID: <1356951109-4286-8-git-send-email-peter.ujfalusi@ti.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55805 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2LaKwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 05:52:53 -0500
In-Reply-To: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, NeilBrown <neilb@suse.de>

Update the common machine driver to support more boards including Zoom2 and
SDP3430.
- Support for voice port of twl4030
- HS jack plug detection support
- The audio routing can be fine tuned via pdata or via provided routing
  table from DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-twl4030.txt     |  46 +++++
 sound/soc/omap/Kconfig                             |   2 +
 sound/soc/omap/omap-twl4030.c                      | 204 ++++++++++++++++++++-
 3 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
index 6fae51c..1ab6bc8 100644
--- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
+++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
@@ -6,6 +6,52 @@ Required properties:
 - ti,mcbsp: phandle for the McBSP node
 - ti,codec: phandle for the twl4030 audio node
 
+Optional properties:
+- ti,mcbsp-voice: phandle for the McBSP node connected to the voice port of twl
+- ti, jack-det-gpio: Jack detect GPIO
+- ti,audio-routing: List of connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+  If the routing is not provided all possible connection will be available
+
+Available audio endpoints for the audio-routing table:
+
+Board connectors:
+ * Headset Stereophone
+ * Earpiece Spk
+ * Handsfree Spk
+ * Ext Spk
+ * Main Mic
+ * Sub Mic
+ * Headset Mic
+ * Carkit Mic
+ * Digital0 Mic
+ * Digital1 Mic
+ * Line In
+
+twl4030 pins:
+ * HSOL
+ * HSOR
+ * EARPIECE
+ * HFL
+ * HFR
+ * PREDRIVEL
+ * PREDRIVER
+ * CARKITL
+ * CARKITR
+ * MAINMIC
+ * SUBMIC
+ * HSMIC
+ * DIGIMIC0
+ * DIGIMIC1
+ * CARKITMIC
+ * AUXL
+ * AUXR
+
+ * Headset Mic Bias
+ * Mic Bias 1 /* Used for Main Mic or Digimic0 */
+ * Mic Bias 2 /* Used for Sub Mic or Digimic1 */
+
 Example:
 
 sound {
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 7048137..e8d2a2f 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -91,6 +91,8 @@ config SND_OMAP_SOC_OMAP_TWL4030
 	  - Gumstix Overo or CompuLab CM-T35/CM-T3730
 	  - IGEP v2
 	  - OMAP3EVM
+	  - SDP3430
+	  - Zoom2
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 4541d28..fd98509 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -11,6 +11,8 @@
  * omap3evm (Author: Anuj Aggarwal <anuj.aggarwal@ti.com>)
  * overo (Author: Steve Sakoman <steve@sakoman.com>)
  * igep0020 (Author: Enric Balletbo i Serra <eballetbo@iseebcn.com>)
+ * zoom2 (Author: Misael Lopez Cruz <misael.lopez@ti.com>)
+ * sdp3430 (Author: Misael Lopez Cruz <misael.lopez@ti.com>)
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -32,14 +34,22 @@
 #include <linux/platform_data/omap-twl4030.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
+struct omap_twl4030 {
+	int jack_detect;	/* board can detect jack events */
+	struct snd_soc_jack hs_jack;
+};
+
 static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -87,17 +97,164 @@ static struct snd_soc_ops omap_twl4030_ops = {
 	.hw_params = omap_twl4030_hw_params,
 };
 
+static const struct snd_soc_dapm_widget dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Earpiece Spk", NULL),
+	SND_SOC_DAPM_SPK("Handsfree Spk", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_SPK("Carkit Spk", NULL),
+
+	SND_SOC_DAPM_MIC("Main Mic", NULL),
+	SND_SOC_DAPM_MIC("Sub Mic", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Carkit Mic", NULL),
+	SND_SOC_DAPM_MIC("Digital0 Mic", NULL),
+	SND_SOC_DAPM_MIC("Digital1 Mic", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Headset Stereophone:  HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+	/* External Speakers: HFL, HFR */
+	{"Handsfree Spk", NULL, "HFL"},
+	{"Handsfree Spk", NULL, "HFR"},
+	/* External Speakers: PredrivL, PredrivR */
+	{"Ext Spk", NULL, "PREDRIVEL"},
+	{"Ext Spk", NULL, "PREDRIVER"},
+	/* Carkit speakers:  CARKITL, CARKITR */
+	{"Carkit Spk", NULL, "CARKITL"},
+	{"Carkit Spk", NULL, "CARKITR"},
+	/* Earpiece */
+	{"Earpiece Spk", NULL, "EARPIECE"},
+
+	/* External Mics: MAINMIC, SUBMIC with bias */
+	{"MAINMIC", NULL, "Main Mic"},
+	{"Main Mic", NULL, "Mic Bias 1"},
+	{"SUBMIC", NULL, "Sub Mic"},
+	{"Sub Mic", NULL, "Mic Bias 2"},
+	/* Headset Mic: HSMIC with bias */
+	{"HSMIC", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "Headset Mic Bias"},
+	/* Digital Mics: DIGIMIC0, DIGIMIC1 with bias */
+	{"DIGIMIC0", NULL, "Digital0 Mic"},
+	{"Digital0 Mic", NULL, "Mic Bias 1"},
+	{"DIGIMIC1", NULL, "Digital1 Mic"},
+	{"Digital1 Mic", NULL, "Mic Bias 2"},
+	/* Carkit In: CARKITMIC */
+	{"CARKITMIC", NULL, "Carkit Mic"},
+	/* Aux In: AUXL, AUXR */
+	{"AUXL", NULL, "Line In"},
+	{"AUXR", NULL, "Line In"},
+};
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headset Stereophone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+/* Headset jack detection gpios */
+static struct snd_soc_jack_gpio hs_jack_gpios[] = {
+	{
+		.name = "hsdet-gpio",
+		.report = SND_JACK_HEADSET,
+		.debounce_time = 200,
+	},
+};
+
+static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *dapm,
+					  int connected, char *pin)
+{
+	if (!connected)
+		snd_soc_dapm_disable_pin(dapm, pin);
+}
+
+static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct omap_tw4030_pdata *pdata = dev_get_platdata(card->dev);
+	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	/* Headset jack detection only if it is supported */
+	if (priv->jack_detect > 0) {
+		hs_jack_gpios[0].gpio = priv->jack_detect;
+
+		ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
+				       &priv->hs_jack);
+		if (ret)
+			return ret;
+
+		ret = snd_soc_jack_add_pins(&priv->hs_jack,
+					    ARRAY_SIZE(hs_jack_pins),
+					    hs_jack_pins);
+		if (ret)
+			return ret;
+
+		ret = snd_soc_jack_add_gpios(&priv->hs_jack,
+					     ARRAY_SIZE(hs_jack_gpios),
+					     hs_jack_gpios);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * NULL pdata means we booted with DT. In this case the routing is
+	 * provided and the card is fully routed, no need to mark pins.
+	 */
+	if (!pdata || !pdata->custom_routing)
+		return ret;
+
+	/* Disable not connected paths if not used */
+	twl4030_disconnect_pin(dapm, pdata->has_ear, "Earpiece Spk");
+	twl4030_disconnect_pin(dapm, pdata->has_hf, "Handsfree Spk");
+	twl4030_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
+	twl4030_disconnect_pin(dapm, pdata->has_predriv, "Ext Spk");
+	twl4030_disconnect_pin(dapm, pdata->has_carkit, "Carkit Spk");
+
+	twl4030_disconnect_pin(dapm, pdata->has_mainmic, "Main Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_submic, "Sub Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_carkitmic, "Carkit Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_digimic0, "Digital0 Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_digimic1, "Digital1 Mic");
+	twl4030_disconnect_pin(dapm, pdata->has_linein, "Line In");
+
+	return ret;
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 	{
-		.name = "TWL4030",
-		.stream_name = "TWL4030",
+		.name = "TWL4030 HiFi",
+		.stream_name = "TWL4030 HiFi",
 		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
+		.init = omap_twl4030_init,
 		.ops = &omap_twl4030_ops,
 	},
+	{
+		.name = "TWL4030 Voice",
+		.stream_name = "TWL4030 Voice",
+		.cpu_dai_name = "omap-mcbsp.3",
+		.codec_dai_name = "twl4030-voice",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
+			   SND_SOC_DAIFMT_CBM_CFM,
+	},
 };
 
 /* Audio machine driver */
@@ -105,6 +262,11 @@ static struct snd_soc_card omap_twl4030_card = {
 	.owner = THIS_MODULE,
 	.dai_link = omap_twl4030_dai_links,
 	.num_links = ARRAY_SIZE(omap_twl4030_dai_links),
+
+	.dapm_widgets = dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int omap_twl4030_probe(struct platform_device *pdev)
@@ -112,12 +274,18 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_twl4030_card;
+	struct omap_twl4030 *priv;
 	int ret = 0;
 
 	card->dev = &pdev->dev;
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct omap_twl4030), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
 	if (node) {
 		struct device_node *dai_node;
+		struct property *prop;
 
 		if (snd_soc_of_parse_card_name(card, "ti,model")) {
 			dev_err(&pdev->dev, "Card name is not provided\n");
@@ -132,6 +300,27 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 		omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
 		omap_twl4030_dai_links[0].cpu_of_node = dai_node;
 
+		dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
+		if (!dai_node) {
+			card->num_links = 1;
+		} else {
+			omap_twl4030_dai_links[1].cpu_dai_name  = NULL;
+			omap_twl4030_dai_links[1].cpu_of_node = dai_node;
+		}
+
+		priv->jack_detect = of_get_named_gpio(node,
+						      "ti,jack-det-gpio", 0);
+
+		/* Optional: audio routing can be provided */
+		prop = of_find_property(node, "ti,audio-routing", NULL);
+		if (prop) {
+			ret = snd_soc_of_parse_audio_routing(card,
+							    "ti,audio-routing");
+			if (ret)
+				return ret;
+
+			card->fully_routed = 1;
+		}
 	} else if (pdata) {
 		if (pdata->card_name) {
 			card->name = pdata->card_name;
@@ -139,11 +328,17 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Card name is not provided\n");
 			return -ENODEV;
 		}
+
+		if (!pdata->voice_connected)
+			card->num_links = 1;
+
+		priv->jack_detect = pdata->jack_detect;
 	} else {
 		dev_err(&pdev->dev, "Missing pdata\n");
 		return -ENODEV;
 	}
 
+	snd_soc_card_set_drvdata(card, priv);
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
@@ -157,7 +352,12 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 static int omap_twl4030_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
 
+	if (priv->jack_detect > 0)
+		snd_soc_jack_free_gpios(&priv->hs_jack,
+					ARRAY_SIZE(hs_jack_gpios),
+					hs_jack_gpios);
 	snd_soc_unregister_card(card);
 
 	return 0;
-- 
1.8.0.2

