From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: DSI: disable manager on framedone timeout
Date: Thu, 17 Jun 2010 13:59:55 +0530
Message-ID: <1276763395-23922-1-git-send-email-archit@ti.com>
References: =?ISO-8859-1?Q?=20<\=1B[1~>?=
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49243 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713Ab0FQIaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 04:30:06 -0400
In-Reply-To: =?ISO-8859-1?Q?=20<\=1B[1~>?=
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the case of a dsi framedone timeout, we should set the LCD_EN
bit to 0 and reset the dsi tx fifo so that the next panel update
call goes through cleanly.

With the new way of handling framedone interrupts, since everything
is handled in irq context, the only reason a framedone timeout occurs
is because of some hardware issue.

The reset of LCD_EN and flush of TX_FIFO won't interfere with a frame
in progress.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6e0f64..224ff97
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2764,6 +2764,7 @@ static void dsi_te_timeout(unsigned long arg)
 static void dsi_handle_framedone(int error)
 {
 	const int channel = dsi.update_channel;
+	struct omap_dss_device *device = dsi.vc[channel].dssdev;
 
 	cancel_delayed_work(&dsi.framedone_timeout_work);
 
@@ -2774,6 +2775,10 @@ static void dsi_handle_framedone(int error)
 
 	dsi.bta_callback = NULL;
 
+	if (error == -ETIMEDOUT) {
+		device->manager->disable(device->manager);
+		dsi_reset_tx_fifo(channel);
+	}
 	if (dsi.te_enabled) {
 		/* enable LP_RX_TO again after the TE */
 		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
-- 
1.6.3.3

