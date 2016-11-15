From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 1/2] ASoC: omap-twl4030: rework probing for
	device tree only
Date: Tue, 15 Nov 2016 10:01:19 +0200
Message-ID: <1479196880-20344-2-git-send-email-Nicolae_Rosia@mentor.com>
References: <1479196880-20344-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1479196880-20344-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

This code is no longer used since all users are
using device tree

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 include/linux/platform_data/omap-twl4030.h |  58 -------------
 sound/soc/omap/omap-twl4030.c              | 133 ++++++++++-------------------
 2 files changed, 46 insertions(+), 145 deletions(-)
 delete mode 100644 include/linux/platform_data/omap-twl4030.h

diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
deleted file mode 100644
index ee60ef7..0000000
--- a/include/linux/platform_data/omap-twl4030.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/**
- * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl4030
- *		    codec, header.
- *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
- * All rights reserved.
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- */
-
-#ifndef _OMAP_TWL4030_H_
-#define _OMAP_TWL4030_H_
-
-/* To select if only one channel is connected in a stereo port */
-#define OMAP_TWL4030_LEFT	(1 << 0)
-#define OMAP_TWL4030_RIGHT	(1 << 1)
-
-struct omap_tw4030_pdata {
-	const char *card_name;
-	/* Voice port is connected to McBSP3 */
-	bool voice_connected;
-
-	/* The driver will parse the connection flags if this flag is set */
-	bool	custom_routing;
-	/* Flags to indicate connected audio ports. */
-	u8	has_hs;
-	u8	has_hf;
-	u8	has_predriv;
-	u8	has_carkit;
-	bool	has_ear;
-
-	bool	has_mainmic;
-	bool	has_submic;
-	bool	has_hsmic;
-	bool	has_carkitmic;
-	bool	has_digimic0;
-	bool	has_digimic1;
-	u8	has_linein;
-
-	/* Jack detect GPIO or  <= 0 if it is not implemented */
-	int jack_detect;
-};
-
-#endif /* _OMAP_TWL4030_H_ */
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 7431314..3988744 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -31,7 +31,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/platform_data/omap-twl4030.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/gpio.h>
@@ -160,10 +159,8 @@ static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *dapm,
 static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dapm_context *dapm = &card->dapm;
-	struct omap_tw4030_pdata *pdata = dev_get_platdata(card->dev);
 	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
-	int ret = 0;
+	int ret;
 
 	/* Headset jack detection only if it is supported */
 	if (priv->jack_detect > 0) {
@@ -183,29 +180,7 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 	}
 
-	/*
-	 * NULL pdata means we booted with DT. In this case the routing is
-	 * provided and the card is fully routed, no need to mark pins.
-	 */
-	if (!pdata || !pdata->custom_routing)
-		return ret;
-
-	/* Disable not connected paths if not used */
-	twl4030_disconnect_pin(dapm, pdata->has_ear, "Earpiece Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_hf, "Handsfree Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
-	twl4030_disconnect_pin(dapm, pdata->has_predriv, "Ext Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_carkit, "Carkit Spk");
-
-	twl4030_disconnect_pin(dapm, pdata->has_mainmic, "Main Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_submic, "Sub Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_carkitmic, "Carkit Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_digimic0, "Digital0 Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_digimic1, "Digital1 Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_linein, "Line In");
-
-	return ret;
+	return 0;
 }
 
 static int omap_twl4030_card_remove(struct snd_soc_card *card)
@@ -259,11 +234,12 @@ static struct snd_soc_card omap_twl4030_card = {
 
 static int omap_twl4030_probe(struct platform_device *pdev)
 {
-	struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_twl4030_card;
 	struct omap_twl4030 *priv;
-	int ret = 0;
+	struct device_node *dai_node;
+	struct property *prop;
+	int ret;
 
 	card->dev = &pdev->dev;
 
@@ -271,67 +247,50 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	if (priv == NULL)
 		return -ENOMEM;
 
-	if (node) {
-		struct device_node *dai_node;
-		struct property *prop;
-
-		if (snd_soc_of_parse_card_name(card, "ti,model")) {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
-
-		dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
-		if (!dai_node) {
-			dev_err(&pdev->dev, "McBSP node is not provided\n");
-			return -EINVAL;
-		}
-		omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
-		omap_twl4030_dai_links[0].cpu_of_node = dai_node;
-
-		omap_twl4030_dai_links[0].platform_name  = NULL;
-		omap_twl4030_dai_links[0].platform_of_node = dai_node;
-
-		dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
-		if (!dai_node) {
-			card->num_links = 1;
-		} else {
-			omap_twl4030_dai_links[1].cpu_dai_name  = NULL;
-			omap_twl4030_dai_links[1].cpu_of_node = dai_node;
-
-			omap_twl4030_dai_links[1].platform_name  = NULL;
-			omap_twl4030_dai_links[1].platform_of_node = dai_node;
-		}
-
-		priv->jack_detect = of_get_named_gpio(node,
-						      "ti,jack-det-gpio", 0);
-
-		/* Optional: audio routing can be provided */
-		prop = of_find_property(node, "ti,audio-routing", NULL);
-		if (prop) {
-			ret = snd_soc_of_parse_audio_routing(card,
-							    "ti,audio-routing");
-			if (ret)
-				return ret;
-
-			card->fully_routed = 1;
-		}
-	} else if (pdata) {
-		if (pdata->card_name) {
-			card->name = pdata->card_name;
-		} else {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
-
-		if (!pdata->voice_connected)
-			card->num_links = 1;
-
-		priv->jack_detect = pdata->jack_detect;
-	} else {
-		dev_err(&pdev->dev, "Missing pdata\n");
+	if (!node) {
+		dev_err(&pdev->dev, "no DT info\n");
+		return -EINVAL;
+	}
+
+	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
 	}
 
+	dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
+	if (!dai_node) {
+		dev_err(&pdev->dev, "McBSP node is not provided\n");
+		return -EINVAL;
+	}
+	omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
+	omap_twl4030_dai_links[0].cpu_of_node = dai_node;
+
+	omap_twl4030_dai_links[0].platform_name  = NULL;
+	omap_twl4030_dai_links[0].platform_of_node = dai_node;
+
+	dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
+	if (!dai_node) {
+		card->num_links = 1;
+	} else {
+		omap_twl4030_dai_links[1].cpu_dai_name  = NULL;
+		omap_twl4030_dai_links[1].cpu_of_node = dai_node;
+
+		omap_twl4030_dai_links[1].platform_name  = NULL;
+		omap_twl4030_dai_links[1].platform_of_node = dai_node;
+	}
+
+	priv->jack_detect = of_get_named_gpio(node, "ti,jack-det-gpio", 0);
+
+	/* Optional: audio routing can be provided */
+	prop = of_find_property(node, "ti,audio-routing", NULL);
+	if (prop) {
+		ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
+		if (ret)
+			return ret;
+
+		card->fully_routed = 1;
+	}
+
 	snd_soc_card_set_drvdata(card, priv);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-- 
2.7.4
