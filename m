From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] OMAPDSS: DPI: Get panel configuration from platform data
Date: Fri, 20 Jul 2012 21:00:19 +0530
Message-ID: <1342798219-13031-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48440 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab2GTPci (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 11:32:38 -0400
Received: by yenl2 with SMTP id l2so4093714yen.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 08:32:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, a0393947@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>

Instead of harcoding in the driver some of potentially countless sets
of parameters that could define a panel, have the board provide the
parameters to the panel driver.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm/mach-omap2/board-2430sdp.c              |    4 +-
 arch/arm/mach-omap2/board-am3517evm.c            |    5 +-
 arch/arm/mach-omap2/board-apollon.c              |    4 +-
 arch/arm/mach-omap2/board-cm-t35.c               |    5 +-
 arch/arm/mach-omap2/board-devkit8000.c           |    4 +-
 arch/arm/mach-omap2/board-h4.c                   |    3 +-
 arch/arm/mach-omap2/board-ldp.c                  |    4 +-
 arch/arm/mach-omap2/board-overo.c                |    4 +-
 drivers/video/omap2/displays/panel-generic-dpi.c |  467 +---------------------
 include/video/omap-panel-generic-dpi.h           |   15 +-
 10 files changed, 44 insertions(+), 471 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 99ca6ba..0cc58c3 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -125,7 +125,9 @@ static void sdp2430_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data sdp2430_panel_data = {
-	.name			= "nec_nl2432dr22-11b",
+	.pcfg = {{240, 320, 5400, 3, 3, 39, 1, 2, 7,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS),
+		0, 0,},
 	.platform_enable	= sdp2430_panel_enable_lcd,
 	.platform_disable	= sdp2430_panel_disable_lcd,
 };
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 18f6010..afd87b5 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -176,7 +176,10 @@ static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "sharp_lq",
+	.pcfg = {{480, 272, 9000, 42, 3, 2, 11, 3, 2,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+			OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO),
+		50, 100,},
 	.platform_enable	= am3517_evm_panel_enable_lcd,
 	.platform_disable	= am3517_evm_panel_disable_lcd,
 };
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 502c31e..e9c6f5a 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -261,7 +261,9 @@ static struct omap_usb_config apollon_usb_config __initdata = {
 };
 
 static struct panel_generic_dpi_data apollon_panel_data = {
-	.name			= "apollon",
+	.pcfg = {{480, 272, 6250, 41, 2, 2, 10, 2, 2,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS),
+		0, 0,},
 };
 
 static struct omap_dss_device apollon_lcd_device = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ded100c..f5a8ce4 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -228,7 +228,10 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "toppoly_tdo35s",
+	.pcfg = {{480, 640, 26000, 8, 104, 8, 2, 4, 2,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+			OMAP_DSS_LCD_IPC | OMAP_DSS_LCD_ONOFF),
+		0, 0,},
 	.platform_enable	= cm_t35_panel_enable_lcd,
 	.platform_disable	= cm_t35_panel_disable_lcd,
 };
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6567c1c..397f52d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -128,7 +128,9 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
 };
 
 static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "innolux_at070tn83",
+	.pcfg = {{800, 480, 40000, 48, 1, 1, 3, 12, 25,}, 0, 0x28,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS),
+		0, 0,},
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
 };
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 876becf..4f62bad 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -205,7 +205,8 @@ static struct platform_device *h4_devices[] __initdata = {
 };
 
 static struct panel_generic_dpi_data h4_panel_data = {
-	.name			= "h4",
+	.pcfg = {{240, 320, 6250, 15, 15, 60, 1, 1, 1,}, 0, 0,
+		OMAP_DSS_LCD_TFT, 0, 0,},
 };
 
 static struct omap_dss_device h4_lcd_device = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ef9e829..de797920 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -210,7 +210,9 @@ static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data ldp_panel_data = {
-	.name			= "nec_nl2432dr22-11b",
+	.pcfg = {{240, 320, 5400, 3, 3, 39, 1, 2, 7,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS),
+		0, 0,},
 	.platform_enable	= ldp_panel_enable_lcd,
 	.platform_disable	= ldp_panel_disable_lcd,
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 779734d..4f7a9fb5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -208,7 +208,9 @@ static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data lcd43_panel = {
-	.name			= "samsung_lte430wq_f0c",
+	.pcfg = {{480, 272, 9200, 41, 8, 4, 10, 4, 2,}, 0, 0,
+		(OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS),
+		0, 0,},
 	.platform_enable	= overo_panel_enable_lcd,
 	.platform_disable	= overo_panel_disable_lcd,
 };
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index e42f9dc..6fa5e22 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -37,457 +37,6 @@
 
 #include <video/omap-panel-generic-dpi.h>
 
-struct panel_config {
-	struct omap_video_timings timings;
-
-	int acbi;	/* ac-bias pin transitions per interrupt */
-	/* Unit: line clocks */
-	int acb;	/* ac-bias pin frequency */
-
-	enum omap_panel_config config;
-
-	int power_on_delay;
-	int power_off_delay;
-
-	/*
-	 * Used to match device to panel configuration
-	 * when use generic panel driver
-	 */
-	const char *name;
-};
-
-/* Panel configurations */
-static struct panel_config generic_dpi_panels[] = {
-	/* Sharp LQ043T1DG01 */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 9000,
-
-			.hsw		= 42,
-			.hfp		= 3,
-			.hbp		= 2,
-
-			.vsw		= 11,
-			.vfp		= 3,
-			.vbp		= 2,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
-		.power_on_delay		= 50,
-		.power_off_delay	= 100,
-		.name			= "sharp_lq",
-	},
-
-	/* Sharp LS037V7DW01 */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 640,
-
-			.pixel_clock	= 19200,
-
-			.hsw		= 2,
-			.hfp		= 1,
-			.hbp		= 28,
-
-			.vsw		= 1,
-			.vfp		= 1,
-			.vbp		= 1,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x28,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
-		.power_on_delay		= 50,
-		.power_off_delay	= 100,
-		.name			= "sharp_ls",
-	},
-
-	/* Toppoly TDO35S */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 640,
-
-			.pixel_clock	= 26000,
-
-			.hfp		= 104,
-			.hsw		= 8,
-			.hbp		= 8,
-
-			.vfp		= 4,
-			.vsw		= 2,
-			.vbp		= 2,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
-					OMAP_DSS_LCD_ONOFF,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "toppoly_tdo35s",
-	},
-
-	/* Samsung LTE430WQ-F0C */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 9200,
-
-			.hfp		= 8,
-			.hsw		= 41,
-			.hbp		= 45 - 41,
-
-			.vfp		= 4,
-			.vsw		= 10,
-			.vbp		= 12 - 10,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "samsung_lte430wq_f0c",
-	},
-
-	/* Seiko 70WVW1TZ3Z3 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-
-			.pixel_clock	= 33000,
-
-			.hsw		= 128,
-			.hfp		= 10,
-			.hbp		= 10,
-
-			.vsw		= 2,
-			.vfp		= 4,
-			.vbp		= 11,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "seiko_70wvw1tz3",
-	},
-
-	/* Powertip PH480272T */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 9000,
-
-			.hsw		= 40,
-			.hfp		= 2,
-			.hbp		= 2,
-
-			.vsw		= 10,
-			.vfp		= 2,
-			.vbp		= 2,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "powertip_ph480272t",
-	},
-
-	/* Innolux AT070TN83 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-
-			.pixel_clock	= 40000,
-
-			.hsw		= 48,
-			.hfp		= 1,
-			.hbp		= 1,
-
-			.vsw		= 3,
-			.vfp		= 12,
-			.vbp		= 25,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x28,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "innolux_at070tn83",
-	},
-
-	/* NEC NL2432DR22-11B */
-	{
-		{
-			.x_res		= 240,
-			.y_res		= 320,
-
-			.pixel_clock	= 5400,
-
-			.hsw		= 3,
-			.hfp		= 3,
-			.hbp		= 39,
-
-			.vsw		= 1,
-			.vfp		= 2,
-			.vbp		= 7,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
-		.name			= "nec_nl2432dr22-11b",
-	},
-
-	/* Unknown panel used in OMAP H4 */
-	{
-		{
-			.x_res		= 240,
-			.y_res		= 320,
-
-			.pixel_clock	= 6250,
-
-			.hsw		= 15,
-			.hfp		= 15,
-			.hbp		= 60,
-
-			.vsw		= 1,
-			.vfp		= 1,
-			.vbp		= 1,
-		},
-		.config			= OMAP_DSS_LCD_TFT,
-
-		.name			= "h4",
-	},
-
-	/* Unknown panel used in Samsung OMAP2 Apollon */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 6250,
-
-			.hsw		= 41,
-			.hfp		= 2,
-			.hbp		= 2,
-
-			.vsw		= 10,
-			.vfp		= 2,
-			.vbp		= 2,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
-
-		.name			= "apollon",
-	},
-	/* FocalTech ETM070003DH6 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-
-			.pixel_clock	= 28000,
-
-			.hsw		= 48,
-			.hfp		= 40,
-			.hbp		= 40,
-
-			.vsw		= 3,
-			.vfp		= 13,
-			.vbp		= 29,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS,
-		.name			= "focaltech_etm070003dh6",
-	},
-
-	/* Microtips Technologies - UMSH-8173MD */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-
-			.pixel_clock	= 34560,
-
-			.hsw		= 13,
-			.hfp		= 101,
-			.hbp		= 101,
-
-			.vsw		= 23,
-			.vfp		= 1,
-			.vbp		= 1,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "microtips_umsh_8173md",
-	},
-
-	/* OrtusTech COM43H4M10XTC */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 8000,
-
-			.hsw		= 41,
-			.hfp		= 8,
-			.hbp		= 4,
-
-			.vsw		= 10,
-			.vfp		= 4,
-			.vbp		= 2,
-		},
-		.config			= OMAP_DSS_LCD_TFT,
-
-		.name			= "ortustech_com43h4m10xtc",
-	},
-
-	/* Innolux AT080TN52 */
-	{
-		{
-			.x_res = 800,
-			.y_res = 600,
-
-			.pixel_clock	= 41142,
-
-			.hsw		= 20,
-			.hfp		= 210,
-			.hbp		= 46,
-
-			.vsw		= 10,
-			.vfp		= 12,
-			.vbp		= 23,
-		},
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
-
-		.name			= "innolux_at080tn52",
-	},
-
-	/* Mitsubishi AA084SB01 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 600,
-			.pixel_clock	= 40000,
-
-			.hsw		= 1,
-			.hfp		= 254,
-			.hbp		= 1,
-
-			.vsw		= 1,
-			.vfp		= 26,
-			.vbp		= 1,
-		},
-		.config			= OMAP_DSS_LCD_TFT,
-		.name			= "mitsubishi_aa084sb01",
-	},
-	/* EDT ET0500G0DH6 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-			.pixel_clock	= 33260,
-
-			.hsw		= 128,
-			.hfp		= 216,
-			.hbp		= 40,
-
-			.vsw		= 2,
-			.vfp		= 35,
-			.vbp		= 10,
-		},
-		.config			= OMAP_DSS_LCD_TFT,
-		.name			= "edt_et0500g0dh6",
-	},
-
-	/* Prime-View PD050VL1 */
-	{
-		{
-			.x_res		= 640,
-			.y_res		= 480,
-
-			.pixel_clock	= 25000,
-
-			.hsw		= 96,
-			.hfp		= 18,
-			.hbp		= 46,
-
-			.vsw		= 2,
-			.vfp		= 10,
-			.vbp		= 33,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
-		.name			= "primeview_pd050vl1",
-	},
-
-	/* Prime-View PM070WL4 */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 480,
-
-			.pixel_clock	= 32000,
-
-			.hsw		= 128,
-			.hfp		= 42,
-			.hbp		= 86,
-
-			.vsw		= 2,
-			.vfp		= 10,
-			.vbp		= 33,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
-		.name			= "primeview_pm070wl4",
-	},
-
-	/* Prime-View PD104SLF */
-	{
-		{
-			.x_res		= 800,
-			.y_res		= 600,
-
-			.pixel_clock	= 40000,
-
-			.hsw		= 128,
-			.hfp		= 42,
-			.hbp		= 86,
-
-			.vsw		= 4,
-			.vfp		= 1,
-			.vbp		= 23,
-		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
-		.name			= "primeview_pd104slf",
-	},
-};
-
 struct panel_drv_data {
 
 	struct omap_dss_device *dssdev;
@@ -554,23 +103,17 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
-	struct panel_config *panel_config = NULL;
 	struct panel_drv_data *drv_data = NULL;
-	int i;
+	struct panel_config *panel_config;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
-	if (!panel_data || !panel_data->name)
+	if (!panel_data)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
-		if (strcmp(panel_data->name, generic_dpi_panels[i].name) == 0) {
-			panel_config = &generic_dpi_panels[i];
-			break;
-		}
-	}
-
-	if (!panel_config)
+	panel_config = &panel_data->pcfg;
+	/* Basic check for config availability */
+	if (!panel_config->timings.x_res)
 		return -EINVAL;
 
 	dssdev->panel.config = panel_config->config;
diff --git a/include/video/omap-panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
index 127e3f2..ca5206f 100644
--- a/include/video/omap-panel-generic-dpi.h
+++ b/include/video/omap-panel-generic-dpi.h
@@ -22,6 +22,19 @@
 
 struct omap_dss_device;
 
+struct panel_config {
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
+};
+
 /**
  * struct panel_generic_dpi_data - panel driver configuration data
  * @name: panel name
@@ -29,7 +42,7 @@ struct omap_dss_device;
  * @platform_disable: platform specific panel disable function
  */
 struct panel_generic_dpi_data {
-	const char *name;
+	struct panel_config pcfg;
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
 };
-- 
1.7.4.1

