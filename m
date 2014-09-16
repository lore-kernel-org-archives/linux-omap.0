From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 10/15] OMAPDSS: hdmi4: Register ASoC platfrom device for omap hdmi audio
Date: Tue, 16 Sep 2014 13:04:24 +0300
Message-ID: <6a127d68e305161aa8da7f776c860eab64835aaa.1410860765.git.jsarha@ti.com>
References: <cover.1410860765.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44827 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbaIPKEy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 06:04:54 -0400
In-Reply-To: <cover.1410860765.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Implements callbacks for OMAP HDMI audio platform driver and registers
it in probe function. Unregistering is done in remove function.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |  103 +++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index b98186e..2e87229 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-audio.h>
 
 #include "hdmi4_core.h"
 #include "dss.h"
@@ -655,6 +656,97 @@ err:
 	return r;
 }
 
+/* Audio callbacks */
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
+	int ret = 0;
+
+	if (enable)
+		ret = hdmi4_audio_start(&hd->core, &hd->wp);
+	else
+		hdmi4_audio_stop(&hd->core, &hd->wp);
+
+	return ret;
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
+		ret = hdmi4_audio_config(&hd->core, &hd->wp, dss_audio,
+					 hd->cfg.timings.pixelclock);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int hdmi_audio_register(struct device *dev)
+{
+	struct omap_hdmi_audio_pdata pdata = {
+		.dev = dev,
+		.hw_version = OMAP4_HDMI,
+		.audio_dma_addr = hdmi_wp_get_audio_dma_addr(&hdmi.wp),
+		.mode_has_audio = mode_has_audio,
+		.audio_enable = audio_enable,
+		.audio_start = audio_start,
+		.audio_config = audio_config,
+	};
+	struct of_phandle_args dma_spec;
+	int ret;
+
+	ret = of_property_match_string(dev->of_node, "dma-names", "audio_tx");
+	if (ret < 0)
+		return ret;
+
+	ret = of_parse_phandle_with_args(dev->of_node, "dmas", "#dma-cells",
+					 ret, &dma_spec);
+	if (ret < 0)
+		return ret;
+
+	pdata.audio_dma_req = dma_spec.args[0];
+
+	hdmi.audio_pdev =
+		platform_device_register_data(dev, "omap-hdmi-audio", 0,
+					      &pdata, sizeof(pdata));
+	if (IS_ERR(hdmi.audio_pdev))
+		return PTR_ERR(hdmi.audio_pdev);
+
+	return 0;
+}
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -712,6 +804,14 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
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
@@ -719,6 +819,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+	if (hdmi.audio_pdev)
+		platform_device_unregister(hdmi.audio_pdev);
+
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

