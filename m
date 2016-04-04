From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] iommu/omap: Remove iopgtable_clear_entry_all() from
	driver remove
Date: Mon, 4 Apr 2016 17:46:18 -0500
Message-ID: <1459809981-37984-2-git-send-email-s-anna@ti.com>
References: <1459809981-37984-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459809981-37984-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The function iopgtable_clear_entry_all() is used for clearing all
the page table entries. These entries are neither created nor
initialized during the OMAP IOMMU driver probe, and are managed
only when a client device attaches to the IOMMU. So, there is no
need to invoke this function on a driver remove.

Removing this fixes a NULL pointer dereference crash if the IOMMU
device is unbound from the driver with no client device attached
to the IOMMU device.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3dc5b65f3990..c05d48f88596 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -987,7 +987,6 @@ static int omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
-	iopgtable_clear_entry_all(obj);
 	omap_iommu_debugfs_remove(obj);
 
 	pm_runtime_disable(obj->dev);
-- 
2.7.4
