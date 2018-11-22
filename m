From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
Date: Thu, 22 Nov 2018 13:39:07 +0200
Message-ID: <1542886753-17625-12-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Add two new get and put API, pruss_get() and pruss_put(), to the
PRUSS platform driver to allow client drivers to request a handle
to a PRUSS device. This handle will be used by client drivers to
request various operations of the PRUSS platform driver through
additional API that will be added in the following patches.

The pruss_get() function returns the pruss handle corresponding
to a PRUSS device referenced by a PRU remoteproc instance. The
pruss_put() is the complimentary function to pruss_get().

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: various fixups and cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/soc/ti/pruss.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pruss.h  | 10 +++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index c2271c4..90ee5b9 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -13,10 +13,67 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/pruss.h>
+#include <linux/remoteproc.h>
 
 #include "pruss.h"
 
 /**
+ * pruss_get() - get the pruss for a given PRU remoteproc
+ * @rproc: remoteproc handle of a PRU instance
+ *
+ * Finds the parent pruss device for a PRU given the @rproc handle of the
+ * PRU remote processor. This function increments the pruss device's refcount,
+ * so always use pruss_put() to decrement it back once pruss isn't needed
+ * anymore.
+ *
+ * Returns the pruss handle on success, and an ERR_PTR on failure using one
+ * of the following error values
+ *    -EINVAL if invalid parameter
+ *    -ENODEV if PRU device or PRUSS device is not found
+ */
+struct pruss *pruss_get(struct rproc *rproc)
+{
+	struct pruss *pruss;
+	struct device *dev;
+	struct platform_device *ppdev;
+
+	if (IS_ERR_OR_NULL(rproc))
+		return ERR_PTR(-EINVAL);
+
+	dev = &rproc->dev;
+	if (!dev->parent)
+		return ERR_PTR(-ENODEV);
+
+	/* rudimentary check to make sure rproc handle is for a PRU */
+	if (!strstr(dev_name(dev->parent), "pru"))
+		return ERR_PTR(-ENODEV);
+
+	ppdev = to_platform_device(dev->parent->parent);
+	pruss = platform_get_drvdata(ppdev);
+	if (pruss)
+		get_device(pruss->dev);
+
+	return pruss ? pruss : ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(pruss_get);
+
+/**
+ * pruss_put() - decrement pruss device's usecount
+ * @pruss: pruss handle
+ *
+ * Complimentary function for pruss_get(). Needs to be called
+ * after the PRUSS is used, and only if the pruss_get() succeeds.
+ */
+void pruss_put(struct pruss *pruss)
+{
+	if (IS_ERR_OR_NULL(pruss))
+		return;
+
+	put_device(pruss->dev);
+}
+EXPORT_SYMBOL_GPL(pruss_put);
+
+/**
  * pruss_request_mem_region() - request a memory resource
  * @pruss: the pruss instance
  * @mem_id: the memory resource id
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 768b698..b9135d6 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -36,6 +36,9 @@ struct pruss;
 
 #if IS_ENABLED(CONFIG_TI_PRUSS)
 
+struct pruss *pruss_get(struct rproc *rproc);
+void pruss_put(struct pruss *pruss);
+
 int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
 			     struct pruss_mem_region *region);
 int pruss_release_mem_region(struct pruss *pruss,
@@ -45,6 +48,13 @@ int pruss_intc_trigger(unsigned int irq);
 
 #else
 
+static inline struct pruss *pruss_get(struct rproc *rproc)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void pruss_put(struct pruss *pruss) { }
+
 static inline int pruss_request_mem_region(struct pruss *pruss,
 					   enum pruss_mem mem_id,
 					   struct pruss_mem_region *region)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
