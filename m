From: Archit Taneja <archit@ti.com>
Subject: [PATCH 05/10] OMAP: DSS2: DSI: Remove functions dsi_vc_dcs_read_1() and dsi_vc_dcs_read_2()
Date: Tue, 30 Aug 2011 16:21:30 +0530
Message-ID: <1314701495-11247-6-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60347 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab1H3KxZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:25 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArPib000570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:25 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArOVQ009404
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:24 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArOdZ025257
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:24 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove functions dsi_vc_dcs_read_1() and dsi_vc_dcs_read_2(), these are used
when the panel is expected to return 1 and 2 bytes respecitvely. This was manily
used for debugging purposes. These functions should be implemented in the panel
driver if needed.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   38 --------------------------------------
 include/video/omapdss.h       |    4 ----
 2 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index bb55889..8251647 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3307,44 +3307,6 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
-int dsi_vc_dcs_read_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-		u8 *data)
-{
-	int r;
-
-	r = dsi_vc_dcs_read(dssdev, channel, dcs_cmd, data, 1);
-
-	if (r < 0)
-		return r;
-
-	if (r != 1)
-		return -EIO;
-
-	return 0;
-}
-EXPORT_SYMBOL(dsi_vc_dcs_read_1);
-
-int dsi_vc_dcs_read_2(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-		u8 *data1, u8 *data2)
-{
-	u8 buf[2];
-	int r;
-
-	r = dsi_vc_dcs_read(dssdev, channel, dcs_cmd, buf, 2);
-
-	if (r < 0)
-		return r;
-
-	if (r != 2)
-		return -EIO;
-
-	*data1 = buf[0];
-	*data2 = buf[1];
-
-	return 0;
-}
-EXPORT_SYMBOL(dsi_vc_dcs_read_2);
-
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 00462cd..af30e1f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -241,10 +241,6 @@ int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len);
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen);
-int dsi_vc_dcs_read_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-		u8 *data);
-int dsi_vc_dcs_read_2(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
-		u8 *data1, u8 *data2);
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len);
 int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
-- 
1.7.1

