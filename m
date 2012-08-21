From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/23] OMAPDSS: DSI: Remove dsi_pdev_map global struct
Date: Tue, 21 Aug 2012 11:28:18 +0530
Message-ID: <1345528711-27801-12-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33225 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2HUGAz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:55 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

dsi_pdev_map is a struct visible globally in the DSI driver to get the platform
device pointer of the DSI device corresponding to it's module ID. This was
required because there was no clean way to derive the platform device from
the DSI module instance number or from the connected panel.

With the new output entity, it is possible to retrieve the platform device
pointer if the omap_dss_output pointer is available. Modify the functions
dsi_get_dsidev_from_dssdev() dsi_get_dsidev_from_id() so that they use output
instead of dsi_pdev_map to retrieve the dsi platform device pointer.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 22e0873..19a4d4d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -344,8 +344,6 @@ struct dsi_packet_sent_handler_data {
 	struct completion *completion;
 };
 
-static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
-
 #ifdef DEBUG
 static bool dsi_perf;
 module_param(dsi_perf, bool, 0644);
@@ -358,12 +356,19 @@ static inline struct dsi_data *dsi_get_dsidrv_data(struct platform_device *dside
 
 static inline struct platform_device *dsi_get_dsidev_from_dssdev(struct omap_dss_device *dssdev)
 {
-	return dsi_pdev_map[dssdev->phy.dsi.module];
+	return dssdev->output->pdev;
 }
 
 struct platform_device *dsi_get_dsidev_from_id(int module)
 {
-	return dsi_pdev_map[module];
+	struct omap_dss_output *out;
+	enum omap_dss_output_id	id;
+
+	id = module == 0 ? OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
+
+	out = omap_dss_get_output(id);
+
+	return out->pdev;
 }
 
 static inline void dsi_write_reg(struct platform_device *dsidev,
@@ -4934,7 +4939,6 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi->module_id = dsidev->id;
 	dsi->pdev = dsidev;
-	dsi_pdev_map[dsi->module_id] = dsidev;
 	dev_set_drvdata(&dsidev->dev, dsi);
 
 	spin_lock_init(&dsi->irq_lock);
-- 
1.7.9.5

