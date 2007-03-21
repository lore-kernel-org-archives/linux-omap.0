From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/2] ARM:OMAP: Add interrupt handling interface in MMU FWK
Date: Wed, 21 Mar 2007 09:43:13 +0200
Message-ID: <11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This adds the entry point in omap mmu framework to handle mmu
interrupt. Users of this framework can use its workqueue interface in
order to accomplish their irq-driven work.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.c       |   66 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/mmu.h       |    4 +-
 arch/arm/mach-omap2/mmu.c       |   22 +++++++++++++
 arch/arm/mach-omap2/mmu.h       |    6 ++-
 arch/arm/plat-omap/mmu.c        |   23 +++++++++++++-
 include/asm-arm/arch-omap/mmu.h |    8 +++++
 6 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 7417124..789783c 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -260,6 +260,71 @@ static inline int omap1_mmu_cam_ram_valid(struct cam_ram_regset *cr)
 	return cr->cam_l & OMAP_MMU_CAM_V;
 }
 
+static void omap1_mmu_interrupt(struct omap_mmu *mmu)
+{
+	unsigned long status;
+	unsigned long adh, adl;
+	unsigned long dp;
+	unsigned long va;
+
+	status = omap_mmu_read_reg(mmu, MMU_FAULT_ST);
+	adh = omap_mmu_read_reg(mmu, MMU_FAULT_AD_H);
+	adl = omap_mmu_read_reg(mmu, MMU_FAULT_AD_L);
+	dp = adh & MMU_FAULT_AD_H_DP;
+	va = MK32(adh & MMU_FAULT_AD_H_ADR_MASK, adl);
+
+	/* if the fault is masked, nothing to do */
+	if ((status & MMUFAULT_MASK) == 0) {
+		pr_debug( "MMU interrupt, but ignoring.\n");
+		/*
+		 * note: in OMAP1710,
+		 * when CACHE + DMA domain gets out of idle in DSP,
+		 * MMU interrupt occurs but MMU_FAULT_ST is not set.
+		 * in this case, we just ignore the interrupt.
+		 */
+		if (status) {
+			pr_debug( "%s%s%s%s\n",
+				  (status & MMU_FAULT_ST_PREF)?
+				  "  (prefetch err)" : "",
+				  (status & MMU_FAULT_ST_PERM)?
+				  "  (permission fault)" : "",
+				  (status & MMU_FAULT_ST_TLB_MISS)?
+				  "  (TLB miss)" : "",
+				  (status & MMU_FAULT_ST_TRANS) ?
+				  "  (translation fault)": "");
+			pr_debug( "fault address = %#08x\n", va);
+		}
+		enable_irq(mmu->irq);
+		return;
+	}
+
+	pr_info("%s%s%s%s\n",
+		(status & MMU_FAULT_ST_PREF)?
+		(MMUFAULT_MASK & MMU_FAULT_ST_PREF)?
+		"  prefetch err":
+		"  (prefetch err)":
+		"",
+		(status & MMU_FAULT_ST_PERM)?
+		(MMUFAULT_MASK & MMU_FAULT_ST_PERM)?
+		"  permission fault":
+		"  (permission fault)":
+		"",
+		(status & MMU_FAULT_ST_TLB_MISS)?
+		(MMUFAULT_MASK & MMU_FAULT_ST_TLB_MISS)?
+		"  TLB miss":
+		"  (TLB miss)":
+		"",
+		(status & MMU_FAULT_ST_TRANS)?
+		(MMUFAULT_MASK & MMU_FAULT_ST_TRANS)?
+		"  translation fault":
+		"  (translation fault)":
+		"");
+	pr_info("fault address = %#08x\n", va);
+
+	mmu->fault_address = va;
+	schedule_work(&mmu->irq_work);
+}
+
 struct omap_mmu_ops omap1_mmu_ops = {
 	.startup	= omap1_mmu_startup,
 	.shutdown	= omap1_mmu_shutdown,
@@ -271,5 +336,6 @@ struct omap_mmu_ops omap1_mmu_ops = {
 	.cam_va		= omap1_mmu_cam_va,
 	.cam_ram_alloc	= omap1_mmu_cam_ram_alloc,
 	.cam_ram_valid	= omap1_mmu_cam_ram_valid,
+	.interrupt	= omap1_mmu_interrupt,
 };
 EXPORT_SYMBOL_GPL(omap1_mmu_ops);
diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 3acbb84..9bda297 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -110,7 +110,7 @@ omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
 	return __raw_readw(mmu->base + reg);
 }
 
-static void omap_mmu_write_reg(struct omap_mmu *mmu,
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 			       unsigned short val, unsigned long reg)
 {
 	__raw_writew(val, mmu->base + reg);
@@ -119,7 +119,7 @@ static void omap_mmu_write_reg(struct omap_mmu *mmu,
 int omap_dsp_request_mem(void);
 void omap_dsp_release_mem(void);
 
-static inline void __dsp_mmu_itack(struct omap_mmu *mmu)
+static inline void omap_mmu_itack(struct omap_mmu *mmu)
 {
 	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
 }
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index be8764d..f94057e 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -27,6 +27,7 @@
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/mm.h>
+#include <linux/interrupt.h>
 #include "mmu.h"
 #include <asm/arch/mmu.h>
 #include <asm/tlbflush.h>
@@ -276,6 +277,26 @@ static inline int omap2_mmu_cam_ram_valid(struct cam_ram_regset *cr)
 	return cr->cam & OMAP_MMU_CAM_V;
 }
 
+static void omap2_mmu_interrupt(struct omap_mmu *mmu)
+{
+	unsigned long status, va;
+
+	status = MMU_IRQ_MASK & omap_mmu_read_reg(mmu, MMU_IRQSTATUS);
+	va = omap_mmu_read_reg(mmu, MMU_FAULT_AD);
+
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_MULTIHITFAULT)		? "multi hit":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TABLEWALKFAULT)		? "table walk fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_EMUMISS)			? "EMU miss":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TRANSLATIONFAULT)	? "translation fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TLBMISS)			? "TLB miss":"");
+	pr_info("fault address = %#08lx\n", va);
+
+	omap_mmu_disable(mmu);
+	omap_mmu_write_reg(mmu, status, MMU_IRQSTATUS);
+
+	mmu->fault_address = va;
+	schedule_work(&mmu->irq_work);
+}
 struct omap_mmu_ops omap2_mmu_ops = {
 	.startup	= omap2_mmu_startup,
 	.shutdown	= omap2_mmu_shutdown,
@@ -285,6 +306,7 @@ struct omap_mmu_ops omap2_mmu_ops = {
 	.cam_va		= omap2_mmu_cam_va,
 	.cam_ram_alloc	= omap2_mmu_cam_ram_alloc,
 	.cam_ram_valid	= omap2_mmu_cam_ram_valid,
+	.interrupt	= omap2_mmu_interrupt,
 };
 EXPORT_SYMBOL_GPL(omap2_mmu_ops);
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 56b7055..6e721fd 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -88,10 +88,12 @@ omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
 	return __raw_readl(mmu->base + reg);
 }
 
-static void omap_mmu_write_reg(struct omap_mmu *mmu,
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 			       unsigned long val, unsigned long reg)
 {
 	__raw_writel(val, mmu->base + reg);
 }
-
+static inline void omap_mmu_itack(struct omap_mmu *mmu)
+{
+}
 #endif /* __MACH_OMAP2_MMU_H */
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 6b5868e..3f572fd 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
@@ -871,6 +872,16 @@ void omap_mmu_enable(struct omap_mmu *mmu, int reset)
 }
 EXPORT_SYMBOL_GPL(omap_mmu_enable);
 
+static irqreturn_t omap_mmu_interrupt(int irq, void *dev_id)
+{
+	struct omap_mmu *mmu = dev_id;
+
+	if (likely(mmu->ops->interrupt))
+		mmu->ops->interrupt(mmu);
+
+	return IRQ_HANDLED;
+}
+
 static int omap_mmu_init(struct omap_mmu *mmu)
 {
 	struct omap_mmu_tlb_lock tlb_lock;
@@ -880,6 +891,14 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 	omap_dsp_request_mem();
 	down_write(&mmu->exmap_sem);
 
+	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
+			  mmu->name,  mmu);
+	if (ret < 0) {
+		printk(KERN_ERR
+		       "failed to register MMU interrupt: %d\n", ret);
+		goto fail;
+	}
+
 	omap_mmu_disable(mmu);	/* clear all */
 	udelay(100);
 	omap_mmu_enable(mmu, 1);
@@ -889,7 +908,7 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 
 	if (unlikely(mmu->ops->startup))
 		ret = mmu->ops->startup(mmu);
-
+ fail:
 	up_write(&mmu->exmap_sem);
 	omap_dsp_release_mem();
 	clk_disable(mmu->clk);
@@ -899,6 +918,8 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 
 static void omap_mmu_shutdown(struct omap_mmu *mmu)
 {
+	free_irq(mmu->irq, mmu);
+
 	if (unlikely(mmu->ops->shutdown))
 		mmu->ops->shutdown(mmu);
 
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index dd2a09a..62b0fa5 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -2,6 +2,7 @@
 #define __ARCH_OMAP_MMU_H
 
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #define MMU_REVISION		0x00
 #define MMU_SYSCONFIG		0x10
@@ -94,6 +95,8 @@ struct omap_mmu_ops {
 	/* Memory operations */
 	int (*mem_enable)(struct omap_mmu *, void *);
 	int (*mem_disable)(struct omap_mmu *, void *);
+
+	void (*interrupt)(struct omap_mmu *);
 };
 
 struct omap_mmu {
@@ -117,6 +120,11 @@ struct omap_mmu {
 	/* Size of virtual address space, in bits */
 	unsigned int addrspace;
 
+	/* Interrupt */
+	unsigned int irq;
+	unsigned long fault_address;
+	struct work_struct irq_work;
+
 	struct omap_mmu_ops *ops;
 };
 
-- 
1.5.1.rc1
