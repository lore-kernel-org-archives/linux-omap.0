From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu: OMAP: device detach on domain destroy
Date: Fri, 30 Mar 2012 11:03:49 -0500
Message-ID: <1333123429-3727-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

'domain_destroy with devices attached' case isn't yet handled, instead
code assumes that the device was already detached.

If the domain is destroyed the hardware still has access to invalid
pointers to its page table and internal iommu object. In order to
detach the users we need to track devices using the iommu, current
use cases only have one user of iommu per instance. When required
this can evolve to a list with the devices using the iommu_dev.

Reported-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Reviewed-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/omap-iommu.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 821062a..e32bd15 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -41,11 +41,13 @@
  * @pgtable:	the page table
  * @iommu_dev:	an omap iommu device attached to this domain. only a single
  *		iommu device can be attached for now.
+ * @dev:	Device using this domain.
  * @lock:	domain lock, should be taken when attaching/detaching
  */
 struct omap_iommu_domain {
 	u32 *pgtable;
 	struct omap_iommu *iommu_dev;
+	struct device *dev;
 	spinlock_t lock;
 };
 
@@ -1074,6 +1076,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
+	omap_domain->dev = dev;
 	oiommu->domain = domain;
 
 	/* temporary workaround */
@@ -1084,19 +1087,16 @@ out:
 	return ret;
 }
 
-static void omap_iommu_detach_dev(struct iommu_domain *domain,
-				 struct device *dev)
+static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
+			struct device *dev)
 {
-	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
 	struct omap_iommu *oiommu = dev_to_omap_iommu(dev);
-
-	spin_lock(&omap_domain->lock);
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
 
 	/* only a single device is supported per domain for now */
 	if (omap_domain->iommu_dev != oiommu) {
 		dev_err(dev, "invalid iommu device\n");
-		goto out;
+		return;
 	}
 
 	iopgtable_clear_entry_all(oiommu);
@@ -1104,11 +1104,19 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 	omap_iommu_detach(oiommu);
 
 	omap_domain->iommu_dev = arch_data->iommu_dev = NULL;
+	omap_domain->dev = NULL;
 
 	/* temporary workaround */
 	clk_disable(oiommu->clk);
+}
 
-out:
+static void omap_iommu_detach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+
+	spin_lock(&omap_domain->lock);
+	_omap_iommu_detach_dev(omap_domain, dev);
 	spin_unlock(&omap_domain->lock);
 }
 
@@ -1147,13 +1155,19 @@ out:
 	return -ENOMEM;
 }
 
-/* assume device was already detached */
 static void omap_iommu_domain_destroy(struct iommu_domain *domain)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
 
 	domain->priv = NULL;
 
+	/*
+	 * An iommu device is still attached
+	 * (currently, only one device can be attached) ?
+	 */
+	if (omap_domain->iommu_dev)
+		_omap_iommu_detach_dev(omap_domain, omap_domain->dev);
+
 	kfree(omap_domain->pgtable);
 	kfree(omap_domain);
 }
-- 
1.7.4.1
