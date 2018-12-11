From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ASoC: simple-card-utils: revert port changes to follow graph binding
Date: Mon, 10 Dec 2018 18:05:56 -0800
Message-ID: <20181211020557.61783-2-tony@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-omap@vger.kernel.org

Commit b6f3fc005a2c ("ASoC: simple-card-utils: fixup
asoc_simple_card_get_dai_id() counting") changed endpoint parsing for
asoc_simple_card_get_dai_id(), but it seems the old code is correct.

This code should follow the generic binding documentation for
Documentation/devicetree/bindings/graph.txt that allows multiple
endpoints for each port.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/generic/simple-card-utils.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -269,19 +269,35 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
 static int asoc_simple_card_get_dai_id(struct device_node *ep)
 {
-	struct of_endpoint info;
+	struct device_node *node;
+	struct device_node *endpoint;
+	int i, id;
 	int ret;
 
 	ret = snd_soc_get_dai_id(ep);
 	if (ret != -ENOTSUPP)
 		return ret;
 
+	node = of_graph_get_port_parent(ep);
+
 	/*
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	of_graph_parse_endpoint(ep, &info);
-	return info.port;
+	i = 0;
+	id = -1;
+	for_each_endpoint_of_node(node, endpoint) {
+		if (endpoint == ep)
+			id = i;
+		i++;
+	}
+
+	of_node_put(node);
+
+	if (id < 0)
+		return -ENODEV;
+
+	return id;
 }
 
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-- 
2.19.2
