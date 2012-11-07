From: Archit Taneja <archit@ti.com>
Subject: [RFC 06/11] OMAPDSS: APPLY: configure channel_in for writeback
Date: Wed, 7 Nov 2012 20:14:24 +0530
Message-ID: <1352299469-17609-7-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794Ab2KGOpK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:45:10 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

writeback's input is configured by the CHANNELIN field in DISPC_WB_ATTRIBUTES.
It's an immediate write register field. We need to change writeback's channel
in whenever the manager to which it is connected changes.

When changing managers for overlays, we needed to be certain that the overlay
was disabled. We added some extra waits for that. However, such a thing isn't
required for writeback as it's disabled for sure after we call dss_wb_disable.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   31 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h       |    9 +++++++++
 drivers/video/omap2/dss/writeback.c |   23 +++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 1ab1755..a205ed4 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1175,6 +1175,22 @@ int dss_mgr_set_output(struct omap_overlay_manager *mgr,
 		goto err;
 	}
 
+	if (output_is_wb(output)) {
+		enum dss_writeback_channel channel;
+
+		r = dss_writeback_calc_channel_in(mgr, &channel);
+		if (r)
+			goto err;
+
+		r = dispc_runtime_get();
+		if (r)
+			goto err;
+
+		dispc_wb_set_channel_in(channel);
+
+		dispc_runtime_put();
+	}
+
 	output->manager = mgr;
 	mgr->output = output;
 
@@ -1210,6 +1226,21 @@ int dss_mgr_unset_output(struct omap_overlay_manager *mgr)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	if (output_is_wb(mgr->output)) {
+		struct omap_dss_output *wb = mgr->output;
+		struct wb_priv_data *wp = get_wb_priv(wb);
+
+		spin_lock_irqsave(&data_lock, flags);
+
+		if (wp->enabled) {
+			DSSERR("WB output can't be unset when enabled\n");
+			r = -EINVAL;
+			goto err1;
+		}
+
+		spin_unlock_irqrestore(&data_lock, flags);
+	}
+
 	mgr->output->manager = NULL;
 	mgr->output = NULL;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6238895..f9e7074 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -540,6 +540,15 @@ int hdmi_audio_config(struct omap_dss_audio *audio);
 #ifdef CONFIG_OMAP4_DSS_WRITEBACK
 int writeback_init_platform_driver(void) __init;
 void writeback_uninit_platform_driver(void) __exit;
+int dss_writeback_calc_channel_in(struct omap_overlay_manager *mgr,
+		enum dss_writeback_channel *channel);
+#else
+static inline int dss_writeback_calc_channel_in(struct omap_overlay_manager *mgr,
+		enum dss_writeback_channel *channel)
+{
+	WARN("%s: WB not compiled in, returning 0\n", __func__);
+	return 0;
+}
 #endif
 
 /* RFBI */
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 598defd..09394fb 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -48,6 +48,29 @@ static inline struct platform_device *writeback_get_wbdev_from_output(struct oma
 	return out->pdev;
 }
 
+int dss_writeback_calc_channel_in(struct omap_overlay_manager *mgr,
+		enum dss_writeback_channel *channel)
+{
+	/*
+	 * Add a case for dummy writeback manager once we support connecting
+	 * writeback directly to an overlay.
+	 */
+	switch (mgr->id) {
+	case OMAP_DSS_CHANNEL_DIGIT:
+		*channel = DSS_WB_TV_MGR;
+		break;
+	case OMAP_DSS_CHANNEL_LCD2:
+		*channel = DSS_WB_LCD2_MGR;
+		break;
+	case OMAP_DSS_CHANNEL_LCD:
+	default:
+		*channel = DSS_WB_LCD1_MGR;
+		break;
+	}
+
+	return 0;
+}
+
 void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h)
 {
 	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
-- 
1.7.9.5

