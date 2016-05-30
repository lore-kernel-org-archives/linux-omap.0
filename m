From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 18/26] video: omapdss: Remove unused members from struct omap_dss_board_info
Date: Mon, 30 May 2016 14:42:50 +0300
Message-ID: <20160530114258.30879-19-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The num_devices, **devices and *default_device is leftover from the past.
They can be removed as they are no used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/video/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0c7ae93ebd76..a43859a0a398 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -320,9 +320,6 @@ enum omapdss_version {
 
 /* Board specific data */
 struct omap_dss_board_info {
-	int num_devices;
-	struct omap_dss_device **devices;
-	struct omap_dss_device *default_device;
 	const char *default_display_name;
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
-- 
2.8.3
