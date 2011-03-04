From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v3 2/9] OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
Date: Fri,  4 Mar 2011 13:18:20 +0530
Message-ID: <1299224907-11354-3-git-send-email-mythripk@ti.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48261 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637Ab1CDHsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 02:48:42 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p247mcAX007765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 01:48:41 -0600
In-Reply-To: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>


Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.c |    5 +++++
 drivers/video/omap2/dss/dss.h |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 99de4e1..baf1974 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -559,6 +559,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+{
+	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+}
+
 static int dss_init(bool skip_init)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b6f27fe..c780926 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -123,6 +123,11 @@ enum dss_clk_source {
 	DSS_SRC_DSS1_ALWON_FCLK,
 };
 
+enum dss_hdmi_venc_clk_source_select {
+	DSS_VENC_TV_CLK = 0,
+	DSS_HDMI_M_PCLK = 1,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -209,6 +214,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 void dss_save_context(void);
 void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
@@ -352,7 +358,6 @@ void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
 void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
-
 int dispc_setup_plane(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
 		      u16 pos_x, u16 pos_y,
-- 
1.5.6.3

