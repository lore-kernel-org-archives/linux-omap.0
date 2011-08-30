From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/10] OMAP: DSS2: DSI: Introduce generic read functions
Date: Tue, 30 Aug 2011 16:21:32 +0530
Message-ID: <1314701495-11247-8-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42700 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1H3Kxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 06:53:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArX58000774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:33 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UArWxT004827
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:32 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArWhp025373
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:32 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Introduce read functions which use generic Processor-to-Peripheral
transaction types. These are needed by some devices which may not support
corresponding DCS commands.

Add function dsi_vc_generic_send_read_request() which can send
a short packet with 0, 1 or 2 bytes of request data and the corresponding
generic data type.

Rename function dsi_vc_dcs_read_rx_fifo() to dsi_vc_read_rx_fifo() and modify
it to take the enum "dss_dsi_content_type" as an argument to use either DCS
or GENERIC Peripheral-to-Processor transaction types while parsing data read
from the device.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  146 ++++++++++++++++++++++++++++++++++++++---
 include/video/omapdss.h       |    6 ++
 2 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c26a914..20cad1b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3217,8 +3217,44 @@ static int dsi_vc_dcs_send_read_request(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
-		u8 *buf, int buflen)
+static int dsi_vc_generic_send_read_request(struct omap_dss_device *dssdev,
+		int channel, u8 *reqdata, int reqlen)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	u16 data;
+	u8 data_type;
+	int r;
+
+	if (dsi->debug_read)
+		DSSDBG("dsi_vc_generic_send_read_request(ch %d, reqlen %d)\n",
+			channel, reqlen);
+
+	if (reqlen == 0) {
+		data_type = MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM;
+		data = 0;
+	} else if (reqlen == 1) {
+		data_type = MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM;
+		data = reqdata[0];
+	} else if (reqlen == 2) {
+		data_type = MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM;
+		data = reqdata[0] | (reqdata[1] << 8);
+	} else {
+		BUG();
+	}
+
+	r = dsi_vc_send_short(dsidev, channel, data_type, data, 0);
+	if (r) {
+		DSSERR("dsi_vc_generic_send_read_request(ch %d, reqlen %d)"
+			" failed\n", channel, reqlen);
+		return r;
+	}
+
+	return 0;
+}
+
+static int dsi_vc_read_rx_fifo(struct platform_device *dsidev, int channel,
+		u8 *buf, int buflen, enum dss_dsi_content_type type)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 val;
@@ -3242,10 +3278,14 @@ static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
 		r = -EIO;
 		goto err;
 
-	} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE) {
+	} else if (dt == (type == DSS_DSI_CONTENT_GENERIC ?
+			MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE :
+			MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE)) {
 		u8 data = FLD_GET(val, 15, 8);
 		if (dsi->debug_read)
-			DSSDBG("\tDCS short response, 1 byte: %02x\n", data);
+			DSSDBG("\t%s short response, 1 byte: %02x\n",
+				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
+				"DCS", data);
 
 		if (buflen < 1) {
 			r = -EIO;
@@ -3255,10 +3295,14 @@ static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
 		buf[0] = data;
 
 		return 1;
-	} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
+	} else if (dt == (type == DSS_DSI_CONTENT_GENERIC ?
+			MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE :
+			MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE)) {
 		u16 data = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
-			DSSDBG("\tDCS short response, 2 byte: %04x\n", data);
+			DSSDBG("\t%s short response, 2 byte: %04x\n",
+				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
+				"DCS", data);
 
 		if (buflen < 2) {
 			r = -EIO;
@@ -3269,11 +3313,15 @@ static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
 		buf[1] = (data >> 8) & 0xff;
 
 		return 2;
-	} else if (dt == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
+	} else if (dt == (type == DSS_DSI_CONTENT_GENERIC ?
+			MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE :
+			MIPI_DSI_RX_DCS_LONG_READ_RESPONSE)) {
 		int w;
 		int len = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
-			DSSDBG("\tDCS long response, len %d\n", len);
+			DSSDBG("\t%s long response, len %d\n",
+				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
+				"DCS", len);
 
 		if (len > buflen) {
 			r = -EIO;
@@ -3309,7 +3357,8 @@ static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
 
 	BUG();
 err:
-	DSSERR("dsi_vc_dcs_read_rx_fifo(ch %d) failed\n", channel);
+	DSSERR("dsi_vc_read_rx_fifo(ch %d type %s) failed\n", channel,
+		type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" : "DCS");
 
 	return r;
 }
@@ -3328,7 +3377,8 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	if (r)
 		goto err;
 
-	r = dsi_vc_dcs_read_rx_fifo(dsidev, channel, buf, buflen);
+	r = dsi_vc_read_rx_fifo(dsidev, channel, buf, buflen,
+		DSS_DSI_CONTENT_DCS);
 	if (r < 0)
 		goto err;
 
@@ -3344,6 +3394,82 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
+static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
+		u8 *reqdata, int reqlen, u8 *buf, int buflen)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int r;
+
+	r = dsi_vc_generic_send_read_request(dssdev, channel, reqdata, reqlen);
+	if (r)
+		return r;
+
+	r = dsi_vc_send_bta_sync(dssdev, channel);
+	if (r)
+		return r;
+
+	r = dsi_vc_read_rx_fifo(dsidev, channel, buf, buflen,
+		DSS_DSI_CONTENT_GENERIC);
+	if (r < 0)
+		return r;
+
+	if (r != buflen) {
+		r = -EIO;
+		return r;
+	}
+
+	return 0;
+}
+
+int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
+		int buflen)
+{
+	int r;
+
+	r = dsi_vc_generic_read(dssdev, channel, NULL, 0, buf, buflen);
+	if (r) {
+		DSSERR("dsi_vc_generic_read_0(ch %d) failed\n", channel);
+		return r;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dsi_vc_generic_read_0);
+
+int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
+		u8 *buf, int buflen)
+{
+	int r;
+
+	r = dsi_vc_generic_read(dssdev, channel, &param, 1, buf, buflen);
+	if (r) {
+		DSSERR("dsi_vc_generic_read_1(ch %d) failed\n", channel);
+		return r;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dsi_vc_generic_read_1);
+
+int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
+		u8 param1, u8 param2, u8 *buf, int buflen)
+{
+	int r;
+	u8 reqdata[2];
+
+	reqdata[0] = param1;
+	reqdata[1] = param2;
+
+	r = dsi_vc_generic_read(dssdev, channel, reqdata, 2, buf, buflen);
+	if (r) {
+		DSSERR("dsi_vc_generic_read_2(ch %d) failed\n", channel);
+		return r;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dsi_vc_generic_read_2);
+
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index af30e1f..8c94d95 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -241,6 +241,12 @@ int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len);
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen);
+int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
+		int buflen);
+int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
+		u8 *buf, int buflen);
+int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
+		u8 param1, u8 param2, u8 *buf, int buflen);
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len);
 int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
-- 
1.7.1

