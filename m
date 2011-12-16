From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle when playing audio
Date: Fri, 16 Dec 2011 01:03:52 -0600
Message-ID: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab1LPHEP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:04:15 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG74EhT023194
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:04:14 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

When playing audio through HDMI, the module should be put in
no-idle mode. This is to prevent the DSS_L3_ICLK to be shut down.
Once audio playback is stopped, the module is set back to smart-idle
wakeup-capable.

Also, a omap_hwmod structure is added to hdmi_ip_data to have access
to idle-mode configuration.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c    |   13 +++++++++++++
 drivers/video/omap2/dss/ti_hdmi.h |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 5c93041..e177338 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -35,6 +35,7 @@
 #include <video/omapdss.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#include <plat/omap_hwmod.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include "ti_hdmi_4xxx_ip.h"
@@ -572,12 +573,16 @@ int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		omap_hwmod_set_slave_idlemode(ip_data->oh,
+			HWMOD_IDLEMODE_NO);
 		ip_data->ops->audio_enable(ip_data, true);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ip_data->ops->audio_enable(ip_data, false);
+		omap_hwmod_set_slave_idlemode(ip_data->oh,
+			HWMOD_IDLEMODE_SMART_WKUP);
 		break;
 	default:
 		err = -EINVAL;
@@ -733,8 +738,16 @@ static int hdmi_audio_startup(struct snd_pcm_substream *substream,
 
 static int hdmi_audio_codec_probe(struct snd_soc_codec *codec)
 {
+	struct platform_device *pdev = to_platform_device(codec->dev);
 	struct hdmi_ip_data *priv = &hdmi.ip_data;
 
+	priv->oh = omap_hwmod_lookup("dss_hdmi");
+
+	if (!priv->oh) {
+		dev_err(&pdev->dev, "Cannot find omap_hwmod for hdmi\n");
+		return -ENODEV;
+	}
+
 	snd_soc_codec_set_drvdata(codec, priv);
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 7503f7f..5ef3cb1 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -126,6 +126,10 @@ struct hdmi_ip_data {
 	const struct ti_hdmi_ip_ops *ops;
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	struct omap_hwmod *oh;
+#endif
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
-- 
1.7.0.4

