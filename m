From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 2/2] iommu/omap: Remove omap_iommu unused owner field
Date: Tue,  9 Sep 2014 18:45:45 +0300
Message-ID: <1410277545-32157-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1410277545-32157-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410277545-32157-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The owner field is never set. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 11 -----------
 drivers/iommu/omap-iommu.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 192c367..fdfe732 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -861,20 +861,11 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 		goto err_enable;
 	flush_iotlb_all(obj);
 
-	if (!try_module_get(obj->owner)) {
-		dev_err(obj->dev, "%s: can't get owner\n", __func__);
-		err = -ENODEV;
-		goto err_module;
-	}
-
 	spin_unlock(&obj->iommu_lock);
 
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
 	return obj;
 
-err_module:
-	if (obj->refcount == 1)
-		iommu_disable(obj);
 err_enable:
 	obj->refcount--;
 	spin_unlock(&obj->iommu_lock);
@@ -895,8 +886,6 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 	if (--obj->refcount == 0)
 		iommu_disable(obj);
 
-	module_put(obj->owner);
-
 	obj->iopgd = NULL;
 
 	spin_unlock(&obj->iommu_lock);
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 7a90800..2c3b85c 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -28,7 +28,6 @@ struct iotlb_entry {
 
 struct omap_iommu {
 	const char	*name;
-	struct module	*owner;
 	void __iomem	*regbase;
 	struct device	*dev;
 	void		*isr_priv;
-- 
1.8.5.5
