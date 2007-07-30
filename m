From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/8] ARM: OMAP: Fix omap mmu framework for omap1
Date: Mon, 30 Jul 2007 14:03:58 +0300
Message-ID: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
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

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.c            |    3 +-
 arch/arm/mach-omap1/mmu.h            |   43 ++++++++++++++++-----------------
 arch/arm/mach-omap2/mmu.c            |   21 ++++++++++------
 arch/arm/mach-omap2/mmu.h            |   24 +++++++++++++++++++
 arch/arm/plat-omap/mmu.c             |   37 +++++++++++++++--------------
 include/asm-arm/arch-omap/mmu.h      |   19 ---------------
 include/asm-arm/arch-omap/omap16xx.h |    2 +-
 7 files changed, 79 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index e1e29e0..876952e 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -86,8 +86,7 @@ static int omap1_mmu_mem_enable(struct omap_mmu *mmu, void *addr)
 	if (omap_mmu_internal_memory(mmu, addr)) {
 		if (intmem_usecount++ == 0)
 			ret = omap_dsp_request_mem();
-	} else
-		ret = -EIO;
+	}
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index d86d966..75966b2 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -7,28 +7,27 @@
 #define MMU_LOCK_BASE_MASK		(0x3f << 10)
 #define MMU_LOCK_VICTIM_MASK		(0x3f << 4)
 
-#define OMAP_MMU_BASE			(0xfffed200)
-#define OMAP_MMU_PREFETCH		(OMAP_MMU_BASE + 0x00)
-#define OMAP_MMU_WALKING_ST		(OMAP_MMU_BASE + 0x04)
-#define OMAP_MMU_CNTL			(OMAP_MMU_BASE + 0x08)
-#define OMAP_MMU_FAULT_AD_H		(OMAP_MMU_BASE + 0x0c)
-#define OMAP_MMU_FAULT_AD_L		(OMAP_MMU_BASE + 0x10)
-#define OMAP_MMU_FAULT_ST		(OMAP_MMU_BASE + 0x14)
-#define OMAP_MMU_IT_ACK			(OMAP_MMU_BASE + 0x18)
-#define OMAP_MMU_TTB_H			(OMAP_MMU_BASE + 0x1c)
-#define OMAP_MMU_TTB_L			(OMAP_MMU_BASE + 0x20)
-#define OMAP_MMU_LOCK			(OMAP_MMU_BASE + 0x24)
-#define OMAP_MMU_LD_TLB			(OMAP_MMU_BASE + 0x28)
-#define OMAP_MMU_CAM_H			(OMAP_MMU_BASE + 0x2c)
-#define OMAP_MMU_CAM_L			(OMAP_MMU_BASE + 0x30)
-#define OMAP_MMU_RAM_H			(OMAP_MMU_BASE + 0x34)
-#define OMAP_MMU_RAM_L			(OMAP_MMU_BASE + 0x38)
-#define OMAP_MMU_GFLUSH			(OMAP_MMU_BASE + 0x3c)
-#define OMAP_MMU_FLUSH_ENTRY		(OMAP_MMU_BASE + 0x40)
-#define OMAP_MMU_READ_CAM_H		(OMAP_MMU_BASE + 0x44)
-#define OMAP_MMU_READ_CAM_L		(OMAP_MMU_BASE + 0x48)
-#define OMAP_MMU_READ_RAM_H		(OMAP_MMU_BASE + 0x4c)
-#define OMAP_MMU_READ_RAM_L		(OMAP_MMU_BASE + 0x50)
+#define OMAP_MMU_PREFETCH		0x00
+#define OMAP_MMU_WALKING_ST		0x04
+#define OMAP_MMU_CNTL			0x08
+#define OMAP_MMU_FAULT_AD_H		0x0c
+#define OMAP_MMU_FAULT_AD_L		0x10
+#define OMAP_MMU_FAULT_ST		0x14
+#define OMAP_MMU_IT_ACK			0x18
+#define OMAP_MMU_TTB_H			0x1c
+#define OMAP_MMU_TTB_L			0x20
+#define OMAP_MMU_LOCK			0x24
+#define OMAP_MMU_LD_TLB			0x28
+#define OMAP_MMU_CAM_H			0x2c
+#define OMAP_MMU_CAM_L			0x30
+#define OMAP_MMU_RAM_H			0x34
+#define OMAP_MMU_RAM_L			0x38
+#define OMAP_MMU_GFLUSH			0x3c
+#define OMAP_MMU_FLUSH_ENTRY		0x40
+#define OMAP_MMU_READ_CAM_H		0x44
+#define OMAP_MMU_READ_CAM_L		0x48
+#define OMAP_MMU_READ_RAM_H		0x4c
+#define OMAP_MMU_READ_RAM_L		0x50
 
 #define OMAP_MMU_CNTL_BURST_16MNGT_EN	0x0020
 #define OMAP_MMU_CNTL_WTL_EN		0x0004
diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index 2f0e6ed..ca21541 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -42,16 +42,16 @@ static void *dspvect_page;
 static inline void
 omap2_mmu_read_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
 {
-	cr->cam = omap_mmu_read_reg(mmu, MMU_READ_CAM);
-	cr->ram = omap_mmu_read_reg(mmu, MMU_READ_RAM);
+	cr->cam = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM);
+	cr->ram = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM);
 }
 
 static inline void
 omap2_mmu_load_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
 {
 	/* Set the CAM and RAM entries */
-	omap_mmu_write_reg(mmu, cr->cam | OMAP_MMU_CAM_V, MMU_CAM);
-	omap_mmu_write_reg(mmu, cr->ram, MMU_RAM);
+	omap_mmu_write_reg(mmu, cr->cam | OMAP_MMU_CAM_V, OMAP_MMU_CAM);
+	omap_mmu_write_reg(mmu, cr->ram, OMAP_MMU_RAM);
 }
 
 static void exmap_setup_iomap_page(struct omap_mmu *mmu, unsigned long phys,
@@ -145,6 +145,11 @@ static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
 
 static int omap2_mmu_startup(struct omap_mmu *mmu)
 {
+	u32 rev = omap_mmu_read_reg(mmu, OMAP_MMU_REVISION);
+
+	pr_info("MMU: OMAP %s MMU initialized (HW v%d.%d)\n", mmu->name,
+		(rev >> 4) & 0xf, rev & 0xf);
+
 	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
 	if (dspvect_page == NULL) {
 		printk(KERN_ERR "MMU: failed to allocate memory "
@@ -154,7 +159,7 @@ static int omap2_mmu_startup(struct omap_mmu *mmu)
 
 	mmu->nr_exmap_preserved = exmap_setup_preserved_entries(mmu);
 
-	omap_mmu_write_reg(mmu, MMU_IRQ_MASK, MMU_IRQENABLE);
+	omap_mmu_write_reg(mmu, MMU_IRQ_MASK, OMAP_MMU_IRQENABLE);
 
 	return 0;
 }
@@ -283,8 +288,8 @@ static void omap2_mmu_interrupt(struct omap_mmu *mmu)
 {
 	unsigned long status, va;
 
-	status = MMU_IRQ_MASK & omap_mmu_read_reg(mmu, MMU_IRQSTATUS);
-	va = omap_mmu_read_reg(mmu, MMU_FAULT_AD);
+	status = MMU_IRQ_MASK & omap_mmu_read_reg(mmu, OMAP_MMU_IRQSTATUS);
+	va = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD);
 
 	pr_info("%s\n", (status & OMAP_MMU_IRQ_MULTIHITFAULT)		? "multi hit":"");
 	pr_info("%s\n", (status & OMAP_MMU_IRQ_TABLEWALKFAULT)		? "table walk fault":"");
@@ -294,7 +299,7 @@ static void omap2_mmu_interrupt(struct omap_mmu *mmu)
 	pr_info("fault address = %#08lx\n", va);
 
 	omap_mmu_disable(mmu);
-	omap_mmu_write_reg(mmu, status, MMU_IRQSTATUS);
+	omap_mmu_write_reg(mmu, status, OMAP_MMU_IRQSTATUS);
 
 	mmu->fault_address = va;
 	schedule_work(&mmu->irq_work);
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index 7520f91..c4922d1 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -7,6 +7,30 @@
 #define MMU_LOCK_BASE_MASK		(0x1f << 10)
 #define MMU_LOCK_VICTIM_MASK		(0x1f << 4)
 
+#define OMAP_MMU_REVISION		0x00
+#define OMAP_MMU_SYSCONFIG		0x10
+#define OMAP_MMU_SYSSTATUS		0x14
+#define OMAP_MMU_IRQSTATUS		0x18
+#define OMAP_MMU_IRQENABLE		0x1c
+#define OMAP_MMU_WALKING_ST		0x40
+#define OMAP_MMU_CNTL			0x44
+#define OMAP_MMU_FAULT_AD		0x48
+#define OMAP_MMU_TTB			0x4c
+#define OMAP_MMU_LOCK			0x50
+#define OMAP_MMU_LD_TLB			0x54
+#define OMAP_MMU_CAM			0x58
+#define OMAP_MMU_RAM			0x5c
+#define OMAP_MMU_GFLUSH			0x60
+#define OMAP_MMU_FLUSH_ENTRY		0x64
+#define OMAP_MMU_READ_CAM		0x68
+#define OMAP_MMU_READ_RAM		0x6c
+#define OMAP_MMU_EMU_FAULT_AD		0x70
+
+#define OMAP_MMU_CNTL_BURST_16MNGT_EN   0x0020
+#define OMAP_MMU_CNTL_WTL_EN            0x0004
+#define OMAP_MMU_CNTL_MMU_EN            0x0002
+#define OMAP_MMU_CNTL_RESET_SW          0x0001
+
 #define OMAP_MMU_IRQ_MULTIHITFAULT	0x00000010
 #define OMAP_MMU_IRQ_TABLEWALKFAULT	0x00000008
 #define OMAP_MMU_IRQ_EMUMISS		0x00000004
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 30c646e..cb675d4 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -523,7 +523,7 @@ static int omap_mmu_cam_ram_valid(struct omap_mmu *mmu,
 static inline void
 omap_mmu_get_tlb_lock(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *tlb_lock)
 {
-	unsigned long lock = omap_mmu_read_reg(mmu, MMU_LOCK);
+	unsigned long lock = omap_mmu_read_reg(mmu, OMAP_MMU_LOCK);
 	int mask;
 
 	mask = (mmu->type == OMAP_MMU_CAMERA) ?
@@ -540,17 +540,18 @@ omap_mmu_set_tlb_lock(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock)
 {
 	omap_mmu_write_reg(mmu,
 			   (lock->base << MMU_LOCK_BASE_SHIFT) |
-			   (lock->victim << MMU_LOCK_VICTIM_SHIFT), MMU_LOCK);
+			   (lock->victim << MMU_LOCK_VICTIM_SHIFT),
+			   OMAP_MMU_LOCK);
 }
 
 static inline void omap_mmu_flush(struct omap_mmu *mmu)
 {
-	omap_mmu_write_reg(mmu, 0x1, MMU_FLUSH_ENTRY);
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_FLUSH_ENTRY);
 }
 
 static inline void omap_mmu_ldtlb(struct omap_mmu *mmu)
 {
-	omap_mmu_write_reg(mmu, 0x1, MMU_LD_TLB);
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_LD_TLB);
 }
 
 void omap_mmu_read_tlb(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock,
@@ -671,7 +672,7 @@ static void omap_mmu_gflush(struct omap_mmu *mmu)
 	clk_enable(mmu->clk);
 	omap_dsp_request_mem();
 
-	omap_mmu_write_reg(mmu, 0x1, MMU_GFLUSH);
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_GFLUSH);
 	lock.base = lock.victim = mmu->nr_exmap_preserved;
 	omap_mmu_set_tlb_lock(mmu, &lock);
 
@@ -1015,35 +1016,39 @@ EXPORT_SYMBOL_GPL(exmap_clear_mem_page);
 
 static void omap_mmu_reset(struct omap_mmu *mmu)
 {
+#if defined(CONFIG_ARCH_OMAP2) /* FIXME */
 	int i;
 
-	omap_mmu_write_reg(mmu, 0x2, MMU_SYSCONFIG);
+	omap_mmu_write_reg(mmu, 0x2, OMAP_MMU_SYSCONFIG);
 
 	for (i = 0; i < 10000; i++)
-		if (likely(omap_mmu_read_reg(mmu, MMU_SYSSTATUS) & 0x1))
+		if (likely(omap_mmu_read_reg(mmu, OMAP_MMU_SYSSTATUS) & 0x1))
 			break;
+#endif
 }
 
 void omap_mmu_disable(struct omap_mmu *mmu)
 {
-	omap_mmu_write_reg(mmu, 0x00, MMU_CNTL);
+	omap_mmu_write_reg(mmu, 0x00, OMAP_MMU_CNTL);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_disable);
 
 void omap_mmu_enable(struct omap_mmu *mmu, int reset)
 {
-	u32 val = MMU_CNTL_MMUENABLE;
-	u32 pa = (u32)virt_to_phys(mmu->twl_mm->pgd);
+	u32 val = OMAP_MMU_CNTL_MMU_EN;
 
 	if (likely(reset))
 		omap_mmu_reset(mmu);
-
+#if defined(CONFIG_ARCH_OMAP2) /* FIXME */
 	if (mmu->ops->pte_get_attr) {
-		omap_mmu_write_reg(mmu, pa, MMU_TTB);
+		omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd),
+				   OMAP_MMU_TTB);
 		val |= MMU_CNTL_TWLENABLE;
 	}
-
-	omap_mmu_write_reg(mmu, val, MMU_CNTL);
+#else
+	val |= OMAP_MMU_CNTL_RESET_SW;
+#endif
+	omap_mmu_write_reg(mmu, val, OMAP_MMU_CNTL);
 }
 EXPORT_SYMBOL_GPL(omap_mmu_enable);
 
@@ -1472,10 +1477,6 @@ int omap_mmu_register(struct omap_mmu *mmu)
 
 	init_rwsem(&mmu->exmap_sem);
 
-	ret = omap_mmu_read_reg(mmu, MMU_REVISION);
-	printk(KERN_NOTICE "MMU: OMAP %s MMU initialized (HW v%d.%d)\n",
-	       mmu->name, (ret >> 4) & 0xf, ret & 0xf);
-
 	ret = omap_mmu_init(mmu);
 	if (unlikely(ret))
 		goto err_mmu_init;
diff --git a/include/asm-arm/arch-omap/mmu.h b/include/asm-arm/arch-omap/mmu.h
index bff433b..7d1e450 100644
--- a/include/asm-arm/arch-omap/mmu.h
+++ b/include/asm-arm/arch-omap/mmu.h
@@ -4,25 +4,6 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 
-#define MMU_REVISION		0x00
-#define MMU_SYSCONFIG		0x10
-#define MMU_SYSSTATUS		0x14
-#define MMU_IRQSTATUS		0x18
-#define MMU_IRQENABLE		0x1c
-#define MMU_WALKING_ST		0x40
-#define MMU_CNTL		0x44
-#define MMU_FAULT_AD		0x48
-#define MMU_TTB			0x4c
-#define MMU_LOCK		0x50
-#define MMU_LD_TLB		0x54
-#define MMU_CAM			0x58
-#define MMU_RAM			0x5c
-#define MMU_GFLUSH		0x60
-#define MMU_FLUSH_ENTRY		0x64
-#define MMU_READ_CAM		0x68
-#define MMU_READ_RAM		0x6c
-#define MMU_EMU_FAULT_AD	0x70
-
 enum exmap_type {
 	EXMAP_TYPE_MEM,
 	EXMAP_TYPE_FB
diff --git a/include/asm-arm/arch-omap/omap16xx.h b/include/asm-arm/arch-omap/omap16xx.h
index f7f5cdf..db85276 100644
--- a/include/asm-arm/arch-omap/omap16xx.h
+++ b/include/asm-arm/arch-omap/omap16xx.h
@@ -190,7 +190,7 @@
 #define WSPR_DISABLE_0         (0x0000aaaa)
 #define WSPR_DISABLE_1         (0x00005555)
 
-/* Mailbox */
+#define OMAP16XX_DSP_MMU_BASE	(0xfffed200)
 #define OMAP16XX_MAILBOX_BASE	(0xfffcf000)
 
 #endif /*  __ASM_ARCH_OMAP16XX_H */
-- 
1.5.3.rc3.24.g83b3d
