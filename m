From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component driver implementation
Date: Thu, 26 Jun 2014 22:20:55 +0300
Message-ID: <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbaFZTVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 15:21:32 -0400
In-Reply-To: <cover.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Integrate ASoC DAI component driver in to the OMAP hdmi driver. The
patch also updates the relevant entry in ti,omap5-dss DT binding
document. The driver registers a dummy hdmi codec driver and a
simple-card driver to produce a fully functional ALSA device. The DAI
driver is implemented in hdmi_audio.c, but it still needs to be
registered from hdmi4.c or hdmi5.c.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Makefile     |    2 +
 drivers/video/fbdev/omap2/dss/hdmi.h       |   38 +++-
 drivers/video/fbdev/omap2/dss/hdmi_audio.c |  317 ++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c

diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
index 245f933..8260987 100644
--- a/drivers/video/fbdev/omap2/dss/Makefile
+++ b/drivers/video/fbdev/omap2/dss/Makefile
@@ -14,5 +14,7 @@ omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
 	hdmi_phy.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
+omapdss-$(CONFIG_OMAP4_DSS_HDMI_AUDIO) += hdmi_audio.o
 omapdss-$(CONFIG_OMAP5_DSS_HDMI) += hdmi5.o hdmi5_core.o
+omapdss-$(CONFIG_OMAP5_DSS_HDMI_AUDIO) += hdmi_audio.o
 ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 927cb4d..cc6ecb5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -25,6 +25,11 @@
 #include <linux/hdmi.h>
 #include <video/omapdss.h>
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+#include <sound/dmaengine_pcm.h>
+#include <uapi/sound/asound.h>
+#endif
+
 #include "dss.h"
 
 /* HDMI Wrapper */
@@ -338,6 +343,35 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	struct hdmi_phy_data *phy);
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+struct hdmi_audio_data {
+	/* These should be initialized when hdmi_audio_register() is called */
+	struct mutex *hdmi_lock;
+	struct hdmi_wp_data *wp;
+	struct hdmi_core_data *core;
+	struct hdmi_config *cfg;
+	struct snd_soc_dai_driver *hdmi_dai_drv;
+
+	int (*audio_start)(struct hdmi_core_data *core,
+			   struct hdmi_wp_data *wp);
+	void (*audio_stop)(struct hdmi_core_data *core,
+			   struct hdmi_wp_data *wp);
+	int (*audio_config)(struct hdmi_core_data *core,
+			    struct hdmi_wp_data *wp,
+			    struct omap_dss_audio *audio,
+			    u32 pclk);
+
+	/* These are of audio implementation's private use */
+	struct snd_dmaengine_dai_dma_data dma_data;
+	struct omap_dss_audio dss_audio;
+	struct snd_aes_iec958 iec;
+	struct snd_cea_861_aud_if cea;
+	struct platform_device *codec_pdev;
+	struct platform_device *card_pdev;
+};
+
+int hdmi_audio_register(struct platform_device *pdev);
+void hdmi_audio_unregister(struct platform_device *pdev);
+
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts);
 int hdmi_wp_audio_enable(struct hdmi_wp_data *wp, bool enable);
 int hdmi_wp_audio_core_req_enable(struct hdmi_wp_data *wp, bool enable);
@@ -345,9 +379,9 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
 		struct hdmi_audio_format *aud_fmt);
 void hdmi_wp_audio_config_dma(struct hdmi_wp_data *wp,
 		struct hdmi_audio_dma *aud_dma);
-static inline bool hdmi_mode_has_audio(int mode)
+static inline bool hdmi_mode_has_audio(struct hdmi_config *cfg)
 {
-	return mode == HDMI_HDMI ? true : false;
+	return cfg->hdmi_dvi_mode == HDMI_HDMI ? true : false;
 }
 #endif
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_audio.c b/drivers/video/fbdev/omap2/dss/hdmi_audio.c
new file mode 100644
index 0000000..a8a0b78
--- /dev/null
+++ b/drivers/video/fbdev/omap2/dss/hdmi_audio.c
@@ -0,0 +1,317 @@
+/*
+ * OMAP4+ HDMI audio
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated
+ *
+ * Authors: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+#include <uapi/sound/asound.h>
+#include <sound/asoundef.h>
+#include <sound/omap-pcm.h>
+#include <sound/simple_card.h>
+
+#include "hdmi.h"
+
+static int hdmi_dai_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *dd = snd_soc_dai_get_drvdata(dai);
+	int ret;
+	/*
+	 * Make sure that the period bytes are multiple of the DMA packet size.
+	 * Largest packet size we use is 32 32-bit words = 128 bytes
+	 */
+	ret = snd_pcm_hw_constraint_step(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
+	if (ret < 0) {
+		dev_err(dai->dev, "could not apply constraint\n");
+		return ret;
+	}
+
+	mutex_lock(dd->hdmi_lock);
+	ret = hdmi_mode_has_audio(dd->cfg);
+	mutex_unlock(dd->hdmi_lock);
+	if (!ret) {
+		dev_err(dai->dev, "audio not supported\n");
+		return -ENODEV;
+	}
+
+	snd_soc_dai_set_dma_data(dai, substream, &dd->dma_data);
+
+	return 0;
+}
+
+static int hdmi_dai_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *dd = snd_soc_dai_get_drvdata(dai);
+	int r;
+
+	mutex_lock(dd->hdmi_lock);
+
+	if (!hdmi_mode_has_audio(dd->cfg)) {
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_wp_audio_enable(dd->wp, true);
+
+err:
+	mutex_unlock(dd->hdmi_lock);
+	return r;
+}
+
+static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *dd = snd_soc_dai_get_drvdata(dai);
+	struct snd_aes_iec958 *iec = &dd->iec;
+	struct snd_cea_861_aud_if *cea = &dd->cea;
+	int err;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dd->dma_data.maxburst = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dd->dma_data.maxburst = 32;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
+
+	dd->dss_audio.iec = iec;
+	dd->dss_audio.cea = cea;
+	/*
+	 * fill the IEC-60958 channel status word
+	 */
+	/* initialize the word bytes */
+	memset(iec->status, 0, sizeof(iec->status));
+
+	/* specify IEC-60958-3 (commercial use) */
+	iec->status[0] &= ~IEC958_AES0_PROFESSIONAL;
+
+	/* specify that the audio is LPCM*/
+	iec->status[0] &= ~IEC958_AES0_NONAUDIO;
+
+	iec->status[0] |= IEC958_AES0_CON_NOT_COPYRIGHT;
+
+	iec->status[0] |= IEC958_AES0_CON_EMPHASIS_NONE;
+
+	iec->status[0] |= IEC958_AES1_PRO_MODE_NOTID;
+
+	iec->status[1] = IEC958_AES1_CON_GENERAL;
+
+	iec->status[2] |= IEC958_AES2_CON_SOURCE_UNSPEC;
+
+	iec->status[2] |= IEC958_AES2_CON_CHANNEL_UNSPEC;
+
+	switch (params_rate(params)) {
+	case 32000:
+		iec->status[3] |= IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		iec->status[3] |= IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		iec->status[3] |= IEC958_AES3_CON_FS_48000;
+		break;
+	case 88200:
+		iec->status[3] |= IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		iec->status[3] |= IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		iec->status[3] |= IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		iec->status[3] |= IEC958_AES3_CON_FS_192000;
+		break;
+	default:
+		dev_err(dai->dev, "rate not supported!\n");
+		return -EINVAL;
+	}
+
+	/* specify the clock accuracy */
+	iec->status[3] |= IEC958_AES3_CON_CLOCK_1000PPM;
+
+	/*
+	 * specify the word length. The same word length value can mean
+	 * two different lengths. Hence, we need to specify the maximum
+	 * word length as well.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iec->status[4] |= IEC958_AES4_CON_WORDLEN_20_16;
+		iec->status[4] &= ~IEC958_AES4_CON_MAX_WORDLEN_24;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iec->status[4] |= IEC958_AES4_CON_WORDLEN_24_20;
+		iec->status[4] |= IEC958_AES4_CON_MAX_WORDLEN_24;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Fill the CEA-861 audio infoframe (see spec for details)
+	 */
+
+	cea->db1_ct_cc = (params_channels(params) - 1)
+		& CEA861_AUDIO_INFOFRAME_DB1CC;
+	cea->db1_ct_cc |= CEA861_AUDIO_INFOFRAME_DB1CT_FROM_STREAM;
+
+	cea->db2_sf_ss = CEA861_AUDIO_INFOFRAME_DB2SF_FROM_STREAM;
+	cea->db2_sf_ss |= CEA861_AUDIO_INFOFRAME_DB2SS_FROM_STREAM;
+
+	cea->db3 = 0; /* not used, all zeros */
+
+	/*
+	 * The OMAP HDMI IP requires to use the 8-channel channel code when
+	 * transmitting more than two channels.
+	 */
+	if (params_channels(params) == 2)
+		cea->db4_ca = 0x0;
+	else
+		cea->db4_ca = 0x13;
+
+	cea->db5_dminh_lsv = CEA861_AUDIO_INFOFRAME_DB5_DM_INH_PROHIBITED;
+	/* the expression is trivial but makes clear what we are doing */
+	cea->db5_dminh_lsv |= (0 & CEA861_AUDIO_INFOFRAME_DB5_LSV);
+
+	mutex_lock(dd->hdmi_lock);
+
+	if (!hdmi_mode_has_audio(dd->cfg)) {
+		err = -EPERM;
+		goto err;
+	}
+
+	err = dd->audio_config(dd->core, dd->wp, &dd->dss_audio,
+			       dd->cfg->timings.pixelclock);
+err:
+	mutex_unlock(dd->hdmi_lock);
+	return err;
+}
+
+static int hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *dd = snd_soc_dai_get_drvdata(dai);
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		err = dd->audio_start(dd->core, dd->wp);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dd->audio_start(dd->core, dd->wp);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
+}
+
+static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *dd = snd_soc_dai_get_drvdata(dai);
+
+	hdmi_wp_audio_enable(dd->wp, false);
+}
+
+static const struct snd_soc_dai_ops hdmi_dai_ops = {
+	.startup	= hdmi_dai_startup,
+	.hw_params	= hdmi_dai_hw_params,
+	.prepare	= hdmi_dai_prepare,
+	.trigger	= hdmi_dai_trigger,
+	.shutdown	= hdmi_dai_shutdown,
+};
+
+static const struct snd_soc_component_driver omap_hdmi_component = {
+	.name = "omapdss_hdmi",
+};
+
+static struct asoc_simple_card_info card_info = {
+	.name = "HDMI",
+	.card = "OMAPHDMI",
+	.codec_dai.name = "hdmi-hifi",
+};
+
+int hdmi_audio_register(struct platform_device *pdev)
+{
+	struct hdmi_audio_data *dd = dev_get_drvdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	dd->dma_data.addr = hdmi_wp_get_phys_addr(dd->wp) + HDMI_WP_AUDIO_DATA;
+	dd->dma_data.filter_data = "audio_tx";
+	dd->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dd->hdmi_dai_drv->ops = &hdmi_dai_ops,
+
+	ret = snd_soc_register_component(dev, &omap_hdmi_component,
+					 dd->hdmi_dai_drv, 1);
+	if (ret)
+		return ret;
+
+	ret = omap_pcm_platform_register(dev);
+	if (ret)
+		return ret;
+
+	dd->codec_pdev = platform_device_register_data(dev, "hdmi-audio-codec",
+						       0, NULL, 0);
+	if (IS_ERR(dd->codec_pdev)) {
+		snd_soc_unregister_component(dev);
+		return PTR_ERR(dd->codec_pdev);
+	}
+
+	card_info.cpu_dai.name = dev_name(dev);
+	card_info.platform = dev_name(dev);
+	card_info.codec = dev_name(&dd->codec_pdev->dev);
+
+	dd->card_pdev =
+		platform_device_register_data(dev, "asoc-simple-card", 0,
+					      &card_info, sizeof(card_info));
+	if (IS_ERR(dd->card_pdev)) {
+		snd_soc_unregister_component(dev);
+		platform_device_unregister(dd->codec_pdev);
+		return PTR_ERR(dd->card_pdev);
+	}
+	return 0;
+}
+
+void hdmi_audio_unregister(struct platform_device *pdev)
+{
+	struct hdmi_audio_data *dd = dev_get_drvdata(&pdev->dev);
+
+	platform_device_unregister(dd->card_pdev);
+	platform_device_unregister(dd->codec_pdev);
+	snd_soc_unregister_component(&pdev->dev);
+}
-- 
1.7.9.5

