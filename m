From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: Use snd soc volsw functions" to the asoc tree
Date: Thu, 23 Jun 2016 15:38:06 +0100
Message-ID: <E1bG5le-00043m-2m@debutante>
References: <07133127008fa3924bd4cf7d10d42df30e4361f4.1466441036.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07133127008fa3924bd4cf7d10d42df30e4361f4.1466441036.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, k.kozlowski@samsung.comlars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.combroonie@kernel.org, cphealy@gmail.com, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: tpa6130a2: Use snd soc volsw functions

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

>From e01d700c399d8d899850a1e5fad5227a9d976304 Mon Sep 17 00:00:00 2001
From: Helen Koike <helen.koike@collabora.co.uk>
Date: Mon, 20 Jun 2016 14:12:31 -0300
Subject: [PATCH] ASoC: tpa6130a2: Use snd soc volsw functions

Use snd_soc_{info,get,put}_volsw instead of custom volume functions

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
[On N900]
Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 64 ++------------------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index d90388a38903..81bf5848b743 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -114,64 +114,6 @@ exit:
 	return ret;
 }
 
-static int tpa6130a2_get_volsw(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct tpa6130a2_data *data;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	int max = mc->max, val;
-	unsigned int mask = (1 << fls(max)) - 1;
-	unsigned int invert = mc->invert;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	mutex_lock(&data->mutex);
-
-	regmap_read(data->regmap, reg, &val);
-	ucontrol->value.integer.value[0] = (val >> shift) & mask;
-
-	if (invert)
-		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
-
-	mutex_unlock(&data->mutex);
-	return 0;
-}
-
-static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct tpa6130a2_data *data;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	int max = mc->max;
-	unsigned int mask = (1 << fls(max)) - 1;
-	unsigned int invert = mc->invert;
-	unsigned int val = (ucontrol->value.integer.value[0] & mask);
-	bool change;
-
-	if (WARN_ON(!tpa6130a2_client))
-		return -EINVAL;
-	data = i2c_get_clientdata(tpa6130a2_client);
-
-	if (invert)
-		val = max - val;
-
-	mutex_lock(&data->mutex);
-	regmap_update_bits_check(data->regmap, reg, mask << shift, val << shift,
-				 &change);
-	mutex_unlock(&data->mutex);
-
-	return change;
-}
-
 /*
  * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
  * down in gain.
@@ -190,9 +132,8 @@ static const DECLARE_TLV_DB_RANGE(tpa6130_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("Headphone Playback Volume",
+	SOC_SINGLE_TLV("Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
-		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6130_tlv),
 };
 
@@ -203,9 +144,8 @@ static const DECLARE_TLV_DB_RANGE(tpa6140_tlv,
 );
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("Headphone Playback Volume",
+	SOC_SINGLE_TLV("Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
-		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6140_tlv),
 };
 
-- 
2.8.1
