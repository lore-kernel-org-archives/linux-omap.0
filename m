From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
Date: Thu, 18 Aug 2011 02:10:05 +0300
Message-ID: <1313622608-30397-5-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63099 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1HQXKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Aug 2011 19:10:47 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so1482308wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 16:10:46 -0700 (PDT)
In-Reply-To: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Use PREFETCH_IOTLB to control the content of the called function,
instead of inlining it in the code.

This improves readability of the code, and also prevents an "unused
function" warning to show up when PREFETCH_IOTLB isn't set.

While we're at it, rename load_iotlb_entry to prefetch_iotlb_entry
to better reflect the purpose of that function.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ed81977..7280e5b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -248,11 +248,12 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
 }
 
 /**
- * load_iotlb_entry - Set an iommu tlb entry
+ * prefetch_iotlb_entry - Set an iommu tlb entry
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+#ifdef PREFETCH_IOTLB
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
 	struct iotlb_lock l;
@@ -309,6 +310,15 @@ out:
 	return err;
 }
 
+#else /* !PREFETCH_IOTLB */
+
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return 0;
+}
+
+#endif /* !PREFETCH_IOTLB */
+
 /**
  * flush_iotlb_page - Clear an iommu tlb entry
  * @obj:	target iommu
@@ -662,10 +672,8 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 
 	flush_iotlb_page(obj, e->da);
 	err = iopgtable_store_entry_core(obj, e);
-#ifdef PREFETCH_IOTLB
 	if (!err)
-		load_iotlb_entry(obj, e);
-#endif
+		prefetch_iotlb_entry(obj, e);
 	return err;
 }
 EXPORT_SYMBOL_GPL(iopgtable_store_entry);
-- 
1.7.4.1

