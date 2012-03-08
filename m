From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: add set_min_bus_tput pointer to omapdss's platform data
Date: Thu,  8 Mar 2012 13:13:36 +0200
Message-ID: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60820 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752679Ab2CHLOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 06:14:14 -0500
Received: by laap9 with SMTP id p9so374046laa.38
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 03:14:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

omapdss driver needs to use the omap_pm_set_min_bus_tput(), so add a new
entry for that in omapdss's platform data, and set it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/display.c |    6 ++++++
 include/video/omapdss.h       |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3677b1f..a675cab 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -179,6 +179,11 @@ static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 		omap4_dsi_mux_pads(dsi_id, 0);
 }
 
+static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long tput)
+{
+	return omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, tput);
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -209,6 +214,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count =
 		omap_pm_get_dev_context_loss_count;
+	pdata.board_data->set_min_bus_tput = omap_dss_set_min_bus_tput;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 483f67c..7aecadb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -309,6 +309,7 @@ struct omap_dss_board_info {
 	struct omap_dss_device *default_device;
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
+	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
 };
 
 /* Init with the board info */
-- 
1.7.4.1

