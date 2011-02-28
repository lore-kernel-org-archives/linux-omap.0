From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: Taal: Use 2 DSI Virtual Channels for Taal
Date: Mon, 28 Feb 2011 14:17:29 +0530
Message-ID: <1298882849-7432-4-git-send-email-archit@ti.com>
References: <1298882849-7432-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57241 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab1B1IpG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:45:06 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S8j6cw002190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 02:45:06 -0600
In-Reply-To: <1298882849-7432-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Request 2 DSI Virtual channels for the Taal Panel. The first channel is used to
send control related commands to the Panel. The second is used to send the Pixel
data to the Panel through calling omap_dsi_update().

The 2 channels are named in the struct 'taal_data' as config_channel and
update_channel for sending control commands and pixel data respectively.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   41 +++++++++++++++++-----------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e7f9010..710547c 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -218,7 +218,8 @@ struct taal_data {
 		u16 w;
 		u16 h;
 	} update_region;
-	int channel;
+	int config_channel;
+	int update_channel;
 
 	struct delayed_work te_timeout_work;
 
@@ -264,7 +265,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 	int r;
 	u8 buf[1];
 
-	r = dsi_vc_dcs_read(td->channel, dcs_cmd, buf, 1);
+	r = dsi_vc_dcs_read(td->config_channel, dcs_cmd, buf, 1);
 
 	if (r < 0)
 		return r;
@@ -276,7 +277,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 
 static int taal_dcs_write_0(struct taal_data *td, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(td->channel, &dcs_cmd, 1);
+	return dsi_vc_dcs_write(td->config_channel, &dcs_cmd, 1);
 }
 
 static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
@@ -284,7 +285,7 @@ static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
 	u8 buf[2];
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(td->channel, buf, 2);
+	return dsi_vc_dcs_write(td->config_channel, buf, 2);
 }
 
 static int taal_sleep_in(struct taal_data *td)
@@ -296,7 +297,7 @@ static int taal_sleep_in(struct taal_data *td)
 	hw_guard_wait(td);
 
 	cmd = DCS_SLEEP_IN;
-	r = dsi_vc_dcs_write_nosync(td->channel, &cmd, 1);
+	r = dsi_vc_dcs_write_nosync(td->config_channel, &cmd, 1);
 	if (r)
 		return r;
 
@@ -402,7 +403,7 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (x2 >> 8) & 0xff;
 	buf[4] = (x2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(td->config_channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
@@ -412,11 +413,11 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (y2 >> 8) & 0xff;
 	buf[4] = (y2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(td->config_channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
-	dsi_vc_send_bta_sync(td->channel);
+	dsi_vc_send_bta_sync(td->config_channel);
 
 	return r;
 }
@@ -777,7 +778,13 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
 	}
 
-	r = omap_dsi_request_vc(dssdev, TCH, &td->channel);
+	r = omap_dsi_request_vc(dssdev, TCH, &td->config_channel);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to get virtual channel\n");
+		goto err_req_vc;
+	}
+
+	r = omap_dsi_request_vc(dssdev, TCH, &td->update_channel);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to get virtual channel\n");
 		goto err_req_vc;
@@ -858,7 +865,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_vc_enable_hs(td->channel, false);
+	omapdss_dsi_vc_enable_hs(td->config_channel, false);
+	omapdss_dsi_vc_enable_hs(td->update_channel, false);
 
 	r = taal_sleep_out(td);
 	if (r)
@@ -915,7 +923,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		td->intro_printed = true;
 	}
 
-	omapdss_dsi_vc_enable_hs(td->channel, true);
+	omapdss_dsi_vc_enable_hs(td->config_channel, true);
+	omapdss_dsi_vc_enable_hs(td->update_channel, true);
 
 	return 0;
 err:
@@ -1101,7 +1110,7 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 	if (old) {
 		cancel_delayed_work(&td->te_timeout_work);
 
-		r = omap_dsi_update(dssdev, td->channel,
+		r = omap_dsi_update(dssdev, td->update_channel,
 				td->update_region.x,
 				td->update_region.y,
 				td->update_region.w,
@@ -1165,7 +1174,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 				msecs_to_jiffies(250));
 		atomic_set(&td->do_update, 1);
 	} else {
-		r = omap_dsi_update(dssdev, td->channel, x, y, w, h,
+		r = omap_dsi_update(dssdev, td->update_channel, x, y, w, h,
 				taal_framedone_cb, dssdev);
 		if (r)
 			goto err;
@@ -1418,7 +1427,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 
 	taal_set_update_window(td, x, y, w, h);
 
-	r = dsi_vc_set_max_rx_packet_size(td->channel, plen);
+	r = dsi_vc_set_max_rx_packet_size(td->config_channel, plen);
 	if (r)
 		goto err2;
 
@@ -1426,7 +1435,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 		u8 dcs_cmd = first ? 0x2e : 0x3e;
 		first = 0;
 
-		r = dsi_vc_dcs_read(td->channel, dcs_cmd,
+		r = dsi_vc_dcs_read(td->config_channel, dcs_cmd,
 				buf + buf_used, size - buf_used);
 
 		if (r < 0) {
@@ -1452,7 +1461,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	r = buf_used;
 
 err3:
-	dsi_vc_set_max_rx_packet_size(td->channel, 1);
+	dsi_vc_set_max_rx_packet_size(td->config_channel, 1);
 err2:
 	dsi_bus_unlock();
 err1:
-- 
1.7.1

