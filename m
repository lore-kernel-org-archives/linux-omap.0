From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Wed, 17 Jun 2015 13:46:02 -0500
Message-ID: <1434566762-40702-1-git-send-email-d-gerlach@ti.com>
References: <1432327530-48032-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbFQSqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 14:46:47 -0400
In-Reply-To: <1432327530-48032-2-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

Allow users of remoteproc the ability to get a handle to an rproc by
passing a phandle supplied in the user's device tree node. This is
useful in situations that require manual booting of the rproc.

This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
remove the get_by_name/put API") for the ref counting but is modified
to use a simple list and locking mechanism and has rproc_get_by_name
replaced with an rproc_get_by_phandle API.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v4->v5: Fixed build error from of_find_node_by_phandle when !CONFIG_OF
	based on offline discussion.

 Documentation/remoteproc.txt         |  6 +++++
 drivers/remoteproc/remoteproc_core.c | 52 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           | 14 +++++++---
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
index e6469fd..ef0219f 100644
--- a/Documentation/remoteproc.txt
+++ b/Documentation/remoteproc.txt
@@ -51,6 +51,12 @@ cost.
         rproc_shutdown() returns, and users can still use it with a subsequent
         rproc_boot(), if needed.
 
+  struct rproc *rproc_get_by_phandle(phandle phandle)
+    - Find an rproc handle using a device tree phandle. Returns the rproc
+      handle on success, and NULL on failure. This function increments
+      the remote processor's refcount, so always use rproc_put() to
+      decrement it back once rproc isn't needed anymore.
+
 3. Typical usage
 
 #include <linux/remoteproc.h>
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e991512..a898c48 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -44,6 +44,9 @@
 
 #include "remoteproc_internal.h"
 
+static DEFINE_MUTEX(rproc_list_mutex);
+static LIST_HEAD(rproc_list);
+
 typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
 				struct resource_table *table, int len);
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
@@ -1144,6 +1147,45 @@ out:
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+#ifdef CONFIG_OF
+/**
+ * rproc_get_by_phandle() - find a remote processor by phandle
+ * @phandle: phandle to the rproc
+ *
+ * Finds an rproc handle using the remote processor's phandle, and then
+ * return a handle to the rproc.
+ *
+ * This function increments the remote processor's refcount, so always
+ * use rproc_put() to decrement it back once rproc isn't needed anymore.
+ *
+ * Returns the rproc handle on success, and NULL on failure.
+ */
+struct rproc *rproc_get_by_phandle(phandle phandle)
+{
+	struct rproc *rproc = NULL, *r;
+	struct device_node *np;
+
+	np = of_find_node_by_phandle(phandle);
+	if (!np)
+		return NULL;
+
+	mutex_lock(&rproc_list_mutex);
+	list_for_each_entry(r, &rproc_list, node) {
+		if (r->dev.parent && r->dev.parent->of_node == np) {
+			rproc = r;
+			get_device(&rproc->dev);
+			break;
+		}
+	}
+	mutex_unlock(&rproc_list_mutex);
+
+	of_node_put(np);
+
+	return rproc;
+}
+EXPORT_SYMBOL(rproc_get_by_phandle);
+#endif /* CONFIG_OF */
+
 /**
  * rproc_add() - register a remote processor
  * @rproc: the remote processor handle to register
@@ -1173,6 +1215,11 @@ int rproc_add(struct rproc *rproc)
 	if (ret < 0)
 		return ret;
 
+	/* expose to rproc_get_by_phandle users */
+	mutex_lock(&rproc_list_mutex);
+	list_add(&rproc->node, &rproc_list);
+	mutex_unlock(&rproc_list_mutex);
+
 	dev_info(dev, "%s is available\n", rproc->name);
 
 	dev_info(dev, "Note: remoteproc is still under development and considered experimental.\n");
@@ -1360,6 +1407,11 @@ int rproc_del(struct rproc *rproc)
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 
+	/* the rproc is downref'ed as soon as it's removed from the klist */
+	mutex_lock(&rproc_list_mutex);
+	list_del(&rproc->node);
+	mutex_unlock(&rproc_list_mutex);
+
 	device_del(&rproc->dev);
 
 	return 0;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 78b8a9b..cccfe0b 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -36,11 +36,11 @@
 #define REMOTEPROC_H
 
 #include <linux/types.h>
-#include <linux/klist.h>
 #include <linux/mutex.h>
 #include <linux/virtio.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 
 /**
  * struct resource_table - firmware resource table header
@@ -375,7 +375,7 @@ enum rproc_crash_type {
 
 /**
  * struct rproc - represents a physical remote processor device
- * @node: klist node of this rproc object
+ * @node: list node of this rproc object
  * @domain: iommu domain
  * @name: human readable name of the rproc
  * @firmware: name of firmware file to be loaded
@@ -407,7 +407,7 @@ enum rproc_crash_type {
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  */
 struct rproc {
-	struct klist_node node;
+	struct list_head node;
 	struct iommu_domain *domain;
 	const char *name;
 	const char *firmware;
@@ -504,4 +504,12 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
 	return rvdev->rproc;
 }
 
+#ifdef CONFIG_OF
+struct rproc *rproc_get_by_phandle(phandle phandle);
+#else
+static inline struct rproc *rproc_get_by_phandle(phandle phandle)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
 #endif /* REMOTEPROC_H */
-- 
2.4.1

