From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 3/3] ASoC: simple-card: Add system-clock-id DT parameter to dai nodes
Date: Fri, 13 Jun 2014 13:04:38 +0300
Message-ID: <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
References: <cover.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbaFMKEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 06:04:50 -0400
In-Reply-To: <cover.1402653217.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Select clk_id parameters for set_sysclk calls in the card init phase.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/sound/simple-card.txt      |    2 ++
 include/sound/simple_card.h                        |    1 +
 sound/soc/generic/simple-card.c                    |    6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 8460744..8877130 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -72,6 +72,8 @@ Optional CPU/CODEC subnodes properties:
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
 - system-clock-direction		: "in" or "out", default "in"
+- system-clock-id			: u32, clk_id parameter for set_sysclk,
+					  default 0
 
 Example 1 - single DAI link:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 6d74fef..f3c7a30 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -19,6 +19,7 @@ struct asoc_simple_dai {
 	unsigned int fmt;
 	unsigned int sysclk;
 	int sysclk_dir;
+	int sysclk_id;
 	int slots;
 	int slot_width;
 };
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 8dd7957..f840d9c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -64,7 +64,7 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 	}
 
 	if (set->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk,
+		ret = snd_soc_dai_set_sysclk(dai, set->sysclk_id, set->sysclk,
 					     set->sysclk_dir);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
@@ -150,6 +150,10 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			return -EINVAL;
 	}
 
+	ret = of_property_read_u32(np, "system-clock-id", &val);
+	if (ret == 0)
+		dai->sysclk_id = val;
+
 	/*
 	 * dai->sysclk come from
 	 *  "clocks = <&xxx>" (if system has common clock)
-- 
1.7.9.5

