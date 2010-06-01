From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 6/8] omap iommu: add functionality to get TLB miss interrupt
Date: Tue,  1 Jun 2010 08:30:45 +0300
Message-ID: <1275370247-15888-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33954 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0FAFct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:32:49 -0400
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ramesh Gupta <grgupta@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

In order to enable TLB miss interrupt, the TWL should be
disabled. This patch provides the functionality to get the
MMU fault interrupt for a TLB miss in the cases where the
users are working with the locked TLB entries and with TWL
disabled.
New interface is added to select twl and to enable TLB miss
interrupt.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c            |   32 ++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/iommu.h |    2 +
 arch/arm/plat-omap/iommu.c              |   17 ++++++++++++++++
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index ebbdae2..edf7cd4 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -65,6 +65,26 @@
 	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
 	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
 
+
+static void __iommu_set_twl(struct iommu *obj, bool on)
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
+
 static int omap2_iommu_enable(struct iommu *obj)
 {
 	u32 l, pa;
@@ -100,13 +120,9 @@ static int omap2_iommu_enable(struct iommu *obj)
 	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
 	iommu_write_reg(obj, l, MMU_SYSCONFIG);
 
-	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
 	iommu_write_reg(obj, pa, MMU_TTB);
 
-	l = iommu_read_reg(obj, MMU_CNTL);
-	l &= ~MMU_CNTL_MASK;
-	l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
-	iommu_write_reg(obj, l, MMU_CNTL);
+	__iommu_set_twl(obj, true);
 
 	return 0;
 }
@@ -122,6 +138,11 @@ static void omap2_iommu_disable(struct iommu *obj)
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
 
+static void omap2_iommu_set_twl(struct iommu *obj, bool on)
+{
+	__iommu_set_twl(obj, false);
+}
+
 static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 {
 	int i;
@@ -304,6 +325,7 @@ static const struct iommu_functions omap2_iommu_ops = {
 
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
index 341c481..688ae66 100644
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
1.7.1.rc1

