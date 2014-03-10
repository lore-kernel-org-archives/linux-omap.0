From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 2/2] ASoC: simple-card: Take snd_soc_of_parse_daifmt() change in to account
Date: Mon, 10 Mar 2014 13:41:16 +0200
Message-ID: <0929a0018fa3e909cb0894c5b01873b5eae0f6eb.1394451329.git.jsarha@ti.com>
References: <cover.1394451329.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47216 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbaCJLl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 07:41:27 -0400
In-Reply-To: <cover.1394451329.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

snd_soc_of_parse_daifmt() needs to know if it is parsing a cpu-dai node.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/generic/simple-card.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7cabcc5..7cbbf44 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -87,7 +87,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      unsigned int daifmt,
 			      struct asoc_simple_dai *dai,
 			      const struct device_node **p_node,
-			      const char **name)
+			      const char **name,
+			      bool is_cpu_dai_node)
 {
 	struct device_node *node;
 	struct clk *clk;
@@ -117,7 +118,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * bitclock-master,    frame-master
 	 * and specific "format" if it has
 	 */
-	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
+	dai->fmt = snd_soc_of_parse_daifmt(np, NULL, is_cpu_dai_node);
 	dai->fmt |= daifmt;
 
 	/*
@@ -165,7 +166,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
-	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
+	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,", 0) &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* off-codec widgets */
@@ -191,7 +192,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
-						  &dai_link->cpu_dai_name);
+						  &dai_link->cpu_dai_name,
+						  true);
 	if (ret < 0)
 		return ret;
 
@@ -202,7 +204,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->codec_dai,
 						  &dai_link->codec_of_node,
-						  &dai_link->codec_dai_name);
+						  &dai_link->codec_dai_name,
+						  false);
 	if (ret < 0)
 		return ret;
 
-- 
1.7.9.5

