From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 7/7] [media] omap3isp: Remove iommu_group related code
Date: Wed, 12 Apr 2017 00:21:32 -0500
Message-ID: <20170412052132.14406-8-s-anna@ti.com>
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

The OMAP IOMMU driver has added the support for IOMMU groups internally,
and the ISP device is automatically linked to the appropriate IOMMU group.
So, remove the explicit function calls that creates/deletes an iommu_group
and adds the ISP device to this group.

Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v3: new patch

 drivers/media/platform/omap3isp/isp.c | 17 -----------------
 drivers/media/platform/omap3isp/isp.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 084ecf4aa9a4..0d984a28a003 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1943,30 +1943,13 @@ static void isp_detach_iommu(struct isp_device *isp)
 {
 	arm_iommu_release_mapping(isp->mapping);
 	isp->mapping = NULL;
-	iommu_group_remove_device(isp->dev);
 }
 
 static int isp_attach_iommu(struct isp_device *isp)
 {
 	struct dma_iommu_mapping *mapping;
-	struct iommu_group *group;
 	int ret;
 
-	/* Create a device group and add the device to it. */
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(isp->dev, "failed to allocate IOMMU group\n");
-		return PTR_ERR(group);
-	}
-
-	ret = iommu_group_add_device(group, isp->dev);
-	iommu_group_put(group);
-
-	if (ret < 0) {
-		dev_err(isp->dev, "failed to add device to IPMMU group\n");
-		return ret;
-	}
-
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/platform/omap3isp/isp.h
index 7e6f6638433b..2f2ae609c548 100644
--- a/drivers/media/platform/omap3isp/isp.h
+++ b/drivers/media/platform/omap3isp/isp.h
@@ -23,7 +23,6 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/wait.h>
 
-- 
2.12.0
