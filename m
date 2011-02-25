From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 6/8] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in the DSS
Date: Fri, 25 Feb 2011 19:51:53 +0530
Message-ID: <1298643715-21540-7-git-send-email-mythripk@ti.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46318 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab1BYNyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 08:54:47 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1PDslnT007186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 07:54:47 -0600
In-Reply-To: <1298643715-21540-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

The panel driver(hdmi_omap4_panel.c) in dss file acts as a controller
to manage the enable and disable requests and synchronize audio and video.
Also the header file to export the hdmi registers is added in the
plat-omap , so that it can be accessed by audio driver.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/Kconfig            |    8 ++
 drivers/video/omap2/dss/Makefile           |    1 +
 drivers/video/omap2/dss/hdmi_omap4_panel.c |  190 ++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index fe1ab09..670a55d 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -125,4 +125,12 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
 	  Max FCK is 173MHz, so this doesn't work if your PCK
 	  is very high.
 
+config OMAP4_PANEL_HDMI
+	bool "HDMI panel support"
+	depends on OMAP2_DSS_HDMI
+        default n
+	help
+	  HDMI panel. This adds the High Definition Multimedia panel.
+	  See http://www.hdmi.org/ for HDMI specification.
+
 endif
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 5998b69..95234d4 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -6,3 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP2_DSS_HDMI) += hdmi.o
+obj-$(CONFIG_OMAP4_PANEL_HDMI) += hdmi_omap4_panel.o
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
new file mode 100644
index 0000000..c28b1f6
--- /dev/null
+++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
@@ -0,0 +1,190 @@
+/*
+ * hdmi_omap4_panel.c
+ *
+ * HDMI library support functions for TI OMAP4 processors.
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Authors:	MythriPk <mythripk@ti.com>
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
+#define DSS_SUBSYS_NAME "HDMI"
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <plat/display.h>
+
+#include "dss.h"
+
+static struct {
+	struct mutex hdmi_lock;
+} hdmi;
+
+
+static int hdmi_panel_probe(struct omap_dss_device *dssdev)
+{
+	DSSDBG("ENTER hdmi_panel_probe\n");
+
+	dssdev->panel.config = OMAP_DSS_LCD_TFT |
+			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
+
+	/*
+	 * Initialize the timings to 1920 * 1080
+	 * This is only for framebuffer update not for TV timing setting
+	 * Setting TV timing will be done only on enable
+	 */
+	dssdev->panel.timings.x_res = 1920;
+	dssdev->panel.timings.y_res = 1080;
+
+	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
+		dssdev->panel.timings.x_res,
+		dssdev->panel.timings.y_res);
+	return 0;
+}
+
+static void hdmi_panel_remove(struct omap_dss_device *dssdev)
+{
+
+}
+
+static int hdmi_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+	DSSDBG("ENTER hdmi_panel_enable\n");
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
+		return -EINVAL;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	r = omapdss_hdmi_display_enable(dssdev);
+	if (r) {
+		DSSERR("failed to power on\n");
+		return r;
+	}
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&hdmi.hdmi_lock);
+
+	return 0;
+}
+
+static void hdmi_panel_disable(struct omap_dss_device *dssdev)
+{
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		omapdss_hdmi_display_disable(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&hdmi.hdmi_lock);
+}
+
+static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
+			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+		return -EINVAL;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	omapdss_hdmi_display_suspend(dssdev);
+
+	mutex_unlock(&hdmi.hdmi_lock);
+
+	return 0;
+}
+
+static int hdmi_panel_resume(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return -EINVAL;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	omapdss_hdmi_display_resume(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&hdmi.hdmi_lock);
+
+	return 0;
+}
+
+static void hdmi_get_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static void hdmi_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	DSSDBG("hdmi_set_timings\n");
+
+	dssdev->panel.timings = *timings;
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		/* turn the hdmi off and on to get new timings to use */
+		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_display_enable(dssdev);
+	}
+
+	mutex_unlock(&hdmi.hdmi_lock);
+}
+
+static struct omap_dss_driver hdmi_driver = {
+	.probe		= hdmi_panel_probe,
+	.remove		= hdmi_panel_remove,
+	.enable		= hdmi_panel_enable,
+	.disable	= hdmi_panel_disable,
+	.suspend	= hdmi_panel_suspend,
+	.resume		= hdmi_panel_resume,
+	.get_timings	= hdmi_get_timings,
+	.set_timings	= hdmi_set_timings,
+	.driver			= {
+		.name   = "hdmi_panel",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init hdmi_panel_init(void)
+{
+	mutex_init(&hdmi.hdmi_lock);
+
+	omap_dss_register_driver(&hdmi_driver);
+
+	return 0;
+}
+
+static void __exit hdmi_panel_exit(void)
+{
+	omap_dss_unregister_driver(&hdmi_driver);
+
+}
+
+module_init(hdmi_panel_init);
+module_exit(hdmi_panel_exit);
-- 
1.5.6.3

