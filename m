From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 1/7] iommu/omap: Register driver before setting IOMMU ops
Date: Wed, 12 Apr 2017 00:21:26 -0500
Message-ID: <20170412052132.14406-2-s-anna@ti.com>
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

Move the registration of the OMAP IOMMU platform driver before
setting the IOMMU callbacks on the platform bus. This causes
the IOMMU devices to be probed first before the .add_device()
callback is invoked for all registered devices, and allows
the iommu_group support to be added to the OMAP IOMMU driver.

While at this, also check for the return status from bus_set_iommu.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3: New patch

 drivers/iommu/omap-iommu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e2583cce2cc1..54556713c8d1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1299,6 +1299,7 @@ static int __init omap_iommu_init(void)
 	const unsigned long flags = SLAB_HWCACHE_ALIGN;
 	size_t align = 1 << 10; /* L2 pagetable alignement */
 	struct device_node *np;
+	int ret;
 
 	np = of_find_matching_node(NULL, omap_iommu_of_match);
 	if (!np)
@@ -1312,11 +1313,25 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep = p;
 
-	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
-
 	omap_iommu_debugfs_init();
 
-	return platform_driver_register(&omap_iommu_driver);
+	ret = platform_driver_register(&omap_iommu_driver);
+	if (ret) {
+		pr_err("%s: failed to register driver\n", __func__);
+		goto fail_driver;
+	}
+
+	ret = bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
+	if (ret)
+		goto fail_bus;
+
+	return 0;
+
+fail_bus:
+	platform_driver_unregister(&omap_iommu_driver);
+fail_driver:
+	kmem_cache_destroy(iopte_cachep);
+	return ret;
 }
 subsys_initcall(omap_iommu_init);
 /* must be ready before omap3isp is probed */
-- 
2.12.0
