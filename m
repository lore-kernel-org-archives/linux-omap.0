From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAP: DSS2: DSI: disable manager on framedone timeout
Date: Mon, 21 Jun 2010 16:40:21 +0530
Message-ID: <1277118621-2086-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35710 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab0FULKc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 07:10:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the case of a dispc framedone timeout, we should set the LCD_EN
bit in DISPC_CONTROL to 0 and reset the dsi tx fifo so that the next
panel update call goes through cleanly.

With the new way of handling dispc framedone interrupts, since everything
is handled in irq context, the only reason a dispc framedone timeout
may occur is because of some dispc hardware issue.

Resetting the TX FIFO is listed as an errata and hence shouldn't be
performed on a dispc framedone timeout. But in the case of timeout,
we need to disable the manager so that atleast DISPC is in a clean
state for the next panel update call.

Starting a new DSI transfer with the DSI TX fifo already having content
of the previous frame is not desirable, but it is better than not to have
any future panel updates at all.

This patch version removes the reset_tx_fifo call as per required by the
errata.
---
 drivers/video/omap2/dss/dsi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6e0f64..1c4925c
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2764,6 +2764,7 @@ static void dsi_te_timeout(unsigned long arg)
 static void dsi_handle_framedone(int error)
 {
 	const int channel = dsi.update_channel;
+	struct omap_dss_device *device = dsi.vc[channel].dssdev;
 
 	cancel_delayed_work(&dsi.framedone_timeout_work);
 
@@ -2774,6 +2775,9 @@ static void dsi_handle_framedone(int error)
 
 	dsi.bta_callback = NULL;
 
+	if (error == -ETIMEDOUT)
+		device->manager->disable(device->manager);
+
 	if (dsi.te_enabled) {
 		/* enable LP_RX_TO again after the TE */
 		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
-- 
1.6.3.3

