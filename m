From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 3/3] omap iommu: move iommu_disable at fault to the above layer
Date: Sun, 23 May 2010 21:01:52 -0500
Message-ID: <1274666512-19765-4-git-send-email-h-kanigeri2@ti.com>
References: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60969 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515Ab0EXBzK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 May 2010 21:55:10 -0400
In-Reply-To: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The function prefix "omap2_iommu_" indicates that the prefixed
function belongs to "omap2_iommu_ops" to provide iommu basic
functionalities for the above layers. It's better to avoid the
prefixed function called in the same prefixed ones internally, like
nested here. Now "iommu_disable" is called just after fault_isr() in
the above layer. This is a little bit more sensible to keep the
consistency of module layers.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 arch/arm/plat-omap/iommu.c   |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index edf7cd4..14ee686 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -172,7 +172,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	printk("\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
-	omap2_iommu_disable(obj);
+
 	return stat;
 }
 
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index aa064e1..344af31 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -782,6 +782,8 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!stat)
 		return IRQ_HANDLED;
 
+	iommu_disable(obj);
+
 	iopgd = iopgd_offset(obj, da);
 
 	if (!(*iopgd & IOPGD_TABLE)) {
-- 
1.7.0

