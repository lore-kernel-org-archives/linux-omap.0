From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 3/3] OMAP: use generic panel driver in board files
Date: Tue,  2 Nov 2010 16:39:52 -0400
Message-ID: <1288730392-11223-4-git-send-email-bryan.wu@canonical.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59550 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0KBUkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 16:40:17 -0400
Received: by ywc21 with SMTP id 21so2044116ywc.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 13:40:16 -0700 (PDT)
In-Reply-To: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

Introduce some fields in struct panel, which will be used to match the right
panel configurations in generic panel driver.

Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
control driver code which will be moved out later. Then we can use generic driver
for sharp_ls_panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |    1 +
 arch/arm/mach-omap2/board-am3517evm.c     |    4 +++-
 arch/arm/mach-omap2/board-cm-t35.c        |    4 +++-
 arch/arm/mach-omap2/board-devkit8000.c    |    2 ++
 arch/arm/mach-omap2/board-igep0020.c      |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c   |    1 +
 arch/arm/mach-omap2/board-omap3evm.c      |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c  |    2 ++
 arch/arm/plat-omap/include/plat/display.h |   28 +++++++++++++++++++---------
 9 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..529a016 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -273,6 +273,7 @@ static struct omap_dss_device sdp3430_lcd_device = {
 static struct omap_dss_device sdp3430_dvi_device = {
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= sdp3430_panel_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..e435e66 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -306,7 +306,8 @@ static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 static struct omap_dss_device am3517_evm_lcd_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "lcd",
-	.driver_name		= "sharp_lq_panel",
+	.driver_name		= "generic_panel",
+	.panel.name		= "sharp_lq",
 	.phy.dpi.data_lines 	= 16,
 	.platform_enable	= am3517_evm_panel_enable_lcd,
 	.platform_disable	= am3517_evm_panel_disable_lcd,
@@ -350,6 +351,7 @@ static struct omap_dss_device am3517_evm_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= am3517_evm_panel_enable_dvi,
 	.platform_disable	= am3517_evm_panel_disable_dvi,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..afadebb 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -353,7 +353,8 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
 
 static struct omap_dss_device cm_t35_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "toppoly_tdo35s_panel",
+	.driver_name		= "generic_panel",
+	.panel.name		= "toppoly_tdo35s",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 18,
 	.platform_enable	= cm_t35_panel_enable_lcd,
@@ -363,6 +364,7 @@ static struct omap_dss_device cm_t35_lcd_device = {
 static struct omap_dss_device cm_t35_dvi_device = {
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= cm_t35_panel_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 067f437..3a5937e 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -152,6 +152,7 @@ static struct regulator_consumer_supply devkit8000_vio_supply =
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
 	.driver_name            = "generic_panel",
+	.panel.name		= "dvi",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
 	.reset_gpio             = -EINVAL, /* will be replaced */
@@ -161,6 +162,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 static struct omap_dss_device devkit8000_dvi_device = {
 	.name                   = "dvi",
 	.driver_name            = "generic_panel",
+	.panel.name		= "dvi",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
 	.reset_gpio             = -EINVAL, /* will be replaced */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..4c83ef0 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -437,6 +437,7 @@ static struct omap_dss_device igep2_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= igep2_enable_dvi,
 	.platform_disable	= igep2_disable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..18401ff 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -198,6 +198,7 @@ static struct omap_dss_device beagle_dvi_device = {
 	.type = OMAP_DISPLAY_TYPE_DPI,
 	.name = "dvi",
 	.driver_name = "generic_panel",
+	.panel.name = "dvi",
 	.phy.dpi.data_lines = 24,
 	.reset_gpio = 170,
 	.platform_enable = beagle_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..49325a4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -304,6 +304,7 @@ static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 static struct omap_dss_device omap3_evm_dvi_device = {
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= omap3_evm_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..cfbf4b1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -163,6 +163,7 @@ static void omap3_stalker_disable_lcd(struct omap_dss_device *dssdev)
 static struct omap_dss_device omap3_stalker_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.phy.dpi.data_lines	= 24,
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.platform_enable	= omap3_stalker_enable_lcd,
@@ -211,6 +212,7 @@ static void omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)
 static struct omap_dss_device omap3_stalker_dvi_device = {
 	.name			= "dvi",
 	.driver_name		= "generic_panel",
+	.panel.name		= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= omap3_stalker_enable_dvi,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c915a66..6e1fbbd 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -346,6 +346,24 @@ struct omap_overlay_manager {
 	int (*disable)(struct omap_overlay_manager *mgr);
 };
 
+struct omap_display_panel {
+	struct omap_video_timings timings;
+
+	int acbi;	/* ac-bias pin transitions per interrupt */
+	/* Unit: line clocks */
+	int acb;	/* ac-bias pin frequency */
+
+	enum omap_panel_config config;
+
+	int power_on_delay;
+	int power_off_delay;
+	/*
+	 * Used to match device to panel configuration
+	 * when use generic panel driver
+	 */
+	const char *name;
+};
+
 struct omap_dss_device {
 	struct device dev;
 
@@ -395,15 +413,7 @@ struct omap_dss_device {
 		} venc;
 	} phy;
 
-	struct {
-		struct omap_video_timings timings;
-
-		int acbi;	/* ac-bias pin transitions per interrupt */
-		/* Unit: line clocks */
-		int acb;	/* ac-bias pin frequency */
-
-		enum omap_panel_config config;
-	} panel;
+	struct omap_display_panel panel;
 
 	struct {
 		u8 pixel_size;
-- 
1.7.1

