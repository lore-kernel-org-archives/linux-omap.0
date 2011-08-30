From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/10] OMAP: DSS2: DSI: Introduce generic write functions
Date: Tue, 30 Aug 2011 16:21:29 +0530
Message-ID: <1314701495-11247-5-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52463 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1H3KxX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:23 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArLlg020867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:21 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArLPI009397
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:21 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArL63025179
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:21 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Intoduce enum "dss_dsi_content_type" to differentiate between DCS and generic
content types.

Introduce short and long packet write functions which use generic
Processor-to-Peripheral transaction types. These are needed by some devices
which may not support corresponding DCS commands. Create common write functions
which allow code reuse between DCS and generic write functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   84 +++++++++++++++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h |    5 ++
 include/video/omapdss.h       |   12 +++++-
 3 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d3bffe8..bb55889 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3065,38 +3065,60 @@ int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
 
-int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
-		u8 *data, int len)
+static int dsi_vc_write_nosync_common(struct omap_dss_device *dssdev,
+		int channel, u8 *data, int len, enum dss_dsi_content_type type)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
-	BUG_ON(len == 0);
-
-	if (len == 1) {
+	if (len == 0) {
+		BUG_ON(type == DSS_DSI_CONTENT_DCS);
 		r = dsi_vc_send_short(dsidev, channel,
+				MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM, 0, 0);
+	} else if (len == 1) {
+		r = dsi_vc_send_short(dsidev, channel,
+				type == DSS_DSI_CONTENT_GENERIC ?
+				MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM :
 				MIPI_DSI_DCS_SHORT_WRITE, data[0], 0);
 	} else if (len == 2) {
 		r = dsi_vc_send_short(dsidev, channel,
+				type == DSS_DSI_CONTENT_GENERIC ?
+				MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM :
 				MIPI_DSI_DCS_SHORT_WRITE_PARAM,
 				data[0] | (data[1] << 8), 0);
 	} else {
-		/* 0x39 = DCS Long Write */
-		r = dsi_vc_send_long(dsidev, channel, MIPI_DSI_DCS_LONG_WRITE,
-				data, len, 0);
+		r = dsi_vc_send_long(dsidev, channel,
+				type == DSS_DSI_CONTENT_GENERIC ?
+				MIPI_DSI_GENERIC_LONG_WRITE :
+				MIPI_DSI_DCS_LONG_WRITE, data, len, 0);
 	}
 
 	return r;
 }
+
+int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len)
+{
+	return dsi_vc_write_nosync_common(dssdev, channel, data, len,
+			DSS_DSI_CONTENT_DCS);
+}
 EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 
-int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
-		int len)
+int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len)
+{
+	return dsi_vc_write_nosync_common(dssdev, channel, data, len,
+			DSS_DSI_CONTENT_GENERIC);
+}
+EXPORT_SYMBOL(dsi_vc_generic_write_nosync);
+
+static int dsi_vc_write_common(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len, enum dss_dsi_content_type type)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
-	r = dsi_vc_dcs_write_nosync(dssdev, channel, data, len);
+	r = dsi_vc_write_nosync_common(dssdev, channel, data, len, type);
 	if (r)
 		goto err;
 
@@ -3114,18 +3136,39 @@ int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 
 	return 0;
 err:
-	DSSERR("dsi_vc_dcs_write(ch %d, cmd 0x%02x, len %d) failed\n",
+	DSSERR("dsi_vc_write_common(ch %d, cmd 0x%02x, len %d) failed\n",
 			channel, data[0], len);
 	return r;
 }
+
+int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+		int len)
+{
+	return dsi_vc_write_common(dssdev, channel, data, len,
+			DSS_DSI_CONTENT_DCS);
+}
 EXPORT_SYMBOL(dsi_vc_dcs_write);
 
+int dsi_vc_generic_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+		int len)
+{
+	return dsi_vc_write_common(dssdev, channel, data, len,
+			DSS_DSI_CONTENT_GENERIC);
+}
+EXPORT_SYMBOL(dsi_vc_generic_write);
+
 int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd)
 {
 	return dsi_vc_dcs_write(dssdev, channel, &dcs_cmd, 1);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_0);
 
+int dsi_vc_generic_write_0(struct omap_dss_device *dssdev, int channel)
+{
+	return dsi_vc_generic_write(dssdev, channel, NULL, 0);
+}
+EXPORT_SYMBOL(dsi_vc_generic_write_0);
+
 int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 param)
 {
@@ -3136,6 +3179,23 @@ int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_1);
 
+int dsi_vc_generic_write_1(struct omap_dss_device *dssdev, int channel,
+		u8 param)
+{
+	return dsi_vc_generic_write(dssdev, channel, &param, 1);
+}
+EXPORT_SYMBOL(dsi_vc_generic_write_1);
+
+int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
+		u8 param1, u8 param2)
+{
+	u8 buf[2];
+	buf[0] = param1;
+	buf[1] = param2;
+	return dsi_vc_generic_write(dssdev, channel, buf, 2);
+}
+EXPORT_SYMBOL(dsi_vc_generic_write_2);
+
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a095a62..3ec8dd7 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -108,6 +108,11 @@ enum dss_hdmi_venc_clk_source_select {
 	DSS_HDMI_M_PCLK = 1,
 };
 
+enum dss_dsi_content_type {
+	DSS_DSI_CONTENT_DCS,
+	DSS_DSI_CONTENT_GENERIC,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2babe7e..00462cd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -225,12 +225,20 @@ void dsi_bus_lock(struct omap_dss_device *dssdev);
 void dsi_bus_unlock(struct omap_dss_device *dssdev);
 int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 		int len);
-int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel,
-		u8 dcs_cmd);
+int dsi_vc_generic_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+		int len);
+int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd);
+int dsi_vc_generic_write_0(struct omap_dss_device *dssdev, int channel);
 int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 param);
+int dsi_vc_generic_write_1(struct omap_dss_device *dssdev, int channel,
+		u8 param);
+int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
+		u8 param1, u8 param2);
 int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len);
+int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len);
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen);
 int dsi_vc_dcs_read_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-- 
1.7.1

