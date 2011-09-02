From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/7] iommu/omap: cleanup: remove a redundant statement
Date: Fri,  2 Sep 2011 20:32:31 +0300
Message-ID: <1314984756-4400-3-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

Tiny cleanup that removes a redundant 'return' statement.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 90744af..4311bc3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1069,12 +1069,10 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	iotlb_init_entry(&e, da, pa, flags);
 
 	ret = omap_iopgtable_store_entry(oiommu, &e);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "omap_iopgtable_store_entry failed: %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
-- 
1.7.4.1
