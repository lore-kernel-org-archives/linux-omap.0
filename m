From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/12] OMAPDSS: DPI: verify if DSI PLL is operational
Date: Tue, 30 Oct 2012 18:10:08 +0200
Message-ID: <1351613409-21186-12-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56391 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933955Ab2J3QKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:38 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The SoCs that have DSI module should have a working DSI PLL. However,
some rare boards have not connected the powers to the DSI PLL.

This patch adds a function that tries to power up the DSI PLL, and
reports if that doesn't succeed. DPI uses this function to fall back to
PRCM clocks if DSI PLL doesn't work.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index fc1ec7d..267caf0 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -361,6 +361,28 @@ void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 }
 EXPORT_SYMBOL(omapdss_dpi_set_data_lines);
 
+static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
+{
+	int r;
+
+	/* do initial setup with the PLL to see if it is operational */
+
+	r = dsi_runtime_get(dsidev);
+	if (r)
+		return r;
+
+	r = dsi_pll_init(dsidev, 0, 1);
+	if (r) {
+		dsi_runtime_put(dsidev);
+		return r;
+	}
+
+	dsi_pll_uninit(dsidev, true);
+	dsi_runtime_put(dsidev);
+
+	return 0;
+}
+
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -383,6 +405,11 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		enum omap_dss_clk_source dispc_fclk_src =
 			dssdev->clocks.dispc.dispc_fclk_src;
 		dpi.dsidev = dpi_get_dsidev(dispc_fclk_src);
+
+		if (dpi_verify_dsi_pll(dpi.dsidev)) {
+			dpi.dsidev = NULL;
+			DSSWARN("DSI PLL not operational\n");
+		}
 	}
 
 	return 0;
-- 
1.7.10.4

