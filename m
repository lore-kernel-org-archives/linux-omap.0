From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/4] ARM: OMAP: IOMMU driver: OMAP2 specific
Date: Mon,  8 Sep 2008 08:56:33 +0300
Message-ID: <1220853394-21529-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-4-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36824 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYIHF5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 01:57:13 -0400
In-Reply-To: <1220853394-21529-4-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, r-woodruff2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

OMAP2 IOMMU has both TLB and TWL.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu_arch.c         |  331 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/iommu2.h |  102 +++++++++
 2 files changed, 433 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu_arch.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h

diff --git a/arch/arm/mach-omap2/iommu_arch.c b/arch/arm/mach-omap2/iommu_arch.c
new file mode 100644
index 0000000..a850940
--- /dev/null
+++ b/arch/arm/mach-omap2/iommu_arch.c
@@ -0,0 +1,331 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ *	OMAP2 specific functions
+ *
+ * Copyright (C) 2002-2008 Nokia Corporation
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *		Paul Mundt and Toshihiro Kobayashi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/jiffies.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include <mach/iommu.h>
+
+/* SYSCONF */
+#define MMU_SYS_IDLE_SHIFT	3
+#define MMU_SYS_IDLE_FORCE	(0 << MMU_SYS_IDLE_SHIFT)
+#define MMU_SYS_IDLE_NONE	(1 << MMU_SYS_IDLE_SHIFT)
+#define MMU_SYS_IDLE_SMART	(2 << MMU_SYS_IDLE_SHIFT)
+#define MMU_SYS_IDLE_MASK	(3 << MMU_SYS_IDLE_SHIFT)
+
+#define MMU_SYS_SOFTRESET	(1 << 1)
+#define MMU_SYS_AUTOIDLE	1
+
+/* SYSSTATUS */
+#define MMU_SYS_RESETDONE	1
+
+/* IRQSTATUS & IRQENABLE */
+#define MMU_IRQ_MULTIHITFAULT	(1 << 4)
+#define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
+#define MMU_IRQ_EMUMISS		(1 << 2)
+#define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
+#define MMU_IRQ_TLBMISS		(1 << 0)
+#define MMU_IRQ_MASK	\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS | \
+	 MMU_IRQ_TRANSLATIONFAULT)
+
+/* MMU_CNTL */
+#define MMU_CNTL_SHIFT		1
+#define MMU_CNTL_MASK		(7 << MMU_CNTL_SHIFT)
+#define MMU_CNTL_EML_TLB	(1 << 3)
+#define MMU_CNTL_TWL_EN		(1 << 2)
+#define MMU_CNTL_MMU_EN		(1 << 1)
+
+#define get_cam_va_mask(pgsz) \
+	(((pgsz) == MMU_CAM_PAGESIZE_16MB) ? 0xff000000 : \
+	 ((pgsz) == MMU_CAM_PAGESIZE_1MB)  ? 0xfff00000 : \
+	 ((pgsz) == MMU_CAM_PAGESIZE_64KB) ? 0xffff0000 : \
+	 ((pgsz) == MMU_CAM_PAGESIZE_4KB)  ? 0xfffff000 : 0)
+
+static int omap2_iommu_startup(struct iommu *obj)
+{
+	u32 l;
+	unsigned long timeout;
+
+	iommu_write_reg(obj, MMU_SYS_SOFTRESET, MMU_SYSCONFIG);
+	timeout = jiffies + msecs_to_jiffies(20);
+	while (1) {
+		l = iommu_read_reg(obj, MMU_SYSSTATUS);
+		if (!(l & MMU_SYS_RESETDONE))
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	}
+	if (l & MMU_SYS_RESETDONE) {
+		dev_err(obj->dev, "can't take MMU out of reset\n");
+		return -ENODEV;
+	}
+
+	l = iommu_read_reg(obj, MMU_REVISION);
+	dev_info(obj->dev, "%s: Initialized (HW v%d.%d)\n", obj->name,
+		 (l >> 4) & 0xf, l & 0xf);
+
+	l = iommu_read_reg(obj, MMU_SYSCONFIG);
+	l &= ~MMU_SYS_IDLE_MASK;
+	l |= MMU_SYS_IDLE_SMART;
+	iommu_write_reg(obj, l, MMU_SYSCONFIG);
+
+	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
+	return 0;
+}
+
+static void omap2_iommu_shutdown(struct iommu *obj)
+{
+	iommu_write_reg(obj, MMU_SYS_IDLE_FORCE, MMU_SYSCONFIG);
+}
+
+int omap2_iommu_enable(struct iommu *obj)
+{
+	u32 l, va;
+
+	va = (u32)virt_to_phys(obj->twl_mm->pgd);
+	if (va & 0xffffc000) { /* 16KB */
+		dev_err(obj->dev, "TTB address not aligned at 16KB: %08x", va);
+		return -ENOMEM;
+	}
+	iommu_write_reg(obj, va, MMU_TTB);
+
+	l = iommu_read_reg(obj, MMU_CNTL);
+	l &= ~MMU_CNTL_MASK;
+	l |= MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN;
+	iommu_write_reg(obj, l, MMU_CNTL);
+	return 0;
+}
+
+void omap2_iommu_disable(struct iommu *obj)
+{
+	u32 l;
+	l = iommu_read_reg(obj, MMU_CNTL);
+	l &= ~MMU_CNTL_MASK;
+	iommu_write_reg(obj, l, MMU_CNTL);
+}
+
+static void omap2_arch_iommu_isr(struct iommu *obj)
+{
+	unsigned long l, va;
+
+	l = iommu_read_reg(obj, MMU_IRQSTATUS);
+	l &= MMU_IRQ_MASK;
+
+	if (l & MMU_IRQ_MULTIHITFAULT)
+		dev_info(obj->dev, "multi hit\n");
+
+	if (l & MMU_IRQ_TABLEWALKFAULT)
+		dev_info(obj->dev, "table walk fault\n");
+
+	if (l & MMU_IRQ_EMUMISS)
+		dev_info(obj->dev, "EMU miss\n");
+
+	if (l & MMU_IRQ_TRANSLATIONFAULT)
+		dev_info(obj->dev, "translation fault\n");
+
+	if ((l & MMU_IRQ_TLBMISS))
+		dev_info(obj->dev, "TLB miss\n");
+
+	va = iommu_read_reg(obj, MMU_FAULT_AD);
+	dev_info(obj->dev, "fault address = %#08lx\n", va);
+
+	iommu_write_reg(obj, l, MMU_IRQSTATUS);
+}
+
+static void omap2_tlb_cr_read(struct iommu *obj, struct cr_regs *cr)
+{
+	cr->cam = iommu_read_reg(obj, MMU_READ_CAM);
+	cr->ram = iommu_read_reg(obj, MMU_READ_RAM);
+}
+
+static void omap2_tlb_cr_load(struct iommu *obj, struct cr_regs *cr)
+{
+	iommu_write_reg(obj, cr->cam | MMU_CAM_V, MMU_CAM);
+	iommu_write_reg(obj, cr->ram, MMU_RAM);
+}
+
+static unsigned long omap2_cr_to_virt(struct cr_regs *cr)
+{
+	unsigned int page_size = cr->cam & MMU_CAM_PAGESIZE_MASK;
+	unsigned int mask = get_cam_va_mask(cr->cam & page_size);
+	return cr->cam & mask;
+}
+
+static struct cr_regs *omap2_cr_alloc(struct iommu *obj, struct iotlb_entry *e)
+{
+	struct cr_regs *cr;
+	if (e->va & ~(get_cam_va_mask(e->pgsz))) {
+		dev_err(obj->dev, "MMU %s: mapping vadr (0x%06lx) is not on"
+			" an aligned boundary\n", obj->name, e->va);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
+	if (!cr)
+		return ERR_PTR(-ENOMEM);
+	cr->cam = (e->va & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->ram = e->pa | e->endian | e->elsz;
+	return cr;
+}
+
+static inline int omap2_cr_valid(struct cr_regs *cr)
+{
+	return cr->cam & MMU_CAM_V;
+}
+
+static pgprot_t omap2_pte_attr_get(struct iotlb_entry *e)
+{
+	u32 attr;
+
+	attr = e->mixed << 5;
+	attr |= e->endian;
+	attr |= e->elsz >> 3;
+	attr <<= ((e->pgsz & MMU_CAM_PAGESIZE_4KB) ? 0 : 6);
+
+	return attr;
+}
+
+/* FIXME: To debugfs binary & userland encoder */
+static ssize_t omap2_tlb_show(struct iommu *obj, char *buf,
+			      struct iotlb_lock *l)
+{
+	int i, len;
+
+	/* 00: P V  4KB 0x300000 0x10171800 B 16 M */
+	len = sprintf(buf, "P: preserved, V: valid\n"
+		      "B: big endian, L:little endian, "
+		      "M: mixed page attribute\n"
+		      "ety P V size   cam_va     ram_pa E ES M\n");
+
+	for (i = 0; i < obj->nr_tlb_entries; i++) {
+		struct iotlb_entry e;
+		struct cr_regs cr;
+		struct iotlb_lock el;
+		char *pgsz_str, *elsz_str;
+
+		/* read a TLB entry */
+		el.base   = l->base;
+		el.victim = i;
+		iotlb_cr_read(obj, &el, &cr);
+
+		e.pgsz   = cr.cam & MMU_CAM_PAGESIZE_MASK;
+		e.prsvd  = cr.cam & MMU_CAM_P;
+		e.valid  = cr.cam & MMU_CAM_V;
+		e.va     = cr.cam & MMU_CAM_VATAG_MASK;
+		e.endian = cr.ram & MMU_RAM_ENDIANNESS_MASK;
+		e.elsz   = cr.ram & MMU_RAM_ELEMENTSIZE_MASK;
+		e.pa     = cr.ram & MMU_RAM_PADDR_MASK;
+		e.mixed  = cr.ram & MMU_RAM_MIXED;
+
+		pgsz_str = (e.pgsz == MMU_CAM_PAGESIZE_16MB) ? "64MB" :
+			(e.pgsz == MMU_CAM_PAGESIZE_1MB)  ? " 1MB" :
+			(e.pgsz == MMU_CAM_PAGESIZE_64KB) ? "64KB" :
+			(e.pgsz == MMU_CAM_PAGESIZE_4KB)  ? " 4KB" :
+			" ???";
+		elsz_str = (e.elsz == MMU_RAM_ELEMENTSIZE_8)  ? " 8" :
+			(e.elsz == MMU_RAM_ELEMENTSIZE_16) ? "16" :
+			(e.elsz == MMU_RAM_ELEMENTSIZE_32) ? "32" :
+			"??";
+
+		if (i == l->base)
+			len += sprintf(buf + len, "lock base = %d\n",
+				       l->base);
+		if (i == l->victim)
+			len += sprintf(buf + len, "victim    = %d\n",
+				       l->victim);
+		len += sprintf(buf + len,
+			       /* 00: P V  4KB 0x300000 0x10171800 B 16 M */
+			       "%02d: %c %c %s 0x%06lx 0x%08lx %c %s %c\n",
+			       i,
+			       e.prsvd ? 'P' : ' ',
+			       e.valid ? 'V' : ' ',
+			       pgsz_str, e.va, e.pa,
+			       e.endian ? 'B' : 'L',
+			       elsz_str,
+			       e.mixed ? 'M' : ' ');
+	}
+	return len;
+}
+
+struct __regs {
+	char *name;
+	u32 offs;
+};
+#define __ENTRY(x) { .name = __stringify(x), .offs = x }
+static struct __regs iommu_regs[] = {
+	__ENTRY(MMU_REVISION),
+	__ENTRY(MMU_SYSCONFIG),
+	__ENTRY(MMU_SYSSTATUS),
+	__ENTRY(MMU_IRQSTATUS),
+	__ENTRY(MMU_IRQENABLE),
+	__ENTRY(MMU_WALKING_ST),
+	__ENTRY(MMU_CNTL),
+	__ENTRY(MMU_FAULT_AD),
+	__ENTRY(MMU_TTB),
+	__ENTRY(MMU_LOCK),
+	__ENTRY(MMU_LD_TLB),
+	__ENTRY(MMU_CAM),
+	__ENTRY(MMU_RAM),
+	__ENTRY(MMU_GFLUSH),
+	__ENTRY(MMU_FLUSH_ENTRY),
+	__ENTRY(MMU_READ_CAM),
+	__ENTRY(MMU_READ_RAM),
+	__ENTRY(MMU_EMU_FAULT_AD),
+};
+
+static void omap2_regs_show(struct iommu *obj)
+{
+	int i;
+	struct __regs *r;
+
+	r = &iommu_regs[0];
+	for (i = 0; i < ARRAY_SIZE(iommu_regs); i++, r++)
+		dev_info(obj->dev, "%s: %08lx\n",
+			 r->name, iommu_read_reg(obj, r->offs));
+}
+
+static struct iommu_functions omap2_iommu_ops = {
+	.startup	= omap2_iommu_startup,
+	.shutdown	= omap2_iommu_shutdown,
+	.enable		= omap2_iommu_enable,
+	.disable	= omap2_iommu_disable,
+	.isr		= omap2_arch_iommu_isr,
+
+	.tlb_cr_read	= omap2_tlb_cr_read,
+	.tlb_cr_load	= omap2_tlb_cr_load,
+
+	.cr_to_virt	= omap2_cr_to_virt,
+	.cr_alloc	= omap2_cr_alloc,
+	.cr_valid	= omap2_cr_valid,
+
+	.pte_attr_get	= omap2_pte_attr_get,
+
+	.tlb_show	= omap2_tlb_show,	/* FIXME: to debugfs bin */
+	.regs_show	= omap2_regs_show,	/* FIXME: to debugfs */
+};
+
+static int __init omap2_iommu_ops_init(void)
+{
+	iommu_arch_init(&omap2_iommu_ops);
+	return 0;
+}
+module_init(omap2_iommu_ops_init);
+
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>"
+	      "Paul Mundt and Toshihiro Kobayashi");
+MODULE_DESCRIPTION("OMAP peripheral device common MMU fucntions");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-omap/include/mach/iommu2.h b/arch/arm/plat-omap/include/mach/iommu2.h
new file mode 100644
index 0000000..ada97d7
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/iommu2.h
@@ -0,0 +1,102 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ *
+ * OMAP2 specific definitions
+ */
+#ifndef __IOMMU2_H
+#define __IOMMU2_H
+
+/*	MMU Register offsets	*/
+#define MMU_REVISION		0x00
+#define MMU_SYSCONFIG		0x10
+#define MMU_SYSSTATUS		0x14
+#define MMU_IRQSTATUS		0x18
+#define MMU_IRQENABLE		0x1c
+#define MMU_WALKING_ST	0x40
+#define MMU_CNTL		0x44
+#define MMU_FAULT_AD		0x48
+#define MMU_TTB		0x4c
+#define MMU_LOCK		0x50
+#define MMU_LD_TLB		0x54
+#define MMU_CAM		0x58
+#define MMU_RAM		0x5c
+#define MMU_GFLUSH		0x60
+#define MMU_FLUSH_ENTRY	0x64
+#define MMU_READ_CAM		0x68
+#define MMU_READ_RAM		0x6c
+#define MMU_EMU_FAULT_AD	0x70
+
+#define MMU_LOCK_BASE_SHIFT	10
+#define MMU_LOCK_BASE_MASK	(0x1f << MMU_LOCK_BASE_SHIFT)
+#define MMU_LOCK_BASE(x)	\
+	((x & MMU_LOCK_BASE_MASK) >> MMU_LOCK_BASE_SHIFT)
+
+#define MMU_LOCK_VICTIM_SHIFT	4
+#define MMU_LOCK_VICTIM_MASK	(0x1f << MMU_LOCK_VICTIM_SHIFT)
+#define MMU_LOCK_VICTIM(x)	\
+	((x & MMU_LOCK_VICTIM_MASK) >> MMU_LOCK_VICTIM_SHIFT)
+
+#define MMU_CAM_VATAG_SHIFT	12
+#define MMU_CAM_VATAG_MASK \
+	((~0UL >> MMU_CAM_VATAG_SHIFT) << MMU_CAM_VATAG_SHIFT)
+#define MMU_CAM_P		(1 << 3)
+#define MMU_CAM_V		(1 << 2)
+#define MMU_CAM_PAGESIZE_MASK	3
+#define MMU_CAM_PAGESIZE_1MB	(0 << 0)
+#define MMU_CAM_PAGESIZE_64KB	(1 << 0)
+#define MMU_CAM_PAGESIZE_4KB	(2 << 0)
+#define MMU_CAM_PAGESIZE_16MB	(3 << 0)
+
+#define MMU_RAM_PADDR_SHIFT	12
+#define MMU_RAM_PADDR_MASK \
+	((~0UL >> MMU_RAM_PADDR_SHIFT) << MMU_RAM_PADDR_SHIFT)
+#define MMU_RAM_ENDIANNESS_SHIFT	9
+#define MMU_RAM_ENDIANNESS_MASK	(1 << MMU_RAM_ENDIANNESS_SHIFT)
+#define MMU_RAM_ENDIANNESS_BIG	(1 << MMU_RAM_ENDIANNESS_SHIFT)
+#define MMU_RAM_ENDIANNESS_LITTLE	(0 << MMU_RAM_ENDIANNESS_SHIFT)
+#define MMU_RAM_ELEMENTSIZE_SHIFT	7
+#define MMU_RAM_ELEMENTSIZE_MASK	(3 << MMU_RAM_ELEMENTSIZE_SHIFT)
+#define MMU_RAM_ELEMENTSIZE_8		(0 << MMU_RAM_ELEMENTSIZE_SHIFT)
+#define MMU_RAM_ELEMENTSIZE_16	(1 << MMU_RAM_ELEMENTSIZE_SHIFT)
+#define MMU_RAM_ELEMENTSIZE_32	(2 << MMU_RAM_ELEMENTSIZE_SHIFT)
+#define MMU_RAM_ELEMENTSIZE_NONE	(3 << MMU_RAM_ELEMENTSIZE_SHIFT)
+#define MMU_RAM_MIXED_SHIFT		6
+#define MMU_RAM_MIXED			(1 << MMU_RAM_MIXED_SHIFT)
+
+static inline unsigned long pgsz2bytes(int pgsz)
+{
+	const unsigned long pgsz2bytes_array[] =
+		{ SZ_1M, SZ_64K, SZ_4K, SZ_16M, };
+	switch (pgsz) {
+	case MMU_CAM_PAGESIZE_1MB:
+	case MMU_CAM_PAGESIZE_64KB:
+	case MMU_CAM_PAGESIZE_4KB:
+	case MMU_CAM_PAGESIZE_16MB:
+		break;
+	default:
+		pr_err("Unsupported size, %xl\n", pgsz);
+		return ~0UL;
+		break;
+	}
+	return pgsz2bytes_array[pgsz];
+}
+
+struct iotlb_entry {
+	unsigned long va;
+	unsigned long pa;
+	unsigned int pgsz, prsvd, valid;
+
+	u32 endian, elsz, mixed;
+};
+
+static inline unsigned long iommu_read_reg(struct iommu *obj, unsigned long offs)
+{
+	return __raw_readl(obj->regbase + offs);
+
+}
+static inline void iommu_write_reg(struct iommu *obj, unsigned long val,
+				   unsigned long offs)
+{
+	__raw_writel(val, obj->regbase + offs);
+}
+#endif /* __IOMMU2_H */
-- 
1.5.5.1.357.g1af8b

