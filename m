From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH v3 3/6] ARM: OMAP: iommu: pm runtime save and restore context
Date: Thu, 11 Oct 2012 20:06:10 -0500
Message-ID: <1350003977-32744-6-git-send-email-omar.luna@linaro.org>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Save and restore context during pm runtime transitions.

For now, the previous API for this purpose will trigger
pm runtime functions, and will be left as exported symbol
for compatibility with it's only user.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 drivers/iommu/omap-iommu.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 37644c4..875e894 100644
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
 
@@ -1008,11 +1008,36 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
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

