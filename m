From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP: Add MMU framework
Date: Mon, 3 Dec 2007 14:46:12 -0800
Message-ID: <20071203224611.GG4105@atomide.com>
References: <20071203222651.GE4105@atomide.com>
	<20071203224029.GF4105@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tqI+Z3u+9OQ7kwn0"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071203224029.GF4105@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <lethal@linux-sh.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And this is what the MMU patch against Linus' tree would look like.
This on is without the previous sysdev_class patch until that's been
decided.

Paul, Toshihiro & Hiroshi, are you OK sending this to linux-arm
mailing list in general in this format?

Regards,

Tony

--tqI+Z3u+9OQ7kwn0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-omap-mmu.patch"

>From 0a1a943d244aae355052fa29f9dc7e7e992ea4db Mon Sep 17 00:00:00 2001
From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Nov 2007 15:30:54 -0800
Subject: [PATCH] ARM: OMAP: Add MMU framework

ARM: OMAP: Add MMU framework

OMAP processors have an MMU for coprocessors such as
DSP, IVA (Image Video Accelerator) and camera.

Various additional features added by Hiroshi DOYU.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile           |    3 +
 arch/arm/mach-omap1/mmu.c              |  361 ++++++++
 arch/arm/mach-omap1/mmu.h              |  119 +++
 arch/arm/mach-omap2/Makefile           |    3 +
 arch/arm/mach-omap2/mmu.c              |  340 +++++++
 arch/arm/mach-omap2/mmu.h              |  117 +++
 arch/arm/plat-omap/Kconfig             |    8 +
 arch/arm/plat-omap/Makefile            |    3 +
 arch/arm/plat-omap/mmu.c               | 1584 ++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/dsp_common.h |    8 +-
 include/asm-arm/arch-omap/mmu.h        |  211 +++++
 include/asm-arm/pgtable.h              |    1 +
 12 files changed, 2756 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap1/mmu.c
 create mode 100644 arch/arm/mach-omap1/mmu.h
 create mode 100644 arch/arm/mach-omap2/mmu.c
 create mode 100644 arch/arm/mach-omap2/mmu.h
 create mode 100644 arch/arm/plat-omap/mmu.c
 create mode 100644 include/asm-arm/arch-omap/mmu.h

Index: linux-2.6/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap1/Makefile	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/arch/arm/mach-omap1/Makefile	2007-12-03 14:36:47.000000000 -0800
@@ -10,6 +10,9 @@ obj-$(CONFIG_OMAP_MPU_TIMER)		+= time.o
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
+obj-$(CONFIG_OMAP_MMU_FWK)		+= mmu_mach.o
+mmu_mach-objs				:= mmu.o
+
 led-y := leds.o
 
 # Specific board support
Index: linux-2.6/arch/arm/mach-omap1/mmu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/arm/mach-omap1/mmu.c	2007-12-03 14:36:47.000000000 -0800
@@ -0,0 +1,351 @@
+/*
+ * linux/arch/arm/mach-omap1/mmu.c
+ *
+ * Support for non-MPU OMAP1 MMUs.
+ *
+ * Copyright (C) 2002-2005 Nokia Corporation
+ *
+ * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *        and Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include "mmu.h"
+#include <asm/tlbflush.h>
+#include <asm/arch/dsp_common.h>
+
+static void *dspvect_page;
+#define DSP_INIT_PAGE	0xfff000
+
+#define MMUFAULT_MASK (OMAP_MMU_FAULT_ST_PERM |\
+		       OMAP_MMU_FAULT_ST_TLB_MISS |\
+		       OMAP_MMU_FAULT_ST_TRANS)
+
+static unsigned int get_cam_l_va_mask(u16 pgsz)
+{
+	switch (pgsz) {
+	case OMAP_MMU_CAM_PAGESIZE_1MB:
+		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
+		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1MB;
+	case OMAP_MMU_CAM_PAGESIZE_64KB:
+		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
+		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_64KB;
+	case OMAP_MMU_CAM_PAGESIZE_4KB:
+		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
+		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_4KB;
+	case OMAP_MMU_CAM_PAGESIZE_1KB:
+		return OMAP_MMU_CAM_L_VA_TAG_L1_MASK |
+		       OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1KB;
+	}
+	return 0;
+}
+
+#define get_cam_va_mask(pgsz) \
+	((u32)OMAP_MMU_CAM_H_VA_TAG_H_MASK << 22 | \
+	 (u32)get_cam_l_va_mask(pgsz) << 6)
+
+static int intmem_usecount;
+
+/* for safety */
+void dsp_mem_usecount_clear(void)
+{
+	if (intmem_usecount != 0) {
+		printk(KERN_WARNING
+		       "MMU: unbalanced memory request/release detected.\n"
+		       "         intmem_usecount is not zero at where "
+		       "it should be! ... fixed to be zero.\n");
+		intmem_usecount = 0;
+		omap_dsp_release_mem();
+	}
+}
+EXPORT_SYMBOL_GPL(dsp_mem_usecount_clear);
+
+void omap_mmu_itack(struct omap_mmu *mmu)
+{
+	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
+}
+EXPORT_SYMBOL(omap_mmu_itack);
+
+static int omap1_mmu_mem_enable(struct omap_mmu *mmu, void *addr)
+{
+	int ret = 0;
+
+	if (omap_mmu_internal_memory(mmu, addr)) {
+		if (intmem_usecount++ == 0)
+			ret = omap_dsp_request_mem();
+	}
+
+	return ret;
+}
+
+static int omap1_mmu_mem_disable(struct omap_mmu *mmu, void *addr)
+{
+	int ret = 0;
+
+	if (omap_mmu_internal_memory(mmu, addr)) {
+		if (--intmem_usecount == 0)
+			omap_dsp_release_mem();
+	} else
+		ret = -EIO;
+
+	return ret;
+}
+
+static inline void
+omap1_mmu_read_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	/* read a TLB entry */
+	omap_mmu_write_reg(mmu, OMAP_MMU_LD_TLB_RD, OMAP_MMU_LD_TLB);
+
+	cr->cam_h = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM_H);
+	cr->cam_l = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM_L);
+	cr->ram_h = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM_H);
+	cr->ram_l = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM_L);
+}
+
+static inline void
+omap1_mmu_load_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	/* Set the CAM and RAM entries */
+	omap_mmu_write_reg(mmu, cr->cam_h, OMAP_MMU_CAM_H);
+	omap_mmu_write_reg(mmu, cr->cam_l, OMAP_MMU_CAM_L);
+	omap_mmu_write_reg(mmu, cr->ram_h, OMAP_MMU_RAM_H);
+	omap_mmu_write_reg(mmu, cr->ram_l, OMAP_MMU_RAM_L);
+}
+
+static ssize_t omap1_mmu_show(struct omap_mmu *mmu, char *buf,
+			      struct omap_mmu_tlb_lock *tlb_lock)
+{
+	int i, len;
+
+	len = sprintf(buf, "P: preserved, V: valid\n"
+			   "ety P V size   cam_va     ram_pa ap\n");
+			 /* 00: P V  4KB 0x300000 0x10171800 FA */
+
+	for (i = 0; i < mmu->nr_tlb_entries; i++) {
+		struct omap_mmu_tlb_entry ent;
+		struct cam_ram_regset cr;
+		struct omap_mmu_tlb_lock entry_lock;
+		char *pgsz_str, *ap_str;
+
+		/* read a TLB entry */
+		entry_lock.base   = tlb_lock->base;
+		entry_lock.victim = i;
+		omap_mmu_read_tlb(mmu, &entry_lock, &cr);
+
+		ent.pgsz  = cr.cam_l & OMAP_MMU_CAM_PAGESIZE_MASK;
+		ent.prsvd = cr.cam_l & OMAP_MMU_CAM_P;
+		ent.valid = cr.cam_l & OMAP_MMU_CAM_V;
+		ent.ap    = cr.ram_l & OMAP_MMU_RAM_L_AP_MASK;
+		ent.va = (u32)(cr.cam_h & OMAP_MMU_CAM_H_VA_TAG_H_MASK) << 22 |
+			 (u32)(cr.cam_l & get_cam_l_va_mask(ent.pgsz)) << 6;
+		ent.pa = (unsigned long)cr.ram_h << 16 |
+			 (cr.ram_l & OMAP_MMU_RAM_L_RAM_LSB_MASK);
+
+		pgsz_str = (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_1MB)  ? " 1MB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_64KB) ? "64KB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_4KB)  ? " 4KB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_1KB)  ? " 1KB":
+								     " ???";
+		ap_str = (ent.ap == OMAP_MMU_RAM_L_AP_RO) ? "RO":
+			 (ent.ap == OMAP_MMU_RAM_L_AP_FA) ? "FA":
+			 (ent.ap == OMAP_MMU_RAM_L_AP_NA) ? "NA":
+							   "??";
+
+		if (i == tlb_lock->base)
+			len += sprintf(buf + len, "lock base = %d\n",
+				       tlb_lock->base);
+		if (i == tlb_lock->victim)
+			len += sprintf(buf + len, "victim    = %d\n",
+				       tlb_lock->victim);
+		len += sprintf(buf + len,
+			       /* 00: P V  4KB 0x300000 0x10171800 FA */
+			       "%02d: %c %c %s 0x%06lx 0x%08lx %s\n",
+			       i,
+			       ent.prsvd ? 'P' : ' ',
+			       ent.valid ? 'V' : ' ',
+			       pgsz_str, ent.va, ent.pa, ap_str);
+	}
+
+	return len;
+}
+
+static int exmap_setup_preserved_entries(struct omap_mmu *mmu)
+{
+	int n = 0;
+
+	exmap_setup_preserved_mem_page(mmu, dspvect_page, DSP_INIT_PAGE, n++);
+
+	return n;
+}
+
+static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
+{
+	exmap_clear_mem_page(mmu, DSP_INIT_PAGE);
+}
+
+static int omap1_mmu_startup(struct omap_mmu *mmu)
+{
+	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
+	if (dspvect_page == NULL) {
+		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+			"for vector table\n", mmu->name);
+		return -ENOMEM;
+	}
+
+	mmu->nr_exmap_preserved = exmap_setup_preserved_entries(mmu);
+
+	return 0;
+}
+
+static void omap1_mmu_shutdown(struct omap_mmu *mmu)
+{
+	exmap_clear_preserved_entries(mmu);
+
+	if (dspvect_page != NULL) {
+		unsigned long virt;
+
+		down_read(&mmu->exmap_sem);
+
+		virt = (unsigned long)omap_mmu_to_virt(mmu, DSP_INIT_PAGE);
+		flush_tlb_kernel_range(virt, virt + PAGE_SIZE);
+		free_page((unsigned long)dspvect_page);
+		dspvect_page = NULL;
+
+		up_read(&mmu->exmap_sem);
+	}
+}
+
+static inline unsigned long omap1_mmu_cam_va(struct cam_ram_regset *cr)
+{
+	unsigned int page_size = cr->cam_l & OMAP_MMU_CAM_PAGESIZE_MASK;
+
+	return (u32)(cr->cam_h & OMAP_MMU_CAM_H_VA_TAG_H_MASK)  << 22 |
+	       (u32)(cr->cam_l & get_cam_l_va_mask(page_size)) << 6;
+}
+
+static struct cam_ram_regset *
+omap1_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
+{
+	struct cam_ram_regset *cr;
+
+	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
+		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+			" an aligned boundary\n", mmu->name, entry->va);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cr = kmalloc(sizeof(struct cam_ram_regset), GFP_KERNEL);
+
+	cr->cam_h = entry->va >> 22;
+	cr->cam_l = (entry->va >> 6 & get_cam_l_va_mask(entry->pgsz)) |
+		   entry->prsvd | entry->pgsz;
+	cr->ram_h = entry->pa >> 16;
+	cr->ram_l = (entry->pa & OMAP_MMU_RAM_L_RAM_LSB_MASK) | entry->ap;
+
+	return cr;
+}
+
+static inline int omap1_mmu_cam_ram_valid(struct cam_ram_regset *cr)
+{
+	return cr->cam_l & OMAP_MMU_CAM_V;
+}
+
+static void omap1_mmu_interrupt(struct omap_mmu *mmu)
+{
+	unsigned long status;
+	unsigned long adh, adl;
+	unsigned long dp;
+	unsigned long va;
+
+	status = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_ST);
+	adh = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_H);
+	adl = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD_L);
+	dp = adh & OMAP_MMU_FAULT_AD_H_DP;
+	va = (((adh & OMAP_MMU_FAULT_AD_H_ADR_MASK) << 16) | adl);
+
+	/* if the fault is masked, nothing to do */
+	if ((status & MMUFAULT_MASK) == 0) {
+		pr_debug("MMU interrupt, but ignoring.\n");
+		/*
+		 * note: in OMAP1710,
+		 * when CACHE + DMA domain gets out of idle in DSP,
+		 * MMU interrupt occurs but MMU_FAULT_ST is not set.
+		 * in this case, we just ignore the interrupt.
+		 */
+		if (status) {
+			pr_debug("%s%s%s%s\n",
+				 (status & OMAP_MMU_FAULT_ST_PREF)?
+				 "  (prefetch err)" : "",
+				 (status & OMAP_MMU_FAULT_ST_PERM)?
+				 "  (permission fault)" : "",
+				 (status & OMAP_MMU_FAULT_ST_TLB_MISS)?
+				 "  (TLB miss)" : "",
+				 (status & OMAP_MMU_FAULT_ST_TRANS) ?
+				 "  (translation fault)": "");
+			pr_debug("fault address = %#08lx\n", va);
+		}
+		enable_irq(mmu->irq);
+		return;
+	}
+
+	pr_info("%s%s%s%s\n",
+		(status & OMAP_MMU_FAULT_ST_PREF)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PREF)?
+		"  prefetch err":
+		"  (prefetch err)":
+		"",
+		(status & OMAP_MMU_FAULT_ST_PERM)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_PERM)?
+		"  permission fault":
+		"  (permission fault)":
+		"",
+		(status & OMAP_MMU_FAULT_ST_TLB_MISS)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TLB_MISS)?
+		"  TLB miss":
+		"  (TLB miss)":
+		"",
+		(status & OMAP_MMU_FAULT_ST_TRANS)?
+		(MMUFAULT_MASK & OMAP_MMU_FAULT_ST_TRANS)?
+		"  translation fault":
+		"  (translation fault)":
+		"");
+	pr_info("fault address = %#08lx\n", va);
+
+	mmu->fault_address = va;
+	schedule_work(&mmu->irq_work);
+}
+
+static pgprot_t omap1_mmu_pte_get_attr(struct omap_mmu_tlb_entry *entry)
+{
+	/* 4KB AP position as default */
+	u32 attr = entry->ap >> 4;
+	attr <<= ((entry->pgsz == OMAP_MMU_CAM_PAGESIZE_1MB) ? 6:0);
+	return attr;
+}
+
+struct omap_mmu_ops omap1_mmu_ops = {
+	.startup	= omap1_mmu_startup,
+	.shutdown	= omap1_mmu_shutdown,
+	.mem_enable	= omap1_mmu_mem_enable,
+	.mem_disable	= omap1_mmu_mem_disable,
+	.read_tlb	= omap1_mmu_read_tlb,
+	.load_tlb	= omap1_mmu_load_tlb,
+	.show		= omap1_mmu_show,
+	.cam_va		= omap1_mmu_cam_va,
+	.cam_ram_alloc	= omap1_mmu_cam_ram_alloc,
+	.cam_ram_valid	= omap1_mmu_cam_ram_valid,
+	.interrupt	= omap1_mmu_interrupt,
+	.pte_get_attr	= omap1_mmu_pte_get_attr,
+};
+EXPORT_SYMBOL_GPL(omap1_mmu_ops);
Index: linux-2.6/arch/arm/mach-omap1/mmu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/arm/mach-omap1/mmu.h	2007-12-03 14:36:47.000000000 -0800
@@ -0,0 +1,119 @@
+#ifndef __MACH_OMAP1_MMU_H
+#define __MACH_OMAP1_MMU_H
+
+#include <asm/arch/mmu.h>
+#include <asm/io.h>
+
+#define MMU_LOCK_BASE_MASK		(0x3f << 10)
+#define MMU_LOCK_VICTIM_MASK		(0x3f << 4)
+
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
+
+#define OMAP_MMU_CNTL_BURST_16MNGT_EN	0x0020
+#define OMAP_MMU_CNTL_WTL_EN		0x0004
+#define OMAP_MMU_CNTL_MMU_EN		0x0002
+#define OMAP_MMU_CNTL_RESET_SW		0x0001
+
+#define OMAP_MMU_FAULT_AD_H_DP		0x0100
+#define OMAP_MMU_FAULT_AD_H_ADR_MASK	0x00ff
+
+#define OMAP_MMU_FAULT_ST_PREF		0x0008
+#define OMAP_MMU_FAULT_ST_PERM		0x0004
+#define OMAP_MMU_FAULT_ST_TLB_MISS	0x0002
+#define OMAP_MMU_FAULT_ST_TRANS		0x0001
+
+#define OMAP_MMU_IT_ACK_IT_ACK		0x0001
+
+#define OMAP_MMU_CAM_H_VA_TAG_H_MASK		0x0003
+
+#define OMAP_MMU_CAM_L_VA_TAG_L1_MASK		0xc000
+#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1MB	0x0000
+#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_64KB	0x3c00
+#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_4KB	0x3fc0
+#define OMAP_MMU_CAM_L_VA_TAG_L2_MASK_1KB	0x3ff0
+#define OMAP_MMU_CAM_L_P			0x0008
+#define OMAP_MMU_CAM_L_V			0x0004
+#define OMAP_MMU_CAM_L_PAGESIZE_MASK		0x0003
+#define OMAP_MMU_CAM_L_PAGESIZE_1MB		0x0000
+#define OMAP_MMU_CAM_L_PAGESIZE_64KB		0x0001
+#define OMAP_MMU_CAM_L_PAGESIZE_4KB		0x0002
+#define OMAP_MMU_CAM_L_PAGESIZE_1KB		0x0003
+
+#define OMAP_MMU_CAM_P			OMAP_MMU_CAM_L_P
+#define OMAP_MMU_CAM_V			OMAP_MMU_CAM_L_V
+#define OMAP_MMU_CAM_PAGESIZE_MASK	OMAP_MMU_CAM_L_PAGESIZE_MASK
+#define OMAP_MMU_CAM_PAGESIZE_1MB	OMAP_MMU_CAM_L_PAGESIZE_1MB
+#define OMAP_MMU_CAM_PAGESIZE_64KB	OMAP_MMU_CAM_L_PAGESIZE_64KB
+#define OMAP_MMU_CAM_PAGESIZE_4KB	OMAP_MMU_CAM_L_PAGESIZE_4KB
+#define OMAP_MMU_CAM_PAGESIZE_1KB	OMAP_MMU_CAM_L_PAGESIZE_1KB
+#define OMAP_MMU_CAM_PAGESIZE_16MB	-1 /* unused in omap1 */
+
+#define OMAP_MMU_RAM_L_RAM_LSB_MASK	0xfc00
+#define OMAP_MMU_RAM_L_AP_MASK		0x0300
+#define OMAP_MMU_RAM_L_AP_NA		0x0000
+#define OMAP_MMU_RAM_L_AP_RO		0x0200
+#define OMAP_MMU_RAM_L_AP_FA		0x0300
+
+#define OMAP_MMU_LD_TLB_RD		0x0002
+
+#define INIT_TLB_ENTRY(ent, v, p, ps)			\
+do {							\
+	(ent)->va	= (v);				\
+	(ent)->pa	= (p);				\
+	(ent)->pgsz	= (ps);				\
+	(ent)->prsvd	= 0;				\
+	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
+	(ent)->tlb	= 1;				\
+} while (0)
+
+#define INIT_TLB_ENTRY_4KB_PRESERVED(ent, v, p)	\
+do {							\
+	(ent)->va	= (v);				\
+	(ent)->pa	= (p);				\
+	(ent)->pgsz	= OMAP_MMU_CAM_PAGESIZE_4KB;	\
+	(ent)->prsvd	= OMAP_MMU_CAM_P;		\
+	(ent)->ap	= OMAP_MMU_RAM_L_AP_FA;		\
+} while (0)
+
+struct omap_mmu_tlb_entry {
+	unsigned long va;
+	unsigned long pa;
+	unsigned int pgsz, prsvd, valid;
+
+	u16 ap;
+	unsigned int tlb;
+};
+
+static inline unsigned short
+omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
+{
+	return __raw_readw(mmu->base + reg);
+}
+
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
+			       unsigned short val, unsigned long reg)
+{
+	__raw_writew(val, mmu->base + reg);
+}
+
+#endif /* __MACH_OMAP1_MMU_H */
Index: linux-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/Makefile	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/arch/arm/mach-omap2/Makefile	2007-12-03 14:36:47.000000000 -0800
@@ -11,6 +11,9 @@ obj-$(CONFIG_OMAP_MPU_TIMER)		+= timer-g
 # Power Management
 obj-$(CONFIG_PM) += pm.o pm-domain.o sleep.o
 
+obj-$(CONFIG_OMAP_MMU_FWK)		+= mmu_mach.o
+mmu_mach-objs				:= mmu.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
Index: linux-2.6/arch/arm/mach-omap2/mmu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/arm/mach-omap2/mmu.c	2007-12-03 14:36:47.000000000 -0800
@@ -0,0 +1,330 @@
+/*
+ * linux/arch/arm/mach-omap2/mmu.c
+ *
+ * Support for non-MPU OMAP2 MMUs.
+ *
+ * Copyright (C) 2002-2007 Nokia Corporation
+ *
+ * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *        and Paul Mundt <paul.mundt@nokia.com>
+ *
+ * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include "mmu.h"
+#include <asm/arch/mmu.h>
+#include <asm/tlbflush.h>
+#include <asm/io.h>
+#include <asm/sizes.h>
+
+static void *dspvect_page;
+#define DSP_INIT_PAGE	0xfff000
+
+static inline void
+omap2_mmu_read_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	cr->cam = omap_mmu_read_reg(mmu, OMAP_MMU_READ_CAM);
+	cr->ram = omap_mmu_read_reg(mmu, OMAP_MMU_READ_RAM);
+}
+
+static inline void
+omap2_mmu_load_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	/* Set the CAM and RAM entries */
+	omap_mmu_write_reg(mmu, cr->cam | OMAP_MMU_CAM_V, OMAP_MMU_CAM);
+	omap_mmu_write_reg(mmu, cr->ram, OMAP_MMU_RAM);
+}
+
+static void exmap_setup_iomap_page(struct omap_mmu *mmu, unsigned long phys,
+				   unsigned long dsp_io_adr, int index)
+{
+	unsigned long dspadr;
+	void *virt;
+	struct omap_mmu_tlb_entry tlb_ent;
+
+	dspadr = (IOMAP_VAL << 18) + (dsp_io_adr << 1);
+	virt = omap_mmu_to_virt(mmu, dspadr);
+	exmap_set_armmmu(mmu, (unsigned long)virt, phys, PAGE_SIZE);
+	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, NULL, virt);
+	INIT_TLB_ENTRY_4KB_ES32_PRESERVED(&tlb_ent, dspadr, phys);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
+}
+
+static void exmap_clear_iomap_page(struct omap_mmu *mmu,
+				   unsigned long dsp_io_adr)
+{
+	unsigned long dspadr;
+	void *virt;
+
+	dspadr = (IOMAP_VAL << 18) + (dsp_io_adr << 1);
+	virt = omap_mmu_to_virt(mmu, dspadr);
+	exmap_clear_armmmu(mmu, (unsigned long)virt, PAGE_SIZE);
+	/* DSP MMU is shutting down. not handled here. */
+}
+
+#define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
+#define OMAP2420_GPT5_BASE	(L4_24XX_BASE + 0x7c000)
+#define OMAP2420_GPT6_BASE	(L4_24XX_BASE + 0x7e000)
+#define OMAP2420_GPT7_BASE	(L4_24XX_BASE + 0x80000)
+#define OMAP2420_GPT8_BASE	(L4_24XX_BASE + 0x82000)
+#define OMAP24XX_EAC_BASE	(L4_24XX_BASE + 0x90000)
+#define OMAP24XX_STI_BASE	(L4_24XX_BASE + 0x68000)
+#define OMAP24XX_STI_CH_BASE	(L4_24XX_BASE + 0x0c000000)
+
+static int exmap_setup_preserved_entries(struct omap_mmu *mmu)
+{
+	int i, n = 0;
+
+	exmap_setup_preserved_mem_page(mmu, dspvect_page, DSP_INIT_PAGE, n++);
+
+	/* REVISIT: This will need to be revisited for 3430 */
+	exmap_setup_iomap_page(mmu, OMAP2_PRCM_BASE, 0x7000, n++);
+	exmap_setup_iomap_page(mmu, OMAP24XX_MAILBOX_BASE, 0x11000, n++);
+
+	if (cpu_is_omap2420()) {
+		exmap_setup_iomap_page(mmu, OMAP2420_GPT5_BASE, 0xe000, n++);
+		exmap_setup_iomap_page(mmu, OMAP2420_GPT6_BASE, 0xe800, n++);
+		exmap_setup_iomap_page(mmu, OMAP2420_GPT7_BASE, 0xf000, n++);
+		exmap_setup_iomap_page(mmu, OMAP2420_GPT8_BASE, 0xf800, n++);
+		exmap_setup_iomap_page(mmu, OMAP24XX_EAC_BASE,  0x10000, n++);
+		exmap_setup_iomap_page(mmu, OMAP24XX_STI_BASE, 0xc800, n++);
+		for (i = 0; i < 5; i++)
+			exmap_setup_preserved_mem_page(mmu,
+				__va(OMAP24XX_STI_CH_BASE + i*SZ_4K),
+				0xfb0000 + i*SZ_4K, n++);
+	}
+
+	return n;
+}
+
+static void exmap_clear_preserved_entries(struct omap_mmu *mmu)
+{
+	int i;
+
+	exmap_clear_iomap_page(mmu, 0x7000);	/* PRCM registers */
+	exmap_clear_iomap_page(mmu, 0x11000);	/* MAILBOX registers */
+
+	if (cpu_is_omap2420()) {
+		exmap_clear_iomap_page(mmu, 0xe000);	/* GPT5 */
+		exmap_clear_iomap_page(mmu, 0xe800);	/* GPT6 */
+		exmap_clear_iomap_page(mmu, 0xf000);	/* GPT7 */
+		exmap_clear_iomap_page(mmu, 0xf800);	/* GPT8 */
+		exmap_clear_iomap_page(mmu, 0x10000);	/* EAC */
+		exmap_clear_iomap_page(mmu, 0xc800);	/* STI */
+		for (i = 0; i < 5; i++)			/* STI CH */
+			exmap_clear_mem_page(mmu, 0xfb0000 + i*SZ_4K);
+	}
+
+	exmap_clear_mem_page(mmu, DSP_INIT_PAGE);
+}
+
+#define MMU_IRQ_MASK \
+	(OMAP_MMU_IRQ_MULTIHITFAULT | \
+	 OMAP_MMU_IRQ_TABLEWALKFAULT | \
+	 OMAP_MMU_IRQ_EMUMISS | \
+	 OMAP_MMU_IRQ_TRANSLATIONFAULT)
+
+static int omap2_mmu_startup(struct omap_mmu *mmu)
+{
+	u32 rev = omap_mmu_read_reg(mmu, OMAP_MMU_REVISION);
+
+	pr_info("MMU: OMAP %s MMU initialized (HW v%d.%d)\n", mmu->name,
+		(rev >> 4) & 0xf, rev & 0xf);
+
+	dspvect_page = (void *)__get_dma_pages(GFP_KERNEL, 0);
+	if (dspvect_page == NULL) {
+		dev_err(&mmu->dev, "MMU %s: failed to allocate memory "
+			"for vector table\n", mmu->name);
+		return -ENOMEM;
+	}
+
+	mmu->nr_exmap_preserved = exmap_setup_preserved_entries(mmu);
+
+	omap_mmu_write_reg(mmu, MMU_IRQ_MASK, OMAP_MMU_IRQENABLE);
+
+	return 0;
+}
+
+static void omap2_mmu_shutdown(struct omap_mmu *mmu)
+{
+	exmap_clear_preserved_entries(mmu);
+
+	if (dspvect_page != NULL) {
+		unsigned long virt;
+
+		down_read(&mmu->exmap_sem);
+
+		virt = (unsigned long)omap_mmu_to_virt(mmu, DSP_INIT_PAGE);
+		flush_tlb_kernel_range(virt, virt + PAGE_SIZE);
+		free_page((unsigned long)dspvect_page);
+		dspvect_page = NULL;
+
+		up_read(&mmu->exmap_sem);
+	}
+}
+
+static ssize_t omap2_mmu_show(struct omap_mmu *mmu, char *buf,
+			      struct omap_mmu_tlb_lock *tlb_lock)
+{
+	int i, len;
+
+	len = sprintf(buf, "P: preserved, V: valid\n"
+			   "B: big endian, L:little endian, "
+			   "M: mixed page attribute\n"
+			   "ety P V size   cam_va     ram_pa E ES M\n");
+			 /* 00: P V  4KB 0x300000 0x10171800 B 16 M */
+
+	for (i = 0; i < mmu->nr_tlb_entries; i++) {
+		struct omap_mmu_tlb_entry ent;
+		struct cam_ram_regset cr;
+		struct omap_mmu_tlb_lock entry_lock;
+		char *pgsz_str, *elsz_str;
+
+		/* read a TLB entry */
+		entry_lock.base   = tlb_lock->base;
+		entry_lock.victim = i;
+		omap_mmu_read_tlb(mmu, &entry_lock, &cr);
+
+		ent.pgsz   = cr.cam & OMAP_MMU_CAM_PAGESIZE_MASK;
+		ent.prsvd  = cr.cam & OMAP_MMU_CAM_P;
+		ent.valid  = cr.cam & OMAP_MMU_CAM_V;
+		ent.va     = cr.cam & OMAP_MMU_CAM_VATAG_MASK;
+		ent.endian = cr.ram & OMAP_MMU_RAM_ENDIANNESS;
+		ent.elsz   = cr.ram & OMAP_MMU_RAM_ELEMENTSIZE_MASK;
+		ent.pa     = cr.ram & OMAP_MMU_RAM_PADDR_MASK;
+		ent.mixed  = cr.ram & OMAP_MMU_RAM_MIXED;
+
+		pgsz_str = (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_16MB) ? "64MB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_1MB)  ? " 1MB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_64KB) ? "64KB":
+			   (ent.pgsz == OMAP_MMU_CAM_PAGESIZE_4KB)  ? " 4KB":
+								     " ???";
+		elsz_str = (ent.elsz == OMAP_MMU_RAM_ELEMENTSIZE_8)  ? " 8":
+			   (ent.elsz == OMAP_MMU_RAM_ELEMENTSIZE_16) ? "16":
+			   (ent.elsz == OMAP_MMU_RAM_ELEMENTSIZE_32) ? "32":
+								      "??";
+
+		if (i == tlb_lock->base)
+			len += sprintf(buf + len, "lock base = %d\n",
+				       tlb_lock->base);
+		if (i == tlb_lock->victim)
+			len += sprintf(buf + len, "victim    = %d\n",
+				       tlb_lock->victim);
+
+		len += sprintf(buf + len,
+			       /* 00: P V  4KB 0x300000 0x10171800 B 16 M */
+			       "%02d: %c %c %s 0x%06lx 0x%08lx %c %s %c\n",
+			       i,
+			       ent.prsvd ? 'P' : ' ',
+			       ent.valid ? 'V' : ' ',
+			       pgsz_str, ent.va, ent.pa,
+			       ent.endian ? 'B' : 'L',
+			       elsz_str,
+			       ent.mixed ? 'M' : ' ');
+	}
+
+	return len;
+}
+
+#define get_cam_va_mask(pgsz) \
+	(((pgsz) == OMAP_MMU_CAM_PAGESIZE_16MB) ? 0xff000000 : \
+	 ((pgsz) == OMAP_MMU_CAM_PAGESIZE_1MB)  ? 0xfff00000 : \
+	 ((pgsz) == OMAP_MMU_CAM_PAGESIZE_64KB) ? 0xffff0000 : \
+	 ((pgsz) == OMAP_MMU_CAM_PAGESIZE_4KB)  ? 0xfffff000 : 0)
+
+static inline unsigned long omap2_mmu_cam_va(struct cam_ram_regset *cr)
+{
+	unsigned int page_size = cr->cam & OMAP_MMU_CAM_PAGESIZE_MASK;
+	unsigned int mask = get_cam_va_mask(cr->cam & page_size);
+
+	return cr->cam & mask;
+}
+
+static struct cam_ram_regset *
+omap2_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
+{
+	struct cam_ram_regset *cr;
+
+	if (entry->va & ~(get_cam_va_mask(entry->pgsz))) {
+		dev_err(&mmu->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+			" an aligned boundary\n", mmu->name, entry->va);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cr = kmalloc(sizeof(struct cam_ram_regset), GFP_KERNEL);
+
+	cr->cam = (entry->va & OMAP_MMU_CAM_VATAG_MASK) |
+		  entry->prsvd | entry->pgsz;
+	cr->ram = entry->pa | entry->endian | entry->elsz;
+
+	return cr;
+}
+
+static inline int omap2_mmu_cam_ram_valid(struct cam_ram_regset *cr)
+{
+	return cr->cam & OMAP_MMU_CAM_V;
+}
+
+static void omap2_mmu_interrupt(struct omap_mmu *mmu)
+{
+	unsigned long status, va;
+
+	status = MMU_IRQ_MASK & omap_mmu_read_reg(mmu, OMAP_MMU_IRQSTATUS);
+	va = omap_mmu_read_reg(mmu, OMAP_MMU_FAULT_AD);
+
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_MULTIHITFAULT)?
+		"multi hit":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TABLEWALKFAULT)?
+		"table walk fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_EMUMISS)?
+		"EMU miss":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TRANSLATIONFAULT)?
+		"translation fault":"");
+	pr_info("%s\n", (status & OMAP_MMU_IRQ_TLBMISS)?
+		"TLB miss":"");
+	pr_info("fault address = %#08lx\n", va);
+
+	omap_mmu_disable(mmu);
+	omap_mmu_write_reg(mmu, status, OMAP_MMU_IRQSTATUS);
+
+	mmu->fault_address = va;
+	schedule_work(&mmu->irq_work);
+}
+
+static pgprot_t omap2_mmu_pte_get_attr(struct omap_mmu_tlb_entry *entry)
+{
+	u32 attr;
+
+	attr = entry->mixed << 5;
+	attr |= entry->endian;
+	attr |= entry->elsz >> 3;
+	attr <<= ((entry->pgsz & OMAP_MMU_CAM_PAGESIZE_4KB) ? 0:6);
+
+	return attr;
+}
+
+struct omap_mmu_ops omap2_mmu_ops = {
+	.startup	= omap2_mmu_startup,
+	.shutdown	= omap2_mmu_shutdown,
+	.read_tlb	= omap2_mmu_read_tlb,
+	.load_tlb	= omap2_mmu_load_tlb,
+	.show		= omap2_mmu_show,
+	.cam_va		= omap2_mmu_cam_va,
+	.cam_ram_alloc	= omap2_mmu_cam_ram_alloc,
+	.cam_ram_valid	= omap2_mmu_cam_ram_valid,
+	.interrupt	= omap2_mmu_interrupt,
+	.pte_get_attr	= omap2_mmu_pte_get_attr,
+};
+EXPORT_SYMBOL_GPL(omap2_mmu_ops);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6/arch/arm/mach-omap2/mmu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/arm/mach-omap2/mmu.h	2007-12-03 14:36:47.000000000 -0800
@@ -0,0 +1,117 @@
+#ifndef __MACH_OMAP2_MMU_H
+#define __MACH_OMAP2_MMU_H
+
+#include <asm/arch/mmu.h>
+#include <asm/io.h>
+
+#define MMU_LOCK_BASE_MASK		(0x1f << 10)
+#define MMU_LOCK_VICTIM_MASK		(0x1f << 4)
+
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
+#define OMAP_MMU_IRQ_MULTIHITFAULT	0x00000010
+#define OMAP_MMU_IRQ_TABLEWALKFAULT	0x00000008
+#define OMAP_MMU_IRQ_EMUMISS		0x00000004
+#define OMAP_MMU_IRQ_TRANSLATIONFAULT	0x00000002
+#define OMAP_MMU_IRQ_TLBMISS		0x00000001
+
+#define OMAP_MMU_CAM_VATAG_MASK		0xfffff000
+#define OMAP_MMU_CAM_P			0x00000008
+#define OMAP_MMU_CAM_V			0x00000004
+#define OMAP_MMU_CAM_PAGESIZE_MASK	0x00000003
+#define OMAP_MMU_CAM_PAGESIZE_1MB	0x00000000
+#define OMAP_MMU_CAM_PAGESIZE_64KB	0x00000001
+#define OMAP_MMU_CAM_PAGESIZE_4KB	0x00000002
+#define OMAP_MMU_CAM_PAGESIZE_16MB	0x00000003
+
+#define OMAP_MMU_RAM_PADDR_MASK		0xfffff000
+#define OMAP_MMU_RAM_ENDIANNESS		0x00000200
+#define OMAP_MMU_RAM_ENDIANNESS_BIG	0x00000200
+#define OMAP_MMU_RAM_ENDIANNESS_LITTLE	0x00000000
+#define OMAP_MMU_RAM_ELEMENTSIZE_MASK	0x00000180
+#define OMAP_MMU_RAM_ELEMENTSIZE_8	0x00000000
+#define OMAP_MMU_RAM_ELEMENTSIZE_16	0x00000080
+#define OMAP_MMU_RAM_ELEMENTSIZE_32	0x00000100
+#define OMAP_MMU_RAM_ELEMENTSIZE_NONE	0x00000180
+#define OMAP_MMU_RAM_MIXED		0x00000040
+
+#define IOMAP_VAL	0x3f
+
+#define INIT_TLB_ENTRY(ent, v, p, ps)				\
+do {								\
+	(ent)->va	= (v);					\
+	(ent)->pa	= (p);					\
+	(ent)->pgsz	= (ps);					\
+	(ent)->prsvd	= 0;					\
+	(ent)->endian	= OMAP_MMU_RAM_ENDIANNESS_LITTLE;	\
+	(ent)->elsz	= OMAP_MMU_RAM_ELEMENTSIZE_16;		\
+	(ent)->mixed	= 0;					\
+	(ent)->tlb	= 1;					\
+} while (0)
+
+#define INIT_TLB_ENTRY_4KB_PRESERVED(ent, v, p)		\
+do {								\
+	(ent)->va	= (v);					\
+	(ent)->pa	= (p);					\
+	(ent)->pgsz	= OMAP_MMU_CAM_PAGESIZE_4KB;		\
+	(ent)->prsvd	= OMAP_MMU_CAM_P;			\
+	(ent)->endian	= OMAP_MMU_RAM_ENDIANNESS_LITTLE;	\
+	(ent)->elsz	= OMAP_MMU_RAM_ELEMENTSIZE_16;		\
+	(ent)->mixed	= 0;					\
+} while (0)
+
+#define INIT_TLB_ENTRY_4KB_ES32_PRESERVED(ent, v, p)		\
+do {								\
+	(ent)->va	= (v);					\
+	(ent)->pa	= (p);					\
+	(ent)->pgsz	= OMAP_MMU_CAM_PAGESIZE_4KB;		\
+	(ent)->prsvd	= OMAP_MMU_CAM_P;			\
+	(ent)->endian	= OMAP_MMU_RAM_ENDIANNESS_LITTLE;	\
+	(ent)->elsz	= OMAP_MMU_RAM_ELEMENTSIZE_32;		\
+	(ent)->mixed	= 0;					\
+} while (0)
+
+struct omap_mmu_tlb_entry {
+	unsigned long va;
+	unsigned long pa;
+	unsigned int pgsz, prsvd, valid;
+
+	u32 endian, elsz, mixed;
+	unsigned int tlb;
+};
+
+static inline unsigned long
+omap_mmu_read_reg(struct omap_mmu *mmu, unsigned long reg)
+{
+	return __raw_readl(mmu->base + reg);
+}
+
+static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
+			       unsigned long val, unsigned long reg)
+{
+	__raw_writel(val, mmu->base + reg);
+}
+
+#endif /* __MACH_OMAP2_MMU_H */
Index: linux-2.6/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/Kconfig	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/arch/arm/plat-omap/Kconfig	2007-12-03 14:36:47.000000000 -0800
@@ -76,6 +76,14 @@ config OMAP_MCBSP
 	  Say Y here if you want support for the OMAP Multichannel
 	  Buffered Serial Port.
 
+config OMAP_MMU_FWK
+	tristate "MMU framework support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want to use OMAP MMU framework support for
+	  DSP, IVA1.0 and Camera in OMAP1/2.
+
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
Index: linux-2.6/arch/arm/plat-omap/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/Makefile	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/arch/arm/plat-omap/Makefile	2007-12-03 14:36:47.000000000 -0800
@@ -19,3 +19,6 @@ obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
+
+# OMAP MMU framework
+obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
Index: linux-2.6/arch/arm/plat-omap/mmu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/arm/plat-omap/mmu.c	2007-12-03 14:37:17.000000000 -0800
@@ -0,0 +1,1569 @@
+/*
+ * linux/arch/arm/plat-omap/mmu.c
+ *
+ * OMAP MMU management framework
+ *
+ * Copyright (C) 2002-2006 Nokia Corporation
+ *
+ * Written by Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
+ *        and Paul Mundt <lethal@linux-sh.org>
+ *
+ * TWL support: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/mempool.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/arch/mmu.h>
+#include <asm/sizes.h>
+#include <asm/arch/dsp_common.h>
+
+#if defined(CONFIG_ARCH_OMAP1)
+#include "../mach-omap1/mmu.h"
+#elif defined(CONFIG_ARCH_OMAP2)
+#include "../mach-omap2/mmu.h"
+#endif
+
+/*
+ * On OMAP2 MMU_LOCK_xxx_MASK only applies to the IVA and DSP, the camera
+ * MMU has base and victim implemented in different bits in the LOCK
+ * register (shifts are still the same), all of the other registers are
+ * the same on all of the MMUs..
+ */
+#define MMU_LOCK_BASE_SHIFT		10
+#define MMU_LOCK_VICTIM_SHIFT		4
+
+#define CAMERA_MMU_LOCK_BASE_MASK	(0x7 << MMU_LOCK_BASE_SHIFT)
+#define CAMERA_MMU_LOCK_VICTIM_MASK	(0x7 << MMU_LOCK_VICTIM_SHIFT)
+
+#define is_aligned(adr, align)	(!((adr)&((align)-1)))
+#define ORDER_1MB	(20 - PAGE_SHIFT)
+#define ORDER_64KB	(16 - PAGE_SHIFT)
+#define ORDER_4KB	(12 - PAGE_SHIFT)
+
+#define MMU_CNTL_EMUTLBUPDATE	(1<<3)
+#define MMU_CNTL_TWLENABLE	(1<<2)
+#define MMU_CNTL_MMUENABLE	(1<<1)
+
+static mempool_t *mempool_1M;
+static mempool_t *mempool_64K;
+
+#define omap_mmu_for_each_tlb_entry(mmu, entry)			\
+	for (entry = mmu->exmap_tbl; prefetch(entry + 1),	\
+	     entry < (mmu->exmap_tbl + mmu->nr_tlb_entries);	\
+	     entry++)
+
+#define to_dev(obj)	container_of(obj, struct device, kobj)
+
+static void *mempool_alloc_from_pool(mempool_t *pool,
+				     unsigned int __nocast gfp_mask)
+{
+	spin_lock_irq(&pool->lock);
+	if (likely(pool->curr_nr)) {
+		void *element = pool->elements[--pool->curr_nr];
+		spin_unlock_irq(&pool->lock);
+		return element;
+	}
+
+	spin_unlock_irq(&pool->lock);
+	return mempool_alloc(pool, gfp_mask);
+}
+
+/*
+ * kmem_reserve(), kmem_release():
+ * reserve or release kernel memory for exmap().
+ *
+ * exmap() might request consecutive 1MB or 64kB,
+ * but it will be difficult after memory pages are fragmented.
+ * So, user can reserve such memory blocks in the early phase
+ * through kmem_reserve().
+ */
+static void *omap_mmu_pool_alloc(unsigned int __nocast gfp, void *order)
+{
+	return (void *)__get_dma_pages(gfp, (unsigned int)order);
+}
+
+static void omap_mmu_pool_free(void *buf, void *order)
+{
+	free_pages((unsigned long)buf, (unsigned int)order);
+}
+
+int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size)
+{
+	unsigned long len = size;
+
+	/* alignment check */
+	if (!is_aligned(size, SZ_64K)) {
+		dev_err(&mmu->dev,
+			"MMU %s: size(0x%lx) is not multiple of 64KB.\n",
+			mmu->name, size);
+		return -EINVAL;
+	}
+
+	if (size > (1 << mmu->addrspace)) {
+		dev_err(&mmu->dev,
+			"MMU %s: size(0x%lx) is larger than external device "
+			" memory space size (0x%x.\n", mmu->name, size,
+			(1 << mmu->addrspace));
+		return -EINVAL;
+	}
+
+	if (size >= SZ_1M) {
+		int nr = size >> 20;
+
+		if (likely(!mempool_1M))
+			mempool_1M = mempool_create(nr, omap_mmu_pool_alloc,
+						    omap_mmu_pool_free,
+						    (void *)ORDER_1MB);
+		else
+			mempool_resize(mempool_1M, mempool_1M->min_nr + nr,
+				       GFP_KERNEL);
+
+		size &= ~(0xf << 20);
+	}
+
+	if (size >= SZ_64K) {
+		int nr = size >> 16;
+
+		if (likely(!mempool_64K))
+			mempool_64K = mempool_create(nr, omap_mmu_pool_alloc,
+						     omap_mmu_pool_free,
+						     (void *)ORDER_64KB);
+		else
+			mempool_resize(mempool_64K, mempool_64K->min_nr + nr,
+				       GFP_KERNEL);
+
+		size &= ~(0xf << 16);
+	}
+
+	if (size)
+		len -= size;
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_kmem_reserve);
+
+void omap_mmu_kmem_release(void)
+{
+	if (mempool_64K) {
+		mempool_destroy(mempool_64K);
+		mempool_64K = NULL;
+	}
+
+	if (mempool_1M) {
+		mempool_destroy(mempool_1M);
+		mempool_1M = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(omap_mmu_kmem_release);
+
+static void omap_mmu_free_pages(unsigned long buf, unsigned int order)
+{
+	struct page *page, *ps, *pe;
+
+	ps = virt_to_page(buf);
+	pe = virt_to_page(buf + (1 << (PAGE_SHIFT + order)));
+
+	for (page = ps; page < pe; page++)
+		ClearPageReserved(page);
+
+	if ((order == ORDER_64KB) && likely(mempool_64K))
+		mempool_free((void *)buf, mempool_64K);
+	else if ((order == ORDER_1MB) && likely(mempool_1M))
+		mempool_free((void *)buf, mempool_1M);
+	else
+		free_pages(buf, order);
+}
+
+/*
+ * ARM MMU operations
+ */
+int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
+		     unsigned long phys, unsigned long size)
+{
+	long off;
+	unsigned long sz_left;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	int prot_pmd, prot_pte;
+
+	dev_dbg(&mmu->dev,
+		"MMU %s: mapping in ARM MMU, v=0x%08lx, p=0x%08lx, sz=0x%lx\n",
+		mmu->name, virt, phys, size);
+
+	prot_pmd = PMD_TYPE_TABLE | PMD_DOMAIN(DOMAIN_IO);
+	prot_pte = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_WRITE;
+
+	pmdp = pmd_offset(pgd_offset_k(virt), virt);
+	if (pmd_none(*pmdp)) {
+		ptep = pte_alloc_one_kernel(&init_mm, 0);
+		if (ptep == NULL)
+			return -ENOMEM;
+		/* note: two PMDs will be set  */
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+
+	off = phys - virt;
+	for (sz_left = size;
+	     sz_left >= PAGE_SIZE;
+	     sz_left -= PAGE_SIZE, virt += PAGE_SIZE) {
+		ptep = pte_offset_kernel(pmdp, virt);
+		set_pte_ext(ptep, __pte((virt + off) | prot_pte), 0);
+	}
+	if (sz_left)
+		BUG();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(exmap_set_armmmu);
+
+void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
+			unsigned long size)
+{
+	unsigned long sz_left;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	dev_dbg(&mmu->dev,
+		"MMU %s: unmapping in ARM MMU, v=0x%08lx, sz=0x%lx\n",
+		mmu->name, virt, size);
+
+	for (sz_left = size;
+	     sz_left >= PAGE_SIZE;
+	     sz_left -= PAGE_SIZE, virt += PAGE_SIZE) {
+		pmdp = pmd_offset(pgd_offset_k(virt), virt);
+		ptep = pte_offset_kernel(pmdp, virt);
+		pte_clear(&init_mm, virt, ptep);
+	}
+	if (sz_left)
+		BUG();
+}
+EXPORT_SYMBOL_GPL(exmap_clear_armmmu);
+
+int exmap_valid(struct omap_mmu *mmu, void *vadr, size_t len)
+{
+	/* exmap_sem should be held before calling this function */
+	struct exmap_tbl *ent;
+
+start:
+	omap_mmu_for_each_tlb_entry(mmu, ent) {
+		void *mapadr;
+		unsigned long mapsize;
+
+		if (!ent->valid)
+			continue;
+		mapadr = (void *)ent->vadr;
+		mapsize = 1 << (ent->order + PAGE_SHIFT);
+		if ((vadr >= mapadr) && (vadr < mapadr + mapsize)) {
+			if (vadr + len <= mapadr + mapsize) {
+				/* this map covers whole address. */
+				return 1;
+			} else {
+				/*
+				 * this map covers partially.
+				 * check rest portion.
+				 */
+				len -= mapadr + mapsize - vadr;
+				vadr = mapadr + mapsize;
+				goto start;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(exmap_valid);
+
+/*
+ * omap_mmu_exmap_use(), unuse():
+ * when the mapped area is exported to user space with mmap,
+ * the usecount is incremented.
+ * while the usecount > 0, that area can't be released.
+ */
+void omap_mmu_exmap_use(struct omap_mmu *mmu, void *vadr, size_t len)
+{
+	struct exmap_tbl *ent;
+
+	down_write(&mmu->exmap_sem);
+	omap_mmu_for_each_tlb_entry(mmu, ent) {
+		void *mapadr;
+		unsigned long mapsize;
+
+		if (!ent->valid)
+			continue;
+		mapadr = (void *)ent->vadr;
+		mapsize = 1 << (ent->order + PAGE_SHIFT);
+		if ((vadr + len > mapadr) && (vadr < mapadr + mapsize))
+			ent->usecount++;
+	}
+	up_write(&mmu->exmap_sem);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_exmap_use);
+
+void omap_mmu_exmap_unuse(struct omap_mmu *mmu, void *vadr, size_t len)
+{
+	struct exmap_tbl *ent;
+
+	down_write(&mmu->exmap_sem);
+	omap_mmu_for_each_tlb_entry(mmu, ent) {
+		void *mapadr;
+		unsigned long mapsize;
+
+		if (!ent->valid)
+			continue;
+		mapadr = (void *)ent->vadr;
+		mapsize = 1 << (ent->order + PAGE_SHIFT);
+		if ((vadr + len > mapadr) && (vadr < mapadr + mapsize))
+			ent->usecount--;
+	}
+	up_write(&mmu->exmap_sem);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_exmap_unuse);
+
+/*
+ * omap_mmu_virt_to_phys()
+ * returns physical address, and sets len to valid length
+ */
+unsigned long
+omap_mmu_virt_to_phys(struct omap_mmu *mmu, void *vadr, size_t *len)
+{
+	struct exmap_tbl *ent;
+
+	if (omap_mmu_internal_memory(mmu, vadr)) {
+		unsigned long addr = (unsigned long)vadr;
+		*len = mmu->membase + mmu->memsize - addr;
+		return addr;
+	}
+
+	/* EXRAM */
+	omap_mmu_for_each_tlb_entry(mmu, ent) {
+		void *mapadr;
+		unsigned long mapsize;
+
+		if (!ent->valid)
+			continue;
+		mapadr = (void *)ent->vadr;
+		mapsize = 1 << (ent->order + PAGE_SHIFT);
+		if ((vadr >= mapadr) && (vadr < mapadr + mapsize)) {
+			*len = mapadr + mapsize - vadr;
+			return __pa(ent->buf) + vadr - mapadr;
+		}
+	}
+
+	/* valid mapping not found */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_virt_to_phys);
+
+/*
+ * PTE operations
+ */
+static inline void
+omap_mmu_alloc_section(struct mm_struct *mm, unsigned long virt,
+		       unsigned long phys, int prot)
+{
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+	if (virt & (1 << SECTION_SHIFT))
+		pmdp++;
+	*pmdp = __pmd((phys & SECTION_MASK) | prot | PMD_TYPE_SECT);
+	flush_pmd_entry(pmdp);
+}
+
+static inline void
+omap_mmu_alloc_supersection(struct mm_struct *mm, unsigned long virt,
+			    unsigned long phys, int prot)
+{
+	int i;
+	for (i = 0; i < 16; i += 1) {
+		omap_mmu_alloc_section(mm, virt, phys, prot | PMD_SECT_SUPER);
+		virt += (PGDIR_SIZE / 2);
+	}
+}
+
+static inline int
+omap_mmu_alloc_page(struct mm_struct *mm, unsigned long virt,
+		    unsigned long phys, pgprot_t prot)
+{
+	pte_t *ptep;
+	pmd_t *pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+
+	if (!(prot & PTE_TYPE_MASK))
+		prot |= PTE_TYPE_SMALL;
+
+	if (pmd_none(*pmdp)) {
+		ptep = pte_alloc_one_kernel(mm, virt);
+		if (ptep == NULL)
+			return -ENOMEM;
+		pmd_populate_kernel(mm, pmdp, ptep);
+	}
+	ptep = pte_offset_kernel(pmdp, virt);
+	ptep -= PTRS_PER_PTE;
+	*ptep = pfn_pte(phys >> PAGE_SHIFT, prot);
+	flush_pmd_entry((pmd_t *)ptep);
+	return 0;
+}
+
+static inline int
+omap_mmu_alloc_largepage(struct mm_struct *mm, unsigned long virt,
+			 unsigned long phys, pgprot_t prot)
+{
+	int i, ret;
+	for (i = 0; i < 16; i += 1) {
+		ret = omap_mmu_alloc_page(mm, virt, phys,
+					  prot | PTE_TYPE_LARGE);
+		if (ret)
+			return -ENOMEM; /* only 1st time */
+		virt += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static int omap_mmu_load_pte(struct omap_mmu *mmu,
+			     struct omap_mmu_tlb_entry *e)
+{
+	int ret = 0;
+	struct mm_struct *mm = mmu->twl_mm;
+	const unsigned long va = e->va;
+	const unsigned long pa = e->pa;
+	const pgprot_t prot = mmu->ops->pte_get_attr(e);
+
+	spin_lock(&mm->page_table_lock);
+
+	switch (e->pgsz) {
+	case OMAP_MMU_CAM_PAGESIZE_16MB:
+		omap_mmu_alloc_supersection(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_1MB:
+		omap_mmu_alloc_section(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_64KB:
+		ret = omap_mmu_alloc_largepage(mm, va, pa, prot);
+		break;
+	case OMAP_MMU_CAM_PAGESIZE_4KB:
+		ret = omap_mmu_alloc_page(mm, va, pa, prot);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	spin_unlock(&mm->page_table_lock);
+
+	return ret;
+}
+
+static void omap_mmu_clear_pte(struct omap_mmu *mmu, unsigned long virt)
+{
+	pte_t *ptep, *end;
+	pmd_t *pmdp;
+	struct mm_struct *mm = mmu->twl_mm;
+
+	spin_lock(&mm->page_table_lock);
+
+	pmdp = pmd_offset(pgd_offset(mm, virt), virt);
+
+	if (pmd_none(*pmdp))
+		goto out;
+
+	if (!pmd_table(*pmdp))
+		goto invalidate_pmd;
+
+	ptep = pte_offset_kernel(pmdp, virt);
+	pte_clear(mm, virt, ptep);
+	flush_pmd_entry((pmd_t *)ptep);
+
+	/* zap pte */
+	end = pmd_page_vaddr(*pmdp);
+	ptep = end - PTRS_PER_PTE;
+	while (ptep < end) {
+		if (!pte_none(*ptep))
+			goto out;
+		ptep++;
+	}
+	pte_free_kernel(pmd_page_vaddr(*pmdp));
+
+ invalidate_pmd:
+	pmd_clear(pmdp);
+	flush_pmd_entry(pmdp);
+ out:
+	spin_unlock(&mm->page_table_lock);
+}
+
+/*
+ * TLB operations
+ */
+static struct cam_ram_regset *
+omap_mmu_cam_ram_alloc(struct omap_mmu *mmu, struct omap_mmu_tlb_entry *entry)
+{
+	return mmu->ops->cam_ram_alloc(mmu, entry);
+}
+
+static int omap_mmu_cam_ram_valid(struct omap_mmu *mmu,
+				  struct cam_ram_regset *cr)
+{
+	return mmu->ops->cam_ram_valid(cr);
+}
+
+static inline void
+omap_mmu_get_tlb_lock(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *tlb_lock)
+{
+	unsigned long lock = omap_mmu_read_reg(mmu, OMAP_MMU_LOCK);
+	int mask;
+
+	mask = (mmu->type == OMAP_MMU_CAMERA) ?
+			CAMERA_MMU_LOCK_BASE_MASK : MMU_LOCK_BASE_MASK;
+	tlb_lock->base = (lock & mask) >> MMU_LOCK_BASE_SHIFT;
+
+	mask = (mmu->type == OMAP_MMU_CAMERA) ?
+			CAMERA_MMU_LOCK_VICTIM_MASK : MMU_LOCK_VICTIM_MASK;
+	tlb_lock->victim = (lock & mask) >> MMU_LOCK_VICTIM_SHIFT;
+}
+
+static inline void
+omap_mmu_set_tlb_lock(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock)
+{
+	omap_mmu_write_reg(mmu,
+			   (lock->base << MMU_LOCK_BASE_SHIFT) |
+			   (lock->victim << MMU_LOCK_VICTIM_SHIFT),
+			   OMAP_MMU_LOCK);
+}
+
+static inline void omap_mmu_flush(struct omap_mmu *mmu)
+{
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_FLUSH_ENTRY);
+}
+
+static inline void omap_mmu_ldtlb(struct omap_mmu *mmu)
+{
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_LD_TLB);
+}
+
+void omap_mmu_read_tlb(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock,
+		       struct cam_ram_regset *cr)
+{
+	/* set victim */
+	omap_mmu_set_tlb_lock(mmu, lock);
+
+	if (likely(mmu->ops->read_tlb))
+		mmu->ops->read_tlb(mmu, cr);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_read_tlb);
+
+void omap_mmu_load_tlb(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	if (likely(mmu->ops->load_tlb))
+		mmu->ops->load_tlb(mmu, cr);
+
+	/* flush the entry */
+	omap_mmu_flush(mmu);
+
+	/* load a TLB entry */
+	omap_mmu_ldtlb(mmu);
+}
+
+int omap_mmu_load_tlb_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry)
+{
+	struct omap_mmu_tlb_lock lock;
+	struct cam_ram_regset *cr;
+	int ret;
+
+	clk_enable(mmu->clk);
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
+	omap_mmu_get_tlb_lock(mmu, &lock);
+	for (lock.victim = 0; lock.victim < lock.base; lock.victim++) {
+		struct cam_ram_regset tmp;
+
+		/* read a TLB entry */
+		omap_mmu_read_tlb(mmu, &lock, &tmp);
+		if (!omap_mmu_cam_ram_valid(mmu, &tmp))
+			goto found_victim;
+	}
+	omap_mmu_set_tlb_lock(mmu, &lock);
+
+found_victim:
+	/* The last entry cannot be locked? */
+	if (lock.victim == (mmu->nr_tlb_entries - 1)) {
+		dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
+		return -EBUSY;
+	}
+
+	cr = omap_mmu_cam_ram_alloc(mmu, entry);
+	if (IS_ERR(cr))
+		return PTR_ERR(cr);
+
+	omap_mmu_load_tlb(mmu, cr);
+	kfree(cr);
+
+	/* update lock base */
+	if (lock.victim == lock.base)
+		lock.base++;
+
+	omap_mmu_set_tlb_lock(mmu, &lock);
+
+	omap_dsp_release_mem();
+out:
+	clk_disable(mmu->clk);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_load_tlb_entry);
+
+static inline unsigned long
+omap_mmu_cam_va(struct omap_mmu *mmu, struct cam_ram_regset *cr)
+{
+	return mmu->ops->cam_va(cr);
+}
+
+int omap_mmu_clear_tlb_entry(struct omap_mmu *mmu, unsigned long vadr)
+{
+	struct omap_mmu_tlb_lock lock;
+	int i, ret = 0;
+	int max_valid = 0;
+
+	clk_enable(mmu->clk);
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
+	omap_mmu_get_tlb_lock(mmu, &lock);
+	for (i = 0; i < lock.base; i++) {
+		struct cam_ram_regset cr;
+
+		/* read a TLB entry */
+		lock.victim = i;
+		omap_mmu_read_tlb(mmu, &lock, &cr);
+		if (!omap_mmu_cam_ram_valid(mmu, &cr))
+			continue;
+
+		if (omap_mmu_cam_va(mmu, &cr) == vadr)
+			/* flush the entry */
+			omap_mmu_flush(mmu);
+		else
+			max_valid = i;
+	}
+
+	/* set new lock base */
+	lock.base = lock.victim = max_valid + 1;
+	omap_mmu_set_tlb_lock(mmu, &lock);
+
+	omap_dsp_release_mem();
+out:
+	clk_disable(mmu->clk);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_clear_tlb_entry);
+
+static void omap_mmu_gflush(struct omap_mmu *mmu)
+{
+	struct omap_mmu_tlb_lock lock;
+	int ret;
+
+	clk_enable(mmu->clk);
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
+	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_GFLUSH);
+	lock.base = lock.victim = mmu->nr_exmap_preserved;
+	omap_mmu_set_tlb_lock(mmu, &lock);
+
+	omap_dsp_release_mem();
+out:
+	clk_disable(mmu->clk);
+}
+
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry)
+{
+	int ret = -1;
+	/*XXX use PG_flag for prsvd */
+	ret = omap_mmu_load_pte(mmu, entry);
+	if (ret)
+		return ret;
+	if (entry->tlb)
+		ret = omap_mmu_load_tlb_entry(mmu, entry);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_load_pte_entry);
+
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr)
+{
+	int ret = omap_mmu_clear_tlb_entry(mmu, vadr);
+	if (ret)
+		return ret;
+	omap_mmu_clear_pte(mmu, vadr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_clear_pte_entry);
+
+/*
+ * omap_mmu_exmap()
+ *
+ * MEM_IOCTL_EXMAP ioctl calls this function with padr=0.
+ * In this case, the buffer for external device is allocated in this routine,
+ * then it is mapped.
+ * On the other hand, for example - frame buffer sharing, calls
+ * this function with padr set. It means some known address space
+ * pointed with padr is going to be shared with external device.
+ */
+int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long devadr,
+		   unsigned long padr, unsigned long size,
+		   enum exmap_type type)
+{
+	unsigned long pgsz;
+	void *buf;
+	unsigned int order = 0;
+	unsigned long unit;
+	int prev = -1;
+	unsigned long _devadr = devadr;
+	unsigned long _padr = padr;
+	void *_vadr = omap_mmu_to_virt(mmu, devadr);
+	unsigned long _size = size;
+	struct omap_mmu_tlb_entry tlb_ent;
+	struct exmap_tbl *exmap_ent, *tmp_ent;
+	int status;
+	int idx;
+
+#define MINIMUM_PAGESZ	SZ_4K
+	/*
+	 * alignment check
+	 */
+	if (!is_aligned(size, MINIMUM_PAGESZ)) {
+		dev_err(&mmu->dev,
+			"MMU %s: size(0x%lx) is not multiple of 4KB.\n",
+			mmu->name, size);
+		return -EINVAL;
+	}
+	if (!is_aligned(devadr, MINIMUM_PAGESZ)) {
+		dev_err(&mmu->dev,
+			"MMU %s: external device address(0x%lx) is not"
+			" aligned.\n", mmu->name, devadr);
+		return -EINVAL;
+	}
+	if (!is_aligned(padr, MINIMUM_PAGESZ)) {
+		dev_err(&mmu->dev,
+			"MMU %s: physical address(0x%lx) is not aligned.\n",
+			mmu->name, padr);
+		return -EINVAL;
+	}
+
+	/* address validity check */
+	if ((devadr < mmu->memsize) ||
+	    (devadr >= (1 << mmu->addrspace))) {
+		dev_err(&mmu->dev,
+			"MMU %s: illegal address/size for %s().\n",
+			mmu->name, __FUNCTION__);
+		return -EINVAL;
+	}
+
+	down_write(&mmu->exmap_sem);
+
+	/* overlap check */
+	omap_mmu_for_each_tlb_entry(mmu, tmp_ent) {
+		unsigned long mapsize;
+
+		if (!tmp_ent->valid)
+			continue;
+		mapsize = 1 << (tmp_ent->order + PAGE_SHIFT);
+		if ((_vadr + size > tmp_ent->vadr) &&
+		    (_vadr < tmp_ent->vadr + mapsize)) {
+			dev_err(&mmu->dev, "MMU %s: exmap page overlap!\n",
+				mmu->name);
+			up_write(&mmu->exmap_sem);
+			return -EINVAL;
+		}
+	}
+
+start:
+	buf = NULL;
+	/* Are there any free TLB lines?  */
+	for (idx = 0; idx < mmu->nr_tlb_entries; idx++)
+		if (!mmu->exmap_tbl[idx].valid)
+			goto found_free;
+
+	dev_err(&mmu->dev, "MMU %s: TLB is full.\n", mmu->name);
+	status = -EBUSY;
+	goto fail;
+
+found_free:
+	exmap_ent = mmu->exmap_tbl + idx;
+
+	if ((_size >= SZ_1M) &&
+	    (is_aligned(_padr, SZ_1M) || (padr == 0)) &&
+	    is_aligned(_devadr, SZ_1M)) {
+		unit = SZ_1M;
+		pgsz = OMAP_MMU_CAM_PAGESIZE_1MB;
+	} else if ((_size >= SZ_64K) &&
+		   (is_aligned(_padr, SZ_64K) || (padr == 0)) &&
+		   is_aligned(_devadr, SZ_64K)) {
+		unit = SZ_64K;
+		pgsz = OMAP_MMU_CAM_PAGESIZE_64KB;
+	} else {
+		unit = SZ_4K;
+		pgsz = OMAP_MMU_CAM_PAGESIZE_4KB;
+	}
+
+	order = get_order(unit);
+
+	/* buffer allocation */
+	if (type == EXMAP_TYPE_MEM) {
+		struct page *page, *ps, *pe;
+
+		if ((order == ORDER_1MB) && likely(mempool_1M))
+			buf = mempool_alloc_from_pool(mempool_1M, GFP_KERNEL);
+		else if ((order == ORDER_64KB) && likely(mempool_64K))
+			buf = mempool_alloc_from_pool(mempool_64K, GFP_KERNEL);
+		else {
+			buf = (void *)__get_dma_pages(GFP_KERNEL, order);
+			if (buf == NULL) {
+				status = -ENOMEM;
+				goto fail;
+			}
+		}
+
+		/* mark the pages as reserved; this is needed for mmap */
+		ps = virt_to_page(buf);
+		pe = virt_to_page(buf + unit);
+
+		for (page = ps; page < pe; page++)
+			SetPageReserved(page);
+
+		_padr = __pa(buf);
+	}
+
+	/*
+	 * mapping for ARM MMU:
+	 * we should not access to the allocated memory through 'buf'
+	 * since this area should not be cached.
+	 */
+	status = exmap_set_armmmu(mmu, (unsigned long)_vadr, _padr, unit);
+	if (status < 0)
+		goto fail;
+
+	/* loading external device PTE entry */
+	INIT_TLB_ENTRY(&tlb_ent, _devadr, _padr, pgsz);
+	status = omap_mmu_load_pte_entry(mmu, &tlb_ent);
+	if (status < 0) {
+		exmap_clear_armmmu(mmu, (unsigned long)_vadr, unit);
+		goto fail;
+	}
+
+	INIT_EXMAP_TBL_ENTRY(exmap_ent, buf, _vadr, type, order);
+	exmap_ent->link.prev = prev;
+	if (prev >= 0)
+		mmu->exmap_tbl[prev].link.next = idx;
+
+	if ((_size -= unit) == 0) {	/* normal completion */
+		up_write(&mmu->exmap_sem);
+		return size;
+	}
+
+	_devadr += unit;
+	_vadr   += unit;
+	_padr = padr ? _padr + unit : 0;
+	prev = idx;
+	goto start;
+
+fail:
+	up_write(&mmu->exmap_sem);
+	if (buf)
+		omap_mmu_free_pages((unsigned long)buf, order);
+	omap_mmu_exunmap(mmu, devadr);
+	return status;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_exmap);
+
+static unsigned long unmap_free_arm(struct omap_mmu *mmu,
+				    struct exmap_tbl *ent)
+{
+	unsigned long size;
+
+	/* clearing ARM MMU */
+	size = 1 << (ent->order + PAGE_SHIFT);
+	exmap_clear_armmmu(mmu, (unsigned long)ent->vadr, size);
+
+	/* freeing allocated memory */
+	if (ent->type == EXMAP_TYPE_MEM) {
+		omap_mmu_free_pages((unsigned long)ent->buf, ent->order);
+		dev_dbg(&mmu->dev, "MMU %s: freeing 0x%lx bytes @ adr 0x%8p\n",
+			mmu->name, size, ent->buf);
+	}
+
+	ent->valid = 0;
+	return size;
+}
+
+int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long devadr)
+{
+	void *vadr;
+	unsigned long size;
+	int total = 0;
+	struct exmap_tbl *ent;
+	int idx;
+
+	vadr = omap_mmu_to_virt(mmu, devadr);
+	down_write(&mmu->exmap_sem);
+	for (idx = 0; idx < mmu->nr_tlb_entries; idx++) {
+		ent = mmu->exmap_tbl + idx;
+		if (!ent->valid || ent->prsvd)
+			continue;
+		if (ent->vadr == vadr)
+			goto found_map;
+	}
+	up_write(&mmu->exmap_sem);
+	dev_warn(&mmu->dev, "MMU %s: address %06lx not found in exmap_tbl.\n",
+		 mmu->name, devadr);
+	return -EINVAL;
+
+found_map:
+	if (ent->usecount > 0) {
+		dev_err(&mmu->dev, "MMU %s: exmap reference count is not 0.\n"
+			"   idx=%d, vadr=%p, order=%d, usecount=%d\n",
+			mmu->name, idx, ent->vadr, ent->order, ent->usecount);
+		up_write(&mmu->exmap_sem);
+		return -EINVAL;
+	}
+	/* clearing external device PTE entry */
+	omap_mmu_clear_pte_entry(mmu, devadr);
+
+	/* clear ARM MMU and free buffer */
+	size = unmap_free_arm(mmu, ent);
+	total += size;
+
+	/* we don't free PTEs */
+
+	/* flush TLB */
+	flush_tlb_kernel_range((unsigned long)vadr, (unsigned long)vadr + size);
+
+	/* check if next mapping is in same group */
+	idx = ent->link.next;
+	if (idx < 0)
+		goto up_out;	/* normal completion */
+	ent = mmu->exmap_tbl + idx;
+	devadr += size;
+	vadr   += size;
+	if (ent->vadr == vadr)
+		goto found_map;	/* continue */
+
+	dev_err(&mmu->dev, "MMU %s: illegal exmap_tbl grouping!\n"
+		"expected vadr = %p, exmap_tbl[%d].vadr = %p\n",
+		mmu->name, vadr, idx, ent->vadr);
+	up_write(&mmu->exmap_sem);
+	return -EINVAL;
+
+up_out:
+	up_write(&mmu->exmap_sem);
+	return total;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_exunmap);
+
+void omap_mmu_exmap_flush(struct omap_mmu *mmu)
+{
+	struct exmap_tbl *ent;
+
+	down_write(&mmu->exmap_sem);
+
+	/* clearing TLB entry */
+	omap_mmu_gflush(mmu);
+
+	omap_mmu_for_each_tlb_entry(mmu, ent)
+		if (ent->valid && !ent->prsvd)
+			unmap_free_arm(mmu, ent);
+
+	/* flush TLB */
+	if (likely(mmu->membase))
+		flush_tlb_kernel_range(mmu->membase + mmu->memsize,
+				       mmu->membase + (1 << mmu->addrspace));
+
+	up_write(&mmu->exmap_sem);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_exmap_flush);
+
+void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
+				    unsigned long devadr, int index)
+{
+	unsigned long phys;
+	void *virt;
+	struct omap_mmu_tlb_entry tlb_ent;
+
+	phys = __pa(buf);
+	virt = omap_mmu_to_virt(mmu, devadr);
+	exmap_set_armmmu(mmu, (unsigned long)virt, phys, PAGE_SIZE);
+	INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(mmu->exmap_tbl + index, buf, virt);
+	INIT_TLB_ENTRY_4KB_PRESERVED(&tlb_ent, devadr, phys);
+	omap_mmu_load_pte_entry(mmu, &tlb_ent);
+}
+EXPORT_SYMBOL_GPL(exmap_setup_preserved_mem_page);
+
+void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long devadr)
+{
+	void *virt = omap_mmu_to_virt(mmu, devadr);
+
+	exmap_clear_armmmu(mmu, (unsigned long)virt, PAGE_SIZE);
+	/* DSP MMU is shutting down. not handled here. */
+}
+EXPORT_SYMBOL_GPL(exmap_clear_mem_page);
+
+static void omap_mmu_reset(struct omap_mmu *mmu)
+{
+#if defined(CONFIG_ARCH_OMAP2) /* FIXME */
+	int i;
+
+	omap_mmu_write_reg(mmu, 0x2, OMAP_MMU_SYSCONFIG);
+
+	for (i = 0; i < 10000; i++)
+		if (likely(omap_mmu_read_reg(mmu, OMAP_MMU_SYSSTATUS) & 0x1))
+			break;
+#endif
+}
+
+void omap_mmu_disable(struct omap_mmu *mmu)
+{
+	omap_mmu_write_reg(mmu, 0x00, OMAP_MMU_CNTL);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_disable);
+
+void omap_mmu_enable(struct omap_mmu *mmu, int reset)
+{
+	u32 val = OMAP_MMU_CNTL_MMU_EN | MMU_CNTL_TWLENABLE;
+
+	if (likely(reset))
+		omap_mmu_reset(mmu);
+#if defined(CONFIG_ARCH_OMAP2) /* FIXME */
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd),
+			   OMAP_MMU_TTB);
+#else
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd) & 0xffff,
+			   OMAP_MMU_TTB_L);
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd) >> 16,
+			   OMAP_MMU_TTB_H);
+	val |= OMAP_MMU_CNTL_RESET_SW;
+#endif
+	omap_mmu_write_reg(mmu, val, OMAP_MMU_CNTL);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_enable);
+
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
+static int omap_mmu_init(struct omap_mmu *mmu)
+{
+	struct omap_mmu_tlb_lock tlb_lock;
+	int ret = 0;
+
+	clk_enable(mmu->clk);
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
+	down_write(&mmu->exmap_sem);
+
+	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
+			  mmu->name,  mmu);
+	if (ret < 0) {
+		dev_err(&mmu->dev, "MMU %s: failed to register MMU interrupt:"
+			" %d\n", mmu->name, ret);
+		goto fail;
+	}
+
+	omap_mmu_disable(mmu);	/* clear all */
+	udelay(100);
+	omap_mmu_enable(mmu, 1);
+
+	memset(&tlb_lock, 0, sizeof(struct omap_mmu_tlb_lock));
+	omap_mmu_set_tlb_lock(mmu, &tlb_lock);
+
+	if (unlikely(mmu->ops->startup))
+		ret = mmu->ops->startup(mmu);
+fail:
+	up_write(&mmu->exmap_sem);
+	omap_dsp_release_mem();
+out:
+	clk_disable(mmu->clk);
+
+	return ret;
+}
+
+static void omap_mmu_shutdown(struct omap_mmu *mmu)
+{
+	free_irq(mmu->irq, mmu);
+
+	if (unlikely(mmu->ops->shutdown))
+		mmu->ops->shutdown(mmu);
+
+	omap_mmu_exmap_flush(mmu);
+	omap_mmu_disable(mmu); /* clear all */
+}
+
+/*
+ * omap_mmu_mem_enable() / disable()
+ */
+int omap_mmu_mem_enable(struct omap_mmu *mmu, void *addr)
+{
+	if (unlikely(mmu->ops->mem_enable))
+		return mmu->ops->mem_enable(mmu, addr);
+
+	down_read(&mmu->exmap_sem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_mem_enable);
+
+void omap_mmu_mem_disable(struct omap_mmu *mmu, void *addr)
+{
+	if (unlikely(mmu->ops->mem_disable)) {
+		mmu->ops->mem_disable(mmu, addr);
+		return;
+	}
+
+	up_read(&mmu->exmap_sem);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_mem_disable);
+
+/*
+ * dsp_mem file operations
+ */
+static ssize_t intmem_read(struct omap_mmu *mmu, char *buf, size_t count,
+			   loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+	ssize_t size = mmu->memsize;
+	ssize_t read;
+
+	if (p >= size)
+		return 0;
+	clk_enable(mmu->memclk);
+	read = count;
+	if (count > size - p)
+		read = size - p;
+	if (copy_to_user(buf, vadr, read)) {
+		read = -EFAULT;
+		goto out;
+	}
+	*ppos += read;
+out:
+	clk_disable(mmu->memclk);
+	return read;
+}
+
+static ssize_t exmem_read(struct omap_mmu *mmu, char *buf, size_t count,
+			  loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+
+	if (!exmap_valid(mmu, vadr, count)) {
+		dev_err(&mmu->dev, "MMU %s: external device address %08lx / "
+			"size %08x is not valid!\n", mmu->name, p, count);
+		return -EFAULT;
+	}
+	if (count > (1 << mmu->addrspace) - p)
+		count = (1 << mmu->addrspace) - p;
+	if (copy_to_user(buf, vadr, count))
+		return -EFAULT;
+	*ppos += count;
+
+	return count;
+}
+
+static ssize_t omap_mmu_mem_read(struct kobject *kobj,
+				 struct bin_attribute *attr,
+				 char *buf, loff_t offset, size_t count)
+{
+	struct device *dev = to_dev(kobj);
+	struct omap_mmu *mmu = dev_get_drvdata(dev);
+	unsigned long p = (unsigned long)offset;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+	int ret;
+
+	if (omap_mmu_mem_enable(mmu, vadr) < 0)
+		return -EBUSY;
+
+	if (p < mmu->memsize)
+		ret = intmem_read(mmu, buf, count, &offset);
+	else
+		ret = exmem_read(mmu, buf, count, &offset);
+
+	omap_mmu_mem_disable(mmu, vadr);
+
+	return ret;
+}
+
+static ssize_t intmem_write(struct omap_mmu *mmu, const char *buf, size_t count,
+			    loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+	ssize_t size = mmu->memsize;
+	ssize_t written;
+
+	if (p >= size)
+		return 0;
+	clk_enable(mmu->memclk);
+	written = count;
+	if (count > size - p)
+		written = size - p;
+	if (copy_from_user(vadr, buf, written)) {
+		written = -EFAULT;
+		goto out;
+	}
+	*ppos += written;
+out:
+	clk_disable(mmu->memclk);
+	return written;
+}
+
+static ssize_t exmem_write(struct omap_mmu *mmu, char *buf, size_t count,
+			   loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+
+	if (!exmap_valid(mmu, vadr, count)) {
+		dev_err(&mmu->dev, "MMU %s: external device address %08lx "
+			"/ size %08x is not valid!\n", mmu->name, p, count);
+		return -EFAULT;
+	}
+	if (count > (1 << mmu->addrspace) - p)
+		count = (1 << mmu->addrspace) - p;
+	if (copy_from_user(vadr, buf, count))
+		return -EFAULT;
+	*ppos += count;
+
+	return count;
+}
+
+static ssize_t omap_mmu_mem_write(struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  char *buf, loff_t offset, size_t count)
+{
+	struct device *dev = to_dev(kobj);
+	struct omap_mmu *mmu = dev_get_drvdata(dev);
+	unsigned long p = (unsigned long)offset;
+	void *vadr = omap_mmu_to_virt(mmu, p);
+	int ret;
+
+	if (omap_mmu_mem_enable(mmu, vadr) < 0)
+		return -EBUSY;
+
+	if (p < mmu->memsize)
+		ret = intmem_write(mmu, buf, count, &offset);
+	else
+		ret = exmem_write(mmu, buf, count, &offset);
+
+	omap_mmu_mem_disable(mmu, vadr);
+
+	return ret;
+}
+
+static struct bin_attribute dev_attr_mem = {
+	.attr	= {
+		.name	= "mem",
+		.owner	= THIS_MODULE,
+		.mode	= S_IRUSR | S_IWUSR | S_IRGRP,
+	},
+
+	.read	= omap_mmu_mem_read,
+	.write	= omap_mmu_mem_write,
+};
+
+/* To be obsolete for backward compatibility */
+ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu,
+			    struct bin_attribute *attr,
+			    char *buf, loff_t offset, size_t count)
+{
+	return omap_mmu_mem_read(&mmu->dev.kobj, attr, buf, offset, count);
+}
+EXPORT_SYMBOL_GPL(__omap_mmu_mem_read);
+
+ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu,
+			     struct bin_attribute *attr,
+			     char *buf, loff_t offset, size_t count)
+{
+	return omap_mmu_mem_write(&mmu->dev.kobj, attr, buf, offset, count);
+}
+EXPORT_SYMBOL_GPL(__omap_mmu_mem_write);
+
+/*
+ * sysfs files
+ */
+static ssize_t omap_mmu_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct omap_mmu *mmu = dev_get_drvdata(dev);
+	struct omap_mmu_tlb_lock tlb_lock;
+	int ret;
+
+	clk_enable(mmu->clk);
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
+	down_read(&mmu->exmap_sem);
+
+	omap_mmu_get_tlb_lock(mmu, &tlb_lock);
+
+	ret = -EIO;
+	if (likely(mmu->ops->show))
+		ret = mmu->ops->show(mmu, buf, &tlb_lock);
+
+	/* restore victim entry */
+	omap_mmu_set_tlb_lock(mmu, &tlb_lock);
+
+	up_read(&mmu->exmap_sem);
+	omap_dsp_release_mem();
+out:
+	clk_disable(mmu->clk);
+
+	return ret;
+}
+
+static DEVICE_ATTR(mmu, S_IRUGO, omap_mmu_show, NULL);
+
+static ssize_t exmap_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct omap_mmu *mmu = dev_get_drvdata(dev);
+	struct exmap_tbl *ent;
+	int len;
+	int i = 0;
+
+	down_read(&mmu->exmap_sem);
+	len = sprintf(buf, "  devadr     size         buf     size uc\n");
+			 /* 0x300000 0x123000  0xc0171000 0x100000  0*/
+
+	omap_mmu_for_each_tlb_entry(mmu, ent) {
+		void *vadr;
+		unsigned long size;
+		enum exmap_type type;
+		int idx;
+
+		/* find a top of link */
+		if (!ent->valid || (ent->link.prev >= 0))
+			continue;
+
+		vadr = ent->vadr;
+		type = ent->type;
+		size = 0;
+		idx = i;
+		do {
+			ent = mmu->exmap_tbl + idx;
+			size += PAGE_SIZE << ent->order;
+		} while ((idx = ent->link.next) >= 0);
+
+		len += sprintf(buf + len, "0x%06lx %#8lx",
+			       virt_to_omap_mmu(mmu, vadr), size);
+
+		if (type == EXMAP_TYPE_FB) {
+			len += sprintf(buf + len, "    framebuf\n");
+		} else {
+			len += sprintf(buf + len, "\n");
+			idx = i;
+			do {
+				ent = mmu->exmap_tbl + idx;
+				len += sprintf(buf + len,
+					       /* 0xc0171000 0x100000  0*/
+					       "%19s0x%8p %#8lx %2d\n",
+					       "", ent->buf,
+					       PAGE_SIZE << ent->order,
+					       ent->usecount);
+			} while ((idx = ent->link.next) >= 0);
+		}
+
+		i++;
+	}
+
+	up_read(&mmu->exmap_sem);
+	return len;
+}
+
+static ssize_t exmap_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf,
+			   size_t count)
+{
+	struct omap_mmu *mmu = dev_get_drvdata(dev);
+	unsigned long base = 0, len = 0;
+	int ret;
+
+	sscanf(buf, "%lx %lx", &base, &len);
+
+	if (!base)
+		return -EINVAL;
+
+	if (len) {
+		/* Add the mapping */
+		ret = omap_mmu_exmap(mmu, base, 0, len, EXMAP_TYPE_MEM);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Remove the mapping */
+		ret = omap_mmu_exunmap(mmu, base);
+		if (ret < 0)
+			return ret;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(exmap, S_IRUGO | S_IWUSR, exmap_show, exmap_store);
+
+static ssize_t mempool_show(struct class *class, char *buf)
+{
+	int min_nr_1M = 0, curr_nr_1M = 0;
+	int min_nr_64K = 0, curr_nr_64K = 0;
+	int total = 0;
+
+	if (likely(mempool_1M)) {
+		min_nr_1M  = mempool_1M->min_nr;
+		curr_nr_1M = mempool_1M->curr_nr;
+		total += min_nr_1M * SZ_1M;
+	}
+	if (likely(mempool_64K)) {
+		min_nr_64K  = mempool_64K->min_nr;
+		curr_nr_64K = mempool_64K->curr_nr;
+		total += min_nr_64K * SZ_64K;
+	}
+
+	return sprintf(buf,
+		       "0x%x\n"
+		       "1M  buffer: %d (%d free)\n"
+		       "64K buffer: %d (%d free)\n",
+		       total, min_nr_1M, curr_nr_1M, min_nr_64K, curr_nr_64K);
+}
+
+
+static CLASS_ATTR(mempool, S_IRUGO, mempool_show, NULL);
+
+static struct class omap_mmu_class = {
+	.name		= "mmu",
+};
+
+int omap_mmu_register(struct omap_mmu *mmu)
+{
+	int ret;
+
+	mmu->dev.class = &omap_mmu_class;
+	strlcpy(mmu->dev.bus_id, mmu->name, KOBJ_NAME_LEN);
+	dev_set_drvdata(&mmu->dev, mmu);
+
+	mmu->exmap_tbl = kzalloc(sizeof(struct exmap_tbl) * mmu->nr_tlb_entries,
+				 GFP_KERNEL);
+	if (!mmu->exmap_tbl)
+		return -ENOMEM;
+
+	mmu->twl_mm = mm_alloc();
+	if (!mmu->twl_mm) {
+		ret = -ENOMEM;
+		goto err_mm_alloc;
+	}
+
+	ret = device_register(&mmu->dev);
+	if (unlikely(ret))
+		goto err_dev_register;
+
+	init_rwsem(&mmu->exmap_sem);
+
+	ret = omap_mmu_init(mmu);
+	if (unlikely(ret))
+		goto err_mmu_init;
+
+	ret = device_create_file(&mmu->dev, &dev_attr_mmu);
+	if (unlikely(ret))
+		goto err_dev_create_mmu;
+	ret = device_create_file(&mmu->dev, &dev_attr_exmap);
+	if (unlikely(ret))
+		goto err_dev_create_exmap;
+
+	if (likely(mmu->membase)) {
+		dev_attr_mem.size = mmu->memsize;
+		ret = device_create_bin_file(&mmu->dev,
+					     &dev_attr_mem);
+		if (unlikely(ret))
+			goto err_bin_create_mem;
+	}
+
+	return 0;
+
+err_bin_create_mem:
+	device_remove_file(&mmu->dev, &dev_attr_exmap);
+err_dev_create_exmap:
+	device_remove_file(&mmu->dev, &dev_attr_mmu);
+err_dev_create_mmu:
+	omap_mmu_shutdown(mmu);
+err_mmu_init:
+	device_unregister(&mmu->dev);
+err_dev_register:
+	kfree(mmu->twl_mm);
+	mmu->twl_mm = NULL;
+err_mm_alloc:
+	kfree(mmu->exmap_tbl);
+	mmu->exmap_tbl = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_mmu_register);
+
+void omap_mmu_unregister(struct omap_mmu *mmu)
+{
+	omap_mmu_shutdown(mmu);
+	omap_mmu_kmem_release();
+
+	device_remove_file(&mmu->dev, &dev_attr_mmu);
+	device_remove_file(&mmu->dev, &dev_attr_exmap);
+
+	if (likely(mmu->membase))
+		device_remove_bin_file(&mmu->dev,
+					     &dev_attr_mem);
+
+	kfree(mmu->exmap_tbl);
+	mmu->exmap_tbl = NULL;
+
+	if (mmu->twl_mm) {
+		__mmdrop(mmu->twl_mm);
+		mmu->twl_mm = NULL;
+	}
+
+	device_unregister(&mmu->dev);
+}
+EXPORT_SYMBOL_GPL(omap_mmu_unregister);
+
+static int __init omap_mmu_class_init(void)
+{
+	int ret = class_register(&omap_mmu_class);
+	if (!ret)
+		ret = class_create_file(&omap_mmu_class, &class_attr_mempool);
+
+	return ret;
+}
+
+static void __exit omap_mmu_class_exit(void)
+{
+	class_remove_file(&omap_mmu_class, &class_attr_mempool);
+	class_unregister(&omap_mmu_class);
+}
+
+subsys_initcall(omap_mmu_class_init);
+module_exit(omap_mmu_class_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6/include/asm-arm/arch-omap/dsp_common.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-omap/dsp_common.h	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/include/asm-arm/arch-omap/dsp_common.h	2007-12-03 14:36:47.000000000 -0800
@@ -5,20 +5,9 @@
  *
  * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #ifndef ASM_ARCH_DSP_COMMON_H
@@ -27,8 +16,12 @@
 #ifdef CONFIG_ARCH_OMAP1
 extern void omap_dsp_request_mpui(void);
 extern void omap_dsp_release_mpui(void);
-extern int omap_dsp_request_mem(void);
-extern int omap_dsp_release_mem(void);
 #endif
 
+static inline int omap_dsp_request_mem(void)
+{
+	return 0;
+}
+#define omap_dsp_release_mem()	do {} while (0)
+
 #endif /* ASM_ARCH_DSP_COMMON_H */
Index: linux-2.6/include/asm-arm/arch-omap/mmu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-omap/mmu.h	2007-12-03 14:36:47.000000000 -0800
@@ -0,0 +1,211 @@
+#ifndef __ARCH_OMAP_MMU_H
+#define __ARCH_OMAP_MMU_H
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+
+enum exmap_type {
+	EXMAP_TYPE_MEM,
+	EXMAP_TYPE_FB
+};
+
+enum omap_mmu_type {
+	OMAP_MMU_DSP,
+	OMAP_MMU_IVA1,
+	OMAP_MMU_CAMERA,
+};
+
+struct exmap_tbl {
+	unsigned int valid:1;
+	unsigned int prsvd:1;
+	int usecount;		/* reference count by mmap */
+	enum exmap_type type;
+	void *buf;		/* virtual address of the buffer,
+				 * i.e. 0xc0000000 - */
+	void *vadr;		/* DSP shadow space,
+				 * i.e. 0xe0000000 - 0xe0ffffff */
+	unsigned int order;
+	struct {
+		int prev;
+		int next;
+	} link;			/* grouping */
+};
+
+struct cam_ram_regset {
+	union {
+		struct {
+			u16 cam_l;
+			u16 cam_h;
+		};
+
+		u32 cam;
+	};
+
+	union {
+		struct {
+			u16 ram_l;
+			u16 ram_h;
+		};
+
+		u32 ram;
+	};
+};
+
+struct omap_mmu_tlb_lock {
+	int base;
+	int victim;
+};
+
+struct omap_mmu;
+struct omap_mmu_tlb_entry;
+
+#ifdef CONFIG_ARCH_OMAP1
+extern struct omap_mmu_ops omap1_mmu_ops;
+extern void omap_mmu_itack(struct omap_mmu *mmu);
+#elif defined(CONFIG_ARCH_OMAP2)
+extern struct omap_mmu_ops omap2_mmu_ops;
+static inline void omap_mmu_itack(struct omap_mmu *mmu)
+{
+}
+#endif
+
+struct omap_mmu_ops {
+	int (*startup)(struct omap_mmu *mmu);
+	void (*shutdown)(struct omap_mmu *mmu);
+
+	/* TLB operations */
+	void (*read_tlb)(struct omap_mmu *, struct cam_ram_regset *);
+	void (*load_tlb)(struct omap_mmu *, struct cam_ram_regset *);
+	ssize_t (*show)(struct omap_mmu *, char *, struct omap_mmu_tlb_lock *);
+
+	/* CAM / RAM operations */
+	struct cam_ram_regset *(*cam_ram_alloc)(struct omap_mmu *,
+						struct omap_mmu_tlb_entry *);
+	int (*cam_ram_valid)(struct cam_ram_regset *);
+	unsigned long (*cam_va)(struct cam_ram_regset *);
+
+	/* Memory operations */
+	int (*mem_enable)(struct omap_mmu *, void *);
+	int (*mem_disable)(struct omap_mmu *, void *);
+
+	void (*interrupt)(struct omap_mmu *);
+
+	/* PTE attribute operations */
+	pgprot_t (*pte_get_attr)(struct omap_mmu_tlb_entry *);
+};
+
+struct omap_mmu {
+	const char *name;
+	unsigned long base;
+	struct clk *clk;
+
+	unsigned long membase, memsize;
+	struct clk *memclk;
+
+	enum omap_mmu_type type;
+
+	struct device dev;
+
+	struct rw_semaphore exmap_sem;
+	struct exmap_tbl *exmap_tbl;
+
+	unsigned int nr_tlb_entries;
+	unsigned int nr_exmap_preserved;
+
+	struct mm_struct *twl_mm;
+
+	/* Size of virtual address space, in bits */
+	unsigned int addrspace;
+
+	/* Interrupt */
+	unsigned int irq;
+	unsigned long fault_address;
+	struct work_struct irq_work;
+
+	struct omap_mmu_ops *ops;
+};
+
+#define omap_mmu_internal_memory(mmu, addr)					\
+	(likely(mmu->membase) && (((unsigned long)(addr) >= mmu->membase) &&	\
+		 ((unsigned long)(addr) < mmu->membase + mmu->memsize)))
+
+#define INIT_EXMAP_TBL_ENTRY(ent, b, v, typ, od)	\
+do {						\
+	(ent)->buf		= (b);		\
+	(ent)->vadr		= (v);		\
+	(ent)->valid		= 1;		\
+	(ent)->prsvd		= 0;		\
+	(ent)->usecount		= 0;		\
+	(ent)->type		= (typ);	\
+	(ent)->order		= (od);		\
+	(ent)->link.next	= -1;		\
+	(ent)->link.prev	= -1;		\
+} while (0)
+
+#define INIT_EXMAP_TBL_ENTRY_4KB_PRESERVED(ent, b, v)	\
+do {							\
+	(ent)->buf		= (b);			\
+	(ent)->vadr		= (v);			\
+	(ent)->valid		= 1;			\
+	(ent)->prsvd		= 1;			\
+	(ent)->usecount		= 0;			\
+	(ent)->type		= EXMAP_TYPE_MEM;	\
+	(ent)->order		= 0;			\
+	(ent)->link.next	= -1;			\
+	(ent)->link.prev	= -1;			\
+} while (0)
+
+#define omap_mmu_to_virt(mmu, db)	((void *)((mmu)->membase + (db)))
+#define virt_to_omap_mmu(mmu, va) \
+	(((unsigned long)(va) - (mmu)->membase))
+
+/* arch/arm/plat-omap/mmu.c */
+int omap_mmu_register(struct omap_mmu *mmu);
+void omap_mmu_unregister(struct omap_mmu *mmu);
+
+void omap_mmu_enable(struct omap_mmu *mmu, int reset);
+void omap_mmu_disable(struct omap_mmu *mmu);
+
+int omap_mmu_mem_enable(struct omap_mmu *mmu, void *addr);
+void omap_mmu_mem_disable(struct omap_mmu *mmu, void *addr);
+
+void omap_mmu_read_tlb(struct omap_mmu *mmu, struct omap_mmu_tlb_lock *lock,
+		       struct cam_ram_regset *cr);
+
+int omap_mmu_load_tlb_entry(struct omap_mmu *, struct omap_mmu_tlb_entry *);
+int omap_mmu_clear_tlb_entry(struct omap_mmu *, unsigned long vadr);
+
+int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
+			    struct omap_mmu_tlb_entry *entry);
+int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr);
+
+int omap_mmu_kmem_reserve(struct omap_mmu *mmu, unsigned long size);
+void omap_mmu_kmem_release(void);
+
+unsigned long omap_mmu_virt_to_phys(struct omap_mmu *mmu, void *vadr,
+				    size_t *len);
+
+int omap_mmu_exmap(struct omap_mmu *mmu, unsigned long dspadr,
+		   unsigned long padr, unsigned long size,
+		   enum exmap_type type);
+int omap_mmu_exunmap(struct omap_mmu *mmu, unsigned long dspadr);
+void omap_mmu_exmap_flush(struct omap_mmu *mmu);
+void omap_mmu_exmap_use(struct omap_mmu *mmu, void *vadr, size_t len);
+void omap_mmu_exmap_unuse(struct omap_mmu *mmu, void *vadr, size_t len);
+
+int exmap_set_armmmu(struct omap_mmu *mmu, unsigned long virt,
+		     unsigned long phys, unsigned long size);
+void exmap_clear_armmmu(struct omap_mmu *mmu, unsigned long virt,
+			unsigned long size);
+void exmap_setup_preserved_mem_page(struct omap_mmu *mmu, void *buf,
+				    unsigned long dspadr, int index);
+void exmap_clear_mem_page(struct omap_mmu *mmu, unsigned long dspadr);
+int exmap_valid(struct omap_mmu *mmu, void *vadr, size_t len);
+
+/* To be obsolete for backward compatibility */
+ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, struct bin_attribute *,
+			    char *buf, loff_t offset, size_t count);
+ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, struct bin_attribute *,
+			    char *buf, loff_t offset, size_t count);
+
+#endif /* __ARCH_OMAP_MMU_H */
Index: linux-2.6/include/asm-arm/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-arm/pgtable.h	2007-12-03 14:36:10.000000000 -0800
+++ linux-2.6/include/asm-arm/pgtable.h	2007-12-03 14:36:47.000000000 -0800
@@ -289,6 +289,7 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0--
