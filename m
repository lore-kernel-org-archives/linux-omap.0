From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] of: dma: fix protection of DMA controller data stored by DMA helpers
Date: Thu, 11 Oct 2012 14:43:01 -0500
Message-ID: <1349984581-5427-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49286 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2JKTna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 15:43:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jon-hunter@ti.com>

In the current implementation of the OF DMA helpers, read-copy-update (RCU)
linked lists are being used for storing and accessing the DMA controller data.
This part of implementation is based upon V2 of the DMA helpers by Nicolas [1].
During a recent review of RCU, it became apparent that the code is missing the
required rcu_read_lock()/unlock() calls as well as synchronisation calls before
freeing any memory protected by RCU.

Having looked into adding the appropriate RCU calls to protect the DMA data it
became apparent that with the current DMA helper implementation, using RCU is
not as attractive as it may have been before. The main reasons being that ...

1. We need to protect the DMA data around calls to the xlate function.
2. The of_dma_simple_xlate() function calls the DMA engine function
   dma_request_channel() which employs a mutex and so could sleep.
3. The RCU read-side critical sections must not sleep and so we cannot hold
   an RCU read lock around the xlate function.

Therefore, instead of using RCU, an alternative for this use-case is to employ
a simple spinlock inconjunction with a usage count variable to keep track of
how many current users of the DMA data structure there are. With this
implementation, the DMA data cannot be freed until all current users of the
DMA data are finished.

This patch is based upon the DMA helpers fix for potential deadlock [2].

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/73622
[2] http://marc.info/?l=linux-arm-kernel&m=134859982520984&w=2

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/of/dma.c       |   89 ++++++++++++++++++++++++++++++++++++------------
 include/linux/of_dma.h |    5 +--
 2 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/of/dma.c b/drivers/of/dma.c
index 4bed490..59631b2 100644
--- a/drivers/of/dma.c
+++ b/drivers/of/dma.c
@@ -19,28 +19,61 @@
 #include <linux/of_dma.h>
 
 static LIST_HEAD(of_dma_list);
+static DEFINE_SPINLOCK(of_dma_lock);
 
 /**
- * of_dma_find_controller - Find a DMA controller in DT DMA helpers list
- * @np:		device node of DMA controller
+ * of_dma_get_controller - Get a DMA controller in DT DMA helpers list
+ * @dma_spec:	pointer to DMA specifier as found in the device tree
+ *
+ * Finds a DMA controller with matching device node and number for dma cells
+ * in a list of registered DMA controllers. If a match is found the use_count
+ * variable is increased and a valid pointer to the DMA data stored is retuned.
+ * A NULL pointer is returned if no match is found.
  */
-static struct of_dma *of_dma_find_controller(struct device_node *np)
+static struct of_dma *of_dma_get_controller(struct of_phandle_args *dma_spec)
 {
 	struct of_dma *ofdma;
 
+	spin_lock(&of_dma_lock);
+
 	if (list_empty(&of_dma_list)) {
-		pr_err("empty DMA controller list\n");
+		spin_unlock(&of_dma_lock);
 		return NULL;
 	}
 
-	list_for_each_entry_rcu(ofdma, &of_dma_list, of_dma_controllers)
-		if (ofdma->of_node == np)
+	list_for_each_entry(ofdma, &of_dma_list, of_dma_controllers)
+		if ((ofdma->of_node == dma_spec->np) &&
+		    (ofdma->of_dma_nbcells == dma_spec->args_count)) {
+			ofdma->use_count++;
+			spin_unlock(&of_dma_lock);
 			return ofdma;
+		}
+
+	spin_unlock(&of_dma_lock);
+
+	pr_debug("%s: can't find DMA controller %s\n", __func__,
+		 dma_spec->np->full_name);
 
 	return NULL;
 }
 
 /**
+ * of_dma_put_controller - Decrement use count for a registered DMA controller
+ * @of_dma:	pointer to DMA controller data
+ *
+ * Decrements the use_count variable in the DMA data structure. This function
+ * should be called only when a valid pointer is returned from
+ * of_dma_get_controller() and no further accesses to data referenced by that
+ * pointer are needed.
+ */
+static void of_dma_put_controller(struct of_dma *ofdma)
+{
+	spin_lock(&of_dma_lock);
+	ofdma->use_count--;
+	spin_unlock(&of_dma_lock);
+}
+
+/**
  * of_dma_controller_register - Register a DMA controller to DT DMA helpers
  * @np:			device node of DMA controller
  * @of_dma_xlate:	translation function which converts a phandle
@@ -81,9 +114,10 @@ int of_dma_controller_register(struct device_node *np,
 	ofdma->of_dma_nbcells = nbcells;
 	ofdma->of_dma_xlate = of_dma_xlate;
 	ofdma->of_dma_data = data;
+	ofdma->use_count = 0;
 
 	/* Now queue of_dma controller structure in list */
-	list_add_tail_rcu(&ofdma->of_dma_controllers, &of_dma_list);
+	list_add_tail(&ofdma->of_dma_controllers, &of_dma_list);
 
 	return 0;
 }
@@ -95,15 +129,32 @@ EXPORT_SYMBOL_GPL(of_dma_controller_register);
  *
  * Memory allocated by of_dma_controller_register() is freed here.
  */
-void of_dma_controller_free(struct device_node *np)
+int of_dma_controller_free(struct device_node *np)
 {
 	struct of_dma *ofdma;
 
-	ofdma = of_dma_find_controller(np);
-	if (ofdma) {
-		list_del_rcu(&ofdma->of_dma_controllers);
-		kfree(ofdma);
+	spin_lock(&of_dma_lock);
+
+	if (list_empty(&of_dma_list)) {
+		spin_unlock(&of_dma_lock);
+		return -ENODEV;
 	}
+
+	list_for_each_entry(ofdma, &of_dma_list, of_dma_controllers)
+		if (ofdma->of_node == np) {
+			if (ofdma->use_count) {
+				spin_unlock(&of_dma_lock);
+				return -EBUSY;
+			}
+
+			list_del(&ofdma->of_dma_controllers);
+			spin_unlock(&of_dma_lock);
+			kfree(ofdma);
+			return 0;
+		}
+
+	spin_unlock(&of_dma_lock);
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(of_dma_controller_free);
 
@@ -166,21 +217,15 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
-		ofdma = of_dma_find_controller(dma_spec.np);
-		if (!ofdma) {
-			pr_debug("%s: can't find DMA controller %s\n",
-				 np->full_name, dma_spec.np->full_name);
-			continue;
-		}
+		ofdma = of_dma_get_controller(&dma_spec);
 
-		if (dma_spec.args_count != ofdma->of_dma_nbcells) {
-			pr_debug("%s: wrong #dma-cells for %s\n", np->full_name,
-				 dma_spec.np->full_name);
+		if (!ofdma)
 			continue;
-		}
 
 		chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
 
+		of_dma_put_controller(ofdma);
+
 		of_node_put(dma_spec.np);
 
 		if (chan)
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 67158dd..84b64f8 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -25,6 +25,7 @@ struct of_dma {
 	struct dma_chan		*(*of_dma_xlate)
 				(struct of_phandle_args *, struct of_dma *);
 	void			*of_dma_data;
+	int			use_count;
 };
 
 struct of_dma_filter_info {
@@ -37,7 +38,7 @@ extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
 		void *data);
-extern void of_dma_controller_free(struct device_node *np);
+extern int of_dma_controller_free(struct device_node *np);
 extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 						     char *name);
 extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
@@ -51,7 +52,7 @@ static int of_dma_controller_register(struct device_node *np,
 	return -ENODEV;
 }
 
-static void of_dma_controller_free(struct device_node *np)
+static int of_dma_controller_free(struct device_node *np)
 {
 }
 
-- 
1.7.9.5

