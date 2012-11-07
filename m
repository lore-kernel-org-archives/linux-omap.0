From: Archit Taneja <archit@ti.com>
Subject: [RFC 01/11] OMAPDSS: Add writeback output driver
Date: Wed, 7 Nov 2012 20:14:19 +0530
Message-ID: <1352299469-17609-2-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50616 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab2KGOoz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:44:55 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback is implemented as an output driver. This lets writeback to connect
to overlay managers, and configure writeback's manager like properties the same
way other output drivers do.

This driver can be considered something similar to the DPI output driver. It
provides functions which configure the writeback's manager-like registers via
apply. One difference though is that these functions won't be used by a panel
driver. They'd be used by a writeback user directly.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Kconfig     |   13 +++++
 drivers/video/omap2/dss/Makefile    |    1 +
 drivers/video/omap2/dss/core.c      |    6 +++
 drivers/video/omap2/dss/dss.h       |    6 +++
 drivers/video/omap2/dss/writeback.c |  102 +++++++++++++++++++++++++++++++++++
 include/video/omapdss.h             |   10 ++++
 6 files changed, 138 insertions(+)
 create mode 100644 drivers/video/omap2/dss/writeback.c

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 50e8802..9e52d4b 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -99,6 +99,19 @@ config OMAP2_DSS_DSI
 
 	  See http://www.mipi.org/ for DSI specifications.
 
+config OMAP4_DSS_WRITEBACK
+	bool "writeback support"
+	default n
+	help
+	  writeback is a DISPC pipeline that takes pixel data from an overlay
+	  output or a overlay manager output and writes it back into a specified
+	  address in memory.
+
+	  writeback pipeline allows us to take benefit of the hardware
+	  processing available inside the DISPC like color space conversion,
+	  rescaling, compositing etc and perform either a memory-to-memory
+	  transfer with data processing, or capture a displayed frame.
+
 config OMAP2_DSS_MIN_FCK_PER_PCK
 	int "Minimum FCK/PCK ratio (for scaling)"
 	range 0 32
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 4070191..211a290 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -8,4 +8,5 @@ omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
 				    hdmi_panel.o ti_hdmi_4xxx_ip.o
+omapdss-$(CONFIG_OMAP4_DSS_WRITEBACK) += writeback.o
 ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b1a9ce1..4040868 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -528,6 +528,9 @@ static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_init_platform_driver,
 #endif
+#ifdef CONFIG_OMAP4_DSS_WRITEBACK
+	writeback_init_platform_driver,
+#endif
 };
 
 static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
@@ -549,6 +552,9 @@ static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_uninit_platform_driver,
 #endif
+#ifdef CONFIG_OMAP4_DSS_WRITEBACK
+	writeback_uninit_platform_driver,
+#endif
 };
 
 static bool dss_output_drv_loaded[ARRAY_SIZE(dss_output_drv_reg_funcs)];
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 84a7f6a..f7eb7d6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -528,6 +528,12 @@ bool hdmi_mode_has_audio(void);
 int hdmi_audio_config(struct omap_dss_audio *audio);
 #endif
 
+/* Writeback */
+#ifdef CONFIG_OMAP4_DSS_WRITEBACK
+int writeback_init_platform_driver(void) __init;
+void writeback_uninit_platform_driver(void) __exit;
+#endif
+
 /* RFBI */
 int rfbi_init_platform_driver(void) __init;
 void rfbi_uninit_platform_driver(void) __exit;
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
new file mode 100644
index 0000000..b5c6406
--- /dev/null
+++ b/drivers/video/omap2/dss/writeback.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Archit Taneja <archit@ti.com>
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
+#define DSS_SUBSYS_NAME "WB"
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+
+struct writeback_data {
+	struct mutex lock;
+
+	struct omap_dss_output output;
+};
+
+static inline struct writeback_data *writeback_get_drv_data(struct platform_device *wbdev)
+{
+	return dev_get_drvdata(&wbdev->dev);
+}
+
+static inline struct platform_device *writeback_get_wbdev_from_output(struct omap_dss_output *out)
+{
+	return out->pdev;
+}
+
+struct omap_dss_output *omap_dss_get_writeback(void)
+{
+	return omap_dss_get_output(OMAP_DSS_OUTPUT_WB);
+}
+EXPORT_SYMBOL(omap_dss_get_writeback);
+
+static void __init writeback_init_output(struct platform_device *pdev,
+		struct writeback_data *wb_data)
+{
+	struct omap_dss_output *out = &wb_data->output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_WB;
+	out->type = OMAP_DISPLAY_TYPE_NONE;
+}
+
+static int __init omap_writeback_probe(struct platform_device *pdev)
+{
+	struct writeback_data *wb_data;
+
+	wb_data = devm_kzalloc(&pdev->dev, sizeof(*wb_data), GFP_KERNEL);
+	if (!wb_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, wb_data);
+
+	mutex_init(&wb_data->lock);
+
+	writeback_init_output(pdev, wb_data);
+
+	return 0;
+}
+
+static int __exit omap_writeback_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_writeback_driver = {
+	.remove         = __exit_p(omap_writeback_remove),
+	.driver         = {
+		.name   = "omapdss_writeback",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int __init writeback_init_platform_driver(void)
+{
+	return platform_driver_probe(&omap_writeback_driver,
+			omap_writeback_probe);
+}
+
+void __exit writeback_uninit_platform_driver(void)
+{
+	platform_driver_unregister(&omap_writeback_driver);
+}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b1248c2..e81fcb2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -217,6 +217,7 @@ enum omap_dss_output_id {
 	OMAP_DSS_OUTPUT_DSI2	= 1 << 4,
 	OMAP_DSS_OUTPUT_VENC	= 1 << 5,
 	OMAP_DSS_OUTPUT_HDMI	= 1 << 6,
+	OMAP_DSS_OUTPUT_WB	= 1 << 7,
 };
 
 /* RFBI */
@@ -836,4 +837,13 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+#ifdef CONFIG_OMAP4_DSS_WRITEBACK
+struct omap_dss_output *omap_dss_get_writeback(void);
+#else
+static inline struct omap_dss_output *omap_dss_get_writeback(void)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
1.7.9.5

