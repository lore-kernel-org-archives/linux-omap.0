From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] ARM: OMAP2+: Remove omap_mmu_dev_attr structure
Date: Wed, 16 Sep 2015 18:48:22 -0500
Message-ID: <1442447302-5246-5-git-send-email-s-anna@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442447302-5246-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The structure omap_mmu_dev_attr was used in the hwmod data for
supplying device-specific data through the .dev_attr field and
used in constructing the platform data for legacy device creation.
The legacy device creation of OMAP IOMMU devices has been cleaned
up, and this structure is no longer needed, so remove it.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 include/linux/platform_data/iommu-omap.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 54a0a9582fad..0496d171700a 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -29,15 +29,6 @@ struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
 };
 
-/**
- * struct omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
- * @nr_tlb_entries:	number of entries supported by the translation
- *			look-aside buffer (TLB).
- */
-struct omap_mmu_dev_attr {
-	int nr_tlb_entries;
-};
-
 struct iommu_platform_data {
 	const char *name;
 	const char *reset_name;
-- 
2.5.0
