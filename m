From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 1/2] iommu/omap: Change the attach detection logic
Date: Thu, 31 Aug 2017 08:14:01 -0500
Message-ID: <20170831131402.29502-2-s-anna@ti.com>
References: <20170831131402.29502-1-s-anna@ti.com>
Reply-To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170831131402.29502-1-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The OMAP IOMMU driver allows only a single device (eg: a rproc
device) to be attached per domain. The current attach detection
logic relies on a check for an attached iommu for the respective
client device. Change this logic to use the client device pointer
instead in preparation for supporting multiple iommu devices to be
bound to a single iommu domain, and thereby to a client device.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bd67e1b2c64e..81ef729994ce 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -805,7 +805,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	struct iommu_domain *domain = obj->domain;
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 
-	if (!omap_domain->iommu_dev)
+	if (!omap_domain->dev)
 		return IRQ_NONE;
 
 	errs = iommu_report_fault(obj, &da);
@@ -1118,8 +1118,8 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	spin_lock(&omap_domain->lock);
 
-	/* only a single device is supported per domain for now */
-	if (omap_domain->iommu_dev) {
+	/* only a single client device can be attached to a domain */
+	if (omap_domain->dev) {
 		dev_err(dev, "iommu domain is already attached\n");
 		ret = -EBUSY;
 		goto out;
@@ -1148,9 +1148,14 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 {
 	struct omap_iommu *oiommu = dev_to_omap_iommu(dev);
 
+	if (!omap_domain->dev) {
+		dev_err(dev, "domain has no attached device\n");
+		return;
+	}
+
 	/* only a single device is supported per domain for now */
-	if (omap_domain->iommu_dev != oiommu) {
-		dev_err(dev, "invalid iommu device\n");
+	if (omap_domain->dev != dev) {
+		dev_err(dev, "invalid attached device\n");
 		return;
 	}
 
@@ -1219,7 +1224,7 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	 * An iommu device is still attached
 	 * (currently, only one device can be attached) ?
 	 */
-	if (omap_domain->iommu_dev)
+	if (omap_domain->dev)
 		_omap_iommu_detach_dev(omap_domain, omap_domain->dev);
 
 	kfree(omap_domain->pgtable);
-- 
2.13.1
