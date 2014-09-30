From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/17] iommu/omap: Remove refcount field from omap_iommu object
Date: Tue, 30 Sep 2014 16:15:56 -0500
Message-ID: <1412111772-38006-2-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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

The refcount field in omap_iommu object is primarily used to check
if an IOMMU device has already been enabled, but this is already
implicit in the omap_iommu_attach_dev() which ensures that only
a single device can attach to an IOMMU. This field is redundant,
and so has been cleaned up.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 15 +++------------
 drivers/iommu/omap-iommu.h |  1 -
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4b432c4..ed26701 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -819,8 +819,9 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	u32 *iopgd, *iopte;
 	struct omap_iommu *obj = data;
 	struct iommu_domain *domain = obj->domain;
+	struct omap_iommu_domain *omap_domain = domain->priv;
 
-	if (!obj->refcount)
+	if (!omap_domain->iommu_dev)
 		return IRQ_NONE;
 
 	errs = iommu_report_fault(obj, &da);
@@ -880,13 +881,6 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 
 	spin_lock(&obj->iommu_lock);
 
-	/* an iommu device can only be attached once */
-	if (++obj->refcount > 1) {
-		dev_err(dev, "%s: already attached!\n", obj->name);
-		err = -EBUSY;
-		goto err_enable;
-	}
-
 	obj->iopgd = iopgd;
 	err = iommu_enable(obj);
 	if (err)
@@ -899,7 +893,6 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 	return obj;
 
 err_enable:
-	obj->refcount--;
 	spin_unlock(&obj->iommu_lock);
 	return ERR_PTR(err);
 }
@@ -915,9 +908,7 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 
 	spin_lock(&obj->iommu_lock);
 
-	if (--obj->refcount == 0)
-		iommu_disable(obj);
-
+	iommu_disable(obj);
 	obj->iopgd = NULL;
 
 	spin_unlock(&obj->iommu_lock);
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 4f1b68c..5c14000 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -33,7 +33,6 @@ struct omap_iommu {
 	void		*isr_priv;
 	struct iommu_domain *domain;
 
-	unsigned int	refcount;
 	spinlock_t	iommu_lock;	/* global for this whole object */
 
 	/*
-- 
2.1.0
