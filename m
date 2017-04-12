From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 2/7] iommu/omap: Drop legacy-style device support
Date: Wed, 12 Apr 2017 00:21:27 -0500
Message-ID: <20170412052132.14406-3-s-anna@ti.com>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

All the supported boards that have OMAP IOMMU devices do support
DT boot only now. So, drop the support for the non-DT legacy-style
devices from the OMAP IOMMU driver. Couple of the fields from the
iommu platform data would no longer be required, so they have also
been cleaned up. The IOMMU platform data is still needed though for
performing reset management properly in a multi-arch environment.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3: New patch

 drivers/iommu/omap-iommu.c               | 30 ++++++++++++++----------------
 include/linux/platform_data/iommu-omap.h |  3 ---
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 54556713c8d1..febd4fbe3445 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -928,28 +928,26 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	int irq;
 	struct omap_iommu *obj;
 	struct resource *res;
-	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *of = pdev->dev.of_node;
 
+	if (!of) {
+		pr_err("%s: only DT-based devices are supported\n", __func__);
+		return -ENODEV;
+	}
+
 	obj = devm_kzalloc(&pdev->dev, sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
 	if (!obj)
 		return -ENOMEM;
 
-	if (of) {
-		obj->name = dev_name(&pdev->dev);
-		obj->nr_tlb_entries = 32;
-		err = of_property_read_u32(of, "ti,#tlb-entries",
-					   &obj->nr_tlb_entries);
-		if (err && err != -EINVAL)
-			return err;
-		if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
-			return -EINVAL;
-		if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
-			obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
-	} else {
-		obj->nr_tlb_entries = pdata->nr_tlb_entries;
-		obj->name = pdata->name;
-	}
+	obj->name = dev_name(&pdev->dev);
+	obj->nr_tlb_entries = 32;
+	err = of_property_read_u32(of, "ti,#tlb-entries", &obj->nr_tlb_entries);
+	if (err && err != -EINVAL)
+		return err;
+	if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
+		return -EINVAL;
+	if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
+		obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
 
 	obj->dev = &pdev->dev;
 	obj->ctx = (void *)obj + sizeof(*obj);
diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 0496d171700a..a40fc0f4f9de 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -30,10 +30,7 @@ struct omap_iommu_arch_data {
 };
 
 struct iommu_platform_data {
-	const char *name;
 	const char *reset_name;
-	int nr_tlb_entries;
-
 	int (*assert_reset)(struct platform_device *pdev, const char *name);
 	int (*deassert_reset)(struct platform_device *pdev, const char *name);
 };
-- 
2.12.0
