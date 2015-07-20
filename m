From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/11] iommu/omap: Remove all module references
Date: Mon, 20 Jul 2015 17:33:24 -0500
Message-ID: <1437431613-55656-3-git-send-email-s-anna@ti.com>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437431613-55656-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP IOMMU driver has been adapted to the IOMMU framework
for a while now, and it does not support being built as a
module anymore. So, remove all the module references from the
OMAP IOMMU driver.

While at it, also relocate a comment around the subsys_initcall
to avoid a checkpatch strict warning about using a blank line
after function/struct/union/enum declarations.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a22c33d6a486..eeecfc4073af 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
@@ -1089,7 +1088,6 @@ static const struct of_device_id omap_iommu_of_match[] = {
 	{ .compatible = "ti,dra7-iommu"	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
 
 static struct platform_driver omap_iommu_driver = {
 	.probe	= omap_iommu_probe,
@@ -1405,20 +1403,5 @@ static int __init omap_iommu_init(void)
 
 	return platform_driver_register(&omap_iommu_driver);
 }
-/* must be ready before omap3isp is probed */
 subsys_initcall(omap_iommu_init);
-
-static void __exit omap_iommu_exit(void)
-{
-	kmem_cache_destroy(iopte_cachep);
-
-	platform_driver_unregister(&omap_iommu_driver);
-
-	omap_iommu_debugfs_exit();
-}
-module_exit(omap_iommu_exit);
-
-MODULE_DESCRIPTION("omap iommu: tlb and pagetable primitives");
-MODULE_ALIAS("platform:omap-iommu");
-MODULE_AUTHOR("Hiroshi DOYU, Paul Mundt and Toshihiro Kobayashi");
-MODULE_LICENSE("GPL v2");
+/* must be ready before omap3isp is probed */
-- 
2.4.4
