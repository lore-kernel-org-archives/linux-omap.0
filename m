From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 09/13] OMAP: DSS2: DSI: add dsi_bus_is_locked()
Date: Mon,  8 Feb 2010 17:56:08 +0200
Message-ID: <1265644572-3578-10-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-9-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65035 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0BHPyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:54:09 -0500
In-Reply-To: <1265644572-3578-9-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Helper function to clean up the checking of the bus lock.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4fdb628..b389745 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -309,6 +309,11 @@ void dsi_bus_unlock(void)
 }
 EXPORT_SYMBOL(dsi_bus_unlock);
 
+static bool dsi_bus_is_locked(void)
+{
+	return mutex_is_locked(&dsi.bus_lock);
+}
+
 static inline int wait_for_bit_change(const struct dsi_reg idx, int bitnum,
 		int value)
 {
@@ -1959,7 +1964,7 @@ static int dsi_vc_send_bta(int channel)
 			(dsi.debug_write || dsi.debug_read))
 		DSSDBG("dsi_vc_send_bta %d\n", channel);
 
-	WARN_ON(!mutex_is_locked(&dsi.bus_lock));
+	WARN_ON(!dsi_bus_is_locked());
 
 	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {	/* RX_FIFO_NOT_EMPTY */
 		DSSERR("rx fifo not empty when sending BTA, dumping data:\n");
@@ -2010,7 +2015,7 @@ static inline void dsi_vc_write_long_header(int channel, u8 data_type,
 	u32 val;
 	u8 data_id;
 
-	WARN_ON(!mutex_is_locked(&dsi.bus_lock));
+	WARN_ON(!dsi_bus_is_locked());
 
 	/*data_id = data_type | channel << 6; */
 	data_id = data_type | dsi.vc[channel].dest_per << 6;
@@ -2105,7 +2110,7 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 	u32 r;
 	u8 data_id;
 
-	WARN_ON(!mutex_is_locked(&dsi.bus_lock));
+	WARN_ON(!dsi_bus_is_locked());
 
 	if (dsi.debug_write)
 		DSSDBG("dsi_vc_send_short(ch%d, dt %#x, b1 %#x, b2 %#x)\n",
@@ -2895,7 +2900,7 @@ static int dsi_set_update_mode(struct omap_dss_device *dssdev,
 	int r = 0;
 	int i;
 
-	WARN_ON(!mutex_is_locked(&dsi.bus_lock));
+	WARN_ON(!dsi_bus_is_locked());
 
 	if (dsi.update_mode != mode) {
 		dsi.update_mode = mode;
-- 
1.6.5

