From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/19] OMAP: DSS2: DSI: add parameter to enter ulps on disable
Date: Tue, 19 Apr 2011 12:22:14 +0300
Message-ID: <1303204942-25450-12-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47648 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754317Ab1DSJW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:56 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add parameter to omapdss_dsi_display_disable() which the panel driver
can use to tell if the DSI lanes should be put to ULPS before disabling
the interface.

This can be used to skip ULPS entry in cases where the panel doesn't
care about ULPS state, for example when the panel will be reset, or when
the display interface will be enabled again right after the disable.

This will speed up the operation considerably in cases where entering
ULPS would fail with timeout, and the panel driver isn't even interested
in entering ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +-
 drivers/video/omap2/displays/panel-taal.c |    4 ++--
 drivers/video/omap2/dss/dsi.c             |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 205c6de..a65479c 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -592,7 +592,7 @@ void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
-		bool disconnect_lanes);
+		bool disconnect_lanes, bool enter_ulps);
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 74ce9f8..d68119e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -932,7 +932,7 @@ err:
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_display_disable(dssdev, true);
+	omapdss_dsi_display_disable(dssdev, true, false);
 err0:
 	return r;
 }
@@ -955,7 +955,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 		taal_hw_reset(dssdev);
 	}
 
-	omapdss_dsi_display_disable(dssdev, true);
+	omapdss_dsi_display_disable(dssdev, true, false);
 
 	td->enabled = 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d85635..d15014e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3763,9 +3763,9 @@ err0:
 }
 
 static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
-		bool disconnect_lanes)
+		bool disconnect_lanes, bool enter_ulps)
 {
-	if (!dsi.ulps_enabled)
+	if (enter_ulps && !dsi.ulps_enabled)
 		dsi_enter_ulps();
 
 	/* disable interface */
@@ -3848,7 +3848,7 @@ err0:
 EXPORT_SYMBOL(omapdss_dsi_display_enable);
 
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
-		bool disconnect_lanes)
+		bool disconnect_lanes, bool enter_ulps)
 {
 	DSSDBG("dsi_display_disable\n");
 
@@ -3858,7 +3858,7 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 	dsi_display_uninit_dispc(dssdev);
 
-	dsi_display_uninit_dsi(dssdev, disconnect_lanes);
+	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
 
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
-- 
1.7.1

