From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 11/15] OMAPDSS: hdmi5: Register HDMI audio with omap_hdmi_audio_register()
Date: Mon, 25 Aug 2014 22:04:19 +0300
Message-ID: <43625eb6a15dceb8c674a53dadd819fbd91b0671.1408993242.git.jsarha@ti.com>
References: <cover.1408993242.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45688 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933376AbaHYTEr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2014 15:04:47 -0400
In-Reply-To: <cover.1408993242.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Implements callbacks for OMAP HDMI audio library and registers
HDMI audio support with omap_hdmi_audio_register()-call.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c |   83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 90410f5..3ed7085 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -38,6 +38,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-audio.h>
 
 #include "hdmi5_core.h"
 #include "dss.h"
@@ -679,6 +680,78 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+static int mode_has_audio(struct device *dev)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&hd->lock);
+	ret = hdmi_mode_has_audio(&hd->cfg);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int audio_enable(struct device *dev, bool enable)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&hd->lock);
+	if (!hdmi_mode_has_audio(&hd->cfg))
+		ret = -EPERM;
+	else
+		ret = hdmi_wp_audio_enable(&hd->wp, enable);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int audio_start(struct device *dev, bool enable)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	return hdmi_wp_audio_core_req_enable(&hd->wp, enable);
+}
+
+static int audio_config(struct device *dev, struct omap_dss_audio *dss_audio)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&hd->lock);
+	if (!hdmi_mode_has_audio(&hd->cfg))
+		ret = -EPERM;
+	else
+		ret = hdmi5_audio_config(&hd->core, &hd->wp, dss_audio,
+					 hd->cfg.timings.pixelclock);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int hdmi_audio_register(struct device *dev)
+{
+	struct omap_hdmi_audio ha = {
+		.dev = dev,
+		.hw_version = OMAP5_HDMI,
+		.audio_dma_addr = hdmi_wp_get_audio_dma_addr(&hdmi.wp),
+		.mode_has_audio = mode_has_audio,
+		.audio_enable = audio_enable,
+		.audio_start = audio_start,
+		.audio_config = audio_config,
+	};
+
+	return omap_hdmi_audio_register(&ha);
+}
+#else /* CONFIG_OMAP5_DSS_HDMI_AUDIO */
+static int hdmi_audio_register(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -736,6 +809,14 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+	r = hdmi_audio_register(&pdev->dev);
+	if (r) {
+		DSSERR("Registering HDMI audio failed\n");
+		hdmi_uninit_output(pdev);
+		pm_runtime_disable(&pdev->dev);
+		return r;
+	}
+
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
@@ -743,6 +824,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+	omap_hdmi_audio_unregister(&pdev->dev);
+
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

