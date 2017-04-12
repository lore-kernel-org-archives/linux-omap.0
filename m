From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/7] iommu/omap: Store iommu_dev pointer in arch_data
Date: Wed, 12 Apr 2017 00:21:29 -0500
Message-ID: <20170412052132.14406-5-s-anna@ti.com>
References: <20170412052132.14406-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170412052132.14406-1-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Instead of finding the matching IOMMU for a device using
string comparision functions, store the pointer to the
iommu_dev in arch_data during the omap_iommu_add_device
callback and reset it during the omap_iommu_remove_device
callback functions.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: few minor cleanups]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3 w.r.t v1:
 - dropped the iommu_domain from arch_data (same as in v2)
 - squashed patch 3 from v1 into this patch
 - minor revisions to the commit subject and description
 - renamed the iommu variable to oiommu in add_device following existing
   convention
 - removed the kerneldoc comment for name in archdata structure

 drivers/iommu/omap-iommu.c | 56 +++++++++++++++++++---------------------------
 drivers/iommu/omap-iommu.h |  2 --
 2 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c1739a650654..0553b0381e2a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -802,33 +802,14 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int device_match_by_alias(struct device *dev, void *data)
-{
-	struct omap_iommu *obj = to_iommu(dev);
-	const char *name = data;
-
-	pr_debug("%s: %s %s\n", __func__, obj->name, name);
-
-	return strcmp(obj->name, name) == 0;
-}
-
 /**
  * omap_iommu_attach() - attach iommu device to an iommu domain
- * @name:	name of target omap iommu device
+ * @obj:	target omap iommu device
  * @iopgd:	page table
  **/
-static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
+static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
 {
 	int err;
-	struct device *dev;
-	struct omap_iommu *obj;
-
-	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
-				 device_match_by_alias);
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	obj = to_iommu(dev);
 
 	spin_lock(&obj->iommu_lock);
 
@@ -841,11 +822,13 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 	spin_unlock(&obj->iommu_lock);
 
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
-	return obj;
+
+	return 0;
 
 err_enable:
 	spin_unlock(&obj->iommu_lock);
-	return ERR_PTR(err);
+
+	return err;
 }
 
 /**
@@ -1059,11 +1042,11 @@ static int
 omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
-	struct omap_iommu *oiommu;
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct omap_iommu *oiommu;
 	int ret = 0;
 
-	if (!arch_data || !arch_data->name) {
+	if (!arch_data || !arch_data->iommu_dev) {
 		dev_err(dev, "device doesn't have an associated iommu\n");
 		return -EINVAL;
 	}
@@ -1077,15 +1060,16 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out;
 	}
 
+	oiommu = arch_data->iommu_dev;
+
 	/* get a handle to and enable the omap iommu */
-	oiommu = omap_iommu_attach(arch_data->name, omap_domain->pgtable);
-	if (IS_ERR(oiommu)) {
-		ret = PTR_ERR(oiommu);
+	ret = omap_iommu_attach(oiommu, omap_domain->pgtable);
+	if (ret) {
 		dev_err(dev, "can't get omap iommu: %d\n", ret);
 		goto out;
 	}
 
-	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
+	omap_domain->iommu_dev = oiommu;
 	omap_domain->dev = dev;
 	oiommu->domain = domain;
 
@@ -1098,7 +1082,6 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 				   struct device *dev)
 {
 	struct omap_iommu *oiommu = dev_to_omap_iommu(dev);
-	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
 
 	/* only a single device is supported per domain for now */
 	if (omap_domain->iommu_dev != oiommu) {
@@ -1110,7 +1093,7 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 
 	omap_iommu_detach(oiommu);
 
-	omap_domain->iommu_dev = arch_data->iommu_dev = NULL;
+	omap_domain->iommu_dev = NULL;
 	omap_domain->dev = NULL;
 	oiommu->domain = NULL;
 }
@@ -1214,6 +1197,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data;
+	struct omap_iommu *oiommu;
 	struct device_node *np;
 	struct platform_device *pdev;
 
@@ -1236,13 +1220,19 @@ static int omap_iommu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
+	oiommu = platform_get_drvdata(pdev);
+	if (!oiommu) {
+		of_node_put(np);
+		return -EINVAL;
+	}
+
 	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
 	if (!arch_data) {
 		of_node_put(np);
 		return -ENOMEM;
 	}
 
-	arch_data->name = kstrdup(dev_name(&pdev->dev), GFP_KERNEL);
+	arch_data->iommu_dev = oiommu;
 	dev->archdata.iommu = arch_data;
 
 	of_node_put(np);
@@ -1257,7 +1247,7 @@ static void omap_iommu_remove_device(struct device *dev)
 	if (!dev->of_node || !arch_data)
 		return;
 
-	kfree(arch_data->name);
+	dev->archdata.iommu = NULL;
 	kfree(arch_data);
 }
 
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 3c33608f48ca..f81184b549ec 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -72,7 +72,6 @@ struct omap_iommu {
 
 /**
  * struct omap_iommu_arch_data - omap iommu private data
- * @name: name of the iommu device
  * @iommu_dev: handle of the iommu device
  *
  * This is an omap iommu private data object, which binds an iommu user
@@ -81,7 +80,6 @@ struct omap_iommu {
  * utilize omap-specific plumbing anymore.
  */
 struct omap_iommu_arch_data {
-	const char *name;
 	struct omap_iommu *iommu_dev;
 };
 
-- 
2.12.0
