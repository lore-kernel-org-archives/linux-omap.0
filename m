From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 4/6] ARM: OMAP: iommu: optimize save and restore routines
Date: Thu, 11 Oct 2012 20:06:13 -0500
Message-ID: <1350003977-32744-9-git-send-email-omar.luna@linaro.org>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35549 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2JLBGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 21:06:44 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2412118oag.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 18:06:43 -0700 (PDT)
In-Reply-To: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org

These functions save and restore registers irrespectively of their
read or write permissions, this ends up in registers being saved
that can't be restored because of read only attributes. OTOH, so
far only 3 of them need to be saved.

In future GP_REG (which is present only on OMAP4 ipu) needs to be
saved but right now there is no API that can alter its value. Also,
protected TLB entries must be saved but this can be in a separate
patch as the original code didn't implement the loop to traverse
protected TLB entries.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/iommu2.c             |   38 ++++++++++++++----------------
 arch/arm/plat-omap/include/plat/iommu.h  |   10 +++++++-
 arch/arm/plat-omap/include/plat/iommu2.h |    2 --
 drivers/iommu/omap-iommu.c               |    3 +--
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 3e47786..cd77abb 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -19,6 +19,7 @@
 #include <linux/stringify.h>
 
 #include <plat/iommu.h>
+#include <plat/omap-pm.h>
 
 /*
  * omap2 architecture specific register bit definitions
@@ -55,20 +56,26 @@
 
 static void __iommu_set_twl(struct omap_iommu *obj, bool on)
 {
-	u32 l = iommu_read_reg(obj, MMU_CNTL);
+	u32 l;
 
 	if (on)
-		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
+		l = MMU_IRQ_TWL_MASK;
 	else
-		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
+		l = MMU_IRQ_TLB_MISS_MASK;
+
+	iommu_write_reg(obj, l, MMU_IRQENABLE);
+	obj->context.irqen = l;
 
+	l = iommu_read_reg(obj, MMU_CNTL);
 	l &= ~MMU_CNTL_MASK;
+
 	if (on)
 		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
 	else
 		l |= (MMU_CNTL_MMU_EN);
 
 	iommu_write_reg(obj, l, MMU_CNTL);
+	obj->context.cntl = l;
 }
 
 
@@ -88,6 +95,7 @@ static int omap2_iommu_enable(struct omap_iommu *obj)
 		 (l >> 4) & 0xf, l & 0xf);
 
 	iommu_write_reg(obj, pa, MMU_TTB);
+	obj->context.ttb = pa;
 
 	__iommu_set_twl(obj, true);
 
@@ -100,6 +108,7 @@ static void omap2_iommu_disable(struct omap_iommu *obj)
 
 	l &= ~MMU_CNTL_MASK;
 	iommu_write_reg(obj, l, MMU_CNTL);
+	obj->context.cntl = l;
 
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
@@ -249,28 +258,17 @@ out:
 
 static void omap2_iommu_save_ctx(struct omap_iommu *obj)
 {
-	int i;
-	u32 *p = obj->ctx;
-
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		p[i] = iommu_read_reg(obj, i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
-	}
-
-	BUG_ON(p[0] != IOMMU_ARCH_VERSION);
+	obj->ctx_loss_cnt = omap_pm_get_dev_context_loss_count(obj->dev);
 }
 
 static void omap2_iommu_restore_ctx(struct omap_iommu *obj)
 {
-	int i;
-	u32 *p = obj->ctx;
-
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		iommu_write_reg(obj, p[i], i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
-	}
+	if (omap_pm_get_dev_context_loss_count(obj->dev) == obj->ctx_loss_cnt)
+		return;
 
-	BUG_ON(p[0] != IOMMU_ARCH_VERSION);
+	iommu_write_reg(obj, obj->context.ttb, MMU_TTB);
+	iommu_write_reg(obj, obj->context.irqen, MMU_IRQENABLE);
+	iommu_write_reg(obj, obj->context.cntl, MMU_CNTL);
 }
 
 static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 902d193..af14486 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -27,6 +27,13 @@ struct iotlb_entry {
 	};
 };
 
+/* context registers */
+struct iommu_regs {
+	u32 irqen;
+	u32 cntl;
+	u32 ttb;
+};
+
 struct omap_iommu {
 	const char	*name;
 	struct module	*owner;
@@ -50,7 +57,8 @@ struct omap_iommu {
 	struct list_head	mmap;
 	struct mutex		mmap_lock; /* protect mmap */
 
-	void *ctx; /* iommu context: registres saved area */
+	struct iommu_regs context;
+	int ctx_loss_cnt;
 	u32 da_start;
 	u32 da_end;
 };
diff --git a/arch/arm/plat-omap/include/plat/iommu2.h b/arch/arm/plat-omap/include/plat/iommu2.h
index 1579694..bc43d41 100644
--- a/arch/arm/plat-omap/include/plat/iommu2.h
+++ b/arch/arm/plat-omap/include/plat/iommu2.h
@@ -35,8 +35,6 @@
 #define MMU_READ_RAM		0x6c
 #define MMU_EMU_FAULT_AD	0x70
 
-#define MMU_REG_SIZE		256
-
 /*
  * MMU Register bit definitions
  */
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 875e894..e266ad7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -924,14 +924,13 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
 	if (!obj)
 		return -ENOMEM;
 
 	obj->nr_tlb_entries = pdata->nr_tlb_entries;
 	obj->name = pdata->name;
 	obj->dev = &pdev->dev;
-	obj->ctx = (void *)obj + sizeof(*obj);
 	obj->da_start = pdata->da_start;
 	obj->da_end = pdata->da_end;
 
-- 
1.7.9.5

