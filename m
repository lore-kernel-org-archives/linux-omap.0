From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/3] omap iommu: kmemleak: Avoid false positive with special scan
Date: Thu, 20 May 2010 07:46:20 +0300
Message-ID: <1274330780-31764-4-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1274330780-31764-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56196 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0ETErP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 00:47:15 -0400
In-Reply-To: <1274330780-31764-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The fist level iommu page table address is registered with the address
conversion function for kmemleak special scan.

Depends on:
http://groups.google.co.jp/group/linux.kernel/browse_thread/thread/51de33be01acf4e2

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 341c481..3381070 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -875,6 +875,16 @@ void iommu_put(struct iommu *obj)
 }
 EXPORT_SYMBOL_GPL(iommu_put);
 
+static u32 kmemleak_special_conv(u32 orig)
+{
+	u32 *iopgd = (u32 *)orig;
+
+	if (!iopgd_is_table(*iopgd))
+		return NULL;
+
+	return iopgd_page_vaddr(iopgd);
+}
+
 /*
  *	OMAP Device MMU(IOMMU) detection
  */
@@ -948,6 +958,10 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 
 	BUG_ON(!IS_ALIGNED((unsigned long)obj->iopgd, IOPGD_TABLE_SIZE));
 
+	err = kmemleak_special_scan(p, IOPGD_TABLE_SIZE, kmemleak_special_conv);
+	if (err)
+		dev_warn(&pdev->dev, "kmemleak: failed to add special scan\n");
+
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
 
@@ -972,6 +986,7 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	iopgtable_clear_entry_all(obj);
+	kmemleak_no_special(obj->iopgd);
 	free_pages((unsigned long)obj->iopgd, get_order(IOPGD_TABLE_SIZE));
 
 	irq = platform_get_irq(pdev, 0);
-- 
1.7.1.rc1

