From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 2/2] iommu/omap: Fix iommu archdata name for DT-based devices
Date: Thu, 4 Sep 2014 17:27:30 -0500
Message-ID: <1409869650-26115-3-git-send-email-s-anna@ti.com>
References: <1409869650-26115-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51278 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbaIDW2u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 18:28:50 -0400
In-Reply-To: <1409869650-26115-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

A device is tied to an iommu through its archdata field. The archdata
is allocated on the fly for DT-based devices automatically through the
.add_device iommu ops. The current logic incorrectly assigned the name
of the IOMMU user device, instead of the name of the IOMMU device as
required by the attach logic. Fix this issue so that DT-based devices
can attach successfully to an IOMMU domain.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ea6e59d..8cf8bf1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 
 #include <asm/cacheflush.h>
 
@@ -1243,6 +1244,7 @@ static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data;
 	struct device_node *np;
+	struct platform_device *pdev;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1257,13 +1259,19 @@ static int omap_iommu_add_device(struct device *dev)
 	if (!np)
 		return 0;
 
+	pdev = of_find_device_by_node(np);
+	if (WARN_ON(!pdev)) {
+		of_node_put(np);
+		return -EINVAL;
+	}
+
 	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
 	if (!arch_data) {
 		of_node_put(np);
 		return -ENOMEM;
 	}
 
-	arch_data->name = kstrdup(dev_name(dev), GFP_KERNEL);
+	arch_data->name = kstrdup(dev_name(&pdev->dev), GFP_KERNEL);
 	dev->archdata.iommu = arch_data;
 
 	of_node_put(np);
-- 
2.0.4

