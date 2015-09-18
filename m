From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v4 6/8] drm/i2c: tda998x: Improve tda998x_configure_audio() audio related pdata
Date: Fri, 18 Sep 2015 14:06:43 +0300
Message-ID: <59dbf9a45b35ad77def32e1d44bb8f9241a92026.1442572860.git.jsarha@ti.com>
References: <cover.1442572860.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1442572860.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Declare struct tda998x_audio_params in include/drm/i2c/tda998x.h and
use it in pdata and for tda998x_configure_audio() parameters. Also updates
tda998x_write_aif() to use hdmi_audio_infoframe_pack() and friends.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 drivers/gpu/drm/armada/armada_drv.c |  25 ++++++--
 drivers/gpu/drm/i2c/tda998x_drv.c   | 123 ++++++++++++++++++++----------------
 include/drm/i2c/tda998x.h           |  23 ++++---
 3 files changed, 102 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 225034b..d500840 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -20,6 +20,7 @@
 
 #ifdef CONFIG_DRM_ARMADA_TDA1998X
 #include <drm/i2c/tda998x.h>
+#include <sound/asoundef.h>
 #include "armada_slave.h"
 
 static struct tda998x_encoder_params params = {
@@ -35,10 +36,26 @@ static struct tda998x_encoder_params params = {
 	.swap_d = 5,
 	.swap_e = 0,
 	.swap_f = 1,
-	.audio_cfg = BIT(2),
-	.audio_frame[1] = 1,
-	.audio_format = AFMT_SPDIF,
-	.audio_sample_rate = 44100,
+	.audio = {
+		.config = BIT(2),
+		.format = AFMT_SPDIF,
+		.sample_width = 24,
+		.sample_rate = 44100,
+		.cea = {
+			.channels = 2,
+			.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM,
+			.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM,
+			.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM,
+		},
+		.status = {
+			IEC958_AES0_CON_NOT_COPYRIGHT,
+			IEC958_AES1_CON_GENERAL,
+			IEC958_AES2_CON_SOURCE_UNSPEC |
+			IEC958_AES2_CON_CHANNEL_UNSPEC,
+			IEC958_AES3_CON_CLOCK_1000PPM |
+			IEC958_AES3_CON_FS_NOTID,
+		},
+	}
 };
 
 static const struct armada_drm_slave_config tda19988_config = {
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 4dc2dc0..2fc6399 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -47,7 +47,7 @@ struct tda998x_priv {
 	u8 vip_cntrl_0;
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
-	struct tda998x_encoder_params params;
+	struct tda998x_audio_params audio_params;
 
 	wait_queue_head_t wq_edid;
 	volatile int wq_edid_wait;
@@ -597,15 +597,6 @@ static irqreturn_t tda998x_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static uint8_t tda998x_cksum(uint8_t *buf, size_t bytes)
-{
-	int sum = 0;
-
-	while (bytes--)
-		sum -= *buf++;
-	return sum;
-}
-
 #define HB(x) (x)
 #define PB(x) (HB(2) + 1 + (x))
 
@@ -618,24 +609,22 @@ tda998x_write_if(struct tda998x_priv *priv, uint8_t bit, uint16_t addr,
 	reg_set(priv, REG_DIP_IF_FLAGS, bit);
 }
 
-static void
-tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
+static int tda998x_write_aif(struct tda998x_priv *priv,
+			     struct hdmi_audio_infoframe *cea)
 {
-	u8 buf[PB(HDMI_AUDIO_INFOFRAME_SIZE) + 1];
-
-	memset(buf, 0, sizeof(buf));
-	buf[HB(0)] = HDMI_INFOFRAME_TYPE_AUDIO;
-	buf[HB(1)] = 0x01;
-	buf[HB(2)] = HDMI_AUDIO_INFOFRAME_SIZE;
-	buf[PB(1)] = p->audio_frame[1] & 0x07; /* CC */
-	buf[PB(2)] = p->audio_frame[2] & 0x1c; /* SF */
-	buf[PB(4)] = p->audio_frame[4];
-	buf[PB(5)] = p->audio_frame[5] & 0xf8; /* DM_INH + LSV */
+	uint8_t buf[HDMI_INFOFRAME_SIZE(AUDIO)];
+	int len;
 
-	buf[PB(0)] = tda998x_cksum(buf, sizeof(buf));
+	len = hdmi_audio_infoframe_pack(cea, buf, sizeof(buf));
+	if (len < 0) {
+		dev_err(&priv->hdmi->dev,
+			"Failed to pack audio infoframe: %d\n", len);
+		return len;
+	}
 
-	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf,
-			 sizeof(buf));
+	/* Write the audio information packet */
+	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf, len);
+	return 0;
 }
 
 static void
@@ -670,19 +659,20 @@ static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
 	}
 }
 
-static void
+static int
 tda998x_configure_audio(struct tda998x_priv *priv,
-		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
+			struct tda998x_audio_params *params,
+			unsigned mode_clock)
 {
 	uint8_t buf[6], clksel_aip, clksel_fs, cts_n, adiv;
 	uint32_t n;
 
 	/* Enable audio ports */
-	reg_write(priv, REG_ENA_AP, p->audio_cfg);
-	reg_write(priv, REG_ENA_ACLK, p->audio_clk_cfg);
+	reg_write(priv, REG_ENA_AP, params->config);
+	reg_write(priv, REG_ENA_ACLK, params->format == AFMT_SPDIF ? 0 : 1);
 
 	/* Set audio input source */
-	switch (p->audio_format) {
+	switch (params->format) {
 	case AFMT_SPDIF:
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
 		clksel_aip = AIP_CLKSEL_AIP_SPDIF;
@@ -694,12 +684,25 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		cts_n = CTS_N_M(3) | CTS_N_K(3);
+		switch (params->sample_width) {
+		case 16:
+			cts_n = CTS_N_M(3) | CTS_N_K(1);
+			break;
+		case 18:
+		case 20:
+		case 24:
+			cts_n = CTS_N_M(3) | CTS_N_K(2);
+			break;
+		default:
+		case 32:
+			cts_n = CTS_N_M(3) | CTS_N_K(3);
+			break;
+		}
 		break;
 
 	default:
 		BUG();
-		return;
+		return -EINVAL;
 	}
 
 	reg_write(priv, REG_AIP_CLKSEL, clksel_aip);
@@ -715,11 +718,11 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * assume 100MHz requires larger divider.
 	 */
 	adiv = AUDIO_DIV_SERCLK_8;
-	if (mode->clock > 100000)
+	if (mode_clock > 100000)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 */
 
 	/* S/PDIF asks for a larger divider */
-	if (p->audio_format == AFMT_SPDIF)
+	if (params->format == AFMT_SPDIF)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 or _32 */
 
 	reg_write(priv, REG_AUDIO_DIV, adiv);
@@ -728,7 +731,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * This is the approximate value of N, which happens to be
 	 * the recommended values for non-coherent clocks.
 	 */
-	n = 128 * p->audio_sample_rate / 1000;
+	n = 128 * params->sample_rate / 1000;
 
 	/* Write the CTS and N values */
 	buf[0] = 0x44;
@@ -747,19 +750,13 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
 
 	/* Write the channel status */
-	buf[0] = IEC958_AES0_CON_NOT_COPYRIGHT;
-	buf[1] = 0x00;
-	buf[2] = IEC958_AES3_CON_FS_NOTID;
-	buf[3] = IEC958_AES4_CON_ORIGFS_NOTID |
-			IEC958_AES4_CON_MAX_WORDLEN_24;
-	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
+	reg_write_range(priv, REG_CH_STAT_B(0), params->status, 4);
 
 	tda998x_audio_mute(priv, true);
 	msleep(20);
 	tda998x_audio_mute(priv, false);
 
-	/* Write the audio information packet */
-	tda998x_write_aif(priv, p);
+	return tda998x_write_aif(priv, &params->cea);
 }
 
 /* DRM encoder functions */
@@ -780,9 +777,7 @@ static void tda998x_encoder_set_config(struct tda998x_priv *priv,
 			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
 			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
 
-	priv->params = *p;
-	priv->audio.port_types[0] = p->audio_format;
-	priv->audio.ports[0] = p->audio_cfg;
+	priv->audio_params = p->audio;
 }
 
 static void tda998x_encoder_dpms(struct tda998x_priv *priv, int mode)
@@ -1033,9 +1028,11 @@ tda998x_encoder_mode_set(struct tda998x_priv *priv,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		if (priv->params.audio_cfg)
-			tda998x_configure_audio(priv, adjusted_mode,
-						&priv->params);
+		if (priv->audio_params.config) {
+			tda998x_configure_audio(priv,
+						&priv->audio_params,
+						adjusted_mode->clock);
+		}
 	}
 }
 
@@ -1416,12 +1413,28 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 			}
 		}
 		if (priv->audio.ports[0]) {
-			priv->params.audio_cfg = priv->audio.ports[0];
-			priv->params.audio_format =
-				priv->audio.port_types[0];
-			priv->params.audio_clk_cfg =
-				priv->params.audio_format ==
-				AFMT_SPDIF ? 0 : 1;
+			struct tda998x_audio_params params = {
+				.config = priv->audio.ports[0],
+				.format = priv->audio.port_types[0],
+				.sample_width = 24,
+				.sample_rate = 44100,
+				.cea = {
+					.channels = 2,
+					.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM,
+					.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM,
+					.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM,
+				},
+				.status = {
+					IEC958_AES0_CON_NOT_COPYRIGHT,
+					IEC958_AES1_CON_GENERAL,
+					IEC958_AES2_CON_SOURCE_UNSPEC |
+					IEC958_AES2_CON_CHANNEL_UNSPEC,
+					IEC958_AES3_CON_CLOCK_1000PPM |
+					IEC958_AES3_CON_FS_NOTID,
+				},
+			};
+
+			priv->audio_params = params;
 		}
 	}
 
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index 3e419d9..dfe7829 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -1,6 +1,18 @@
 #ifndef __DRM_I2C_TDA998X_H__
 #define __DRM_I2C_TDA998X_H__
 
+struct tda998x_audio_params {
+	u8 config;
+	enum {
+		AFMT_SPDIF,
+		AFMT_I2S
+	} format;
+	unsigned sample_width;
+	unsigned sample_rate;
+	struct hdmi_audio_infoframe cea;
+	u8 status[4];
+};
+
 struct tda998x_encoder_params {
 	u8 swap_b:3;
 	u8 mirr_b:1;
@@ -15,16 +27,7 @@ struct tda998x_encoder_params {
 	u8 swap_e:3;
 	u8 mirr_e:1;
 
-	u8 audio_cfg;
-	u8 audio_clk_cfg;
-	u8 audio_frame[6];
-
-	enum {
-		AFMT_SPDIF,
-		AFMT_I2S
-	} audio_format;
-
-	unsigned audio_sample_rate;
+	struct tda998x_audio_params audio;
 };
 
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
