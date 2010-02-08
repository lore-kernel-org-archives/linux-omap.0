From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 13/13] OMAP: DSS2: DSI: remove dsi_vc_print_status()
Date: Mon,  8 Feb 2010 17:56:12 +0200
Message-ID: <1265644572-3578-14-git-send-email-tomi.valkeinen@nokia.com>
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
 <1265644572-3578-13-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65087 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab0BHPyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:54:15 -0500
In-Reply-To: <1265644572-3578-13-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

It was not used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 131bd53..4b85ed2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1760,24 +1760,6 @@ static int dsi_force_tx_stop_mode_io(void)
 	return 0;
 }
 
-static void dsi_vc_print_status(int channel)
-{
-	u32 r;
-
-	r = dsi_read_reg(DSI_VC_CTRL(channel));
-	DSSDBG("vc %d: TX_FIFO_NOT_EMPTY %d, BTA_EN %d, VC_BUSY %d, "
-			"TX_FIFO_FULL %d, RX_FIFO_NOT_EMPTY %d, ",
-			channel,
-			FLD_GET(r, 5, 5),
-			FLD_GET(r, 6, 6),
-			FLD_GET(r, 15, 15),
-			FLD_GET(r, 16, 16),
-			FLD_GET(r, 20, 20));
-
-	r = dsi_read_reg(DSI_TX_FIFO_VC_EMPTINESS);
-	DSSDBG("EMPTINESS %d\n", (r >> (8 * channel)) & 0xff);
-}
-
 static int dsi_vc_enable(int channel, bool enable)
 {
 	if (dsi.update_mode != OMAP_DSS_UPDATE_AUTO)
@@ -2062,13 +2044,10 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
 
 	dsi_vc_write_long_header(channel, data_type, len, ecc);
 
-	/*dsi_vc_print_status(0); */
-
 	p = data;
 	for (i = 0; i < len >> 2; i++) {
 		if (dsi.debug_write)
 			DSSDBG("\tsending full packet %d\n", i);
-		/*dsi_vc_print_status(0); */
 
 		b1 = *p++;
 		b2 = *p++;
-- 
1.6.5

