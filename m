From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 4/7] device property: introduce fwnode_get_named_child_node()
Date: Tue, 24 Jan 2017 16:06:38 -0800
Message-ID: <20170125000641.25520-5-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>, Furquan Shaikh <furquan@>
List-Id: linux-omap@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

Generic code that works with ACPI, device tree, and pset properties may
want to fetch named child node of fwnode_handle.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/base/property.c | 45 +++++++++++++++++++++++++++++----------------
 include/linux/fwnode.h  |  3 +++
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index fbb05a4a7595..3556c9fbdbf7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -889,23 +889,11 @@ struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *node,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
- * @dev: Device to find the next child node for.
- * @child: Handle to one of the device's child nodes or a null handle.
- */
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
-						 struct fwnode_handle *child)
-{
-	return fwnode_get_next_child_node(dev_fwnode(dev), child);
-}
-EXPORT_SYMBOL_GPL(device_get_next_child_node);
-
-/**
- * device_get_named_child_node - Return first matching named child node handle
- * @dev: Device to find the named child node for.
+ * fwnode_get_named_child_node - Return first matching named child node handle
+ * @node: Node to find the named child node for.
  * @childname: String to match child node name against.
  */
-struct fwnode_handle *device_get_named_child_node(struct device *dev,
+struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *node,
 						  const char *childname)
 {
 	struct fwnode_handle *child;
@@ -914,7 +902,7 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 	 * Find first matching named child node of this device.
 	 * For ACPI this will be a data only sub-node.
 	 */
-	device_for_each_child_node(dev, child) {
+	fwnode_for_each_child_node(node, child) {
 		if (is_of_node(child)) {
 			if (!of_node_cmp(to_of_node(child)->name, childname))
 				return child;
@@ -926,6 +914,31 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
+
+
+/**
+ * device_get_next_child_node - Return the next child node handle for a device
+ * @dev: Device to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ */
+struct fwnode_handle *device_get_next_child_node(struct device *dev,
+						 struct fwnode_handle *child)
+{
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
+}
+EXPORT_SYMBOL_GPL(device_get_next_child_node);
+
+/**
+ * device_get_named_child_node - Return first matching named child node handle
+ * @dev: Device to find the named child node for.
+ * @childname: String to match child node name against.
+ */
+struct fwnode_handle *device_get_named_child_node(struct device *dev,
+						  const char *childname)
+{
+	return fwnode_get_named_child_node(dev_fwnode(dev), childname);
+}
 EXPORT_SYMBOL_GPL(device_get_named_child_node);
 
 /**
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index b4efe2a088ae..d501e0b967bd 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -34,4 +34,7 @@ struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *node,
 	for (child = fwnode_get_next_child_node(node, NULL); child; \
 	     child = fwnode_get_next_child_node(node, child))
 
+struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *node,
+						  const char *childname);
+
 #endif
-- 
2.11.0.483.g087da7b7c-goog
