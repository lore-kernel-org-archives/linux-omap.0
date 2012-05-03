From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Thu, 3 May 2012 12:56:11 +0530
Message-ID: <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719Ab2ECH0m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:42 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

OMAP5430 is Texas Instrument's SOC based on ARM Cortex-A15 SMP
architecture. It's a dual core SOC with GIC used for interrupt
handling and with an integrated L2 cache controller.

OMAP5432 is another variant of OMAP5430, with a
memory controller supporting DDR3 and SATA.

Patch includes:
 - The machine specific headers and sources updates.
 - Platform header updates.
 - Minimum initialisation support for serial.
 - IO table init

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                   |   26 ++++++++++----
 arch/arm/mach-omap2/clock.c                    |    3 +-
 arch/arm/mach-omap2/cminst44xx.h               |    2 +-
 arch/arm/mach-omap2/common.c                   |   24 +++++++++++++
 arch/arm/mach-omap2/common.h                   |   11 ++++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |    8 ++--
 arch/arm/mach-omap2/io.c                       |   44 ++++++++++++++++++++++++
 arch/arm/mach-omap2/iomap.h                    |   27 ++++++++++++++
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h             |    5 ++-
 arch/arm/plat-omap/Makefile                    |    4 +--
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    4 ++-
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/multi.h        |    9 +++++
 arch/arm/plat-omap/include/plat/omap54xx.h     |   32 +++++++++++++++++
 arch/arm/plat-omap/include/plat/serial.h       |   10 +++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    6 +++
 arch/arm/plat-omap/sram.c                      |   11 +++++-
 19 files changed, 208 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 669e2b1..fbb6b3d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP5) += prm44xx.o $(hwmod-common) $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -27,8 +28,10 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
-obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
+omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
+					   sleep44xx.o		
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
+obj-$(CONFIG_ARCH_OMAP5)                += $(omap-4-5-common)
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -68,6 +71,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP5)		+= omap-mpuss-lowpower.o
 obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
@@ -87,9 +91,11 @@ obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
+omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
+					   prcm_mpu44xx.o prminst44xx.o \
+					   vc44xx_data.o vp44xx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common) prm44xx.o
+obj-$(CONFIG_ARCH_OMAP5)                += $(omap-prcm-4-5-common)
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -99,6 +105,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP5)		+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -113,6 +120,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP5)                += $(powerdomain-common) powerdomain44xx.o
 
 # PRCM clockdomain control
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o
@@ -124,9 +132,11 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
+omap-clock-4-5-common			= clockdomain.o \
+					  clockdomain44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-clock-4-5-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP5)		+= $(omap-clock-4-5-common)
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -144,6 +154,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_ARCH_OMAP5)		+= $(clock-common)
+obj-$(CONFIG_ARCH_OMAP5)		+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d9f4931..c589bb8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -400,7 +400,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 /* OMAP3/4 non-CORE DPLL clkops */
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
+				defined(CONFIG_ARCH_OMAP5)
 
 const struct clkops clkops_omap3_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index a018a73..da67e08 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -19,7 +19,7 @@ extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 
-# ifdef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
 extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
 					 u16 clkctrl_offs);
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8a6953a..a0e74b9 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -182,3 +182,27 @@ void __init omap4_map_io(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_OMAP5)
+static struct omap_globals omap5_globals = {
+	.class	= OMAP54XX_CLASS,
+	.tap	= OMAP2_L4_IO_ADDRESS(OMAP543x_SCM_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP543x_SCM_BASE),
+	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP543x_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
+	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
+	.prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),
+};
+
+void __init omap2_set_globals_543x(void)
+{
+	omap2_set_globals_tap(&omap5_globals);
+	omap2_set_globals_control(&omap5_globals);
+	omap2_set_globals_prcm(&omap5_globals);
+}
+
+void __init omap5_map_io(void)
+{
+	omap5_map_common_io();
+}
+#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 0672fc5..797dda7 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -78,6 +78,14 @@ static inline void omap44xx_map_common_io(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP5
+extern void omap5_map_common_io(void);
+#else
+static inline void omap5_map_common_io(void)
+{
+}
+#endif
+
 extern void omap2_init_common_infrastructure(void);
 
 extern struct sys_timer omap2_timer;
@@ -94,6 +102,7 @@ void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti81xx_init_early(void);
 void omap4430_init_early(void);
+void omap5_init_early(void);
 void omap_prcm_restart(char, const char *);
 
 /*
@@ -118,6 +127,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
+void omap2_set_globals_543x(void);
 void omap2_set_globals_ti81xx(void);
 void omap2_set_globals_am33xx(void);
 
@@ -132,6 +142,7 @@ void omap243x_map_io(void);
 void omap3_map_io(void);
 void am33xx_map_io(void);
 void omap4_map_io(void);
+void omap5_map_io(void);
 void ti81xx_map_io(void);
 void omap_barriers_init(void);
 
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index cdfc2a1..6ef5898 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -60,12 +60,12 @@ omap_uart_lsr:	.word	0
 		beq	23f			@ configure OMAP2UART3
 		cmp	\rp, #OMAP3UART3	@ only on 34xx
 		beq	33f			@ configure OMAP3UART3
-		cmp	\rp, #OMAP4UART3	@ only on 44xx
-		beq	43f			@ configure OMAP4UART3
+		cmp	\rp, #OMAP4UART3	@ only on 44xx/54xx
+		beq	43f			@ configure OMAP4/5UART3
 		cmp	\rp, #OMAP3UART4	@ only on 36xx
 		beq	34f			@ configure OMAP3UART4
-		cmp	\rp, #OMAP4UART4	@ only on 44xx
-		beq	44f			@ configure OMAP4UART4
+		cmp	\rp, #OMAP4UART4	@ only on 44xx/54xx
+		beq	44f			@ configure OMAP4/5UART4
 		cmp	\rp, #TI81XXUART1	@ ti81Xx UART offsets different
 		beq	81f			@ configure UART1
 		cmp	\rp, #TI81XXUART2	@ ti81Xx UART offsets different
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 595a5dd..b3f0c3c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -232,6 +232,35 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
+#ifdef	CONFIG_ARCH_OMAP5
+static struct map_desc omap54xx_io_desc[] __initdata = {
+	{
+		.virtual	= L3_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L3_54XX_PHYS),
+		.length		= L3_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_54XX_PHYS),
+		.length		= L4_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_WK_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_WK_54XX_PHYS),
+		.length		= L4_WK_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_PER_54XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_PER_54XX_PHYS),
+		.length		= L4_PER_54XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+#endif
+
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap242x_map_common_io(void)
 {
@@ -277,6 +306,12 @@ void __init omap44xx_map_common_io(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP5
+void __init omap5_map_common_io(void)
+{
+	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
+}
+#endif
 /*
  * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
  *
@@ -454,6 +489,15 @@ void __init omap4430_init_early(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP5
+void __init omap5_init_early(void)
+{
+	omap2_set_globals_543x();
+	omap5xxx_check_revision();
+	omap_common_init_early();
+}
+#endif
+
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
index 80b8892..cce2b65 100644
--- a/arch/arm/mach-omap2/iomap.h
+++ b/arch/arm/mach-omap2/iomap.h
@@ -1,6 +1,14 @@
 /*
  * IO mappings for OMAP2+
  *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Copyright (C) 2009-2012 Texas Instruments
+ * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -166,4 +174,23 @@
 						/* 0x49000000 --> 0xfb000000 */
 #define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
 #define L4_ABE_44XX_SIZE	SZ_1M
+/*
+ * ----------------------------------------------------------------------------
+ * Omap5 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+#define L3_54XX_PHYS		L3_54XX_BASE	/* 0x44000000 --> 0xf8000000 */
+#define L3_54XX_VIRT		(L3_54XX_PHYS + OMAP4_L3_IO_OFFSET)
+#define L3_54XX_SIZE		SZ_1M
+
+#define L4_54XX_PHYS		L4_54XX_BASE	/* 0x4a000000 --> 0xfc000000 */
+#define L4_54XX_VIRT		(L4_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_54XX_SIZE		SZ_4M
+
+#define L4_WK_54XX_PHYS		L4_WK_54XX_BASE	/* 0x4ae00000 --> 0xfce00000 */
+#define L4_WK_54XX_VIRT		(L4_WK_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_WK_54XX_SIZE		SZ_2M
 
+#define L4_PER_54XX_PHYS	L4_PER_54XX_BASE /* 0x48000000 --> 0xfa000000 */
+#define L4_PER_54XX_VIRT	(L4_PER_54XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_PER_54XX_SIZE	SZ_4M
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 480f40a..904b494 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -159,7 +159,7 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 	if (omap2_globals->prcm_mpu)
 		prcm_mpu_base = omap2_globals->prcm_mpu;
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
 		omap_prm_base_init();
 		omap_cm_base_init();
 	}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..85fa808 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -232,8 +232,9 @@
  * Stub omap2xxx/omap3xxx functions so that common files
  * continue to build when custom builds are used
  */
-#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
-					defined(CONFIG_ARCH_OMAP3))
+#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
+		!(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
+
 static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
 {
 	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index c0fe275..e6d7287 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,9 +13,7 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 # omap_device support (OMAP2+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b299b8d..d939599 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -40,6 +40,7 @@ struct omap_clk {
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
+#define CK_54XX		(1 << 14)
 #define CK_1710		(1 << 15)	/* 1710 extra for rate selection */
 
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..41858f4 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -61,6 +61,7 @@ struct clkops {
 #define RATE_IN_4460		(1 << 7)
 #define RATE_IN_AM33XX		(1 << 8)
 #define RATE_IN_TI814X		(1 << 9)
+#define RATE_IN_54XX		(1 << 10)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
@@ -156,7 +157,8 @@ struct dpll_data {
 	u8			min_divider;
 	u16			max_divider;
 	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) \
+		|| defined(CONFIG_ARCH_OMAP5)
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index e897978..ddbde38 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -288,5 +288,6 @@
 #include <plat/omap44xx.h>
 #include <plat/ti81xx.h>
 #include <plat/am33xx.h>
+#include <plat/omap54xx.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index 999ffba..9117af9 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -99,4 +99,13 @@
 # endif
 #endif
 
+#ifdef CONFIG_ARCH_OMAP5
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap5
+# endif
+#endif
+
 #endif	/* __PLAT_OMAP_MULTI_H */
diff --git a/arch/arm/plat-omap/include/plat/omap54xx.h b/arch/arm/plat-omap/include/plat/omap54xx.h
new file mode 100644
index 0000000..823873f
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/omap54xx.h
@@ -0,0 +1,32 @@
+/*:
+ * Address mappings and base address for OMAP5 interconnects
+ * and peripherals.
+ *
+ * Copyright (C) 2012 Texas Instruments
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	Sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARCH_OMAP54XX_H
+#define __ASM_ARCH_OMAP54XX_H
+
+/*
+ * Please place only base defines here and put the rest in device
+ * specific headers.
+ */
+#define L4_54XX_BASE			0x4a000000
+#define L4_WK_54XX_BASE			0x4ae00000
+#define L4_PER_54XX_BASE		0x48000000
+#define L3_54XX_BASE			0x44000000
+#define OMAP54XX_32KSYNCT_BASE		0x4ae04000
+#define OMAP54XX_CM_CORE_AON_BASE	0x4a004000
+#define OMAP54XX_CM_CORE_BASE		0x4a008000
+#define OMAP54XX_PRM_BASE		0x4ae06000
+#define OMAP54XX_PRCM_MPU_BASE		0x48243000
+#define OMAP543x_SCM_BASE		0x4a002000
+#define OMAP543x_CTRL_BASE		0x4a002800
+
+#endif /* __ASM_ARCH_OMAP555554XX_H */
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index b073e5f..c317f22 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -60,6 +60,14 @@
 /* AM3505/3517 UART4 */
 #define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
 
+/* OMAP5 serial ports */
+#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
+#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
+#define OMAP5_UART5_BASE	0x48066000
+#define OMAP5_UART6_BASE	0x48068000
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
@@ -93,6 +101,8 @@
 #define TI81XXUART1		81
 #define TI81XXUART2		82
 #define TI81XXUART3		83
+#define OMAP5UART3		OMAP4UART3
+#define OMAP5UART4		OMAP4UART4
 #define ZOOM_UART		95		/* Only on zoom2/3 */
 
 /* This is only used by 8250.c for omap1510 */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index cc3f11b..42d6f72 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -95,6 +95,9 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		OMAP4UART##p)
 
+#define DEBUG_LL_OMAP5(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP5_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP5UART##p)
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
 	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
@@ -173,6 +176,9 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
 		DEBUG_LL_OMAP4(3, omap4_panda);
 
+		/* omap5 based boards using UART3 */
+		DEBUG_LL_OMAP5(3, omap5_sevm);
+
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
 		DEBUG_LL_ZOOM(omap_zoom3);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f9a8c53..a7b6df2 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -6,8 +6,8 @@
  * Copyright (C) 2005 Nokia Corporation
  * Written by Tony Lindgren <tony@atomide.com>
  *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Copyright (C) 2009-2012 Texas Instruments
+ * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -44,6 +44,7 @@
 #else
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #endif
+#define OMAP5_SRAM_PA		0x40300000
 
 #if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -118,6 +119,9 @@ static void __init omap_detect_sram(void)
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PUB_PA;
 				omap_sram_size = 0xa000; /* 40K */
+			} else if (cpu_is_omap54xx()) {
+				omap_sram_start = OMAP5_SRAM_PA;
+				omap_sram_size = SZ_128K; /* 128KB */
 			} else {
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
 				omap_sram_size = 0x800; /* 2K */
@@ -132,6 +136,9 @@ static void __init omap_detect_sram(void)
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PA;
 				omap_sram_size = 0xe000; /* 56K */
+			} else if (cpu_is_omap54xx()) {
+				omap_sram_start = OMAP5_SRAM_PA;
+				omap_sram_size = SZ_128K; /* 128KB */
 			} else {
 				omap_sram_start = OMAP2_SRAM_PA;
 				if (cpu_is_omap242x())
-- 
1.7.1

