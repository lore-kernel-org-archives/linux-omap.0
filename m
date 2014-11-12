From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 01/20] OMAPDSS: hdmi_wp: Protect reserved bits in hdmi_wp_audio_config_format()
Date: Wed, 12 Nov 2014 12:49:03 +0200
Message-ID: <97e78fc41195719e4423d2aedf1b90b4740379c7.1415786458.git.jsarha@ti.com>
References: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbaKLKtg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 05:49:36 -0500
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Only OMAP4 DSS has non reserved bits above 6th bit in HDMI_WP_AUDIO_CFG.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index 496327e..71b499e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -194,8 +194,12 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
 	DSSDBG("Enter hdmi_wp_audio_config_format\n");
 
 	r = hdmi_read_reg(wp->base, HDMI_WP_AUDIO_CFG);
-	r = FLD_MOD(r, aud_fmt->stereo_channels, 26, 24);
-	r = FLD_MOD(r, aud_fmt->active_chnnls_msk, 23, 16);
+	if (omapdss_get_version() == OMAPDSS_VER_OMAP4430_ES1 ||
+	    omapdss_get_version() == OMAPDSS_VER_OMAP4430_ES2 ||
+	    omapdss_get_version() == OMAPDSS_VER_OMAP4) {
+		r = FLD_MOD(r, aud_fmt->stereo_channels, 26, 24);
+		r = FLD_MOD(r, aud_fmt->active_chnnls_msk, 23, 16);
+	}
 	r = FLD_MOD(r, aud_fmt->en_sig_blk_strt_end, 5, 5);
 	r = FLD_MOD(r, aud_fmt->type, 4, 4);
 	r = FLD_MOD(r, aud_fmt->justification, 3, 3);
-- 
1.7.9.5

