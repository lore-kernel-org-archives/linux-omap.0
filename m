From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 11/20] ARM: OMAP4: PM: Add SAR backup support towards device OFF
Date: Tue, 12 Jun 2012 18:31:26 +0300
Message-ID: <1339515095-9908-12-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2FLPcY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:24 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Most of the device register contents are lost during device off. To
resume properly from this, a special memory area called SAR RAM is
maintained during device off, and its contents are restored to HW
registers during wakeup. The register layout is fixed in SAR RAM.
SAR is split into 4 banks with different privilege accesses based
on device type:

 ---------------------------------------------------------------
 Access mode            Bank    Address Range
 ---------------------------------------------------------------
 HS/GP : Public         1       0x4A32_6000 - 0x4A32_6FFF (4kB)
 HS/GP : Public         2       0x4A32_7000 - 0x4A32_73FF (1kB)

 HS/EMU : Secured
 GP : Public            3       0x4A32_8000 - 0x4A32_87FF (2kB)

 HS/GP :Secure
 write once.            4       0x4A32_9000 - 0x4A32_93FF (1kB)
 ---------------------------------------------------------------

The save process is done entirely by software and restore is done by
hardware using the auto-restore feature. The restore feature is enabled
by default and cannot be disabled. The software must save the data
to be restored in a dedicated location in SAR RAM.

IO address -> SAR RAM layout is generated during init time from the
contents of the SAR ROM. An algorithm is executed which parses the
contents of each SAR ROM entry, and creates IO -> SAR RAM mapping
based on this. This mapping is then later used before each entry
to device off to save the IO registers to the SAR RAM.

Original code written by Santosh Shilimkar <santosh.shilimkar@ti.com>,
updated with the auto generate feature by Tero Kristo <t-kristo@ti.com>.
Contributions / cleanups to the original code were received from
Rajeev Kulkarni <rajeev@ti.com>,
Nishanth Menon <nm@ti.com>,
Axel Haslam <axelhaslam@gmail.com> and
Avinash.H.M <avinashhm@ti.com>.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/cm1_44xx.h             |    2 +
 arch/arm/mach-omap2/cm2_44xx.h             |    2 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |    6 +
 arch/arm/mach-omap2/omap-sar.c             |  623 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c         |   28 --
 arch/arm/mach-omap2/omap4-sar-layout.h     |   26 ++
 arch/arm/mach-omap2/pm.h                   |    8 +
 arch/arm/plat-omap/include/plat/omap44xx.h |    6 +
 9 files changed, 674 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-sar.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..f7ca602 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
-obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o omap-sar.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-omap2/cm1_44xx.h b/arch/arm/mach-omap2/cm1_44xx.h
index 1bc00dc..c21b660 100644
--- a/arch/arm/mach-omap2/cm1_44xx.h
+++ b/arch/arm/mach-omap2/cm1_44xx.h
@@ -218,8 +218,10 @@
 #define OMAP4430_CM1_ABE_WDT3_CLKCTRL			OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_INST, 0x0088)
 
 /* Function prototypes */
+#ifndef __ASSEMBLER__
 extern u32 omap4_cm1_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 idx);
 extern u32 omap4_cm1_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/cm2_44xx.h b/arch/arm/mach-omap2/cm2_44xx.h
index b9de72d..3e8871e 100644
--- a/arch/arm/mach-omap2/cm2_44xx.h
+++ b/arch/arm/mach-omap2/cm2_44xx.h
@@ -450,8 +450,10 @@
 #define OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL		OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CEFUSE_INST, 0x0020)
 
 /* Function prototypes */
+#ifndef __ASSEMBLER__
 extern u32 omap4_cm2_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 idx);
 extern u32 omap4_cm2_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index f1a1db0..da84339 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -234,6 +234,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int save_state = 0;
 	unsigned int wakeup_cpu;
+	int ret;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
@@ -267,6 +268,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 */
 	mpuss_clear_prev_logic_pwrst();
 	if (pwrdm_read_next_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF) {
+		/* Save the device context to SAR RAM */
+		ret = omap_sar_save();
+		if (ret)
+			goto sar_save_failed;
 		omap4_cm_prepare_off();
 		omap4_dpll_prepare_off();
 		save_state = 3;
@@ -301,6 +306,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		omap4_cm_resume_off();
 	}
 
+sar_save_failed:
 	pwrdm_post_transition();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/omap-sar.c b/arch/arm/mach-omap2/omap-sar.c
new file mode 100644
index 0000000..548454e
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-sar.c
@@ -0,0 +1,623 @@
+/*
+ * OMAP4 Save Restore source file
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+
+#include "iomap.h"
+#include "pm.h"
+#include "clockdomain.h"
+
+#include "omap4-sar-layout.h"
+#include "cm-regbits-44xx.h"
+#include "cm-regbits-34xx.h"
+#include "prcm44xx.h"
+#include "cminst44xx.h"
+
+static void __iomem *sar_ram_base;
+static struct powerdomain *l3init_pwrdm;
+	static struct clockdomain *l3init_clkdm;
+static struct clk *usb_host_ck, *usb_tll_ck;
+
+/**
+ * struct sar_ram_entry - SAR RAM layout descriptor
+ * @io_base: IO base address for the entry
+ * @offset: IO offset from @io_base
+ * @size: size of entry in words, size=0 marks end of descriptor array
+ * @ram_addr: SAR RAM address to store the data to
+ */
+struct sar_ram_entry {
+	void __iomem *io_base;
+	u32 offset;
+	u32 size;
+	u32 ram_addr;
+};
+
+/**
+ * struct sar_overwrite_entry - SAR RAM overwrite descriptor
+ * @reg_addr: register address
+ * @sar_offset: offset in SAR RAM
+ * @valid: whether data for this entry was found or not from SAR ROM
+ */
+struct sar_overwrite_entry {
+	u32 reg_addr;
+	u32 sar_offset;
+	bool valid;
+};
+
+enum {
+	MEMIF_CLKSTCTRL_IDX,
+	SHADOW_FREQ_CFG2_IDX,
+	SHADOW_FREQ_CFG1_IDX,
+	MEMIF_CLKSTCTRL_2_IDX,
+	HSUSBHOST_CLKCTRL_IDX,
+	HSUSBHOST_CLKCTRL_2_IDX,
+	L3INIT_CLKSTCTRL_IDX,
+	OW_IDX_SIZE
+};
+
+static struct sar_ram_entry *sar_ram_layout[3];
+static struct sar_overwrite_entry *sar_overwrite_data;
+
+static struct sar_overwrite_entry omap4_sar_overwrite_data[OW_IDX_SIZE] = {
+	[MEMIF_CLKSTCTRL_IDX] = { .reg_addr = 0x4a009e0c },
+	[SHADOW_FREQ_CFG2_IDX] = { .reg_addr = 0x4a004e2c },
+	[SHADOW_FREQ_CFG1_IDX] = { .reg_addr = 0x4a004e30 },
+	[MEMIF_CLKSTCTRL_2_IDX] = { .reg_addr = 0x4a009e0c },
+	[HSUSBHOST_CLKCTRL_IDX] = { .reg_addr = 0x4a009e54 },
+	[HSUSBHOST_CLKCTRL_2_IDX] = { .reg_addr = 0x4a009e54 },
+	[L3INIT_CLKSTCTRL_IDX] = { .reg_addr = 0x4a009300 },
+};
+
+/**
+ * check_overwrite_data - update matching SAR overwrite entry
+ * @io_addr: IO address of the entry to lookup
+ * @ram_addr: SAR RAM address of the entry to update
+ * @size: size of the entry in words
+ *
+ * Checks a single SAR RAM entry against existing SAR RAM overwrite data.
+ * If a matching overwrite location is found, update the pointers for
+ * that entry. As each SAR RAM entry is of @size, the function must
+ * go over the whole entry area in a for loop to find any possible
+ * matching locations.
+ */
+static void check_overwrite_data(u32 io_addr, u32 ram_addr, int size)
+{
+	int i;
+
+	while (size) {
+		for (i = 0; i < OW_IDX_SIZE; i++) {
+			if (sar_overwrite_data[i].reg_addr == io_addr &&
+			    !sar_overwrite_data[i].valid) {
+				sar_overwrite_data[i].sar_offset = ram_addr;
+				sar_overwrite_data[i].valid = true;
+				break;
+			}
+		}
+		size--;
+		io_addr += 4;
+		ram_addr += 4;
+	}
+}
+
+/**
+ * omap_sar_save - saves a SAR RAM layout
+ * @entry: first descriptor for the layout to save
+ *
+ * common routine to save the registers to SAR RAM with the
+ * given parameters
+ */
+static void sar_save(struct sar_ram_entry *entry)
+{
+	u32 reg_val, size, offset;
+	void __iomem *reg_read_addr, *sar_wr_addr;
+
+	while (entry->size) {
+		size = entry->size;
+		reg_read_addr = entry->io_base + entry->offset;
+		sar_wr_addr = sar_ram_base + entry->ram_addr;
+		for (offset = 0; offset < size * 4; offset += 4) {
+			reg_val = __raw_readl(reg_read_addr + offset);
+			__raw_writel(reg_val, sar_wr_addr + offset);
+		}
+		entry++;
+	}
+}
+
+/**
+ * save_sar_bank3 - save SAR RAM bank 3
+ *
+ * Saves SAR RAM bank 3, this contains static data and should be saved
+ * only once during boot.
+ */
+static void save_sar_bank3(void)
+{
+	struct clockdomain *l4_secure_clkdm;
+
+	/*
+	 * Not supported on ES1.0 silicon
+	 */
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN_ONCE(1, "omap4: SAR backup not supported on ES1.0 ..\n");
+		return;
+	}
+
+	l4_secure_clkdm = clkdm_lookup("l4_secure_clkdm");
+	clkdm_wakeup(l4_secure_clkdm);
+
+	sar_save(sar_ram_layout[2]);
+
+	clkdm_allow_idle(l4_secure_clkdm);
+}
+
+/**
+ * omap4_sar_not_accessible - checks if all SAR IO areas are accessible
+ *
+ * Check if all SAR RAM IO locations are accessible or not. Namely,
+ * USB host and TLL modules should be idle.
+ */
+static int omap4_sar_not_accessible(void)
+{
+	u32 usbhost_state, usbtll_state;
+
+	/*
+	 * Make sure that USB host and TLL modules are not
+	 * enabled before attempting to save the context
+	 * registers, otherwise this will trigger an exception.
+	 */
+	usbhost_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
+				OMAP4430_CM2_L3INIT_INST,
+				OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET);
+	usbhost_state &= (OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK);
+
+	usbtll_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
+				OMAP4430_CM2_L3INIT_INST,
+				OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET);
+	usbtll_state &= OMAP4430_IDLEST_MASK;
+
+	if ((usbhost_state == (OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK)) &&
+	    (usbtll_state == (OMAP4430_IDLEST_MASK)))
+		return 0;
+	else
+		return -EBUSY;
+}
+
+/**
+ * omap_sar_overwrite :
+ * This API overwrites some of the SAR locations as a special cases
+ * The register content to be saved can be the register value before
+ * going into OFF-mode or a value that is required on wake up. This means
+ * that the restored register value can be different from the last value
+ * of the register before going into OFF-mode
+ *	- CM1 and CM2 configuration
+ *		Bits 0 of the CM_SHADOW_FREQ_CONFIG1 regiser and the
+ *		CM_SHADOW_FREQ_CONFIG2 register are self-clearing and must
+ *		 be set at restore time. Thus, these data must always be
+ *		overwritten in the SAR RAM.
+ *	- Because USBHOSTHS and USBTLL restore needs a particular
+ *		sequencing, the software must overwrite data read from
+ *		the following registers implied in phase2a and phase 2b
+ */
+static void omap_sar_overwrite(void)
+{
+	u32 val = 0;
+	u32 offset = 0;
+
+	if (sar_overwrite_data[MEMIF_CLKSTCTRL_IDX].valid)
+		__raw_writel(0x2, sar_ram_base +
+			sar_overwrite_data[MEMIF_CLKSTCTRL_IDX].sar_offset);
+
+	if (sar_overwrite_data[SHADOW_FREQ_CFG1_IDX].valid) {
+		offset = sar_overwrite_data[SHADOW_FREQ_CFG1_IDX].sar_offset;
+		val = __raw_readl(sar_ram_base + offset);
+		val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
+		val &= ~OMAP4430_DLL_OVERRIDE_2_2_MASK;
+		__raw_writel(val, sar_ram_base + offset);
+	}
+
+	if (sar_overwrite_data[SHADOW_FREQ_CFG2_IDX].valid) {
+		offset = sar_overwrite_data[SHADOW_FREQ_CFG2_IDX].sar_offset;
+		val = __raw_readl(sar_ram_base + offset);
+		/*
+		 * FIXME: Implement FREQ UPDATE for L#/M5 before enabling
+		 * val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
+		 */
+		__raw_writel(val, sar_ram_base + offset);
+	}
+
+	if (sar_overwrite_data[MEMIF_CLKSTCTRL_2_IDX].valid)
+		__raw_writel(0x3, sar_ram_base +
+			sar_overwrite_data[MEMIF_CLKSTCTRL_2_IDX].sar_offset);
+
+	if (sar_overwrite_data[HSUSBHOST_CLKCTRL_IDX].valid) {
+		offset = sar_overwrite_data[HSUSBHOST_CLKCTRL_IDX].sar_offset;
+
+		/* Overwriting Phase2a data to be restored */
+		/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 1, MODULEMODE = 2 */
+		__raw_writel(OMAP4430_SAR_MODE_MASK | 0x2,
+			sar_ram_base + offset);
+		/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 1, MODULEMODE = 1 */
+		__raw_writel(OMAP4430_SAR_MODE_MASK | 0x1,
+			sar_ram_base + offset + 4);
+		/*
+		 * CM2 CM_SDMA_STATICDEP : Enable static depedency for
+		 * SAR modules
+		 */
+		__raw_writel(OMAP4430_L4WKUP_STATDEP_MASK |
+			     OMAP4430_L4CFG_STATDEP_MASK |
+			     OMAP4430_L3INIT_STATDEP_MASK |
+			     OMAP4430_L3_1_STATDEP_MASK |
+			     OMAP4430_L3_2_STATDEP_MASK |
+			     OMAP4430_ABE_STATDEP_MASK,
+			     sar_ram_base + offset + 8);
+	}
+
+	if (sar_overwrite_data[HSUSBHOST_CLKCTRL_2_IDX].valid) {
+		offset = sar_overwrite_data[HSUSBHOST_CLKCTRL_2_IDX].sar_offset;
+
+		/* Overwriting Phase2b data to be restored */
+		/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
+		val = __raw_readl(OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL);
+		val &= (OMAP4430_CLKSEL_UTMI_P1_MASK |
+			OMAP4430_CLKSEL_UTMI_P2_MASK);
+		__raw_writel(val, sar_ram_base + offset);
+		/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
+		__raw_writel(0, sar_ram_base + offset + 4);
+		/* CM2 CM_SDMA_STATICDEP : Clear the static depedency */
+		__raw_writel(OMAP4430_L3_2_STATDEP_MASK,
+			     sar_ram_base + offset + 8);
+	}
+
+	if (sar_overwrite_data[L3INIT_CLKSTCTRL_IDX].valid) {
+		offset = sar_overwrite_data[L3INIT_CLKSTCTRL_IDX].sar_offset;
+
+		/*
+		 * Set CM_L3INIT_CLKSTRCTRL to FORCE_SLEEP, it is enabled
+		 * during SAR save and gets incorrect value of FORCE_WAKEUP.
+		 */
+		val = __raw_readl(sar_ram_base + offset);
+		val &= ~(OMAP4430_CLKTRCTRL_MASK);
+		val |= OMAP34XX_CLKSTCTRL_FORCE_SLEEP;
+		__raw_writel(val, sar_ram_base + offset);
+	}
+
+	/* readback to ensure data reaches to SAR RAM */
+	barrier();
+	val = __raw_readl(sar_ram_base + offset);
+}
+
+/**
+ * omap_sar_save - save sar context to SAR RAM
+ *
+ * Save the context to SAR_RAM1 and SAR_RAM2 as per the generated SAR
+ * RAM layouts (sar_ram_layout[0] / [1]) and overwrite parts of the
+ * area according to the overwrite data. This must be done before
+ * attempting device off mode.
+ */
+int omap_sar_save(void)
+{
+	if (omap4_sar_not_accessible()) {
+		pr_debug("%s: USB SAR CNTX registers are not accessible!\n",
+			__func__);
+		return -EBUSY;
+	}
+
+	/*
+	 * SAR bits and clocks needs to be enabled
+	 */
+	clkdm_wakeup(l3init_clkdm);
+	pwrdm_enable_hdwr_sar(l3init_pwrdm);
+	clk_enable(usb_host_ck);
+	clk_enable(usb_tll_ck);
+
+	/* Save SAR BANK1 */
+	sar_save(sar_ram_layout[0]);
+
+	clk_disable(usb_host_ck);
+	clk_disable(usb_tll_ck);
+	pwrdm_disable_hdwr_sar(l3init_pwrdm);
+	clkdm_allow_idle(l3init_clkdm);
+
+	/* Save SAR BANK2 */
+	sar_save(sar_ram_layout[1]);
+
+	omap_sar_overwrite();
+
+	return 0;
+}
+
+void __iomem *omap4_get_sar_ram_base(void)
+{
+	return sar_ram_base;
+}
+
+/*
+ * SAR ROM phases correspond to different restore phases executed
+ * according to TRM chapter 16.4.21.4. "SAR ROM". Different phases
+ * are executed according to different types of wakeups, and at
+ * different points of wakeup chain. All the data must be stored
+ * for the restore to be successful before device off entry. The
+ * values in this array are offsets from the SAR ROM base address.
+ */
+static const u32 sar_rom_phases[] = {
+	0, 0x30, 0x60
+};
+
+/**
+ * struct sar_module - SAR IO module declarations
+ * @io_base: IO base pointer for the module
+ * @base: base physical address for the module
+ * @size: size of the module
+ * @invalid: flag for marking modules invalid for certain architectures
+ */
+struct sar_module {
+	void __iomem *io_base;
+	u32 base;
+	u32 size;
+	bool invalid;
+};
+
+static struct sar_module *sar_modules;
+
+/**
+ * sar_ioremap_modules - map the IO address space for all modules
+ *
+ * Maps the whole IO address space required by SAR mechanism for
+ * reading the registers from IO address space.
+ */
+static void sar_ioremap_modules(void)
+{
+	struct sar_module *mod;
+
+	mod = sar_modules;
+
+	while (mod->base) {
+		if (!mod->invalid) {
+			mod->io_base = ioremap(mod->base, mod->size);
+			if (!mod->io_base)
+				pr_err("%s: ioremap failed for %08x[%08x]\n",
+					__func__, mod->base, mod->size);
+			WARN_ON(!mod->io_base);
+		}
+		mod++;
+	}
+}
+
+/**
+ * set_sar_io_addr - route SAR RAM entry to SAR IO module
+ * @entry: SAR RAM entry to route
+ * @addr: target IO address
+ *
+ * Scans available SAR IO modules for a matching one. If a match is
+ * found, sets the entry base address to point the IO address space
+ * and calculates the address offset from the beginning of the module.
+ * Returns 0 if a matching IO module was found, -EINVAL otherwise.
+ */
+static int set_sar_io_addr(struct sar_ram_entry *entry, u32 addr)
+{
+	struct sar_module *mod;
+
+	mod = sar_modules;
+
+	while (mod->base) {
+		if (addr >= mod->base && addr <= mod->base + mod->size) {
+			if (mod->invalid)
+				break;
+			entry->io_base = mod->io_base;
+			entry->offset = addr - mod->base;
+			return 0;
+		}
+		mod++;
+	}
+	pr_warn("%s: no matching sar_module for %08x\n", __func__, addr);
+	return -EINVAL;
+}
+
+/**
+ * sar_layout_generate - generates SAR RAM layout based on SAR ROM contents
+ *
+ * This function parses the contents of the SAR ROM to generate SAR RAM
+ * layout entries. SAR ROM consists of following entries:
+ *      u32 next        : pointer to next element on ROM
+ *      u32 size        : number of words to restore
+ *      u32 ram_address : SAR RAM address to restore from
+ *      u32 io_address  : IO address to write SAR RAM contents to
+ *
+ * The function parses each SAR ROM entry, checks the validity of pointers
+ * to both IO and SAR RAM, and adds the entry to the list if it is valid.
+ * After adding the entry, next ROM entry is parsed, unless the target
+ * pointer is outside of SAR ROM area which indicates end of restore chain.
+ * Returns 0 on success, negative error value otherwise.
+ */
+static int sar_layout_generate(void)
+{
+	int phase;
+	void __iomem *sarrom;
+	u32 rombase, romend, rambase, ramend;
+	u32 offset, next;
+	u16 size;
+	u32 ram_addr, io_addr;
+	void *sarram;
+	struct sar_ram_entry *entry[3];
+	int bank;
+	int ret = 0;
+
+	pr_info("generating sar_ram layout...\n");
+
+	rombase = OMAP44XX_SAR_ROM_BASE;
+	romend = rombase + SZ_8K;
+	rambase = OMAP44XX_SAR_RAM_BASE;
+	ramend = rambase + SAR_BANK4_OFFSET - 1;
+
+	sarrom = ioremap(rombase, SZ_8K);
+
+	/*
+	 * Allocate temporary memory for sar ram layout. The amount
+	 * allocated is exaggerated to make sure everything fits in,
+	 * this memory is freed once SAR RAM layout generation is
+	 * completed and actual sizes are known
+	 */
+	sarram = kmalloc(SAR_BANK4_OFFSET, GFP_KERNEL);
+	for (bank = 0; bank < 3; bank++)
+		entry[bank] = sarram + SAR_BANK2_OFFSET * bank;
+
+	/* Go through each SAR ROM restore phase */
+	for (phase = 0; phase < ARRAY_SIZE(sar_rom_phases); phase++) {
+		offset = sar_rom_phases[phase];
+
+		while (1) {
+			next = __raw_readl(sarrom + offset);
+			size = __raw_readl(sarrom + offset + 4) & 0xffff;
+			ram_addr = __raw_readl(sarrom + offset + 8);
+			io_addr = __raw_readl(sarrom + offset + 12);
+
+			if (ram_addr >= rambase && ram_addr <= ramend) {
+				/* Valid ram address, add entry */
+				ram_addr -= rambase;
+
+				/* Calculate which bank we are using */
+				bank = ram_addr / SAR_BANK2_OFFSET;
+
+				if (!set_sar_io_addr(entry[bank], io_addr)) {
+					entry[bank]->size = size;
+					entry[bank]->ram_addr = ram_addr;
+					check_overwrite_data(io_addr, ram_addr,
+						size);
+					entry[bank]++;
+				}
+			}
+
+			/*
+			 * If pointer to next SAR ROM address is invalid,
+			 * stop. Indicates end of restore phase.
+			 */
+			if (next < rombase || next > romend)
+				break;
+
+			offset = next - rombase;
+		}
+	}
+
+	/* Copy SAR RAM entry data to permanent location */
+	for (bank = 0; bank < 3; bank++) {
+		size = (u32)entry[bank] -
+			(u32)(sarram + SAR_BANK2_OFFSET * bank);
+		sar_ram_layout[bank] = kmalloc(size +
+			sizeof(struct sar_ram_entry), GFP_KERNEL);
+		if (!sar_ram_layout[bank]) {
+			pr_err("%s: kmalloc failed\n", __func__);
+			goto cleanup;
+		}
+		memcpy(sar_ram_layout[bank], sarram + SAR_BANK2_OFFSET * bank,
+			size);
+		memset((void *)sar_ram_layout[bank] + size, 0,
+			sizeof(struct sar_ram_entry));
+		entry[bank] = sar_ram_layout[bank];
+	}
+
+cleanup:
+	kfree(sarram);
+	iounmap(sarrom);
+	pr_info("sar ram layout created\n");
+	return ret;
+}
+
+/*
+ * SAR IO module mapping. This is used to access the hardware registers
+ * during SAR save.
+ */
+static struct sar_module omap44xx_sar_modules[] = {
+	{ .base = OMAP44XX_EMIF1_BASE, .size = SZ_1M },
+	{ .base = OMAP44XX_EMIF2_BASE, .size = SZ_1M },
+	{ .base = OMAP44XX_DMM_BASE, .size = SZ_1M },
+	{ .base = OMAP4430_CM1_BASE, .size = SZ_8K },
+	{ .base = OMAP4430_CM2_BASE, .size = SZ_8K },
+	{ .base = OMAP44XX_C2C_BASE, .size = SZ_1M },
+	{ .base = OMAP443X_CTRL_BASE, .size = SZ_4K },
+	{ .base = L3_44XX_BASE_CLK1, .size = SZ_1M },
+	{ .base = L3_44XX_BASE_CLK2, .size = SZ_1M },
+	{ .base = L3_44XX_BASE_CLK3, .size = SZ_1M },
+	{ .base = OMAP44XX_USBTLL_BASE, .size = SZ_1M },
+	{ .base = OMAP44XX_UHH_CONFIG_BASE, .size = SZ_1M },
+	{ .base = L4_44XX_PHYS, .size = SZ_4M },
+	{ .base = L4_PER_44XX_PHYS, .size = SZ_4M },
+	{ .base = 0 },
+};
+
+/**
+ * omap4_sar_ram_init - initializes SAR save mechanism
+ *
+ * This function allocates the IO maps, generates the SAR RAM layout
+ * entries, detects the overwrite locations and stores the once per
+ * boot type data (sar_bank3). Also L3INIT clockdomain / clocks
+ * are allocated, which are needed during SAR save.
+ */
+static int __init omap4_sar_ram_init(void)
+{
+	/*
+	 * To avoid code running on other OMAPs in
+	 * multi-omap builds
+	 */
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	/*
+	 * Static mapping, never released Actual SAR area used is 8K it's
+	 * spaced over 16K address with some part is reserved.
+	 */
+	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
+	if (WARN_ON(!sar_ram_base))
+		return -ENOMEM;
+
+	sar_modules = omap44xx_sar_modules;
+	sar_overwrite_data = omap4_sar_overwrite_data;
+
+	sar_ioremap_modules();
+
+	sar_layout_generate();
+
+	/*
+	 * SAR BANK3 contains all firewall settings and it's saved through
+	 * secure API on HS device. On GP device these registers are
+	 * meaningless but still needs to be saved. Otherwise Auto-restore
+	 * phase DMA takes an abort. Hence save these conents only once
+	 * in init to avoid the issue while waking up from device OFF
+	 */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		save_sar_bank3();
+
+	/*
+	 * L3INIT PD and clocks are needed for SAR save phase
+	 */
+	l3init_pwrdm = pwrdm_lookup("l3init_pwrdm");
+	if (!l3init_pwrdm)
+		pr_err("Failed to get l3init_pwrdm\n");
+
+	l3init_clkdm = clkdm_lookup("l3_init_clkdm");
+	if (!l3init_clkdm)
+		pr_err("Failed to get l3_init_clkdm\n");
+
+	usb_host_ck = clk_get_sys("usbhs_omap", "hs_fck");
+	if (IS_ERR(usb_host_ck))
+		pr_err("Could not get usb_host_ck\n");
+
+	usb_tll_ck = clk_get_sys("usbhs_omap", "usbtll_ick");
+	if (IS_ERR(usb_tll_ck))
+		pr_err("Could not get usb_tll_ck\n");
+
+	return 0;
+}
+early_initcall(omap4_sar_ram_init);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 07ca05b..4e2da77 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -39,7 +39,6 @@
 static void __iomem *l2cache_base;
 #endif
 
-static void __iomem *sar_ram_base;
 static void __iomem *gic_dist_base_addr;
 
 #ifdef CONFIG_OMAP4_ERRATA_I688
@@ -189,33 +188,6 @@ static int __init omap_l2_cache_init(void)
 early_initcall(omap_l2_cache_init);
 #endif
 
-void __iomem *omap4_get_sar_ram_base(void)
-{
-	return sar_ram_base;
-}
-
-/*
- * SAR RAM used to save and restore the HW
- * context in low power modes
- */
-static int __init omap4_sar_ram_init(void)
-{
-	/*
-	 * To avoid code running on other OMAPs in
-	 * multi-omap builds
-	 */
-	if (!cpu_is_omap44xx())
-		return -ENOMEM;
-
-	/* Static mapping, never released */
-	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
-	if (WARN_ON(!sar_ram_base))
-		return -ENOMEM;
-
-	return 0;
-}
-early_initcall(omap4_sar_ram_init);
-
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index fe5b545..e99955f 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -11,6 +11,32 @@
 #ifndef OMAP_ARCH_OMAP4_SAR_LAYOUT_H
 #define OMAP_ARCH_OMAP4_SAR_LAYOUT_H
 
+#include <mach/hardware.h>
+#include <mach/ctrl_module_pad_core_44xx.h>
+
+#include "cm1_44xx.h"
+#include "cm2_44xx.h"
+#include "prcm-common.h"
+
+/*
+ * The SAR RAM is maintained during Device OFF mode.
+ * It is split into 4 banks with different privilege accesses
+ *
+ * ---------------------------------------------------------------------
+ * Access mode			Bank	Address Range
+ * ---------------------------------------------------------------------
+ * HS/GP : Public		1	0x4A32_6000 - 0x4A32_6FFF (4kB)
+ * HS/GP : Public, Secured
+ * if padconfaccdisable=1	2	0x4A32_7000 - 0x4A32_73FF (1kB)
+ * HS/EMU : Secured
+ * GP : Public			3	0x4A32_8000 - 0x4A32_87FF (2kB)
+ * HS/GP :
+ * Secure Priviledge,
+ * write once.			4	0x4A32_9000 - 0x4A32_93FF (1kB)
+ * ---------------------------------------------------------------------
+ * The SAR RAM save regiter layout is fixed since restore is done by hardware.
+ */
+
 /*
  * SAR BANK offsets from base address OMAP44XX_SAR_RAM_BASE
  */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 8d7de4f..43cacef 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -124,4 +124,12 @@ static inline int omap4_twl_init(void)
 }
 #endif
 
+#ifdef CONFIG_PM
+extern int omap_sar_save(void);
+#else
+static inline void omap_sar_save(void)
+{
+}
+#endif
+
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index c0d478e..8e83e16 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -22,6 +22,9 @@
 #define L4_PER_44XX_BASE		0x48000000
 #define L4_EMU_44XX_BASE		0x54000000
 #define L3_44XX_BASE			0x44000000
+#define L3_44XX_BASE_CLK1		L3_44XX_BASE
+#define L3_44XX_BASE_CLK2		0x44800000
+#define L3_44XX_BASE_CLK3		0x45000000
 #define OMAP44XX_EMIF1_BASE		0x4c000000
 #define OMAP44XX_EMIF2_BASE		0x4d000000
 #define OMAP44XX_DMM_BASE		0x4e000000
@@ -46,6 +49,7 @@
 #define OMAP44XX_MCPDM_BASE		0x40132000
 #define OMAP44XX_MCPDM_L3_BASE		0x49032000
 #define OMAP44XX_SAR_RAM_BASE		0x4a326000
+#define OMAP44XX_SAR_ROM_BASE		0x4a05e000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
@@ -58,5 +62,7 @@
 #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
 #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
 
+#define OMAP44XX_C2C_BASE		0x5c000000
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.4.1

