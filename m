From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 14/18] OMAPDSS: hdmi4: Register ASoC platfrom device for omap hdmi audio
Date: Tue, 14 Oct 2014 20:29:33 +0300
Message-ID: <a7ec4492260b8ae30703669628572196ddd041da.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44343 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199AbaJNRaL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 13:30:11 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Implements callbacks for OMAP HDMI audio platform driver and registers
it in probe function. Unregistering is done in remove function.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |  124 +++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 4c671ee..fbb17b3 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-audio.h>
 
 #include "hdmi4_core.h"
 #include "dss.h"
@@ -336,6 +337,8 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	hdmi.display_enabled = true;
+
 	mutex_unlock(&hdmi.lock);
 	return 0;
 
@@ -350,8 +353,13 @@ static void hdmi_display_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&hdmi.lock);
 
+	if (hdmi.audio_pdev && hdmi.audio_abort_cb)
+		hdmi.audio_abort_cb(&hdmi.audio_pdev->dev);
+
 	hdmi_power_off_full(dssdev);
 
+	hdmi.display_enabled = false;
+
 	mutex_unlock(&hdmi.lock);
 }
 
@@ -542,6 +550,111 @@ err:
 	return r;
 }
 
+/* Audio callbacks */
+static int hdmi_audio_startup(struct device *dev,
+			      void (*abort_cb)(struct device *dev))
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	int ret = 0;
+
+	mutex_lock(&hd->lock);
+
+	if (!hdmi_mode_has_audio(&hd->cfg) || !hd->display_enabled) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	hd->audio_abort_cb = abort_cb;
+
+out:
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int hdmi_audio_shutdown(struct device *dev)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->lock);
+	hd->audio_abort_cb = NULL;
+	mutex_unlock(&hd->lock);
+
+	return 0;
+}
+
+static int hdmi_audio_start(struct device *dev)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
+	WARN_ON(!hd->display_enabled);
+
+	hdmi_wp_audio_enable(&hd->wp, true);
+	hdmi4_audio_start(&hd->core, &hd->wp);
+
+	return 0;
+}
+
+static void hdmi_audio_stop(struct device *dev)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
+	WARN_ON(!hd->display_enabled);
+
+	hdmi4_audio_stop(&hd->core, &hd->wp);
+	hdmi_wp_audio_enable(&hd->wp, false);
+}
+
+static int hdmi_audio_config(struct device *dev,
+			     struct omap_dss_audio *dss_audio)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&hd->lock);
+
+	if (!hdmi_mode_has_audio(&hd->cfg) || !hd->display_enabled) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	ret = hdmi4_audio_config(&hd->core, &hd->wp, dss_audio,
+				 hd->cfg.timings.pixelclock);
+
+out:
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static const struct omap_hdmi_audio_ops hdmi_audio_ops = {
+	.audio_startup = hdmi_audio_startup,
+	.audio_shutdown = hdmi_audio_shutdown,
+	.audio_start = hdmi_audio_start,
+	.audio_stop = hdmi_audio_stop,
+	.audio_config = hdmi_audio_config,
+};
+
+static int hdmi_audio_register(struct device *dev)
+{
+	struct omap_hdmi_audio_pdata pdata = {
+		.dev = dev,
+		.dss_version = omapdss_get_version(),
+		.audio_dma_addr = hdmi_wp_get_audio_dma_addr(&hdmi.wp),
+		.ops = &hdmi_audio_ops,
+	};
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
@@ -599,6 +712,14 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
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
@@ -606,6 +727,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+	if (hdmi.audio_pdev)
+		platform_device_unregister(hdmi.audio_pdev);
+
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

