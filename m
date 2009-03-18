From: hvaibhav@ti.com
Subject: [PATCH 1/1] Back-light class driver support for OMAP
Date: Wed, 18 Mar 2009 19:40:10 +0530
Message-ID: <1237385410-29124-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47982 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939AbZCROKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2009 10:10:21 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, premi@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Till now OMAPFB driver was handling back-light interface
through it's own custom SYSFS entries. Earliear there
was a discussion where we decided to add support for OMAP
back-light into Generic class driver. Also Sanjeev has submitted
patch supporting back-light class driver.

This patch addresses review comments from 'Richard Purdie', and
adds support for OMAP3EVM.

NOTE:
	I am not sure whether back-light class driver interface
	still holds this implementation, since not a single platform
	I could found in kernel tree which follows this implementation.

	Since this implementation has been suggested by 'Richard Purdie',
	and I was readily having this patch so I am submitting it for review.

	The next version of patch will be devided into 3 seperate patches
		- twl4030 related changes
		- OMAPFB related changes
		- board-omap3evm.c related changes.

TODO:
	- Need to add simillar support for other platforms and development
	  boards.
	- Merge it to DSS2 and OMAP2FB

Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
Signed-off-by: Hardik Shah <hardik.shah@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c     |   37 ++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omapfb.h |    4 --
 drivers/video/omap/lcd_omap3evm.c        |   27 ---------------
 drivers/video/omap/omapfb_main.c         |   54 ------------------------------
 include/linux/i2c/twl4030.h              |   14 ++++++++
 5 files changed, 51 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 024d7c4..c749604 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/input.h>
 #include <linux/leds.h>
+#include <linux/backlight.h>

 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -225,6 +226,41 @@ static struct omap_lcd_config omap3_evm_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };

+#define TWL_PWMA_PWMAOFF	0x01
+
+static void omap3_set_bl_intensity(int intensity)
+{
+	unsigned char c;
+
+	if (intensity > 100)
+		return;
+
+	c = ((125 * (100 - intensity)) / 100) + 2;
+
+#if defined(CONFIG_TWL4030_CORE)
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL4030_LED_EN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+#endif
+
+}
+static struct generic_bl_info omap3_bl_platform_data = {
+	.name			= "omap3-bklight",
+	.max_intensity		= 100,
+	.default_intensity	= 70,
+	.limit_mask		= 0,
+	.set_bl_intensity	= omap3_set_bl_intensity,
+	.kick_battery		= NULL,
+};
+
+static struct platform_device omap3_bklight_device = {
+	.name			= "generic-bl",
+	.id			= -1,
+	.dev			= {
+		.parent		= &omap3_evm_lcd_device.dev,
+		.platform_data	= &omap3_bl_platform_data,
+	},
+};
+
 static void ads7846_dev_init(void)
 {
 	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
@@ -286,6 +322,7 @@ static struct omap_board_config_kernel omap3_evm_config[] __initdata = {

 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
+	&omap3_bklight_device,
 	&omap3evm_smc911x_device,
 };

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index b226bdf..b87466b 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -218,10 +218,6 @@ struct lcd_panel {
 	int		(*enable)	(struct lcd_panel *panel);
 	void		(*disable)	(struct lcd_panel *panel);
 	unsigned long	(*get_caps)	(struct lcd_panel *panel);
-	int		(*set_bklight_level)(struct lcd_panel *panel,
-					     unsigned int level);
-	unsigned int	(*get_bklight_level)(struct lcd_panel *panel);
-	unsigned int	(*get_bklight_max)  (struct lcd_panel *panel);
 	int		(*run_test)	(struct lcd_panel *panel, int test_num);
 };

diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 1c3d814..23238ae 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -49,7 +49,6 @@
 #define TWL_PWMA_PWMAON		0x00
 #define TWL_PWMA_PWMAOFF	0x01

-static unsigned int bklight_level;

 static int omap3evm_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
@@ -69,7 +68,6 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
-	bklight_level = 100;

 	return 0;
 }
@@ -94,28 +92,6 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }

-static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
-						unsigned int level)
-{
-	u8 c;
-	if ((level >= 0) && (level <= 100)) {
-		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
-		bklight_level = level;
-	}
-	return 0;
-}
-
-static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
-{
-	return bklight_level;
-}
-
-static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
-{
-	return 100;
-}
-
 struct lcd_panel omap3evm_panel = {
 	.name		= "omap3evm",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
@@ -139,9 +115,6 @@ struct lcd_panel omap3evm_panel = {
 	.enable		= omap3evm_panel_enable,
 	.disable	= omap3evm_panel_disable,
 	.get_caps	= omap3evm_panel_get_caps,
-	.set_bklight_level      = omap3evm_bklight_setlevel,
-	.get_bklight_level      = omap3evm_bklight_getlevel,
-	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
 };

 static int omap3evm_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 3bb4247..2d1dcfb 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1345,65 +1345,11 @@ static ssize_t omapfb_show_panel_name(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", fbdev->panel->name);
 }

-static ssize_t omapfb_show_bklight_level(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
-	int r;
-
-	if (fbdev->panel->get_bklight_level) {
-		r = snprintf(buf, PAGE_SIZE, "%d\n",
-			     fbdev->panel->get_bklight_level(fbdev->panel));
-	} else
-		r = -ENODEV;
-	return r;
-}
-
-static ssize_t omapfb_store_bklight_level(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t size)
-{
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
-	int r;
-
-	if (fbdev->panel->set_bklight_level) {
-		unsigned int level;
-
-		if (sscanf(buf, "%10d", &level) == 1) {
-			r = fbdev->panel->set_bklight_level(fbdev->panel,
-							    level);
-		} else
-			r = -EINVAL;
-	} else
-		r = -ENODEV;
-	return r ? r : size;
-}
-
-static ssize_t omapfb_show_bklight_max(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct omapfb_device *fbdev = (struct omapfb_device *)dev->driver_data;
-	int r;
-
-	if (fbdev->panel->get_bklight_level) {
-		r = snprintf(buf, PAGE_SIZE, "%d\n",
-			     fbdev->panel->get_bklight_max(fbdev->panel));
-	} else
-		r = -ENODEV;
-	return r;
-}
-
 static struct device_attribute dev_attr_panel_name =
 	__ATTR(name, 0444, omapfb_show_panel_name, NULL);
-static DEVICE_ATTR(backlight_level, 0664,
-		   omapfb_show_bklight_level, omapfb_store_bklight_level);
-static DEVICE_ATTR(backlight_max, 0444, omapfb_show_bklight_max, NULL);

 static struct attribute *panel_attrs[] = {
 	&dev_attr_panel_name.attr,
-	&dev_attr_backlight_level.attr,
-	&dev_attr_backlight_max.attr,
 	NULL,
 };

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index c89d33b..48063ba 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -84,6 +84,20 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 /*----------------------------------------------------------------------*/

 /*
+ * LED Module register offsets (use TWL4030_MODULE_LED)
+ */
+#define TWL4030_LED_EN			0x0
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * PWMA/B register offsets (use TWL4030_MODULE_PWMA/TWL4030_MODULE_PWMB)
+ */
+#define TWL4030_LED_PWMON		0x0
+#define TWL4030_LED_PWMOFF		0x1
+
+
+/*
  * NOTE:  at up to 1024 registers, this is a big chip.
  *
  * Avoid putting register declarations in this file, instead of into
--
1.5.6

