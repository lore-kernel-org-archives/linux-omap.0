From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 01/11] ASoC: davinci-evm: Move sysclk logic away from evm_hw_params
Date: Thu, 19 Sep 2013 14:29:34 +0300
Message-ID: <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379590035.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The sysclk rate does not change runtime so it should be initialized at
init time.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/davinci-evm.c |   64 +++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index fd7c45b..2f8161c 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -27,6 +27,10 @@
 #include "davinci-i2s.h"
 #include "davinci-mcasp.h"
 
+struct snd_soc_card_drvdata_davinci {
+	unsigned sysclk;
+};
+
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
 		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
 static int evm_hw_params(struct snd_pcm_substream *substream,
@@ -35,27 +39,11 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *soc_card = codec->card;
 	int ret = 0;
-	unsigned sysclk;
-
-	/* ASP1 on DM355 EVM is clocked by an external oscillator */
-	if (machine_is_davinci_dm355_evm() || machine_is_davinci_dm6467_evm() ||
-	    machine_is_davinci_dm365_evm())
-		sysclk = 27000000;
-
-	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
-	 * board-dm644x-evm.c using GPIOs from U18.  There are six
-	 * options; here we "know" we use a 48 KHz sample rate.
-	 */
-	else if (machine_is_davinci_evm())
-		sysclk = 12288000;
-
-	else if (machine_is_davinci_da830_evm() ||
-				machine_is_davinci_da850_evm())
-		sysclk = 24576000;
-
-	else
-		return -EINVAL;
+	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
+			   snd_soc_card_get_drvdata(soc_card))->sysclk;
 
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
@@ -243,35 +231,65 @@ static struct snd_soc_dai_link da850_evm_dai = {
 };
 
 /* davinci dm6446 evm audio machine driver */
+/*
+ * ASP0 in DM6446 EVM is clocked by U55, as configured by
+ * board-dm644x-evm.c using GPIOs from U18.  There are six
+ * options; here we "know" we use a 48 KHz sample rate.
+ */
+static struct snd_soc_card_drvdata_davinci dm6446_snd_soc_card_drvdata = {
+	.sysclk = 12288000,
+};
+
 static struct snd_soc_card dm6446_snd_soc_card_evm = {
 	.name = "DaVinci DM6446 EVM",
 	.owner = THIS_MODULE,
 	.dai_link = &dm6446_evm_dai,
 	.num_links = 1,
+	.drvdata = &dm6446_snd_soc_card_drvdata,
 };
 
 /* davinci dm355 evm audio machine driver */
+/* ASP1 on DM355 EVM is clocked by an external oscillator */
+static struct snd_soc_card_drvdata_davinci dm355_snd_soc_card_drvdata = {
+	.sysclk = 27000000,
+};
+
 static struct snd_soc_card dm355_snd_soc_card_evm = {
 	.name = "DaVinci DM355 EVM",
 	.owner = THIS_MODULE,
 	.dai_link = &dm355_evm_dai,
 	.num_links = 1,
+	.drvdata = &dm355_snd_soc_card_drvdata,
 };
 
 /* davinci dm365 evm audio machine driver */
+static struct snd_soc_card_drvdata_davinci dm365_snd_soc_card_drvdata = {
+	.sysclk = 27000000,
+};
+
 static struct snd_soc_card dm365_snd_soc_card_evm = {
 	.name = "DaVinci DM365 EVM",
 	.owner = THIS_MODULE,
 	.dai_link = &dm365_evm_dai,
 	.num_links = 1,
+	.drvdata = &dm365_snd_soc_card_drvdata,
 };
 
 /* davinci dm6467 evm audio machine driver */
+static struct snd_soc_card_drvdata_davinci dm6467_snd_soc_card_drvdata = {
+	.sysclk = 27000000,
+};
+
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
 	.owner = THIS_MODULE,
 	.dai_link = dm6467_evm_dai,
 	.num_links = ARRAY_SIZE(dm6467_evm_dai),
+	.drvdata = &dm6467_snd_soc_card_drvdata,
+};
+
+static struct snd_soc_card_drvdata_davinci da830_snd_soc_card_drvdata = {
+	.sysclk = 24576000,
 };
 
 static struct snd_soc_card da830_snd_soc_card = {
@@ -279,6 +297,11 @@ static struct snd_soc_card da830_snd_soc_card = {
 	.owner = THIS_MODULE,
 	.dai_link = &da830_evm_dai,
 	.num_links = 1,
+	.drvdata = &da830_snd_soc_card_drvdata,
+};
+
+static struct snd_soc_card_drvdata_davinci da850_snd_soc_card_drvdata = {
+	.sysclk = 24576000,
 };
 
 static struct snd_soc_card da850_snd_soc_card = {
@@ -286,6 +309,7 @@ static struct snd_soc_card da850_snd_soc_card = {
 	.owner = THIS_MODULE,
 	.dai_link = &da850_evm_dai,
 	.num_links = 1,
+	.drvdata = &da850_snd_soc_card_drvdata,
 };
 
 static struct platform_device *evm_snd_device;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
