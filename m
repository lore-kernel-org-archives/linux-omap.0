From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/6] ARM: OMAP: iommu: fix including iommu.h without IOMMU_API
	selected
Date: Fri, 15 Jun 2012 20:55:59 -0500
Message-ID: <1339811764-5337-2-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If included without IOMMU_API being selected it will break
compilation:

arch/arm/plat-omap/include/plat/iommu.h:
	In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:148:
	error: 'struct dev_archdata' has no member named 'iommu'

This will be seen, when hwmod includes iommu.h to get the
structure for attributes.

Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 88be3e6..e58d571 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -126,6 +126,7 @@ struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
 };
 
+#ifdef CONFIG_IOMMU_API
 /**
  * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
  * @dev: iommu client device
@@ -136,6 +137,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 
 	return arch_data->iommu_dev;
 }
+#endif
 
 /* IOMMU errors */
 #define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
-- 
1.7.4.1
