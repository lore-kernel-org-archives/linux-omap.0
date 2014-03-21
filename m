From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 1/2] ASoC: core: Update snd_soc_of_parse_daifmt() interface
Date: Fri, 21 Mar 2014 18:47:22 +0200
Message-ID: <9e6ff715a2852851bed5d92035409114fd15f997.1395419906.git.jsarha@ti.com>
References: <cover.1395419906.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbaCUQrj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Mar 2014 12:47:39 -0400
In-Reply-To: <cover.1395419906.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, moinejf@free.fr, Li.Xiubo@freescale.com, kuninori.morimoto.gx@renesas.com, Jyri Sarha <jsarha@ti.com>

Adds struct device_node **bitclkmaster and struct device_node **framemaster
function parameters. With the new syntax bitclock-master and frame-master
properties can explicitly indicate the dai-link bit-clock and frame masters
with a phandle.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/soc.h  |    4 +++-
 sound/soc/soc-core.c |    8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

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

