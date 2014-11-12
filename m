From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 20/20] OMAPDSS: hdmi5: Change hdmi_wp idlemode to to no_idle for audio playback
Date: Wed, 12 Nov 2014 12:49:22 +0200
Message-ID: <cab1610d065e20f519c71f201812ac978520cc9e.1415786458.git.jsarha@ti.com>
References: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36357 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbaKLKt6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 05:49:58 -0500
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h  |    1 +
 drivers/video/fbdev/omap2/dss/hdmi5.c |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index bfaaf2f..f991dbf 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -372,6 +372,7 @@ struct omap_hdmi {
 
 	struct platform_device *audio_pdev;
 	void (*audio_abort_cb)(struct device *dev);
+	int wp_idlemode;
 };
 
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index feb76e2..c91685e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -614,6 +614,10 @@ static int hdmi_audio_start(struct device *dev)
 	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
 	WARN_ON(!hd->display_enabled);
 
+	/* No-idle while playing audio, store the old value */
+	hd->wp_idlemode = REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
+	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
+
 	hdmi_wp_audio_enable(&hd->wp, true);
 	hdmi_wp_audio_core_req_enable(&hd->wp, true);
 
@@ -629,6 +633,9 @@ static void hdmi_audio_stop(struct device *dev)
 
 	hdmi_wp_audio_core_req_enable(&hd->wp, false);
 	hdmi_wp_audio_enable(&hd->wp, false);
+
+	/* Playback stopped, restore original idlemode */
+	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, hd->wp_idlemode, 3, 2);
 }
 
 static int hdmi_audio_config(struct device *dev,
-- 
1.7.9.5

