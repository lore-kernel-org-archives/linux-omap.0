From: y@legion.dal.design.ti.com
Subject: [PATCH 1/2] OMAP: DSS2: Introduce dss_features files
Date: Thu, 26 Aug 2010 18:00:27 +0530
Message-ID: <11192.0904055753$1282825780@news.gmane.org>
References: <1282825828-24115-1-git-send-email-y>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0HZM3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 08:29:33 -0400
In-Reply-To: <1282825828-24115-1-git-send-email-y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

Add dss_features.c and dss_features.h for the dss_features framework

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |  197 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |   48 ++++++++
 2 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dss_features.c
 create mode 100644 drivers/video/omap2/dss/dss_features.h

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
new file mode 100644
index 0000000..0ac18d2
--- /dev/null
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -0,0 +1,197 @@
+/*
+ * linux/drivers/video/omap2/dss/dss_features.c
+ *
+ * Copyright (C) 2010 Texas Instruments
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <plat/display.h>
+#include <plat/cpu.h>
+
+#include "dss_features.h"
+
+static struct list_head reg_field_list;
+static int num_reg_fields;
+
+/* Defines a generic omap register field */
+struct dss_reg_field {
+	struct list_head list;
+	int id;
+	u8 start, end;
+};
+
+/* This struct is divided into 2 sets: the first gives a value corresponding
+ * to a feature, the second tells if a dss feature exists or not */
+static struct
+{
+	int num_mgrs;
+	int num_ovls;
+	enum omap_display_type supported_displays[MAX_DSS_MANAGERS];
+	enum omap_color_mode supported_color_modes[MAX_DSS_OVERLAYS];
+
+	bool has_feature[MAX_DSS_FEATURES];
+} omap_dss_features;
+
+/* Functions to add/fetch the start and end bits of a DSS register field */
+static void dss_add_reg_field(int id, u8 start, u8 end)
+{
+	struct dss_reg_field *field;
+	field = kzalloc(sizeof(*field), GFP_KERNEL);
+
+	++num_reg_fields;
+
+	field->id = id;
+	field->start = start;
+	field->end = end;
+
+	list_add_tail(&field->list, &reg_field_list);
+}
+
+void omap_dss_get_reg_field(int id, u8 *start, u8 *end)
+{
+	struct dss_reg_field *field;
+
+	list_for_each_entry(field, &reg_field_list, list) {
+		if (field->id == id) {
+			*start = field->start;
+			*end = field->end;
+			return;
+		}
+	}
+	BUG();
+}
+EXPORT_SYMBOL(omap_dss_get_reg_field);
+
+/* Functions returning values related to a DSS feature */
+int omap_dss_num_mgrs(void)
+{
+	return omap_dss_features.num_mgrs;
+}
+EXPORT_SYMBOL(omap_dss_num_mgrs);
+
+int omap_dss_num_ovls(void)
+{
+	return omap_dss_features.num_ovls;
+}
+EXPORT_SYMBOL(omap_dss_num_ovls);
+
+enum omap_display_type omap_dss_supported_displays(int id)
+{
+	return omap_dss_features.supported_displays[id];
+}
+EXPORT_SYMBOL(omap_dss_supported_displays);
+
+enum omap_color_mode omap_dss_supported_color_modes(int id)
+{
+	return omap_dss_features.supported_color_modes[id];
+}
+EXPORT_SYMBOL(omap_dss_supported_color_modes);
+
+/* DSS has_feature check */
+bool omap_dss_has_feature(int id)
+{
+	return omap_dss_features.has_feature[id];
+}
+EXPORT_SYMBOL(omap_dss_has_feature);
+
+void omap_dss_features_init(void)
+{
+	INIT_LIST_HEAD(&reg_field_list);
+	num_reg_fields = 0;
+
+	omap_dss_features.num_mgrs = 2;
+	omap_dss_features.num_ovls = 3;
+
+	omap_dss_features.supported_displays[OMAP_DSS_CHANNEL_LCD] =
+				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+				OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI;
+
+	omap_dss_features.supported_displays[OMAP_DSS_CHANNEL_DIGIT] =
+				OMAP_DISPLAY_TYPE_VENC;
+
+	omap_dss_features.has_feature[GLOBAL_ALPHA_VIDEO1] = false;
+
+	if (cpu_is_omap34xx()) {
+		omap_dss_features.supported_color_modes[OMAP_DSS_GFX] =
+			OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+			OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+			OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+			OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+			OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
+			OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32;
+
+		omap_dss_features.supported_color_modes[OMAP_DSS_VIDEO1] =
+			OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
+			OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
+			OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY;
+
+		omap_dss_features.supported_color_modes[OMAP_DSS_VIDEO2] =
+			OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+			OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+			OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
+			OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
+			OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32;
+
+		omap_dss_features.has_feature[GLOBAL_ALPHA] = true;
+
+		dss_add_reg_field(FIRHINC, 12, 0);
+		dss_add_reg_field(FIRVINC, 28, 16);
+		dss_add_reg_field(FIFOLOWTHRESHOLD, 11, 0);
+		dss_add_reg_field(FIFOHIGHTHRESHOLD, 27, 16);
+		dss_add_reg_field(FIFOSIZE, 10, 0);
+	} else {
+		/* cpu_is_omap24xx() */
+		omap_dss_features.supported_color_modes[OMAP_DSS_GFX] =
+			OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+			OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+			OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
+			OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P;
+
+		omap_dss_features.supported_color_modes[OMAP_DSS_VIDEO1] =
+		omap_dss_features.supported_color_modes[OMAP_DSS_VIDEO2] =
+			OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+			OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
+			OMAP_DSS_COLOR_UYVY;
+
+		omap_dss_features.has_feature[GLOBAL_ALPHA] = false;
+
+		dss_add_reg_field(FIRHINC, 11, 0);
+		dss_add_reg_field(FIRVINC, 12, 0);
+		dss_add_reg_field(FIFOLOWTHRESHOLD, 8, 0);
+		dss_add_reg_field(FIFOHIGHTHRESHOLD, 24, 16);
+		dss_add_reg_field(FIFOSIZE, 8, 0);
+	}
+}
+EXPORT_SYMBOL(omap_dss_features_init);
+
+void omap_dss_features_exit(void)
+{
+	/* We only need to free the register field list for now */
+	struct dss_reg_field *field;
+
+	while (!list_empty(&reg_field_list)) {
+		field = list_first_entry(&reg_field_list,
+				struct dss_reg_field, list);
+		list_del(&field->list);
+		kfree(field);
+	}
+	num_reg_fields = 0;
+}
+EXPORT_SYMBOL(omap_dss_features_exit);
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
new file mode 100644
index 0000000..e16fa07
--- /dev/null
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -0,0 +1,48 @@
+/*
+ * linux/drivers/video/omap2/dss/dss_features.h
+ *
+ * Copyright (C) 2010 Texas Instruments
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
+#ifndef __OMAP2_DSS_FEATURES_H
+#define __OMAP2_DSS_FEATURES_H
+
+#define MAX_DSS_MANAGERS	2
+#define MAX_DSS_OVERLAYS	3
+#define MAX_DSS_FEATURES	10
+
+/* DSS has feature id */
+#define GLOBAL_ALPHA		0
+#define GLOBAL_ALPHA_VIDEO1	1
+
+/* DSS register field id */
+#define FIRHINC		0
+#define FIRVINC		1
+#define FIFOHIGHTHRESHOLD	2
+#define FIFOLOWTHRESHOLD	3
+#define FIFOSIZE		4
+
+/* DSS Feature Functions */
+void omap_dss_get_reg_field(int id, u8 *start, u8 *end);
+int omap_dss_num_mgrs(void);
+int omap_dss_num_ovls(void);
+enum omap_display_type omap_dss_supported_displays(int id);
+enum omap_color_mode omap_dss_supported_color_modes(int id);
+
+bool omap_dss_has_feature(int id);
+void omap_dss_features_init(void);
+void omap_dss_features_exit(void);
+#endif
-- 
1.7.0.4

