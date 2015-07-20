From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/11] iommu/omap: Split multiple assignments into separate
	lines
Date: Mon, 20 Jul 2015 17:33:33 -0500
Message-ID: <1437431613-55656-12-git-send-email-s-anna@ti.com>
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

Use separate assignments for assigning the same value into
different variables. This fixes the following check warning
generated with the checkpatch --strict option:
    "CHECK: multiple assignments should be avoided"

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 36d0033c2ccb..fe742c01a4f2 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1044,7 +1044,8 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out;
 	}
 
-	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
+	omap_domain->iommu_dev = oiommu;
+	arch_data->iommu_dev = oiommu;
 	omap_domain->dev = dev;
 	oiommu->domain = domain;
 
@@ -1069,7 +1070,8 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 
 	omap_iommu_detach(oiommu);
 
-	omap_domain->iommu_dev = arch_data->iommu_dev = NULL;
+	omap_domain->iommu_dev = NULL;
+	arch_data->iommu_dev = NULL;
 	omap_domain->dev = NULL;
 	oiommu->domain = NULL;
 }
-- 
2.4.4
