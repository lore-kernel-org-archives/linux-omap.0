From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 5/7] iommu/omap: Make use of 'struct iommu_device'
Date: Wed, 12 Apr 2017 00:21:30 -0500
Message-ID: <20170412052132.14406-6-s-anna@ti.com>
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

Modify the driver to register individual iommus and
establish links between devices and iommus in sysfs.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: fix some cleanup issues during failures]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3 w.r.t v1:
 - moved the iommu_device calls in probe above the pm_runtime API
   invocations to simplify cleanup
 - added the cleanup on iommu_device_register() failure (code moved
   from patch 5 from v1)
 - arch_data also freed upon iommu_device_link failure in add_device

 drivers/iommu/omap-iommu.c | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/omap-iommu.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 0553b0381e2a..ef44fc740da7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -36,6 +36,8 @@
 #include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
+static const struct iommu_ops omap_iommu_ops;
+
 #define to_iommu(dev)							\
 	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
 
@@ -941,6 +943,16 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		return err;
 	platform_set_drvdata(pdev, obj);
 
+	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
+	if (err)
+		return err;
+
+	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
+
+	err = iommu_device_register(&obj->iommu);
+	if (err)
+		goto out_sysfs;
+
 	pm_runtime_irq_safe(obj->dev);
 	pm_runtime_enable(obj->dev);
 
@@ -948,12 +960,19 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
+
+out_sysfs:
+	iommu_device_sysfs_remove(&obj->iommu);
+	return err;
 }
 
 static int omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&obj->iommu);
+	iommu_device_unregister(&obj->iommu);
+
 	omap_iommu_debugfs_remove(obj);
 
 	pm_runtime_disable(obj->dev);
@@ -1200,6 +1219,7 @@ static int omap_iommu_add_device(struct device *dev)
 	struct omap_iommu *oiommu;
 	struct device_node *np;
 	struct platform_device *pdev;
+	int ret;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1232,6 +1252,13 @@ static int omap_iommu_add_device(struct device *dev)
 		return -ENOMEM;
 	}
 
+	ret = iommu_device_link(&oiommu->iommu, dev);
+	if (ret) {
+		kfree(arch_data);
+		of_node_put(np);
+		return ret;
+	}
+
 	arch_data->iommu_dev = oiommu;
 	dev->archdata.iommu = arch_data;
 
@@ -1247,8 +1274,11 @@ static void omap_iommu_remove_device(struct device *dev)
 	if (!dev->of_node || !arch_data)
 		return;
 
+	iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
+
 	dev->archdata.iommu = NULL;
 	kfree(arch_data);
+
 }
 
 static const struct iommu_ops omap_iommu_ops = {
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index f81184b549ec..758958a4712c 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -68,6 +68,8 @@ struct omap_iommu {
 
 	int has_bus_err_back;
 	u32 id;
+
+	struct iommu_device iommu;
 };
 
 /**
-- 
2.12.0
