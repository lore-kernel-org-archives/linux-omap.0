From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 4/7] omap: iommu: PREFETCH_IOTLB cleanup
Date: Wed, 24 Aug 2011 20:08:11 +0300
Message-ID: <1314205694-28935-5-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54580 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1HXRJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 13:09:08 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so1445872wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 10:09:07 -0700 (PDT)
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Use PREFETCH_IOTLB to control the content of the called function,
instead of inlining it in the code.

This improves readability of the code, and also prevents an "unused
function" warning to show up when PREFETCH_IOTLB isn't set.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/iommu/omap-iommu.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3aad2e3..966093a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -253,6 +253,7 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
+#ifdef PREFETCH_IOTLB
 static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
@@ -310,6 +311,20 @@ out:
 	return err;
 }
 
+#else /* !PREFETCH_IOTLB */
+
+static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return 0;
+}
+
+#endif /* !PREFETCH_IOTLB */
+
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return load_iotlb_entry(obj, e);
+}
+
 /**
  * flush_iotlb_page - Clear an iommu tlb entry
  * @obj:	target iommu
@@ -663,10 +678,8 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 
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

