From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/10] OMAP: use dvi panel driver instead of generic-dpi
Date: Tue, 20 Sep 2011 11:18:21 +0300
Message-ID: <1316506706-18941-6-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38916 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754215Ab1ITIS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:18:57 -0400
Received: by mail-bw0-f47.google.com with SMTP id 11so418522bke.6
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:18:55 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Multiple OMAP3/4 boards have a DVI framer output. This patch makes the
boards use the new panel-dvi driver, instead of the panel-generic-dpi
driver.

Separate drivers for fixed size panels and DVI framer gives us cleaner
driver code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    7 +++----
 arch/arm/mach-omap2/board-am3517evm.c    |    6 +++---
 arch/arm/mach-omap2/board-cm-t35.c       |    6 +++---
 arch/arm/mach-omap2/board-devkit8000.c   |    6 +++---
 arch/arm/mach-omap2/board-igep0020.c     |    7 +++----
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 +++----
 arch/arm/mach-omap2/board-omap3evm.c     |    7 +++----
 arch/arm/mach-omap2/board-omap3stalker.c |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c   |    7 +++----
 arch/arm/mach-omap2/board-overo.c        |    6 +++---
 10 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd600cf..18c4d19 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -37,7 +37,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include <plat/gpmc-smc91x.h>
 
@@ -186,8 +186,7 @@ static struct omap_dss_device sdp3430_lcd_device = {
 	.platform_disable	= sdp3430_panel_disable_lcd,
 };
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= sdp3430_panel_enable_dvi,
 	.platform_disable	= sdp3430_panel_disable_dvi,
 };
@@ -195,7 +194,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device sdp3430_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f3006c3..9a68ef5 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include "mux.h"
 #include "control.h"
@@ -333,8 +334,7 @@ static void am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= am3517_evm_panel_enable_dvi,
 	.platform_disable	= am3517_evm_panel_disable_dvi,
 };
@@ -342,7 +342,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device am3517_evm_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 3af8aab..2d112bf 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -43,6 +43,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 #include <plat/mcspi.h>
 
 #include <mach/hardware.h>
@@ -242,8 +243,7 @@ static struct omap_dss_device cm_t35_lcd_device = {
 	.phy.dpi.data_lines	= 18,
 };
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= cm_t35_panel_enable_dvi,
 	.platform_disable	= cm_t35_panel_disable_dvi,
 };
@@ -251,7 +251,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device cm_t35_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index da5057e..44da207 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -47,6 +47,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -152,8 +153,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 	.phy.dpi.data_lines     = 24,
 };
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable        = devkit8000_panel_enable_dvi,
 	.platform_disable       = devkit8000_panel_disable_dvi,
 };
@@ -161,7 +161,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device devkit8000_dvi_device = {
 	.name                   = "dvi",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "generic_dpi_panel",
+	.driver_name            = "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines     = 24,
 };
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 35be778..9fda8d8 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -32,7 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 #include <plat/onenand.h>
 
 #include "mux.h"
@@ -455,8 +455,7 @@ static void igep2_disable_dvi(struct omap_dss_device *dssdev)
 	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 0);
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= igep2_enable_dvi,
 	.platform_disable	= igep2_disable_dvi,
 };
@@ -464,7 +463,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device igep2_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..26bc860 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -42,7 +42,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
@@ -203,8 +203,7 @@ static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name = "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
 };
@@ -212,7 +211,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device beagle_dvi_device = {
 	.type = OMAP_DISPLAY_TYPE_DPI,
 	.name = "dvi",
-	.driver_name = "generic_dpi_panel",
+	.driver_name = "dvi",
 	.data = &dvi_panel,
 	.phy.dpi.data_lines = 24,
 	.reset_gpio = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c452b3f..82142c5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -45,7 +45,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -247,8 +247,7 @@ static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= omap3_evm_enable_dvi,
 	.platform_disable	= omap3_evm_disable_dvi,
 };
@@ -256,7 +255,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device omap3_evm_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8e10498..8ab99f1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -41,6 +41,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -179,8 +180,7 @@ static void omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= omap3_stalker_enable_dvi,
 	.platform_disable	= omap3_stalker_disable_dvi,
 };
@@ -188,7 +188,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device omap3_stalker_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..c35384e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,7 +40,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 
 #include "hsmmc.h"
 #include "control.h"
@@ -455,8 +455,7 @@ static void omap4_panda_disable_dvi(struct omap_dss_device *dssdev)
 }
 
 /* Using generic display panel */
-static struct panel_generic_dpi_data omap4_dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data omap4_dvi_panel = {
 	.platform_enable	= omap4_panda_enable_dvi,
 	.platform_disable	= omap4_panda_disable_dvi,
 };
@@ -464,7 +463,7 @@ static struct panel_generic_dpi_data omap4_dvi_panel = {
 struct omap_dss_device omap4_panda_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &omap4_dvi_panel,
 	.phy.dpi.data_lines	= 24,
 	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f949a99..06064d5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -46,6 +46,7 @@
 #include <plat/common.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
+#include <video/omap-panel-dvi.h>
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
 #include <plat/nand.h>
@@ -182,8 +183,7 @@ static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
-static struct panel_generic_dpi_data dvi_panel = {
-	.name			= "generic",
+static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= overo_panel_enable_dvi,
 	.platform_disable	= overo_panel_disable_dvi,
 };
@@ -191,7 +191,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 static struct omap_dss_device overo_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
+	.driver_name		= "dvi",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
-- 
1.7.4.1

