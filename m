From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/10] OMAP: DSS2: DSI: Split dsi_vc_dcs_read() into 2 functions
Date: Tue, 30 Aug 2011 16:21:31 +0530
Message-ID: <1314701495-11247-7-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60348 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1H3Kx3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:29 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArSHK000574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:28 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UArS3X021109
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:28 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArSlF025305
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:28 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Split dsi_vc_dcs_read() into the functions:
- dsi_vc_dcs_send_read_request(): This is responsible for sending the short
packet command with the read request.
- dsi_vc_dcs_read_rx_fifo(): This parses the DSI RX fifo of the given virtual
channel, identifies the type of data received, and fills a buffer with the data
provided by the panel.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   61 +++++++++++++++++++++++++++++++++--------
 1 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8251647..c26a914 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3196,25 +3196,34 @@ int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_2);
 
-int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-		u8 *buf, int buflen)
+static int dsi_vc_dcs_send_read_request(struct omap_dss_device *dssdev,
+		int channel, u8 dcs_cmd)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	u32 val;
-	u8 dt;
 	int r;
 
 	if (dsi->debug_read)
-		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %x)\n", channel, dcs_cmd);
+		DSSDBG("dsi_vc_dcs_send_read_request(ch%d, dcs_cmd %x)\n",
+			channel, dcs_cmd);
 
 	r = dsi_vc_send_short(dsidev, channel, MIPI_DSI_DCS_READ, dcs_cmd, 0);
-	if (r)
-		goto err;
+	if (r) {
+		DSSERR("dsi_vc_dcs_send_read_request(ch %d, cmd 0x%02x)"
+			" failed\n", channel, dcs_cmd);
+		return r;
+	}
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
-	if (r)
-		goto err;
+	return 0;
+}
+
+static int dsi_vc_dcs_read_rx_fifo(struct platform_device *dsidev, int channel,
+		u8 *buf, int buflen)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	u32 val;
+	u8 dt;
+	int r;
 
 	/* RX_FIFO_NOT_EMPTY */
 	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20) == 0) {
@@ -3300,10 +3309,38 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 
 	BUG();
 err:
-	DSSERR("dsi_vc_dcs_read(ch %d, cmd 0x%02x) failed\n",
-			channel, dcs_cmd);
+	DSSERR("dsi_vc_dcs_read_rx_fifo(ch %d) failed\n", channel);
+
 	return r;
+}
+
+int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *buf, int buflen)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int r;
+
+	r = dsi_vc_dcs_send_read_request(dssdev, channel, dcs_cmd);
+	if (r)
+		goto err;
 
+	r = dsi_vc_send_bta_sync(dssdev, channel);
+	if (r)
+		goto err;
+
+	r = dsi_vc_dcs_read_rx_fifo(dsidev, channel, buf, buflen);
+	if (r < 0)
+		goto err;
+
+	if (r != buflen) {
+		r = -EIO;
+		goto err;
+	}
+
+	return 0;
+err:
+	DSSERR("dsi_vc_dcs_read(ch %d, cmd 0x%02x) failed\n", channel, dcs_cmd);
+	return r;
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
-- 
1.7.1

