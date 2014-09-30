From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/17] iommu/omap: Remove duplicate declarations
Date: Tue, 30 Sep 2014 16:15:58 -0500
Message-ID: <1412111772-38006-4-git-send-email-s-anna@ti.com>
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

The omap_iommu_save_ctx() and omap_iommu_restore_ctx() declarations
are defined in include/linux/omap-iommu.h and do not belong in the
internal drivers/iommu/omap-iommu.h header, so remove them.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 18a0f3a..4fc51c8 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -197,9 +197,6 @@ extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
 extern int
 omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 
-extern void omap_iommu_save_ctx(struct device *dev);
-extern void omap_iommu_restore_ctx(struct device *dev);
-
 extern int omap_foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));
 
-- 
2.1.0
