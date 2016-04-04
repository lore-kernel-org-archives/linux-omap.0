From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] iommu/omap: Use WARN_ON for page table alignment check
Date: Mon, 4 Apr 2016 17:46:20 -0500
Message-ID: <1459809981-37984-4-git-send-email-s-anna@ti.com>
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

The OMAP IOMMU page table needs to be aligned on a 16K boundary,
and the current code uses a BUG_ON on the alignment sanity check
in the .domain_alloc() ops implementation. Replace this with a
less severe WARN_ON and bail out gracefully.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index f6cf728ee32a..e2583cce2cc1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1162,7 +1162,8 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 	 * should never fail, but please keep this around to ensure
 	 * we keep the hardware happy
 	 */
-	BUG_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE));
+	if (WARN_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE)))
+		goto fail_align;
 
 	clean_dcache_area(omap_domain->pgtable, IOPGD_TABLE_SIZE);
 	spin_lock_init(&omap_domain->lock);
@@ -1173,6 +1174,8 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 
 	return &omap_domain->domain;
 
+fail_align:
+	kfree(omap_domain->pgtable);
 fail_nomem:
 	kfree(omap_domain);
 out:
-- 
2.7.4
