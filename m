From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 3/5] OMAPDSS: HDMI5: Fix AUDICONF3 bitfield offsets
Date: Wed, 22 Apr 2015 16:22:59 +0300
Message-ID: <5f42c5eb8dda56f4351f3e1292841243ee38e3dc.1429705991.git.jsarha@ti.com>
References: <cover.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39837 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102AbbDVNX0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 09:23:26 -0400
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

Downmix inhibit in HDMI_CORE_FC_AUDICONF3 register is in
bit 4 while CEA861_AUDIO_INFOFRAME_DB5_DM_INH sets bit 7.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index 7a80beb..c3286bd 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -790,7 +790,9 @@ static void hdmi5_core_audio_infoframe_cfg(struct hdmi_core_data *core,
 
 	hdmi_write_reg(base, HDMI_CORE_FC_AUDICONF1, info_aud->db2_sf_ss);
 	hdmi_write_reg(base, HDMI_CORE_FC_AUDICONF2, info_aud->db4_ca);
-	hdmi_write_reg(base, HDMI_CORE_FC_AUDICONF3, info_aud->db5_dminh_lsv);
+	hdmi_write_reg(base, HDMI_CORE_FC_AUDICONF3,
+	  (info_aud->db5_dminh_lsv & CEA861_AUDIO_INFOFRAME_DB5_DM_INH) >> 3 |
+	  (info_aud->db5_dminh_lsv & CEA861_AUDIO_INFOFRAME_DB5_LSV));
 }
 
 int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
-- 
1.9.1

