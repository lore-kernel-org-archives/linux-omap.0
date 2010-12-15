From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Fix build breaks for rfbi.c and dsi.c
Date: Wed, 15 Dec 2010 08:46:52 +0530
Message-ID: <1292383012-22772-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39769 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab0LODQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 22:16:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The following patches caused compilation errors in rfbi.c and dsi.c:
OMAP: DSS2: Introduce omap_channel argument to DISPC functions used by interface drivers
OMAP: DSS2: Change remaining DISPC functions for new omap_channel argument

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c  |    2 +-
 drivers/video/omap2/dss/dss.h  |    2 +-
 drivers/video/omap2/dss/rfbi.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f00ebb3..ddf3a05 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2990,7 +2990,7 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 	cinfo.regm  = dssdev->phy.dsi.div.regm;
 	cinfo.regm3 = dssdev->phy.dsi.div.regm3;
 	cinfo.regm4 = dssdev->phy.dsi.div.regm4;
-	r = dsi_calc_clock_rates(&cinfo);
+	r = dsi_calc_clock_rates(dssdev, &cinfo);
 	if (r) {
 		DSSERR("Failed to calc dsi clocks\n");
 		return r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index dd51d3f..b394951 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -431,7 +431,7 @@ void rfbi_dump_regs(struct seq_file *s);
 
 int rfbi_configure(int rfbi_module, int bpp, int lines);
 void rfbi_enable_rfbi(bool enable);
-void rfbi_transfer_area(omap_dss_device *dssdev, u16 width,
+void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		u16 height, void (callback)(void *data), void *data);
 void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index c20a185..10a2ffe 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -301,7 +301,7 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-void rfbi_transfer_area(omap_dss_device *dssdev, u16 width,
+void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
-- 
1.7.0.4

