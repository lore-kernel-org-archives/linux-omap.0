From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 2/5] OMAPDSS: DT: Get source endpoint by matching reg-id
Date: Mon, 26 May 2014 14:58:09 +0530
Message-ID: <1401096492-1405-2-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
 <1401096492-1405-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56905 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbaEZJ3i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 May 2014 05:29:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4Q9Tchq008475
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:38 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4Q9TcP2014920
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:38 -0500
In-Reply-To: <1401096492-1405-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

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
 drivers/video/fbdev/omap2/dss/dss-of.c             | 51 +++++++++++++++++-----
 drivers/video/fbdev/omap2/dss/output.c             |  8 ++--
 include/video/omapdss.h                            |  7 ++-
 5 files changed, 52 insertions(+), 16 deletions(-)

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
index a4b20aa..8ba43faa 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -132,28 +132,55 @@ EXPORT_SYMBOL_GPL(omapdss_of_get_first_endpoint);
 struct omap_dss_device *
 omapdss_of_find_source_for_first_ep(struct device_node *node)
 {
-	struct device_node *ep;
-	struct device_node *src_node;
+	struct device_node *ep, *port_ep;
+	struct device_node *src_node, *src_port;
 	struct omap_dss_device *src;
+	int r;
+	u32 reg;
 
 	ep = omapdss_of_get_first_endpoint(node);
-	if (!ep)
-		return ERR_PTR(-EINVAL);
+	if (!ep) {
+		r = -EINVAL;
+		goto err_first_ep;
+	}
 
 	src_node = omapdss_of_get_remote_device_node(ep);
+	if (!src_node) {
+		r = -EINVAL;
+		goto err_src_node;
+	}
 
-	of_node_put(ep);
-
-	if (!src_node)
-		return ERR_PTR(-EINVAL);
+	port_ep = of_parse_phandle(ep, "remote-endpoint", 0);
+	if (!port_ep) {
+		r = -EINVAL;
+		goto err_port_ep;
+	}
 
-	src = omap_dss_find_output_by_node(src_node);
+	src_port = of_get_next_parent(port_ep);
+	if (!src_port) {
+		r = -EINVAL;
+		goto err_src_port;
+	}
 
-	of_node_put(src_node);
+	r = of_property_read_u32(src_port, "reg", &reg);
+	if (r) {
+		r = 0;
+		reg = 0;
+	}
 
+	src = omap_dss_find_output_by_node_and_reg(src_node, reg);
 	if (!src)
-		return ERR_PTR(-EPROBE_DEFER);
+		r = -EPROBE_DEFER;
+
+	of_node_put(src_port);
 
-	return src;
+err_src_port:
+	of_node_put(port_ep);
+err_port_ep:
+	of_node_put(src_node);
+err_src_node:
+	of_node_put(ep);
+err_first_ep:
+	return r ? ERR_PTR(r) : src;
 }
 EXPORT_SYMBOL_GPL(omapdss_of_find_source_for_first_ep);
diff --git a/drivers/video/fbdev/omap2/dss/output.c b/drivers/video/fbdev/omap2/dss/output.c
index 2ab3afa..1a8d6c7 100644
--- a/drivers/video/fbdev/omap2/dss/output.c
+++ b/drivers/video/fbdev/omap2/dss/output.c
@@ -131,18 +131,20 @@ struct omap_dss_device *omap_dss_find_output(const char *name)
 }
 EXPORT_SYMBOL(omap_dss_find_output);
 
-struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node)
+struct omap_dss_device
+		*omap_dss_find_output_by_node_and_reg(struct device_node *node,
+		u32 reg)
 {
 	struct omap_dss_device *out;
 
 	list_for_each_entry(out, &output_list, list) {
-		if (out->dev->of_node == node)
+		if (out->dev->of_node == node && out->port_num == reg)
 			return omap_dss_get_device(out);
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL(omap_dss_find_output_by_node);
+EXPORT_SYMBOL(omap_dss_find_output_by_node_and_reg);
 
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index fc06c5b..6c49771 100644
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
 
@@ -909,7 +912,9 @@ int omapdss_register_output(struct omap_dss_device *output);
 void omapdss_unregister_output(struct omap_dss_device *output);
 struct omap_dss_device *omap_dss_get_output(enum omap_dss_output_id id);
 struct omap_dss_device *omap_dss_find_output(const char *name);
-struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node);
+struct omap_dss_device
+		*omap_dss_find_output_by_node_and_reg(struct device_node *node,
+		u32 reg);
 int omapdss_output_set_device(struct omap_dss_device *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_device *out);
-- 
1.8.3.2

