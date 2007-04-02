From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] DSP: Fix build problem with OMAP1
Date: Mon,  2 Apr 2007 15:10:16 +0300
Message-ID: <11755158162460-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Based on Dirk Behme's comment:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009461.html

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.c        |   43 +++++++++++++++++++++----------------
 arch/arm/plat-omap/dsp/dsp_mem.c |    6 +++-
 arch/arm/plat-omap/dsp/mmu.h     |    2 +-
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 789783c..e1e29e0 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -28,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/interrupt.h>
 #include <linux/err.h>
 #include "mmu.h"
 #include <asm/tlbflush.h>
@@ -35,6 +36,10 @@
 static void *dspvect_page;
 #define DSP_INIT_PAGE	0xfff000
 
+#define MMUFAULT_MASK (OMAP_MMU_FAULT_ST_PERM |\
+		       OMAP_MMU_FAULT_ST_TLB_MISS |\
+		       OMAP_MMU_FAULT_ST_TRANS)
+
 static unsigned int get_cam_l_va_mask(u16 pgsz)
 {
 	switch (pgsz) {
@@ -267,11 +272,11 @@ static void omap1_mmu_interrupt(struct omap_mmu *mmu)
 	unsigned long dp;
 	unsigned long va;
 
-	status = omap_mmu_read_reg(mmu, MMU_FAULT_ST);
-	adh = omap_mmu_read_reg(mmu, MMU_FAULT_AD_H);
-	adl = omap_mmu_read_reg(mmu, MMU_FAULT_AD_L);
-	dp = adh & MMU_FAULT_AD_H_DP;
-	va = MK32(adh & MMU_FAULT_AD_H_ADR_MASK, adl);
+	status = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_ST);
+	adh = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_H);
+	adl = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_L);
+	dp = adh & OMAP_MMU_FAULT_AD_H_DP;
+	va = (((adh & OMAP_MMU_FAULT_AD_H_ADR_MASK) << 16) | adl);
 
 	/* if the fault is masked, nothing to do */
 	if ((status & MMUFAULT_MASK) == 0) {
@@ -284,42 +289,42 @@ static void omap1_mmu_interrupt(struct omap_mmu *mmu)
 		 */
 		if (status) {
 			pr_debug( "%s%s%s%s\n",
-				  (status & MMU_FAULT_ST_PREF)?
+				  (status & OMAP_MMU_FAULT_ST_PREF)?
 				  "  (prefetch err)" : "",
-				  (status & MMU_FAULT_ST_PERM)?
+				  (status & OMAP_MMU_FAULT_ST_PERM)?
 				  "  (permission fault)" : "",
-				  (status & MMU_FAULT_ST_TLB_MISS)?
+				  (status & OMAP_MMU_FAULT_ST_TLB_MISS)?
 				  "  (TLB miss)" : "",
-				  (status & MMU_FAULT_ST_TRANS) ?
+				  (status & OMAP_MMU_FAULT_ST_TRANS) ?
 				  "  (translation fault)": "");
-			pr_debug( "fault address = %#08x\n", va);
+			pr_debug( "fault address = %#08lx\n", va);
 		}
 		enable_irq(mmu->irq);
 		return;
 	}
 
 	pr_info("%s%s%s%s\n",
-		(status & MMU_FAULT_ST_PREF)?
-		(MMUFAULT_MASK & MMU_FAULT_ST_PREF)?
+		(status & OMAP_MMU_FAULT_ST_PREF)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PREF)?
 		"  prefetch err":
 		"  (prefetch err)":
 		"",
-		(status & MMU_FAULT_ST_PERM)?
-		(MMUFAULT_MASK & MMU_FAULT_ST_PERM)?
+		(status & OMAP_MMU_FAULT_ST_PERM)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PERM)?
 		"  permission fault":
 		"  (permission fault)":
 		"",
-		(status & MMU_FAULT_ST_TLB_MISS)?
-		(MMUFAULT_MASK & MMU_FAULT_ST_TLB_MISS)?
+		(status & OMAP_MMU_FAULT_ST_TLB_MISS)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TLB_MISS)?
 		"  TLB miss":
 		"  (TLB miss)":
 		"",
-		(status & MMU_FAULT_ST_TRANS)?
-		(MMUFAULT_MASK & MMU_FAULT_ST_TRANS)?
+		(status & OMAP_MMU_FAULT_ST_TRANS)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TRANS)?
 		"  translation fault":
 		"  (translation fault)":
 		"");
-	pr_info("fault address = %#08x\n", va);
+	pr_info("fault address = %#08lx\n", va);
 
 	mmu->fault_address = va;
 	schedule_work(&mmu->irq_work);
diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
index d5a652c..eab57b5 100644
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ b/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -344,8 +344,6 @@ static int dsp_mem_ioctl(struct inode *inode, struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
 	struct omap_dsp_mapinfo mapinfo;
-	dsp_long_t dspadr;
-	int ret;
 	__u32 size;
 
 	switch (cmd) {
@@ -370,6 +368,9 @@ static int dsp_mem_ioctl(struct inode *inode, struct file *file,
 		return 0;
 #ifdef CONFIG_OMAP_DSP_FBEXPORT
 	case MEM_IOCTL_FBEXPORT:
+	{
+		dsp_long_t dspadr;
+		int ret;
 		if (copy_from_user(&dspadr, (void __user *)arg,
 				   sizeof(dsp_long_t)))
 			return -EFAULT;
@@ -378,6 +379,7 @@ static int dsp_mem_ioctl(struct inode *inode, struct file *file,
 				 sizeof(dsp_long_t)))
 			return -EFAULT;
 		return ret;
+	}
 #endif
 	case MEM_IOCTL_MMUITACK:
 		return dsp_mmu_itack();
diff --git a/arch/arm/plat-omap/dsp/mmu.h b/arch/arm/plat-omap/dsp/mmu.h
index 78189f0..ca47b7b 100644
--- a/arch/arm/plat-omap/dsp/mmu.h
+++ b/arch/arm/plat-omap/dsp/mmu.h
@@ -83,7 +83,7 @@ static int dsp_mmu_itack(void)
 		printk(KERN_ERR "omapdsp: DSP MMU error has not been set.\n");
 		return -EINVAL;
 	}
-	dspadr = dsp_fault_adr & ~(SZ_4K-1);
+	dspadr = dsp_mmu.fault_address & ~(SZ_4K-1);
 	/* FIXME: reserve TLB entry for this */
 	omap_mmu_exmap(&dsp_mmu, dspadr, 0, SZ_4K, EXMAP_TYPE_MEM);
 	pr_info("omapdsp: falling into recovery runlevel...\n");
-- 
1.5.1.rc2.18.g9c88
