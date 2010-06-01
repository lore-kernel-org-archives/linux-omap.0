From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/8] omap iommu: Introduce iopgd_is_table MACRO
Date: Tue,  1 Jun 2010 08:30:41 +0300
Message-ID: <1275370247-15888-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51442 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab0FAFbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:31:24 -0400
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

A bit more strict comparison.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c     |    8 ++++----
 arch/arm/plat-omap/iopgtable.h |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index bc094db..341c481 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -653,7 +653,7 @@ void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd, u32 **ppte)
 	if (!*iopgd)
 		goto out;
 
-	if (*iopgd & IOPGD_TABLE)
+	if (iopgd_is_table(*iopgd))
 		iopte = iopte_offset(iopgd, da);
 out:
 	*ppgd = iopgd;
@@ -670,7 +670,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 	if (!*iopgd)
 		return 0;
 
-	if (*iopgd & IOPGD_TABLE) {
+	if (iopgd_is_table(*iopgd)) {
 		int i;
 		u32 *iopte = iopte_offset(iopgd, da);
 
@@ -745,7 +745,7 @@ static void iopgtable_clear_entry_all(struct iommu *obj)
 		if (!*iopgd)
 			continue;
 
-		if (*iopgd & IOPGD_TABLE)
+		if (iopgd_is_table(*iopgd))
 			iopte_free(iopte_offset(iopgd, 0));
 
 		*iopgd = 0;
@@ -785,7 +785,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 
 	iopgd = iopgd_offset(obj, da);
 
-	if (!(*iopgd & IOPGD_TABLE)) {
+	if (!iopgd_is_table(*iopgd)) {
 		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", __func__,
 			da, iopgd, *iopgd);
 		return IRQ_NONE;
diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/iopgtable.h
index ab23b6a..f2e6b64 100644
--- a/arch/arm/plat-omap/iopgtable.h
+++ b/arch/arm/plat-omap/iopgtable.h
@@ -63,6 +63,8 @@
 #define IOPGD_SECTION		(2 << 0)
 #define IOPGD_SUPER		(1 << 18 | 2 << 0)
 
+#define iopgd_is_table(x)	(((x) & 3) == IOPGD_TABLE)
+
 #define IOPTE_SMALL		(2 << 0)
 #define IOPTE_LARGE		(1 << 0)
 
-- 
1.7.1.rc1

