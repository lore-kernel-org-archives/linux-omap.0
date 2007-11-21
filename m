From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH RESEND 4/4] Runtime constants: use runtime-computed system
	control module base
Date: Tue, 20 Nov 2007 17:16:24 -0700
Message-ID: <20071121002108.310783171@pwsan.com>
References: <20071121001620.571082090@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=mb-convert-omap2-ctrl-base.patch
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
List-Id: linux-omap@vger.kernel.org

Create a global variable, omap2_ctrl_base, that is initialized with
the appropriate control module base address at runtime during
architecture initialization.  Convert users of the preprocessor define
OMAP2_CTRL_BASE to use the runtime-computed address, and get rid of
OMAP2_CTRL_BASE.  Create ctrl_{read,write}_reg() to handle register
access to these functions - these live in a newly-created file,
arch/arm/mach-omap2/control.h.  Add the control register defines that
we currently use into a newly-created file,
include/asm-arm/arch-omap/control.h, where they can be imported into
assembly-language code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/board-h4.c       |    3 +
 arch/arm/mach-omap2/clock34xx.h      |   30 +++++----------
 arch/arm/mach-omap2/control.h        |   41 +++++++++++++++++++++
 arch/arm/mach-omap2/id.c             |    4 +-
 arch/arm/mach-omap2/pm.c             |    6 +--
 arch/arm/plat-omap/common.c          |    5 ++
 arch/arm/plat-omap/devices.c         |   12 ++++--
 arch/arm/plat-omap/mux.c             |   13 ++++--
 arch/arm/plat-omap/sram.c            |    6 ++-
 arch/arm/plat-omap/usb.c             |   66 +++++++++++++++++++++++++++--------
 include/asm-arm/arch-omap/control.h  |   58 ++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/omap24xx.h |   12 ------
 include/asm-arm/arch-omap/omap34xx.h |   12 ------
 include/asm-arm/arch-omap/usb.h      |    5 --
 14 files changed, 198 insertions(+), 75 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/control.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/control.h	2007-11-20 17:12:50.000000000 -0700
@@ -0,0 +1,41 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
+#define __ARCH_ARM_MACH_OMAP2_CONTROL_H
+
+/*
+ * OMAP2/3 System Control Module register definitions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <asm/arch/control.h>
+
+extern unsigned long omap2_ctrl_base;
+
+#define OMAP_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_ctrl_base + reg)
+
+
+/* Control global register get/set */
+
+static void __attribute__((unused)) ctrl_write_reg(u32 val, u16 reg)
+{
+	pr_debug("ctrl_write_reg: writing 0x%0x to 0x%0x\n", val,
+		 (u32)OMAP_CTRL_REGADDR(reg));
+
+	__raw_writel(val, OMAP_CTRL_REGADDR(reg));
+}
+
+static u32 __attribute__((unused)) ctrl_read_reg(u16 reg)
+{
+	return __raw_readl(OMAP_CTRL_REGADDR(reg));
+}
+
+#endif  /* __ARCH_ARM_MACH_OMAP2_CONTROL_H */
Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-20 17:10:22.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-20 17:12:50.000000000 -0700
@@ -29,6 +29,7 @@
 # include "../mach-omap2/prm.h"
 # include "../mach-omap2/cm.h"
 # include "../mach-omap2/sdrc.h"
+# include "../mach-omap2/control.h"
 #endif
 
 #define OMAP1_SRAM_PA		0x20000000
@@ -47,7 +48,6 @@
 #define VA_REQINFOPERM0		IO_ADDRESS(0x68005048)
 #define VA_READPERM0		IO_ADDRESS(0x68005050)
 #define VA_WRITEPERM0		IO_ADDRESS(0x68005058)
-#define VA_CONTROL_STAT		IO_ADDRESS(0x480002F8)
 #define GP_DEVICE		0x300
 #define TYPE_MASK		0x700
 
@@ -92,8 +92,10 @@
 {
 	int type = 0;
 
+#if defined(CONFIG_ARCH_OMAP242X)
 	if (cpu_is_omap242x())
-		type = __raw_readl(VA_CONTROL_STAT) & TYPE_MASK;
+		type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
+#endif
 
 	if (type == GP_DEVICE) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
Index: linux-omap/arch/arm/plat-omap/usb.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/usb.c	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/usb.c	2007-11-20 17:12:50.000000000 -0700
@@ -37,6 +37,8 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/board.h>
 
+#include "../mach-omap2/control.h"
+
 #ifdef CONFIG_ARCH_OMAP1
 
 #define INT_USB_IRQ_GEN		IH2_BASE + 20
@@ -110,12 +112,48 @@
 
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP15XX)
 
+static void omap2_usb_devconf_clear(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r &= ~USBTXWRMODEI(port, mask);
+	ctrl_write_reg(r, CONTROL_DEVCONF0);
+}
+
+static void omap2_usb_devconf_set(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(port, mask);
+	ctrl_write_reg(r, CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_disable_5pinbitll(void)
+{
+	u32 r;
+
+	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r &= ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
+	ctrl_write_reg(r, CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_enable_5pinunitll(void)
+{
+	u32 r;
+
+	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
+	ctrl_write_reg(r, CONTROL_DEVCONF0);
+}
+
 static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 {
 	u32	syscon1 = 0;
 
 	if (cpu_is_omap24xx())
-		CONTROL_DEVCONF_REG &= ~USBT0WRMODEI(USB_BIDIR_TLL);
+		omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
 
 	if (nwires == 0) {
 		if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
@@ -187,19 +225,19 @@
 	case 3:
 		syscon1 = 2;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(0, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(0, USB_BIDIR);
 		break;
 	case 6:
 		syscon1 = 3;
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(J19_24XX_USB0_VP);
 			omap_cfg_reg(K20_24XX_USB0_VM);
-			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_UNIDIR);
+			omap2_usb_devconf_set(0, USB_UNIDIR);
 		} else {
 			omap_cfg_reg(AA9_USB0_VP);
 			omap_cfg_reg(R9_USB0_VM);
@@ -220,7 +258,7 @@
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB1_UNI_R;
 	if (cpu_is_omap24xx())
-		CONTROL_DEVCONF_REG &= ~USBT1WRMODEI(USB_BIDIR_TLL);
+		omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
 
 	if (nwires == 0)
 		return 0;
@@ -261,17 +299,17 @@
 		 * this TLL link is not using DP/DM
 		 */
 		syscon1 = 1;
-		CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR_TLL);
+		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
 		break;
 	case 3:
 		syscon1 = 2;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(1, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(1, USB_BIDIR);
 		break;
 	case 6:
 		if (cpu_is_omap24xx())
@@ -295,8 +333,7 @@
 	u32	syscon1 = 0;
 
 	if (cpu_is_omap24xx()) {
-		CONTROL_DEVCONF_REG &= ~(USBT2WRMODEI(USB_BIDIR_TLL)
-					| USBT2TLL5PI);
+		omap2_usb2_disable_5pinbitll();
 		alt_pingroup = 0;
 	}
 
@@ -343,17 +380,17 @@
 		 * this TLL link is not using DP/DM
 		 */
 		syscon1 = 1;
-		CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR_TLL);
+		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
 		break;
 	case 3:
 		syscon1 = 2;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(2, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
 		if (cpu_is_omap24xx())
-			CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR);
+			omap2_usb_devconf_set(2, USB_BIDIR);
 		break;
 	case 5:
 		if (!cpu_is_omap24xx())
@@ -364,8 +401,7 @@
 		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
 		 */
 		syscon1 = 3;
-		CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_UNIDIR_TLL)
-					| USBT2TLL5PI;
+		omap2_usb2_enable_5pinunitll();
 		break;
 	case 6:
 		if (cpu_is_omap24xx())
Index: linux-omap/include/asm-arm/arch-omap/control.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/include/asm-arm/arch-omap/control.h	2007-11-20 17:12:50.000000000 -0700
@@ -0,0 +1,58 @@
+#ifndef __ASM_ARCH_CONTROL_H
+#define __ASM_ARCH_CONTROL_H
+
+/*
+ * include/asm-arm/arch-omap/control.h
+ *
+ * OMAP2/3 System Control Module definitions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#include <asm/arch/io.h>
+
+#define OMAP242X_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + reg)
+#define OMAP243X_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + reg)
+#define OMAP343X_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + reg)
+
+/* Control submodule offsets */
+
+#define CONTROL_INTERFACE		0x000
+#define CONTROL_PADCONFS		0x030
+#define CONTROL_GENERAL			0x270
+#define CONTROL_MEM_WKUP		0x600
+#define CONTROL_PADCONFS_WKUP		0xa00
+#define CONTROL_GENERAL_WKUP		0xa60
+
+/* Control register offsets - read/write with ctrl_{read,write}_reg() */
+
+#define CONTROL_SYSCONFIG		(CONTROL_INTERFACE + 0x10)
+
+#define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
+#define CONTROL_DEVCONF1		(CONTROL_GENERAL + 0x68) /* > 242x */
+#define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
+
+
+/*
+ * Control module register bit defines - these should eventually go into
+ * their own regbits file
+ */
+/* CONTROL_DEVCONF0 bits */
+#define OMAP2_MCBSP2_CLKS_MASK		    (1 << 6)
+#define OMAP2_MCBSP1_CLKS_MASK		    (1 << 2)
+
+/* CONTROL_DEVCONF1 bits */
+#define OMAP2_MCBSP5_CLKS_MASK		    (1 << 4)
+#define OMAP2_MCBSP4_CLKS_MASK		    (1 << 2)
+#define OMAP2_MCBSP3_CLKS_MASK		    (1 << 0)
+
+
+#endif /* __ASM_ARCH_CONTROL_H */
+
Index: linux-omap/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/devices.c	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/devices.c	2007-11-20 17:12:50.000000000 -0700
@@ -25,6 +25,10 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
 
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+# include "../mach-omap2/control.h"
+#endif
+
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
 #include "../plat-omap/dsp/dsp_common.h"
@@ -269,17 +273,19 @@
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
+#if defined(CONFIG_ARCH_OMAP2420)
 		if (mmc->internal_clock) {
 			/*
 			 * Use internal loop-back in MMC/SDIO
 			 * Module Input Clock selection
 			 */
 			if (cpu_is_omap24xx()) {
-				u32 v = omap_readl(OMAP2_CONTROL_DEVCONF);
-				v |= (1 << 24);
-				omap_writel(v, OMAP2_CONTROL_DEVCONF);
+				u32 v = ctrl_read_reg(CONTROL_DEVCONF0);
+				v |= (1 << 24); /* not used in 243x */
+				ctrl_write_reg(v, CONTROL_DEVCONF0);
 			}
 		}
+#endif
 		mmc1_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-11-20 17:12:50.000000000 -0700
@@ -15,19 +15,11 @@
 #include "cm_regbits_34xx.h"
 #include "prm.h"
 #include "prm_regbits_34xx.h"
+#include "control.h"
 
 static void omap3_dpll_recalc(struct clk *clk);
 static void omap3_clkoutx2_recalc(struct clk *clk);
 
-/* REVISIT: this stuff should be moved to a scm.h file */
-/* CONTROL_DEVCONF0 bits */
-#define OMAP3430_MCBSP2_CLKS_MASK		    (1 << 6)
-#define OMAP3430_MCBSP1_CLKS_MASK		    (1 << 2)
-/* OMAP34XX_CONTROL_DEVCONF1 bits */
-#define OMAP3430_MCBSP5_CLKS_MASK		    (1 << 4)
-#define OMAP3430_MCBSP4_CLKS_MASK		    (1 << 2)
-#define OMAP3430_MCBSP3_CLKS_MASK		    (1 << 0)
-
 /*
  * DPLL1 supplies clock to the MPU.
  * DPLL2 supplies clock to the IVA2.
@@ -930,8 +922,8 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP3430_MCBSP5_CLKS_MASK,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
@@ -942,8 +934,8 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
-	.clksel_mask	= OMAP3430_MCBSP1_CLKS_MASK,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
@@ -1990,8 +1982,8 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
-	.clksel_mask	= OMAP3430_MCBSP2_CLKS_MASK,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
@@ -2002,8 +1994,8 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP3430_MCBSP3_CLKS_MASK,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
@@ -2014,8 +2006,8 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP3430_MCBSP4_CLKS_MASK,
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
Index: linux-omap/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-h4.c	2007-11-20 17:12:45.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-h4.c	2007-11-20 17:12:50.000000000 -0700
@@ -47,6 +47,7 @@
 
 #include <asm/io.h>
 
+#include "control.h"
 #include <../drivers/media/video/ov9640.h>
 
 #define H4_FLASH_CS	0
@@ -271,7 +272,7 @@
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
-	return (omap_readl(OMAP2_CONTROL_STATUS) & 0xFFF);
+	return (ctrl_read_reg(CONTROL_STATUS) & 0xFFF);
 }
 
 /* FIXME: This function should be moved to some other file, gpmc.c? */
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/pm.c	2007-11-20 17:12:50.000000000 -0700
@@ -51,6 +51,7 @@
 #include "cm.h"
 #include "cm_regbits_24xx.h"
 #include "sdrc.h"
+#include "control.h"
 
 /* These addrs are in assembly language code to be patched at runtime */
 extern void *omap2_ocs_sdrc_power;
@@ -351,8 +352,6 @@
 
 static struct clk *osc_ck, *emul_ck;
 
-#define CONTROL_DEVCONF		__REG32(OMAP2_CTRL_BASE + 0x274)
-
 static int omap2_fclks_active(void)
 {
 	u32 f1, f2;
@@ -415,7 +414,8 @@
 			  MPU_MOD, PM_PWSTCTRL);
 
 	/* Workaround to kill USB */
-	CONTROL_DEVCONF |= 0x00008000;
+	l = ctrl_read_reg(CONTROL_DEVCONF0) | 0x00008000;
+	ctrl_write_reg(l, CONTROL_DEVCONF0);
 
 	omap2_gpio_prepare_for_retention();
 
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:12:48.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:12:50.000000000 -0700
@@ -84,7 +84,6 @@
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP2_CTRL_BASE		OMAP2420_CTRL_BASE
 
 #elif defined(CONFIG_ARCH_OMAP2430)
 
@@ -93,19 +92,8 @@
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
-#elif !defined(CONFIG_ARCH_OMAP34XX)
-/* FIXME: These will go away soon */
-#define OMAP2_CTRL_BASE		L4_24XX_BASE
 #endif
 
-/* Control module */
-#define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
-#define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)
-#define OMAP2_CONTROL_DEVCONF   OMAP2_CONTROL_DEVCONF0
-
-#define OMAP2_CONTROL_STATUS	(OMAP2_CTRL_BASE + 0x2f8)
-
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:12:48.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:12:50.000000000 -0700
@@ -46,7 +46,7 @@
 #define OMAP343X_SDRC_BASE	0x6D000000
 #define OMAP34XX_GPMC_BASE	0x6E000000
 #define OMAP343X_SCM_BASE	0x48002000
-#define OMAP3430_CTRL_BASE	OMAP343X_SCM_BASE
+#define OMAP343X_CTRL_BASE	OMAP343X_SCM_BASE
 
 #define OMAP34XX_IC_BASE	0x48200000
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
@@ -55,20 +55,10 @@
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
-/*
- * REVISIT: OMAP3430 has two CONTROL_DEVCONF registers, CONTROL_DEVCONF0
- * and CONTROL_DEVCONF1.  We should probably split those defines, along
- * with any other System Control Module registers and read/write fns,
- * out to a separate scm.h file, and do this for 24xx also.
- */
 #define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
-#define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
-#define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
-#define OMAP2_CONTROL_STATUS		(OMAP2_CTRL_BASE + 0x2f0)
 
 #endif
 
Index: linux-omap/include/asm-arm/arch-omap/usb.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/usb.h	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/usb.h	2007-11-20 17:12:50.000000000 -0700
@@ -132,14 +132,11 @@
 #	define	CONF_USB_PWRDN_DP_R	(1 << 1)
 
 /* OMAP2 */
-#define	CONTROL_DEVCONF_REG		__REG32(L4_24XX_BASE + 0x0274)
 #	define	USB_UNIDIR			0x0
 #	define	USB_UNIDIR_TLL			0x1
 #	define	USB_BIDIR			0x2
 #	define	USB_BIDIR_TLL			0x3
-#	define	USBT0WRMODEI(x)		((x) << 22)
-#	define	USBT1WRMODEI(x)		((x) << 20)
-#	define	USBT2WRMODEI(x)		((x) << 18)
+#	define	USBTXWRMODEI(port, x)	((x) << (22 - (port * 2)))
 #	define	USBT2TLL5PI		(1 << 17)
 #	define	USB0PUENACTLOI		(1 << 16)
 #	define	USBSTANDBYCTRL		(1 << 15)
Index: linux-omap/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/common.c	2007-11-20 17:12:48.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/common.c	2007-11-20 17:12:50.000000000 -0700
@@ -38,6 +38,8 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
+u32 omap2_ctrl_base; /* until we have a better place to put it */
+
 unsigned char omap_bootloader_tag[512];
 int omap_bootloader_tag_len;
 
@@ -242,6 +244,7 @@
 {
 	omap2_sdrc_base = OMAP2420_SDRC_BASE;
 	omap2_sms_base = OMAP2420_SMS_BASE;
+	omap2_ctrl_base = OMAP2420_CTRL_BASE;
 }
 #endif
 
@@ -250,6 +253,7 @@
 {
 	omap2_sdrc_base = OMAP243X_SDRC_BASE;
 	omap2_sms_base = OMAP243X_SMS_BASE;
+	omap2_ctrl_base = OMAP243X_CTRL_BASE;
 }
 #endif
 
@@ -258,6 +262,7 @@
 {
 	omap2_sdrc_base = OMAP343X_SDRC_BASE;
 	omap2_sms_base = OMAP343X_SMS_BASE;
+	omap2_ctrl_base = OMAP343X_CTRL_BASE;
 }
 #endif
 
Index: linux-omap/arch/arm/plat-omap/mux.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/mux.c	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/mux.c	2007-11-20 17:12:50.000000000 -0700
@@ -30,6 +30,10 @@
 #include <linux/spinlock.h>
 #include <asm/arch/mux.h>
 
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+# include "../mach-omap2/control.h"
+#endif
+
 #ifdef CONFIG_OMAP_MUX
 
 #define OMAP24XX_PULL_ENA	(1 << 3)
@@ -75,6 +79,7 @@
 
 	cfg = (struct pin_config *)&pin_table[index];
 #ifdef CONFIG_ARCH_OMAP24XX
+	/* REVISIT: Convert this code to use ctrl_{read,write}_reg */
 	if (cpu_is_omap24xx()) {
 		u8 reg = 0;
 
@@ -85,7 +90,7 @@
 			reg |= OMAP24XX_PULL_UP;
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
 		{
-			u8 orig = omap_readb(OMAP2_CTRL_BASE + cfg->mux_reg);
+			u8 orig = omap_readb(omap2_ctrl_base + cfg->mux_reg);
 			u8 debug = 0;
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
@@ -93,13 +98,13 @@
 #endif
 			warn = (orig != reg);
 			if (debug || warn)
-				printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
+				printk("MUX: setup %s (0x%08lx): 0x%02x -> 0x%02x\n",
 						cfg->name,
-						OMAP2_CTRL_BASE + cfg->mux_reg,
+						omap2_ctrl_base + cfg->mux_reg,
 						orig, reg);
 		}
 #endif
-		omap_writeb(reg, OMAP2_CTRL_BASE + cfg->mux_reg);
+		omap_writeb(reg, omap2_ctrl_base + cfg->mux_reg);
 
 		return 0;
 	}
Index: linux-omap/arch/arm/mach-omap2/id.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/id.c	2007-11-20 15:59:39.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/id.c	2007-11-20 17:12:50.000000000 -0700
@@ -17,6 +17,8 @@
 
 #include <asm/io.h>
 
+#include "control.h"
+
 #if defined(CONFIG_ARCH_OMAP2420)
 #define TAP_BASE	io_p2v(0x48014000)
 #elif defined(CONFIG_ARCH_OMAP2430)
@@ -160,7 +162,7 @@
 	/* Embedding the ES revision info in type field */
 	system_rev = omap_ids[j].type;
 
-	ctrl_status = omap_readl(OMAP2_CONTROL_STATUS);
+	ctrl_status = ctrl_read_reg(CONTROL_STATUS);
 	system_rev |= (ctrl_status & 0x3f);
 	system_rev |= (ctrl_status & 0x700);
 

-- 
