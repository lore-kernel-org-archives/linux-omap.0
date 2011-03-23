From: archit@ti.com
Subject: [PATCH] OMAP: DSS2: DSI: Introduce sync_vc functions
Date: Wed, 23 Mar 2011 15:29:34 +0530
Message-ID: <1300874374-23112-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab1CWJzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Mar 2011 05:55:18 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2N9tHn8018858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 04:55:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

The DSI protocol engine has no interrupt for signalling the end of a Frame
transfer. The present approach is to send a BTA after DISPC generates a
FRAMEDONE interrupt, and unlock the dsi bus only when the BTA Ack is received.

The assumption made with this approach was that OMAP will send a BTA only after
the long packet corresponding to the last line is sent. However, it is possible
that on the DISPC FRAMEDONE interrupt there are 2 (or more) lines of pixel data
in the DSI line buffer. Hence, the BTA Ack could be received for the long packet
corresponding to the second last line (or the third last and so on..).
Therefore, the current method doesn't ensure that the complete frame data is
sent before we start a new transfer. A similar explanation holds valid if we
send a BTA in between multiple short/long command packets from the slave port.

Introduce dsi_sync_vc functions, based on Tomi Valkeinen's idea, which ensure
that the DSI Virtual Channel in use(update_channel) completes its previous work
before proceeding to the next Frame/Command.

For a frame update, the DSI driver now sends a callback to the Panel Driver
on the FRAMEDONE interrupt itself. The callback in the panel driver then unlocks
the bus. dsi_sync_vc() functions are placed in dsi_vc_config_l4() and
dsi_vc_config_vp() to ensure that the previous task of the Virtual Channel is
completed.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note:
Applies over the master branch of the tree:
http://gitorious.org/linux-omap-dss2/linux/commits/master

 drivers/video/omap2/dss/dsi.c |  180 ++++++++++++++++++++++++++--------------
 1 files changed, 117 insertions(+), 63 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5614164..cfbb772 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2033,6 +2033,114 @@ static int dsi_force_tx_stop_mode_io(void)
 	return 0;
 }
 
+static bool dsi_vc_is_enabled(int channel)
+{
+	return REG_GET(DSI_VC_CTRL(channel), 0, 0);
+}
+
+static void dsi_packet_sent_handler_vp(void *data, u32 mask)
+{
+	const int channel = dsi.update_channel;
+	u8 bit = dsi.te_enabled ? 30 : 31;
+
+	if (REG_GET(DSI_VC_TE(channel), bit, bit) == 0)
+		complete((struct completion *)data);
+}
+
+static int dsi_sync_vc_vp(int channel)
+{
+	int r = 0;
+	u8 bit;
+
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	bit = dsi.te_enabled ? 30 : 31;
+
+	r = dsi_register_isr_vc(channel, dsi_packet_sent_handler_vp,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		goto err0;
+
+	/* Wait for completion only if TE_EN/TE_START is still set */
+	if (REG_GET(DSI_VC_TE(channel), bit, bit)) {
+		if (wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(10)) == 0) {
+			DSSERR("Failed to complete previous frame transfer\n");
+			r = -EIO;
+			goto err1;
+		}
+	}
+
+	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_vp,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
+
+	return 0;
+err1:
+	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_vp, &completion,
+		DSI_VC_IRQ_PACKET_SENT);
+err0:
+	return r;
+}
+
+static void dsi_packet_sent_handler_l4(void *data, u32 mask)
+{
+	const int channel = dsi.update_channel;
+
+	if (REG_GET(DSI_VC_CTRL(channel), 5, 5) == 0)
+		complete((struct completion *)data);
+}
+
+static int dsi_sync_vc_l4(int channel)
+{
+	int r = 0;
+
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	r = dsi_register_isr_vc(channel, dsi_packet_sent_handler_l4,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		goto err0;
+
+	/* Wait for completion only if TX_FIFO_NOT_EMPTY is still set */
+	if (REG_GET(DSI_VC_CTRL(channel), 5, 5)) {
+		if (wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(10)) == 0) {
+			DSSERR("Failed to complete previous l4 transfer\n");
+			r = -EIO;
+			goto err1;
+		}
+	}
+
+	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_l4,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
+
+	return 0;
+err1:
+	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_l4,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
+err0:
+	return r;
+}
+
+static int dsi_sync_vc(int channel)
+{
+	WARN_ON(!dsi_bus_is_locked());
+
+	WARN_ON(in_interrupt());
+
+	if (!dsi_vc_is_enabled(channel))
+		return 0;
+
+	switch (dsi.vc[channel].mode) {
+	case DSI_VC_MODE_VP:
+		return dsi_sync_vc_vp(channel);
+	case DSI_VC_MODE_L4:
+		return dsi_sync_vc_l4(channel);
+	default:
+		BUG();
+	}
+}
+
 static int dsi_vc_enable(int channel, bool enable)
 {
 	DSSDBG("dsi_vc_enable channel %d, enable %d\n",
@@ -2085,6 +2193,8 @@ static int dsi_vc_config_l4(int channel)
 
 	DSSDBGF("%d", channel);
 
+	dsi_sync_vc(channel);
+
 	dsi_vc_enable(channel, 0);
 
 	/* VC_BUSY */
@@ -2113,6 +2223,8 @@ static int dsi_vc_config_vp(int channel)
 
 	DSSDBGF("%d", channel);
 
+	dsi_sync_vc(channel);
+
 	dsi_vc_enable(channel, 0);
 
 	/* VC_BUSY */
@@ -3105,17 +3217,8 @@ static void dsi_te_timeout(unsigned long arg)
 }
 #endif
 
-static void dsi_framedone_bta_callback(void *data, u32 mask);
-
 static void dsi_handle_framedone(int error)
 {
-	const int channel = dsi.update_channel;
-
-	dsi_unregister_isr_vc(channel, dsi_framedone_bta_callback,
-			NULL, DSI_VC_IRQ_BTA);
-
-	cancel_delayed_work(&dsi.framedone_timeout_work);
-
 	/* SIDLEMODE back to smart-idle */
 	dispc_enable_sidle();
 
@@ -3124,14 +3227,6 @@ static void dsi_handle_framedone(int error)
 		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
 	}
 
-	/* RX_FIFO_NOT_EMPTY */
-	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {
-		DSSERR("Received error during frame transfer:\n");
-		dsi_vc_flush_receive_data(channel);
-		if (!error)
-			error = -EIO;
-	}
-
 	dsi.framedone_callback(error, dsi.framedone_data);
 
 	if (!error)
@@ -3152,61 +3247,20 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 	dsi_handle_framedone(-ETIMEDOUT);
 }
 
-static void dsi_framedone_bta_callback(void *data, u32 mask)
-{
-	dsi_handle_framedone(0);
-
-#ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
-	dispc_fake_vsync_irq();
-#endif
-}
-
 static void dsi_framedone_irq_callback(void *data, u32 mask)
 {
-	const int channel = dsi.update_channel;
-	int r;
-
 	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
 	 * turns itself off. However, DSI still has the pixels in its buffers,
 	 * and is sending the data.
 	 */
 
-	if (dsi.te_enabled) {
-		/* enable LP_RX_TO again after the TE */
-		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
-	}
+	__cancel_delayed_work(&dsi.framedone_timeout_work);
 
-	/* Send BTA after the frame. We need this for the TE to work, as TE
-	 * trigger is only sent for BTAs without preceding packet. Thus we need
-	 * to BTA after the pixel packets so that next BTA will cause TE
-	 * trigger.
-	 *
-	 * This is not needed when TE is not in use, but we do it anyway to
-	 * make sure that the transfer has been completed. It would be more
-	 * optimal, but more complex, to wait only just before starting next
-	 * transfer.
-	 *
-	 * Also, as there's no interrupt telling when the transfer has been
-	 * done and the channel could be reconfigured, the only way is to
-	 * busyloop until TE_SIZE is zero. With BTA we can do this
-	 * asynchronously.
-	 * */
-
-	r = dsi_register_isr_vc(channel, dsi_framedone_bta_callback,
-			NULL, DSI_VC_IRQ_BTA);
-	if (r) {
-		DSSERR("Failed to register BTA ISR\n");
-		dsi_handle_framedone(-EIO);
-		return;
-	}
+	dsi_handle_framedone(0);
 
-	r = dsi_vc_send_bta(channel);
-	if (r) {
-		DSSERR("BTA after framedone failed\n");
-		dsi_unregister_isr_vc(channel, dsi_framedone_bta_callback,
-				NULL, DSI_VC_IRQ_BTA);
-		dsi_handle_framedone(-EIO);
-	}
+#ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
+	dispc_fake_vsync_irq();
+#endif
 }
 
 int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
-- 
1.7.1

