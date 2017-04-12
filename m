From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 6/7] iommu/omap: Add iommu-group support
Date: Wed, 12 Apr 2017 00:21:31 -0500
Message-ID: <20170412052132.14406-7-s-anna@ti.com>
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

Support for IOMMU groups will become mandatory for drivers,
so add it to the omap iommu driver.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: minor error cleanups]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3 w.r.t v1:
 - iommu_group_get_for_dev() failure path cleanup code added in
   the add_device callback
 - iommu_group_alloc() added in the same place relative to iommu_device
   calls, but before pm_runtime calls
 - iommu_device_register() failure cleanup dropped since it is handled
   in patch 5
 - omap_device_group() renamed to omap_iommu_device_group() following
   the convention on all OMAP IOMMU ops

 drivers/iommu/omap-iommu.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/omap-iommu.h |  1 +
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ef44fc740da7..95dfca36ccb9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -943,9 +943,13 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		return err;
 	platform_set_drvdata(pdev, obj);
 
+	obj->group = iommu_group_alloc();
+	if (IS_ERR(obj->group))
+		return PTR_ERR(obj->group);
+
 	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
 	if (err)
-		return err;
+		goto out_group;
 
 	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
 
@@ -959,10 +963,13 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	omap_iommu_debugfs_add(obj);
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
+
 	return 0;
 
 out_sysfs:
 	iommu_device_sysfs_remove(&obj->iommu);
+out_group:
+	iommu_group_put(obj->group);
 	return err;
 }
 
@@ -970,6 +977,9 @@ static int omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
+	iommu_group_put(obj->group);
+	obj->group = NULL;
+
 	iommu_device_sysfs_remove(&obj->iommu);
 	iommu_device_unregister(&obj->iommu);
 
@@ -1217,6 +1227,7 @@ static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data;
 	struct omap_iommu *oiommu;
+	struct iommu_group *group;
 	struct device_node *np;
 	struct platform_device *pdev;
 	int ret;
@@ -1262,6 +1273,19 @@ static int omap_iommu_add_device(struct device *dev)
 	arch_data->iommu_dev = oiommu;
 	dev->archdata.iommu = arch_data;
 
+	/*
+	 * IOMMU group initialization calls into omap_iommu_device_group, which
+	 * needs a valid dev->archdata.iommu pointer
+	 */
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group)) {
+		iommu_device_unlink(&oiommu->iommu, dev);
+		dev->archdata.iommu = NULL;
+		kfree(arch_data);
+		return PTR_ERR(group);
+	}
+	iommu_group_put(group);
+
 	of_node_put(np);
 
 	return 0;
@@ -1275,12 +1299,24 @@ static void omap_iommu_remove_device(struct device *dev)
 		return;
 
 	iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
+	iommu_group_remove_device(dev);
 
 	dev->archdata.iommu = NULL;
 	kfree(arch_data);
 
 }
 
+static struct iommu_group *omap_iommu_device_group(struct device *dev)
+{
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct iommu_group *group = NULL;
+
+	if (arch_data->iommu_dev)
+		group = arch_data->iommu_dev->group;
+
+	return group;
+}
+
 static const struct iommu_ops omap_iommu_ops = {
 	.domain_alloc	= omap_iommu_domain_alloc,
 	.domain_free	= omap_iommu_domain_free,
@@ -1292,6 +1328,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
+	.device_group	= omap_iommu_device_group,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
 
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 758958a4712c..6e70515e6038 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -70,6 +70,7 @@ struct omap_iommu {
 	u32 id;
 
 	struct iommu_device iommu;
+	struct iommu_group *group;
 };
 
 /**
-- 
2.12.0
