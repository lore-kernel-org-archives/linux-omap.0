From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ASoC: audio-graph-card: Fix parsing of multiple endpoints
Date: Mon, 10 Dec 2018 18:05:57 -0800
Message-ID: <20181211020557.61783-3-tony@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-omap@vger.kernel.org

We currently use only the first endpoint even if multiple endpoints
are configured for a port.

We should follow what's specified in the device graph binding
document Documentation/devicetree/bindings/graph.txt in paragraph
"Organisation of ports and endpoints":

"If a single port is connected to more than one remote device, an
 'endpoint' child node must be provided for each link."

This is the case for example for I2S where multiple devices can be
connected to a single I2S port sharing it using TDM (Time-Division
Multiplexing).

To fix this, we need to iterate over each endpoint for a port.

Note that the dts "dais" property should still contain a single
property for each port, and not for each endpoint.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/generic/audio-graph-card.c | 41 ++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -156,17 +156,17 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
+static int asoc_graph_card_ep_of(struct device_node *cpu_port,
+					struct device_node *cpu_ep,
 					struct graph_card_data *priv,
 					int *dai_idx, int link_idx)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, link_idx);
+	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
-	struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
-	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	int ret;
 
 	cpu_dai			=
@@ -230,6 +230,31 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	return ret;
 }
 
+static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
+					struct graph_card_data *priv,
+					int *dai_idx, int link_idx)
+{
+	struct device *dev = graph_priv_to_dev(priv);
+	struct device_node *ep = NULL;
+	int num_ep, ep_idx, ret;
+
+	num_ep = of_get_child_count(cpu_port);
+	if (!num_ep) {
+		dev_err(dev, "no cpu endpoints found for %pOf\n", cpu_port);
+		return -ENODEV;
+	}
+
+	for (ep_idx = 0; ep_idx < num_ep; ep_idx++) {
+		ep = of_get_next_child(cpu_port, ep);
+		ret = asoc_graph_card_ep_of(cpu_port, ep, priv,
+					    dai_idx, link_idx + ep_idx);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 {
 	struct of_phandle_iterator it;
@@ -272,8 +297,14 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
-		count++;
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+		int ep_count = of_get_child_count(it.node);
+
+		if (ep_count)
+			count += ep_count;
+		else
+			count++;
+	}
 
 	return count;
 }
-- 
2.19.2
