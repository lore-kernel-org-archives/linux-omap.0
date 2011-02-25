From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 3/8] OMAP4 : DSS : HDMI: HDMI specific display controller and dss change.
Date: Fri, 25 Feb 2011 19:51:50 +0530
Message-ID: <1298643715-21540-4-git-send-email-mythripk@ti.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53870 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703Ab1BYNyh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:54:37 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1PDsbDc020957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 07:54:37 -0600
In-Reply-To: <1298643715-21540-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

Adding changes to set gamma table bit for TV interface and function to select
between VENC and HDMI.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++++
 drivers/video/omap2/dss/dss.c   |    7 +++++++
 drivers/video/omap2/dss/dss.h   |    2 ++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6d9bb17..16f1106 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1213,6 +1213,11 @@ void dispc_enable_zorder(enum omap_plane plane, bool enable)
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
index 99de4e1..127d42e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -559,6 +559,13 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
+void dss_select_hdmi_venc(bool hdmi)
+{
+	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* 0x1 for HDMI, 0x0 VENC */
+	if (hdmi)
+		REG_FLD_MOD(DSS_CONTROL, 0, 9, 8);
+}
+
 static int dss_init(bool skip_init)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b6f27fe..d199ba7 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -209,6 +209,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+void dss_select_hdmi_venc(bool hdmi);
 void dss_save_context(void);
 void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
@@ -352,6 +353,7 @@ void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
 void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
+void dispc_enable_gamma_table(bool enable);
 
 int dispc_setup_plane(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
-- 
1.5.6.3

