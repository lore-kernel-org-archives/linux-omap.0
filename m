From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 2/9] OMAPDSS: Apply manager timings instead of direct DISPC writes
Date: Wed, 9 May 2012 15:40:49 +0530
Message-ID: <1336558256-26140-3-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39779 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab2EIKLv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 06:11:51 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Replace the function dispc_mgr_set_timings() with dss_mgr_set_timings() in the
interface drivers. The latter function ensures that the timing related DISPC
registers are configured according to the shadow register programming model.

Remove the call to dispc_mgr_go() in dpi_set_timings() as the manager's go bit
is now set by dss_mgr_set_timings().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    3 +--
 drivers/video/omap2/dss/dsi.c  |    5 ++---
 drivers/video/omap2/dss/hdmi.c |    2 +-
 drivers/video/omap2/dss/rfbi.c |    4 ++--
 drivers/video/omap2/dss/sdi.c  |    2 +-
 drivers/video/omap2/dss/venc.c |    2 +-
 6 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index cec1166..e65cf1f 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -156,7 +156,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_mgr_set_timings(dssdev->manager->id, t);
+	dss_mgr_set_timings(dssdev->manager, t);
 
 	return 0;
 }
@@ -294,7 +294,6 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 		}
 
 		dpi_set_mode(dssdev);
-		dispc_mgr_go(dssdev->manager->id);
 
 		dispc_runtime_put();
 		dss_runtime_put();
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6c4b034..95bc996 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4215,13 +4215,12 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dispc_mgr_enable_stallmode(dssdev->manager->id, true);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
-		dispc_mgr_set_timings(dssdev->manager->id, &timings);
+		dss_mgr_set_timings(dssdev->manager, &timings);
 	} else {
 		dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 0);
 
-		dispc_mgr_set_timings(dssdev->manager->id,
-			&dssdev->panel.timings);
+		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 	}
 
 		dispc_mgr_set_lcd_display_type(dssdev->manager->id,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 56f6e9c..8d4ff8c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -376,7 +376,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dispc_mgr_set_timings(dssdev->manager->id, &dssdev->panel.timings);
+	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a81ffcb..feadfab 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -320,7 +320,7 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	dss_mgr_set_timings(dssdev->manager, &timings);
 
 	dispc_mgr_enable(dssdev->manager->id, true);
 
@@ -804,7 +804,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	dss_mgr_set_timings(dssdev->manager, &timings);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 741b834..67fbe7c 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -107,7 +107,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_mgr_set_timings(dssdev->manager->id, t);
+	dss_mgr_set_timings(dssdev->manager, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 6947f5b..9475e6e 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -444,7 +444,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	timings = dssdev->panel.timings;
 	timings.y_res /= 2;
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	dss_mgr_set_timings(dssdev->manager, &timings);
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
-- 
1.7.5.4

