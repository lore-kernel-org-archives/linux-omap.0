From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/10] OMAP: DSS2: Use MIPI DSI transacition types and commands from include/video/mipi_display.h
Date: Tue, 30 Aug 2011 16:21:26 +0530
Message-ID: <1314701495-11247-2-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42685 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab1H3KxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 06:53:10 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UAr9PA000726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:09 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UAr942021052
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:09 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAr9JX024973
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:09 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

MIPI DSI Transaction types and DCS commands are currently defined as macros in
dsi.c and panel-taal.c, remove these and replace them with enum members defined
in include/video/mipi_display.h.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   45 +++++++++-----------------
 drivers/video/omap2/dss/dsi.c             |   48 +++++++++++-----------------
 2 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4e888ac..7675687 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -35,26 +35,12 @@
 
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
+#include <video/mipi_display.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
 #define TCH 0
 
 #define DCS_READ_NUM_ERRORS	0x05
-#define DCS_READ_POWER_MODE	0x0a
-#define DCS_READ_MADCTL		0x0b
-#define DCS_READ_PIXEL_FORMAT	0x0c
-#define DCS_RDDSDR		0x0f
-#define DCS_SLEEP_IN		0x10
-#define DCS_SLEEP_OUT		0x11
-#define DCS_DISPLAY_OFF		0x28
-#define DCS_DISPLAY_ON		0x29
-#define DCS_COLUMN_ADDR		0x2a
-#define DCS_PAGE_ADDR		0x2b
-#define DCS_MEMORY_WRITE	0x2c
-#define DCS_TEAR_OFF		0x34
-#define DCS_TEAR_ON		0x35
-#define DCS_MEM_ACC_CTRL	0x36
-#define DCS_PIXEL_FORMAT	0x3a
 #define DCS_BRIGHTNESS		0x51
 #define DCS_CTRL_DISPLAY	0x53
 #define DCS_WRITE_CABC		0x55
@@ -302,7 +288,7 @@ static int taal_sleep_in(struct taal_data *td)
 
 	hw_guard_wait(td);
 
-	cmd = DCS_SLEEP_IN;
+	cmd = MIPI_DCS_ENTER_SLEEP_MODE;
 	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, &cmd, 1);
 	if (r)
 		return r;
@@ -321,7 +307,7 @@ static int taal_sleep_out(struct taal_data *td)
 
 	hw_guard_wait(td);
 
-	r = taal_dcs_write_0(td, DCS_SLEEP_OUT);
+	r = taal_dcs_write_0(td, MIPI_DCS_EXIT_SLEEP_MODE);
 	if (r)
 		return r;
 
@@ -356,7 +342,7 @@ static int taal_set_addr_mode(struct taal_data *td, u8 rotate, bool mirror)
 	u8 mode;
 	int b5, b6, b7;
 
-	r = taal_dcs_read_1(td, DCS_READ_MADCTL, &mode);
+	r = taal_dcs_read_1(td, MIPI_DCS_GET_ADDRESS_MODE, &mode);
 	if (r)
 		return r;
 
@@ -390,7 +376,7 @@ static int taal_set_addr_mode(struct taal_data *td, u8 rotate, bool mirror)
 	mode &= ~((1<<7) | (1<<6) | (1<<5));
 	mode |= (b7 << 7) | (b6 << 6) | (b5 << 5);
 
-	return taal_dcs_write_1(td, DCS_MEM_ACC_CTRL, mode);
+	return taal_dcs_write_1(td, MIPI_DCS_SET_ADDRESS_MODE, mode);
 }
 
 static int taal_set_update_window(struct taal_data *td,
@@ -403,7 +389,7 @@ static int taal_set_update_window(struct taal_data *td,
 	u16 y2 = y + h - 1;
 
 	u8 buf[5];
-	buf[0] = DCS_COLUMN_ADDR;
+	buf[0] = MIPI_DCS_SET_COLUMN_ADDRESS;
 	buf[1] = (x1 >> 8) & 0xff;
 	buf[2] = (x1 >> 0) & 0xff;
 	buf[3] = (x2 >> 8) & 0xff;
@@ -413,7 +399,7 @@ static int taal_set_update_window(struct taal_data *td,
 	if (r)
 		return r;
 
-	buf[0] = DCS_PAGE_ADDR;
+	buf[0] = MIPI_DCS_SET_PAGE_ADDRESS;
 	buf[1] = (y1 >> 8) & 0xff;
 	buf[2] = (y1 >> 0) & 0xff;
 	buf[3] = (y2 >> 8) & 0xff;
@@ -1195,7 +1181,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	r = taal_dcs_write_1(td, DCS_PIXEL_FORMAT, 0x7); /* 24bit/pixel */
+	r = taal_dcs_write_1(td, MIPI_DCS_SET_PIXEL_FORMAT,
+		MIPI_DCS_PIXEL_FMT_24BIT);
 	if (r)
 		goto err;
 
@@ -1209,7 +1196,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 			goto err;
 	}
 
-	r = taal_dcs_write_0(td, DCS_DISPLAY_ON);
+	r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_ON);
 	if (r)
 		goto err;
 
@@ -1246,7 +1233,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 
-	r = taal_dcs_write_0(td, DCS_DISPLAY_OFF);
+	r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_OFF);
 	if (!r)
 		r = taal_sleep_in(td);
 
@@ -1529,9 +1516,9 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	int r;
 
 	if (enable)
-		r = taal_dcs_write_1(td, DCS_TEAR_ON, 0);
+		r = taal_dcs_write_1(td, MIPI_DCS_SET_TEAR_ON, 0);
 	else
-		r = taal_dcs_write_0(td, DCS_TEAR_OFF);
+		r = taal_dcs_write_0(td, MIPI_DCS_SET_TEAR_OFF);
 
 	if (!panel_data->use_ext_te)
 		omapdss_dsi_enable_te(dssdev, enable);
@@ -1851,7 +1838,7 @@ static void taal_esd_work(struct work_struct *work)
 		goto err;
 	}
 
-	r = taal_dcs_read_1(td, DCS_RDDSDR, &state1);
+	r = taal_dcs_read_1(td, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state1);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to read Taal status\n");
 		goto err;
@@ -1864,7 +1851,7 @@ static void taal_esd_work(struct work_struct *work)
 		goto err;
 	}
 
-	r = taal_dcs_read_1(td, DCS_RDDSDR, &state2);
+	r = taal_dcs_read_1(td, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state2);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to read Taal status\n");
 		goto err;
@@ -1880,7 +1867,7 @@ static void taal_esd_work(struct work_struct *work)
 	/* Self-diagnostics result is also shown on TE GPIO line. We need
 	 * to re-enable TE after self diagnostics */
 	if (td->te_enabled && panel_data->use_ext_te) {
-		r = taal_dcs_write_1(td, DCS_TEAR_ON, 0);
+		r = taal_dcs_write_1(td, MIPI_DCS_SET_TEAR_ON, 0);
 		if (r)
 			goto err;
 	}
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 52a4a02..6735e0c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -39,6 +39,7 @@
 #include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
+#include <video/mipi_display.h>
 #include <plat/clock.h>
 
 #include "dss.h"
@@ -198,18 +199,6 @@ struct dsi_reg { u16 idx; };
 	 DSI_CIO_IRQ_ERRCONTENTIONLP0_4 | DSI_CIO_IRQ_ERRCONTENTIONLP1_4 | \
 	 DSI_CIO_IRQ_ERRCONTENTIONLP0_5 | DSI_CIO_IRQ_ERRCONTENTIONLP1_5)
 
-#define DSI_DT_DCS_SHORT_WRITE_0	0x05
-#define DSI_DT_DCS_SHORT_WRITE_1	0x15
-#define DSI_DT_DCS_READ			0x06
-#define DSI_DT_SET_MAX_RET_PKG_SIZE	0x37
-#define DSI_DT_NULL_PACKET		0x09
-#define DSI_DT_DCS_LONG_WRITE		0x39
-
-#define DSI_DT_RX_ACK_WITH_ERR		0x02
-#define DSI_DT_RX_DCS_LONG_READ		0x1c
-#define DSI_DT_RX_SHORT_READ_1		0x21
-#define DSI_DT_RX_SHORT_READ_2		0x22
-
 typedef void (*omap_dsi_isr_t) (void *arg, u32 mask);
 
 #define DSI_MAX_NR_ISRS                2
@@ -2887,16 +2876,16 @@ static u16 dsi_vc_flush_receive_data(struct platform_device *dsidev,
 		val = dsi_read_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel));
 		DSSERR("\trawval %#08x\n", val);
 		dt = FLD_GET(val, 5, 0);
-		if (dt == DSI_DT_RX_ACK_WITH_ERR) {
+		if (dt == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT) {
 			u16 err = FLD_GET(val, 23, 8);
 			dsi_show_rx_ack_with_err(err);
-		} else if (dt == DSI_DT_RX_SHORT_READ_1) {
+		} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE) {
 			DSSERR("\tDCS short response, 1 byte: %#x\n",
 					FLD_GET(val, 23, 8));
-		} else if (dt == DSI_DT_RX_SHORT_READ_2) {
+		} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
 			DSSERR("\tDCS short response, 2 byte: %#x\n",
 					FLD_GET(val, 23, 8));
-		} else if (dt == DSI_DT_RX_DCS_LONG_READ) {
+		} else if (dt == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
 			DSSERR("\tDCS long response, len %d\n",
 					FLD_GET(val, 23, 8));
 			dsi_vc_flush_long_data(dsidev, channel);
@@ -3101,7 +3090,7 @@ int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	u8 nullpkg[] = {0, 0, 0, 0};
 
-	return dsi_vc_send_long(dsidev, channel, DSI_DT_NULL_PACKET, nullpkg,
+	return dsi_vc_send_long(dsidev, channel, MIPI_DSI_NULL_PACKET, nullpkg,
 		4, 0);
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
@@ -3115,14 +3104,15 @@ int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
 	BUG_ON(len == 0);
 
 	if (len == 1) {
-		r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_SHORT_WRITE_0,
-				data[0], 0);
+		r = dsi_vc_send_short(dsidev, channel,
+				MIPI_DSI_DCS_SHORT_WRITE, data[0], 0);
 	} else if (len == 2) {
-		r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_SHORT_WRITE_1,
+		r = dsi_vc_send_short(dsidev, channel,
+				MIPI_DSI_DCS_SHORT_WRITE_PARAM,
 				data[0] | (data[1] << 8), 0);
 	} else {
 		/* 0x39 = DCS Long Write */
-		r = dsi_vc_send_long(dsidev, channel, DSI_DT_DCS_LONG_WRITE,
+		r = dsi_vc_send_long(dsidev, channel, MIPI_DSI_DCS_LONG_WRITE,
 				data, len, 0);
 	}
 
@@ -3188,7 +3178,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	if (dsi->debug_read)
 		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %x)\n", channel, dcs_cmd);
 
-	r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_READ, dcs_cmd, 0);
+	r = dsi_vc_send_short(dsidev, channel, MIPI_DSI_DCS_READ, dcs_cmd, 0);
 	if (r)
 		goto err;
 
@@ -3207,13 +3197,13 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	if (dsi->debug_read)
 		DSSDBG("\theader: %08x\n", val);
 	dt = FLD_GET(val, 5, 0);
-	if (dt == DSI_DT_RX_ACK_WITH_ERR) {
+	if (dt == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT) {
 		u16 err = FLD_GET(val, 23, 8);
 		dsi_show_rx_ack_with_err(err);
 		r = -EIO;
 		goto err;
 
-	} else if (dt == DSI_DT_RX_SHORT_READ_1) {
+	} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE) {
 		u8 data = FLD_GET(val, 15, 8);
 		if (dsi->debug_read)
 			DSSDBG("\tDCS short response, 1 byte: %02x\n", data);
@@ -3226,7 +3216,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		buf[0] = data;
 
 		return 1;
-	} else if (dt == DSI_DT_RX_SHORT_READ_2) {
+	} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
 		u16 data = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
 			DSSDBG("\tDCS short response, 2 byte: %04x\n", data);
@@ -3240,7 +3230,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		buf[1] = (data >> 8) & 0xff;
 
 		return 2;
-	} else if (dt == DSI_DT_RX_DCS_LONG_READ) {
+	} else if (dt == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
 		int w;
 		int len = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
@@ -3330,8 +3320,8 @@ int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 
-	return dsi_vc_send_short(dsidev, channel, DSI_DT_SET_MAX_RET_PKG_SIZE,
-			len, 0);
+	return dsi_vc_send_short(dsidev, channel,
+			MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE, len, 0);
 }
 EXPORT_SYMBOL(dsi_vc_set_max_rx_packet_size);
 
@@ -3690,7 +3680,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	l = FLD_VAL(total_len, 23, 0); /* TE_SIZE */
 	dsi_write_reg(dsidev, DSI_VC_TE(channel), l);
 
-	dsi_vc_write_long_header(dsidev, channel, DSI_DT_DCS_LONG_WRITE,
+	dsi_vc_write_long_header(dsidev, channel, MIPI_DSI_DCS_LONG_WRITE,
 		packet_len, 0);
 
 	if (dsi->te_enabled)
-- 
1.7.1

