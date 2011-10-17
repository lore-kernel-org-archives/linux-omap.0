From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v4 3/7] iommu/omap: announce supported page sizes
Date: Mon, 17 Oct 2011 13:27:22 +0200
Message-ID: <1318850846-16066-4-git-send-email-ohad@wizery.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318850846-16066-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, KyongHo Cho <pullip.cho@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, linux-kernel@vger.kernel.org, Stepan Moskovchenko <stepanm@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Let the IOMMU core know we support 4KiB, 64KiB, 1MiB and 16MiB page sizes.

This way the IOMMU core can split any arbitrary-sized physically
contiguous regions (that it needs to map) as needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
---
 drivers/iommu/omap-iommu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 1bb2971..1692b6a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -33,6 +33,9 @@
 	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
 	     __i++)
 
+/* bitmap of the page sizes currently supported */
+#define OMAP_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
+
 /**
  * struct omap_iommu_domain - omap iommu domain
  * @pgtable:	the page table
@@ -1207,6 +1210,7 @@ static struct iommu_ops omap_iommu_ops = {
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.domain_has_cap	= omap_iommu_domain_has_cap,
+	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
 
 static int __init omap_iommu_init(void)
-- 
1.7.4.1
