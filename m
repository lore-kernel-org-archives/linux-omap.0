From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: Move display.h to include/video/
Date: Wed, 11 May 2011 15:26:28 +0300
Message-ID: <1305116790-24067-2-git-send-email-tomi.valkeinen@ti.com>
References: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52530 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636Ab1EKQ2n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:28:43 -0400
In-Reply-To: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

arch/arm/plat-omap/include/plat/display.h is an include for the OMAP DSS
driver. A more logical place for it is in include/video.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/board-overo.c                  |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c             |    2 +-
 arch/arm/mach-omap2/board-zoom-display.c           |    2 +-
 arch/arm/mach-omap2/display.c                      |    2 +-
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    2 +-
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h  |    2 +-
 .../arm/plat-omap/include/plat/panel-generic-dpi.h |    2 +-
 drivers/media/video/omap/omap_vout.c               |    2 +-
 drivers/media/video/omap/omap_voutdef.h            |    2 +-
 drivers/video/omap2/displays/panel-acx565akm.c     |    2 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    2 +-
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    2 +-
 drivers/video/omap2/displays/panel-taal.c          |    2 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 +-
 drivers/video/omap2/dss/core.c                     |    2 +-
 drivers/video/omap2/dss/dispc.c                    |    2 +-
 drivers/video/omap2/dss/display.c                  |    2 +-
 drivers/video/omap2/dss/dpi.c                      |    2 +-
 drivers/video/omap2/dss/dsi.c                      |    2 +-
 drivers/video/omap2/dss/dss.c                      |    2 +-
 drivers/video/omap2/dss/dss_features.c             |    2 +-
 drivers/video/omap2/dss/hdmi.c                     |    2 +-
 drivers/video/omap2/dss/hdmi.h                     |    2 +-
 drivers/video/omap2/dss/hdmi_omap4_panel.c         |    2 +-
 drivers/video/omap2/dss/manager.c                  |    2 +-
 drivers/video/omap2/dss/overlay.c                  |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |    2 +-
 drivers/video/omap2/dss/sdi.c                      |    2 +-
 drivers/video/omap2/dss/venc.c                     |    2 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    2 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |    2 +-
 drivers/video/omap2/omapfb/omapfb.h                |    2 +-
 .../plat/display.h => include/video/omapdss.h      |    6 ++----
 47 files changed, 48 insertions(+), 49 deletions(-)
 rename arch/arm/plat-omap/include/plat/display.h => include/video/omapdss.h (99%)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..80bc0d3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -37,7 +37,7 @@
 #include <plat/common.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 
 #include <plat/gpmc-smc91x.h>
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..309bdad 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -36,7 +36,7 @@
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ce7d5e6..7e634c8 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -34,7 +34,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 02a12b4..a98de28 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -45,7 +45,7 @@
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/mcspi.h>
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..2bdfd58 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -45,7 +45,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 34cf982..183db91 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -31,7 +31,7 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/onenand.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..74d6b7b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -41,7 +41,7 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5a1a916..f75015b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -44,7 +44,7 @@
 #include <plat/usb.h>
 #include <plat/common.h>
 #include <plat/mcspi.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..1db1549 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -46,7 +46,7 @@
 #include <mach/hardware.h>
 #include <plat/mcspi.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/nand.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a6e0b91..e5fdfe8 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -39,7 +39,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..9ec9a17 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -34,7 +34,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include <plat/board.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 59ca333..ff28880 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -43,7 +43,7 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/panel-generic-dpi.h>
 #include <mach/gpio.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 89a66db..2df10b6 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -15,7 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mm.h>
 #include <asm/mach-types.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/vram.h>
 #include <plat/mcspi.h>
 
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 37b84c2..60e8645 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -15,7 +15,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/spi/spi.h>
 #include <plat/mcspi.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 256d23f..faebcbc 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index d20bd9c..775fdc3 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -1,7 +1,7 @@
 /*
  * Defines for zoom boards
  */
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define ZOOM_NAND_CS    0
 
diff --git a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
index 01ab657..4d1e794 100644
--- a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
+++ b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
@@ -1,7 +1,7 @@
 #ifndef __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
 #define __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
 
-#include "display.h"
+struct omap_dss_device;
 
 /**
  * struct nokia_dsi_panel_data - Nokia DSI panel driver configuration
diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
index 7906197..b037030 100644
--- a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
+++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
@@ -20,7 +20,7 @@
 #ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
 #define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
 
-#include "display.h"
+struct omap_dss_device;
 
 /**
  * struct panel_generic_dpi_data - panel driver configuration data
diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index d4fe7bc..4ada9be 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -47,7 +47,7 @@
 #include <plat/dma.h>
 #include <plat/vram.h>
 #include <plat/vrfb.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "omap_voutlib.h"
 #include "omap_voutdef.h"
diff --git a/drivers/media/video/omap/omap_voutdef.h b/drivers/media/video/omap/omap_voutdef.h
index ea3a047..659497b 100644
--- a/drivers/media/video/omap/omap_voutdef.h
+++ b/drivers/media/video/omap/omap_voutdef.h
@@ -11,7 +11,7 @@
 #ifndef OMAP_VOUTDEF_H
 #define OMAP_VOUTDEF_H
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define YUYV_BPP        2
 #define RGB565_BPP      2
diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 7e04c92..dbd59b8 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -30,7 +30,7 @@
 #include <linux/backlight.h>
 #include <linux/fb.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define MIPID_CMD_READ_DISP_ID		0x04
 #define MIPID_CMD_READ_RED		0x06
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 4a9b9ff..cc9dc70 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <video/omapdss.h>
 
 #include <plat/panel-generic-dpi.h>
 
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 271324d..e0eb35b 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -21,7 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 struct lb035q02_data {
 	struct mutex lock;
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 925e0fa..2ba9d0c 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -22,7 +22,7 @@
 #include <linux/backlight.h>
 #include <linux/fb.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define LCD_XRES		800
 #define LCD_YRES		480
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index d2b35d2..bc142a0 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -25,7 +25,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 struct sharp_data {
 	struct backlight_device *bl;
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index adc9900..4673517 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -33,7 +33,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/nokia-dsi-panel.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index dbe9d43..62bff58 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define TPO_R02_MODE(x)		((x) & 7)
 #define TPO_R02_MODE_800x480	7
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 1aa2ed1..3a8047a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -33,7 +33,7 @@
 #include <linux/device.h>
 #include <linux/regulator/consumer.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7804779..21de352 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,7 +37,7 @@
 #include <plat/sram.h>
 #include <plat/clock.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index a85a6f3..696369c 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -27,7 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include "dss.h"
 
 static ssize_t display_enabled_show(struct device *dev,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 2d3ca4c..8ed86f8 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0a7f1a4..5c95770 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -34,7 +34,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/clock.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3f1fee6..606a182 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -29,7 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/clk.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/clock.h>
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index aa16222..9ed2033 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -22,7 +22,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a981def..86e32bd 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -29,7 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/string.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "dss.h"
 #include "hdmi.h"
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index 9887ab9..4d385f6 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -22,7 +22,7 @@
 #define _OMAP4_DSS_HDMI_H_
 
 #include <linux/string.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #define HDMI_WP		0x0
 #define HDMI_CORE_SYS		0x400
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
index ffb5de9..7d4f2bd 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #include "dss.h"
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index bcd37ec..ee38ca2 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -29,7 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index f1aca6d..35ef7d1 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -31,7 +31,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5ea17f4..0985f2f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -33,7 +33,7 @@
 #include <linux/hrtimer.h>
 #include <linux/seq_file.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include "dss.h"
 
 struct rfbi_reg { u16 idx; };
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 54a53e6..0bd4b03 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -25,7 +25,7 @@
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 #include "dss.h"
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 8e35a5b..3269301 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/cpu.h>
 
 #include "dss.h"
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 6f43545..3e4ee4d 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -28,7 +28,7 @@
 #include <linux/omapfb.h>
 #include <linux/vmalloc.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/vrfb.h>
 #include <plat/vram.h>
 
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 505ec66..606f6ee 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/omapfb.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/vram.h>
 #include <plat/vrfb.h>
 
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 6f9c72c..3be7646 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -29,7 +29,7 @@
 #include <linux/mm.h>
 #include <linux/omapfb.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 #include <plat/vrfb.h>
 
 #include "omapfb.h"
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 1305fc9..4d1cff9 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -29,7 +29,7 @@
 
 #include <linux/rwsem.h>
 
-#include <plat/display.h>
+#include <video/omapdss.h>
 
 #ifdef DEBUG
 extern unsigned int omapfb_debug;
diff --git a/arch/arm/plat-omap/include/plat/display.h b/include/video/omapdss.h
similarity index 99%
rename from arch/arm/plat-omap/include/plat/display.h
rename to include/video/omapdss.h
index 5e04ddc..3973868 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/include/video/omapdss.h
@@ -1,6 +1,4 @@
 /*
- * linux/include/asm-arm/arch-omap/display.h
- *
  * Copyright (C) 2008 Nokia Corporation
  * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
  *
@@ -17,8 +15,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef __ASM_ARCH_OMAP_DISPLAY_H
-#define __ASM_ARCH_OMAP_DISPLAY_H
+#ifndef __OMAP_OMAPDSS_H
+#define __OMAP_OMAPDSS_H
 
 #include <linux/list.h>
 #include <linux/kobject.h>
-- 
1.7.4.1

