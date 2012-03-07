From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/21] OMAPDSS: TFP410: rename dvi files to tfp410
Date: Wed,  7 Mar 2012 14:44:33 +0200
Message-ID: <1331124290-6285-5-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:39160 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758427Ab2CGMpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:19 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so11579274lag.17
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:17 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

Now that the tfp410 driver has been renamed in the code, this patch
finishes the renaming by renaming the files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
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
 drivers/video/omap2/displays/Makefile              |    2 +-
 .../omap2/displays/{panel-dvi.c => panel-tfp410.c} |    2 +-
 .../{omap-panel-dvi.h => omap-panel-tfp410.h}      |    0
 13 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/video/omap2/displays/{panel-dvi.c => panel-tfp410.c} (99%)
 rename include/video/{omap-panel-dvi.h => omap-panel-tfp410.h} (100%)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2c153bb..fdcbaaf 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -37,7 +37,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include <plat/gpmc-smc91x.h>
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c38dac1..fadd25f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -37,7 +37,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include "mux.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 94d5167..54d8f0f 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -43,7 +43,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 #include <plat/mcspi.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index d1bead0..677f16e 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -47,7 +47,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ae1b157..6e56ccc 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -32,7 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 #include <plat/onenand.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5f858e9..df6acae 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -42,7 +42,7 @@
 #include <plat/board.h>
 #include "common.h"
 #include <video/omapdss.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 840fb99..1a34bee 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -46,7 +46,7 @@
 #include "common.h"
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8a292cc..d05e7a7 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -41,7 +41,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 8196d6e..959b4ed 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,7 +40,7 @@
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include "hsmmc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 76e06e4..ceb7187 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -46,7 +46,7 @@
 #include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
 #include <plat/nand.h>
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 58905ef0..58a5176 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
-obj-$(CONFIG_PANEL_TFP410) += panel-dvi.o
+obj-$(CONFIG_PANEL_TFP410) += panel-tfp410.o
 obj-$(CONFIG_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-tfp410.c
similarity index 99%
rename from drivers/video/omap2/displays/panel-dvi.c
rename to drivers/video/omap2/displays/panel-tfp410.c
index 1ec996d..4b867bf 100644
--- a/drivers/video/omap2/displays/panel-dvi.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -24,7 +24,7 @@
 #include <linux/gpio.h>
 #include <drm/drm_edid.h>
 
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 static const struct omap_video_timings tfp410_default_timings = {
 	.x_res		= 640,
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-tfp410.h
similarity index 100%
rename from include/video/omap-panel-dvi.h
rename to include/video/omap-panel-tfp410.h
-- 
1.7.4.1

