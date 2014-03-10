From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 1/2] ASoC: core: Add is_cpu_dai_node-parameter to snd_soc_of_parse_daifmt()
Date: Mon, 10 Mar 2014 13:28:37 +0200
Message-ID: <8e870602aecf36e8217bb9d0b37c50b060dc1a5b.1394450178.git.jsarha@ti.com>
References: <cover.1394450178.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38112 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbaCJL2w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 07:28:52 -0400
In-Reply-To: <cover.1394450178.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The schematics of bitclock-master and frame-master DT parameters
should be inversed when parsing a cpu-dai node.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/soc-core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

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

