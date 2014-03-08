From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 2/5] iommu/omap: Fix 'no page for' debug message in
	flush_iotlb_page()
Date: Sat,  8 Mar 2014 01:46:11 +0100
Message-ID: <1394239574-2389-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The flush_iotlb_page() function prints a debug message when no
corresponding page was found in the TLB. That condition is incorrectly
checked and always resolves to true, given that the for_each_iotlb_cr()
loop is never interrupted and always reaches obj->nr_tlb_entries.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bb605c9..cb1e1de 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -376,6 +376,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 {
 	int i;
 	struct cr_regs cr;
+	bool found = false;
 
 	pm_runtime_get_sync(obj->dev);
 
@@ -394,11 +395,12 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 				__func__, start, da, bytes);
 			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
+			found = true;
 		}
 	}
 	pm_runtime_put_sync(obj->dev);
 
-	if (i == obj->nr_tlb_entries)
+	if (!found)
 		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
 }
 
-- 
1.8.3.2
