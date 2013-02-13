From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/33] OMAPDSS: panels: keep platform data of all panels in a single header
Date: Wed, 13 Feb 2013 19:51:53 +0530
Message-ID: <1360765345-19312-2-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934024Ab3BMOXP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:15 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Structs for platform data of omapdss panels are found in headers in the
'include/video/' path. Board files populate these structs with platform
specific values, and the panel driver uses these to configure the panel.

Currently, each panel has it's own header in the above path. Move all the
omapdss panel platform data structs to a single header omap-panel-data.h.
This is useful because:

- All other omapdss panel drivers will be modified to use platform data. This
  would lead to a lot of panel headers usable only by omapdss. A lot of these
  platform data structs are trivial, and don't really need a separate header.
- Platform data would be eventually removed, and platform information would be
  passed via device tree. Therefore, omapdss panel platform data structs are
  temporary, and will be easier to remove if they are all in the same header.
- All board files will have to include the same header to configure a panel's
  platform data, that makes the board files more consistent.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c              |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c              |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c            |    3 +-
 arch/arm/mach-omap2/board-apollon.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c               |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c           |    3 +-
 arch/arm/mach-omap2/board-h4.c                   |    2 +-
 arch/arm/mach-omap2/board-igep0020.c             |    2 +-
 arch/arm/mach-omap2/board-ldp.c                  |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c          |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c             |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c         |    3 +-
 arch/arm/mach-omap2/board-overo.c                |    3 +-
 arch/arm/mach-omap2/dss-common.c                 |    4 +-
 drivers/video/omap2/displays/panel-generic-dpi.c |    2 +-
 drivers/video/omap2/displays/panel-n8x0.c        |    2 +-
 drivers/video/omap2/displays/panel-picodlp.c     |    2 +-
 drivers/video/omap2/displays/panel-taal.c        |    2 +-
 drivers/video/omap2/displays/panel-tfp410.c      |    2 +-
 include/video/omap-panel-data.h                  |  101 ++++++++++++++++++++++
 include/video/omap-panel-generic-dpi.h           |   37 --------
 include/video/omap-panel-n8x0.h                  |   13 ---
 include/video/omap-panel-nokia-dsi.h             |   32 -------
 include/video/omap-panel-picodlp.h               |   23 -----
 include/video/omap-panel-tfp410.h                |   35 --------
 25 files changed, 120 insertions(+), 166 deletions(-)
 create mode 100644 include/video/omap-panel-data.h
 delete mode 100644 include/video/omap-panel-generic-dpi.h
 delete mode 100644 include/video/omap-panel-n8x0.h
 delete mode 100644 include/video/omap-panel-nokia-dsi.h
 delete mode 100644 include/video/omap-panel-picodlp.h
 delete mode 100644 include/video/omap-panel-tfp410.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 4815ea6..13a1a3b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -37,7 +37,7 @@
 #include "gpmc-smc91x.h"
 
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-data.h>
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bb73afc..fb75a81 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -33,7 +33,7 @@
 #include "common.h"
 #include <linux/omap-dma.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include "gpmc.h"
 #include "gpmc-smc91x.h"
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f81a303..2988049 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,8 +35,7 @@
 
 #include "common.h"
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include "am35xx-emac.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 5d0a61f..d2a83a8 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -38,7 +38,7 @@
 #include "gpmc.h"
 
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-data.h>
 
 #include "mux.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b3102c2..f940a79 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -40,8 +40,7 @@
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 12865af..019b212 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -42,8 +42,7 @@
 #include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 3be1311..88d1b5b 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-data.h>
 
 #include "common.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0f24cb8..810e168 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,7 +30,7 @@
 #include <asm/mach/arch.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 0869f4f..68e56f1 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -40,7 +40,7 @@
 #include "gpmc-smsc911x.h"
 
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-data.h>
 
 #include "board-flash.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 22c483d..8d357ce 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -40,7 +40,7 @@
 #include <asm/mach/flash.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3985f35..335127d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -50,7 +50,7 @@
 #include "common.h"
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include "soc.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 53a6cbc..621ace1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -43,8 +43,7 @@
 #include "gpmc.h"
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c8fde3e..bf6b2ce 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -46,8 +46,7 @@
 #include <asm/mach/map.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 #include "common.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 4be5cfc..9c49bbe 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -27,9 +27,7 @@
 #include <linux/gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-tfp410.h>
-#include <video/omap-panel-nokia-dsi.h>
-#include <video/omap-panel-picodlp.h>
+#include <video/omap-panel-data.h>
 
 #include "soc.h"
 #include "dss-common.h"
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 6cb2fe0..d8d0cd5 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 #include <video/omapdss.h>
 
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-data.h>
 
 struct panel_config {
 	struct omap_video_timings timings;
diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index b750480..9c55c91 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -8,7 +8,7 @@
 #include <linux/fb.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-n8x0.h>
+#include <video/omap-panel-data.h>
 
 #define BLIZZARD_REV_CODE                      0x00
 #define BLIZZARD_CONFIG                        0x02
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 3864299..56d536c 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -31,7 +31,7 @@
 #include <linux/gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-picodlp.h>
+#include <video/omap-panel-data.h>
 
 #include "panel-picodlp.h"
 
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index a32407a..031d406 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -33,7 +33,7 @@
 #include <linux/mutex.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-nokia-dsi.h>
+#include <video/omap-panel-data.h>
 #include <video/mipi_display.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 8281baa..a1dba868 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -24,7 +24,7 @@
 #include <linux/gpio.h>
 #include <drm/drm_edid.h>
 
-#include <video/omap-panel-tfp410.h>
+#include <video/omap-panel-data.h>
 
 static const struct omap_video_timings tfp410_default_timings = {
 	.x_res		= 640,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
new file mode 100644
index 0000000..e8e30f9
--- /dev/null
+++ b/include/video/omap-panel-data.h
@@ -0,0 +1,101 @@
+/*
+ * Header containing platform_data structs for omap panels
+ *
+ * Copyright (C) 2013 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *	   Archit Taneja <archit@ti.com>
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Mayuresh Janorkar <mayur@ti.com>
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __OMAP_PANEL_DATA_H
+#define __OMAP_PANEL_DATA_H
+
+struct omap_dss_device;
+
+/**
+ * struct panel_generic_dpi_data - panel driver configuration data
+ * @name: panel name
+ * @platform_enable: platform specific panel enable function
+ * @platform_disable: platform specific panel disable function
+ */
+struct panel_generic_dpi_data {
+	const char *name;
+	int (*platform_enable)(struct omap_dss_device *dssdev);
+	void (*platform_disable)(struct omap_dss_device *dssdev);
+};
+
+/**
+ * struct panel_n8x0_data - N800 panel driver configuration data
+ */
+struct panel_n8x0_data {
+	int (*platform_enable)(struct omap_dss_device *dssdev);
+	void (*platform_disable)(struct omap_dss_device *dssdev);
+	int panel_reset;
+	int ctrl_pwrdown;
+};
+
+/**
+ * struct nokia_dsi_panel_data - Nokia DSI panel driver configuration data
+ * @name: panel name
+ * @use_ext_te: use external TE
+ * @ext_te_gpio: external TE GPIO
+ * @esd_interval: interval of ESD checks, 0 = disabled (ms)
+ * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
+ * @use_dsi_backlight: true if panel uses DSI command to control backlight
+ * @pin_config: DSI pin configuration
+ */
+
+struct nokia_dsi_panel_data {
+	const char *name;
+
+	int reset_gpio;
+
+	bool use_ext_te;
+	int ext_te_gpio;
+
+	unsigned esd_interval;
+	unsigned ulps_timeout;
+
+	bool use_dsi_backlight;
+
+	struct omap_dsi_pin_config pin_config;
+};
+
+/**
+ * struct picodlp_panel_data - picodlp panel driver configuration data
+ * @picodlp_adapter_id:	i2c_adapter number for picodlp
+ */
+struct picodlp_panel_data {
+	int picodlp_adapter_id;
+	int emu_done_gpio;
+	int pwrgood_gpio;
+};
+
+/**
+ * struct tfp410_platform_data - tfp410 panel driver configuration data
+ * @i2c_bus_num: i2c bus id for the panel
+ * @power_down_gpio: gpio number for PD pin (or -1 if not available)
+ */
+struct tfp410_platform_data {
+	int i2c_bus_num;
+	int power_down_gpio;
+};
+
+#endif /* __OMAP_PANEL_DATA_H */
diff --git a/include/video/omap-panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
deleted file mode 100644
index 127e3f2..0000000
--- a/include/video/omap-panel-generic-dpi.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Header for generic DPI panel driver
- *
- * Copyright (C) 2010 Canonical Ltd.
- * Author: Bryan Wu <bryan.wu@canonical.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __OMAP_PANEL_GENERIC_DPI_H
-#define __OMAP_PANEL_GENERIC_DPI_H
-
-struct omap_dss_device;
-
-/**
- * struct panel_generic_dpi_data - panel driver configuration data
- * @name: panel name
- * @platform_enable: platform specific panel enable function
- * @platform_disable: platform specific panel disable function
- */
-struct panel_generic_dpi_data {
-	const char *name;
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
-};
-
-#endif /* __OMAP_PANEL_GENERIC_DPI_H */
diff --git a/include/video/omap-panel-n8x0.h b/include/video/omap-panel-n8x0.h
deleted file mode 100644
index 9cc69c8..0000000
--- a/include/video/omap-panel-n8x0.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __OMAP_PANEL_N8X0_H
-#define __OMAP_PANEL_N8X0_H
-
-struct omap_dss_device;
-
-struct panel_n8x0_data {
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
-	int panel_reset;
-	int ctrl_pwrdown;
-};
-
-#endif
diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
deleted file mode 100644
index 04219a2..0000000
--- a/include/video/omap-panel-nokia-dsi.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef __OMAP_NOKIA_DSI_PANEL_H
-#define __OMAP_NOKIA_DSI_PANEL_H
-
-struct omap_dss_device;
-
-/**
- * struct nokia_dsi_panel_data - Nokia DSI panel driver configuration
- * @name: panel name
- * @use_ext_te: use external TE
- * @ext_te_gpio: external TE GPIO
- * @esd_interval: interval of ESD checks, 0 = disabled (ms)
- * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
- * @use_dsi_backlight: true if panel uses DSI command to control backlight
- * @pin_config: DSI pin configuration
- */
-struct nokia_dsi_panel_data {
-	const char *name;
-
-	int reset_gpio;
-
-	bool use_ext_te;
-	int ext_te_gpio;
-
-	unsigned esd_interval;
-	unsigned ulps_timeout;
-
-	bool use_dsi_backlight;
-
-	struct omap_dsi_pin_config pin_config;
-};
-
-#endif /* __OMAP_NOKIA_DSI_PANEL_H */
diff --git a/include/video/omap-panel-picodlp.h b/include/video/omap-panel-picodlp.h
deleted file mode 100644
index 1c342ef..0000000
--- a/include/video/omap-panel-picodlp.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * panel data for picodlp panel
- *
- * Copyright (C) 2011 Texas Instruments
- *
- * Author: Mayuresh Janorkar <mayur@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __PANEL_PICODLP_H
-#define __PANEL_PICODLP_H
-/**
- * struct : picodlp panel data
- * picodlp_adapter_id:	i2c_adapter number for picodlp
- */
-struct picodlp_panel_data {
-	int picodlp_adapter_id;
-	int emu_done_gpio;
-	int pwrgood_gpio;
-};
-#endif /* __PANEL_PICODLP_H */
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
deleted file mode 100644
index aef35e4..0000000
--- a/include/video/omap-panel-tfp410.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Header for TFP410 chip driver
- *
- * Copyright (C) 2011 Texas Instruments Inc
- * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __OMAP_PANEL_TFP410_H
-#define __OMAP_PANEL_TFP410_H
-
-struct omap_dss_device;
-
-/**
- * struct tfp410_platform_data - panel driver configuration data
- * @i2c_bus_num: i2c bus id for the panel
- * @power_down_gpio: gpio number for PD pin (or -1 if not available)
- */
-struct tfp410_platform_data {
-	int i2c_bus_num;
-	int power_down_gpio;
-};
-
-#endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.9.5

