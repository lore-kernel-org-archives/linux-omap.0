From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 2/3] OMAP: use generic DPI panel driver in board files
Date: Wed, 17 Nov 2010 10:23:59 +0800
Message-ID: <1289960640-8782-3-git-send-email-bryan.wu@canonical.com>
References: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56937 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab0KQCY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 21:24:58 -0500
In-Reply-To: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
control driver code which will be moved out later. Then we can use generic DPI
driver for sharp_ls_panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   12 +++++++++---
 arch/arm/mach-omap2/board-am3517evm.c    |   23 +++++++++++++++++------
 arch/arm/mach-omap2/board-cm-t35.c       |   23 +++++++++++++++++------
 arch/arm/mach-omap2/board-devkit8000.c   |   26 ++++++++++++++++++--------
 arch/arm/mach-omap2/board-igep0020.c     |   12 +++++++++---
 arch/arm/mach-omap2/board-omap3beagle.c  |   12 +++++++++---
 arch/arm/mach-omap2/board-omap3evm.c     |   12 +++++++++---
 arch/arm/mach-omap2/board-omap3stalker.c |   23 +++++++++++++++++------
 8 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..1ca0156 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include <plat/gpmc-smc91x.h>
 
@@ -270,13 +271,18 @@ static struct omap_dss_device sdp3430_lcd_device = {
 	.platform_disable	= sdp3430_panel_disable_lcd,
 };
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= sdp3430_panel_enable_dvi,
+	.platform_disable	= sdp3430_panel_disable_dvi,
+};
+
 static struct omap_dss_device sdp3430_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= sdp3430_panel_enable_dvi,
-	.platform_disable	= sdp3430_panel_disable_dvi,
 };
 
 static struct omap_dss_device sdp3430_tv_device = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..851683f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -35,6 +35,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "control.h"
@@ -303,13 +304,18 @@ static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 	lcd_enabled = 0;
 }
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "sharp_lq",
+	.platform_enable	= am3517_evm_panel_enable_lcd,
+	.platform_disable	= am3517_evm_panel_disable_lcd,
+};
+
 static struct omap_dss_device am3517_evm_lcd_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "lcd",
-	.driver_name		= "sharp_lq_panel",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines 	= 16,
-	.platform_enable	= am3517_evm_panel_enable_lcd,
-	.platform_disable	= am3517_evm_panel_disable_lcd,
 };
 
 static int am3517_evm_panel_enable_tv(struct omap_dss_device *dssdev)
@@ -346,13 +352,18 @@ static void am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= am3517_evm_panel_enable_dvi,
+	.platform_disable	= am3517_evm_panel_disable_dvi,
+};
+
 static struct omap_dss_device am3517_evm_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= am3517_evm_panel_enable_dvi,
-	.platform_disable	= am3517_evm_panel_disable_dvi,
 };
 
 static struct omap_dss_device *am3517_evm_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..e91c986 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -46,6 +46,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 #include <plat/mcspi.h>
 
 #include <mach/hardware.h>
@@ -351,22 +352,32 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
 {
 }
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "toppoly_tdo35s",
+	.platform_enable	= cm_t35_panel_enable_lcd,
+	.platform_disable	= cm_t35_panel_disable_lcd,
+};
+
 static struct omap_dss_device cm_t35_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "toppoly_tdo35s_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines	= 18,
-	.platform_enable	= cm_t35_panel_enable_lcd,
-	.platform_disable	= cm_t35_panel_disable_lcd,
+};
+
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= cm_t35_panel_enable_dvi,
+	.platform_disable	= cm_t35_panel_disable_dvi,
 };
 
 static struct omap_dss_device cm_t35_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= cm_t35_panel_enable_dvi,
-	.platform_disable	= cm_t35_panel_disable_dvi,
 };
 
 static struct omap_dss_device cm_t35_tv_device = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53ac762..b72c4a5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -46,6 +46,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -149,23 +150,32 @@ static struct regulator_consumer_supply devkit8000_vmmc1_supply =
 static struct regulator_consumer_supply devkit8000_vio_supply =
 	REGULATOR_SUPPLY("vcc", "spi2.0");
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "generic",
+	.platform_enable        = devkit8000_panel_enable_lcd,
+	.platform_disable       = devkit8000_panel_disable_lcd,
+};
+
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
-	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
+	.driver_name            = "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines     = 24,
-	.reset_gpio             = -EINVAL, /* will be replaced */
-	.platform_enable        = devkit8000_panel_enable_lcd,
-	.platform_disable       = devkit8000_panel_disable_lcd,
 };
+
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable        = devkit8000_panel_enable_dvi,
+	.platform_disable       = devkit8000_panel_disable_dvi,
+};
+
 static struct omap_dss_device devkit8000_dvi_device = {
 	.name                   = "dvi",
-	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
+	.driver_name            = "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines     = 24,
-	.reset_gpio             = -EINVAL, /* will be replaced */
-	.platform_enable        = devkit8000_panel_enable_dvi,
-	.platform_disable       = devkit8000_panel_disable_dvi,
 };
 
 static struct omap_dss_device devkit8000_tv_device = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..da9e5a3 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,6 +30,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 #include <plat/onenand.h>
 
 #include "mux.h"
@@ -433,13 +434,18 @@ static void igep2_disable_dvi(struct omap_dss_device *dssdev)
 	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 0);
 }
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= igep2_enable_dvi,
+	.platform_disable	= igep2_disable_dvi,
+};
+
 static struct omap_dss_device igep2_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= igep2_enable_dvi,
-	.platform_disable	= igep2_disable_dvi,
 };
 
 static struct omap_dss_device *igep2_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..789ca78 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -41,6 +41,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
@@ -194,14 +195,19 @@ static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name = "generic",
+	.platform_enable = beagle_enable_dvi,
+	.platform_disable = beagle_disable_dvi,
+};
+
 static struct omap_dss_device beagle_dvi_device = {
 	.type = OMAP_DISPLAY_TYPE_DPI,
 	.name = "dvi",
-	.driver_name = "generic_panel",
+	.driver_name = "generic_dpi_panel",
+	.data = &dvi_panel,
 	.phy.dpi.data_lines = 24,
 	.reset_gpio = 170,
-	.platform_enable = beagle_enable_dvi,
-	.platform_disable = beagle_disable_dvi,
 };
 
 static struct omap_dss_device beagle_tv_device = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..369cbdc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -301,13 +302,18 @@ static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= omap3_evm_enable_dvi,
+	.platform_disable	= omap3_evm_disable_dvi,
+};
+
 static struct omap_dss_device omap3_evm_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= omap3_evm_enable_dvi,
-	.platform_disable	= omap3_evm_disable_dvi,
 };
 
 static struct omap_dss_device *omap3_evm_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..852cec5 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -40,6 +40,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -160,13 +161,18 @@ static void omap3_stalker_disable_lcd(struct omap_dss_device *dssdev)
 	lcd_enabled = 0;
 }
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "generic",
+	.platform_enable	= omap3_stalker_enable_lcd,
+	.platform_disable	= omap3_stalker_disable_lcd,
+};
+
 static struct omap_dss_device omap3_stalker_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "generic_panel",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines	= 24,
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.platform_enable	= omap3_stalker_enable_lcd,
-	.platform_disable	= omap3_stalker_disable_lcd,
 };
 
 static int omap3_stalker_enable_tv(struct omap_dss_device *dssdev)
@@ -208,13 +214,18 @@ static void omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)
 	dvi_enabled = 0;
 }
 
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= omap3_stalker_enable_dvi,
+	.platform_disable	= omap3_stalker_disable_dvi,
+};
+
 static struct omap_dss_device omap3_stalker_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= omap3_stalker_enable_dvi,
-	.platform_disable	= omap3_stalker_disable_dvi,
 };
 
 static struct omap_dss_device *omap3_stalker_dss_devices[] = {
-- 
1.7.1

