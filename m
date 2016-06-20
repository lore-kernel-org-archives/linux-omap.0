From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v2 1/5] ASoC: tpa6130a2: Register component
Date: Mon, 20 Jun 2016 14:12:29 -0300
Message-ID: <139032aca71410fa9df608ea34ecb8046439c626.1466441036.git.helen.koike@collabora.co.uk>
References: <20160618104038.GB31665@earth>
 <cover.1466441036.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1466441036.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1466441036.git.helen.koike@collabora.co.uk>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: k.kozlowski@samsung.com, lars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, cphealy@gmail.com, Helen Koike <helen.koike@collabora.co.uk>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Add tpa6130a2 controls by the component API and update rx51 accordingly

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>

---

Changes since v1:
- Remove prefix from snd_kcontrol_new in tpa6130a2.c
- Add tested-by and reviewd-by from Sebastian

 sound/soc/codecs/tpa6130a2.c | 30 +++++++++++++++---------------
 sound/soc/codecs/tpa6130a2.h |  1 -
 sound/soc/omap/rx51.c        | 23 ++++++++++++-----------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 11d85c5..f31326a 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -273,7 +273,7 @@ static const DECLARE_TLV_DB_RANGE(tpa6130_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
+	SOC_SINGLE_EXT_TLV("Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
 		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6130_tlv),
@@ -286,7 +286,7 @@ static const DECLARE_TLV_DB_RANGE(tpa6140_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
+	SOC_SINGLE_EXT_TLV("Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
 		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6140_tlv),
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
