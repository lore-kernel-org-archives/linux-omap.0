From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/19] OMAP: DSS2: DSI: implement ULPS enter and exit
Date: Tue, 19 Apr 2011 12:22:06 +0300
Message-ID: <1303204942-25450-4-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39059 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051Ab1DSJWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:40 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Entering ULPS (Ultra Low Power State) happens by sending ULPS entry
sequence to the DSI peripheral and pulling the DSI lines down.

Exiting ULPS happens by sending ULPS exit sequence.

We can send the ULPS entry sequence by using OMAP DSS HW's ULPS support,
but we cannot use the ULPS exit support from DSS HW. DSS HW refuses to
send the ULPS exit sequence if it thinks that the lanes are not in ULPS.
After being in OFF mode the DSS HW has been reset, and so it does not
know that the lanes are actually in ULPS.

Thus we need to use the lane override support and manually send the ULPS
exit sequence. Luckily the sequence is very simple.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  141 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 013621e..5303548 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -33,6 +33,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/sched.h>
 
 #include <plat/display.h>
 #include <plat/clock.h>
@@ -268,6 +269,7 @@ static struct
 	struct dsi_update_region update_region;
 
 	bool te_enabled;
+	bool ulps_enabled;
 
 	struct workqueue_struct *workqueue;
 
@@ -1925,9 +1927,13 @@ static void dsi_disable_lane_override(void)
 static int dsi_complexio_init(struct omap_dss_device *dssdev)
 {
 	int r = 0;
+	u32 l;
 
 	DSSDBG("dsi_complexio_init\n");
 
+	if (dsi.ulps_enabled)
+		DSSDBG("manual ulps exit\n");
+
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
@@ -1941,11 +1947,49 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 
 	dsi_complexio_config(dssdev);
 
-	r = dsi_complexio_power(DSI_COMPLEXIO_POWER_ON);
+	dsi_if_enable(true);
+	dsi_if_enable(false);
+	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
+
+	/* set TX STOP MODE timer to maximum for this operation */
+	l = dsi_read_reg(DSI_TIMING1);
+	l = FLD_MOD(l, 1, 15, 15);	/* FORCE_TX_STOP_MODE_IO */
+	l = FLD_MOD(l, 1, 14, 14);	/* STOP_STATE_X16_IO */
+	l = FLD_MOD(l, 1, 13, 13);	/* STOP_STATE_X4_IO */
+	l = FLD_MOD(l, 0x1fff, 12, 0);	/* STOP_STATE_COUNTER_IO */
+	dsi_write_reg(DSI_TIMING1, l);
+
+	if (dsi.ulps_enabled) {
+		/* ULPS is exited by Mark-1 state for 1ms, followed by
+		 * stop state. DSS HW cannot do this via the normal
+		 * ULPS exit sequence, as after reset the DSS HW thinks
+		 * that we are not in ULPS mode, and refuses to send the
+		 * sequence. So we need to send the ULPS exit sequence
+		 * manually.
+		 */
+
+		dsi_enable_lane_override(dssdev,
+				DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P);
+	}
 
+	r = dsi_complexio_power(DSI_COMPLEXIO_POWER_ON);
 	if (r)
 		goto err;
 
+	if (dsi.ulps_enabled) {
+		/* Keep Mark-1 state for 1ms (as per DSI spec) */
+		ktime_t wait = ns_to_ktime(1000 * 1000);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&wait, HRTIMER_MODE_REL);
+
+		/* Disable the override. The lanes should be set to Mark-11
+		 * state by the HW */
+		dsi_disable_lane_override();
+	}
+
+	/* FORCE_TX_STOP_MODE_IO */
+	REG_FLD_MOD(DSI_TIMING1, 0, 15, 15);
+
 	if (wait_for_bit_change(DSI_COMPLEXIO_CFG1, 29, 1) != 1) {
 		DSSERR("ComplexIO not coming out of reset.\n");
 		r = -ENODEV;
@@ -1954,23 +1998,7 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 
 	dsi_complexio_timings();
 
-	/*
-	   The configuration of the DSI complex I/O (number of data lanes,
-	   position, differential order) should not be changed while
-	   DSS.DSI_CLK_CRTRL[20] LP_CLK_ENABLE bit is set to 1. For the
-	   hardware to recognize a new configuration of the complex I/O (done
-	   in DSS.DSI_COMPLEXIO_CFG1 register), it is recommended to follow
-	   this sequence: First set the DSS.DSI_CTRL[0] IF_EN bit to 1, next
-	   reset the DSS.DSI_CTRL[0] IF_EN to 0, then set DSS.DSI_CLK_CTRL[20]
-	   LP_CLK_ENABLE to 1, and finally, set again the DSS.DSI_CTRL[0] IF_EN
-	   bit to 1. If the sequence is not followed, the DSi complex I/O
-	   configuration is undetermined.
-	   */
-	dsi_if_enable(1);
-	dsi_if_enable(0);
-	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
-	dsi_if_enable(1);
-	dsi_if_enable(0);
+	dsi.ulps_enabled = false;
 
 	DSSDBG("CIO init done\n");
 err:
@@ -2793,6 +2821,80 @@ int dsi_vc_set_max_rx_packet_size(int channel, u16 len)
 }
 EXPORT_SYMBOL(dsi_vc_set_max_rx_packet_size);
 
+static int dsi_enter_ulps(void)
+{
+	DECLARE_COMPLETION_ONSTACK(completion);
+	int r;
+
+	DSSDBGF();
+
+	WARN_ON(!dsi_bus_is_locked());
+
+	WARN_ON(dsi.ulps_enabled);
+
+	if (dsi.ulps_enabled)
+		return 0;
+
+	if (REG_GET(DSI_CLK_CTRL, 13, 13)) {
+		DSSERR("DDR_CLK_ALWAYS_ON enabled when entering ULPS\n");
+		return -EIO;
+	}
+
+	dsi_sync_vc(0);
+	dsi_sync_vc(1);
+	dsi_sync_vc(2);
+	dsi_sync_vc(3);
+
+	dsi_force_tx_stop_mode_io();
+
+	dsi_vc_enable(0, false);
+	dsi_vc_enable(1, false);
+	dsi_vc_enable(2, false);
+	dsi_vc_enable(3, false);
+
+	if (REG_GET(DSI_COMPLEXIO_CFG2, 16, 16)) {	/* HS_BUSY */
+		DSSERR("HS busy when enabling ULPS\n");
+		return -EIO;
+	}
+
+	if (REG_GET(DSI_COMPLEXIO_CFG2, 17, 17)) {	/* LP_BUSY */
+		DSSERR("LP busy when enabling ULPS\n");
+		return -EIO;
+	}
+
+	r = dsi_register_isr_cio(dsi_completion_handler, &completion,
+			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
+	if (r)
+		return r;
+
+	/* Assert TxRequestEsc for data lanes and TxUlpsClk for clk lane */
+	/* LANEx_ULPS_SIG2 */
+	REG_FLD_MOD(DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2), 7, 5);
+
+	if (wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(1000)) == 0) {
+		DSSERR("ULPS enable timeout\n");
+		r = -EIO;
+		goto err;
+	}
+
+	dsi_unregister_isr_cio(dsi_completion_handler, &completion,
+			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
+
+	dsi_complexio_power(DSI_COMPLEXIO_POWER_ULPS);
+
+	dsi_if_enable(false);
+
+	dsi.ulps_enabled = true;
+
+	return 0;
+
+err:
+	dsi_unregister_isr_cio(dsi_completion_handler, &completion,
+			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
+	return r;
+}
+
 static void dsi_set_lp_rx_timeout(unsigned ticks, bool x4, bool x16)
 {
 	unsigned long fck;
@@ -3547,6 +3649,9 @@ err0:
 
 static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
 {
+	if (!dsi.ulps_enabled)
+		dsi_enter_ulps();
+
 	/* disable interface */
 	dsi_if_enable(0);
 	dsi_vc_enable(0, 0);
-- 
1.7.1

