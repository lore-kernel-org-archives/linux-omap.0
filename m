From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH 1/4] ASoC: tpa6130a2: Register component
Date: Sat, 18 Jun 2016 00:26:28 -0300
Message-ID: <ab4a503a44da58b65c3d56bf86e8e2949a4d3cab.1466218805.git.helen.koike@collabora.co.uk>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466218805.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1466218805.git.helen.koike@collabora.co.uk>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Helen Koike <helen.koike@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add tpa6130a2 controls by the component API and update rx51 accordingly

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
---
 sound/soc/codecs/tpa6130a2.c | 26 +++++++++++++-------------
 sound/soc/codecs/tpa6130a2.h |  1 -
 sound/soc/omap/rx51.c        | 23 ++++++++++++-----------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 11d85c5..f700d92 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -348,23 +348,22 @@ int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable)
 }
 EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
 
-int tpa6130a2_add_controls(struct snd_soc_codec *codec)
+static int tpa6130a2_component_probe(struct snd_soc_component *component)
 {
-	struct	tpa6130a2_data *data;
-
-	if (tpa6130a2_client == NULL)
-		return -ENODEV;
-
-	data = i2c_get_clientdata(tpa6130a2_client);
+	struct tpa6130a2_data *data = snd_soc_component_get_drvdata(component);
 
 	if (data->id == TPA6140A2)
-		return snd_soc_add_codec_controls(codec, tpa6140a2_controls,
-						ARRAY_SIZE(tpa6140a2_controls));
+		return snd_soc_add_component_controls(component,
+			tpa6140a2_controls, ARRAY_SIZE(tpa6140a2_controls));
 	else
-		return snd_soc_add_codec_controls(codec, tpa6130a2_controls,
-						ARRAY_SIZE(tpa6130a2_controls));
+		return snd_soc_add_component_controls(component,
+			tpa6130a2_controls, ARRAY_SIZE(tpa6130a2_controls));
 }
-EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
+
+struct snd_soc_component_driver tpa6130a2_component_driver = {
+	.name = "tpa6130a2",
+	.probe = tpa6130a2_component_probe,
+};
 
 static int tpa6130a2_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
@@ -451,7 +450,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	if (ret != 0)
 		goto err_gpio;
 
-	return 0;
+	return devm_snd_soc_register_component(&client->dev,
+			&tpa6130a2_component_driver, NULL, 0);
 
 err_gpio:
 	tpa6130a2_client = NULL;
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 4174440..78ee723 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -56,7 +56,6 @@
 /* TPA6130A2_REG_VERSION (0x04) */
 #define TPA6130A2_VERSION_MASK		(0x0f)
 
-extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
 extern int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable);
 
 #endif /* __TPA6130A2_H__ */
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 5494924..b59cf89 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -286,16 +286,10 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 
 static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = rtd->card;
 	struct rx51_audio_pdata *pdata = snd_soc_card_get_drvdata(card);
 	int err;
 
-	err = tpa6130a2_add_controls(codec);
-	if (err < 0) {
-		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
-		return err;
-	}
 	snd_soc_limit_volume(card, "TPA6130A2 Headphone Playback Volume", 42);
 
 	err = omap_mcbsp_st_add_controls(rtd, 2);
@@ -357,6 +351,10 @@ static struct snd_soc_aux_dev rx51_aux_dev[] = {
 		.name = "TLV320AIC34b",
 		.codec_name = "tlv320aic3x-codec.2-0019",
 	},
+	{
+		.name = "TPA61320A2",
+		.codec_name = "tpa6130a2.2-0060",
+	},
 };
 
 static struct snd_soc_codec_conf rx51_codec_conf[] = {
@@ -364,6 +362,10 @@ static struct snd_soc_codec_conf rx51_codec_conf[] = {
 		.dev_name = "tlv320aic3x-codec.2-0019",
 		.name_prefix = "b",
 	},
+	{
+		.dev_name = "tpa6130a2.2-0060",
+		.name_prefix = "TPA6130A2",
+	},
 };
 
 /* Audio card */
@@ -435,11 +437,10 @@ static int rx51_soc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Headphone amplifier node is not provided\n");
 			return -EINVAL;
 		}
-
-		/* TODO: tpa6130a2a driver supports only a single instance, so
-		 * this driver ignores the headphone-amplifier node for now.
-		 * It's already mandatory in the DT binding to be future proof.
-		 */
+		rx51_aux_dev[1].codec_name = NULL;
+		rx51_aux_dev[1].codec_of_node = dai_node;
+		rx51_codec_conf[1].dev_name = NULL;
+		rx51_codec_conf[1].of_node = dai_node;
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-- 
1.9.1
