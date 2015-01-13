From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC] ASoC: simple-card: Enable and disable DAI clocks as needed
Date: Tue, 13 Jan 2015 21:16:34 +0200
Message-ID: <1421176594-2117-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41580 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbbAMTQx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 14:16:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, broonie@kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, Jyri Sarha <jsarha@ti.com>

Call clk_prepare_enable() and clk_disable_unprepare() for cpu dai
clock and codec dai clock in dai statup and shutdown callbacks. This
to make sure the related clock are enabled when the audio device is
used.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
This patch is needed for Beaglebone-back HDMI audio. There is no
direct dependency between this patch and the other (dts and DRM)
changes needed for the HDMI audio so these changes can be merged
independently. There are also some other TI EVMs that require this
functionality if they are to be used with simple-card.

 .../devicetree/bindings/sound/simple-card.txt      |    5 +++
 include/sound/simple_card.h                        |    1 +
 sound/soc/generic/simple-card.c                    |   34 ++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c3cba60..73bf314 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -75,6 +75,11 @@ Optional CPU/CODEC subnodes properties:
 					  it can be specified via "clocks" if system has
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
+					  If a clock is specified, it is
+					  enabled with clk_prepare_enable()
+					  in dai startup() and disabled with
+					  clk_disable_unprepare() in dai
+					  shutdown().
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 9b0ac77..1255ddb 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -20,6 +20,7 @@ struct asoc_simple_dai {
 	unsigned int sysclk;
 	int slots;
 	int slot_width;
+	struct clk *clk;
 };
 
 struct asoc_simple_card_info {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fb9240f..cb3998d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -39,6 +39,37 @@ struct simple_card_data {
 #define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + i)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + i)
 
+static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props =
+		&priv->dai_props[rtd - rtd->card->rtd];
+	int ret;
+
+	ret = clk_prepare_enable(dai_props->cpu_dai.clk);
+	if (ret)
+		return ret;
+	
+	ret = clk_prepare_enable(dai_props->codec_dai.clk);
+	if (ret)
+		clk_disable_unprepare(dai_props->cpu_dai.clk);
+
+	return ret;
+}
+
+static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props =
+		&priv->dai_props[rtd - rtd->card->rtd];
+
+	clk_disable_unprepare(dai_props->cpu_dai.clk);
+
+	clk_disable_unprepare(dai_props->codec_dai.clk);
+}
+
 static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
@@ -58,6 +89,8 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_ops asoc_simple_card_ops = {
+	.startup = asoc_simple_card_startup,
+	.shutdown = asoc_simple_card_shutdown,
 	.hw_params = asoc_simple_card_hw_params,
 };
 
@@ -219,6 +252,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		}
 
 		dai->sysclk = clk_get_rate(clk);
+		dai->clk = clk;
 	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
 		dai->sysclk = val;
 	} else {
-- 
1.7.9.5

