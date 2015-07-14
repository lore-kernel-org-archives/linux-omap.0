From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] V4 regmap: Use reg_sequence for
	multi_reg_write / register_patch
Date: Tue, 14 Jul 2015 15:45:51 +0100
Message-ID: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, bardliao@realtek.com, lee.jones@linaro.org, laurent.pinchart+renesas@ideasonboard.com, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, nariman@opensource.wolfsonmicro.com, Paul.Handrigan@cirrus.com, tony@atomide.com, lars@metafoo.de, dmurphy@ti.com, linux-omap@vger.kernel.org, oder_chiou@realtek.com, brian.austin@cirrus.com, support.opensource@diasemi.com, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org

Add support for writing sequences of registers / patches with specified
delays (in microseconds). Logically separates the functionality using
sequences of register writes from the functions that take register
defaults, as adding a delay field on the reg_defaults can increase
memory usage substantially.

This also updates all the clients of multi_reg_write/register_patch.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
---
 drivers/base/regmap/internal.h |  2 +-
 drivers/base/regmap/regmap.c   | 22 +++++++++++-----------
 drivers/gpu/drm/i2c/adv7511.c  |  2 +-
 drivers/input/misc/drv260x.c   |  6 +++---
 drivers/input/misc/drv2665.c   |  2 +-
 drivers/input/misc/drv2667.c   |  4 ++--
 drivers/mfd/arizona-core.c     |  2 +-
 drivers/mfd/twl6040.c          |  2 +-
 drivers/mfd/wm5102-tables.c    |  6 +++---
 drivers/mfd/wm5110-tables.c    |  6 +++---
 drivers/mfd/wm8994-core.c      |  8 ++++----
 drivers/mfd/wm8997-tables.c    |  2 +-
 include/linux/regmap.h         | 21 ++++++++++++++++++---
 sound/soc/codecs/arizona.c     |  2 +-
 sound/soc/codecs/cs35l32.c     |  2 +-
 sound/soc/codecs/cs42l52.c     |  2 +-
 sound/soc/codecs/da7210.c      |  4 ++--
 sound/soc/codecs/rt5640.c      |  2 +-
 sound/soc/codecs/rt5645.c      |  4 ++--
 sound/soc/codecs/rt5651.c      |  2 +-
 sound/soc/codecs/rt5670.c      |  2 +-
 sound/soc/codecs/rt5677.c      |  2 +-
 sound/soc/codecs/tlv320aic3x.c |  2 +-
 sound/soc/codecs/wm2200.c      |  2 +-
 sound/soc/codecs/wm5100.c      |  2 +-
 sound/soc/codecs/wm8962.c      |  2 +-
 sound/soc/codecs/wm8993.c      |  2 +-
 27 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b2b2849..873ddf9 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -136,7 +136,7 @@ struct regmap {
 	/* if set, the HW registers are known to match map->reg_defaults */
 	bool no_sync_defaults;
 
-	struct reg_default *patch;
+	struct reg_sequence *patch;
 	int patch_regs;
 
 	/* if set, converts bulk rw to single rw */
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index dd63bcb..0a849ee 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1755,7 +1755,7 @@ EXPORT_SYMBOL_GPL(regmap_bulk_write);
  * relative. The page register has been written if that was neccessary.
  */
 static int _regmap_raw_multi_reg_write(struct regmap *map,
-				       const struct reg_default *regs,
+				       const struct reg_sequence *regs,
 				       size_t num_regs)
 {
 	int ret;
@@ -1812,12 +1812,12 @@ static unsigned int _regmap_register_page(struct regmap *map,
 }
 
 static int _regmap_range_multi_paged_reg_write(struct regmap *map,
-					       struct reg_default *regs,
+					       struct reg_sequence *regs,
 					       size_t num_regs)
 {
 	int ret;
 	int i, n;
-	struct reg_default *base;
+	struct reg_sequence *base;
 	unsigned int this_page = 0;
 	/*
 	 * the set of registers are not neccessarily in order, but
@@ -1855,7 +1855,7 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 }
 
 static int _regmap_multi_reg_write(struct regmap *map,
-				   const struct reg_default *regs,
+				   const struct reg_sequence *regs,
 				   size_t num_regs)
 {
 	int i;
@@ -1907,8 +1907,8 @@ static int _regmap_multi_reg_write(struct regmap *map,
 		struct regmap_range_node *range;
 		range = _regmap_range_lookup(map, reg);
 		if (range) {
-			size_t len = sizeof(struct reg_default)*num_regs;
-			struct reg_default *base = kmemdup(regs, len,
+			size_t len = sizeof(struct reg_sequence)*num_regs;
+			struct reg_sequence *base = kmemdup(regs, len,
 							   GFP_KERNEL);
 			if (!base)
 				return -ENOMEM;
@@ -1941,7 +1941,7 @@ static int _regmap_multi_reg_write(struct regmap *map,
  * A value of zero will be returned on success, a negative errno will be
  * returned in error cases.
  */
-int regmap_multi_reg_write(struct regmap *map, const struct reg_default *regs,
+int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
 			   int num_regs)
 {
 	int ret;
@@ -1974,7 +1974,7 @@ EXPORT_SYMBOL_GPL(regmap_multi_reg_write);
  * be returned in error cases.
  */
 int regmap_multi_reg_write_bypassed(struct regmap *map,
-				    const struct reg_default *regs,
+				    const struct reg_sequence *regs,
 				    int num_regs)
 {
 	int ret;
@@ -2587,10 +2587,10 @@ EXPORT_SYMBOL_GPL(regmap_async_complete);
  * The caller must ensure that this function cannot be called
  * concurrently with either itself or regcache_sync().
  */
-int regmap_register_patch(struct regmap *map, const struct reg_default *regs,
+int regmap_register_patch(struct regmap *map, const struct reg_sequence *regs,
 			  int num_regs)
 {
-	struct reg_default *p;
+	struct reg_sequence *p;
 	int ret;
 	bool bypass;
 
@@ -2599,7 +2599,7 @@ int regmap_register_patch(struct regmap *map, const struct reg_default *regs,
 		return 0;
 
 	p = krealloc(map->patch,
-		     sizeof(struct reg_default) * (map->patch_regs + num_regs),
+		     sizeof(struct reg_sequence) * (map->patch_regs + num_regs),
 		     GFP_KERNEL);
 	if (p) {
 		memcpy(p + map->patch_regs, regs, num_regs * sizeof(*regs));
diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index 2aaa3c8..00416f2 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -54,7 +54,7 @@ static struct adv7511 *encoder_to_adv7511(struct drm_encoder *encoder)
 }
 
 /* ADI recommended values for proper operation. */
-static const struct reg_default adv7511_fixed_registers[] = {
+static const struct reg_sequence adv7511_fixed_registers[] = {
 	{ 0x98, 0x03 },
 	{ 0x9a, 0xe0 },
 	{ 0x9c, 0x30 },
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e5d60ec..f5c9cf2 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -313,14 +313,14 @@ static void drv260x_close(struct input_dev *input)
 	gpiod_set_value(haptics->enable_gpio, 0);
 }
 
-static const struct reg_default drv260x_lra_cal_regs[] = {
+static const struct reg_sequence drv260x_lra_cal_regs[] = {
 	{ DRV260X_MODE, DRV260X_AUTO_CAL },
 	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 },
 	{ DRV260X_FEEDBACK_CTRL, DRV260X_FB_REG_LRA_MODE |
 		DRV260X_BRAKE_FACTOR_4X | DRV260X_LOOP_GAIN_HIGH },
 };
 
-static const struct reg_default drv260x_lra_init_regs[] = {
+static const struct reg_sequence drv260x_lra_init_regs[] = {
 	{ DRV260X_MODE, DRV260X_RT_PLAYBACK },
 	{ DRV260X_A_TO_V_CTRL, DRV260X_AUDIO_HAPTICS_PEAK_20MS |
 		DRV260X_AUDIO_HAPTICS_FILTER_125HZ },
@@ -337,7 +337,7 @@ static const struct reg_default drv260x_lra_init_regs[] = {
 	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
 };
 
-static const struct reg_default drv260x_erm_cal_regs[] = {
+static const struct reg_sequence drv260x_erm_cal_regs[] = {
 	{ DRV260X_MODE, DRV260X_AUTO_CAL },
 	{ DRV260X_A_TO_V_MIN_INPUT, DRV260X_AUDIO_HAPTICS_MIN_IN_VOLT },
 	{ DRV260X_A_TO_V_MAX_INPUT, DRV260X_AUDIO_HAPTICS_MAX_IN_VOLT },
diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 0afaa33..924456e 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -132,7 +132,7 @@ static void drv2665_close(struct input_dev *input)
 			"Failed to enter standby mode: %d\n", error);
 }
 
-static const struct reg_default drv2665_init_regs[] = {
+static const struct reg_sequence drv2665_init_regs[] = {
 	{ DRV2665_CTRL_2, 0 | DRV2665_10_MS_IDLE_TOUT },
 	{ DRV2665_CTRL_1, DRV2665_25_VPP_GAIN },
 };
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index fc0fddf..047136a 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -262,14 +262,14 @@ static void drv2667_close(struct input_dev *input)
 			"Failed to enter standby mode: %d\n", error);
 }
 
-static const struct reg_default drv2667_init_regs[] = {
+static const struct reg_sequence drv2667_init_regs[] = {
 	{ DRV2667_CTRL_2, 0 },
 	{ DRV2667_CTRL_1, DRV2667_25_VPP_GAIN },
 	{ DRV2667_WV_SEQ_0, 1 },
 	{ DRV2667_WV_SEQ_1, 0 }
 };
 
-static const struct reg_default drv2667_page1_init[] = {
+static const struct reg_sequence drv2667_page1_init[] = {
 	{ DRV2667_RAM_HDR_SZ, 0x05 },
 	{ DRV2667_RAM_START_HI, 0x80 },
 	{ DRV2667_RAM_START_LO, 0x06 },
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index bebf58a..66d50be 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -392,7 +392,7 @@ err:
  * Register patch to some of the CODECs internal write sequences
  * to ensure a clean exit from the low power sleep state.
  */
-static const struct reg_default wm5110_sleep_patch[] = {
+static const struct reg_sequence wm5110_sleep_patch[] = {
 	{ 0x337A, 0xC100 },
 	{ 0x337B, 0x0041 },
 	{ 0x3300, 0xA210 },
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index c5265c1..583dc33 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -86,7 +86,7 @@ static const struct reg_default twl6040_defaults[] = {
 	{ 0x2E, 0x00 }, /* REG_STATUS	(ro) */
 };
 
-static struct reg_default twl6040_patch[] = {
+static struct reg_sequence twl6040_patch[] = {
 	/*
 	 * Select I2C bus access to dual access registers
 	 * Interrupt register is cleared on read
diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index aeae6ec..423fb37 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -21,7 +21,7 @@
 #define WM5102_NUM_AOD_ISR 2
 #define WM5102_NUM_ISR 5
 
-static const struct reg_default wm5102_reva_patch[] = {
+static const struct reg_sequence wm5102_reva_patch[] = {
 	{ 0x80, 0x0003 },
 	{ 0x221, 0x0090 },
 	{ 0x211, 0x0014 },
@@ -57,7 +57,7 @@ static const struct reg_default wm5102_reva_patch[] = {
 	{ 0x80, 0x0000 },
 };
 
-static const struct reg_default wm5102_revb_patch[] = {
+static const struct reg_sequence wm5102_revb_patch[] = {
 	{ 0x19, 0x0001 },
 	{ 0x80, 0x0003 },
 	{ 0x081, 0xE022 },
@@ -80,7 +80,7 @@ static const struct reg_default wm5102_revb_patch[] = {
 /* We use a function so we can use ARRAY_SIZE() */
 int wm5102_patch(struct arizona *arizona)
 {
-	const struct reg_default *wm5102_patch;
+	const struct reg_sequence *wm5102_patch;
 	int patch_size;
 
 	switch (arizona->rev) {
diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 12cad94..26ce14f 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -21,7 +21,7 @@
 #define WM5110_NUM_AOD_ISR 2
 #define WM5110_NUM_ISR 5
 
-static const struct reg_default wm5110_reva_patch[] = {
+static const struct reg_sequence wm5110_reva_patch[] = {
 	{ 0x80, 0x3 },
 	{ 0x44, 0x20 },
 	{ 0x45, 0x40 },
@@ -134,7 +134,7 @@ static const struct reg_default wm5110_reva_patch[] = {
 	{ 0x209, 0x002A },
 };
 
-static const struct reg_default wm5110_revb_patch[] = {
+static const struct reg_sequence wm5110_revb_patch[] = {
 	{ 0x80, 0x3 },
 	{ 0x36e, 0x0210 },
 	{ 0x370, 0x0210 },
@@ -224,7 +224,7 @@ static const struct reg_default wm5110_revb_patch[] = {
 	{ 0x80, 0x0 },
 };
 
-static const struct reg_default wm5110_revd_patch[] = {
+static const struct reg_sequence wm5110_revd_patch[] = {
 	{ 0x80, 0x3 },
 	{ 0x80, 0x3 },
 	{ 0x393, 0x27 },
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 53ae5af..0f4169a 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -243,21 +243,21 @@ static int wm8994_ldo_in_use(struct wm8994_pdata *pdata, int ldo)
 }
 #endif
 
-static const struct reg_default wm8994_revc_patch[] = {
+static const struct reg_sequence wm8994_revc_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0x56, 0x3 },
 	{ 0x817, 0x0 },
 	{ 0x102, 0x0 },
 };
 
-static const struct reg_default wm8958_reva_patch[] = {
+static const struct reg_sequence wm8958_reva_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0xcb, 0x81 },
 	{ 0x817, 0x0 },
 	{ 0x102, 0x0 },
 };
 
-static const struct reg_default wm1811_reva_patch[] = {
+static const struct reg_sequence wm1811_reva_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0x56, 0xc07 },
 	{ 0x5d, 0x7e },
@@ -326,7 +326,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 {
 	struct wm8994_pdata *pdata;
 	struct regmap_config *regmap_config;
-	const struct reg_default *regmap_patch = NULL;
+	const struct reg_sequence *regmap_patch = NULL;
 	const char *devname;
 	int ret, i, patch_regs = 0;
 	int pulls = 0;
diff --git a/drivers/mfd/wm8997-tables.c b/drivers/mfd/wm8997-tables.c
index c0c25d75..cab2c68 100644
--- a/drivers/mfd/wm8997-tables.c
+++ b/drivers/mfd/wm8997-tables.c
@@ -17,7 +17,7 @@
 
 #include "arizona.h"
 
-static const struct reg_default wm8997_reva_patch[] = {
+static const struct reg_sequence wm8997_reva_patch[] = {
 	{ 0x80, 0x0003 },
 	{ 0x214, 0x0008 },
 	{ 0x458, 0x0000 },
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 519c962..ee5106e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -50,6 +50,21 @@ struct reg_default {
 	unsigned int def;
 };
 
+/**
+ * Register / Value pairs for sequences of writes, incorporating an optional
+ * delay in microseconds.
+ *
+ * @reg: Register address.
+ * @def: Register default value.
+ * @delay_us: Delay in microseconds
+ */
+
+struct reg_sequence {
+	unsigned reg;
+	unsigned def;
+	unsigned delay_us;
+};
+
 #ifdef CONFIG_REGMAP
 
 enum regmap_endian {
@@ -410,10 +425,10 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		     const void *val, size_t val_len);
 int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			size_t val_count);
-int regmap_multi_reg_write(struct regmap *map, const struct reg_default *regs,
+int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
 			int num_regs);
 int regmap_multi_reg_write_bypassed(struct regmap *map,
-				    const struct reg_default *regs,
+				    const struct reg_sequence *regs,
 				    int num_regs);
 int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 			   const void *val, size_t val_len);
@@ -452,7 +467,7 @@ void regcache_mark_dirty(struct regmap *map);
 bool regmap_check_range_table(struct regmap *map, unsigned int reg,
 			      const struct regmap_access_table *table);
 
-int regmap_register_patch(struct regmap *map, const struct reg_default *regs,
+int regmap_register_patch(struct regmap *map, const struct reg_sequence *regs,
 			  int num_regs);
 int regmap_parse_val(struct regmap *map, const void *buf,
 				unsigned int *val);
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 802e05e..5edd33f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1366,7 +1366,7 @@ static void arizona_wm5102_set_dac_comp(struct snd_soc_codec *codec,
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
-	struct reg_default dac_comp[] = {
+	struct reg_sequence dac_comp[] = {
 		{ 0x80, 0x3 },
 		{ ARIZONA_DAC_COMP_1, 0 },
 		{ ARIZONA_DAC_COMP_2, 0 },
diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 8f40025..2813a1b 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -276,7 +276,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_cs35l32 = {
 };
 
 /* Current and threshold powerup sequence Pg37 in datasheet */
-static const struct reg_default cs35l32_monitor_patch[] = {
+static const struct reg_sequence cs35l32_monitor_patch[] = {
 
 	{ 0x00, 0x99 },
 	{ 0x48, 0x17 },
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 4de52c9..8b2d059 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1118,7 +1118,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_cs42l52 = {
 };
 
 /* Current and threshold powerup sequence Pg37 */
-static const struct reg_default cs42l52_threshold_patch[] = {
+static const struct reg_sequence cs42l52_threshold_patch[] = {
 
 	{ 0x00, 0x99 },
 	{ 0x3E, 0xBA },
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 21810e5..bf0fb3d 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1182,7 +1182,7 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 
 #if IS_ENABLED(CONFIG_I2C)
 
-static struct reg_default da7210_regmap_i2c_patch[] = {
+static struct reg_sequence da7210_regmap_i2c_patch[] = {
 
 	/* System controller master disable */
 	{ DA7210_STARTUP1, 0x00 },
@@ -1269,7 +1269,7 @@ static struct i2c_driver da7210_i2c_driver = {
 
 #if defined(CONFIG_SPI_MASTER)
 
-static struct reg_default da7210_regmap_spi_patch[] = {
+static struct reg_sequence da7210_regmap_spi_patch[] = {
 	/* Dummy read to give two pulses over nCS for SPI */
 	{ DA7210_AUX2, 0x00 },
 	{ DA7210_AUX2, 0x00 },
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9bc78e5..1ed1f88 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -51,7 +51,7 @@ static const struct regmap_range_cfg rt5640_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static const struct reg_default init_list[] = {
+static const struct reg_sequence init_list[] = {
 	{RT5640_PR_BASE + 0x3d,	0x3600},
 	{RT5640_PR_BASE + 0x12,	0x0aa8},
 	{RT5640_PR_BASE + 0x14,	0x0aaa},
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..c0f4be4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -54,7 +54,7 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 	},
 };
 
-static const struct reg_default init_list[] = {
+static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
 	{RT5645_PR_BASE + 0x1c,	0xfd20},
 	{RT5645_PR_BASE + 0x20,	0x611f},
@@ -63,7 +63,7 @@ static const struct reg_default init_list[] = {
 };
 #define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
-static const struct reg_default rt5650_init_list[] = {
+static const struct reg_sequence rt5650_init_list[] = {
 	{0xf6,	0x0100},
 };
 
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index a3506e1..db9b866 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -46,7 +46,7 @@ static const struct regmap_range_cfg rt5651_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static struct reg_default init_list[] = {
+static struct reg_sequence init_list[] = {
 	{RT5651_PR_BASE + 0x3d,	0x3e00},
 };
 
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index a9123d4..462a91f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -51,7 +51,7 @@ static const struct regmap_range_cfg rt5670_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static const struct reg_default init_list[] = {
+static const struct reg_sequence init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
 	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 31d969a..b897752 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -54,7 +54,7 @@ static const struct regmap_range_cfg rt5677_ranges[] = {
 	},
 };
 
-static const struct reg_default init_list[] = {
+static const struct reg_sequence init_list[] = {
 	{RT5677_ASRC_12,	0x0018},
 	{RT5677_PR_BASE + 0x3d,	0x364d},
 	{RT5677_PR_BASE + 0x17,	0x4fc0},
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index a7cf19b..83ae1eb 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1668,7 +1668,7 @@ static const struct i2c_device_id aic3x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
 
-static const struct reg_default aic3007_class_d[] = {
+static const struct reg_sequence aic3007_class_d[] = {
 	/* Class-D speaker driver init; datasheet p. 46 */
 	{ AIC3X_PAGE_SELECT, 0x0D },
 	{ 0xD, 0x0D },
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index c830832..6c60792 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -897,7 +897,7 @@ static bool wm2200_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct reg_default wm2200_reva_patch[] = {
+static const struct reg_sequence wm2200_reva_patch[] = {
 	{ 0x07, 0x0003 },
 	{ 0x102, 0x0200 },
 	{ 0x203, 0x0084 },
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4c10cd8..26d79bb 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1247,7 +1247,7 @@ static const struct snd_soc_dapm_route wm5100_dapm_routes[] = {
 	{ "PWM2", NULL, "PWM2 Driver" },
 };
 
-static const struct reg_default wm5100_reva_patches[] = {
+static const struct reg_sequence wm5100_reva_patches[] = {
 	{ WM5100_AUDIO_IF_1_10, 0 },
 	{ WM5100_AUDIO_IF_1_11, 1 },
 	{ WM5100_AUDIO_IF_1_12, 2 },
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c5748fd..05492e8 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3495,7 +3495,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 };
 
 /* Improve power consumption for IN4 DC measurement mode */
-static const struct reg_default wm8962_dc_measure[] = {
+static const struct reg_sequence wm8962_dc_measure[] = {
 	{ 0xfd, 0x1 },
 	{ 0xcc, 0x40 },
 	{ 0xfd, 0 },
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 8a8db86..52ec64d 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1595,7 +1595,7 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 #endif
 
 /* Tune DC servo configuration */
-static struct reg_default wm8993_regmap_patch[] = {
+static struct reg_sequence wm8993_regmap_patch[] = {
 	{ 0x44, 3 },
 	{ 0x56, 3 },
 	{ 0x44, 0 },
-- 
2.1.4
