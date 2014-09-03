From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] iommu/omap: Check for valid archdata in attach_dev
Date: Wed, 3 Sep 2014 18:58:31 -0500
Message-ID: <1409788712-10741-2-git-send-email-s-anna@ti.com>
References: <1409788712-10741-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409788712-10741-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Any device requiring to be attached to an iommu_domain must have
valid archdata containing the necessary iommu information, which
is SoC-specific. Add a check in the omap_iommu_attach_dev to make
sure that the device has non-NULL archdata before accessing
different SoC-specific fields of the archdata. This prevents a
NULL pointer dereference on any misconfigured devices.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 02ef0ac..f245d51 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1092,6 +1092,12 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	spin_lock(&omap_domain->lock);
 
+	if (!arch_data) {
+		dev_err(dev, "device doesn't have an associated iommu\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* only a single device is supported per domain for now */
 	if (omap_domain->iommu_dev) {
 		dev_err(dev, "iommu domain is already attached\n");
-- 
2.0.4
