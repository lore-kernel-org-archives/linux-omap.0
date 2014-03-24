From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 1/2] ASoC: core: Update snd_soc_of_parse_daifmt() interface
Date: Mon, 24 Mar 2014 12:15:24 +0200
Message-ID: <ea6e68518bd5f9df07dbd146f41cb02a8f290bc5.1395655868.git.jsarha@ti.com>
References: <cover.1395655868.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57783 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaCXKPk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 06:15:40 -0400
In-Reply-To: <cover.1395655868.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, moinejf@free.fr, Li.Xiubo@freescale.com, kuninori.morimoto.gx@renesas.com, Jyri Sarha <jsarha@ti.com>

Adds struct device_node **bitclkmaster and struct device_node **framemaster
function parameters. With the new syntax bitclock-master and frame-master
properties can explicitly indicate the dai-link bit-clock and frame masters
with a phandle. This patch also makes the minimal changes to simple-card
for it to work with the updated snd_soc_of_parse_daifmt(). Simple-card appears
to be the only user of snd_soc_of_parse_daifmt() for now.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/soc.h             |    4 +++-
 sound/soc/generic/simple-card.c |    5 +++--
 sound/soc/soc-core.c            |    8 +++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f7de629..e40713a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1228,7 +1228,9 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
-				     const char *prefix);
+				     const char *prefix,
+				     struct device_node **bitclkmaster,
+				     struct device_node **framemaster);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 21f1ccb..835fd02 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -121,7 +121,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * bitclock-master,    frame-master
 	 * and specific "format" if it has
 	 */
-	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
+	dai->fmt = snd_soc_of_parse_daifmt(np, NULL, NULL, NULL);
 	dai->fmt |= daifmt;
 
 	/*
@@ -201,7 +201,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
-	daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
+	daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,", NULL,
+					 NULL) &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* off-codec widgets */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf2..7979dcc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4560,7 +4560,9 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_routing);
 
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
-				     const char *prefix)
+				     const char *prefix,
+				     struct device_node **bitclkmaster,
+				     struct device_node **framemaster)
 {
 	int ret, i;
 	char prop[128];
@@ -4643,9 +4645,13 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
 	bit = !!of_get_property(np, prop, NULL);
+	if (bit && bitclkmaster)
+		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
 	frame = !!of_get_property(np, prop, NULL);
+	if (frame && framemaster)
+		*framemaster = of_parse_phandle(np, prop, 0);
 
 	switch ((bit << 4) + frame) {
 	case 0x11:
-- 
1.7.9.5

