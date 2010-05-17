From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 1/2] omap: iommu-update irq mask to be specific about twl
Date: Mon, 17 May 2010 18:12:29 -0500
Message-ID: <1274137950-18759-2-git-send-email-h-kanigeri2@ti.com>
References: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60555 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070Ab0EQXGa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 May 2010 19:06:30 -0400
In-Reply-To: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Update the irq mask so that is is clear that the MMU
interrupt is related to TWL fault.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index e82da68..fcf4f4a 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -46,7 +46,13 @@
 #define MMU_IRQ_TLBMISS		(1 << 0)
 #define MMU_IRQ_MASK	\
 	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS | \
-	 MMU_IRQ_TRANSLATIONFAULT)
+	  MMU_IRQ_TRANSLATIONFAULT | MMU_IRQ_TLBMISS)
+#define MMU_IRQ_TWL_MASK	\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS | \
+	  MMU_IRQ_TRANSLATIONFAULT)
+#define MMU_IRQ_TLB_MISS_MASK	\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TLBMISS | MMU_IRQ_EMUMISS | \
+	  MMU_IRQ_TRANSLATIONFAULT)
 
 /* MMU_CNTL */
 #define MMU_CNTL_SHIFT		1
@@ -96,7 +102,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
 	iommu_write_reg(obj, l, MMU_SYSCONFIG);
 
-	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
+	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
 	iommu_write_reg(obj, pa, MMU_TTB);
 
 	l = iommu_read_reg(obj, MMU_CNTL);
-- 
1.7.0

