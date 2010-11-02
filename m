From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 1/3] OMAP: DSS2: Add dummy panel display driver
Date: Tue,  2 Nov 2010 12:13:08 -0400
Message-ID: <1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Dummy panel driver includes the driver and 4 similar panel configurations. It
will match the panel name which is passed from platform data and setup the
right configurations.

With dummy panel driver, we can remove those 4 duplicated panel display
drivers. In the future, it is simple for us just add new panel configuration
date in panel-dummy.h to support new display panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/Kconfig       |    8 +
 drivers/video/omap2/displays/Makefile      |    1 +
 drivers/video/omap2/displays/panel-dummy.c |  195 ++++++++++++++++++++++++++++
 drivers/video/omap2/displays/panel-dummy.h |  119 +++++++++++++++++
 4 files changed, 323 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-dummy.c
 create mode 100644 drivers/video/omap2/displays/panel-dummy.h

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 12327bb..4b2ed33 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -1,6 +1,14 @@
 menu "OMAP2/3 Display Device Drivers"
         depends on OMAP2_DSS
 
+config PANEL_DUMMY
+        tristate "Dummy Panel"
+        help
+	  Dummy panel driver.
+	  Supports DVI output for Beagle and OMAP3 SDP.
+	  Supports LCD Panel used in TI SDP3430 and EVM boards,
+	  OMAP3517 EVM boards and CM-T35.
+
 config PANEL_GENERIC
         tristate "Generic Panel"
         help
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index aa38609..5b50036 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_PANEL_DUMMY) += panel-dummy.o
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
diff --git a/drivers/video/omap2/displays/panel-dummy.c b/drivers/video/omap2/displays/panel-dummy.c
new file mode 100644
index 0000000..c4c387a
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-dummy.c
@@ -0,0 +1,195 @@
+/*
+ * Dummy Panels support
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
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
+#include <linux/delay.h>
+
+#include <plat/display.h>
+
+#include "panel-dummy.h"
+
+static int dummy_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+	struct omap_display_panel *p = &dssdev->panel;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	/* wait couple of vsyncs until enabling the LCD */
+	if (p->power_on_delay)
+		msleep(p->power_on_delay);
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void dummy_panel_power_off(struct omap_dss_device *dssdev)
+{
+	struct omap_display_panel *p = &dssdev->panel;
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	/* wait couple of vsyncs after disabling the LCD */
+	if (p->power_off_delay)
+		msleep(p->power_off_delay);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int dummy_panel_probe(struct omap_dss_device *dssdev)
+{
+	struct omap_display_panel *dp = &dssdev->panel;
+	struct omap_display_panel *pp = NULL;
+	int i;
+	int matched = 0;
+
+	if (dp->name == NULL)
+		return -ENODEV;
+
+	/* Match for the configuration of the panel */
+	for (i = 0; i < ARRAY_SIZE(dummy_panels); i++) {
+		pp = &dummy_panels[i];
+		if (strcmp(pp->name, dp->name) == 0) {
+			matched = 1;
+			break;
+		}
+	}
+
+	if (!matched)
+		return -ENODEV;
+
+	memcpy(dp, pp, sizeof(struct omap_display_panel));
+
+	return 0;
+}
+
+static void dummy_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int dummy_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = dummy_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void dummy_panel_disable(struct omap_dss_device *dssdev)
+{
+	dummy_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int dummy_panel_suspend(struct omap_dss_device *dssdev)
+{
+	dummy_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int dummy_panel_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = dummy_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void dummy_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dpi_set_timings(dssdev, timings);
+}
+
+static void dummy_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int dummy_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return dpi_check_timings(dssdev, timings);
+}
+
+static struct omap_dss_driver dummy_driver = {
+	.probe		= dummy_panel_probe,
+	.remove		= dummy_panel_remove,
+
+	.enable		= dummy_panel_enable,
+	.disable	= dummy_panel_disable,
+	.suspend	= dummy_panel_suspend,
+	.resume		= dummy_panel_resume,
+
+	.set_timings	= dummy_panel_set_timings,
+	.get_timings	= dummy_panel_get_timings,
+	.check_timings	= dummy_panel_check_timings,
+
+	.driver         = {
+		.name   = "dummy_panels",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init dummy_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&dummy_driver);
+}
+
+static void __exit dummy_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&dummy_driver);
+}
+
+module_init(dummy_panel_drv_init);
+module_exit(dummy_panel_drv_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays/panel-dummy.h b/drivers/video/omap2/displays/panel-dummy.h
new file mode 100644
index 0000000..ac2b7a2
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-dummy.h
@@ -0,0 +1,119 @@
+/*
+ * Dummy panels support
+ *
+ * Copyright (C) 2010 Bryan Wu
+ * Author: Bryan Wu <bryan.wu@canonical.com>
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
+static struct omap_display_panel dummy_panels[] = {
+	/* Generic Panel */
+	{
+		{
+			.x_res		= 640,
+			.y_res		= 480,
+
+			.pixel_clock	= 23500,
+
+			.hfp		= 48,
+			.hsw		= 32,
+			.hbp		= 80,
+
+			.vfp		= 3,
+			.vsw		= 4,
+			.vbp		= 7,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "generic",
+	},
+
+	/* Sharp LQ043T1DG01 */
+	{
+		{	.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 9000,
+
+			.hsw		= 42,
+			.hfp		= 3,
+			.hbp		= 2,
+
+			.vsw		= 11,
+			.vfp		= 3,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "sharp_lq",
+	},
+
+	/* Sharp LS037V7DW01 */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 19200,
+
+			.hsw		= 2,
+			.hfp		= 1,
+			.hbp		= 28,
+
+			.vsw		= 1,
+			.vfp		= 1,
+			.vbp		= 1,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+						OMAP_DSS_LCD_IHS,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "sharp_ls",
+	},
+
+	/* Toppoly TDO35S */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 26000,
+
+			.hfp		= 104,
+			.hsw		= 8,
+			.hbp		= 8,
+
+			.vfp		= 4,
+			.vsw		= 2,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
+					OMAP_DSS_LCD_ONOFF,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "toppoly_tdo35s",
+	},
+};
-- 
1.7.1
