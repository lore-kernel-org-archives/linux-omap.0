From: <mythripk@ti.com>
Subject: [PATCH 2/3] OMAPDSS: HDMI: Add support to configure quantization
Date: Thu, 22 Sep 2011 16:09:11 +0530
Message-ID: <1316687952-27686-2-git-send-email-mythripk@ti.com>
References: <1316687952-27686-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab1IVKrQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 06:47:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MAlDJg018457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 05:47:15 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MAlCxH012133
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 16:17:12 +0530 (IST)
In-Reply-To: <1316687952-27686-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Configure the IP to support the limited range and full range quantization
mode. If the full range is configured HDMI transmitter will expand the range
of pixel data from 16-235 to full 8 bit 0-235.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    7 +++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   40 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index f28f779..ec30961 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -42,6 +42,11 @@ enum hdmi_clk_refsel {
 	HDMI_REFSEL_SYSCLK = 3
 };
 
+enum hdmi_range {
+	HDMI_LIMITED_RANGE = 0,
+	HDMI_FULL_RANGE = 1,
+};
+
 struct hdmi_video_timings {
 	u16 x_res;
 	u16 y_res;
@@ -163,6 +168,7 @@ struct hdmi_ip_data {
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 	struct hdmi_core_infoframe_avi avi_cfg;
+	enum hdmi_range range;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
@@ -176,5 +182,6 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data);
 
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 7b0dcd2..e30fb22 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -610,6 +610,46 @@ static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data)
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_CHSUM, checksum);
 }
 
+int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data)
+{
+	int var;
+
+	switch (ip_data->range) {
+	/*
+	 * Setting the AVI infroframe to respective limited range
+	 * 0 if limited range 1 if full range
+	 */
+	case HDMI_LIMITED_RANGE:
+		ip_data->avi_cfg.db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_LR;
+		hdmi_core_aux_infoframe_avi_config(ip_data);
+		var = hdmi_read_reg(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_SYS_VID_ACEN);
+		var = FLD_MOD(var, 1, 1, 1);
+		hdmi_write_reg(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_SYS_VID_ACEN, var);
+		break;
+	case HDMI_FULL_RANGE:
+	default:
+		/* HDMI 1.3 section 6.6 YCBCR components shall
+		 * always be Limited Range
+		 */
+		if (ip_data->avi_cfg.db1_format ==
+					HDMI_INFOFRAME_AVI_DB1Y_YUV422) {
+			pr_err("Only limited range is supported for YUV");
+			return -EINVAL;
+		}
+		ip_data->avi_cfg.db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_FR;
+		hdmi_core_aux_infoframe_avi_config(ip_data);
+			var = hdmi_read_reg(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_SYS_VID_MODE);
+			var = FLD_MOD(var, 1, 4, 4);
+			hdmi_write_reg(hdmi_core_sys_base(ip_data),
+						HDMI_CORE_SYS_VID_MODE, var);
+		break;
+	}
+	return 0;
+}
+
 static void hdmi_core_av_packet_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_packet_enable_repeat repeat_cfg)
 {
-- 
1.7.5.4

