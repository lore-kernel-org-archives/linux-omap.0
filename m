From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v3 1/2] ASoC: tpa6130a2: Add DAPM support
Date: Thu, 23 Jun 2016 16:23:13 -0300
Message-ID: <9946402f404892d0bacb3666a82aba8e07374068.1466709086.git.helen.koike@collabora.co.uk>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
 <cover.1466709086.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466709086.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1466709086.git.helen.koike@collabora.co.uk>
References: <cover.1466709086.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com, cphealy@gmail.com, Helen Koike <helen.koike@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add DAPM support and updated rx51 accordingly.
As a consequence:
- the exported function tpa6130a2_stereo_enable is not needed anymore
- the mutex is dealt in the DAPM
- the power state is tracked by the DAPM

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
Tested-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>

---
Changes since v1:
- Replace
	+	{"TPA6130A2 HPLEFT", NULL, "LLOUT"},
	+	{"TPA6130A2 HPRIGHT", NULL, "RLOUT"}

	by

	+       {"TPA6130A2 LEFTIN", NULL, "LLOUT"},
	+       {"TPA6130A2 RIGHTIN", NULL, "RLOUT"},
- Add tested-by and reviewed-by from Sebastian
- Add struct device dev* in struct tpa6130a2_data and pass data instead
of dev to tpa6130a2_power function
- remove #include "../codecs/tpa6130a2.h" in rx51.c

Changes since v2:
- Add braces around else statement in tpa6130a2_power_event

 sound/soc/codecs/tpa6130a2.c | 185 ++++++++++++++++++-------------------------
 sound/soc/codecs/tpa6130a2.h |  11 +--
 sound/soc/omap/rx51.c        |  23 ++----
 3 files changed, 89 insertions(+), 130 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 81bf584..9da1dd1 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -41,79 +41,74 @@ enum tpa_model {
 	TPA6140A2,
 };
 
-static struct i2c_client *tpa6130a2_client;
-
 /* This struct is used to save the context */
 struct tpa6130a2_data {
-	struct mutex mutex;
+	struct device *dev;
 	struct regmap *regmap;
 	struct regulator *supply;
 	int power_gpio;
-	u8 power_state:1;
 	enum tpa_model id;
 };
 
-static int tpa6130a2_power(u8 power)
+static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 {
-	struct	tpa6130a2_data *data;
-	int	ret = 0;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	mutex_lock(&data->mutex);
-	if (power == data->power_state)
-		goto exit;
+	int ret;
 
-	if (power) {
+	if (enable) {
 		ret = regulator_enable(data->supply);
 		if (ret != 0) {
-			dev_err(&tpa6130a2_client->dev,
+			dev_err(data->dev,
 				"Failed to enable supply: %d\n", ret);
-			goto exit;
+			return ret;
 		}
 		/* Power on */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 1);
-
-		data->power_state = 1;
-		ret = regcache_sync(data->regmap);
-		if (ret < 0) {
-			dev_err(&tpa6130a2_client->dev,
-				"Failed to initialize chip\n");
-			if (data->power_gpio >= 0)
-				gpio_set_value(data->power_gpio, 0);
-			regulator_disable(data->supply);
-			data->power_state = 0;
-			goto exit;
-		}
 	} else {
-		/* set SWS */
-		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
-			TPA6130A2_SWS, TPA6130A2_SWS);
-
 		/* Power off */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 0);
 
 		ret = regulator_disable(data->supply);
 		if (ret != 0) {
-			dev_err(&tpa6130a2_client->dev,
+			dev_err(data->dev,
 				"Failed to disable supply: %d\n", ret);
-			goto exit;
+			return ret;
 		}
 
-		data->power_state = 0;
 		/* device regs does not match the cache state anymore */
 		regcache_mark_dirty(data->regmap);
 	}
 
-exit:
-	mutex_unlock(&data->mutex);
 	return ret;
 }
 
+static int tpa6130a2_power_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kctrl, int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct tpa6130a2_data *data = snd_soc_component_get_drvdata(c);
+	int ret;
+
+	/* before widget power up */
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		/* Turn on the chip */
+		tpa6130a2_power(data, true);
+		/* Sync the registers */
+		ret = regcache_sync(data->regmap);
+		if (ret < 0) {
+			dev_err(c->dev, "Failed to initialize chip\n");
+			tpa6130a2_power(data, false);
+			return ret;
+		}
+	/* after widget power down */
+	} else {
+		tpa6130a2_power(data, false);
+	}
+
+	return 0;
+}
+
 /*
  * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
  * down in gain.
@@ -149,57 +144,6 @@ static const struct snd_kcontrol_new tpa6140a2_controls[] = {
 		       tpa6140_tlv),
 };
 
-/*
- * Enable or disable channel (left or right)
- * The bit number for mute and amplifier are the same per channel:
- * bit 6: Right channel
- * bit 7: Left channel
- * in both registers.
- */
-static void tpa6130a2_channel_enable(u8 channel, int enable)
-{
-	struct tpa6130a2_data *data = i2c_get_clientdata(tpa6130a2_client);
-
-	if (enable) {
-		/* Enable channel */
-		/* Enable amplifier */
-		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
-			channel | TPA6130A2_SWS, channel & ~TPA6130A2_SWS);
-
-		/* Unmute channel */
-		regmap_update_bits(data->regmap, TPA6130A2_REG_VOL_MUTE,
-				   channel, 0);
-	} else {
-		/* Disable channel */
-		/* Mute channel */
-		regmap_update_bits(data->regmap, TPA6130A2_REG_VOL_MUTE,
-				   channel, channel);
-
-		/* Disable amplifier */
-		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
-				   channel, 0);
-	}
-}
-
-int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable)
-{
-	int ret = 0;
-	if (enable) {
-		ret = tpa6130a2_power(1);
-		if (ret < 0)
-			return ret;
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
-					 1);
-	} else {
-		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
-					 0);
-		ret = tpa6130a2_power(0);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
-
 static int tpa6130a2_component_probe(struct snd_soc_component *component)
 {
 	struct tpa6130a2_data *data = snd_soc_component_get_drvdata(component);
@@ -212,9 +156,47 @@ static int tpa6130a2_component_probe(struct snd_soc_component *component)
 			tpa6130a2_controls, ARRAY_SIZE(tpa6130a2_controls));
 }
 
+static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("LEFTIN"),
+	SND_SOC_DAPM_INPUT("RIGHTIN"),
+	SND_SOC_DAPM_OUTPUT("HPLEFT"),
+	SND_SOC_DAPM_OUTPUT("HPRIGHT"),
+
+	SND_SOC_DAPM_PGA("Left Mute", TPA6130A2_REG_VOL_MUTE,
+			 TPA6130A2_HP_EN_L_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Mute", TPA6130A2_REG_VOL_MUTE,
+			 TPA6130A2_HP_EN_R_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Left PGA", TPA6130A2_REG_CONTROL,
+			 TPA6130A2_HP_EN_L_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right PGA", TPA6130A2_REG_CONTROL,
+			 TPA6130A2_HP_EN_R_SHIFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("Power", TPA6130A2_REG_CONTROL,
+			    TPA6130A2_SWS_SHIFT, 1, tpa6130a2_power_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route tpa6130a2_dapm_routes[] = {
+	{ "Left PGA", NULL, "LEFTIN" },
+	{ "Right PGA", NULL, "RIGHTIN" },
+
+	{ "Left Mute", NULL, "Left PGA" },
+	{ "Right Mute", NULL, "Right PGA" },
+
+	{ "HPLEFT", NULL, "Left Mute" },
+	{ "HPRIGHT", NULL, "Right Mute" },
+
+	{ "Left PGA", NULL, "Power" },
+	{ "Right PGA", NULL, "Power" },
+};
+
 struct snd_soc_component_driver tpa6130a2_component_driver = {
 	.name = "tpa6130a2",
 	.probe = tpa6130a2_component_probe,
+	.dapm_widgets = tpa6130a2_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tpa6130a2_dapm_widgets),
+	.dapm_routes = tpa6130a2_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(tpa6130a2_dapm_routes),
 };
 
 static const struct reg_default tpa6130a2_reg_defaults[] = {
@@ -248,6 +230,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = dev;
+
 	data->regmap = devm_regmap_init_i2c(client, &tpa6130a2_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
@@ -262,14 +246,10 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	tpa6130a2_client = client;
-
-	i2c_set_clientdata(tpa6130a2_client, data);
+	i2c_set_clientdata(client, data);
 
 	data->id = id->driver_data;
 
-	mutex_init(&data->mutex);
-
 	if (data->power_gpio >= 0) {
 		ret = devm_gpio_request(dev, data->power_gpio,
 					"tpa6130a2 enable");
@@ -300,7 +280,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		goto err_gpio;
 	}
 
-	ret = tpa6130a2_power(1);
+	ret = tpa6130a2_power(data, true);
 	if (ret != 0)
 		goto err_gpio;
 
@@ -312,7 +292,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		dev_warn(dev, "UNTESTED version detected (%d)\n", version);
 
 	/* Disable the chip */
-	ret = tpa6130a2_power(0);
+	ret = tpa6130a2_power(data, false);
 	if (ret != 0)
 		goto err_gpio;
 
@@ -320,19 +300,9 @@ static int tpa6130a2_probe(struct i2c_client *client,
 			&tpa6130a2_component_driver, NULL, 0);
 
 err_gpio:
-	tpa6130a2_client = NULL;
-
 	return ret;
 }
 
-static int tpa6130a2_remove(struct i2c_client *client)
-{
-	tpa6130a2_power(0);
-	tpa6130a2_client = NULL;
-
-	return 0;
-}
-
 static const struct i2c_device_id tpa6130a2_id[] = {
 	{ "tpa6130a2", TPA6130A2 },
 	{ "tpa6140a2", TPA6140A2 },
@@ -355,7 +325,6 @@ static struct i2c_driver tpa6130a2_i2c_driver = {
 		.of_match_table = of_match_ptr(tpa6130a2_of_match),
 	},
 	.probe = tpa6130a2_probe,
-	.remove = tpa6130a2_remove,
 	.id_table = tpa6130a2_id,
 };
 
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index ef05a3f..f19cad5 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -32,15 +32,18 @@
 
 /* Register bits */
 /* TPA6130A2_REG_CONTROL (0x01) */
-#define TPA6130A2_SWS			(0x01 << 0)
+#define TPA6130A2_SWS_SHIFT		0
+#define TPA6130A2_SWS			(0x01 << TPA6130A2_SWS_SHIFT)
 #define TPA6130A2_TERMAL		(0x01 << 1)
 #define TPA6130A2_MODE(x)		(x << 4)
 #define TPA6130A2_MODE_STEREO		(0x00)
 #define TPA6130A2_MODE_DUAL_MONO	(0x01)
 #define TPA6130A2_MODE_BRIDGE		(0x02)
 #define TPA6130A2_MODE_MASK		(0x03)
-#define TPA6130A2_HP_EN_R		(0x01 << 6)
-#define TPA6130A2_HP_EN_L		(0x01 << 7)
+#define TPA6130A2_HP_EN_R_SHIFT		6
+#define TPA6130A2_HP_EN_R		(0x01 << TPA6130A2_HP_EN_R_SHIFT)
+#define TPA6130A2_HP_EN_L_SHIFT		7
+#define TPA6130A2_HP_EN_L		(0x01 << TPA6130A2_HP_EN_L_SHIFT)
 
 /* TPA6130A2_REG_VOL_MUTE (0x02) */
 #define TPA6130A2_VOLUME(x)		((x & 0x3f) << 0)
@@ -54,6 +57,4 @@
 /* TPA6130A2_REG_VERSION (0x04) */
 #define TPA6130A2_VERSION_MASK		(0x0f)
 
-extern int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable);
-
 #endif /* __TPA6130A2_H__ */
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index b59cf89..a768457 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -33,7 +33,6 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include "../codecs/tpa6130a2.h"
 
 #include <asm/mach-types.h>
 
@@ -164,19 +163,6 @@ static int rx51_spk_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rx51_hp_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *k, int event)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		tpa6130a2_stereo_enable(codec, 1);
-	else
-		tpa6130a2_stereo_enable(codec, 0);
-
-	return 0;
-}
-
 static int rx51_get_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
@@ -235,7 +221,7 @@ static struct snd_soc_jack_gpio rx51_av_jack_gpios[] = {
 static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
-	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("HS Mic", NULL),
 	SND_SOC_DAPM_LINE("FM Transmitter", NULL),
 	SND_SOC_DAPM_SPK("Earphone", NULL),
@@ -246,11 +232,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPROUT"},
 	{"Ext Spk", NULL, "HPLCOM"},
 	{"Ext Spk", NULL, "HPRCOM"},
-	{"Headphone Jack", NULL, "LLOUT"},
-	{"Headphone Jack", NULL, "RLOUT"},
 	{"FM Transmitter", NULL, "LLOUT"},
 	{"FM Transmitter", NULL, "RLOUT"},
 
+	{"Headphone Jack", NULL, "TPA6130A2 HPLEFT"},
+	{"Headphone Jack", NULL, "TPA6130A2 HPRIGHT"},
+	{"TPA6130A2 LEFTIN", NULL, "LLOUT"},
+	{"TPA6130A2 RIGHTIN", NULL, "RLOUT"},
+
 	{"DMic Rate 64", NULL, "DMic"},
 	{"DMic", NULL, "Mic Bias"},
 
-- 
1.9.1
