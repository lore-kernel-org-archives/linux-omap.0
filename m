From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/12] OMAPDSS: Add struct to hold LCD overlay manager configuration
Date: Thu, 28 Jun 2012 20:00:32 +0530
Message-ID: <1340893842-10626-4-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36388 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab2F1OcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:32:12 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a struct dss_lcd_mgr_config which holds LCD overlay manager related
parameters. These are currently partially contained in the omap_dss_device
connected to the manager, and the rest are in the interface driver.

The parameters are directly written to the DISPC registers in the interface
drivers. These should eventually be applied at the correct time using the
shadow register programming model. This struct would help in grouping these
parameters so that they can be applied together.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f8289e9..6688eaf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -152,6 +152,19 @@ struct dsi_clock_info {
 	u16 lp_clk_div;
 };
 
+struct dss_lcd_mgr_config {
+	enum dss_io_pad_mode io_pad_mode;
+
+	bool stallmode;
+	bool fifohandcheck;
+
+	struct dispc_clock_info clock_info;
+
+	int video_port_width;
+
+	int lcden_sig_polarity;
+};
+
 struct seq_file;
 struct platform_device;
 
-- 
1.7.9.5

