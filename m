From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 5/6] iommu/omap: Remove comment about supporting single
	page mappings only
Date: Thu,  3 Apr 2014 22:01:37 +0200
Message-ID: <1396555298-25246-6-git-send-email-laurent.pinchart@ideasonboard.com>
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

The IOMMU core breaks out mappings into pages already, there's no
need to support mapping multiple pages in one go.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Reviewed-by: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 428b47a..a47dbdc 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1067,7 +1067,6 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	int omap_pgsz;
 	u32 ret, flags;
 
-	/* we only support mapping a single iommu page for now */
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
 		dev_err(dev, "invalid size to map: %d\n", bytes);
-- 
1.8.3.2
