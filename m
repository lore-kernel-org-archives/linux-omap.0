From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 10/11] iommu/omap: Align code with open parenthesis
Date: Mon, 20 Jul 2015 17:33:32 -0500
Message-ID: <1437431613-55656-11-git-send-email-s-anna@ti.com>
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

Fix all the occurrences of the following check warning
generated with the checkpatch --strict option:
    "CHECK: Alignment should match open parenthesis"

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4328d9855edb..36d0033c2ccb 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -787,14 +787,14 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 
 	if (!iopgd_is_table(*iopgd)) {
 		dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:px%08x\n",
-				obj->name, errs, da, iopgd, *iopgd);
+			obj->name, errs, da, iopgd, *iopgd);
 		return IRQ_NONE;
 	}
 
 	iopte = iopte_offset(iopgd, da);
 
 	dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:0x%08x pte:0x%p *pte:0x%08x\n",
-			obj->name, errs, da, iopgd, *iopgd, iopte, *iopte);
+		obj->name, errs, da, iopgd, *iopgd, iopte, *iopte);
 
 	return IRQ_NONE;
 }
@@ -820,9 +820,8 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 	struct device *dev;
 	struct omap_iommu *obj;
 
-	dev = driver_find_device(&omap_iommu_driver.driver, NULL,
-				(void *)name,
-				device_match_by_alias);
+	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
+				 device_match_by_alias);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -977,7 +976,7 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
 }
 
 static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
-			 phys_addr_t pa, size_t bytes, int prot)
+			  phys_addr_t pa, size_t bytes, int prot)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
@@ -1004,7 +1003,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 }
 
 static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
-			    size_t size)
+			       size_t size)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
@@ -1055,7 +1054,7 @@ out:
 }
 
 static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
-			struct device *dev)
+				   struct device *dev)
 {
 	struct omap_iommu *oiommu = dev_to_omap_iommu(dev);
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
@@ -1076,7 +1075,7 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 }
 
 static void omap_iommu_detach_dev(struct iommu_domain *domain,
-				 struct device *dev)
+				  struct device *dev)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 
@@ -1137,7 +1136,7 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 }
 
 static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t da)
+					   dma_addr_t da)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
@@ -1154,7 +1153,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
 		else
 			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
-							(unsigned long long)da);
+				(unsigned long long)da);
 	} else {
 		if (iopgd_is_section(*pgd))
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
@@ -1162,7 +1161,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
 		else
 			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
-							(unsigned long long)da);
+				(unsigned long long)da);
 	}
 
 	return ret;
-- 
2.4.4
