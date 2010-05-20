From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
Date: Thu, 20 May 2010 16:10:23 -0500
Message-ID: <1274389823-4051-3-git-send-email-h-kanigeri2@ti.com>
References: <1274389823-4051-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43145 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab0ETVEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 17:04:01 -0400
In-Reply-To: <1274389823-4051-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ramesh Gupta <grgupta@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

In order to enable TLB miss interrupt, the TWL should be
disabled. This patch provides the functionality to get the
MMU fault interrupt for a TLB miss in the cases where the
users are working with the locked TLB entries and with TWL
disabled.
New interface is added to select twl and to enable TLB miss
interrupt.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c            |   26 +++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 arch/arm/plat-omap/iommu.c              |   17 +++++++++++++++++
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index ebbdae2..3cfe1c4 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -65,6 +65,25 @@
 	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
 	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
 
+
+static void omap2_iommu_set_twl(struct iommu *obj, bool on)
+{
+	u32 l = iommu_read_reg(obj, MMU_CNTL);
+
+	if (on)
+		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
+	else
+		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
+
+	l &= ~MMU_CNTL_MASK;
+	if (on)
+		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
+	else
+		l |= (MMU_CNTL_MMU_EN);
+
+	iommu_write_reg(obj, l, MMU_CNTL);
+}
+
 static int omap2_iommu_enable(struct iommu *obj)
 {
 	u32 l, pa;
@@ -100,13 +119,9 @@ static int omap2_iommu_enable(struct iommu *obj)
 	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
 	iommu_write_reg(obj, l, MMU_SYSCONFIG);
 
-	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
 	iommu_write_reg(obj, pa, MMU_TTB);
 
-	l = iommu_read_reg(obj, MMU_CNTL);
-	l &= ~MMU_CNTL_MASK;
-	l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
-	iommu_write_reg(obj, l, MMU_CNTL);
+	omap2_iommu_set_twl(obj, true);
 
 	return 0;
 }
@@ -304,6 +319,7 @@ static const struct iommu_functions omap2_iommu_ops = {
 
 	.enable		= omap2_iommu_enable,
 	.disable	= omap2_iommu_disable,
+	.set_twl	= omap2_iommu_set_twl,
 	.fault_isr	= omap2_iommu_fault_isr,
 
 	.tlb_read_cr	= omap2_tlb_read_cr,
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 0752af9..33c7d41 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -80,6 +80,7 @@ struct iommu_functions {
 
 	int (*enable)(struct iommu *obj);
 	void (*disable)(struct iommu *obj);
+	void (*set_twl)(struct iommu *obj, bool on);
 	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
 
 	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
@@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
 extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
 
 extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
+extern void iommu_set_twl(struct iommu *obj, bool on);
 extern void flush_iotlb_page(struct iommu *obj, u32 da);
 extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
 extern void flush_iotlb_all(struct iommu *obj);
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b2b3937..aa064e1 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -370,6 +370,23 @@ void flush_iotlb_all(struct iommu *obj)
 }
 EXPORT_SYMBOL_GPL(flush_iotlb_all);
 
+/**
+ * iommu_set_twl - enable/disable table walking logic
+ * @obj:	target iommu
+ * @on:		enable/disable
+ *
+ * Function used to enable/disable TWL. If one wants to work
+ * exclusively with locked TLB entries and receive notifications
+ * for TLB miss then call this function to disable TWL.
+ */
+void iommu_set_twl(struct iommu *obj, bool on)
+{
+	clk_enable(obj->clk);
+	arch_iommu->set_twl(obj, on);
+	clk_disable(obj->clk);
+}
+EXPORT_SYMBOL_GPL(iommu_set_twl);
+
 #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
 
 ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
-- 
1.7.0

