From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 04/16] iommu/omap: add devicetree support
Date: Thu, 13 Feb 2014 12:15:35 -0600
Message-ID: <1392315347-32967-5-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

As OMAP2+ is moving to a full DT boot for all SoC families, commit
7ce93f3 "ARM: OMAP2+: Fix more missing data for omap3.dtsi file"
adds basic DT bits for OMAP3. But the driver is not yet converted,
so this will not work and driver will not be probed. Convert it!

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: dev_name adaptation and improved error checking]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap-iommu.c |  5 +++++
 drivers/iommu/omap-iommu.c       | 41 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index f6daae8..f1fab56 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -58,6 +59,10 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 
 static int __init omap_iommu_init(void)
 {
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	return omap_hwmod_for_each_by_class("mmu", omap_iommu_dev_init, NULL);
 }
 /* must be ready before omap3isp is probed */
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6272c36..4329ab1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -23,6 +23,9 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_irq.h>
 
 #include <asm/cacheflush.h>
 
@@ -937,20 +940,41 @@ static int omap_iommu_probe(struct platform_device *pdev)
 {
 	int err = -ENODEV;
 	int irq;
+	size_t len;
 	struct omap_iommu *obj;
 	struct resource *res;
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *of = pdev->dev.of_node;
 
 	obj = devm_kzalloc(&pdev->dev, sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
 	if (!obj)
 		return -ENOMEM;
 
-	obj->nr_tlb_entries = pdata->nr_tlb_entries;
-	obj->name = pdata->name;
+	if (of) {
+		obj->name = dev_name(&pdev->dev);
+		obj->nr_tlb_entries = 32;
+		err = of_property_read_u32(of, "ti,#tlb-entries",
+					   &obj->nr_tlb_entries);
+		if (err && err != -EINVAL)
+			return err;
+		if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
+			return -EINVAL;
+		err = of_get_dma_window(of, NULL, 0, NULL, &obj->da_start,
+					&len);
+		if (err != 0)
+			return err;
+		obj->da_end = obj->da_start + len;
+	} else {
+		obj->nr_tlb_entries = pdata->nr_tlb_entries;
+		obj->name = pdata->name;
+		obj->da_start = pdata->da_start;
+		obj->da_end = pdata->da_end;
+	}
+	if (obj->da_end <= obj->da_start)
+		return -EINVAL;
+
 	obj->dev = &pdev->dev;
 	obj->ctx = (void *)obj + sizeof(*obj);
-	obj->da_start = pdata->da_start;
-	obj->da_end = pdata->da_end;
 
 	spin_lock_init(&obj->iommu_lock);
 	mutex_init(&obj->mmap_lock);
@@ -991,11 +1015,20 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id omap_iommu_of_match[] = {
+	{ .compatible = "ti,omap2-iommu" },
+	{ .compatible = "ti,omap4-iommu" },
+	{ .compatible = "ti,dra7-iommu"	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
+
 static struct platform_driver omap_iommu_driver = {
 	.probe	= omap_iommu_probe,
 	.remove	= omap_iommu_remove,
 	.driver	= {
 		.name	= "omap-iommu",
+		.of_match_table = of_match_ptr(omap_iommu_of_match),
 	},
 };
 
-- 
1.8.5.3
