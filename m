From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 4/5] ASoC: davinci-evm: Add AM43xx-EPOS-EVM audio support
Date: Wed, 26 Feb 2014 11:14:28 +0200
Message-ID: <db3067a150e8e1be0f972a3067b684d4ef04317e.1393405575.git.jsarha@ti.com>
References: <cover.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50518 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaBZJOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 04:14:49 -0500
In-Reply-To: <cover.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Add machine driver support for AM43xx-ePOS-EVM and update associated
device tree binding document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-evm-audio.txt           |    9 +++--
 sound/soc/davinci/davinci-evm.c                    |   41 ++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
index 865178d..356cba1 100644
--- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
@@ -2,8 +2,10 @@
 
 Required properties:
 - compatible : "ti,da830-evm-audio" : forDM365/DA8xx/OMAPL1x/AM33xx
+  	     : "ti,am43xx-epos-evm-audio" : for am43xx-epos-evm
 - ti,model : The user-visible name of this sound complex.
-- ti,audio-codec : The phandle of the TLV320AIC3x audio codec
+- ti,audio-codec : The phandle of the TLV320AIC3x audio codec,
+  		   or the TLV320AIC31xx audio codec.
 - ti,mcasp-controller : The phandle of the McASP controller
 - ti,codec-clock-rate : The Codec Clock rate (in Hz) applied to the Codec
 - ti,audio-routing : A list of the connections between audio components.
@@ -14,9 +16,10 @@ Required properties:
   Board connectors:
 
   * Headphone Jack
-  * Line Out
+  * Line Out - "ti,da830-evm-audio" only
   * Mic Jack
-  * Line In
+  * Line In - "ti,da830-evm-audio" only
+  * Speaker - "ti,am43xx-epos-evm-audio" only
 
 
 Example:
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 5e3bc3c..d4d965e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -128,6 +128,33 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+/* Logic for EVMs with an aic31xx */
+static int evm_aic31xx_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct device_node *np = codec->card->dev->of_node;
+	int ret;
+
+	snd_soc_dapm_new_controls(dapm, aic31xx_dapm_widgets,
+				  ARRAY_SIZE(aic31xx_dapm_widgets));
+
+	if (np) {
+		ret = snd_soc_of_parse_audio_routing(codec->card,
+						     "ti,audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* davinci-evm digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link dm6446_evm_dai = {
 	.name = "TLV320AIC3X",
@@ -326,11 +353,25 @@ static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
 		   SND_SOC_DAIFMT_IB_NF,
 };
 
+static struct snd_soc_dai_link evm_dai_tlv320aic3111 = {
+	.name		= "TLV320AIC3111",
+	.stream_name	= "AIC3111",
+	.codec_dai_name	= "tlv320aic31xx-hifi",
+	.ops		= &evm_ops,
+	.init		= evm_aic31xx_init,
+	.dai_fmt	= (SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_B |
+			   SND_SOC_DAIFMT_IB_NF),
+};
+
 static const struct of_device_id davinci_evm_dt_ids[] = {
 	{
 		.compatible = "ti,da830-evm-audio",
 		.data = (void *) &evm_dai_tlv320aic3x,
 	},
+	{
+		.compatible = "ti,am43xx-epos-evm-audio",
+		.data = &evm_dai_tlv320aic3111,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, davinci_evm_dt_ids);
-- 
1.7.9.5

