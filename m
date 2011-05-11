From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] OMAP: DSS2: Move panel-generic-dpi.h to include/video/
Date: Wed, 11 May 2011 15:26:29 +0300
Message-ID: <1305116790-24067-3-git-send-email-tomi.valkeinen@ti.com>
References: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41600 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208Ab1EKQoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:44:30 -0400
In-Reply-To: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

arch/arm/plat-omap/include/plat/panel-generic-dpi.h is an include for
the OMAP DSS panel driver for generic DPI displays. A more logical place
for it is in include/video.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/board-overo.c                  |    2 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |    2 +-
 .../video/omap-panel-generic-dpi.h                 |    6 +++---
 12 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/plat-omap/include/plat/panel-generic-dpi.h => include/video/omap-panel-generic-dpi.h (88%)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 80bc0d3..23244cd 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -38,7 +38,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 #include <plat/gpmc-smc91x.h>
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 7e634c8..ff8c59b 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,7 +35,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 #include "mux.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index a98de28..9340f6a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -46,7 +46,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 #include <plat/mcspi.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 2bdfd58..1d1b56a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -46,7 +46,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 183db91..3da64d3 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -32,7 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 #include <plat/onenand.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 74d6b7b..97750d4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -42,7 +42,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f75015b..7f94ccc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -45,7 +45,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index e5fdfe8..a72c90a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -40,7 +40,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9ec9a17..e4973ac 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,7 +40,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 #include "timer-gp.h"
 
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index ff28880..9d192ff 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,7 +44,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <video/omapdss.h>
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 #include <mach/gpio.h>
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index cc9dc70..2251f73 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 #include <video/omapdss.h>
 
-#include <plat/panel-generic-dpi.h>
+#include <video/omap-panel-generic-dpi.h>
 
 struct panel_config {
 	struct omap_video_timings timings;
diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
similarity index 88%
rename from arch/arm/plat-omap/include/plat/panel-generic-dpi.h
rename to include/video/omap-panel-generic-dpi.h
index b037030..127e3f2 100644
--- a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
+++ b/include/video/omap-panel-generic-dpi.h
@@ -17,8 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
-#define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
+#ifndef __OMAP_PANEL_GENERIC_DPI_H
+#define __OMAP_PANEL_GENERIC_DPI_H
 
 struct omap_dss_device;
 
@@ -34,4 +34,4 @@ struct panel_generic_dpi_data {
 	void (*platform_disable)(struct omap_dss_device *dssdev);
 };
 
-#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H */
+#endif /* __OMAP_PANEL_GENERIC_DPI_H */
-- 
1.7.4.1

