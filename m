From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/23] OMAPDSS: outputs: Create a new entity called outputs
Date: Tue, 21 Aug 2012 11:28:08 +0530
Message-ID: <1345528711-27801-2-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab2HUGAN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:13 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

The current OMAPDSS design contains 3 software entities: Overlays, Managers and
Devices. These map to pipelines, overlay managers and the panels respectively in
hardware. One or more overlays connect to a manager to represent a composition,
the manager connects to a device(generally a display) to display the content.

The part of DSS hardware which isn't represented by any of the above entities
are interfaces/outputs that connect to an overlay manager, i.e blocks like DSI,
HDMI, VENC and so on. Currently, an overlay manager directly connects to the
display, and the output to which it is actually connected is ignored. The panel
driver of the display is responsible of calling output specific functions to
configure the output.

Adding outputs as a new software entity gives us the following benefits:

- Have exact information on the possible connections between managers and
  outputs: A manager can't connect to each and every output, there only limited
  hardware links between a manager's video port and some of the outputs.

- Remove hacks related to connecting managers and devices: Currently, default
  links between managers and devices are set in a not so clean way. Matching is
  done via comparing the device type, and the display types supported by the
  manager. This isn't sufficient to establish all the possible links between
  managers, outputs and devices in hardware.

- Make panel drivers more generic: The DSS panel drivers currently call
  interface/output specific functions to configure the hardware IP. When making
  these calls, the driver isn't actually aware of the underlying output. The
  output driver extracts information from the panel's omap_dss_device pointer
  to figure out which interface it is connected to, and then configures the
  corresponding output block. An example of this is when a DSI panel calls
  dsi functions, the dsi driver figures out whether the panel is connected
  to DSI1 or DSI2. This isn't correct, and having output as entities will
  give the panel driver the exact information on which output to configure.
  Having outputs also gives the opportunity to make panel drivers generic
  across different platforms/SoCs, this is achieved as omap specific output
  calls can be replaced by ops of a particular output type.

- Have more complex connections between managers, outputs and devices: OMAPDSS
  currently doesn't support use cases like 2 outputs connect to a single
  device. This can be achieved by extending properties of outputs to connect to
  more managers or devices.

- Represent writeback as an output: The writeback pipeline fits well in OMAPDSS
  as compared to overlays, managers or devices.

Add a new struct to represent outputs. An output struct holds pointers to the
manager and device structs to which it is connected. Add functions which can
add an output, or look for one. Create an enum which represent each output
instance.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Makefile |    2 +-
 drivers/video/omap2/dss/core.c   |    1 +
 drivers/video/omap2/dss/dss.h    |    4 +++
 drivers/video/omap2/dss/output.c |   58 ++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h          |   30 ++++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/omap2/dss/output.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 30a48fb..645f8c3 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o overlay.o apply.o
+	manager.o overlay.o output.o apply.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index c35a248..2eccd74 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -239,6 +239,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
+	dss_init_outputs();
 
 	r = dss_initialize_debugfs();
 	if (r)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 41c00dc..8a7c94c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -222,6 +222,10 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr);
 int dss_ovl_unset_manager(struct omap_overlay *ovl);
 
+/* output */
+struct omap_dss_output *dss_create_output(struct platform_device *pdev);
+void dss_init_outputs(void);
+
 /* display */
 int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
new file mode 100644
index 0000000..034ebbe
--- /dev/null
+++ b/drivers/video/omap2/dss/output.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Ltd
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
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+
+static struct list_head output_list;
+
+struct omap_dss_output *dss_create_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = kzalloc(sizeof(struct omap_dss_output *), GFP_KERNEL);
+	if (!out)
+		return NULL;
+
+	out->pdev = pdev;
+
+	list_add_tail(&out->list, &output_list);
+
+	return out;
+}
+
+struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
+{
+	struct omap_dss_output *out;
+
+	list_for_each_entry(out, &output_list, list) {
+		if (out->id == id)
+			return out;
+	}
+
+	return NULL;
+}
+
+void dss_init_outputs(void)
+{
+	INIT_LIST_HEAD(&output_list);
+}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b868123..0ba613f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -207,6 +207,16 @@ enum omap_hdmi_flags {
 	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP = 1 << 0,
 };
 
+enum omap_dss_output_id {
+	OMAP_DSS_OUTPUT_DPI	= 1 << 0,
+	OMAP_DSS_OUTPUT_DBI	= 1 << 1,
+	OMAP_DSS_OUTPUT_SDI	= 1 << 2,
+	OMAP_DSS_OUTPUT_DSI1	= 1 << 3,
+	OMAP_DSS_OUTPUT_VENC	= 1 << 4,
+	OMAP_DSS_OUTPUT_DSI2	= 1 << 5,
+	OMAP_DSS_OUTPUT_HDMI	= 1 << 6,
+};
+
 /* RFBI */
 
 struct rfbi_timings {
@@ -492,6 +502,24 @@ struct omap_dsi_pin_config {
 	int pins[OMAP_DSS_MAX_DSI_PINS];
 };
 
+struct omap_dss_output {
+	struct list_head list;
+
+	/* display type supported by the output */
+	enum omap_display_type type;
+
+	/* output instance */
+	enum omap_dss_output_id id;
+
+	/* output's platform device pointer */
+	struct platform_device *pdev;
+
+	/* dynamic fields */
+	struct omap_overlay_manager *manager;
+
+	struct omap_dss_device *device;
+};
+
 struct omap_dss_device {
 	struct device dev;
 
@@ -699,6 +727,8 @@ struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
 int omap_dss_get_num_overlays(void);
 struct omap_overlay *omap_dss_get_overlay(int num);
 
+struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id);
+
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres);
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev);
-- 
1.7.9.5

