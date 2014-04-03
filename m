From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 1/6] iommu/omap: Correct init value of iotlb_entry valid
	field
Date: Thu,  3 Apr 2014 22:01:33 +0200
Message-ID: <1396555298-25246-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1396555298-25246-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

The iotlb_entry field values are used directly in omap2_alloc_cr,
a function used in preparing the MMU_CAM and MMU_RAM registers.
The iotlb_entry.valid value is being set incorrectly to 1 at the
moment, and this would result in overriding the PAGESIZE bit field
of the MMU_CAM register if prefetching of the entries were to be
supported.

The bug has not caused any MMU faults due to incorrect size
programming so far as the prefetching is disabled by default. Fix
this by using the correct init value for the iotlb_entry.valid
field.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8acea87..4716af1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1043,7 +1043,7 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
 
 	e->da		= da;
 	e->pa		= pa;
-	e->valid	= 1;
+	e->valid	= MMU_CAM_V;
 	/* FIXME: add OMAP1 support */
 	e->pgsz		= flags & MMU_CAM_PGSZ_MASK;
 	e->endian	= flags & MMU_RAM_ENDIAN_MASK;
-- 
1.8.3.2
