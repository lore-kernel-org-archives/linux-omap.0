From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 3/7] iommu/core: use the existing IS_ALIGNED macro
Date: Fri,  2 Sep 2011 20:32:32 +0300
Message-ID: <1314984756-4400-4-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314984756-4400-1-git-send-email-ohad@wizery.com>
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Replace iommu's alignment checks with the existing IS_ALIGNED macro,
to drop a few lines of code and utilize IS_ALIGNED's type safety.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6e6b6a1..e61a9ba 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -97,13 +98,11 @@ EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, int gfp_order, int prot)
 {
-	unsigned long invalid_mask;
 	size_t size;
 
 	size         = 0x1000UL << gfp_order;
-	invalid_mask = size - 1;
 
-	BUG_ON((iova | paddr) & invalid_mask);
+	BUG_ON(!IS_ALIGNED(iova | paddr, size));
 
 	return iommu_ops->map(domain, iova, paddr, gfp_order, prot);
 }
@@ -111,13 +110,11 @@ EXPORT_SYMBOL_GPL(iommu_map);
 
 int iommu_unmap(struct iommu_domain *domain, unsigned long iova, int gfp_order)
 {
-	unsigned long invalid_mask;
 	size_t size;
 
 	size         = 0x1000UL << gfp_order;
-	invalid_mask = size - 1;
 
-	BUG_ON(iova & invalid_mask);
+	BUG_ON(!IS_ALIGNED(iova, size));
 
 	return iommu_ops->unmap(domain, iova, gfp_order);
 }
-- 
1.7.4.1
