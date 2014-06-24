From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/15] OMAPDSS: HDMI4: use common AVI infoframe support
Date: Tue, 24 Jun 2014 13:03:51 +0300
Message-ID: <1403604240-16738-7-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46989 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbaFXKES (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:18 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using OMAP specific AVI infoframe structs, use the common one
from include/linux/hdmi.h.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h       |   2 +
 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 136 ++++++-----------------------
 drivers/video/fbdev/omap2/dss/hdmi4_core.h |   1 +
 3 files changed, 28 insertions(+), 111 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 1a62dc3fe54e..6cd4a755b0ac 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/hdmi.h>
 #include <video/omapdss.h>
 
 #include "dss.h"
@@ -360,6 +361,7 @@ struct hdmi_core_data {
 	void __iomem *base;
 
 	struct hdmi_core_infoframe_avi avi_cfg;
+	struct hdmi_avi_infoframe avi_infoframe;
 };
 
 static inline void hdmi_write_reg(void __iomem *base_addr, const u32 idx,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 8bde7b7e95ff..dbdbc5836d51 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -198,7 +198,6 @@ int hdmi4_read_edid(struct hdmi_core_data *core, u8 *edid, int len)
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-			struct hdmi_core_infoframe_avi *avi_cfg,
 			struct hdmi_core_packet_enable_repeat *repeat_cfg)
 {
 	DSSDBG("Enter hdmi_core_init\n");
@@ -211,25 +210,6 @@ static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
 	video_cfg->hdmi_dvi = HDMI_DVI;
 	video_cfg->tclk_sel_clkmult = HDMI_FPLL10IDCK;
 
-	/* info frame */
-	avi_cfg->db1_format = 0;
-	avi_cfg->db1_active_info = 0;
-	avi_cfg->db1_bar_info_dv = 0;
-	avi_cfg->db1_scan_info = 0;
-	avi_cfg->db2_colorimetry = 0;
-	avi_cfg->db2_aspect_ratio = 0;
-	avi_cfg->db2_active_fmt_ar = 0;
-	avi_cfg->db3_itc = 0;
-	avi_cfg->db3_ec = 0;
-	avi_cfg->db3_q_range = 0;
-	avi_cfg->db3_nup_scaling = 0;
-	avi_cfg->db4_videocode = 0;
-	avi_cfg->db5_pixel_repeat = 0;
-	avi_cfg->db6_7_line_eoftop = 0;
-	avi_cfg->db8_9_line_sofbottom = 0;
-	avi_cfg->db10_11_pixel_eofleft = 0;
-	avi_cfg->db12_13_pixel_sofright = 0;
-
 	/* packet enable and repeat */
 	repeat_cfg->audio_pkt = 0;
 	repeat_cfg->audio_pkt_repeat = 0;
@@ -305,78 +285,17 @@ static void hdmi_core_video_config(struct hdmi_core_data *core,
 
 static void hdmi_core_aux_infoframe_avi_config(struct hdmi_core_data *core)
 {
-	u32 val;
-	char sum = 0, checksum = 0;
 	void __iomem *av_base = hdmi_av_base(core);
-	struct hdmi_core_infoframe_avi info_avi = core->avi_cfg;
-
-	sum += 0x82 + 0x002 + 0x00D;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_TYPE, 0x082);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_VERS, 0x002);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_LEN, 0x00D);
-
-	val = (info_avi.db1_format << 5) |
-		(info_avi.db1_active_info << 4) |
-		(info_avi.db1_bar_info_dv << 2) |
-		(info_avi.db1_scan_info);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(0), val);
-	sum += val;
-
-	val = (info_avi.db2_colorimetry << 6) |
-		(info_avi.db2_aspect_ratio << 4) |
-		(info_avi.db2_active_fmt_ar);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(1), val);
-	sum += val;
-
-	val = (info_avi.db3_itc << 7) |
-		(info_avi.db3_ec << 4) |
-		(info_avi.db3_q_range << 2) |
-		(info_avi.db3_nup_scaling);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(2), val);
-	sum += val;
-
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(3),
-					info_avi.db4_videocode);
-	sum += info_avi.db4_videocode;
-
-	val = info_avi.db5_pixel_repeat;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(4), val);
-	sum += val;
-
-	val = info_avi.db6_7_line_eoftop & 0x00FF;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(5), val);
-	sum += val;
-
-	val = ((info_avi.db6_7_line_eoftop >> 8) & 0x00FF);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(6), val);
-	sum += val;
-
-	val = info_avi.db8_9_line_sofbottom & 0x00FF;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(7), val);
-	sum += val;
-
-	val = ((info_avi.db8_9_line_sofbottom >> 8) & 0x00FF);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(8), val);
-	sum += val;
-
-	val = info_avi.db10_11_pixel_eofleft & 0x00FF;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(9), val);
-	sum += val;
-
-	val = ((info_avi.db10_11_pixel_eofleft >> 8) & 0x00FF);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(10), val);
-	sum += val;
-
-	val = info_avi.db12_13_pixel_sofright & 0x00FF;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(11), val);
-	sum += val;
-
-	val = ((info_avi.db12_13_pixel_sofright >> 8) & 0x00FF);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_DBYTE(12), val);
-	sum += val;
+	struct hdmi_avi_infoframe *frame = &core->avi_infoframe;
+	u8 data[HDMI_INFOFRAME_SIZE(AVI)];
+	int i;
 
-	checksum = 0x100 - sum;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_CHSUM, checksum);
+	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
+
+	for (i = 0; i < sizeof(data); ++i) {
+		hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_BASE + i * 4,
+			data[i]);
+	}
 }
 
 static void hdmi_core_av_packet_config(struct hdmi_core_data *core,
@@ -404,11 +323,11 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	struct omap_video_timings video_timing;
 	struct hdmi_video_format video_format;
 	/* HDMI core */
-	struct hdmi_core_infoframe_avi *avi_cfg = &core->avi_cfg;
 	struct hdmi_core_video_config v_core_cfg;
 	struct hdmi_core_packet_enable_repeat repeat_cfg;
+	struct hdmi_avi_infoframe *avi_infoframe = &core->avi_infoframe;
 
-	hdmi_core_init(&v_core_cfg, avi_cfg, &repeat_cfg);
+	hdmi_core_init(&v_core_cfg, &repeat_cfg);
 
 	hdmi_wp_init_vid_fmt_timings(&video_format, &video_timing, cfg);
 
@@ -442,25 +361,20 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	 * configure packet
 	 * info frame video see doc CEA861-D page 65
 	 */
-	avi_cfg->db1_format = HDMI_INFOFRAME_AVI_DB1Y_RGB;
-	avi_cfg->db1_active_info =
-			HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
-	avi_cfg->db1_bar_info_dv = HDMI_INFOFRAME_AVI_DB1B_NO;
-	avi_cfg->db1_scan_info = HDMI_INFOFRAME_AVI_DB1S_0;
-	avi_cfg->db2_colorimetry = HDMI_INFOFRAME_AVI_DB2C_NO;
-	avi_cfg->db2_aspect_ratio = HDMI_INFOFRAME_AVI_DB2M_NO;
-	avi_cfg->db2_active_fmt_ar = HDMI_INFOFRAME_AVI_DB2R_SAME;
-	avi_cfg->db3_itc = HDMI_INFOFRAME_AVI_DB3ITC_NO;
-	avi_cfg->db3_ec = HDMI_INFOFRAME_AVI_DB3EC_XVYUV601;
-	avi_cfg->db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_DEFAULT;
-	avi_cfg->db3_nup_scaling = HDMI_INFOFRAME_AVI_DB3SC_NO;
-	avi_cfg->db4_videocode = cfg->cm.code;
-	avi_cfg->db5_pixel_repeat = HDMI_INFOFRAME_AVI_DB5PR_NO;
-	avi_cfg->db6_7_line_eoftop = 0;
-	avi_cfg->db8_9_line_sofbottom = 0;
-	avi_cfg->db10_11_pixel_eofleft = 0;
-	avi_cfg->db12_13_pixel_sofright = 0;
-
+	hdmi_avi_infoframe_init(avi_infoframe);
+	avi_infoframe->colorspace = HDMI_COLORSPACE_RGB;
+	avi_infoframe->scan_mode = HDMI_SCAN_MODE_NONE;
+	avi_infoframe->colorimetry = HDMI_COLORIMETRY_NONE;
+	avi_infoframe->picture_aspect = HDMI_PICTURE_ASPECT_NONE;
+	avi_infoframe->active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
+	avi_infoframe->itc = 0;
+	avi_infoframe->extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+	avi_infoframe->quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
+	avi_infoframe->nups = HDMI_NUPS_UNKNOWN;
+	avi_infoframe->video_code = cfg->cm.code;
+	avi_infoframe->ycc_quantization_range = HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+	avi_infoframe->content_type = HDMI_CONTENT_TYPE_NONE;
+	avi_infoframe->pixel_repeat = 0;
 	hdmi_core_aux_infoframe_avi_config(core);
 
 	/* enable/repeat the infoframe */
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.h b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
index bb646896fa82..827909eb6c50 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
@@ -145,6 +145,7 @@
 #define HDMI_CORE_AV_DPD			0xF4
 #define HDMI_CORE_AV_PB_CTRL1			0xF8
 #define HDMI_CORE_AV_PB_CTRL2			0xFC
+#define HDMI_CORE_AV_AVI_BASE			0x100
 #define HDMI_CORE_AV_AVI_TYPE			0x100
 #define HDMI_CORE_AV_AVI_VERS			0x104
 #define HDMI_CORE_AV_AVI_LEN			0x108
-- 
1.9.1

