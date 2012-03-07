From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/21] OMAPDSS: TFP410: rename dvi -> tfp410
Date: Wed,  7 Mar 2012 14:44:32 +0200
Message-ID: <1331124290-6285-4-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:33636 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757078Ab2CGMpR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 07:45:17 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so7306984laa.10
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:15 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

The driver for the TFP410 DVI framer chip was named quite badly as "DVI
panel driver". This patch renames the code to use tfp410 name for the
driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    4 +-
 arch/arm/mach-omap2/board-am3517evm.c    |    4 +-
 arch/arm/mach-omap2/board-cm-t35.c       |    4 +-
 arch/arm/mach-omap2/board-devkit8000.c   |    4 +-
 arch/arm/mach-omap2/board-igep0020.c     |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    4 +-
 arch/arm/mach-omap2/board-omap3stalker.c |    4 +-
 arch/arm/mach-omap2/board-omap4panda.c   |    4 +-
 arch/arm/mach-omap2/board-overo.c        |    4 +-
 drivers/video/omap2/displays/Kconfig     |    8 +-
 drivers/video/omap2/displays/Makefile    |    2 +-
 drivers/video/omap2/displays/panel-dvi.c |   94 +++++++++++++++---------------
 include/video/omap-panel-dvi.h           |   12 ++--
 14 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7105005..2c153bb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -157,14 +157,14 @@ static struct omap_dss_device sdp3430_lcd_device = {
 	.platform_disable	= sdp3430_panel_disable_lcd,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device sdp3430_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 958dd97..c38dac1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -320,14 +320,14 @@ static struct omap_dss_device am3517_evm_tv_device = {
 	.platform_disable	= am3517_evm_panel_disable_tv,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device am3517_evm_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 5a361c9..94d5167 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -225,14 +225,14 @@ static struct omap_dss_device cm_t35_lcd_device = {
 	.phy.dpi.data_lines	= 18,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
 };
 
 static struct omap_dss_device cm_t35_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 07edb6d..d1bead0 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -140,14 +140,14 @@ static struct omap_dss_device devkit8000_lcd_device = {
 	.phy.dpi.data_lines     = 24,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device devkit8000_dvi_device = {
 	.name                   = "dvi",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "dvi",
+	.driver_name            = "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines     = 24,
 };
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 21188f8..ae1b157 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -443,7 +443,7 @@ static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.setup		= igep_twl_gpio_setup,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= IGEP2_GPIO_DVI_PUP,
 };
@@ -451,7 +451,7 @@ static struct panel_dvi_platform_data dvi_panel = {
 static struct omap_dss_device igep2_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 26c9df4..5f858e9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -189,7 +189,7 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 
 /* DSS */
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num = 3,
 	.power_down_gpio = -1,
 };
@@ -197,7 +197,7 @@ static struct panel_dvi_platform_data dvi_panel = {
 static struct omap_dss_device beagle_dvi_device = {
 	.type = OMAP_DISPLAY_TYPE_DPI,
 	.name = "dvi",
-	.driver_name = "dvi",
+	.driver_name = "tfp410",
 	.data = &dvi_panel,
 	.phy.dpi.data_lines = 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1467fbf..840fb99 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -228,14 +228,14 @@ static struct omap_dss_device omap3_evm_tv_device = {
 	.platform_disable	= omap3_evm_disable_tv,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
 };
 
 static struct omap_dss_device omap3_evm_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 22444c2..8a292cc 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -127,14 +127,14 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 	.platform_disable	= omap3_stalker_disable_tv,
 };
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= DSS_ENABLE_GPIO,
 };
 
 static struct omap_dss_device omap3_stalker_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e773f28..8196d6e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -373,7 +373,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
 /* Using generic display panel */
-static struct panel_dvi_platform_data omap4_dvi_panel = {
+static struct tfp410_platform_data omap4_dvi_panel = {
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 };
@@ -381,7 +381,7 @@ static struct panel_dvi_platform_data omap4_dvi_panel = {
 struct omap_dss_device omap4_panda_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &omap4_dvi_panel,
 	.phy.dpi.data_lines	= 24,
 	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 21e900e..76e06e4 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -167,7 +167,7 @@ static void __init overo_display_init(void)
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
 }
 
-static struct panel_dvi_platform_data dvi_panel = {
+static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= -1,
 };
@@ -175,7 +175,7 @@ static struct panel_dvi_platform_data dvi_panel = {
 static struct omap_dss_device overo_dvi_device = {
 	.name			= "dvi",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "dvi",
+	.driver_name		= "tfp410",
 	.data			= &dvi_panel,
 	.phy.dpi.data_lines	= 24,
 };
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 408a992..1395438 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -10,12 +10,12 @@ config PANEL_GENERIC_DPI
 	  Supports LCD Panel used in TI SDP3430 and EVM boards,
 	  OMAP3517 EVM boards and CM-T35.
 
-config PANEL_DVI
-	tristate "DVI output"
+config PANEL_TFP410
+	tristate "TFP410 DVI Framer"
 	depends on OMAP2_DSS_DPI && I2C
 	help
-	  Driver for external monitors, connected via DVI. The driver uses i2c
-	  to read EDID information from the monitor.
+	  Driver for TFP410 DVI framer chip. The driver uses i2c to read EDID
+	  information from the monitor.
 
 config PANEL_LGPHILIPS_LB035Q02
 	tristate "LG.Philips LB035Q02 LCD Panel"
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index fbfafc6..58905ef0 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
-obj-$(CONFIG_PANEL_DVI) += panel-dvi.o
+obj-$(CONFIG_PANEL_TFP410) += panel-dvi.o
 obj-$(CONFIG_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-dvi.c
index 7e8cadd..1ec996d 100644
--- a/drivers/video/omap2/displays/panel-dvi.c
+++ b/drivers/video/omap2/displays/panel-dvi.c
@@ -1,5 +1,5 @@
 /*
- * DVI output support
+ * TFP410 DVI framer chip
  *
  * Copyright (C) 2011 Texas Instruments Inc
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
@@ -26,7 +26,7 @@
 
 #include <video/omap-panel-dvi.h>
 
-static const struct omap_video_timings panel_dvi_default_timings = {
+static const struct omap_video_timings tfp410_default_timings = {
 	.x_res		= 640,
 	.y_res		= 480,
 
@@ -49,13 +49,13 @@ struct panel_drv_data {
 	int pd_gpio;
 };
 
-static inline struct panel_dvi_platform_data
+static inline struct tfp410_platform_data
 *get_pdata(const struct omap_dss_device *dssdev)
 {
 	return dssdev->data;
 }
 
-static int panel_dvi_power_on(struct omap_dss_device *dssdev)
+static int tfp410_power_on(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 	int r;
@@ -75,7 +75,7 @@ err0:
 	return r;
 }
 
-static void panel_dvi_power_off(struct omap_dss_device *dssdev)
+static void tfp410_power_off(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
@@ -88,9 +88,9 @@ static void panel_dvi_power_off(struct omap_dss_device *dssdev)
 	omapdss_dpi_display_disable(dssdev);
 }
 
-static int panel_dvi_probe(struct omap_dss_device *dssdev)
+static int tfp410_probe(struct omap_dss_device *dssdev)
 {
-	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
 	struct panel_drv_data *ddata;
 	int r;
 
@@ -98,7 +98,7 @@ static int panel_dvi_probe(struct omap_dss_device *dssdev)
 	if (!ddata)
 		return -ENOMEM;
 
-	dssdev->panel.timings = panel_dvi_default_timings;
+	dssdev->panel.timings = tfp410_default_timings;
 	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 
 	ddata->dssdev = dssdev;
@@ -124,7 +124,7 @@ static int panel_dvi_probe(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void __exit panel_dvi_remove(struct omap_dss_device *dssdev)
+static void __exit tfp410_remove(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
@@ -140,14 +140,14 @@ static void __exit panel_dvi_remove(struct omap_dss_device *dssdev)
 	kfree(ddata);
 }
 
-static int panel_dvi_enable(struct omap_dss_device *dssdev)
+static int tfp410_enable(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 	int r;
 
 	mutex_lock(&ddata->lock);
 
-	r = panel_dvi_power_on(dssdev);
+	r = tfp410_power_on(dssdev);
 	if (r == 0)
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -156,26 +156,26 @@ static int panel_dvi_enable(struct omap_dss_device *dssdev)
 	return r;
 }
 
-static void panel_dvi_disable(struct omap_dss_device *dssdev)
+static void tfp410_disable(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
 	mutex_lock(&ddata->lock);
 
-	panel_dvi_power_off(dssdev);
+	tfp410_power_off(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	mutex_unlock(&ddata->lock);
 }
 
-static int panel_dvi_suspend(struct omap_dss_device *dssdev)
+static int tfp410_suspend(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
 	mutex_lock(&ddata->lock);
 
-	panel_dvi_power_off(dssdev);
+	tfp410_power_off(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
@@ -184,14 +184,14 @@ static int panel_dvi_suspend(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int panel_dvi_resume(struct omap_dss_device *dssdev)
+static int tfp410_resume(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 	int r;
 
 	mutex_lock(&ddata->lock);
 
-	r = panel_dvi_power_on(dssdev);
+	r = tfp410_power_on(dssdev);
 	if (r == 0)
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -200,7 +200,7 @@ static int panel_dvi_resume(struct omap_dss_device *dssdev)
 	return r;
 }
 
-static void panel_dvi_set_timings(struct omap_dss_device *dssdev,
+static void tfp410_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
@@ -210,7 +210,7 @@ static void panel_dvi_set_timings(struct omap_dss_device *dssdev,
 	mutex_unlock(&ddata->lock);
 }
 
-static void panel_dvi_get_timings(struct omap_dss_device *dssdev,
+static void tfp410_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
@@ -220,7 +220,7 @@ static void panel_dvi_get_timings(struct omap_dss_device *dssdev,
 	mutex_unlock(&ddata->lock);
 }
 
-static int panel_dvi_check_timings(struct omap_dss_device *dssdev,
+static int tfp410_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
@@ -234,7 +234,7 @@ static int panel_dvi_check_timings(struct omap_dss_device *dssdev,
 }
 
 
-static int panel_dvi_ddc_read(struct i2c_adapter *adapter,
+static int tfp410_ddc_read(struct i2c_adapter *adapter,
 		unsigned char *buf, u16 count, u8 offset)
 {
 	int r, retries;
@@ -265,11 +265,11 @@ static int panel_dvi_ddc_read(struct i2c_adapter *adapter,
 	return r < 0 ? r : -EIO;
 }
 
-static int panel_dvi_read_edid(struct omap_dss_device *dssdev,
+static int tfp410_read_edid(struct omap_dss_device *dssdev,
 		u8 *edid, int len)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
 	struct i2c_adapter *adapter;
 	int r, l, bytes_read;
 
@@ -289,7 +289,7 @@ static int panel_dvi_read_edid(struct omap_dss_device *dssdev,
 	}
 
 	l = min(EDID_LENGTH, len);
-	r = panel_dvi_ddc_read(adapter, edid, l, 0);
+	r = tfp410_ddc_read(adapter, edid, l, 0);
 	if (r)
 		goto err;
 
@@ -299,7 +299,7 @@ static int panel_dvi_read_edid(struct omap_dss_device *dssdev,
 	if (len > EDID_LENGTH && edid[0x7e] > 0) {
 		l = min(EDID_LENGTH, len - EDID_LENGTH);
 
-		r = panel_dvi_ddc_read(adapter, edid + EDID_LENGTH,
+		r = tfp410_ddc_read(adapter, edid + EDID_LENGTH,
 				l, EDID_LENGTH);
 		if (r)
 			goto err;
@@ -316,10 +316,10 @@ err:
 	return r;
 }
 
-static bool panel_dvi_detect(struct omap_dss_device *dssdev)
+static bool tfp410_detect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
 	struct i2c_adapter *adapter;
 	unsigned char out;
 	int r;
@@ -333,7 +333,7 @@ static bool panel_dvi_detect(struct omap_dss_device *dssdev)
 	if (!adapter)
 		goto out;
 
-	r = panel_dvi_ddc_read(adapter, &out, 1, 0);
+	r = tfp410_ddc_read(adapter, &out, 1, 0);
 
 	mutex_unlock(&ddata->lock);
 
@@ -344,38 +344,38 @@ out:
 	return true;
 }
 
-static struct omap_dss_driver panel_dvi_driver = {
-	.probe		= panel_dvi_probe,
-	.remove		= __exit_p(panel_dvi_remove),
+static struct omap_dss_driver tfp410_driver = {
+	.probe		= tfp410_probe,
+	.remove		= __exit_p(tfp410_remove),
 
-	.enable		= panel_dvi_enable,
-	.disable	= panel_dvi_disable,
-	.suspend	= panel_dvi_suspend,
-	.resume		= panel_dvi_resume,
+	.enable		= tfp410_enable,
+	.disable	= tfp410_disable,
+	.suspend	= tfp410_suspend,
+	.resume		= tfp410_resume,
 
-	.set_timings	= panel_dvi_set_timings,
-	.get_timings	= panel_dvi_get_timings,
-	.check_timings	= panel_dvi_check_timings,
+	.set_timings	= tfp410_set_timings,
+	.get_timings	= tfp410_get_timings,
+	.check_timings	= tfp410_check_timings,
 
-	.read_edid	= panel_dvi_read_edid,
-	.detect		= panel_dvi_detect,
+	.read_edid	= tfp410_read_edid,
+	.detect		= tfp410_detect,
 
 	.driver         = {
-		.name   = "dvi",
+		.name   = "tfp410",
 		.owner  = THIS_MODULE,
 	},
 };
 
-static int __init panel_dvi_init(void)
+static int __init tfp410_init(void)
 {
-	return omap_dss_register_driver(&panel_dvi_driver);
+	return omap_dss_register_driver(&tfp410_driver);
 }
 
-static void __exit panel_dvi_exit(void)
+static void __exit tfp410_exit(void)
 {
-	omap_dss_unregister_driver(&panel_dvi_driver);
+	omap_dss_unregister_driver(&tfp410_driver);
 }
 
-module_init(panel_dvi_init);
-module_exit(panel_dvi_exit);
+module_init(tfp410_init);
+module_exit(tfp410_exit);
 MODULE_LICENSE("GPL");
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-dvi.h
index a782124..68c31d7 100644
--- a/include/video/omap-panel-dvi.h
+++ b/include/video/omap-panel-dvi.h
@@ -1,5 +1,5 @@
 /*
- * Header for DVI output driver
+ * Header for TFP410 chip driver
  *
  * Copyright (C) 2011 Texas Instruments Inc
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
@@ -17,19 +17,19 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef __OMAP_PANEL_DVI_H
-#define __OMAP_PANEL_DVI_H
+#ifndef __OMAP_PANEL_TFP410_H
+#define __OMAP_PANEL_TFP410_H
 
 struct omap_dss_device;
 
 /**
- * struct panel_dvi_platform_data - panel driver configuration data
+ * struct tfp410_platform_data - panel driver configuration data
  * @i2c_bus_num: i2c bus id for the panel
  * @power_down_gpio: gpio number for PD pin (or -1 if not available)
  */
-struct panel_dvi_platform_data {
+struct tfp410_platform_data {
 	u16 i2c_bus_num;
 	int power_down_gpio;
 };
 
-#endif /* __OMAP_PANEL_DVI_H */
+#endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.4.1

