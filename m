From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 09/19] OMAPDSS: hdmi5: Integrated ASoC DAI component driver implementation
Date: Mon, 12 May 2014 12:12:20 +0300
Message-ID: <7042e536e85c478cdc1b63a3adbf373ec78d548e.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaELJMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:12:55 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Integrate ASoC DAI component driver in to the OMAP5 hdmi driver. The
patch also updates the relevant entry in ti,omap5-dss DT binding
document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/video/ti,omap5-dss.txt     |    4 +
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  199 ++++++++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/ti,omap5-dss.txt b/Documentation/devicetree/bindings/video/ti,omap5-dss.txt
index 38ffc8f..795f5cf 100644
--- a/Documentation/devicetree/bindings/video/ti,omap5-dss.txt
+++ b/Documentation/devicetree/bindings/video/ti,omap5-dss.txt
@@ -88,6 +88,10 @@ Required properties:
 - clocks: handles to fclk and pll clock
 - clock-names: "fck", "sys_clk"
 
+Required properties if hdmi audio support is enabled:
+- dmas: DMA controller phandle for HDMI audio output
+- dma-names: "audio_tx"
+
 Optional nodes:
 - Video port for HDMI output
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 49a85c9..c6a8862 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -39,6 +39,16 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+#include <linux/dmaengine.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <uapi/sound/asound.h>
+#include <sound/asoundef.h>
+#include <sound/omap-pcm.h>
+#endif
+
 #include "hdmi5_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -57,6 +67,13 @@ static struct {
 	struct clk *sys_clk;
 	struct regulator *vdda_reg;
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	struct snd_dmaengine_dai_dma_data dma_data;
+	struct omap_dss_audio dss_audio;
+	struct snd_aes_iec958 iec;
+	struct snd_cea_861_aud_if cea;
+#endif
+
 	bool core_enabled;
 
 	struct omap_dss_device output;
@@ -534,6 +551,182 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev,
 	return r;
 }
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+static int hdmi_dai_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
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
+	mutex_lock(&hdmi.lock);
+	ret = hdmi_mode_has_audio(hdmi.cfg.cm.mode);
+	mutex_unlock(&hdmi.lock);
+	if (!ret) {
+		dev_err(dai->dev, "audio not supported\n");
+		return -ENODEV;
+	}
+
+	snd_soc_dai_set_dma_data(dai, substream, &hdmi.dma_data);
+
+	return 0;
+}
+
+static int hdmi_dai_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_wp_audio_enable(&hdmi.wp, true);
+
+err:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
+{
+	int err;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		hdmi.dma_data.maxburst = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		hdmi.dma_data.maxburst = 32;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
+
+	hdmi.dss_audio.iec = &hdmi.iec;
+	hdmi.dss_audio.cea = &hdmi.cea;
+	err = hdmi_dss_audio_from_hw_params(params, &hdmi.dss_audio, dai);
+	if (err)
+		return err;
+
+	mutex_lock(&hdmi.lock);
+
+	if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
+		err = -EPERM;
+		goto err;
+	}
+
+	err = hdmi5_audio_config(&hdmi.core, &hdmi.wp, &hdmi.dss_audio,
+				 hdmi.cfg.timings.pixelclock);
+err:
+	mutex_unlock(&hdmi.lock);
+	return err;
+}
+
+static int hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		err = hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
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
+	hdmi_wp_audio_enable(&hdmi.wp, false);
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
+static struct snd_soc_dai_driver omap_hdmi_dai = {
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
+static const struct snd_soc_component_driver omap_hdmi_component = {
+	.name = "omapdss_hdmi",
+};
+
+static int hdmi_audio_init(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wp");
+	if (!res) {
+		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM l4\n");
+		return -ENODEV;
+	}
+	hdmi.dma_data.addr = res->start + HDMI_WP_AUDIO_DATA;
+	hdmi.dma_data.filter_data = "audio_tx";
+	hdmi.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
+					 &omap_hdmi_dai, 1);
+	if (ret)
+		return ret;
+
+	return omap_pcm_platform_register(&pdev->dev);
+}
+
+static void hdmi_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+}
+
+#else
+static int hdmi_audio_init(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static void hdmi_audio_remove(struct platform_device *pdev)
+{
+}
+#endif
+
 static const struct omapdss_hdmi_ops hdmi_ops = {
 	.connect		= hdmi_connect,
 	.disconnect		= hdmi_disconnect,
@@ -644,6 +837,10 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 		return r;
 	}
 
+	r = hdmi_audio_init(pdev);
+	if (r)
+		return r;
+
 	pm_runtime_enable(&pdev->dev);
 
 	hdmi_init_output(pdev);
@@ -657,6 +854,8 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_uninit_output(pdev);
 
+	hdmi_audio_remove(pdev);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.9.5

