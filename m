From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 1/2] ASoC: core: Add is_cpu_dai_node-parameter to snd_soc_of_parse_daifmt()
Date: Mon, 10 Mar 2014 13:41:15 +0200
Message-ID: <2fdbb57b2598e014a443bbe882af75072bddac6f.1394451329.git.jsarha@ti.com>
References: <cover.1394451329.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44337 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbaCJLl0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 07:41:26 -0400
In-Reply-To: <cover.1394451329.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The sematics of bitclock-master and frame-master DT parameters
should be inversed when parsing a cpu-dai node.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/soc.h  |    3 ++-
 sound/soc/soc-core.c |    8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c0b6656..ecd0745 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1231,7 +1231,8 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
-				     const char *prefix);
+				     const char *prefix,
+				     bool is_cpu_dai_node);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8ddb15c..dfff75f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4613,7 +4613,8 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
 
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
-				     const char *prefix)
+				     const char *prefix,
+				     bool is_cpu_dai_node)
 {
 	int ret, i;
 	char prop[128];
@@ -4700,6 +4701,11 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
 	frame = !!of_get_property(np, prop, NULL);
 
+	if (is_cpu_dai_node) {
+		bit = !bit;
+		frame = !frame;
+	}
+
 	switch ((bit << 4) + frame) {
 	case 0x11:
 		format |= SND_SOC_DAIFMT_CBM_CFM;
-- 
1.7.9.5

