From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 1/7] ASoC: core: If component doesn't have of_node use parent's node instead
Date: Tue, 26 May 2015 21:59:05 +0300
Message-ID: <1432666751-24794-2-git-send-email-jsarha@ti.com>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37435 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbEZS7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2015 14:59:54 -0400
In-Reply-To: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, moinejf@free.fr, rmk+kernel@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

If an ASoC component device does not have a device tree node, use its
parent's node instead, when looking for a matching DAI based on a
device tree reference.

This allows video device drivers to register a separate child device
for their ASoC side audio functionality.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/soc-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2373252..b1bcff2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -904,12 +904,17 @@ static struct snd_soc_dai *snd_soc_find_dai(
 {
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
+	struct device_node *component_of_node;
 
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
 	list_for_each_entry(component, &component_list, list) {
-		if (dlc->of_node && component->dev->of_node != dlc->of_node)
+		component_of_node = component->dev->of_node;
+		if (!component_of_node && component->dev->parent)
+			component_of_node = component->dev->parent->of_node;
+
+		if (dlc->of_node && component_of_node != dlc->of_node)
 			continue;
 		if (dlc->name && strcmp(component->name, dlc->name))
 			continue;
@@ -3488,11 +3493,16 @@ static int snd_soc_get_dai_name(struct of_phandle_args *args,
 				const char **dai_name)
 {
 	struct snd_soc_component *pos;
+	struct device_node *component_of_node;
 	int ret = -EPROBE_DEFER;
 
 	mutex_lock(&client_mutex);
 	list_for_each_entry(pos, &component_list, list) {
-		if (pos->dev->of_node != args->np)
+		component_of_node = pos->dev->of_node;
+		if (!component_of_node && pos->dev->parent)
+			component_of_node = pos->dev->parent->of_node;
+
+		if (component_of_node != args->np)
 			continue;
 
 		if (pos->driver->of_xlate_dai_name) {
-- 
1.9.1

