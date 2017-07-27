From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] device property: Fix usecount for of_graph_get_port_parent()
Date: Thu, 27 Jul 2017 02:44:05 -0700
Message-ID: <20170727094405.19778-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Fix inconsistent use of of_graph_get_port_parent() where
asoc_simple_card_parse_graph_dai() does of_node_get() before
calling it while other callers do not. We can fix this by
not trashing the node passed to of_graph_get_port_parent().

Let's make sure the users have correct refcounts and remove
related incorrect of_node_put() calls for of_for_each_phandle
as that's done by of_phandle_iterator_next().

Let's fix both issues with a single patch to avoid kobject
refcounts getting messed up more if two patches are merged
separately.

Otherwise strange issues can happen caused by memory corruption
caused by too many kobject_del() calls such as:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:747
...
(___might_sleep)
(__mutex_lock)
(mutex_lock_nested)
(kernfs_remove)
(kobject_del)
(kobject_put)
(of_get_next_parent)
(of_graph_get_port_parent)
(asoc_simple_card_parse_graph_dai [snd_soc_simple_card_utils])
(asoc_graph_card_probe [snd_soc_audio_graph_card])

Fixes: 0ef472a973eb ("of_graph: add of_graph_get_port_parent()")
Fixes: 2692c1c63c29 ("ASoC: add audio-graph-card support")
Fixes: 1689333f8311 ("ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()")
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/of/property.c                 | 9 +++++++++
 sound/soc/generic/audio-graph-card.c  | 5 +----
 sound/soc/generic/simple-card-utils.c | 5 -----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -708,6 +708,15 @@ struct device_node *of_graph_get_port_parent(struct device_node *node)
 {
 	unsigned int depth;
 
+	if (!node)
+		return NULL;
+
+	/*
+	 * Preserve usecount for passed in node as of_get_next_parent()
+	 * will do of_node_put() on it.
+	 */
+	of_node_get(node);
+
 	/* Walk 3 levels up only if there is 'ports' node. */
 	for (depth = 3; depth && node; depth--) {
 		node = of_get_next_parent(node);
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -224,7 +224,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
-		of_node_put(it.node);
 		if (ret < 0)
 			return ret;
 	}
@@ -239,10 +238,8 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
 		count++;
-		of_node_put(it.node);
-	}
 
 	return count;
 }
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -282,11 +282,6 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 	if (!dai_name)
 		return 0;
 
-	/*
-	 * of_graph_get_port_parent() will call
-	 * of_node_put(). So, call of_node_get() here
-	 */
-	of_node_get(ep);
 	node = of_graph_get_port_parent(ep);
 
 	/* Get dai->name */
-- 
2.13.2
