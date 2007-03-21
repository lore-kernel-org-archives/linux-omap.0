From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 2/2] ARM:OMAP:DSP: Use MMU FWK interrupt interface
Date: Wed, 21 Mar 2007 09:43:14 +0200
Message-ID: <11744629971941-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

- Add a new member, a pointer of "struct omap_mmu" in "struct
  omap_dsp"
- Register dsp's interrupt work to MMU FWK

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/dsp/dsp_common.c |    7 +-
 arch/arm/plat-omap/dsp/dsp_common.h |    5 +-
 arch/arm/plat-omap/dsp/dsp_core.c   |   13 +--
 arch/arm/plat-omap/dsp/dsp_mem.c    |   74 ++++++---------
 arch/arm/plat-omap/dsp/error.c      |    4 +-
 arch/arm/plat-omap/dsp/mmu.h        |  167 ++---------------------------------
 6 files changed, 47 insertions(+), 223 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index 310ae3c..cfb2bbc 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -262,7 +262,8 @@ void dsp_reset_idle_boot_base(void)
 {
 	idle_boot_base = DSP_BOOT_ADR_MPUI;
 }
-
+#else
+void dsp_reset_idle_boot_base(void) { }
 #endif /* CONFIG_ARCH_OMAP1 */
 
 static int init_done;
@@ -377,8 +378,6 @@ static void dsp_cpustat_update(void)
 			__dsp_core_enable();
 #endif
 			cpustat.stat = CPUSTAT_RUN;
-			if (omap_dsp != NULL)
-				enable_irq(omap_dsp->mmu_irq);
 		}
 		return;
 	}
@@ -386,8 +385,6 @@ static void dsp_cpustat_update(void)
 	/* cpustat.req < CPUSTAT_RUN */
 
 	if (cpustat.stat == CPUSTAT_RUN) {
-		if (omap_dsp != NULL)
-			disable_irq(omap_dsp->mmu_irq);
 #ifdef CONFIG_ARCH_OMAP1
 		clk_disable(api_ck_handle);
 #endif
diff --git a/arch/arm/plat-omap/dsp/dsp_common.h b/arch/arm/plat-omap/dsp/dsp_common.h
index cf13c7e..898c9ea 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.h
+++ b/arch/arm/plat-omap/dsp/dsp_common.h
@@ -25,6 +25,7 @@
 #define DRIVER_DSP_COMMON_H
 
 #include <linux/clk.h>
+#include <asm/arch/mmu.h>
 #include "hardware_dsp.h"
 
 #define DSPSPACE_SIZE	0x1000000
@@ -134,10 +135,8 @@ enum cpustat_e {
 
 int dsp_set_rstvect(dsp_long_t adr);
 dsp_long_t dsp_get_rstvect(void);
-#ifdef CONFIG_ARCH_OMAP1
 void dsp_set_idle_boot_base(dsp_long_t adr, size_t size);
 void dsp_reset_idle_boot_base(void);
-#endif
 void dsp_cpustat_request(enum cpustat_e req);
 enum cpustat_e dsp_cpustat_get_stat(void);
 u16 dsp_cpustat_get_icrmask(void);
@@ -197,7 +196,7 @@ struct dsp_platform_data {
 struct omap_dsp {
 	struct mutex		lock;
 	int			enabled;	/* stored peripheral status */
-	int			mmu_irq;
+	struct omap_mmu		*mmu;
 	struct omap_mbox	*mbox;
 	struct device		*dev;
 	struct list_head	*kdev_list;
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
index 86a2d15..f3a91d0 100644
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ b/arch/arm/plat-omap/dsp/dsp_core.c
@@ -44,7 +44,7 @@ static struct sync_seq *mbseq;
 static u16 mbseq_expect_tmp;
 static u16 *mbseq_expect = &mbseq_expect_tmp;
 
-extern void dsp_mem_late_init(void);
+extern int dsp_mem_late_init(void);
 
 /*
  * mailbox commands
@@ -459,7 +459,9 @@ int dsp_late_init(void)
 	int ret;
 
 	dsp_clk_enable();
-	dsp_mem_late_init();
+	ret = dsp_mem_late_init();
+	if (ret)
+		return ret;
 	ret = dsp_mbox_init();
 	if (ret)
 		goto fail_mbox;
@@ -522,12 +524,6 @@ static int __init dsp_drv_probe(struct platform_device *pdev)
 		goto fail_kfunc;
 	}
 
-	info->mmu_irq = platform_get_irq_byname(pdev, "dsp_mmu");
-	if (unlikely(info->mmu_irq) < 0) {
-		ret = -ENXIO;
-		goto fail_irq;
-	}
-
 	ret = dsp_ctl_core_init();
 	if (ret)
 		goto fail_ctl_core;
@@ -552,7 +548,6 @@ static int __init dsp_drv_probe(struct platform_device *pdev)
  fail_mem:
 	dsp_ctl_core_exit();
  fail_ctl_core:
- fail_irq:
 	dsp_kfunc_remove_devices(info);
  fail_kfunc:
 	kfree(info);
diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
index 30e766e..d5a652c 100644
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ b/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -406,16 +406,6 @@ struct file_operations dsp_mem_fops = {
 	.ioctl   = dsp_mem_ioctl,
 };
 
-/*
- * DSP MMU interrupt handler
- */
-static irqreturn_t dsp_mmu_interrupt(int irq, void *dev_id)
-{
-	disable_irq(omap_dsp->mmu_irq);
-	schedule_work(&mmu_int_work);
-	return IRQ_HANDLED;
-}
-
 void dsp_mem_start(void)
 {
 	dsp_register_mem_cb(intmem_enable, intmem_disable);
@@ -427,14 +417,42 @@ void dsp_mem_stop(void)
 	dsp_unregister_mem_cb();
 }
 
+static void dsp_mmu_irq_work(struct work_struct *work)
+{
+	struct omap_mmu *mmu = container_of(work, struct omap_mmu, irq_work);
+
+	if (dsp_cfgstat_get_stat() == CFGSTAT_READY) {
+		dsp_err_set(ERRCODE_MMU, mmu->fault_address);
+		return;
+	}
+	omap_mmu_itack(mmu);
+	pr_info("Resetting DSP...\n");
+	dsp_cpustat_request(CPUSTAT_RESET);
+	omap_mmu_enable(mmu, 0);
+}
+
 /*
  * later half of dsp memory initialization
  */
-void dsp_mem_late_init(void)
+int dsp_mem_late_init(void)
 {
-	int ret = 0;
+	int ret;
 
 	dsp_mem_ipi_init();
+
+	INIT_WORK(&dsp_mmu.irq_work, dsp_mmu_irq_work);
+	ret = omap_mmu_register(&dsp_mmu);
+	if (ret) {
+		dsp_reset_idle_boot_base();
+		goto out;
+	}
+	omap_dsp->mmu = &dsp_mmu;
+ out:
+	return ret;
+}
+
+int __init dsp_mem_init(void)
+{
 #ifdef CONFIG_ARCH_OMAP2
 	dsp_mmu.clk    = dsp_fck_handle;
 	dsp_mmu.memclk = dsp_ick_handle;
@@ -442,43 +460,11 @@ void dsp_mem_late_init(void)
 	dsp_mmu.clk    = dsp_ck_handle;
 	dsp_mmu.memclk = api_ck_handle;
 #endif
-	ret = omap_mmu_register(&dsp_mmu);
-}
-
-int __init dsp_mem_init(void)
-{
-	int ret;
-	/*
-	 * DSP MMU interrupt setup
-	 */
-	ret = request_irq(omap_dsp->mmu_irq, dsp_mmu_interrupt, IRQF_DISABLED,
-			  "dsp_mmu",  NULL);
-	if (ret) {
-		printk(KERN_ERR
-		       "failed to register DSP MMU interrupt: %d\n", ret);
-		goto fail;
-	}
-
-	/* MMU interrupt is not enabled until DSP runs */
-	disable_irq(omap_dsp->mmu_irq);
-
 	return 0;
- fail:
-#ifdef CONFIG_ARCH_OMAP1
-	dsp_reset_idle_boot_base();
-#endif
-	return ret;
 }
 
 void dsp_mem_exit(void)
 {
-	free_irq(omap_dsp->mmu_irq, NULL);
-
-	/* recover disable_depth */
-	enable_irq(omap_dsp->mmu_irq);
-
-#ifdef CONFIG_ARCH_OMAP1
 	dsp_reset_idle_boot_base();
-#endif
 	omap_mmu_unregister(&dsp_mmu);
 }
diff --git a/arch/arm/plat-omap/dsp/error.c b/arch/arm/plat-omap/dsp/error.c
index 58df0b2..d2276f9 100644
--- a/arch/arm/plat-omap/dsp/error.c
+++ b/arch/arm/plat-omap/dsp/error.c
@@ -99,13 +99,13 @@ struct file_operations dsp_err_fops = {
 /* DSP MMU */
 static void dsp_err_mmu_set(unsigned long arg)
 {
-	disable_irq(omap_dsp->mmu_irq);
+	disable_irq(omap_dsp->mmu->irq);
 	mmu_fadr = (u32)arg;
 }
 
 static void dsp_err_mmu_clr(void)
 {
-	enable_irq(omap_dsp->mmu_irq);
+	enable_irq(omap_dsp->mmu->irq);
 }
 
 /* WDT */
diff --git a/arch/arm/plat-omap/dsp/mmu.h b/arch/arm/plat-omap/dsp/mmu.h
index 1c2dd71..78189f0 100644
--- a/arch/arm/plat-omap/dsp/mmu.h
+++ b/arch/arm/plat-omap/dsp/mmu.h
@@ -5,45 +5,46 @@
 
 #ifdef CONFIG_ARCH_OMAP15XX
 struct omap_mmu dsp_mmu = {
-	.name		= "dsp",
+	.name		= "mmu:dsp",
 	.type		= OMAP_MMU_DSP,
 	.base		= DSP_MMU_BASE,
 	.membase	= OMAP15XX_DSP_BASE,
 	.memsize	= OMAP15XX_DSP_SIZE,
 	.nr_tlb_entries	= 32,
 	.addrspace	= 24,
+	.irq		= INT_1510_DSP_MMU,
 	.ops		= &omap1_mmu_ops,
 };
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 struct omap_mmu dsp_mmu = {
-	.name		= "dsp",
+	.name		= "mmu:dsp",
 	.type		= OMAP_MMU_DSP,
 	.base		= DSP_MMU_BASE,
 	.membase	= OMAP16XX_DSP_BASE,
 	.memsize	= OMAP16XX_DSP_SIZE,
 	.nr_tlb_entries	= 32,
 	.addrspace	= 24,
+	.irq		= INT_1610_DSP_MMU,
 	.ops		= &omap1_mmu_ops,
 };
 #endif
 #else /* OMAP2 */
 struct omap_mmu dsp_mmu = {
-	.name		= "dsp",
+	.name		= "mmu:dsp",
 	.type		= OMAP_MMU_DSP,
 	.base		= DSP_MMU_24XX_VIRT,
 	.membase	= DSP_MEM_24XX_VIRT,
 	.memsize	= DSP_MEM_24XX_SIZE,
 	.nr_tlb_entries	= 32,
 	.addrspace	= 24,
+	.irq		= INT_24XX_DSP_MMU,
 	.ops		= &omap2_mmu_ops,
 };
 
 #define IOMAP_VAL	0x3f
 #endif
 
-static u32 dsp_fault_adr;
-
 #ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
 static struct omapfb_notifier_block *omapfb_nb;
 static int omapfb_ready;
@@ -72,160 +73,6 @@ static int omapfb_ready;
 #define set_emiff_dma_prio(prio)	do { } while (0)
 #endif /* CONFIG_ARCH_OMAP1 */
 
-/*
- * workqueue for mmu int
- */
-#ifdef CONFIG_ARCH_OMAP1
-/*
- * MMU fault mask:
- * We ignore prefetch err.
- */
-#define MMUFAULT_MASK \
-	(DSP_MMU_FAULT_ST_PERM |\
-	 DSP_MMU_FAULT_ST_TLB_MISS |\
-	 DSP_MMU_FAULT_ST_TRANS)
-
-static void do_mmu_int(struct work_struct *unused)
-{
-	unsigned long status;
-	unsigned long adh, adl;
-	unsigned long dp;
-
-	status = omap_mmu_read_reg(&dsp_mmu, DSP_MMU_FAULT_ST);
-	adh = omap_mmu_read_reg(&dsp_mmu, DSP_MMU_FAULT_AD_H);
-	adl = omap_mmu_read_reg(&dsp_mmu, DSP_MMU_FAULT_AD_L);
-	dp = adh & DSP_MMU_FAULT_AD_H_DP;
-	dsp_fault_adr = MK32(adh & DSP_MMU_FAULT_AD_H_ADR_MASK, adl);
-
-	/* if the fault is masked, nothing to do */
-	if ((status & MMUFAULT_MASK) == 0) {
-		pr_debug( "DSP MMU interrupt, but ignoring.\n");
-		/*
-		 * note: in OMAP1710,
-		 * when CACHE + DMA domain gets out of idle in DSP,
-		 * MMU interrupt occurs but DSP_MMU_FAULT_ST is not set.
-		 * in this case, we just ignore the interrupt.
-		 */
-		if (status) {
-			pr_debug( "%s%s%s%s\n",
-				  (status & DSP_MMU_FAULT_ST_PREF)?
-				  "  (prefetch err)" : "",
-				  (status & DSP_MMU_FAULT_ST_PERM)?
-				  "  (permission fault)" : "",
-				  (status & DSP_MMU_FAULT_ST_TLB_MISS)?
-				  "  (TLB miss)" : "",
-				  (status & DSP_MMU_FAULT_ST_TRANS) ?
-				  "  (translation fault)": "");
-			pr_debug( "fault address = %#08x\n", dsp_fault_adr);
-		}
-		enable_irq(omap_dsp->mmu_irq);
-		return;
-	}
-
-
-	pr_info("%s%s%s%s\n",
-		(status & DSP_MMU_FAULT_ST_PREF)?
-		(MMUFAULT_MASK & DSP_MMU_FAULT_ST_PREF)?
-		"  prefetch err":
-		"  (prefetch err)":
-		"",
-		(status & DSP_MMU_FAULT_ST_PERM)?
-		(MMUFAULT_MASK & DSP_MMU_FAULT_ST_PERM)?
-		"  permission fault":
-		"  (permission fault)":
-		"",
-		(status & DSP_MMU_FAULT_ST_TLB_MISS)?
-		(MMUFAULT_MASK & DSP_MMU_FAULT_ST_TLB_MISS)?
-		"  TLB miss":
-		"  (TLB miss)":
-		"",
-		(status & DSP_MMU_FAULT_ST_TRANS)?
-		(MMUFAULT_MASK & DSP_MMU_FAULT_ST_TRANS)?
-		"  translation fault":
-		"  (translation fault)":
-		"");
-
-	pr_info("fault address = %#08x\n", dsp_fault_adr);
-
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
-		dsp_err_set(ERRCODE_MMU, (unsigned long)dsp_fault_adr);
-	else {
-		__dsp_mmu_itack(&dsp_mmu);
-
-		pr_info("Resetting DSP...\n");
-		dsp_cpustat_request(CPUSTAT_RESET);
-		/*
-		 * if we enable followings, semaphore lock should be avoided.
-		 *
-		 pr_info("Flushing DSP MMU...\n");
-		 exmap_flush();
-		 dsp_mmu_init();
-		*/
-	}
-
-	enable_irq(omap_dsp->mmu_irq);
-}
-#elif defined(CONFIG_ARCH_OMAP2)
-static void do_mmu_int(struct work_struct *unused)
-{
-	unsigned long status;
-
-	status = omap_mmu_read_reg(&dsp_mmu, DSP_MMU_IRQSTATUS);
-	dsp_fault_adr = omap_mmu_read_reg(&dsp_mmu, DSP_MMU_FAULT_AD);
-
-#define MMU_IRQ_MASK \
-	(DSP_MMU_IRQ_MULTIHITFAULT | \
-	 DSP_MMU_IRQ_TABLEWALKFAULT | \
-	 DSP_MMU_IRQ_EMUMISS | \
-	 DSP_MMU_IRQ_TRANSLATIONFAULT | \
-	 DSP_MMU_IRQ_TLBMISS)
-
-	pr_info("%s%s%s%s%s\n",
-		(status & DSP_MMU_IRQ_MULTIHITFAULT)?
-		(MMU_IRQ_MASK & DSP_MMU_IRQ_MULTIHITFAULT)?
-		"  multi hit":
-		"  (multi hit)":
-		"",
-		(status & DSP_MMU_IRQ_TABLEWALKFAULT)?
-		(MMU_IRQ_MASK & DSP_MMU_IRQ_TABLEWALKFAULT)?
-		"  table walk fault":
-		"  (table walk fault)":
-		"",
-		(status & DSP_MMU_IRQ_EMUMISS)?
-		(MMU_IRQ_MASK & DSP_MMU_IRQ_EMUMISS)?
-		"  EMU miss":
-		"  (EMU miss)":
-		"",
-		(status & DSP_MMU_IRQ_TRANSLATIONFAULT)?
-		(MMU_IRQ_MASK & DSP_MMU_IRQ_TRANSLATIONFAULT)?
-		"  translation fault":
-		"  (translation fault)":
-		"",
-		(status & DSP_MMU_IRQ_TLBMISS)?
-		(MMU_IRQ_MASK & DSP_MMU_IRQ_TLBMISS)?
-		"  TLB miss":
-		"  (TLB miss)":
-		"");
-
-	pr_info("fault address = %#08x\n", dsp_fault_adr);
-
-	if (dsp_cfgstat_get_stat() == CFGSTAT_READY)
-		dsp_err_set(ERRCODE_MMU, (unsigned long)dsp_fault_adr);
-	else {
-		pr_info("Resetting DSP...\n");
-		dsp_cpustat_request(CPUSTAT_RESET);
-	}
-
-	omap_mmu_disable(&dsp_mmu);
-	omap_mmu_write_reg(&dsp_mmu, status, DSP_MMU_IRQSTATUS);
-	omap_mmu_enable(&dsp_mmu, 0);
-
-	enable_irq(omap_dsp->mmu_irq);
-}
-#endif
-
-static DECLARE_WORK(mmu_int_work, do_mmu_int);
-
 #ifdef CONFIG_ARCH_OMAP1
 static int dsp_mmu_itack(void)
 {
@@ -241,7 +88,7 @@ static int dsp_mmu_itack(void)
 	omap_mmu_exmap(&dsp_mmu, dspadr, 0, SZ_4K, EXMAP_TYPE_MEM);
 	pr_info("omapdsp: falling into recovery runlevel...\n");
 	dsp_set_runlevel(RUNLEVEL_RECOVERY);
-	__dsp_mmu_itack(&dsp_mmu);
+	omap_mmu_itack(&dsp_mmu);
 	udelay(100);
 	omap_mmu_exunmap(&dsp_mmu, dspadr);
 	dsp_err_clear(ERRCODE_MMU);
-- 
1.5.1.rc1
