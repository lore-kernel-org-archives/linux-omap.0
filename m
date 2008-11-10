From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/5] omap iommu: omap2 architecture specific functions
Date: Mon, 10 Nov 2008 21:03:50 +0200
Message-ID: <1226343833-13869-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1226343833-13869-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1226343833-13869-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58979 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbYKJTEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 14:04:12 -0500
In-Reply-To: <1226343833-13869-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The structure 'arch_mmu' accommodates the difference between omap1 and
omap2/3.

This patch provides omap2/3 specific functions and its registration.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile             |    2 +
 arch/arm/mach-omap2/iommu_omap2.c        |  379 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/iommu2.h |   92 +++++++
 3 files changed, 473 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu_omap2.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3897347..31cc26d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
 mailbox_mach-objs		:= mailbox.o
 mmu_mach-objs			:= mmu.o
 
+obj-$(CONFIG_OMAP_IOMMU)		+= iommu_omap2.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
diff --git a/arch/arm/mach-omap2/iommu_omap2.c b/arch/arm/mach-omap2/iommu_omap2.c
new file mode 100644
index 0000000..848b782
--- /dev/null
+++ b/arch/arm/mach-omap2/iommu_omap2.c
@@ -0,0 +1,379 @@
+/*
+ * omap iommu: omap2 architecture specific functions
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *		Paul Mundt and Toshihiro Kobayashi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/jiffies.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/stringify.h>
+#include <linux/platform_device.h>
+
+#include <mach/iommu.h>
+#include <mach/iommu2.h>
+
+/*
+ * omap2 architecture specific register bit definitions
+ */
+#define IOMMU_ARCH_VERSION	0x00000011
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
+#define get_cam_va_mask(pgsz)				\
+	(((pgsz) == MMU_CAM_PGSZ_16M) ? 0xff000000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_1M)  ? 0xfff00000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
+
+#if defined(CONFIG_ARCH_OMAP3)
+
+#define OMAP2_MMU_REG_SIZE	256
+
+/* Camera ISP MMU */
+#define OMAP2_MMU1_BASE		0x480bd400
+#define OMAP2_MMU1_IRQ		24
+
+/* IVA2.2 MMU */
+#define OMAP2_MMU2_BASE		0x5d000000
+#define OMAP2_MMU2_IRQ		28
+
+static struct resource iommu1_res[] = { /* Camera ISP MMU */
+	{
+		.start		= OMAP2_MMU1_BASE,
+		.end		= OMAP2_MMU1_BASE + OMAP2_MMU_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MMU1_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource iommu2_res[] = { /* IVA2.2 MMU */
+	{
+		.start		= OMAP2_MMU2_BASE,
+		.end		= OMAP2_MMU2_BASE + OMAP2_MMU_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MMU2_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct iommu_platform_data omap2_iommu_platform_data[] = {
+	{
+		.name = "isp",
+		.nr_tlb_entries = 8,
+		.clk_name = "cam_ick",
+		.res = iommu1_res,
+		.n_res = ARRAY_SIZE(iommu1_res),
+	},
+	{
+		.name = "iva2",
+		.nr_tlb_entries = 32,
+		.clk_name = "iva2_ck",
+		.res = iommu2_res,
+		.n_res = ARRAY_SIZE(iommu2_res),
+	},
+};
+#else
+static struct iommu_platform_data omap2_iommu_platform_data[];
+#endif /* CONFIG_ARCH_OMAP3 */
+
+static int __init iommu_device_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap2_iommu_platform_data); i++) {
+		int err;
+		struct platform_device *new;
+		struct iommu_platform_data *p = &omap2_iommu_platform_data[i];
+
+		new = platform_device_alloc("omap-iommu", i + 1);
+		if (!new)
+			continue;
+		new->num_resources = p->n_res;
+		new->resource = p->res;
+		new->dev.platform_data = p;
+		err = platform_device_add(new);
+		if (err) {
+			platform_device_put(new);
+			continue;
+		}
+
+		p->clk = clk_get(NULL, p->clk_name);
+		BUG_ON(IS_ERR(p->clk));
+	}
+	return 0;
+}
+
+static int omap2_iommu_enable(struct iommu *obj)
+{
+	u32 l, pa;
+	unsigned long timeout;
+
+	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
+		return -EINVAL;
+
+	pa = virt_to_phys(obj->iopgd);
+	if (!IS_ALIGNED(pa, SZ_16K))
+		return -EINVAL;
+
+	iommu_write_reg(obj, MMU_SYS_SOFTRESET, MMU_SYSCONFIG);
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	do {
+		l = iommu_read_reg(obj, MMU_SYSSTATUS);
+		if (l & MMU_SYS_RESETDONE)
+			break;
+	} while (time_after(jiffies, timeout));
+
+	if (!(l & MMU_SYS_RESETDONE)) {
+		dev_err(obj->dev, "can't take MMU out of reset\n");
+		return -ENODEV;
+	}
+
+	l = iommu_read_reg(obj, MMU_REVISION);
+	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
+		 (l >> 4) & 0xf, l & 0xf);
+
+	l = iommu_read_reg(obj, MMU_SYSCONFIG);
+	l &= ~MMU_SYS_IDLE_MASK;
+	l |= MMU_SYS_IDLE_SMART;
+	iommu_write_reg(obj, l, MMU_SYSCONFIG);
+
+	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
+	iommu_write_reg(obj, pa, MMU_TTB);
+
+	l = iommu_read_reg(obj, MMU_CNTL);
+	l &= ~MMU_CNTL_MASK;
+	l |= MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN;
+	iommu_write_reg(obj, l, MMU_CNTL);
+
+	return 0;
+}
+
+static void omap2_iommu_disable(struct iommu *obj)
+{
+	u32 l = iommu_read_reg(obj, MMU_CNTL);
+
+	l &= ~MMU_CNTL_MASK;
+	iommu_write_reg(obj, l, MMU_CNTL);
+	iommu_write_reg(obj, MMU_SYS_IDLE_FORCE, MMU_SYSCONFIG);
+
+	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
+}
+
+static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
+{
+	int i;
+	u32 stat, da;
+	const char *err_msg[] =
+		{"tlb miss", "translation fault", "emulation miss",
+		 "table walk fault", "multi hit fault", };
+
+	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
+	stat &= MMU_IRQ_MASK;
+	if (!stat)
+		return 0;
+
+	da = iommu_read_reg(obj, MMU_FAULT_AD);
+	*ra = da;
+
+	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
+
+	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
+		if (stat & (1 << i))
+			pr_err("%s", err_msg[i]);
+	}
+	pr_err("\n");
+
+	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	return stat;
+}
+
+static void omap2_tlb_read_cr(struct iommu *obj, struct cr_regs *cr)
+{
+	cr->cam = iommu_read_reg(obj, MMU_READ_CAM);
+	cr->ram = iommu_read_reg(obj, MMU_READ_RAM);
+}
+
+static void omap2_tlb_load_cr(struct iommu *obj, struct cr_regs *cr)
+{
+	iommu_write_reg(obj, cr->cam | MMU_CAM_V, MMU_CAM);
+	iommu_write_reg(obj, cr->ram, MMU_RAM);
+}
+
+static u32 omap2_cr_to_virt(struct cr_regs *cr)
+{
+	u32 page_size = cr->cam & MMU_CAM_PGSZ_MASK;
+	u32 mask = get_cam_va_mask(cr->cam & page_size);
+
+	return cr->cam & mask;
+}
+
+static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
+{
+	struct cr_regs *cr;
+
+	if (e->da & ~(get_cam_va_mask(e->pgsz))) {
+		dev_err(obj->dev, "%s:\twrong alignment: %08x\n", __func__,
+			e->da);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
+	if (!cr)
+		return ERR_PTR(-ENOMEM);
+
+	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->ram = e->pa | e->endian | e->elsz;
+
+	return cr;
+}
+
+static inline int omap2_cr_valid(struct cr_regs *cr)
+{
+	return cr->cam & MMU_CAM_V;
+}
+
+static pgprot_t omap2_get_pte_attr(struct iotlb_entry *e)
+{
+	u32 attr;
+
+	attr = e->mixed << 5;
+	attr |= e->endian;
+	attr |= e->elsz >> 3;
+	attr <<= ((e->pgsz & MMU_CAM_PGSZ_4K) ? 0 : 6);
+
+	return attr;
+}
+
+static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
+{
+	char *p = buf;
+
+	/* FIXME: Need more detail analysis of cam/ram */
+	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
+
+	return p - buf;
+}
+
+#ifdef DEBUG
+#define pr_reg(name)							\
+	p += sprintf(p, "%20s: %08lx\n",				\
+		     __stringify(name), iommu_read_reg(obj, MMU_##name));
+
+static ssize_t omap2_dump_regs(struct iommu *obj, char *buf)
+{
+	char *p = buf;
+
+	pr_reg(REVISION);
+	pr_reg(SYSCONFIG);
+	pr_reg(SYSSTATUS);
+	pr_reg(IRQSTATUS);
+	pr_reg(IRQENABLE);
+	pr_reg(WALKING_ST);
+	pr_reg(CNTL);
+	pr_reg(FAULT_AD);
+	pr_reg(TTB);
+	pr_reg(LOCK);
+	pr_reg(LD_TLB);
+	pr_reg(CAM);
+	pr_reg(RAM);
+	pr_reg(GFLUSH);
+	pr_reg(FLUSH_ENTRY);
+	pr_reg(READ_CAM);
+	pr_reg(READ_RAM);
+	pr_reg(EMU_FAULT_AD);
+
+	return p - buf;
+}
+#else
+#define omap2_dump_regs NULL
+#endif /* DEBUG */
+
+static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
+{
+	e->da		= cr->cam & MMU_CAM_VATAG_MASK;
+	e->pa		= cr->ram & MMU_RAM_PADDR_MASK;
+	e->valid	= cr->cam & MMU_CAM_V;
+	e->pgsz		= cr->cam & MMU_CAM_PGSZ_MASK;
+	e->endian	= cr->ram & MMU_RAM_ENDIAN_MASK;
+	e->elsz		= cr->ram & MMU_RAM_ELSZ_MASK;
+	e->mixed	= cr->ram & MMU_RAM_MIXED;
+}
+
+static const struct iommu_functions omap2_iommu_ops = {
+	.version	= IOMMU_ARCH_VERSION,
+
+	.enable		= omap2_iommu_enable,
+	.disable	= omap2_iommu_disable,
+	.fault_isr	= omap2_iommu_fault_isr,
+
+	.tlb_read_cr	= omap2_tlb_read_cr,
+	.tlb_load_cr	= omap2_tlb_load_cr,
+
+	.cr_to_e	= omap2_cr_to_e,
+	.cr_to_virt	= omap2_cr_to_virt,
+	.alloc_cr	= omap2_alloc_cr,
+	.cr_valid	= omap2_cr_valid,
+	.dump_cr	= omap2_dump_cr,
+
+	.get_pte_attr	= omap2_get_pte_attr,
+
+	.dump_regs	= omap2_dump_regs,
+};
+
+static int __init omap2_iommu_init(void)
+{
+	iommu_set_arch(&omap2_iommu_ops);
+
+	return iommu_device_init();
+}
+module_init(omap2_iommu_init);
+
+MODULE_AUTHOR("Hiroshi DOYU, Paul Mundt and Toshihiro Kobayashi");
+MODULE_DESCRIPTION("omap iommu: omap2 architecture specific functions");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/include/mach/iommu2.h b/arch/arm/plat-omap/include/mach/iommu2.h
new file mode 100644
index 0000000..ad2bb5b
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/iommu2.h
@@ -0,0 +1,92 @@
+/*
+ * omap iommu: omap2 architecture specific definitions
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_IOMMU2_H
+#define __MACH_IOMMU2_H
+
+/*
+ * MMU Register offsets
+ */
+#define MMU_REVISION		0x00
+#define MMU_SYSCONFIG		0x10
+#define MMU_SYSSTATUS		0x14
+#define MMU_IRQSTATUS		0x18
+#define MMU_IRQENABLE		0x1c
+#define MMU_WALKING_ST		0x40
+#define MMU_CNTL		0x44
+#define MMU_FAULT_AD		0x48
+#define MMU_TTB			0x4c
+#define MMU_LOCK		0x50
+#define MMU_LD_TLB		0x54
+#define MMU_CAM			0x58
+#define MMU_RAM			0x5c
+#define MMU_GFLUSH		0x60
+#define MMU_FLUSH_ENTRY		0x64
+#define MMU_READ_CAM		0x68
+#define MMU_READ_RAM		0x6c
+#define MMU_EMU_FAULT_AD	0x70
+
+/*
+ * MMU Register bit definitions
+ */
+#define MMU_LOCK_BASE_SHIFT	10
+#define MMU_LOCK_BASE_MASK	(0x1f << MMU_LOCK_BASE_SHIFT)
+#define MMU_LOCK_BASE(x)	\
+	((x & MMU_LOCK_BASE_MASK) >> MMU_LOCK_BASE_SHIFT)
+
+#define MMU_LOCK_VICT_SHIFT	4
+#define MMU_LOCK_VICT_MASK	(0x1f << MMU_LOCK_VICT_SHIFT)
+#define MMU_LOCK_VICT(x)	\
+	((x & MMU_LOCK_VICT_MASK) >> MMU_LOCK_VICT_SHIFT)
+
+#define MMU_CAM_VATAG_SHIFT	12
+#define MMU_CAM_VATAG_MASK \
+	((~0UL >> MMU_CAM_VATAG_SHIFT) << MMU_CAM_VATAG_SHIFT)
+#define MMU_CAM_P		(1 << 3)
+#define MMU_CAM_V		(1 << 2)
+#define MMU_CAM_PGSZ_MASK	3
+#define MMU_CAM_PGSZ_1M		(0 << 0)
+#define MMU_CAM_PGSZ_64K	(1 << 0)
+#define MMU_CAM_PGSZ_4K		(2 << 0)
+#define MMU_CAM_PGSZ_16M	(3 << 0)
+
+#define MMU_RAM_PADDR_SHIFT	12
+#define MMU_RAM_PADDR_MASK \
+	((~0UL >> MMU_RAM_PADDR_SHIFT) << MMU_RAM_PADDR_SHIFT)
+#define MMU_RAM_ENDIAN_SHIFT	9
+#define MMU_RAM_ENDIAN_MASK	(1 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ENDIAN_BIG	(1 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ENDIAN_LITTLE	(0 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ELSZ_SHIFT	7
+#define MMU_RAM_ELSZ_MASK	(3 << MMU_RAM_ELSZ_SHIFT)
+#define MMU_RAM_ELSZ_8		(0 << MMU_RAM_ELSZ_SHIFT)
+#define MMU_RAM_ELSZ_16		(1 << MMU_RAM_ELSZ_SHIFT)
+#define MMU_RAM_ELSZ_32		(2 << MMU_RAM_ELSZ_SHIFT)
+#define MMU_RAM_ELSZ_NONE	(3 << MMU_RAM_ELSZ_SHIFT)
+#define MMU_RAM_MIXED_SHIFT	6
+#define MMU_RAM_MIXED_MASK	(1 << MMU_RAM_MIXED_SHIFT)
+#define MMU_RAM_MIXED		MMU_RAM_MIXED_MASK
+
+/*
+ * register accessors
+ */
+static inline u32 iommu_read_reg(struct iommu *obj, size_t offs)
+{
+	return __raw_readl(obj->regbase + offs);
+}
+
+static inline void iommu_write_reg(struct iommu *obj, u32 val, size_t offs)
+{
+	__raw_writel(val, obj->regbase + offs);
+}
+
+#endif /* __MACH_IOMMU2_H */
-- 
1.6.0.3.613.g9f8f13

