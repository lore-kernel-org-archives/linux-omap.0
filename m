From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Wed, 1 Apr 2015 14:37:16 -0500
Message-ID: <1427917039-43206-2-git-send-email-d-gerlach@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Allow users of remoteproc the ability to get a handle to an rproc by
passing a phandle supplied in the user's device tree node. This is
useful in situations that require manual booting of the rproc.

This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
remove the get_by_name/put API") for the ref counting a rproc klist
code but has rproc_get_by_name replaced with an rproc_get_by_phandle API.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 Documentation/remoteproc.txt         |  6 +++
 drivers/remoteproc/remoteproc_core.c | 83 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  2 +
 3 files changed, 91 insertions(+)

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
index 3cd85a63..5a6c192 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -36,6 +36,7 @@
 #include <linux/remoteproc.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
+#include <linux/klist.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
 #include <linux/virtio_ids.h>
@@ -44,6 +45,17 @@
 
 #include "remoteproc_internal.h"
 
+static void klist_rproc_get(struct klist_node *n);
+static void klist_rproc_put(struct klist_node *n);
+
+/*
+ * klist of the available remote processors.
+ *
+ * We need this in order to support rproc lookups (needed by the
+ * rproc_get_by_phandle()).
+ */
+static DEFINE_KLIST(rprocs, klist_rproc_get, klist_rproc_put);
+
 typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
 				struct resource_table *table, int len);
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
@@ -1162,6 +1174,71 @@ out:
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+/* will be called when an rproc is added to the rprocs klist */
+static void klist_rproc_get(struct klist_node *n)
+{
+	struct rproc *rproc = container_of(n, struct rproc, node);
+
+	get_device(&rproc->dev);
+}
+
+/* will be called when an rproc is removed from the rprocs klist */
+static void klist_rproc_put(struct klist_node *n)
+{
+	struct rproc *rproc = container_of(n, struct rproc, node);
+
+	put_device(&rproc->dev);
+}
+
+static struct rproc *next_rproc(struct klist_iter *i)
+{
+	struct klist_node *n;
+
+	n = klist_next(i);
+	if (!n)
+		return NULL;
+
+	return container_of(n, struct rproc, node);
+}
+
+/**
+ * rproc_get_by_phandle() - find a remote processor by phandle
+ * @phandle: phandle to the rproc
+ *
+ * Finds an rproc handle using the remote processor's phandle, and then
+ * return a handle to the rproc.
+ *
+ * Returns the rproc handle on success, and NULL on failure.
+ *
+ * This function increments the remote processor's refcount, so always
+ * use rproc_put() to decrement it back once rproc isn't needed anymore.
+ *
+ */
+struct rproc *rproc_get_by_phandle(phandle phandle)
+{
+	struct rproc *rproc;
+	struct klist_iter i;
+	struct device_node *np;
+
+	np = of_find_node_by_phandle(phandle);
+	if (!np)
+		return NULL;
+
+	/* find the remote processor, and upref its refcount */
+	klist_iter_init(&rprocs, &i);
+	while ((rproc = next_rproc(&i)) != NULL)
+		if (rproc->dev.parent && rproc->dev.parent->of_node == np) {
+			get_device(&rproc->dev);
+			break;
+		}
+	klist_iter_exit(&i);
+
+	of_node_put(np);
+
+	return rproc;
+}
+EXPORT_SYMBOL(rproc_get_by_phandle);
+
 /**
  * rproc_add() - register a remote processor
  * @rproc: the remote processor handle to register
@@ -1191,6 +1268,9 @@ int rproc_add(struct rproc *rproc)
 	if (ret < 0)
 		return ret;
 
+	/* expose to rproc_get_by_phandle users */
+	klist_add_tail(&rproc->node, &rprocs);
+
 	dev_info(dev, "%s is available\n", rproc->name);
 
 	dev_info(dev, "Note: remoteproc is still under development and considered experimental.\n");
@@ -1380,6 +1460,9 @@ int rproc_del(struct rproc *rproc)
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 
+	/* the rproc is downref'ed as soon as it's removed from the klist */
+	klist_del(&rproc->node);
+
 	device_del(&rproc->dev);
 
 	return 0;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9e7e745..0c7d403 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -41,6 +41,7 @@
 #include <linux/virtio.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 
 /**
  * struct resource_table - firmware resource table header
@@ -479,6 +480,7 @@ struct rproc_vdev {
 	u32 rsc_offset;
 };
 
+struct rproc *rproc_get_by_phandle(phandle phandle);
 struct rproc *rproc_alloc(struct device *dev, const char *name,
 				const struct rproc_ops *ops,
 				const char *firmware, int len);
-- 
2.3.0
