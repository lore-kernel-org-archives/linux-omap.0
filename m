From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 1/3] ASoC: simple-card: Make u32 DT parameter handling 64-bit proof
Date: Fri, 13 Jun 2014 13:04:36 +0300
Message-ID: <ff985604371ff8afa35352db9d460b08760003e2.1402653217.git.jsarha@ti.com>
References: <cover.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53484 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbaFMKEt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 06:04:49 -0400
In-Reply-To: <cover.1402653217.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Passing unsigned int pointers as u32 ponters may be dangerous on 64-bit
system.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/generic/simple-card.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03a7fdc..159e517f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -116,6 +116,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 {
 	struct device_node *node;
 	struct clk *clk;
+	u32 val;
 	int ret;
 
 	/*
@@ -151,10 +152,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		}
 
 		dai->sysclk = clk_get_rate(clk);
-	} else if (of_property_read_bool(np, "system-clock-frequency")) {
-		of_property_read_u32(np,
-				     "system-clock-frequency",
-				     &dai->sysclk);
+	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
+		dai->sysclk = val;
 	} else {
 		clk = of_clk_get(node, 0);
 		if (!IS_ERR(clk))
@@ -303,6 +302,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 {
 	struct snd_soc_dai_link *dai_link = priv->snd_card.dai_link;
 	struct simple_dai_props *dai_props = priv->dai_props;
+	u32 val;
 	int ret;
 
 	/* parsing the card name from DT */
@@ -325,8 +325,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	}
 
 	/* Factor to mclk, used in hw_params() */
-	of_property_read_u32(node, "simple-audio-card,mclk-fs",
-			     &priv->mclk_fs);
+	ret = of_property_read_u32(node, "simple-audio-card,mclk-fs", &val);
+	if (ret == 0)
+		priv->mclk_fs = val;
 
 	dev_dbg(dev, "New simple-card: %s\n", priv->snd_card.name ?
 		priv->snd_card.name : "");
-- 
1.7.9.5

