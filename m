From: David Cohen <david.cohen@nokia.com>
Subject: [PATCH 2/2] OMAP: Cleanup IOMMU error messages
Date: Mon, 31 Jan 2011 19:25:08 +0200
Message-ID: <1296494708-17569-3-git-send-email-david.cohen@nokia.com>
References: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:64865 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222Ab1AaRZb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 12:25:31 -0500
In-Reply-To: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, David Cohen <david.cohen@nokia.com>

IOMMU error messages are duplicated. They're printed on IOMMU specific
layer for OMAP2,3 and once again on the above layer. With this patch,
the error message is printed on the above layer only.

Signed-off-by: David Cohen <david.cohen@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c            |   33 +++++++++++++--------------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +-
 arch/arm/plat-omap/iommu.c              |   36 ++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 14ee686..bb3d75b 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -143,33 +143,32 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
 	__iommu_set_twl(obj, false);
 }
 
-static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
+static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *iommu_errs)
 {
-	int i;
+	u32 errs = 0;
 	u32 stat, da;
-	const char *err_msg[] =	{
-		"tlb miss",
-		"translation fault",
-		"emulation miss",
-		"table walk fault",
-		"multi hit fault",
-	};
 
 	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
 	stat &= MMU_IRQ_MASK;
-	if (!stat)
+	if (!stat) {
+		*iommu_errs = 0;
 		return 0;
+	}
 
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
 
-	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
-
-	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
-		if (stat & (1 << i))
-			printk("%s ", err_msg[i]);
-	}
-	printk("\n");
+	if (stat & MMU_IRQ_TLBMISS)
+		errs |= IOMMU_ERR_TLB_MISS;
+	if (stat & MMU_IRQ_TRANSLATIONFAULT)
+		errs |= IOMMU_ERR_TRANS_FAULT;
+	if (stat & MMU_IRQ_EMUMISS)
+		errs |= IOMMU_ERR_EMU_MISS;
+	if (stat & MMU_IRQ_TABLEWALKFAULT)
+		errs |= IOMMU_ERR_TBLWALK_FAULT;
+	if (stat & MMU_IRQ_MULTIHITFAULT)
+		errs |= IOMMU_ERR_MULTIHIT_FAULT;
+	*iommu_errs = errs;
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index c653fd7..267c5b5 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -83,7 +83,7 @@ struct iommu_functions {
 	int (*enable)(struct iommu *obj);
 	void (*disable)(struct iommu *obj);
 	void (*set_twl)(struct iommu *obj, bool on);
-	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
+	u32 (*fault_isr)(struct iommu *obj, u32 *ra, u32 *iommu_errs);
 
 	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
 	void (*tlb_load_cr)(struct iommu *obj, struct cr_regs *cr);
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b1107c0..c7c37a0 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -163,9 +163,9 @@ static u32 get_iopte_attr(struct iotlb_entry *e)
 	return arch_iommu->get_pte_attr(e);
 }
 
-static u32 iommu_report_fault(struct iommu *obj, u32 *da)
+static u32 iommu_report_fault(struct iommu *obj, u32 *da, u32 *iommu_errs)
 {
-	return arch_iommu->fault_isr(obj, da);
+	return arch_iommu->fault_isr(obj, da, iommu_errs);
 }
 
 static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
@@ -780,10 +780,18 @@ static void iopgtable_clear_entry_all(struct iommu *obj)
  */
 static irqreturn_t iommu_fault_handler(int irq, void *data)
 {
-	u32 stat, da;
+	int i;
+	u32 stat, da, errs;
 	u32 *iopgd, *iopte;
 	int err = -EIO;
 	struct iommu *obj = data;
+	const char *err_msg[] =	{
+		"tlb miss",
+		"translation fault",
+		"emulation miss",
+		"table walk fault",
+		"multi hit fault",
+	};
 
 	if (!obj->refcount)
 		return IRQ_NONE;
@@ -796,7 +804,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 		return IRQ_HANDLED;
 
 	clk_enable(obj->clk);
-	stat = iommu_report_fault(obj, &da);
+	stat = iommu_report_fault(obj, &da, &errs);
 	clk_disable(obj->clk);
 	if (!stat)
 		return IRQ_HANDLED;
@@ -805,16 +813,20 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 
 	iopgd = iopgd_offset(obj, da);
 
-	if (!iopgd_is_table(*iopgd)) {
-		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", __func__,
-			da, iopgd, *iopgd);
-		return IRQ_NONE;
+	if (iopgd_is_table(*iopgd)) {
+		iopte = iopte_offset(iopgd, da);
+		dev_err(obj->dev, "da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x :",
+			da, iopgd, *iopgd, iopte, *iopte);
+	} else {
+		dev_err(obj->dev, "da:%08x pgd:%p *pgd:%08x :", da, iopgd,
+			*iopgd);
 	}
 
-	iopte = iopte_offset(iopgd, da);
-
-	dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
-		__func__, da, iopgd, *iopgd, iopte, *iopte);
+	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
+		if (errs & (1 << i))
+			printk(KERN_CONT " %s", err_msg[i]);
+	}
+	printk("\n");
 
 	return IRQ_NONE;
 }
-- 
1.7.1

