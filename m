From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/11] iommu/omap: Remove unused union fields
Date: Mon, 20 Jul 2015 17:33:27 -0500
Message-ID: <1437431613-55656-6-git-send-email-s-anna@ti.com>
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

There are couple of unions defined in the structures
iotlb_entry and cr_regs. There are no usage/references
to some of these union fields in the code, so clean
them up and simplify the structures.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.h | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index b6cc90b2ba41..5b98408c18bf 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -22,12 +22,7 @@ struct iotlb_entry {
 	u32 da;
 	u32 pa;
 	u32 pgsz, prsvd, valid;
-	union {
-		u16 ap;
-		struct {
-			u32 endian, elsz, mixed;
-		};
-	};
+	u32 endian, elsz, mixed;
 };
 
 struct omap_iommu {
@@ -54,20 +49,8 @@ struct omap_iommu {
 };
 
 struct cr_regs {
-	union {
-		struct {
-			u16 cam_l;
-			u16 cam_h;
-		};
-		u32 cam;
-	};
-	union {
-		struct {
-			u16 ram_l;
-			u16 ram_h;
-		};
-		u32 ram;
-	};
+	u32 cam;
+	u32 ram;
 };
 
 struct iotlb_lock {
-- 
2.4.4
