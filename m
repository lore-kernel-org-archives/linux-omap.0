From: Archit Taneja <archit@ti.com>
Subject: [RFC 3/6] omapdss: DT: Get source endpoint by matching reg-id
Date: Thu, 8 May 2014 14:45:14 +0530
Message-ID: <1399540517-17883-3-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44870 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaEHJQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 05:16:31 -0400
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In omapdss_of_find_source_for_first_ep, we retrieve a source endpoint's DT node,
and then see what omapdss output has the matching device_node pointer in
omap_dss_find_output_by_node.

For all DPI and SDI outputs, the device_node pointer is set as the parent's DSS
device_node pointer. If the source is one of these outputs, the above method
won't work.

To get the correct output for ports within DSS with the existing omapdss DT
framework, we check in omapdss_of_find_source_for_first_ep, whether the source
node is of the DSS parent device. If so, we take an extra step of extracting
the 'reg' property from the port corresponding to the endpoint source, and get
the omap_dss_device output by matching both device_node and reg-id.

We would want to get rid of this eventually, and support multiple ports in
general. That would involve making some more changes the omapdss DT
framework.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss-of.c | 41 ++++++++++++++++++++++++++++++----
 drivers/video/fbdev/omap2/dss/dss.c    |  6 +++++
 drivers/video/fbdev/omap2/dss/dss.h    |  2 ++
 drivers/video/fbdev/omap2/dss/output.c | 15 +++++++++++++
 include/video/omapdss.h                |  6 +++++
 5 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbdev/omap2/dss/dss-of.c
index a4b20aa..4261c14 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 
 #include <video/omapdss.h>
+#include "dss.h"
 
 struct device_node *
 omapdss_of_get_next_port(const struct device_node *parent,
@@ -142,12 +143,44 @@ omapdss_of_find_source_for_first_ep(struct device_node *node)
 
 	src_node = omapdss_of_get_remote_device_node(ep);
 
-	of_node_put(ep);
-
-	if (!src_node)
+	if (!src_node) {
+		of_node_put(ep);
 		return ERR_PTR(-EINVAL);
+	}
 
-	src = omap_dss_find_output_by_node(src_node);
+	/*
+	 * TODO: Find a better solution for this.
+	 *
+	 * DPI and SDI outputs share the same DSS device node. In order to find
+	 * the correct omap_dss_device output, we need to match the reg-id
+	 * property of the DPI/SDI port.
+	 *
+	 * For the special case of device_node being the parent DSS device, make
+	 * sure we check for both device_node and reg-id to get the correct
+	 * source
+	 */
+	if (src_node == dss_device_node()) {
+		struct device_node *src_port;
+		u32 reg;
+		int r;
+
+		src_port = of_parse_phandle(ep, "remote-endpoint", 0);
+
+		/* the parent of the endpoint is always the port node */
+		src_port = of_get_next_parent(src_port);
+
+		r = of_property_read_u32(src_port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+		of_node_put(src_port);
+
+		src = omap_dss_find_output_by_node_and_reg(src_node, reg);
+	} else {
+		src = omap_dss_find_output_by_node(src_node);
+	}
+
+	of_node_put(ep);
 
 	of_node_put(src_node);
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index c415029..4087f3b 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -790,6 +790,12 @@ static int __init dss_init_features(struct platform_device *pdev)
 	return 0;
 }
 
+/* of_node pointer for the DSS parent node */
+struct device_node *dss_device_node(void)
+{
+	return dss.pdev->dev.of_node;
+}
+
 static int __init dss_init_ports_omap34xx(struct platform_device *pdev)
 {
 	struct device_node *parent = pdev->dev.of_node;
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 9f4ee49..6f68f72 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -240,6 +240,8 @@ typedef bool (*dss_div_calc_func)(unsigned long fck, void *data);
 bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 		dss_div_calc_func func, void *data);
 
+struct device_node *dss_device_node(void);
+
 /* SDI */
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
diff --git a/drivers/video/fbdev/omap2/dss/output.c b/drivers/video/fbdev/omap2/dss/output.c
index 2ab3afa..2b556f1 100644
--- a/drivers/video/fbdev/omap2/dss/output.c
+++ b/drivers/video/fbdev/omap2/dss/output.c
@@ -144,6 +144,21 @@ struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node)
 }
 EXPORT_SYMBOL(omap_dss_find_output_by_node);
 
+struct omap_dss_device
+		*omap_dss_find_output_by_node_and_reg(struct device_node *node,
+		u32 reg)
+{
+	struct omap_dss_device *out;
+
+	list_for_each_entry(out, &output_list, list) {
+		if (out->dev->of_node == node && out->reg == reg)
+			return omap_dss_get_device(out);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_find_output_by_node_and_reg);
+
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
 	while (dssdev->src)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6adb445..7ce2d83 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -789,6 +789,9 @@ struct omap_dss_device {
 	/* output instance */
 	enum omap_dss_output_id id;
 
+	/* the <reg> value in the DT node */
+	int reg;
+
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
@@ -909,6 +912,9 @@ void omapdss_unregister_output(struct omap_dss_device *output);
 struct omap_dss_device *omap_dss_get_output(enum omap_dss_output_id id);
 struct omap_dss_device *omap_dss_find_output(const char *name);
 struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node);
+struct omap_dss_device
+		*omap_dss_find_output_by_node_and_reg(struct device_node *node,
+		u32 reg);
 int omapdss_output_set_device(struct omap_dss_device *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_device *out);
-- 
1.8.3.2

