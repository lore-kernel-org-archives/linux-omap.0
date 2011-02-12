From: David Cohen <dacohen@gmail.com>
Subject: [RFC/PATCH 3/3] OMAP: IOMMU: add support to callback during fault handling
Date: Sat, 12 Feb 2011 12:42:53 +0200
Message-ID: <1297507373-1520-4-git-send-email-dacohen@gmail.com>
References: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57093 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab1BLKnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:43:08 -0500
Received: by eye27 with SMTP id 27so1724890eye.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:43:06 -0800 (PST)
In-Reply-To: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, David Cohen <dacohen@gmail.com>

Add support to register a callback for IOMMU fault situations. Drivers using
IOMMU module might want to be informed when such errors happen in order to
debug it or react.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/mach-omap2/iommu2.c            |   21 +++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h |    8 +++++-
 arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 641f54a..d3f7871 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -143,10 +143,10 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
 	__iommu_set_twl(obj, false);
 }
 
-static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
+static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *iommu_errs)
 {
 	int i;
-	u32 stat, da;
+	u32 stat, da, errs;
 	const char *err_msg[] =	{
 		"tlb miss",
 		"translation fault",
@@ -157,8 +157,10 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 
 	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
 	stat &= MMU_IRQ_MASK;
-	if (!stat)
+	if (!stat) {
+		*iommu_errs = 0;
 		return 0;
+	}
 
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
@@ -171,6 +173,19 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	}
 	printk("\n");
 
+	errs = 0;
+	if (stat & MMU_IRQ_TLBMISS)
+		errs |= OMAP_IOMMU_ERR_TLB_MISS;
+	if (stat & MMU_IRQ_TRANSLATIONFAULT)
+		errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
+	if (stat & MMU_IRQ_EMUMISS)
+		errs |= OMAP_IOMMU_ERR_EMU_MISS;
+	if (stat & MMU_IRQ_TABLEWALKFAULT)
+		errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
+	if (stat & MMU_IRQ_MULTIHITFAULT)
+		errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
+	*iommu_errs = errs;
+
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
 
 	return stat;
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 71f369d..9e8c104 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -31,6 +31,7 @@ struct iommu {
 	struct clk	*clk;
 	void __iomem	*regbase;
 	struct device	*dev;
+	void		*fault_cb_priv;
 
 	unsigned int	refcount;
 	struct mutex	iommu_lock;	/* global for this whole object */
@@ -48,6 +49,7 @@ struct iommu {
 	struct mutex		mmap_lock; /* protect mmap */
 
 	int (*isr)(struct iommu *obj);
+	void (*fault_cb)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);
 
 	void *ctx; /* iommu context: registres saved area */
 	u32 da_start;
@@ -83,7 +85,7 @@ struct iommu_functions {
 	int (*enable)(struct iommu *obj);
 	void (*disable)(struct iommu *obj);
 	void (*set_twl)(struct iommu *obj, bool on);
-	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
+	u32 (*fault_isr)(struct iommu *obj, u32 *ra, u32 *iommu_errs);
 
 	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
 	void (*tlb_load_cr)(struct iommu *obj, struct cr_regs *cr);
@@ -166,6 +168,10 @@ extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
 extern struct iommu *iommu_get(const char *name);
 extern void iommu_put(struct iommu *obj);
+extern int iommu_set_fault_callback(const char *name,
+				    void (*fault_cb)(struct iommu *obj, u32 da,
+						     u32 errs, void *priv),
+				    void *fault_cb_priv);
 
 extern void iommu_save_ctx(struct iommu *obj);
 extern void iommu_restore_ctx(struct iommu *obj);
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index f55f458..7761eab 100644
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
@@ -780,7 +780,7 @@ static void iopgtable_clear_entry_all(struct iommu *obj)
  */
 static irqreturn_t iommu_fault_handler(int irq, void *data)
 {
-	u32 stat, da;
+	u32 stat, da, errs;
 	u32 *iopgd, *iopte;
 	int err = -EIO;
 	struct iommu *obj = data;
@@ -796,11 +796,17 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 		return IRQ_HANDLED;
 
 	clk_enable(obj->clk);
-	stat = iommu_report_fault(obj, &da);
+	stat = iommu_report_fault(obj, &da, &errs);
 	clk_disable(obj->clk);
 	if (!stat)
 		return IRQ_HANDLED;
 
+	if (obj->fault_cb) {
+		obj->fault_cb(obj, da, errs, obj->fault_cb_priv);
+		/* No need to print error message as callback is called */
+		return IRQ_NONE;
+	}
+
 	iommu_disable(obj);
 
 	iopgd = iopgd_offset(obj, da);
@@ -917,6 +923,33 @@ void iommu_put(struct iommu *obj)
 }
 EXPORT_SYMBOL_GPL(iommu_put);
 
+int iommu_set_fault_callback(const char *name,
+			     void (*fault_cb)(struct iommu *obj, u32 da,
+					      u32 iommu_errs, void *priv),
+			     void *fault_cb_priv)
+{
+	struct device *dev;
+	struct iommu *obj;
+
+	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
+				 device_match_by_alias);
+	if (!dev)
+		return -ENODEV;
+
+	obj = to_iommu(dev);
+	mutex_lock(&obj->iommu_lock);
+	if (obj->refcount != 0) {
+		mutex_unlock(&obj->iommu_lock);
+		return -EBUSY;
+	}
+	obj->fault_cb = fault_cb;
+	obj->fault_cb_priv = fault_cb_priv;
+	mutex_unlock(&obj->iommu_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_set_fault_callback);
+
 /*
  *	OMAP Device MMU(IOMMU) detection
  */
-- 
1.7.1

