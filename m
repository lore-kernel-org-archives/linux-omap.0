From: Mark Brown <broonie@kernel.org>
Subject: Applied "device property: Fix usecount for of_graph_get_port_parent()" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:23 +0100
Message-ID: <E1dcXyB-0008Jq-SC@debutante>
References: <20170728082315.GL10026@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728082315.GL10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   device property: Fix usecount for of_graph_get_port_parent()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c0a480d1acf7dc184f9f3e7cf724483b0d28dc2e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 28 Jul 2017 01:23:15 -0700
Subject: [PATCH] device property: Fix usecount for of_graph_get_port_parent()

Fix inconsistent use of of_graph_get_port_parent() where
asoc_simple_card_parse_graph_dai() does of_node_get() before
calling it while other callers do not. We can fix this by
not trashing the node passed to of_graph_get_port_parent().

Let's also make sure the callers have correct refcounts and remove
related incorrect of_node_put() calls for of_for_each_phandle
as that's done by of_phandle_iterator_next() except when
we break out of the loop early.

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Antonio Borneo <borneo.antonio@gmail.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/of/property.c                    | 17 +++++++++++++++--
 sound/soc/generic/audio-graph-card.c     | 10 +++++-----
 sound/soc/generic/audio-graph-scu-card.c | 15 +++++++++------
 sound/soc/generic/simple-card-utils.c    |  8 +++-----
 sound/soc/soc-core.c                     |  2 ++
 5 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index eda50b4be934..067f9fab7b77 100644
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
@@ -728,12 +737,16 @@ EXPORT_SYMBOL(of_graph_get_port_parent);
 struct device_node *of_graph_get_remote_port_parent(
 			       const struct device_node *node)
 {
-	struct device_node *np;
+	struct device_node *np, *pp;
 
 	/* Get remote endpoint node. */
 	np = of_graph_get_remote_endpoint(node);
 
-	return of_graph_get_port_parent(np);
+	pp = of_graph_get_port_parent(np);
+
+	of_node_put(np);
+
+	return pp;
 }
 EXPORT_SYMBOL(of_graph_get_remote_port_parent);
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 105ec3a6e30d..de2550c7a96b 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -224,9 +224,11 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
-		of_node_put(it.node);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(it.node);
+
 			return ret;
+		}
 	}
 
 	return asoc_simple_card_parse_card_name(card, NULL);
@@ -239,10 +241,8 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
 		count++;
-		of_node_put(it.node);
-	}
 
 	return count;
 }
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index dcd2df37bc3b..758ac06f3a99 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -215,7 +215,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 		codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 		rcpu_ep  = of_graph_get_remote_endpoint(codec_ep);
 
-		of_node_put(cpu_port);
 		of_node_put(cpu_ep);
 		of_node_put(codec_ep);
 		of_node_put(rcpu_ep);
@@ -232,8 +231,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 		ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 							    NULL, &daifmt);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(cpu_port);
 			goto parse_of_err;
+		}
 	}
 
 	dai_idx = 0;
@@ -250,7 +251,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 			codec_port = of_graph_get_port_parent(codec_ep);
 
-			of_node_put(cpu_port);
 			of_node_put(cpu_ep);
 			of_node_put(codec_ep);
 			of_node_put(codec_port);
@@ -266,13 +266,17 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 				/* Back-End (= Codec) */
 				ret = asoc_graph_card_dai_link_of(codec_ep, priv, daifmt, dai_idx++, 0);
-				if (ret < 0)
+				if (ret < 0) {
+					of_node_put(cpu_port);
 					goto parse_of_err;
+				}
 			} else {
 				/* Front-End (= CPU) */
 				ret = asoc_graph_card_dai_link_of(cpu_ep, priv, daifmt, dai_idx++, 1);
-				if (ret < 0)
+				if (ret < 0) {
+					of_node_put(cpu_port);
 					goto parse_of_err;
+				}
 			}
 		}
 	}
@@ -306,7 +310,6 @@ static int asoc_graph_get_dais_count(struct device *dev)
 		codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 		codec_port = of_graph_get_port_parent(codec_ep);
 
-		of_node_put(cpu_port);
 		of_node_put(cpu_ep);
 		of_node_put(codec_ep);
 		of_node_put(codec_port);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 26d64fa40c9c..7d7ab4aee42e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -263,6 +263,9 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 			id = i;
 		i++;
 	}
+
+	of_node_put(node);
+
 	if (id < 0)
 		return -ENODEV;
 
@@ -282,11 +285,6 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 	if (!dai_name)
 		return 0;
 
-	/*
-	 * of_graph_get_port_parent() will call
-	 * of_node_put(). So, call of_node_get() here
-	 */
-	of_node_get(ep);
 	node = of_graph_get_port_parent(ep);
 
 	/* Get dai->name */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a01944..0cf8498fa36c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4113,6 +4113,8 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	}
 	mutex_unlock(&client_mutex);
 
+	of_node_put(node);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_dai_id);
-- 
2.13.2
