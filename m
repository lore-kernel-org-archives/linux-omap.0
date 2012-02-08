From: <mythripk@ti.com>
Subject: [PATCH v4 2/3] OMAPDSS: HDMI: Add quantization range support in IP lib
Date: Wed, 8 Feb 2012 11:54:20 +0530
Message-ID: <1328682261-22493-2-git-send-email-mythripk@ti.com>
References: <1328682261-22493-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59990 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab2BHGbh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 01:31:37 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q186Vaoa000650
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 00:31:36 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q186VZhK029083
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 12:01:35 +0530 (IST)
In-Reply-To: <1328682261-22493-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Configure the IP to support the limited range and full range quantization
mode. If the full range is configured HDMI transmitter will expand the range
of pixel data from 16-235 to full 8 bit 0-235.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    2 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   41 +++++++++++++++++++++++++++++
 include/video/omapdss.h                   |    5 +++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 46e776c..ab0f2c2 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -164,6 +164,7 @@ struct hdmi_ip_data {
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 	struct hdmi_core_infoframe_avi avi_cfg;
+	enum hdmi_range range;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
@@ -181,4 +182,5 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
 #endif
+int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data);
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 6f93271..b0a9573 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -610,6 +610,47 @@ static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_data)
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
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void hdmi_core_av_packet_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_packet_enable_repeat repeat_cfg)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 062b3b2..29f4e78 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -204,6 +204,11 @@ enum omap_hdmi_flags {
 	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP = 1 << 0,
 };
 
+enum hdmi_range {
+	HDMI_LIMITED_RANGE = 0,
+	HDMI_FULL_RANGE = 1,
+};
+
 /* RFBI */
 
 struct rfbi_timings {
-- 
1.7.5.4

