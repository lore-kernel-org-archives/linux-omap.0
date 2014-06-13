From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 2/3] ASoC: simple-card: Add system-clock-direction DT parameter to dai nodes
Date: Fri, 13 Jun 2014 13:04:37 +0300
Message-ID: <0f714f64a67f9d52aaef8fdaeb279b9e499cf82a.1402653217.git.jsarha@ti.com>
References: <cover.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38038 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbaFMKEu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 06:04:50 -0400
In-Reply-To: <cover.1402653217.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Select dir parameters for set_sysclk calls in the card init phase.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/sound/simple-card.txt      |    1 +
 include/sound/simple_card.h                        |    1 +
 sound/soc/generic/simple-card.c                    |   14 +++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c2e9841..8460744 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -71,6 +71,7 @@ Optional CPU/CODEC subnodes properties:
 					  it can be specified via "clocks" if system has
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
+- system-clock-direction		: "in" or "out", default "in"
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 9b0ac77..6d74fef 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -18,6 +18,7 @@ struct asoc_simple_dai {
 	const char *name;
 	unsigned int fmt;
 	unsigned int sysclk;
+	int sysclk_dir;
 	int slots;
 	int slot_width;
 };
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 159e517f..8dd7957 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -64,7 +64,8 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	}
 
 	if (set->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
+		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk,
+					     set->sysclk_dir);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
 			goto err;
@@ -116,6 +117,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 {
 	struct device_node *node;
 	struct clk *clk;
+	const char *str;
 	u32 val;
 	int ret;
 
@@ -138,6 +140,16 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	if (ret)
 		return ret;
 
+	ret = of_property_read_string(np, "system-clock-direction", &str);
+	if (ret == 0) {
+		if (!strcmp(str, "out"))
+			dai->sysclk_dir = SND_SOC_CLOCK_OUT;
+		else if (!strcmp(str, "in"))
+			dai->sysclk_dir = SND_SOC_CLOCK_IN;
+		else
+			return -EINVAL;
+	}
+
 	/*
 	 * dai->sysclk come from
 	 *  "clocks = <&xxx>" (if system has common clock)
-- 
1.7.9.5

