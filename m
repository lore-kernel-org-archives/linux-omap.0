From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 3/7] device property: introduce fwnode_for_each_child()
Date: Tue, 24 Jan 2017 16:06:37 -0800
Message-ID: <20170125000641.25520-4-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>, Furquan Shaikh <furquan@>
List-Id: linux-omap@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

Generic code, that wishes to work with ACPI, device tree, and pset
properties needs iterator that can work with fwnode_handle.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/base/property.c | 33 +++++++++++++++++++++++----------
 include/linux/fwnode.h  |  7 +++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f2f8220534c4..fbb05a4a7595 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -867,6 +867,28 @@ int device_add_properties(struct device *dev, struct property_entry *properties)
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_next_child_node - Return the next child node handle for a device
+ * @node: Node to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ */
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *node,
+						 struct fwnode_handle *child)
+{
+	if (IS_ENABLED(CONFIG_OF) && is_of_node(node)) {
+		struct device_node *np;
+
+		np = of_get_next_available_child(to_of_node(node),
+						   to_of_node(child));
+		if (np)
+			return &np->fwnode;
+	} else if (IS_ENABLED(CONFIG_ACPI) && is_acpi_node(node)) {
+		return acpi_get_next_subnode(node, child);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
+
+/**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
@@ -874,16 +896,7 @@ EXPORT_SYMBOL_GPL(device_add_properties);
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child)
 {
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-		struct device_node *node;
-
-		node = of_get_next_available_child(dev->of_node, to_of_node(child));
-		if (node)
-			return &node->fwnode;
-	} else if (IS_ENABLED(CONFIG_ACPI)) {
-		return acpi_get_next_subnode(dev->fwnode, child);
-	}
-	return NULL;
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8bd28ce6d76e..b4efe2a088ae 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -27,4 +27,11 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 };
 
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *node,
+						 struct fwnode_handle *child);
+
+#define fwnode_for_each_child_node(node, child) \
+	for (child = fwnode_get_next_child_node(node, NULL); child; \
+	     child = fwnode_get_next_child_node(node, child))
+
 #endif
-- 
2.11.0.483.g087da7b7c-goog

