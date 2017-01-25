From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 2/7] ACPI / property: have acpi_get_next_subnode take fwnode_handle
Date: Tue, 24 Jan 2017 16:06:36 -0800
Message-ID: <20170125000641.25520-3-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>, Furquan Shaikh <furquan@>
List-Id: linux-omap@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

In preparation to introducing fwnode_for_each_chil() iterator we need
acpi_get_next_subnode take fwnode_handle argument instead of dev.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/acpi/property.c | 8 +++++---
 drivers/base/property.c | 2 +-
 include/linux/acpi.h    | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3afddcd834ef..b87e822e3a51 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -866,15 +866,17 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
 
 /**
  * acpi_get_next_subnode - Return the next child node handle for a device.
- * @dev: Device to find the next child node for.
+ * @node: node to find the next child node for. Must be ACPI device node,
+ *	not data node.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *node,
 					    struct fwnode_handle *child)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev;
 	struct list_head *head, *next;
 
+	adev = to_acpi_device_node(node);
 	if (!adev)
 		return NULL;
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 43a36d68c3fd..f2f8220534c4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -881,7 +881,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 		if (node)
 			return &node->fwnode;
 	} else if (IS_ENABLED(CONFIG_ACPI)) {
-		return acpi_get_next_subnode(dev, child);
+		return acpi_get_next_subnode(dev->fwnode, child);
 	}
 	return NULL;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5b36974ed60a..0331a9dbe4f2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -999,7 +999,7 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode, const char *propname,
 int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *node,
 					    struct fwnode_handle *subnode);
 
 struct acpi_probe_entry;
@@ -1117,7 +1117,8 @@ static inline int acpi_dev_prop_read(struct acpi_device *adev,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+static inline struct fwnode_handle *acpi_get_next_subnode(
+						struct fwnode_handle *node,
 						struct fwnode_handle *subnode)
 {
 	return NULL;
-- 
2.11.0.483.g087da7b7c-goog

