From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/25] OMAPDSS: TFP410: rename dvi files to tfp410
Date: Thu,  3 May 2012 16:57:40 +0300
Message-ID: <1336053481-25433-5-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:43682 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756081Ab2ECN60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:26 -0400
Received: by lbol5 with SMTP id l5so1185444lbo.20
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:22 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the tfp410 driver has been renamed in the code, this patch
finishes the renaming by renaming the files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c         |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c       |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c          |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c      |    2 +-
 arch/arm/mach-omap2/board-igep0020.c        |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c     |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c        |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c    |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c      |    2 +-
 arch/arm/mach-omap2/board-overo.c           |    2 +-
 drivers/video/omap2/displays/Makefile       |    2 +-
 drivers/video/omap2/displays/panel-dvi.c    |  381 ---------------------------
 drivers/video/omap2/displays/panel-tfp410.c |  381 +++++++++++++++++++++++++++
 include/video/omap-panel-dvi.h              |   35 ---
 include/video/omap-panel-tfp410.h           |   35 +++
 15 files changed, 427 insertions(+), 427 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/panel-dvi.c
 create mode 100644 drivers/video/omap2/displays/panel-tfp410.c
 delete mode 100644 include/video/omap-panel-dvi.h
 create mode 100644 include/video/omap-panel-tfp410.h

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2a26d62..37abb0d 100644
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
index feecc96..99790eb 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -37,7 +37,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include "am35xx-emac.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 9e8efe9..45746cb 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -44,7 +44,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 #include <plat/mcspi.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5ea88f5..b063f0d 100644
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
index bf87f17..04816c9 100644
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
index 1795967..8ede8d2 100644
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
index 9cb0d08..9919d6c 100644
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
index a9acf96..4396bae 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -42,7 +42,7 @@
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e1f19b2..b26cd15 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -42,7 +42,7 @@
 #include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
-#include <video/omap-panel-dvi.h>
+#include <video/omap-panel-tfp410.h>
 
 #include "hsmmc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index aa83d46..5527c19 100644
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
diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-dvi.c
deleted file mode 100644
index e6d6849..0000000
--- a/drivers/video/omap2/displays/panel-dvi.c
+++ /dev/null
@@ -1,381 +0,0 @@
-/*
- * TFP410 DPI-to-DVI chip
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
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <video/omapdss.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <drm/drm_edid.h>
-
-#include <video/omap-panel-dvi.h>
-
-static const struct omap_video_timings tfp410_default_timings = {
-	.x_res		= 640,
-	.y_res		= 480,
-
-	.pixel_clock	= 23500,
-
-	.hfp		= 48,
-	.hsw		= 32,
-	.hbp		= 80,
-
-	.vfp		= 3,
-	.vsw		= 4,
-	.vbp		= 7,
-};
-
-struct panel_drv_data {
-	struct omap_dss_device *dssdev;
-
-	struct mutex lock;
-
-	int pd_gpio;
-};
-
-static inline struct tfp410_platform_data
-*get_pdata(const struct omap_dss_device *dssdev)
-{
-	return dssdev->data;
-}
-
-static int tfp410_power_on(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r = omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value(ddata->pd_gpio, 1);
-
-	return 0;
-err0:
-	return r;
-}
-
-static void tfp410_power_off(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value(ddata->pd_gpio, 0);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int tfp410_probe(struct omap_dss_device *dssdev)
-{
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
-	struct panel_drv_data *ddata;
-	int r;
-
-	ddata = kzalloc(sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
-
-	dssdev->panel.timings = tfp410_default_timings;
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
-
-	ddata->dssdev = dssdev;
-	mutex_init(&ddata->lock);
-
-	if (pdata)
-		ddata->pd_gpio = pdata->power_down_gpio;
-	else
-		ddata->pd_gpio = -1;
-
-	if (gpio_is_valid(ddata->pd_gpio)) {
-		r = gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
-				"tfp410 pd");
-		if (r) {
-			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
-					ddata->pd_gpio);
-			ddata->pd_gpio = -1;
-		}
-	}
-
-	dev_set_drvdata(&dssdev->dev, ddata);
-
-	return 0;
-}
-
-static void __exit tfp410_remove(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_free(ddata->pd_gpio);
-
-	dev_set_drvdata(&dssdev->dev, NULL);
-
-	mutex_unlock(&ddata->lock);
-
-	kfree(ddata);
-}
-
-static int tfp410_enable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&ddata->lock);
-
-	r = tfp410_power_on(dssdev);
-	if (r == 0)
-		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
-static void tfp410_disable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-
-	tfp410_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-
-	mutex_unlock(&ddata->lock);
-}
-
-static int tfp410_suspend(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-
-	tfp410_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&ddata->lock);
-
-	return 0;
-}
-
-static int tfp410_resume(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&ddata->lock);
-
-	r = tfp410_power_on(dssdev);
-	if (r == 0)
-		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
-static void tfp410_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-	dpi_set_timings(dssdev, timings);
-	mutex_unlock(&ddata->lock);
-}
-
-static void tfp410_get_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-	*timings = dssdev->panel.timings;
-	mutex_unlock(&ddata->lock);
-}
-
-static int tfp410_check_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&ddata->lock);
-	r = dpi_check_timings(dssdev, timings);
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
-
-static int tfp410_ddc_read(struct i2c_adapter *adapter,
-		unsigned char *buf, u16 count, u8 offset)
-{
-	int r, retries;
-
-	for (retries = 3; retries > 0; retries--) {
-		struct i2c_msg msgs[] = {
-			{
-				.addr   = DDC_ADDR,
-				.flags  = 0,
-				.len    = 1,
-				.buf    = &offset,
-			}, {
-				.addr   = DDC_ADDR,
-				.flags  = I2C_M_RD,
-				.len    = count,
-				.buf    = buf,
-			}
-		};
-
-		r = i2c_transfer(adapter, msgs, 2);
-		if (r == 2)
-			return 0;
-
-		if (r != -EAGAIN)
-			break;
-	}
-
-	return r < 0 ? r : -EIO;
-}
-
-static int tfp410_read_edid(struct omap_dss_device *dssdev,
-		u8 *edid, int len)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
-	struct i2c_adapter *adapter;
-	int r, l, bytes_read;
-
-	mutex_lock(&ddata->lock);
-
-	if (pdata->i2c_bus_num == 0) {
-		r = -ENODEV;
-		goto err;
-	}
-
-	adapter = i2c_get_adapter(pdata->i2c_bus_num);
-	if (!adapter) {
-		dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
-				pdata->i2c_bus_num);
-		r = -EINVAL;
-		goto err;
-	}
-
-	l = min(EDID_LENGTH, len);
-	r = tfp410_ddc_read(adapter, edid, l, 0);
-	if (r)
-		goto err;
-
-	bytes_read = l;
-
-	/* if there are extensions, read second block */
-	if (len > EDID_LENGTH && edid[0x7e] > 0) {
-		l = min(EDID_LENGTH, len - EDID_LENGTH);
-
-		r = tfp410_ddc_read(adapter, edid + EDID_LENGTH,
-				l, EDID_LENGTH);
-		if (r)
-			goto err;
-
-		bytes_read += l;
-	}
-
-	mutex_unlock(&ddata->lock);
-
-	return bytes_read;
-
-err:
-	mutex_unlock(&ddata->lock);
-	return r;
-}
-
-static bool tfp410_detect(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct tfp410_platform_data *pdata = get_pdata(dssdev);
-	struct i2c_adapter *adapter;
-	unsigned char out;
-	int r;
-
-	mutex_lock(&ddata->lock);
-
-	if (pdata->i2c_bus_num == 0)
-		goto out;
-
-	adapter = i2c_get_adapter(pdata->i2c_bus_num);
-	if (!adapter)
-		goto out;
-
-	r = tfp410_ddc_read(adapter, &out, 1, 0);
-
-	mutex_unlock(&ddata->lock);
-
-	return r == 0;
-
-out:
-	mutex_unlock(&ddata->lock);
-	return true;
-}
-
-static struct omap_dss_driver tfp410_driver = {
-	.probe		= tfp410_probe,
-	.remove		= __exit_p(tfp410_remove),
-
-	.enable		= tfp410_enable,
-	.disable	= tfp410_disable,
-	.suspend	= tfp410_suspend,
-	.resume		= tfp410_resume,
-
-	.set_timings	= tfp410_set_timings,
-	.get_timings	= tfp410_get_timings,
-	.check_timings	= tfp410_check_timings,
-
-	.read_edid	= tfp410_read_edid,
-	.detect		= tfp410_detect,
-
-	.driver         = {
-		.name   = "tfp410",
-		.owner  = THIS_MODULE,
-	},
-};
-
-static int __init tfp410_init(void)
-{
-	return omap_dss_register_driver(&tfp410_driver);
-}
-
-static void __exit tfp410_exit(void)
-{
-	omap_dss_unregister_driver(&tfp410_driver);
-}
-
-module_init(tfp410_init);
-module_exit(tfp410_exit);
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
new file mode 100644
index 0000000..52637fa
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -0,0 +1,381 @@
+/*
+ * TFP410 DPI-to-DVI chip
+ *
+ * Copyright (C) 2011 Texas Instruments Inc
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
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
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <video/omapdss.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <drm/drm_edid.h>
+
+#include <video/omap-panel-tfp410.h>
+
+static const struct omap_video_timings tfp410_default_timings = {
+	.x_res		= 640,
+	.y_res		= 480,
+
+	.pixel_clock	= 23500,
+
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+};
+
+struct panel_drv_data {
+	struct omap_dss_device *dssdev;
+
+	struct mutex lock;
+
+	int pd_gpio;
+};
+
+static inline struct tfp410_platform_data
+*get_pdata(const struct omap_dss_device *dssdev)
+{
+	return dssdev->data;
+}
+
+static int tfp410_power_on(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_set_value(ddata->pd_gpio, 1);
+
+	return 0;
+err0:
+	return r;
+}
+
+static void tfp410_power_off(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_set_value(ddata->pd_gpio, 0);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int tfp410_probe(struct omap_dss_device *dssdev)
+{
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
+	struct panel_drv_data *ddata;
+	int r;
+
+	ddata = kzalloc(sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	dssdev->panel.timings = tfp410_default_timings;
+	dssdev->panel.config = OMAP_DSS_LCD_TFT;
+
+	ddata->dssdev = dssdev;
+	mutex_init(&ddata->lock);
+
+	if (pdata)
+		ddata->pd_gpio = pdata->power_down_gpio;
+	else
+		ddata->pd_gpio = -1;
+
+	if (gpio_is_valid(ddata->pd_gpio)) {
+		r = gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
+				"tfp410 pd");
+		if (r) {
+			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
+					ddata->pd_gpio);
+			ddata->pd_gpio = -1;
+		}
+	}
+
+	dev_set_drvdata(&dssdev->dev, ddata);
+
+	return 0;
+}
+
+static void __exit tfp410_remove(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_free(ddata->pd_gpio);
+
+	dev_set_drvdata(&dssdev->dev, NULL);
+
+	mutex_unlock(&ddata->lock);
+
+	kfree(ddata);
+}
+
+static int tfp410_enable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	r = tfp410_power_on(dssdev);
+	if (r == 0)
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+static void tfp410_disable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	tfp410_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&ddata->lock);
+}
+
+static int tfp410_suspend(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	tfp410_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	mutex_unlock(&ddata->lock);
+
+	return 0;
+}
+
+static int tfp410_resume(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	r = tfp410_power_on(dssdev);
+	if (r == 0)
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+static void tfp410_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+	dpi_set_timings(dssdev, timings);
+	mutex_unlock(&ddata->lock);
+}
+
+static void tfp410_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+	*timings = dssdev->panel.timings;
+	mutex_unlock(&ddata->lock);
+}
+
+static int tfp410_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+	r = dpi_check_timings(dssdev, timings);
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+
+static int tfp410_ddc_read(struct i2c_adapter *adapter,
+		unsigned char *buf, u16 count, u8 offset)
+{
+	int r, retries;
+
+	for (retries = 3; retries > 0; retries--) {
+		struct i2c_msg msgs[] = {
+			{
+				.addr   = DDC_ADDR,
+				.flags  = 0,
+				.len    = 1,
+				.buf    = &offset,
+			}, {
+				.addr   = DDC_ADDR,
+				.flags  = I2C_M_RD,
+				.len    = count,
+				.buf    = buf,
+			}
+		};
+
+		r = i2c_transfer(adapter, msgs, 2);
+		if (r == 2)
+			return 0;
+
+		if (r != -EAGAIN)
+			break;
+	}
+
+	return r < 0 ? r : -EIO;
+}
+
+static int tfp410_read_edid(struct omap_dss_device *dssdev,
+		u8 *edid, int len)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
+	struct i2c_adapter *adapter;
+	int r, l, bytes_read;
+
+	mutex_lock(&ddata->lock);
+
+	if (pdata->i2c_bus_num == 0) {
+		r = -ENODEV;
+		goto err;
+	}
+
+	adapter = i2c_get_adapter(pdata->i2c_bus_num);
+	if (!adapter) {
+		dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
+				pdata->i2c_bus_num);
+		r = -EINVAL;
+		goto err;
+	}
+
+	l = min(EDID_LENGTH, len);
+	r = tfp410_ddc_read(adapter, edid, l, 0);
+	if (r)
+		goto err;
+
+	bytes_read = l;
+
+	/* if there are extensions, read second block */
+	if (len > EDID_LENGTH && edid[0x7e] > 0) {
+		l = min(EDID_LENGTH, len - EDID_LENGTH);
+
+		r = tfp410_ddc_read(adapter, edid + EDID_LENGTH,
+				l, EDID_LENGTH);
+		if (r)
+			goto err;
+
+		bytes_read += l;
+	}
+
+	mutex_unlock(&ddata->lock);
+
+	return bytes_read;
+
+err:
+	mutex_unlock(&ddata->lock);
+	return r;
+}
+
+static bool tfp410_detect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct tfp410_platform_data *pdata = get_pdata(dssdev);
+	struct i2c_adapter *adapter;
+	unsigned char out;
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	if (pdata->i2c_bus_num == 0)
+		goto out;
+
+	adapter = i2c_get_adapter(pdata->i2c_bus_num);
+	if (!adapter)
+		goto out;
+
+	r = tfp410_ddc_read(adapter, &out, 1, 0);
+
+	mutex_unlock(&ddata->lock);
+
+	return r == 0;
+
+out:
+	mutex_unlock(&ddata->lock);
+	return true;
+}
+
+static struct omap_dss_driver tfp410_driver = {
+	.probe		= tfp410_probe,
+	.remove		= __exit_p(tfp410_remove),
+
+	.enable		= tfp410_enable,
+	.disable	= tfp410_disable,
+	.suspend	= tfp410_suspend,
+	.resume		= tfp410_resume,
+
+	.set_timings	= tfp410_set_timings,
+	.get_timings	= tfp410_get_timings,
+	.check_timings	= tfp410_check_timings,
+
+	.read_edid	= tfp410_read_edid,
+	.detect		= tfp410_detect,
+
+	.driver         = {
+		.name   = "tfp410",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init tfp410_init(void)
+{
+	return omap_dss_register_driver(&tfp410_driver);
+}
+
+static void __exit tfp410_exit(void)
+{
+	omap_dss_unregister_driver(&tfp410_driver);
+}
+
+module_init(tfp410_init);
+module_exit(tfp410_exit);
+MODULE_LICENSE("GPL");
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-dvi.h
deleted file mode 100644
index 68c31d7..0000000
--- a/include/video/omap-panel-dvi.h
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
-	u16 i2c_bus_num;
-	int power_down_gpio;
-};
-
-#endif /* __OMAP_PANEL_TFP410_H */
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
new file mode 100644
index 0000000..68c31d7
--- /dev/null
+++ b/include/video/omap-panel-tfp410.h
@@ -0,0 +1,35 @@
+/*
+ * Header for TFP410 chip driver
+ *
+ * Copyright (C) 2011 Texas Instruments Inc
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
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
+#ifndef __OMAP_PANEL_TFP410_H
+#define __OMAP_PANEL_TFP410_H
+
+struct omap_dss_device;
+
+/**
+ * struct tfp410_platform_data - panel driver configuration data
+ * @i2c_bus_num: i2c bus id for the panel
+ * @power_down_gpio: gpio number for PD pin (or -1 if not available)
+ */
+struct tfp410_platform_data {
+	u16 i2c_bus_num;
+	int power_down_gpio;
+};
+
+#endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.9.5

