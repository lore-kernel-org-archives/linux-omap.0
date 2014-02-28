From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 02/13] iommu/omap: fix error return paths in
	omap_iommu_attach()
Date: Fri, 28 Feb 2014 14:42:33 -0600
Message-ID: <1393620164-14633-3-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

There are couple of issues with the error return paths in
omap_iommu_attach():
1. omap_iommu_attach() returns NULL or ERR_PTR in case of error,
   but omap_iommu_attach_dev() only checks for IS_ERR. Thus a NULL
   return value (in case driver_find_device fails) will cause the
   kernel to panic when omap_iommu_attach_dev() dereferences the
   pointer.
2. A try_module_get() failure returns a valid success value as
   returned from iommu_enable().

Both the above issues have been fixed up to return the proper
ERR_PTR.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index fff2ffd..647e4ba 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -863,7 +863,7 @@ static int device_match_by_alias(struct device *dev, void *data)
  **/
 static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 {
-	int err = -ENOMEM;
+	int err;
 	struct device *dev;
 	struct omap_iommu *obj;
 
@@ -871,7 +871,7 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 				(void *)name,
 				device_match_by_alias);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	obj = to_iommu(dev);
 
@@ -890,8 +890,10 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 		goto err_enable;
 	flush_iotlb_all(obj);
 
-	if (!try_module_get(obj->owner))
+	if (!try_module_get(obj->owner)) {
+		err = -ENODEV;
 		goto err_module;
+	}
 
 	spin_unlock(&obj->iommu_lock);
 
-- 
1.9.0
