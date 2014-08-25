From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 06/15] OMAPDSS: hdmi: Add exported functions for storing HDMI audio data
Date: Mon, 25 Aug 2014 22:04:14 +0300
Message-ID: <8b3df1c82d3de4f3c81e15e8973f4e194ce89788.1408993242.git.jsarha@ti.com>
References: <cover.1408993242.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42389 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933365AbaHYTEm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2014 15:04:42 -0400
In-Reply-To: <cover.1408993242.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Implements omapdss_hdmi_get_audio_data() and omapdss_hdmi_set_audio_data()
for storing HDMI audio data in OMAPDSS HDMI drvdata.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h        |    2 ++
 drivers/video/fbdev/omap2/dss/hdmi_common.c |   16 ++++++++++++++++
 include/video/omapdss.h                     |    3 +++
 3 files changed, 21 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6bf077b..c357057 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -368,6 +368,8 @@ struct omap_hdmi {
 	bool core_enabled;
 
 	struct omap_dss_device output;
+
+	void *audio_data;
 };
 
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 1b8fcc6..318e754 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -146,3 +146,19 @@ int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+void *omapdss_hdmi_get_audio_data(struct device *dev)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	return hd->audio_data;
+}
+EXPORT_SYMBOL_GPL(omapdss_hdmi_get_audio_data);
+
+void omapdss_hdmi_set_audio_data(struct device *dev, void *data)
+{
+	struct omap_hdmi *hd = dev_get_drvdata(dev);
+
+	hd->audio_data = data;
+}
+EXPORT_SYMBOL_GPL(omapdss_hdmi_set_audio_data);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 069dfca..46f4984 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -1039,4 +1039,7 @@ omapdss_of_get_first_endpoint(const struct device_node *parent);
 struct omap_dss_device *
 omapdss_of_find_source_for_first_ep(struct device_node *node);
 
+void *omapdss_hdmi_get_audio_data(struct device *dev);
+void omapdss_hdmi_set_audio_data(struct device *dev, void *data);
+
 #endif
-- 
1.7.9.5

