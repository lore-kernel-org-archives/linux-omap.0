From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 1/2] OMAP: DSS2: Introduce dss_features files
Date: Mon, 13 Sep 2010 11:00:09 +0530
Message-ID: <1284355810-20899-2-git-send-email-archit@ti.com>
References: <1284355810-20899-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56649 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0IMF2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 01:28:53 -0400
In-Reply-To: <1284355810-20899-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add dss_features.c and dss_features.h for the dss_features framework

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Makefile       |    2 +-
 drivers/video/omap2/dss/dss_features.c |  191 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |   50 ++++++++
 3 files changed, 242 insertions(+), 1 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dss_features.c
 create mode 100644 drivers/video/omap2/dss/dss_features.h

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index d71b5d9..7db17b5
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
-omapdss-y := core.o dss.o dispc.o display.o manager.o overlay.o
+omapdss-y := core.o dss.o dss_features.o dispc.o display.o manager.o overlay.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
new file mode 100644
index 0000000..c3e4d4d
--- /dev/null
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -0,0 +1,191 @@
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
+/* Defines a generic omap register field */
+struct dss_reg_field {
+	enum dss_feat_reg_field id;
+	u8 start, end;
+};
+
+struct omap_dss_features {
+	struct dss_reg_field *reg_fields;
+	int num_reg_fields;
+
+	u32 has_feature;
+
+	int num_mgrs;
+	int num_ovls;
+	enum omap_display_type *supported_displays;
+	enum omap_color_mode *supported_color_modes;
+};
+
+/* This struct is assigned to one of the below during initialization */
+static struct omap_dss_features omap_current_dss_features;
+
+static struct dss_reg_field omap2_dss_reg_fields[] = {
+	{ FEAT_REG_FIRHINC, 11, 0 },
+	{ FEAT_REG_FIRVINC, 27, 16 },
+	{ FEAT_REG_FIFOLOWTHRESHOLD, 8, 0 },
+	{ FEAT_REG_FIFOHIGHTHRESHOLD, 24, 16 },
+	{ FEAT_REG_FIFOSIZE, 8, 0 },
+};
+
+static struct dss_reg_field omap3_dss_reg_fields[] = {
+	{ FEAT_REG_FIRHINC, 12, 0 },
+	{ FEAT_REG_FIRVINC, 28, 16 },
+	{ FEAT_REG_FIFOLOWTHRESHOLD, 11, 0 },
+	{ FEAT_REG_FIFOHIGHTHRESHOLD, 27, 16 },
+	{ FEAT_REG_FIFOSIZE, 10, 0 },
+};
+
+static enum omap_display_type omap2_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DISPLAY_TYPE_VENC,
+};
+
+static enum omap_display_type omap3_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DISPLAY_TYPE_VENC,
+};
+
+static enum omap_color_mode omap2_dss_supported_color_modes[] = {
+	/* OMAP_DSS_GFX */
+	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+	OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
+	OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
+	OMAP_DSS_COLOR_UYVY,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
+	OMAP_DSS_COLOR_UYVY,
+};
+
+static enum omap_color_mode omap3_dss_supported_color_modes[] = {
+	/* OMAP_DSS_GFX */
+	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+	OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
+	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
+	OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
+};
+
+/* OMAP2 DSS Features */
+static struct omap_dss_features omap2_dss_features = {
+	.reg_fields = omap2_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
+
+	.num_mgrs = 2,
+	.num_ovls = 3,
+	.supported_displays = omap2_dss_supported_displays,
+	.supported_color_modes = omap2_dss_supported_color_modes,
+};
+
+/* OMAP3 DSS Features */
+static struct omap_dss_features omap3_dss_features = {
+	.reg_fields = omap3_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.has_feature	= FEAT_GLOBAL_ALPHA,
+
+	.num_mgrs = 2,
+	.num_ovls = 3,
+	.supported_displays = omap3_dss_supported_displays,
+	.supported_color_modes = omap3_dss_supported_color_modes,
+};
+
+/* Functions returning values related to a DSS feature */
+int dss_feat_get_num_mgrs(void)
+{
+	return omap_current_dss_features.num_mgrs;
+}
+
+int dss_feat_get_num_ovls(void)
+{
+	return omap_current_dss_features.num_ovls;
+}
+
+enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel)
+{
+	return omap_current_dss_features.supported_displays[channel];
+}
+
+enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
+{
+	return omap_current_dss_features.supported_color_modes[plane];
+}
+
+/* DSS has_feature check */
+bool dss_has_feature(enum dss_feat_id id)
+{
+	return omap_current_dss_features.has_feature & id;
+}
+
+void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
+{
+	if (id >= omap_current_dss_features.num_reg_fields)
+		BUG();
+
+	*start = omap_current_dss_features.reg_fields[id].start;
+	*end = omap_current_dss_features.reg_fields[id].end;
+}
+
+void dss_features_init(void)
+{
+	if (cpu_is_omap24xx())
+		omap_current_dss_features = omap2_dss_features;
+	else
+		omap_current_dss_features = omap3_dss_features;
+}
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
new file mode 100644
index 0000000..cb231ea
--- /dev/null
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -0,0 +1,50 @@
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
+
+/* DSS has feature id */
+enum dss_feat_id {
+	FEAT_GLOBAL_ALPHA	= 1 << 0,
+	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
+};
+
+/* DSS register field id */
+enum dss_feat_reg_field {
+	FEAT_REG_FIRHINC,
+	FEAT_REG_FIRVINC,
+	FEAT_REG_FIFOHIGHTHRESHOLD,
+	FEAT_REG_FIFOLOWTHRESHOLD,
+	FEAT_REG_FIFOSIZE,
+};
+
+/* DSS Feature Functions */
+int dss_feat_get_num_mgrs(void);
+int dss_feat_get_num_ovls(void);
+enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
+enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
+
+bool dss_has_feature(enum dss_feat_id id);
+void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
+void dss_features_init(void);
+#endif
-- 
1.7.0.4

