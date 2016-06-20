From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v2 3/5] ASoC: tpa6130a2: Use snd soc volsw
	functions
Date: Mon, 20 Jun 2016 14:12:31 -0300
Message-ID: <07133127008fa3924bd4cf7d10d42df30e4361f4.1466441036.git.helen.koike@collabora.co.uk>
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

Use snd_soc_{info,get,put}_volsw instead of custom volume functions

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
[koike: port for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
[On N900]
Tested-By: Sebastian Reichel <sre@kernel.org>

---

Changes since v1:
- Add tested-by from Sebastian

 sound/soc/codecs/tpa6130a2.c | 64 ++------------------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index d90388a..81bf584 100644
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
1.9.1
