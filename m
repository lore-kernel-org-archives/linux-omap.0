From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/27] OMAPDSS: DVI: Add ops
Date: Thu, 30 May 2013 12:36:05 +0300
Message-ID: <1369906580-27585-13-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37524 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030428Ab3E3JhF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:37:05 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "ops" style method for using DVI functionality.

Ops style calls will allow us to have arbitrarily long display
pipelines, where each entity can call ops in the previous display
entity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 79e9ec8..9f87fc0 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -611,6 +611,23 @@ struct omapdss_sdi_ops {
 	void (*set_datapairs)(struct omap_dss_device *dssdev, int datapairs);
 };
 
+struct omapdss_dvi_ops {
+	int (*connect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+	void (*disconnect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+
+	int (*enable)(struct omap_dss_device *dssdev);
+	void (*disable)(struct omap_dss_device *dssdev);
+
+	int (*check_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*set_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*get_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+};
+
 struct omap_dss_device {
 	/* old device, to be removed */
 	struct device old_dev;
@@ -686,6 +703,7 @@ struct omap_dss_device {
 	union {
 		const struct omapdss_dpi_ops *dpi;
 		const struct omapdss_sdi_ops *sdi;
+		const struct omapdss_dvi_ops *dvi;
 	} ops;
 
 	/* helper variable for driver suspend/resume */
-- 
1.8.1.2

