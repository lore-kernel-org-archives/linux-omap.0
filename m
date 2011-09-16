From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 3/6] iommu/msm: announce supported page sizes
Date: Fri, 16 Sep 2011 20:51:43 +0300
Message-ID: <1316195506-9777-4-git-send-email-ohad@wizery.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Let the IOMMU core know we support 4KiB, 64KiB, 1MiB and 16MiB page sizes.

This way the IOMMU core can split any arbitrary-sized physically
contiguous regions (that it needs to map) as needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 drivers/iommu/msm_iommu.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d1733f6..a4ed116 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -676,6 +676,9 @@ fail:
 	return 0;
 }
 
+/* bitmap of the page sizes currently supported */
+static unsigned long msm_iommu_pgsizes = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+
 static struct iommu_ops msm_iommu_ops = {
 	.domain_init = msm_iommu_domain_init,
 	.domain_destroy = msm_iommu_domain_destroy,
@@ -728,7 +731,10 @@ static void __init setup_iommu_tex_classes(void)
 static int __init msm_iommu_init(void)
 {
 	setup_iommu_tex_classes();
-	register_iommu(&msm_iommu_ops);
+
+	/* we're only using the first 25 bits of the pgsizes bitmap */
+	register_iommu_pgsize(&msm_iommu_ops, &msm_iommu_pgsizes, 25);
+
 	return 0;
 }
 
-- 
1.7.4.1
