From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/19] ARM: OMAP4: Auto generate SAR layout contents
Date: Fri, 20 Apr 2012 12:33:39 +0300
Message-ID: <1334914432-26456-7-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37971 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2DTJeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 05:34:36 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

SAR layout contents are now generated automatically based on SAR ROM
contents during boot.

u32 offset	description
----------	-------------------------
0		pointer to next entry
1		size of DMA transfer in bytes
2		SAR RAM address for save / restore
3		IO address for save / restore

sar_layout_generate() parses this info and stores the resulting data to
a list of sar_ram_entry structs, which in turn will be used by sar_save.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-sar.c |  290 +++++++++++++++++++++++++++-------------
 1 files changed, 194 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-sar.c b/arch/arm/mach-omap2/omap-sar.c
index 74e0207..da4696a 100644
--- a/arch/arm/mach-omap2/omap-sar.c
+++ b/arch/arm/mach-omap2/omap-sar.c
@@ -2,7 +2,8 @@
  * OMAP4 Save Restore source file
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
- * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Tero Kristo <t-kristo@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/slab.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -25,35 +27,18 @@
 #include "cminst44xx.h"
 
 static void __iomem *sar_ram_base;
-static void __iomem *omap4_sar_modules[MAX_SAR_MODULES];
 static struct powerdomain *l3init_pwrdm;
 	static struct clockdomain *l3init_clkdm;
 static struct clk *usb_host_ck, *usb_tll_ck;
 
-/*
- * SAR_RAM1 register layout consist of EMIF1, EMIF2, CM1, CM2,
- * CONTROL_CORE efuse, DMM and USB TLL registers.
- * The layout is arranged is a two dimentional array like
- * below,
- * const u32 sar_ramX_layout[nb_regs_sets][4] = {
- *	{module_index, reg_offset, size, sar_ram_offset},
- * }
- */
-static const u32 omap443x_sar_ram1_layout[][4] = {
-};
-
-/*
- * SAR_RAM2 register layout consist of SYSCTRL_PADCONF_CORE regsiters
- */
-static const u32 omap443x_sar_ram2_layout[][4] = {
+struct sar_ram_entry {
+	void __iomem *io_base;
+	u32 offset;
+	u32 size;
+	u32 ram_addr;
 };
 
-/*
- * SAR_RAM3 and  SAR_RAM4 layout is not listed since moslty it's handle by
- * secure software.
- */
-static const u32 omap443x_sar_ram3_layout[][4] = {
-};
+static struct sar_ram_entry *sar_ram_layout[3];
 
 /*
  * omap_sar_save :
@@ -63,25 +48,20 @@ static const u32 omap443x_sar_ram3_layout[][4] = {
  * @sar_bank_offset - where to backup
  * @sar_layout - constant table containing the backup info
  */
-static void sar_save(u32 nb_regs, u32 sar_bank, const u32 sar_layout_table[][4])
+static void sar_save(struct sar_ram_entry *entry)
 {
-	u32 reg_val, size, i, j;
+	u32 reg_val, size, i;
 	void __iomem *reg_read_addr, *sar_wr_addr;
 
-	for (i = 0; i < nb_regs; i++) {
-		if (omap4_sar_modules[(sar_layout_table[i][MODULE_ADDR_IDX])]) {
-			size = sar_layout_table[i][MODULE_NB_REGS_IDX];
-			reg_read_addr =
-			    omap4_sar_modules[sar_layout_table[i]
-					      [MODULE_ADDR_IDX]]
-			    + sar_layout_table[i][MODULE_OFFSET_IDX];
-			sar_wr_addr = sar_ram_base + sar_bank +
-			    sar_layout_table[i][SAR_RAM_OFFSET_IDX];
-			for (j = 0; j < size; j++) {
-				reg_val = __raw_readl(reg_read_addr + j * 4);
-				__raw_writel(reg_val, sar_wr_addr + j * 4);
-			}
+	while (entry->size) {
+		size = entry->size;
+		reg_read_addr = entry->io_base + entry->offset;
+		sar_wr_addr = sar_ram_base + entry->ram_addr;
+		for (i = 0; i < size; i++) {
+			reg_val = __raw_readl(reg_read_addr + i * 4);
+			__raw_writel(reg_val, sar_wr_addr + i * 4);
 		}
+		entry++;
 	}
 }
 
@@ -100,8 +80,7 @@ static void save_sar_bank3(void)
 	l4_secure_clkdm = clkdm_lookup("l4_secure_clkdm");
 	clkdm_wakeup(l4_secure_clkdm);
 
-	sar_save(ARRAY_SIZE(omap443x_sar_ram3_layout), SAR_BANK3_OFFSET,
-		 omap443x_sar_ram3_layout);
+	sar_save(sar_ram_layout[2]);
 
 	clkdm_allow_idle(l4_secure_clkdm);
 }
@@ -116,13 +95,13 @@ static int omap4_sar_not_accessible(void)
 	 * registers, otherwise this will trigger an exception.
 	 */
 	usbhost_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
-						   OMAP4430_CM2_L3INIT_INST,
-						   OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET)
+				OMAP4430_CM2_L3INIT_INST,
+				OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET)
 	    & (OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK);
 
 	usbtll_state = omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
-						  OMAP4430_CM2_L3INIT_INST,
-						  OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET)
+				OMAP4430_CM2_L3INIT_INST,
+				OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET)
 	    & OMAP4430_IDLEST_MASK;
 
 	if ((usbhost_state == (OMAP4430_STBYST_MASK | OMAP4430_IDLEST_MASK)) &&
@@ -133,12 +112,12 @@ static int omap4_sar_not_accessible(void)
 }
 
  /*
-  * omap4_sar_save -
+  * omap_sar_save -
   * Save the context to SAR_RAM1 and SAR_RAM2 as per
   * omap4xxx_sar_ram1_layout and omap4xxx_sar_ram2_layout for the device OFF
   * mode
   */
-int omap4_sar_save(void)
+int omap_sar_save(void)
 {
 	/*
 	 * Not supported on ES1.0 silicon
@@ -163,8 +142,7 @@ int omap4_sar_save(void)
 	clk_enable(usb_tll_ck);
 
 	/* Save SAR BANK1 */
-	sar_save(ARRAY_SIZE(omap443x_sar_ram1_layout), SAR_BANK1_OFFSET,
-		 omap443x_sar_ram1_layout);
+	sar_save(sar_ram_layout[0]);
 
 	clk_disable(usb_host_ck);
 	clk_disable(usb_tll_ck);
@@ -172,8 +150,7 @@ int omap4_sar_save(void)
 	clkdm_allow_idle(l3init_clkdm);
 
 	/* Save SAR BANK2 */
-	sar_save(ARRAY_SIZE(omap443x_sar_ram2_layout), SAR_BANK2_OFFSET,
-		 omap443x_sar_ram2_layout);
+	sar_save(sar_ram_layout[1]);
 
 	return 0;
 }
@@ -194,13 +171,16 @@ int omap4_sar_save(void)
  *		sequencing, the software must overwrite data read from
  *		the following registers implied in phase2a and phase 2b
  */
-void omap4_sar_overwrite(void)
+void omap_sar_overwrite(void)
 {
 	u32 val = 0;
-	u32 offset = 0;
+	u32 usb_offset = 0x2ec;
+	u32 usb_offset2 = 0x91c;
 
-	if (cpu_is_omap446x())
-		offset = 0x04;
+	if (cpu_is_omap446x()) {
+		usb_offset = 0x2f4;
+		usb_offset2 = 0x920;
+	}
 
 	/* Overwriting Phase1 data to be restored */
 	/* CM2 MEMIF_CLKTRCTRL = SW_WKUP, before FREQ UPDATE */
@@ -215,7 +195,7 @@ void omap4_sar_overwrite(void)
 	/* CM1 CM_SHADOW_FREQ_CONFIG1, Enable FREQ UPDATE */
 	val = __raw_readl(OMAP4430_CM_SHADOW_FREQ_CONFIG1);
 	val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
-	val &= ~OMAP4430_DLL_OVERRIDE_MASK;
+	val &= ~OMAP4430_DLL_OVERRIDE_2_2_MASK;
 	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + 0x104);
 	/* CM2 MEMIF_CLKTRCTRL = HW_AUTO, after FREQ UPDATE */
 	__raw_writel(0x3, sar_ram_base + SAR_BANK1_OFFSET + 0x124);
@@ -223,29 +203,29 @@ void omap4_sar_overwrite(void)
 	/* Overwriting Phase2a data to be restored */
 	/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 1, MODULEMODE = 2 */
 	__raw_writel(0x00000012,
-		     sar_ram_base + SAR_BANK1_OFFSET + 0x2ec + offset);
+		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset);
 	/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 1, MODULEMODE = 1 */
 	__raw_writel(0x00000011,
-		     sar_ram_base + SAR_BANK1_OFFSET + 0x2f0 + offset);
+		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset + 4);
 	/* CM2 CM_SDMA_STATICDEP : Enable static depedency for SAR modules */
 	__raw_writel(0x000090e8,
-		     sar_ram_base + SAR_BANK1_OFFSET + 0x2f4 + offset);
+		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset + 8);
 
 	/* Overwriting Phase2b data to be restored */
 	/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
 	val = __raw_readl(OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL);
 	val &= (OMAP4430_CLKSEL_UTMI_P1_MASK | OMAP4430_CLKSEL_UTMI_P2_MASK);
-	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + 0x91c + offset);
+	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + usb_offset2);
 	/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
 	__raw_writel(0x0000000,
-		     sar_ram_base + SAR_BANK1_OFFSET + 0x920 + offset);
+		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 4);
 	/* CM2 CM_SDMA_STATICDEP : Clear the static depedency */
 	__raw_writel(0x00000040,
-		     sar_ram_base + SAR_BANK1_OFFSET + 0x924 + offset);
+		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 8);
 
 	/* readback to ensure data reaches to SAR RAM */
 	barrier();
-	val = __raw_readl(sar_ram_base + SAR_BANK1_OFFSET + 0x924 + offset);
+	val = __raw_readl(sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 8);
 }
 
 void __iomem *omap4_get_sar_ram_base(void)
@@ -253,6 +233,152 @@ void __iomem *omap4_get_sar_ram_base(void)
 	return sar_ram_base;
 }
 
+static const u32 sar_rom_phases[] = {
+	0, 0x30, 0x60
+};
+
+struct sar_module {
+	void __iomem *io_base;
+	u32 base;
+	u32 size;
+	bool invalid;
+};
+
+static struct sar_module *sar_modules;
+
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
+			BUG_ON(!mod->io_base);
+		}
+		mod++;
+	}
+}
+
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
+	/* Allocate temporary memory for sar ram layout */
+	sarram = kmalloc(SAR_BANK4_OFFSET, GFP_KERNEL);
+	for (bank = 0; bank < 3; bank++)
+		entry[bank] = sarram + SAR_BANK2_OFFSET * bank;
+
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
+				bank = ram_addr / SAR_BANK2_OFFSET;
+				if (!set_sar_io_addr(entry[bank], io_addr)) {
+					entry[bank]->size = size;
+					entry[bank]->ram_addr = ram_addr;
+					entry[bank]++;
+				}
+			}
+
+			if (next < rombase || next > romend)
+				break;
+
+			offset = next - rombase;
+		}
+	}
+
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
 /*
  * SAR RAM used to save and restore the HW
  * context in low power modes
@@ -273,39 +399,11 @@ static int __init omap4_sar_ram_init(void)
 	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
 	BUG_ON(!sar_ram_base);
 
-	/*
-	 * All these are static mappings so ioremap() will
-	 * just return with mapped VA
-	 */
-	omap4_sar_modules[EMIF1_INDEX] = ioremap(OMAP44XX_EMIF1_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[EMIF1_INDEX]);
-	omap4_sar_modules[EMIF2_INDEX] = ioremap(OMAP44XX_EMIF2_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[EMIF2_INDEX]);
-	omap4_sar_modules[DMM_INDEX] = ioremap(OMAP44XX_DMM_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[DMM_INDEX]);
-	omap4_sar_modules[CM1_INDEX] = ioremap(OMAP4430_CM1_BASE, SZ_8K);
-	BUG_ON(!omap4_sar_modules[CM1_INDEX]);
-	omap4_sar_modules[CM2_INDEX] = ioremap(OMAP4430_CM2_BASE, SZ_8K);
-	BUG_ON(!omap4_sar_modules[CM2_INDEX]);
-	omap4_sar_modules[C2C_INDEX] = ioremap(OMAP44XX_C2C_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[C2C_INDEX]);
-	omap4_sar_modules[CTRL_MODULE_PAD_CORE_INDEX] =
-	    ioremap(OMAP443X_CTRL_BASE, SZ_4K);
-	BUG_ON(!omap4_sar_modules[CTRL_MODULE_PAD_CORE_INDEX]);
-	omap4_sar_modules[L3_CLK1_INDEX] = ioremap(L3_44XX_BASE_CLK1, SZ_1M);
-	BUG_ON(!omap4_sar_modules[L3_CLK1_INDEX]);
-	omap4_sar_modules[L3_CLK2_INDEX] = ioremap(L3_44XX_BASE_CLK2, SZ_1M);
-	BUG_ON(!omap4_sar_modules[L3_CLK2_INDEX]);
-	omap4_sar_modules[L3_CLK3_INDEX] = ioremap(L3_44XX_BASE_CLK3, SZ_1M);
-	BUG_ON(!omap4_sar_modules[L3_CLK3_INDEX]);
-	omap4_sar_modules[USBTLL_INDEX] = ioremap(OMAP44XX_USBTLL_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[USBTLL_INDEX]);
-	omap4_sar_modules[UHH_INDEX] = ioremap(OMAP44XX_UHH_CONFIG_BASE, SZ_1M);
-	BUG_ON(!omap4_sar_modules[UHH_INDEX]);
-	omap4_sar_modules[L4CORE_INDEX] = ioremap(L4_44XX_PHYS, SZ_4M);
-	BUG_ON(!omap4_sar_modules[L4CORE_INDEX]);
-	omap4_sar_modules[L4PER_INDEX] = ioremap(L4_PER_44XX_PHYS, SZ_4M);
-	BUG_ON(!omap4_sar_modules[L4PER_INDEX]);
+	sar_modules = omap44xx_sar_modules;
+
+	sar_ioremap_modules();
+
+	sar_layout_generate();
 
 	/*
 	 * SAR BANK3 contains all firewall settings and it's saved through
-- 
1.7.4.1

