From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 12/13] OMAP: DSS2: DSI: configure all DSI VCs
Date: Mon,  8 Feb 2010 17:56:11 +0200
Message-ID: <1265644572-3578-13-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-10-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-11-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-12-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45715 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0BHPxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:53:54 -0500
In-Reply-To: <1265644572-3578-12-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Instead of configuring only VC0 to be usable, configure all four VCs
similarly. This is needed to utilize the other VCs.

Setting the FIFO sizes evenly for all VCs, regardless of how many VCs are
actually used, is not optimal. However, this affects only cases when
larger amounts of data are written or read via L4, meaning that normal use
cases are not affected.

At some point this could be optimized better to suit different use cases.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e003fe9..131bd53 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -224,7 +224,6 @@ static struct
 		enum dsi_vc_mode mode;
 		struct omap_dss_device *dssdev;
 		enum fifo_size fifo_size;
-		int dest_per;	/* destination peripheral 0-3 */
 	} vc[4];
 
 	struct mutex lock;
@@ -2020,8 +2019,7 @@ static inline void dsi_vc_write_long_header(int channel, u8 data_type,
 
 	WARN_ON(!dsi_bus_is_locked());
 
-	/*data_id = data_type | channel << 6; */
-	data_id = data_type | dsi.vc[channel].dest_per << 6;
+	data_id = data_type | channel << 6;
 
 	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
 		FLD_VAL(ecc, 31, 24);
@@ -2127,7 +2125,7 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 		return -EINVAL;
 	}
 
-	data_id = data_type | dsi.vc[channel].dest_per << 6;
+	data_id = data_type | channel << 6;
 
 	r = (data_id << 0) | (data << 8) | (ecc << 24);
 
@@ -2529,15 +2527,15 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	u32 r;
 	int buswidth = 0;
 
-	dsi_config_tx_fifo(DSI_FIFO_SIZE_128,
-			DSI_FIFO_SIZE_0,
-			DSI_FIFO_SIZE_0,
-			DSI_FIFO_SIZE_0);
+	dsi_config_tx_fifo(DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32);
 
-	dsi_config_rx_fifo(DSI_FIFO_SIZE_128,
-			DSI_FIFO_SIZE_0,
-			DSI_FIFO_SIZE_0,
-			DSI_FIFO_SIZE_0);
+	dsi_config_rx_fifo(DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32,
+			DSI_FIFO_SIZE_32);
 
 	/* XXX what values for the timeouts? */
 	dsi_set_stop_state_counter(1000);
@@ -2575,12 +2573,9 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	dsi_write_reg(DSI_CTRL, r);
 
 	dsi_vc_initial_config(0);
-
-	/* set all vc targets to peripheral 0 */
-	dsi.vc[0].dest_per = 0;
-	dsi.vc[1].dest_per = 0;
-	dsi.vc[2].dest_per = 0;
-	dsi.vc[3].dest_per = 0;
+	dsi_vc_initial_config(1);
+	dsi_vc_initial_config(2);
+	dsi_vc_initial_config(3);
 
 	return 0;
 }
@@ -2846,9 +2841,6 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	if (bytespf % packet_payload)
 		total_len += (bytespf % packet_payload) + 1;
 
-	if (0)
-		dsi_vc_print_status(1);
-
 	l = FLD_VAL(total_len, 23, 0); /* TE_SIZE */
 	dsi_write_reg(DSI_VC_TE(channel), l);
 
@@ -3014,7 +3006,7 @@ static void dsi_handle_framedone(void)
 	/* RX_FIFO_NOT_EMPTY */
 	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {
 		DSSERR("Received error during frame transfer:\n");
-		dsi_vc_flush_receive_data(0);
+		dsi_vc_flush_receive_data(channel);
 	}
 
 #ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
@@ -3268,6 +3260,9 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	/* enable interface */
 	dsi_vc_enable(0, 1);
+	dsi_vc_enable(1, 1);
+	dsi_vc_enable(2, 1);
+	dsi_vc_enable(3, 1);
 	dsi_if_enable(1);
 	dsi_force_tx_stop_mode_io();
 
-- 
1.6.5

