From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v2 2/8] OMAP4 : DSS2 : HDMI: HDMI specific display controller and dss change.
Date: Tue,  1 Mar 2011 19:46:22 +0530
Message-ID: <1298988988-28429-3-git-send-email-mythripk@ti.com>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54301 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab1CANtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 08:49:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21Dnf1t007997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 07:49:41 -0600
In-Reply-To: <1298988988-28429-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

Adding changes to set gamma table bit for TV interface and function to select
between VENC and HDMI.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++++
 drivers/video/omap2/dss/dss.c   |    5 +++++
 drivers/video/omap2/dss/dss.h   |    7 +++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 69e1e9d..cf385f8 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1224,6 +1224,11 @@ void dispc_enable_zorder(enum omap_plane plane, bool enable)
 	dispc_write_reg(dispc_reg_att[plane], val);
 }
 
+void dispc_enable_gamma_table(bool enable)
+{
+	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
+}
+
 static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 99de4e1..ca76e68 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -559,6 +559,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
+void dss_select_hdmi_venc(enum dss_hdmi_venc_select hdmi)
+{
+	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* 0x1 for HDMI, 0x0 VENC */
+}
+
 static int dss_init(bool skip_init)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b6f27fe..5b5b90c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -123,6 +123,11 @@ enum dss_clk_source {
 	DSS_SRC_DSS1_ALWON_FCLK,
 };
 
+enum dss_hdmi_venc_select {
+	DSS_VENC_SELECT,	/* Select VENC */
+	DSS_HDMI_SELECT,	/* Select HDMI */
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -209,6 +214,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+void dss_select_hdmi_venc(enum dss_hdmi_venc_select hdmi);
 void dss_save_context(void);
 void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
@@ -352,6 +358,7 @@ void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
 void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
+void dispc_enable_gamma_table(bool enable);
 
 int dispc_setup_plane(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
-- 
1.5.6.3

