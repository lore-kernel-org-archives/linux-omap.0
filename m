From: <mythripk@ti.com>
Subject: [PATCH 2/2] OMAPDSS: HDMI: Add support for OMAP5 HDMI core library
Date: Fri, 9 Mar 2012 18:27:59 +0530
Message-ID: <1331297879-14622-3-git-send-email-mythripk@ti.com>
References: <1331297879-14622-1-git-send-email-mythripk@ti.com>
 <1331297879-14622-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38630 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2CINFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 08:05:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q29D4wJs010128
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 07:04:59 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q29D4vRR020746
	for <linux-omap@vger.kernel.org>; Fri, 9 Mar 2012 18:34:58 +0530 (IST)
In-Reply-To: <1331297879-14622-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support for configuration of the basic HDMI OMAP5 core IP
driver.HDMI shares the wrapper, PHY and PLL code with OMAP4.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    2 +
 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c |  341 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h |  254 +++++++++++++++++++++
 3 files changed, 597 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 1f58b84..aafecc2 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -185,4 +185,6 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
 #endif
+void ti_hdmi_5xxx_basic_configure(struct hdmi_ip_data *ip_data);
+void ti_hdmi_5xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c
new file mode 100644
index 0000000..a8a5ad3
--- /dev/null
+++ b/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.c
@@ -0,0 +1,341 @@
+
+/*
+ * ti_hdmi_5xxx_ip.c
+ *
+ * HDMI TI OMAP5 IP driver Library
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Mythri pk <mythripk@ti.com>
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+
+#include "ti_hdmi_5xxx_ip.h"
+#include "dss.h"
+
+static inline void hdmi_write_reg(void __iomem *base_addr,
+		const unsigned long idx, u32 val)
+{
+	__raw_writel(val, base_addr + idx);
+}
+
+static inline u32 hdmi_read_reg(void __iomem *base_addr,
+		const unsigned long idx)
+{
+	return __raw_readl(base_addr + idx);
+}
+
+static inline void __iomem *hdmi_core_sys_base(struct hdmi_ip_data *ip_data)
+{
+	return ip_data->base_wp + ip_data->core_sys_offset;
+}
+
+static inline int hdmi_wait_for_bit_change(void __iomem *base_addr,
+			const unsigned long idx,
+			int b2, int b1, u32 val)
+{
+	u32 t = 0;
+	while (val != REG_GET(base_addr, idx, b2, b1)) {
+		udelay(1);
+		if (t++ > 10000)
+			return !val;
+	}
+	return val;
+}
+
+void ti_hdmi_5xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
+{
+
+#define DUMPCORE(r) seq_printf(s, "%-35s %08x\n", #r,\
+		hdmi_read_reg(hdmi_core_sys_base(ip_data), r))
+
+	DUMPCORE(HDMI_CORE_FC_INVIDCONF);
+	DUMPCORE(HDMI_CORE_FC_INHACTIV0);
+	DUMPCORE(HDMI_CORE_FC_INHACTIV1);
+	DUMPCORE(HDMI_CORE_FC_INHBLANK0);
+	DUMPCORE(HDMI_CORE_FC_INHBLANK1);
+	DUMPCORE(HDMI_CORE_FC_INVACTIV0);
+	DUMPCORE(HDMI_CORE_FC_INVACTIV1);
+	DUMPCORE(HDMI_CORE_FC_INVBLANK);
+	DUMPCORE(HDMI_CORE_FC_HSYNCINDELAY0);
+	DUMPCORE(HDMI_CORE_FC_HSYNCINDELAY1);
+	DUMPCORE(HDMI_CORE_FC_HSYNCINWIDTH0);
+	DUMPCORE(HDMI_CORE_FC_HSYNCINWIDTH1);
+	DUMPCORE(HDMI_CORE_FC_VSYNCINDELAY);
+	DUMPCORE(HDMI_CORE_FC_VSYNCINWIDTH);
+	DUMPCORE(HDMI_CORE_FC_CTRLDUR);
+	DUMPCORE(HDMI_CORE_FC_EXCTRLDUR);
+	DUMPCORE(HDMI_CORE_FC_EXCTRLSPAC);
+	DUMPCORE(HDMI_CORE_FC_CH0PREAM);
+	DUMPCORE(HDMI_CORE_FC_CH1PREAM);
+	DUMPCORE(HDMI_CORE_FC_CH2PREAM);
+	DUMPCORE(HDMI_CORE_FC_AVICONF0);
+	DUMPCORE(HDMI_CORE_FC_AVICONF1);
+	DUMPCORE(HDMI_CORE_FC_AVICONF2);
+	DUMPCORE(HDMI_CORE_FC_AVIVID);
+	DUMPCORE(HDMI_CORE_FC_PRCONF);
+
+	DUMPCORE(HDMI_CORE_MC_CLKDIS);
+	DUMPCORE(HDMI_CORE_MC_SWRSTZREQ);
+	DUMPCORE(HDMI_CORE_MC_FLOWCTRL);
+	DUMPCORE(HDMI_CORE_MC_PHYRSTZ);
+	DUMPCORE(HDMI_CORE_MC_LOCKONCLOCK);
+
+	DUMPCORE(HDMI_CORE_I2CM_SLAVE);
+	DUMPCORE(HDMI_CORE_I2CM_ADDRESS);
+	DUMPCORE(HDMI_CORE_I2CM_DATAO);
+	DUMPCORE(HDMI_CORE_I2CM_DATAI);
+	DUMPCORE(HDMI_CORE_I2CM_OPERATION);
+	DUMPCORE(HDMI_CORE_I2CM_INT);
+	DUMPCORE(HDMI_CORE_I2CM_CTLINT);
+	DUMPCORE(HDMI_CORE_I2CM_DIV);
+	DUMPCORE(HDMI_CORE_I2CM_SEGADDR);
+	DUMPCORE(HDMI_CORE_I2CM_SOFTRSTZ);
+	DUMPCORE(HDMI_CORE_I2CM_SEGPTR);
+	DUMPCORE(HDMI_CORE_I2CM_SS_SCL_HCNT_1_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_SS_SCL_HCNT_0_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_SS_SCL_LCNT_1_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_SS_SCL_LCNT_0_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_FS_SCL_HCNT_1_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_FS_SCL_HCNT_0_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_FS_SCL_LCNT_1_ADDR);
+	DUMPCORE(HDMI_CORE_I2CM_FS_SCL_LCNT_0_ADDR);
+}
+
+static void hdmi_core_init(struct hdmi_core_vid_config *video_cfg,
+			struct hdmi_core_infoframe_avi *avi_cfg,
+			struct hdmi_config *cfg)
+{
+	printk(KERN_INFO "Enter hdmi_core_init\n");
+
+	/* video core */
+	video_cfg->data_enable_pol = 1; /* It is always 1*/
+	video_cfg->v_fc_config.timings.hsync_pol = cfg->timings.hsync_pol;
+	video_cfg->v_fc_config.timings.x_res = cfg->timings.x_res;
+	video_cfg->v_fc_config.timings.hsw = cfg->timings.hsw;
+	video_cfg->v_fc_config.timings.hbp = cfg->timings.hbp;
+	video_cfg->v_fc_config.timings.hfp = cfg->timings.hfp;
+	video_cfg->hblank = cfg->timings.hfp +
+				cfg->timings.hbp + cfg->timings.hsw;
+	video_cfg->v_fc_config.timings.vsync_pol = cfg->timings.vsync_pol;
+	video_cfg->v_fc_config.timings.y_res = cfg->timings.y_res;
+	video_cfg->v_fc_config.timings.vsw = cfg->timings.vsw;
+	video_cfg->v_fc_config.timings.vfp = cfg->timings.vfp;
+	video_cfg->v_fc_config.timings.vbp = cfg->timings.vbp;
+	video_cfg->vblank_osc = 0; /* Always 0 - need to confirm */
+	video_cfg->vblank = cfg->timings.vsw +
+				cfg->timings.vfp + cfg->timings.vbp;
+	video_cfg->v_fc_config.cm.mode = cfg->cm.mode;
+	video_cfg->v_fc_config.timings.interlace = cfg->timings.interlace;
+
+	/* info frame */
+	avi_cfg->db1_format = 0;
+	avi_cfg->db1_active_info = 0;
+	avi_cfg->db1_bar_info_dv = 0;
+	avi_cfg->db1_scan_info = 0;
+	avi_cfg->db2_colorimetry = 0;
+	avi_cfg->db2_aspect_ratio = 0;
+	avi_cfg->db2_active_fmt_ar = 0;
+	avi_cfg->db3_itc = 0;
+	avi_cfg->db3_ec = 0;
+	avi_cfg->db3_q_range = 0;
+	avi_cfg->db3_nup_scaling = 0;
+	avi_cfg->db4_videocode = 0;
+	avi_cfg->db5_pixel_repeat = 0;
+	avi_cfg->db6_7_line_eoftop = 0 ;
+	avi_cfg->db8_9_line_sofbottom = 0;
+	avi_cfg->db10_11_pixel_eofleft = 0;
+	avi_cfg->db12_13_pixel_sofright = 0;
+
+}
+
+/* DSS_HDMI_CORE_VIDEO_CONFIG */
+static void hdmi_core_video_config(struct hdmi_ip_data *ip_data,
+				struct hdmi_core_vid_config *cfg)
+{
+	unsigned char r = 0;
+	void __iomem *core_sys_base = hdmi_core_sys_base(ip_data);
+
+	/* Set hsync, vsync and data-enable polarity  */
+	r = hdmi_read_reg(core_sys_base, HDMI_CORE_FC_INVIDCONF);
+
+	r = FLD_MOD(r, cfg->v_fc_config.timings.vsync_pol, 6, 6);
+	r = FLD_MOD(r, cfg->v_fc_config.timings.hsync_pol, 5, 5);
+	r = FLD_MOD(r, cfg->data_enable_pol, 4, 4);
+	r = FLD_MOD(r, cfg->vblank_osc, 1, 1);
+	r = FLD_MOD(r, cfg->v_fc_config.timings.interlace, 0, 0);
+	hdmi_write_reg(core_sys_base, HDMI_CORE_FC_INVIDCONF, r);
+
+	/* set x resolution */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INHACTIV1,
+			(cfg->v_fc_config.timings.x_res >> 8), 4, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INHACTIV0,
+			(cfg->v_fc_config.timings.x_res & 0xFF), 7, 0);
+
+	/* set y resolution */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INVACTIV1,
+			(cfg->v_fc_config.timings.y_res >> 8), 4, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INVACTIV0,
+			(cfg->v_fc_config.timings.y_res & 0xFF), 7, 0);
+
+	/* set horizontal blanking pixels */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INHBLANK1,
+			(cfg->hblank >> 8), 4, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INHBLANK0,
+			(cfg->hblank & 0xFF), 7, 0);
+
+	/* set vertial blanking pixels */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INVBLANK, cfg->vblank, 7, 0);
+
+	/* set horizontal sync offset */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_HSYNCINDELAY1,
+			(cfg->v_fc_config.timings.hfp >> 8), 4, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_HSYNCINDELAY0,
+			(cfg->v_fc_config.timings.hfp & 0xFF), 7, 0);
+
+	/* set vertical sync offset */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_VSYNCINDELAY,
+			cfg->v_fc_config.timings.vfp, 7, 0);
+
+	/* set horizontal sync pulse width */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_HSYNCINWIDTH1,
+			(cfg->v_fc_config.timings.hsw >> 8), 1, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_HSYNCINWIDTH0,
+			(cfg->v_fc_config.timings.hsw & 0xFF), 7, 0);
+
+	/*  set vertical sync pulse width */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_VSYNCINWIDTH,
+			cfg->v_fc_config.timings.vsw, 5, 0);
+
+	/* select DVI mode */
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_INVIDCONF,
+		cfg->v_fc_config.cm.mode, 3, 3);
+}
+
+static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data,
+		struct hdmi_core_infoframe_avi info_avi)
+{
+	void __iomem *core_sys_base = hdmi_core_sys_base(ip_data);
+
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF0,
+				info_avi.db1_format, 1, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF0,
+				info_avi.db1_active_info, 6, 6);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF0,
+				info_avi.db1_bar_info_dv, 3, 2);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF0,
+				info_avi.db1_scan_info, 5, 4);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF1,
+				info_avi.db2_colorimetry, 7, 6);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF1,
+				info_avi.db2_aspect_ratio, 5, 4);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF1,
+				info_avi.db2_active_fmt_ar, 3, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF2,
+				info_avi.db3_itc, 7, 7);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF2,
+				info_avi.db3_ec, 6, 4);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF2,
+				info_avi.db3_q_range, 3, 2);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVICONF2,
+				info_avi.db3_nup_scaling, 1, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AVIVID,
+				info_avi.db4_videocode, 6, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_PRCONF,
+				info_avi.db5_pixel_repeat, 3, 0);
+}
+
+void hdmi_enable_video_path(struct hdmi_ip_data *ip_data)
+{
+	void __iomem *core_sys_base = hdmi_core_sys_base(ip_data);
+
+	printk(KERN_INFO "Enable video_path\n");
+
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_CTRLDUR, 0x0C, 7, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_EXCTRLDUR, 0x20, 7, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_EXCTRLSPAC, 0x01, 7, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_CH0PREAM, 0x0B, 7, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_CH1PREAM, 0x16, 5, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_CH2PREAM, 0x21, 5, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_MC_CLKDIS, 0x00, 0, 0);
+	REG_FLD_MOD(core_sys_base, HDMI_CORE_MC_CLKDIS, 0x00, 1, 1);
+}
+
+void ti_hdmi_5xxx_basic_configure(struct hdmi_ip_data *ip_data)
+{
+	/* HDMI */
+	struct omap_video_timings video_timing;
+	struct hdmi_video_format video_format;
+	/* HDMI core */
+	struct hdmi_core_vid_config v_core_cfg;
+	struct hdmi_core_infoframe_avi avi_cfg;
+	struct hdmi_config *cfg = &ip_data->cfg;
+
+	hdmi_wp_init(&video_timing, &video_format);
+
+	hdmi_core_init(&v_core_cfg, &avi_cfg, cfg);
+
+	hdmi_wp_video_init_format(&video_format, &video_timing, cfg);
+
+	hdmi_wp_video_config_timing(ip_data, &video_timing);
+
+	/* video config */
+	video_format.packing_mode = HDMI_PACK_24b_RGB_YUV444_YUV422;
+
+	hdmi_wp_video_config_format(ip_data, &video_format);
+
+	hdmi_wp_video_config_interface(ip_data);
+
+	/*
+	 * configure core video part
+	 * set software reset in the core
+	 */
+	v_core_cfg.packet_mode = HDMI_PACKETMODE24BITPERPIXEL;
+
+	hdmi_core_video_config(ip_data, &v_core_cfg);
+
+	/*
+	 * configure packet
+	 * info frame video see doc CEA861-D page 65
+	 */
+	avi_cfg.db1_format = HDMI_INFOFRAME_AVI_DB1Y_RGB;
+	avi_cfg.db1_active_info =
+			HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
+	avi_cfg.db1_bar_info_dv = HDMI_INFOFRAME_AVI_DB1B_NO;
+	avi_cfg.db1_scan_info = HDMI_INFOFRAME_AVI_DB1S_0;
+	avi_cfg.db2_colorimetry = HDMI_INFOFRAME_AVI_DB2C_NO;
+	avi_cfg.db2_aspect_ratio = HDMI_INFOFRAME_AVI_DB2M_NO;
+	avi_cfg.db2_active_fmt_ar = HDMI_INFOFRAME_AVI_DB2R_SAME;
+	avi_cfg.db3_itc = HDMI_INFOFRAME_AVI_DB3ITC_NO;
+	avi_cfg.db3_ec = HDMI_INFOFRAME_AVI_DB3EC_XVYUV601;
+	avi_cfg.db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_DEFAULT;
+	avi_cfg.db3_nup_scaling = HDMI_INFOFRAME_AVI_DB3SC_NO;
+	avi_cfg.db4_videocode = cfg->cm.code;
+	avi_cfg.db5_pixel_repeat = HDMI_INFOFRAME_AVI_DB5PR_NO;
+	avi_cfg.db6_7_line_eoftop = 0;
+	avi_cfg.db8_9_line_sofbottom = 0;
+	avi_cfg.db10_11_pixel_eofleft = 0;
+	avi_cfg.db12_13_pixel_sofright = 0;
+
+	hdmi_core_aux_infoframe_avi_config(ip_data, avi_cfg);
+
+	hdmi_enable_video_path(ip_data);
+}
diff --git a/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h
new file mode 100644
index 0000000..eb16798
--- /dev/null
+++ b/drivers/video/omap2/dss/ti_hdmi_5xxx_ip.h
@@ -0,0 +1,254 @@
+/*
+ * ti_hdmi_5xxx_ip.h
+ *
+ * HDMI driver definition for TI OMAP5 processors.
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _OMAP5_DSS_HDMI_H_
+#define _OMAP5_DSS_HDMI_H_
+
+#include <linux/string.h>
+#include <video/omapdss.h>
+#include "ti_hdmi_4xxx_ip.h"
+#include "ti_hdmi.h"
+
+/* HDMI IP Core System */
+
+/* HDMI Identification */
+#define HDMI_CORE_DESIGN_ID			0x00000
+#define HDMI_CORE_REVISION_ID			0x00004
+#define HDMI_CORE_PRODUCT_ID0			0x00008
+#define HDMI_CORE_PRODUCT_ID1			0x0000C
+#define HDMI_CORE_CONFIG0_ID			0x00010
+#define HDMI_CORE_CONFIG1_ID			0x00014
+#define HDMI_CORE_CONFIG2_ID			0x00018
+#define HDMI_CORE_CONFIG3_ID			0x0001C
+
+/* HDMI Interrupt */
+#define HDMI_CORE_IH_FC_STAT0			0x00400
+#define HDMI_CORE_IH_FC_STAT1			0x00404
+#define HDMI_CORE_IH_FC_STAT2			0x00408
+#define HDMI_CORE_IH_AS_STAT0			0x0040C
+#define HDMI_CORE_IH_PHY_STAT0			0x00410
+#define HDMI_CORE_IH_I2CM_STAT0			0x00414
+#define HDMI_CORE_IH_CEC_STAT0			0x00418
+#define HDMI_CORE_IH_VP_STAT0			0x0041C
+#define HDMI_CORE_IH_I2CMPHY_STAT0		0x00420
+#define HDMI_CORE_IH_MUTE			0x047FC
+
+/* HDMI Video Sampler */
+#define HDMI_CORE_TX_INVID0			0x00800
+#define HDMI_CORE_TX_INSTUFFING			0x00804
+#define HDMI_CORE_TX_RGYDATA0			0x00808
+#define HDMI_CORE_TX_RGYDATA1			0x0080C
+#define HDMI_CORE_TX_RCRDATA0			0x00810
+#define HDMI_CORE_TX_RCRDATA1			0x00814
+#define HDMI_CORE_TX_BCBDATA0			0x00818
+#define HDMI_CORE_TX_BCBDATA1			0x0081C
+
+/* HDMI Video Packetizer */
+#define HDMI_CORE_VP_STATUS			0x02000
+#define HDMI_CORE_VP_PR_CD			0x02004
+#define HDMI_CORE_VP_STUFF			0x02008
+#define HDMI_CORE_VP_REMAP			0x0200C
+#define HDMI_CORE_VP_CONF			0x02010
+#define HDMI_CORE_VP_STAT			0x02014
+#define HDMI_CORE_VP_INT			0x02018
+#define HDMI_CORE_VP_MASK			0x0201C
+#define HDMI_CORE_VP_POL			0x02020
+
+/* Frame Composer */
+#define HDMI_CORE_FC_INVIDCONF			0x04000
+#define HDMI_CORE_FC_INHACTIV0			0x04004
+#define HDMI_CORE_FC_INHACTIV1			0x04008
+#define HDMI_CORE_FC_INHBLANK0			0x0400C
+#define HDMI_CORE_FC_INHBLANK1			0x04010
+#define HDMI_CORE_FC_INVACTIV0			0x04014
+#define HDMI_CORE_FC_INVACTIV1			0x04018
+#define HDMI_CORE_FC_INVBLANK			0x0401C
+#define HDMI_CORE_FC_HSYNCINDELAY0		0x04020
+#define HDMI_CORE_FC_HSYNCINDELAY1		0x04024
+#define HDMI_CORE_FC_HSYNCINWIDTH0		0x04028
+#define HDMI_CORE_FC_HSYNCINWIDTH1		0x0402C
+#define HDMI_CORE_FC_VSYNCINDELAY		0x04030
+#define HDMI_CORE_FC_VSYNCINWIDTH		0x04034
+#define HDMI_CORE_FC_INFREQ0			0x04038
+#define HDMI_CORE_FC_INFREQ1			0x0403C
+#define HDMI_CORE_FC_INFREQ2			0x04040
+#define HDMI_CORE_FC_CTRLDUR			0x04044
+#define HDMI_CORE_FC_EXCTRLDUR			0x04048
+#define HDMI_CORE_FC_EXCTRLSPAC			0x0404C
+#define HDMI_CORE_FC_CH0PREAM			0x04050
+#define HDMI_CORE_FC_CH1PREAM			0x04054
+#define HDMI_CORE_FC_CH2PREAM			0x04058
+#define HDMI_CORE_FC_AVICONF3			0x0405C
+#define HDMI_CORE_FC_GCP			0x04060
+#define HDMI_CORE_FC_AVICONF0			0x04064
+#define HDMI_CORE_FC_AVICONF1			0x04068
+#define HDMI_CORE_FC_AVICONF2			0x0406C
+#define HDMI_CORE_FC_AVIVID			0x04070
+#define HDMI_CORE_FC_AVIETB0			0x04074
+#define HDMI_CORE_FC_AVIETB1			0x04078
+#define HDMI_CORE_FC_AVISBB0			0x0407C
+#define HDMI_CORE_FC_AVISBB1			0x04080
+#define HDMI_CORE_FC_AVIELB0			0x04084
+#define HDMI_CORE_FC_AVIELB1			0x04088
+#define HDMI_CORE_FC_AVISRB0			0x0408C
+#define HDMI_CORE_FC_AVISRB1			0x04090
+#define HDMI_CORE_FC_AUDICONF0			0x04094
+#define HDMI_CORE_FC_AUDICONF1			0x04098
+#define HDMI_CORE_FC_AUDICONF2			0x0409C
+#define HDMI_CORE_FC_AUDICONF3			0x040A0
+#define HDMI_CORE_FC_VSDIEEEID0			0x040A4
+#define HDMI_CORE_FC_VSDSIZE			0x040A8
+#define HDMI_CORE_FC_VSDIEEEID1			0x040C0
+#define HDMI_CORE_FC_VSDIEEEID2			0x040C4
+#define HDMI_CORE_FC_VSDPAYLOAD(n)		(n * 4 + 0x040C8)
+#define HDMI_CORE_FC_SPDVENDORNAME(n)		(n * 4 + 0x04128)
+#define HDMI_CORE_FC_SPDPRODUCTNAME(n)		(n * 4 + 0x04148)
+#define HDMI_CORE_FC_SPDDEVICEINF		0x04188
+#define HDMI_CORE_FC_AUDSCONF			0x0418C
+#define HDMI_CORE_FC_AUDSSTAT			0x04190
+#define HDMI_CORE_FC_AUDSV			0x04194
+#define HDMI_CORE_FC_AUDSU			0x04198
+#define HDMI_CORE_FC_AUDSCHNLS(n)		(n * 4 + 0x0419C)
+#define HDMI_CORE_FC_CTRLQHIGH			0x041CC
+#define HDMI_CORE_FC_CTRLQLOW			0x041D0
+#define HDMI_CORE_FC_ACP0			0x041D4
+#define HDMI_CORE_FC_ACP(n)			((16-n) * 4 + 0x04208)
+#define HDMI_CORE_FC_ISCR1_0			0x04248
+#define HDMI_CORE_FC_ISCR1(n)			((16-n) * 4 + 0x0424C)
+#define HDMI_CORE_FC_ISCR2(n)			((15-n) * 4 + 0x0428C)
+#define HDMI_CORE_FC_DATAUTO0			0x042CC
+#define HDMI_CORE_FC_DATAAUTO1			0x042D0
+#define HDMI_CORE_FC_DATAUTO2			0x042D4
+#define HDMI_CORE_FC_DATMAN			0x042D8
+#define HDMI_CORE_FC_DATAUTO3			0x042DC
+#define HDMI_CORE_FC_RDRB(n)			(n * 4 + 0x042E0)
+#define HDMI_CORE_FC_STAT0			0x04340
+#define HDMI_CORE_FC_INT0			0x04344
+#define HDMI_CORE_FC_MASK0			0x04348
+#define HDMI_CORE_FC_POL0			0x0434C
+#define HDMI_CORE_FC_STAT1			0x04350
+#define HDMI_CORE_FC_INT1			0x04354
+#define HDMI_CORE_FC_MASK1			0x04358
+#define HDMI_CORE_FC_POL1			0x0435C
+#define HDMI_CORE_FC_STAT2			0x04360
+#define HDMI_CORE_FC_INT2			0x04364
+#define HDMI_CORE_FC_MASK2			0x04368
+#define HDMI_CORE_FC_POL2			0x0436C
+#define HDMI_CORE_FC_PRCONF			0x04380
+#define HDMI_CORE_FC_GMD_STAT			0x04400
+#define HDMI_CORE_FC_GMD_EN			0x04404
+#define HDMI_CORE_FC_GMD_UP			0x04408
+#define HDMI_CORE_FC_GMD_CONF			0x0440C
+#define HDMI_CORE_FC_GMD_HB			0x04410
+#define HDMI_CORE_FC_GMD_PB(n)			(n * 4 + 0x04414)
+#define HDMI_CORE_FC_DBGFORCE			0x04800
+#define HDMI_CORE_FC_DBGAUD0CH0			0x04804
+#define HDMI_CORE_FC_DBGAUD1CH0			0x04808
+#define HDMI_CORE_FC_DBGAUD2CH0			0x0480C
+#define HDMI_CORE_FC_DBGAUD0CH1			0x04810
+#define HDMI_CORE_FC_DBGAUD1CH1			0x04814
+#define HDMI_CORE_FC_DBGAUD2CH1			0x04818
+#define HDMI_CORE_FC_DBGAUD0CH2			0x0481C
+#define HDMI_CORE_FC_DBGAUD1CH2			0x04820
+#define HDMI_CORE_FC_DBGAUD2CH2			0x04824
+#define HDMI_CORE_FC_DBGAUD0CH3			0x04828
+#define HDMI_CORE_FC_DBGAUD1CH3			0x0482C
+#define HDMI_CORE_FC_DBGAUD2CH3			0x04830
+#define HDMI_CORE_FC_DBGAUD0CH4			0x04834
+#define HDMI_CORE_FC_DBGAUD1CH4			0x04838
+#define HDMI_CORE_FC_DBGAUD2CH4			0x0483C
+#define HDMI_CORE_FC_DBGAUD0CH5			0x04840
+#define HDMI_CORE_FC_DBGAUD1CH5			0x04844
+#define HDMI_CORE_FC_DBGAUD2CH5			0x04848
+#define HDMI_CORE_FC_DBGAUD0CH6			0x0484C
+#define HDMI_CORE_FC_DBGAUD1CH6			0x04850
+#define HDMI_CORE_FC_DBGAUD2CH6			0x04854
+#define HDMI_CORE_FC_DBGAUD0CH7			0x04858
+#define HDMI_CORE_FC_DBGAUD1CH7			0x0485C
+#define HDMI_CORE_FC_DBGAUD2CH7			0x04860
+#define HDMI_CORE_FC_DBGTMDS0			0x04864
+#define HDMI_CORE_FC_DBGTMDS1			0x04868
+#define HDMI_CORE_FC_DBGTMDS2			0x0486C
+
+/* HDMI Main Controller */
+#define HDMI_CORE_MC_CLKDIS			0x10004
+#define HDMI_CORE_MC_SWRSTZREQ			0x10008
+#define HDMI_CORE_MC_FLOWCTRL			0x10010
+#define HDMI_CORE_MC_PHYRSTZ			0x10014
+#define HDMI_CORE_MC_LOCKONCLOCK		0x10018
+
+/* HDMI COLOR SPACE CONVERTER */
+#define HDMI_CORE_CSC_CFG			0x10400
+#define HDMI_CORE_CSC_SCALE			0x10404
+#define HDMI_CORE_CSC_COEF_A1_MSB		0x10408
+#define HDMI_CORE_CSC_COEF_A1_LSB		0x1040C
+#define HDMI_CORE_CSC_COEF_A2_MSB		0x10410
+#define HDMI_CORE_CSC_COEF_A2_LSB		0x10414
+#define HDMI_CORE_CSC_COEF_A3_MSB		0x10418
+#define HDMI_CORE_CSC_COEF_A3_LSB		0x1041C
+#define HDMI_CORE_CSC_COEF_A4_MSB		0x10420
+#define HDMI_CORE_CSC_COEF_A4_LSB		0x10424
+#define HDMI_CORE_CSC_COEF_B1_MSB		0x10428
+#define HDMI_CORE_CSC_COEF_B1_LSB		0x1042C
+#define HDMI_CORE_CSC_COEF_B2_MSB		0x10430
+#define HDMI_CORE_CSC_COEF_B2_LSB		0x10434
+#define HDMI_CORE_CSC_COEF_B3_MSB		0x10438
+#define HDMI_CORE_CSC_COEF_B3_LSB		0x1043C
+#define HDMI_CORE_CSC_COEF_B4_MSB		0x10440
+#define HDMI_CORE_CSC_COEF_B4_LSB		0x10444
+#define HDMI_CORE_CSC_COEF_C1_MSB		0x10448
+#define HDMI_CORE_CSC_COEF_C1_LSB		0x1044C
+#define HDMI_CORE_CSC_COEF_C2_MSB		0x10450
+#define HDMI_CORE_CSC_COEF_C2_LSB		0x10454
+#define HDMI_CORE_CSC_COEF_C3_MSB		0x10458
+#define HDMI_CORE_CSC_COEF_C3_LSB		0x1045C
+#define HDMI_CORE_CSC_COEF_C4_MSB		0x10460
+#define HDMI_CORE_CSC_COEF_C4_LSB		0x10464
+
+/* HDMI I2C Master */
+#define HDMI_CORE_I2CM_SLAVE			0x17800
+#define HDMI_CORE_I2CM_ADDRESS			0x17804
+#define HDMI_CORE_I2CM_DATAO			0x17808
+#define HDMI_CORE_I2CM_DATAI			0X1780C
+#define HDMI_CORE_I2CM_OPERATION		0x17810
+#define HDMI_CORE_I2CM_INT			0x17814
+#define HDMI_CORE_I2CM_CTLINT			0x17818
+#define HDMI_CORE_I2CM_DIV			0x1781C
+#define HDMI_CORE_I2CM_SEGADDR			0x17820
+#define HDMI_CORE_I2CM_SOFTRSTZ			0x17824
+#define HDMI_CORE_I2CM_SEGPTR			0x17828
+#define HDMI_CORE_I2CM_SS_SCL_HCNT_1_ADDR	0x1782C
+#define HDMI_CORE_I2CM_SS_SCL_HCNT_0_ADDR	0x17830
+#define HDMI_CORE_I2CM_SS_SCL_LCNT_1_ADDR	0x17834
+#define HDMI_CORE_I2CM_SS_SCL_LCNT_0_ADDR	0x17838
+#define HDMI_CORE_I2CM_FS_SCL_HCNT_1_ADDR	0x1783C
+#define HDMI_CORE_I2CM_FS_SCL_HCNT_0_ADDR	0x17840
+#define HDMI_CORE_I2CM_FS_SCL_LCNT_1_ADDR	0x17844
+#define HDMI_CORE_I2CM_FS_SCL_LCNT_0_ADDR	0x17848
+
+struct hdmi_core_vid_config	{
+	struct hdmi_config  v_fc_config;
+	enum hdmi_core_packet_mode packet_mode;
+	int data_enable_pol;
+	int vblank_osc;
+	int hblank;
+	int vblank;
+};
+#endif
-- 
1.7.5.4

