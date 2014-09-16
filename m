From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 07/15] ASoC: omap-hdmi-audio: Add platfrom device for OMAP HDMI audio support
Date: Tue, 16 Sep 2014 13:04:21 +0300
Message-ID: <dc0f53a805a3e63e704c563219270c73e0a30392.1410860765.git.jsarha@ti.com>
References: <cover.1410860765.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44111 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723AbaIPKEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 06:04:52 -0400
In-Reply-To: <cover.1410860765.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The platform device should only be registered from OMAPDSS HDMI
driver. The platfrom driver registers and unregisters all ASoC
components needed for OMAP HDMI audio.

The hdmi audio driver implements cpu-dai component using the callbacks
provided by OMAPDSS. Omap-pcm is registered for platform component,
dummy hdmi-audio-codec is registered for codec component, and
asoc-simple-card is registered for machine driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/omap-hdmi-audio.h  |   38 ++++
 sound/soc/omap/Kconfig           |   11 ++
 sound/soc/omap/Makefile          |    2 +
 sound/soc/omap/omap-hdmi-audio.c |  379 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 include/sound/omap-hdmi-audio.h
 create mode 100644 sound/soc/omap/omap-hdmi-audio.c

diff --git a/include/sound/omap-hdmi-audio.h b/include/sound/omap-hdmi-audio.h
new file mode 100644
index 0000000..6c1638c
--- /dev/null
+++ b/include/sound/omap-hdmi-audio.h
@@ -0,0 +1,38 @@
+/*
+ * hdmi-audio.c -- OMAP4+ DSS HDMI audio support library
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <video/omapdss.h>
+
+#ifndef __OMAP_HDMI_AUDIO_H__
+#define __OMAP_HDMI_AUDIO_H__
+
+/* HDMI audio initalization data */
+struct omap_hdmi_audio_pdata {
+	struct device *dev;
+	enum { OMAP4_HDMI, OMAP5_HDMI } hw_version;
+	phys_addr_t audio_dma_addr;
+	unsigned int audio_dma_req;
+
+	int (*mode_has_audio)(struct device *dev);
+	int (*audio_enable)(struct device *dev, bool enable);
+	int (*audio_start)(struct device *dev, bool enable);
+	int (*audio_config)(struct device *dev,
+			    struct omap_dss_audio *dss_audio);
+};
+
+#endif /* __OMAP_HDMI_AUDIO_H__ */
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index d44463a..66eb428 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -15,6 +15,17 @@ config SND_OMAP_SOC_MCPDM
 config SND_OMAP_SOC_HDMI
 	tristate
 
+config SND_OMAP_SOC_HDMI_AUDIO
+	tristate "HDMI audio support for OMAP4+ based SoCs"
+	depends on SND_OMAP_SOC
+	select SND_SOC_HDMI_CODEC
+	select SND_SIMPLE_CARD
+	help
+	  The driver implements an integrated ASoC Digital Audio
+	  Interface component driver and registers a dummy HDMI codec
+	  and asoc-simple-card for full HDMI audio support. OMAPDSS
+	  HDMI video needs to be enabled too for working HDMI audio.
+
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index a725905..40688a6 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -4,12 +4,14 @@ snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-objs := omap-hdmi.o
+snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
 obj-$(CONFIG_SND_OMAP_SOC_HDMI) += snd-soc-omap-hdmi.o
+obj-$(CONFIG_SND_OMAP_SOC_HDMI_AUDIO) += snd-soc-omap-hdmi-audio.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
new file mode 100644
index 0000000..4614dce
--- /dev/null
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -0,0 +1,379 @@
+/*
+ * omap-hdmi-audio.c -- OMAP4+ DSS HDMI audio support library
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
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
+#include <sound/omap-hdmi-audio.h>
+#include <video/omapdss.h>
+
+#include <sound/simple_card.h>
+
+#define DRV_NAME "omap-hdmi-audio"
+
+struct hdmi_audio_data {
+	int (*mode_has_audio)(struct device *dev);
+	int (*audio_enable)(struct device *dev, bool enable);
+	int (*audio_start)(struct device *dev, bool enable);
+	int (*audio_config)(struct device *dev,
+			    struct omap_dss_audio *dss_audio);
+
+	struct device *dssdev;
+	struct snd_dmaengine_dai_dma_data dma_data;
+	unsigned int dma_req;
+	struct omap_dss_audio dss_audio;
+	struct snd_aes_iec958 iec;
+	struct snd_cea_861_aud_if cea;
+	struct platform_device *codec_pdev;
+	struct platform_device *card_pdev;
+};
+
+static int hdmi_dai_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *ad = snd_soc_dai_get_drvdata(dai);
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
+	if (!ad->mode_has_audio(ad->dssdev)) {
+		dev_err(dai->dev, "audio not supported\n");
+		return -ENODEV;
+	}
+
+	snd_soc_dai_set_dma_data(dai, substream, &ad->dma_data);
+
+	return 0;
+}
+
+static int hdmi_dai_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *ad = snd_soc_dai_get_drvdata(dai);
+
+	return ad->audio_enable(ad->dssdev, true);
+}
+
+static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *ad = snd_soc_dai_get_drvdata(dai);
+	struct snd_aes_iec958 *iec = &ad->iec;
+	struct snd_cea_861_aud_if *cea = &ad->cea;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		ad->dma_data.maxburst = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		ad->dma_data.maxburst = 32;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
+
+	ad->dss_audio.iec = iec;
+	ad->dss_audio.cea = cea;
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
+	return ad->audio_config(ad->dssdev, &ad->dss_audio);
+}
+
+static int hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_data *ad = snd_soc_dai_get_drvdata(dai);
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		err = ad->audio_start(ad->dssdev, true);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ad->audio_start(ad->dssdev, false);
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
+	struct hdmi_audio_data *ad = snd_soc_dai_get_drvdata(dai);
+
+	ad->audio_enable(ad->dssdev, false);
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
+static struct snd_soc_dai_driver omap5_hdmi_dai = {
+	.name = "omap5-hdmi-dai",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &hdmi_dai_ops,
+};
+
+static struct snd_soc_dai_driver omap4_hdmi_dai = {
+	.name = "omap4-hdmi-dai",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &hdmi_dai_ops,
+};
+
+static int omap_hdmi_audio_probe(struct platform_device *pdev)
+{
+	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct hdmi_audio_data *ad;
+	struct snd_soc_dai_driver *dai_drv;
+	struct asoc_simple_card_info card_info = {
+		.codec_dai.name = "hdmi-hifi",
+	};
+	char nametmp[64];
+	int ret;
+
+	if (!ha) {
+		dev_err(dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	ad = devm_kzalloc(dev, sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		return -ENOMEM;
+	ad->dssdev = ha->dev;
+	ad->mode_has_audio = ha->mode_has_audio;
+	ad->audio_enable = ha->audio_enable;
+	ad->audio_start = ha->audio_start;
+	ad->audio_config = ha->audio_config;
+	ad->dma_req = ha->audio_dma_req;
+	ad->dma_data.addr = ha->audio_dma_addr;
+	ad->dma_data.filter_data = &ad->dma_req;
+	ad->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	if (ha->hw_version == OMAP5_HDMI)
+		dai_drv = &omap5_hdmi_dai;
+	else
+		dai_drv = &omap4_hdmi_dai;
+
+	ret = snd_soc_register_component(dev, &omap_hdmi_component,
+					 dai_drv, 1);
+	if (ret)
+		return ret;
+
+	ret = omap_pcm_platform_register(dev);
+	if (ret)
+		return ret;
+
+	ad->codec_pdev = platform_device_register_data(
+		dev, "hdmi-audio-codec", 0, NULL, 0);
+
+	if (IS_ERR(ad->codec_pdev)) {
+		snd_soc_unregister_component(dev);
+		return PTR_ERR(ad->codec_pdev);
+	}
+
+	snprintf(nametmp, sizeof(nametmp), "HDMI %s", dev_name(dev));
+	card_info.name = devm_kstrdup(dev, nametmp, GFP_KERNEL);
+	card_info.card = card_info.name;
+	card_info.cpu_dai.name = dev_name(dev);
+	card_info.platform = dev_name(dev);
+	card_info.codec = dev_name(&ad->codec_pdev->dev);
+
+	ad->card_pdev =
+		platform_device_register_data(dev, "asoc-simple-card", 0,
+					      &card_info, sizeof(card_info));
+	if (IS_ERR(ad->card_pdev)) {
+		snd_soc_unregister_component(dev);
+		platform_device_unregister(ad->codec_pdev);
+		return PTR_ERR(ad->card_pdev);
+	}
+
+	dev_set_drvdata(dev, ad);
+
+	return 0;
+}
+
+static int omap_hdmi_audio_remove(struct platform_device *pdev)
+{
+	struct hdmi_audio_data *ad = platform_get_drvdata(pdev);
+
+	platform_device_unregister(ad->card_pdev);
+	platform_device_unregister(ad->codec_pdev);
+	snd_soc_unregister_component(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver hdmi_audio_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = omap_hdmi_audio_probe,
+	.remove = omap_hdmi_audio_remove,
+};
+
+module_platform_driver(hdmi_audio_driver);
+
+MODULE_AUTHOR("Jyri Sarha <jsarha@ti.com>");
+MODULE_DESCRIPTION("OMAP HDMI Audio Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.9.5

