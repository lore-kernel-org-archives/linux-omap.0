From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 2/9] ASoC: davinci-evm: Add named clock reference to DT bindings
Date: Tue, 19 Nov 2013 14:12:22 +0200
Message-ID: <f1a36fea1ea4f452fd716c70a4fb2fb6d6186e1a.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48097 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab3KSMNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Nov 2013 07:13:22 -0500
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The referenced clock is used to get codec clock rate and the clock is
disabled and enabled in startup and shutdown snd_soc_ops call
backs. The change is also documented in DT bindigs document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-evm-audio.txt           |    9 ++-
 sound/soc/davinci/davinci-evm.c                    |   60 +++++++++++++++++++-
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
index 865178d..4aa00f6 100644
--- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
@@ -5,12 +5,19 @@ Required properties:
 - ti,model : The user-visible name of this sound complex.
 - ti,audio-codec : The phandle of the TLV320AIC3x audio codec
 - ti,mcasp-controller : The phandle of the McASP controller
-- ti,codec-clock-rate : The Codec Clock rate (in Hz) applied to the Codec
 - ti,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
   the second being the connection's source. Valid names for sources and
   sinks are the codec's pins, and the jacks on the board:
 
+Optional properties:
+- ti,codec-clock-rate : The Codec Clock rate (in Hz) applied to the Codec.
+- clocks : Reference to the clock used as codec clock
+- clock-names : The codec clock should be named "ti,codec-clock"
+- Either codec-clock-rate or the codec-clock reference has to be defined. If
+  the both are defined the driver attempts to set referenced clock to the
+  defined rate and takes the rate from the clock reference.
+
   Board connectors:
 
   * Headphone Jack
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 70ff377..b28c9fd 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/edma.h>
 #include <linux/i2c.h>
 #include <linux/of_platform.h>
+#include <linux/clk.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -30,9 +31,30 @@
 #include "davinci-i2s.h"
 
 struct snd_soc_card_drvdata_davinci {
+	struct clk *mclk;
 	unsigned sysclk;
 };
 
+static int evm_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct clk *mclk = ((struct snd_soc_card_drvdata_davinci *)
+			    snd_soc_card_get_drvdata(soc_card))->mclk;
+
+	return clk_prepare_enable(mclk);
+}
+
+static void evm_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct clk *mclk = ((struct snd_soc_card_drvdata_davinci *)
+			    snd_soc_card_get_drvdata(soc_card))->mclk;
+
+	clk_disable_unprepare(mclk);
+}
+
 static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
@@ -59,6 +81,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_ops evm_ops = {
+	.startup = evm_startup,
+	.shutdown = evm_shutdown,
 	.hw_params = evm_hw_params,
 };
 
@@ -348,6 +372,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
 		of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
 	struct snd_soc_dai_link *dai = (struct snd_soc_dai_link *) match->data;
 	struct snd_soc_card_drvdata_davinci *drvdata = NULL;
+	struct clk *mclk;
 	int ret = 0;
 
 	evm_soc_card.dai_link = dai;
@@ -367,13 +392,38 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mclk = of_clk_get_by_name(np, "ti,codec-clock");
+	if (PTR_ERR(mclk) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(mclk)) {
+		dev_dbg(&pdev->dev, "Codec clock not found.\n");
+		mclk = NULL;
+	}
+
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->mclk = mclk;
+
 	ret = of_property_read_u32(np, "ti,codec-clock-rate", &drvdata->sysclk);
-	if (ret < 0)
-		return -EINVAL;
+
+	if (ret < 0) {
+		if (!drvdata->mclk) {
+			dev_err(&pdev->dev,
+				"No clock or clock rate defined.\n");
+			return -EINVAL;
+		}
+		drvdata->sysclk = clk_get_rate(drvdata->mclk);
+	} else if (drvdata->mclk) {
+		unsigned int requestd_rate = drvdata->sysclk;
+		clk_set_rate(drvdata->mclk, drvdata->sysclk);
+		drvdata->sysclk = clk_get_rate(drvdata->mclk);
+		if (drvdata->sysclk != requestd_rate)
+			dev_warn(&pdev->dev,
+				 "Could not get requested rate %u using %u.\n",
+				 requestd_rate, drvdata->sysclk);
+	}
 
 	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
@@ -387,6 +437,12 @@ static int davinci_evm_probe(struct platform_device *pdev)
 static int davinci_evm_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		(struct snd_soc_card_drvdata_davinci *)
+		snd_soc_card_get_drvdata(card);
+
+	if (drvdata->mclk)
+		clk_put(drvdata->mclk);
 
 	snd_soc_unregister_card(card);
 
-- 
1.7.9.5

