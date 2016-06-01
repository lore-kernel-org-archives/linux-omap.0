From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 21/27] video/platform_data: omapdss: Create new header file for platform data
Date: Wed, 1 Jun 2016 11:35:43 +0300
Message-ID: <20160601083549.10549-22-peter.ujfalusi@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Create a new header file for platform data used by omapdss.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/omapdss.h | 37 +++++++++++++++++++++++++++++++++++
 include/video/omapdss.h               | 25 +----------------------
 2 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/platform_data/omapdss.h

diff --git a/include/linux/platform_data/omapdss.h b/include/linux/platform_data/omapdss.h
new file mode 100644
index 000000000000..679177929045
--- /dev/null
+++ b/include/linux/platform_data/omapdss.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2016 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __OMAPDSS_PDATA_H
+#define __OMAPDSS_PDATA_H
+
+enum omapdss_version {
+	OMAPDSS_VER_UNKNOWN = 0,
+	OMAPDSS_VER_OMAP24xx,
+	OMAPDSS_VER_OMAP34xx_ES1,	/* OMAP3430 ES1.0, 2.0 */
+	OMAPDSS_VER_OMAP34xx_ES3,	/* OMAP3430 ES3.0+ */
+	OMAPDSS_VER_OMAP3630,
+	OMAPDSS_VER_AM35xx,
+	OMAPDSS_VER_OMAP4430_ES1,	/* OMAP4430 ES1.0 */
+	OMAPDSS_VER_OMAP4430_ES2,	/* OMAP4430 ES2.0, 2.1, 2.2 */
+	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
+	OMAPDSS_VER_OMAP5,
+	OMAPDSS_VER_AM43xx,
+	OMAPDSS_VER_DRA7xx,
+};
+
+/* Board specific data */
+struct omap_dss_board_info {
+	const char *default_display_name;
+	int (*dsi_enable_pads)(int dsi_id, unsigned int lane_mask);
+	void (*dsi_disable_pads)(int dsi_id, unsigned int lane_mask);
+	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
+	enum omapdss_version version;
+};
+
+#endif /* __OMAPDSS_PDATA_H */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a43859a0a398..53ada70cf23c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -22,6 +22,7 @@
 #include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/platform_data/omapdss.h>
 
 #include <video/videomode.h>
 
@@ -303,30 +304,6 @@ struct omap_dss_dsi_config {
 	enum omap_dss_dsi_trans_mode trans_mode;
 };
 
-enum omapdss_version {
-	OMAPDSS_VER_UNKNOWN = 0,
-	OMAPDSS_VER_OMAP24xx,
-	OMAPDSS_VER_OMAP34xx_ES1,	/* OMAP3430 ES1.0, 2.0 */
-	OMAPDSS_VER_OMAP34xx_ES3,	/* OMAP3430 ES3.0+ */
-	OMAPDSS_VER_OMAP3630,
-	OMAPDSS_VER_AM35xx,
-	OMAPDSS_VER_OMAP4430_ES1,	/* OMAP4430 ES1.0 */
-	OMAPDSS_VER_OMAP4430_ES2,	/* OMAP4430 ES2.0, 2.1, 2.2 */
-	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
-	OMAPDSS_VER_OMAP5,
-	OMAPDSS_VER_AM43xx,
-	OMAPDSS_VER_DRA7xx,
-};
-
-/* Board specific data */
-struct omap_dss_board_info {
-	const char *default_display_name;
-	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
-	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
-	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
-	enum omapdss_version version;
-};
-
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
2.8.3
