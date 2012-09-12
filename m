From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 6/9] ARM: OMAP: iommu: pm runtime save and restore context
Date: Wed, 12 Sep 2012 14:45:49 -0500
Message-ID: <1347479152-588-7-git-send-email-omar.luna@linaro.org>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1347479152-588-1-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Save and restore context during pm runtime transitions.

For now, the previous API for this purpose will trigger
pm runtime functions, and will be left as exported symbol
for compatibility with it's only user.

Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/omap-iommu.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 20ae946..c4de9a9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -97,7 +97,7 @@ void omap_iommu_save_ctx(struct device *dev)
 {
 	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 
-	arch_iommu->save_ctx(obj);
+	pm_runtime_put_sync(obj->dev);
 }
 EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
 
@@ -109,7 +109,7 @@ void omap_iommu_restore_ctx(struct device *dev)
 {
 	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 
-	arch_iommu->restore_ctx(obj);
+	pm_runtime_get_sync(obj->dev);
 }
 EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
 
@@ -1001,11 +1001,36 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int omap_iommu_runtime_suspend(struct device *dev)
+{
+	struct omap_iommu *obj = to_iommu(dev);
+
+	arch_iommu->save_ctx(obj);
+
+	return 0;
+}
+
+static int omap_iommu_runtime_resume(struct device *dev)
+{
+	struct omap_iommu *obj = to_iommu(dev);
+
+	arch_iommu->restore_ctx(obj);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(omap_iommu_runtime_suspend,
+			   omap_iommu_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver omap_iommu_driver = {
 	.probe	= omap_iommu_probe,
 	.remove	= __devexit_p(omap_iommu_remove),
 	.driver	= {
 		.name	= "omap-iommu",
+		.pm	= &iommu_pm_ops,
 	},
 };
 
-- 
1.7.9.5
