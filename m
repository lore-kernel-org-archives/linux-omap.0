From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tap6130a2: Use regmap" to the asoc tree
Date: Thu, 23 Jun 2016 15:38:08 +0100
Message-ID: <E1bG5lg-00044q-Vm@debutante>
References: <fe75f8da1580cd37309a566eb515598ffb148add.1466218805.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe75f8da1580cd37309a566eb515598ffb148add.1466218805.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.comlars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: tap6130a2: Use regmap

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

>From a0d5ff4496dca6e435ae3adb286d6583cf785aca Mon Sep 17 00:00:00 2001
From: Helen Koike <helen.koike@collabora.co.uk>
Date: Mon, 20 Jun 2016 14:12:30 -0300
Subject: [PATCH] ASoC: tap6130a2: Use regmap

Use regmap instead of open-coding IO access and caching

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
[On N900]
Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 166 ++++++++++++-------------------------------
 sound/soc/codecs/tpa6130a2.h |   2 -
 2 files changed, 46 insertions(+), 122 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f31326a332fb..d90388a38903 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -32,6 +32,7 @@
 #include <sound/tlv.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/regmap.h>
 
 #include "tpa6130a2.h"
 
@@ -45,92 +46,16 @@ static struct i2c_client *tpa6130a2_client;
 /* This struct is used to save the context */
 struct tpa6130a2_data {
 	struct mutex mutex;
-	unsigned char regs[TPA6130A2_CACHEREGNUM];
+	struct regmap *regmap;
 	struct regulator *supply;
 	int power_gpio;
 	u8 power_state:1;
 	enum tpa_model id;
 };
 
-static int tpa6130a2_i2c_read(int reg)
-{
-	struct tpa6130a2_data *data;
-	int val;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	/* If powered off, return the cached value */
-	if (data->power_state) {
-		val = i2c_smbus_read_byte_data(tpa6130a2_client, reg);
-		if (val < 0)
-			dev_err(&tpa6130a2_client->dev, "Read failed\n");
-		else
-			data->regs[reg] = val;
-	} else {
-		val = data->regs[reg];
-	}
-
-	return val;
-}
-
-static int tpa6130a2_i2c_write(int reg, u8 value)
-{
-	struct tpa6130a2_data *data;
-	int val = 0;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	if (data->power_state) {
-		val = i2c_smbus_write_byte_data(tpa6130a2_client, reg, value);
-		if (val < 0) {
-			dev_err(&tpa6130a2_client->dev, "Write failed\n");
-			return val;
-		}
-	}
-
-	/* Either powered on or off, we save the context */
-	data->regs[reg] = value;
-
-	return val;
-}
-
-static u8 tpa6130a2_read(int reg)
-{
-	struct tpa6130a2_data *data;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return 0;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	return data->regs[reg];
-}
-
-static int tpa6130a2_initialize(void)
-{
-	struct tpa6130a2_data *data;
-	int i, ret = 0;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	for (i = 1; i < TPA6130A2_REG_VERSION; i++) {
-		ret = tpa6130a2_i2c_write(i, data->regs[i]);
-		if (ret < 0)
-			break;
-	}
-
-	return ret;
-}
-
 static int tpa6130a2_power(u8 power)
 {
 	struct	tpa6130a2_data *data;
-	u8	val;
 	int	ret = 0;
 
 	if (WARN_ON(!tpa6130a2_client))
@@ -153,7 +78,7 @@ static int tpa6130a2_power(u8 power)
 			gpio_set_value(data->power_gpio, 1);
 
 		data->power_state = 1;
-		ret = tpa6130a2_initialize();
+		ret = regcache_sync(data->regmap);
 		if (ret < 0) {
 			dev_err(&tpa6130a2_client->dev,
 				"Failed to initialize chip\n");
@@ -165,9 +90,8 @@ static int tpa6130a2_power(u8 power)
 		}
 	} else {
 		/* set SWS */
-		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
-		val |= TPA6130A2_SWS;
-		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
+		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
+			TPA6130A2_SWS, TPA6130A2_SWS);
 
 		/* Power off */
 		if (data->power_gpio >= 0)
@@ -181,6 +105,8 @@ static int tpa6130a2_power(u8 power)
 		}
 
 		data->power_state = 0;
+		/* device regs does not match the cache state anymore */
+		regcache_mark_dirty(data->regmap);
 	}
 
 exit:
@@ -196,7 +122,7 @@ static int tpa6130a2_get_volsw(struct snd_kcontrol *kcontrol,
 	struct tpa6130a2_data *data;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	int max = mc->max;
+	int max = mc->max, val;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 
@@ -206,8 +132,8 @@ static int tpa6130a2_get_volsw(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&data->mutex);
 
-	ucontrol->value.integer.value[0] =
-		(tpa6130a2_read(reg) >> shift) & mask;
+	regmap_read(data->regmap, reg, &val);
+	ucontrol->value.integer.value[0] = (val >> shift) & mask;
 
 	if (invert)
 		ucontrol->value.integer.value[0] =
@@ -229,7 +155,7 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
-	unsigned int val_reg;
+	bool change;
 
 	if (WARN_ON(!tpa6130a2_client))
 		return -EINVAL;
@@ -239,20 +165,11 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
 		val = max - val;
 
 	mutex_lock(&data->mutex);
-
-	val_reg = tpa6130a2_read(reg);
-	if (((val_reg >> shift) & mask) == val) {
-		mutex_unlock(&data->mutex);
-		return 0;
-	}
-
-	val_reg &= ~(mask << shift);
-	val_reg |= val << shift;
-	tpa6130a2_i2c_write(reg, val_reg);
-
+	regmap_update_bits_check(data->regmap, reg, mask << shift, val << shift,
+				 &change);
 	mutex_unlock(&data->mutex);
 
-	return 1;
+	return change;
 }
 
 /*
@@ -301,31 +218,26 @@ static const struct snd_kcontrol_new tpa6140a2_controls[] = {
  */
 static void tpa6130a2_channel_enable(u8 channel, int enable)
 {
-	u8	val;
+	struct tpa6130a2_data *data = i2c_get_clientdata(tpa6130a2_client);
 
 	if (enable) {
 		/* Enable channel */
 		/* Enable amplifier */
-		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
-		val |= channel;
-		val &= ~TPA6130A2_SWS;
-		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
+		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
+			channel | TPA6130A2_SWS, channel & ~TPA6130A2_SWS);
 
 		/* Unmute channel */
-		val = tpa6130a2_read(TPA6130A2_REG_VOL_MUTE);
-		val &= ~channel;
-		tpa6130a2_i2c_write(TPA6130A2_REG_VOL_MUTE, val);
+		regmap_update_bits(data->regmap, TPA6130A2_REG_VOL_MUTE,
+				   channel, 0);
 	} else {
 		/* Disable channel */
 		/* Mute channel */
-		val = tpa6130a2_read(TPA6130A2_REG_VOL_MUTE);
-		val |= channel;
-		tpa6130a2_i2c_write(TPA6130A2_REG_VOL_MUTE, val);
+		regmap_update_bits(data->regmap, TPA6130A2_REG_VOL_MUTE,
+				   channel, channel);
 
 		/* Disable amplifier */
-		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
-		val &= ~channel;
-		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
+		regmap_update_bits(data->regmap, TPA6130A2_REG_CONTROL,
+				   channel, 0);
 	}
 }
 
@@ -365,6 +277,20 @@ struct snd_soc_component_driver tpa6130a2_component_driver = {
 	.probe = tpa6130a2_component_probe,
 };
 
+static const struct reg_default tpa6130a2_reg_defaults[] = {
+	{ TPA6130A2_REG_CONTROL, TPA6130A2_SWS },
+	{ TPA6130A2_REG_VOL_MUTE, TPA6130A2_MUTE_R | TPA6130A2_MUTE_L },
+};
+
+static const struct regmap_config tpa6130a2_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPA6130A2_REG_VERSION,
+	.reg_defaults = tpa6130a2_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(tpa6130a2_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int tpa6130a2_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -373,6 +299,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	struct tpa6130a2_platform_data *pdata = client->dev.platform_data;
 	struct device_node *np = client->dev.of_node;
 	const char *regulator;
+	unsigned int version;
 	int ret;
 
 	dev = &client->dev;
@@ -381,6 +308,10 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
+	data->regmap = devm_regmap_init_i2c(client, &tpa6130a2_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	if (pdata) {
 		data->power_gpio = pdata->power_gpio;
 	} else if (np) {
@@ -399,11 +330,6 @@ static int tpa6130a2_probe(struct i2c_client *client,
 
 	mutex_init(&data->mutex);
 
-	/* Set default register values */
-	data->regs[TPA6130A2_REG_CONTROL] =	TPA6130A2_SWS;
-	data->regs[TPA6130A2_REG_VOL_MUTE] =	TPA6130A2_MUTE_R |
-						TPA6130A2_MUTE_L;
-
 	if (data->power_gpio >= 0) {
 		ret = devm_gpio_request(dev, data->power_gpio,
 					"tpa6130a2 enable");
@@ -440,10 +366,10 @@ static int tpa6130a2_probe(struct i2c_client *client,
 
 
 	/* Read version */
-	ret = tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
-				 TPA6130A2_VERSION_MASK;
-	if ((ret != 1) && (ret != 2))
-		dev_warn(dev, "UNTESTED version detected (%d)\n", ret);
+	regmap_read(data->regmap, TPA6130A2_REG_VERSION, &version);
+	version &= TPA6130A2_VERSION_MASK;
+	if ((version != 1) && (version != 2))
+		dev_warn(dev, "UNTESTED version detected (%d)\n", version);
 
 	/* Disable the chip */
 	ret = tpa6130a2_power(0);
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 78ee7237568b..ef05a3ff189b 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -30,8 +30,6 @@
 #define TPA6130A2_REG_OUT_IMPEDANCE	0x03
 #define TPA6130A2_REG_VERSION		0x04
 
-#define TPA6130A2_CACHEREGNUM	(TPA6130A2_REG_VERSION + 1)
-
 /* Register bits */
 /* TPA6130A2_REG_CONTROL (0x01) */
 #define TPA6130A2_SWS			(0x01 << 0)
-- 
2.8.1
