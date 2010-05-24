From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 1/3] omap: iommu-update irq mask to be specific about twl and tlb
Date: Sun, 23 May 2010 21:01:50 -0500
Message-ID: <1274666512-19765-2-git-send-email-h-kanigeri2@ti.com>
References: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab0EXBzK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 May 2010 21:55:10 -0400
In-Reply-To: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Revise the IRQ mask definitions to handle the  MMU faults related
to TWL fault as well as TLB miss fault.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index e82da68..ebbdae2 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -44,9 +44,13 @@
 #define MMU_IRQ_EMUMISS		(1 << 2)
 #define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
 #define MMU_IRQ_TLBMISS		(1 << 0)
-#define MMU_IRQ_MASK	\
-	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS | \
-	 MMU_IRQ_TRANSLATIONFAULT)
+
+#define __MMU_IRQ_FAULT		\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS | MMU_IRQ_TRANSLATIONFAULT)
+#define MMU_IRQ_MASK		\
+	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_TLBMISS)
+#define MMU_IRQ_TWL_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT)
+#define MMU_IRQ_TLB_MISS_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TLBMISS)
 
 /* MMU_CNTL */
 #define MMU_CNTL_SHIFT		1
@@ -96,7 +100,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
 	iommu_write_reg(obj, l, MMU_SYSCONFIG);
 
-	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
+	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
 	iommu_write_reg(obj, pa, MMU_TTB);
 
 	l = iommu_read_reg(obj, MMU_CNTL);
-- 
1.7.0

