From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC] media: omap3isp: Fix high idle current
Date: Thu, 10 Jan 2019 07:01:36 +0100
Message-ID: <20190110060136.16896-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

On the GTA04, current consumption rose by about 30mA when the omap3_isp
module was loaded and the v4l device was not accessed and even no
camera attached.
Module removal fixed it again. Slowing down the removal process reveals
that calling isp_detach_iommu() is required to have low
current. So isp_attach/detach_iommu() to moved to the get()/put()
functions.
This all has strange side effects. The hwmod seems to be accessible
using /dev/mem if the iommu calls in their original place. With
the modified placement it is not.
In a very old setup with a 3.7 kernel which
has the iommu calls at the same place as our current kernel,
the memory is not accessible.
Note: isp_get()/put() calls seem to be balanced.

But at the current wonky gta04 setup (with a not upstreamed
image sensor driver)which also has other problems, CAM
reports address holes. So I have no clear idea whether this patch
is right or not.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/media/platform/omap3isp/isp.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 13f2828d880d..b837ca5604ad 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -88,6 +88,10 @@ static void isp_save_ctx(struct isp_device *isp);
 
 static void isp_restore_ctx(struct isp_device *isp);
 
+static int isp_attach_iommu(struct isp_device *isp);
+
+static void isp_detach_iommu(struct isp_device *isp);
+
 static const struct isp_res_mapping isp_res_maps[] = {
 	{
 		.isp_rev = ISP_REVISION_2_0,
@@ -1407,6 +1411,14 @@ static struct isp_device *__omap3isp_get(struct isp_device *isp, bool irq)
 		__isp = NULL;
 		goto out;
 	}
+	/* IOMMU */
+	if (isp_attach_iommu(isp) < 0) {
+		dev_err(isp->dev, "unable to attach to IOMMU\n");
+		isp_disable_clocks(isp);
+		__isp = NULL;
+		goto out;
+	}
+
 
 	/* We don't want to restore context before saving it! */
 	if (isp->has_context)
@@ -1453,6 +1465,7 @@ static void __omap3isp_put(struct isp_device *isp, bool save_ctx)
 		if (!media_entity_enum_empty(&isp->crashed) ||
 		    isp->stop_failure)
 			isp_reset(isp);
+		isp_detach_iommu(isp);
 		isp_disable_clocks(isp);
 	}
 	mutex_unlock(&isp->isp_mutex);
@@ -1999,10 +2012,6 @@ static int isp_remove(struct platform_device *pdev)
 	isp_cleanup_modules(isp);
 	isp_xclk_cleanup(isp);
 
-	__omap3isp_get(isp, false);
-	isp_detach_iommu(isp);
-	__omap3isp_put(isp, false);
-
 	media_entity_enum_cleanup(&isp->crashed);
 	v4l2_async_notifier_cleanup(&isp->notifier);
 
@@ -2313,19 +2322,12 @@ static int isp_probe(struct platform_device *pdev)
 	isp->mmio_hist_base_phys =
 		mem->start + isp_res_maps[m].offset[OMAP3_ISP_IOMEM_HIST];
 
-	/* IOMMU */
-	ret = isp_attach_iommu(isp);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to attach to IOMMU\n");
-		goto error_isp;
-	}
-
 	/* Interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
 		dev_err(isp->dev, "No IRQ resource\n");
 		ret = -ENODEV;
-		goto error_iommu;
+		goto error_isp;
 	}
 	isp->irq_num = ret;
 
@@ -2339,7 +2341,7 @@ static int isp_probe(struct platform_device *pdev)
 	/* Entities */
 	ret = isp_initialize_modules(isp);
 	if (ret < 0)
-		goto error_iommu;
+		goto error_isp;
 
 	ret = isp_register_entities(isp);
 	if (ret < 0)
-- 
2.11.0
