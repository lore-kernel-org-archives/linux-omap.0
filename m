From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 19/26] video/platform_data: omapdss: Create new header file for platform data
Date: Mon, 30 May 2016 14:42:51 +0300
Message-ID: <20160530114258.30879-20-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Create a new header file for platform data used by omapdss.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../linux/platform_data/omapdss.h                  | 64 +++++++++-------------
 include/video/omapdss.h                            | 25 +--------
 2 files changed, 26 insertions(+), 63 deletions(-)
 copy arch/arm/boot/dts/axm5516-amarillo.dts => include/linux/platform_data/omapdss.h (23%)

diff --git a/arch/arm/boot/dts/axm5516-amarillo.dts b/include/linux/platform_data/omapdss.h
similarity index 23%
copy from arch/arm/boot/dts/axm5516-amarillo.dts
copy to include/linux/platform_data/omapdss.h
index a9d60471d9ff..679177929045 100644
--- a/arch/arm/boot/dts/axm5516-amarillo.dts
+++ b/include/linux/platform_data/omapdss.h
@@ -1,7 +1,5 @@
 /*
- * arch/arm/boot/dts/axm5516-amarillo.dts
- *
- * Copyright (C) 2013 LSI
+ * Copyright (C) 2016 Texas Instruments, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -9,43 +7,31 @@
  * (at your option) any later version.
  */
 
-/dts-v1/;
-
-/memreserve/ 0x00000000 0x00400000;
-
-#include "axm55xx.dtsi"
-#include "axm5516-cpus.dtsi"
-
-/ {
-	model = "Amarillo AXM5516";
-	compatible = "lsi,axm5516-amarillo", "lsi,axm5516";
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x00000000 0x02 0x00000000>;
-	};
-};
-
-&serial0 {
-	status = "okay";
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
 };
 
-&serial1 {
-	status = "okay";
+/* Board specific data */
+struct omap_dss_board_info {
+	const char *default_display_name;
+	int (*dsi_enable_pads)(int dsi_id, unsigned int lane_mask);
+	void (*dsi_disable_pads)(int dsi_id, unsigned int lane_mask);
+	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
+	enum omapdss_version version;
 };
 
-&serial2 {
-	status = "okay";
-};
-
-&serial3 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
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
