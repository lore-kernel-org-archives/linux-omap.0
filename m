From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 5/7] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Wed, 4 Jun 2014 12:11:01 +0530
Message-ID: <1401864063-19196-6-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49258 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbaFDGmi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 02:42:38 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
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

To get the correct output for ports within DSS(and in other cases in the future,
where multiple ports might be under one device), we require additional
information which is exclusive to the output port.

We create a new field in omap_dss_device called 'port_num', this provides port
number of the output port corresponding to this device. When searching for the
source endpoint in DT, we extract the 'reg' property from the port corresponding
to the endpoint source. From the list of registered outputs, we pick out that
output which has both dev->of_node and port_num matching with the device_node
pointer and 'reg' of the source endpoint node from DT.

For encoder blocks(the ones which have both an input and output port), we need
to set the port_num as the 'reg' property for the output port as defined in the
DT bindings. We set port_num to 1 in the tfp410 and tpd12s015 encoder drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../fbdev/omap2/displays-new/encoder-tfp410.c      |  1 +
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  1 +
 drivers/video/fbdev/omap2/dss/dss-of.c             | 58 +++++++++++++++-------
 drivers/video/fbdev/omap2/dss/dss.h                |  4 ++
 drivers/video/fbdev/omap2/dss/output.c             | 19 +++++--
 include/video/omapdss.h                            |  5 +-
 6 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
index b4e9a42..d927455 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
@@ -249,6 +249,7 @@ static int tfp410_probe(struct platform_device *pdev)
 	dssdev->output_type = OMAP_DISPLAY_TYPE_DVI;
 	dssdev->owner = THIS_MODULE;
 	dssdev->phy.dpi.data_lines = ddata->data_lines;
+	dssdev->port_num = 1;
 
 	r = omapdss_register_output(dssdev);
 	if (r) {
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index 7e33686..9e25fe7 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -389,6 +389,7 @@ static int tpd_probe(struct platform_device *pdev)
 	dssdev->type = OMAP_DISPLAY_TYPE_HDMI;
 	dssdev->output_type = OMAP_DISPLAY_TYPE_HDMI;
 	dssdev->owner = THIS_MODULE;
+	dssdev->port_num = 1;
 
 	in = ddata->in;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbdev/omap2/dss/dss-of.c
index a4b20aa..928ee63 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -20,6 +20,8 @@
 
 #include <video/omapdss.h>
 
+#include "dss.h"
+
 struct device_node *
 omapdss_of_get_next_port(const struct device_node *parent,
 			 struct device_node *prev)
@@ -84,20 +86,17 @@ omapdss_of_get_next_endpoint(const struct device_node *parent,
 }
 EXPORT_SYMBOL_GPL(omapdss_of_get_next_endpoint);
 
-static struct device_node *
-omapdss_of_get_remote_device_node(const struct device_node *node)
+struct device_node *dss_of_port_get_parent_device(struct device_node *port)
 {
 	struct device_node *np;
 	int i;
 
-	np = of_parse_phandle(node, "remote-endpoint", 0);
-
-	if (!np)
+	if (!port)
 		return NULL;
 
-	np = of_get_next_parent(np);
+	np = of_get_next_parent(port);
 
-	for (i = 0; i < 3 && np; ++i) {
+	for (i = 0; i < 2 && np; ++i) {
 		struct property *prop;
 
 		prop = of_find_property(np, "compatible", NULL);
@@ -111,6 +110,31 @@ omapdss_of_get_remote_device_node(const struct device_node *node)
 	return NULL;
 }
 
+u32 dss_of_port_get_port_number(struct device_node *port)
+{
+	int r;
+	u32 reg;
+
+	r = of_property_read_u32(port, "reg", &reg);
+	if (r)
+		reg = 0;
+
+	return reg;
+}
+
+static struct device_node *omapdss_of_get_remote_port(const struct device_node *node)
+{
+	struct device_node *np;
+
+	np = of_parse_phandle(node, "remote-endpoint", 0);
+	if (!np)
+		return NULL;
+
+	np = of_get_next_parent(np);
+
+	return np;
+}
+
 struct device_node *
 omapdss_of_get_first_endpoint(const struct device_node *parent)
 {
@@ -133,27 +157,25 @@ struct omap_dss_device *
 omapdss_of_find_source_for_first_ep(struct device_node *node)
 {
 	struct device_node *ep;
-	struct device_node *src_node;
+	struct device_node *src_port;
 	struct omap_dss_device *src;
 
 	ep = omapdss_of_get_first_endpoint(node);
 	if (!ep)
 		return ERR_PTR(-EINVAL);
 
-	src_node = omapdss_of_get_remote_device_node(ep);
-
-	of_node_put(ep);
-
-	if (!src_node)
+	src_port = omapdss_of_get_remote_port(ep);
+	if (!src_port) {
+		of_node_put(ep);
 		return ERR_PTR(-EINVAL);
+	}
 
-	src = omap_dss_find_output_by_node(src_node);
+	of_node_put(ep);
 
-	of_node_put(src_node);
+	src = omap_dss_find_output_by_port_node(src_port);
 
-	if (!src)
-		return ERR_PTR(-EPROBE_DEFER);
+	of_node_put(src_port);
 
-	return src;
+	return src ? src : ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL_GPL(omapdss_of_find_source_for_first_ep);
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index f0d3e82..849ede1 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -215,6 +215,10 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
+/* dss-of */
+struct device_node *dss_of_port_get_parent_device(struct device_node *port);
+u32 dss_of_port_get_port_number(struct device_node *port);
+
 #if defined(CONFIG_OMAP2_DSS_DEBUGFS)
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/output.c b/drivers/video/fbdev/omap2/dss/output.c
index 2ab3afa..1607215 100644
--- a/drivers/video/fbdev/omap2/dss/output.c
+++ b/drivers/video/fbdev/omap2/dss/output.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -131,18 +132,30 @@ struct omap_dss_device *omap_dss_find_output(const char *name)
 }
 EXPORT_SYMBOL(omap_dss_find_output);
 
-struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node)
+struct omap_dss_device *omap_dss_find_output_by_port_node(struct device_node *port)
 {
+	struct device_node *src_node;
 	struct omap_dss_device *out;
+	u32 reg;
+
+	src_node = dss_of_port_get_parent_device(port);
+	if (!src_node)
+		return NULL;
+
+	reg = dss_of_port_get_port_number(port);
 
 	list_for_each_entry(out, &output_list, list) {
-		if (out->dev->of_node == node)
+		if (out->dev->of_node == src_node && out->port_num == reg) {
+			of_node_put(src_node);
 			return omap_dss_get_device(out);
+		}
 	}
 
+	of_node_put(src_node);
+
 	return NULL;
 }
-EXPORT_SYMBOL(omap_dss_find_output_by_node);
+EXPORT_SYMBOL(omap_dss_find_output_by_port_node);
 
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index fc06c5b..ec0dc29 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -790,6 +790,9 @@ struct omap_dss_device {
 	/* output instance */
 	enum omap_dss_output_id id;
 
+	/* the port number in the DT node */
+	int port_num;
+
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
@@ -909,7 +912,7 @@ int omapdss_register_output(struct omap_dss_device *output);
 void omapdss_unregister_output(struct omap_dss_device *output);
 struct omap_dss_device *omap_dss_get_output(enum omap_dss_output_id id);
 struct omap_dss_device *omap_dss_find_output(const char *name);
-struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node);
+struct omap_dss_device *omap_dss_find_output_by_port_node(struct device_node *port);
 int omapdss_output_set_device(struct omap_dss_device *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_device *out);
-- 
1.8.3.2

