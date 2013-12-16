From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 08/27] OMAPDSS: add of helpers
Date: Mon, 16 Dec 2013 16:56:15 +0200
Message-ID: <1387205794-32246-9-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3LPO6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 09:58:11 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add helpers to get ports and endpoints from DT data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile |   2 +-
 drivers/video/omap2/dss/dss-of.c | 162 +++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h          |  14 ++++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/omap2/dss/dss-of.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index d3aa91bdd6a8..8aec8bda27cc 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 # Core DSS files
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	output.o
+	output.o dss-of.o
 # DSS compat layer files
 omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
 	dispc-compat.o display-sysfs.o
diff --git a/drivers/video/omap2/dss/dss-of.c b/drivers/video/omap2/dss/dss-of.c
new file mode 100644
index 000000000000..59213cf2ffa2
--- /dev/null
+++ b/drivers/video/omap2/dss/dss-of.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2013 Texas Instruments
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
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/seq_file.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+
+struct device_node *
+omapdss_of_get_next_port(const struct device_node *parent,
+			 struct device_node *prev)
+{
+	struct device_node *port = NULL;
+
+	if (!parent)
+		return NULL;
+
+	if (!prev) {
+		struct device_node *ports;
+		/*
+		 * It's the first call, we have to find a port subnode
+		 * within this node or within an optional 'ports' node.
+		 */
+		ports = of_get_child_by_name(parent, "ports");
+		if (ports)
+			parent = ports;
+
+		port = of_get_child_by_name(parent, "port");
+
+		/* release the 'ports' node */
+		of_node_put(ports);
+	} else {
+		struct device_node *ports;
+
+		ports = of_get_parent(prev);
+		if (!ports)
+			return NULL;
+
+		do {
+			port = of_get_next_child(ports, prev);
+			if (!port) {
+				of_node_put(ports);
+				return NULL;
+			}
+			prev = port;
+		} while (of_node_cmp(port->name, "port") != 0);
+	}
+
+	return port;
+}
+EXPORT_SYMBOL_GPL(omapdss_of_get_next_port);
+
+struct device_node *
+omapdss_of_get_next_endpoint(const struct device_node *parent,
+			     struct device_node *prev)
+{
+	struct device_node *ep = NULL;
+
+	if (!parent)
+		return NULL;
+
+	do {
+		ep = of_get_next_child(parent, prev);
+		if (!ep)
+			return NULL;
+		prev = ep;
+	} while (of_node_cmp(ep->name, "endpoint") != 0);
+
+	return ep;
+}
+EXPORT_SYMBOL_GPL(omapdss_of_get_next_endpoint);
+
+static struct device_node *
+omapdss_of_get_remote_device_node(const struct device_node *node)
+{
+	struct device_node *np;
+	int i;
+
+	np = of_parse_phandle(node, "remote-endpoint", 0);
+
+	if (!np)
+		return NULL;
+
+	np = of_get_next_parent(np);
+
+	for (i = 0; i < 3 && np; ++i) {
+		struct property *prop;
+
+		prop = of_find_property(np, "compatible", NULL);
+
+		if (prop)
+			return np;
+
+		np = of_get_next_parent(np);
+	}
+
+	return NULL;
+}
+
+struct device_node *
+omapdss_of_get_first_endpoint(const struct device_node *parent)
+{
+	struct device_node *port;
+	struct device_node *ep;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (port) {
+		ep = omapdss_of_get_next_endpoint(port, NULL);
+		of_node_put(port);
+	} else {
+		ep = omapdss_of_get_next_endpoint(parent, NULL);
+	}
+
+	return ep;
+}
+EXPORT_SYMBOL_GPL(omapdss_of_get_first_endpoint);
+
+struct omap_dss_device *
+omapdss_of_find_source_for_first_ep(struct device_node *node)
+{
+	struct device_node *ep;
+	struct device_node *src_node;
+	struct omap_dss_device *src;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return ERR_PTR(-EINVAL);
+
+	src_node = omapdss_of_get_remote_device_node(ep);
+
+	of_node_put(ep);
+
+	if (!src_node)
+		return ERR_PTR(-EINVAL);
+
+	src = omap_dss_find_output_by_node(src_node);
+
+	of_node_put(src_node);
+
+	if (!src)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return src;
+}
+EXPORT_SYMBOL_GPL(omapdss_of_find_source_for_first_ep);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3d7c51a6f9ff..e3cd2a921c2f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -1019,4 +1019,18 @@ static inline bool omapdss_device_is_enabled(struct omap_dss_device *dssdev)
 	return dssdev->state == OMAP_DSS_DISPLAY_ACTIVE;
 }
 
+struct device_node *
+omapdss_of_get_next_port(const struct device_node *parent,
+			 struct device_node *prev);
+
+struct device_node *
+omapdss_of_get_next_endpoint(const struct device_node *parent,
+			     struct device_node *prev);
+
+struct device_node *
+omapdss_of_get_first_endpoint(const struct device_node *parent);
+
+struct omap_dss_device *
+omapdss_of_find_source_for_first_ep(struct device_node *node);
+
 #endif
-- 
1.8.3.2

