From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 10/13] OMAP: DSS2: DSI: add helpers for DCS read/write
Date: Mon,  8 Feb 2010 17:56:09 +0200
Message-ID: <1265644572-3578-11-git-send-email-tomi.valkeinen@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65028 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0BHPyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:54:08 -0500
In-Reply-To: <1265644572-3578-10-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Add helper functions for most common DCS read and write operations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 ++
 drivers/video/omap2/dss/dsi.c             |   30 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c66e464..47df5f6 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -233,8 +233,11 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 void dsi_bus_lock(void);
 void dsi_bus_unlock(void);
 int dsi_vc_dcs_write(int channel, u8 *data, int len);
+int dsi_vc_dcs_write_0(int channel, u8 dcs_cmd);
+int dsi_vc_dcs_write_1(int channel, u8 dcs_cmd, u8 param);
 int dsi_vc_dcs_write_nosync(int channel, u8 *data, int len);
 int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen);
+int dsi_vc_dcs_read_1(int channel, u8 dcs_cmd, u8 *data);
 int dsi_vc_set_max_rx_packet_size(int channel, u16 len);
 int dsi_vc_send_null(int channel);
 int dsi_vc_send_bta_sync(int channel);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b389745..e49f063 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2176,6 +2176,21 @@ int dsi_vc_dcs_write(int channel, u8 *data, int len)
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write);
 
+int dsi_vc_dcs_write_0(int channel, u8 dcs_cmd)
+{
+	return dsi_vc_dcs_write(channel, &dcs_cmd, 1);
+}
+EXPORT_SYMBOL(dsi_vc_dcs_write_0);
+
+int dsi_vc_dcs_write_1(int channel, u8 dcs_cmd, u8 param)
+{
+	u8 buf[2];
+	buf[0] = dcs_cmd;
+	buf[1] = param;
+	return dsi_vc_dcs_write(channel, buf, 2);
+}
+EXPORT_SYMBOL(dsi_vc_dcs_write_1);
+
 int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
 {
 	u32 val;
@@ -2268,6 +2283,21 @@ int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
+int dsi_vc_dcs_read_1(int channel, u8 dcs_cmd, u8 *data)
+{
+	int r;
+
+	r = dsi_vc_dcs_read(channel, dcs_cmd, data, 1);
+
+	if (r < 0)
+		return r;
+
+	if (r != 1)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL(dsi_vc_dcs_read_1);
 
 int dsi_vc_set_max_rx_packet_size(int channel, u16 len)
 {
-- 
1.6.5

