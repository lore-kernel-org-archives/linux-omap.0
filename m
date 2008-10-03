From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/05] ARM: OMAP2: Add minimal omap3430 support
Date: Fri,  3 Oct 2008 15:09:35 +0300
Message-ID: <1223035779-26306-2-git-send-email-tony@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56843 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYJCMGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 08:06:54 -0400
In-Reply-To: <1223035779-26306-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Karthik Dasu <karthik-dp@ti.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>

Add minimal omap3430 support based on earlier patches from
Syed Mohammed Khasim. Also merge in omap34xx SRAM support
from Karthik Dasu and use consistent naming for sram init
functions.

Also do following changes that make 34xx support usable:

- Rename IRQ_SIR_IRQ to INTCPS_SIR_IRQ and define it locally
  in entry-macro.S

- Update mach-omap2/io.c to support 2420, 2430, and 34xx

- Also merge in 34xx GPMC changes to add fields wr_access and
  wr_data_mux_bus from Adrian Hunter

- Remove memory initialization call omap2_init_memory() until
  until more generic memory initialization patches are posted.
  It's OK to rely on bootloader initialization until then.

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
Signed-off-by: Karthik Dasu<karthik-dp@ti.com>
Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e2274bc..9400314 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -118,6 +118,7 @@ endif
  machine-$(CONFIG_ARCH_IXP23XX)    := ixp23xx
  machine-$(CONFIG_ARCH_OMAP1)	   := omap1
  machine-$(CONFIG_ARCH_OMAP2)	   := omap2
+ machine-$(CONFIG_ARCH_OMAP3)	   := omap2
     plat-$(CONFIG_ARCH_OMAP)	   := omap
  machine-$(CONFIG_ARCH_S3C2410)	   := s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
     plat-$(CONFIG_PLAT_S3C24XX)	   := s3c24xx
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 7069c9d..a4582a9 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -14,9 +14,19 @@ config ARCH_OMAP2420
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
+	select ARCH_OMAP_OTG
+
+config ARCH_OMAP34XX
+	bool "OMAP34xx Based System"
+	depends on ARCH_OMAP3
+
+config ARCH_OMAP3430
+	bool "OMAP3430 support"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select ARCH_OMAP_OTG
 
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2 || ARCH_OMAP3
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 800639e..0dc40db 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
+obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 # Power Management
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a8d34f6..f3e0271 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -220,6 +220,11 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	if (cpu_is_omap34xx()) {
+		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
+	}
+
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
 	 */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index faf3f68..5ea64f9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -43,7 +43,9 @@
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
  */
-static struct map_desc omap2_io_desc[] __initdata = {
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct map_desc omap24xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_24XX_VIRT,
 		.pfn		= __phys_to_pfn(L3_24XX_PHYS),
@@ -51,12 +53,39 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual        = L4_24XX_VIRT,
-		.pfn            = __phys_to_pfn(L4_24XX_PHYS),
-		.length         = L4_24XX_SIZE,
-		.type           = MT_DEVICE
+		.virtual	= L4_24XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
+		.length		= L4_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+#ifdef CONFIG_ARCH_OMAP2420
+static struct map_desc omap242x_io_desc[] __initdata = {
+	{
+		.virtual	= DSP_MEM_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
+		.length		= DSP_MEM_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= DSP_IPI_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
+		.length		= DSP_IPI_24XX_SIZE,
+		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= DSP_MMU_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
+		.length		= DSP_MMU_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+#endif
+
 #ifdef CONFIG_ARCH_OMAP2430
+static struct map_desc omap243x_io_desc[] __initdata = {
 	{
 		.virtual	= L4_WK_243X_VIRT,
 		.pfn		= __phys_to_pfn(L4_WK_243X_PHYS),
@@ -69,30 +98,90 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.length		= OMAP243X_GPMC_SIZE,
 		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= OMAP243X_SDRC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SDRC_PHYS),
+		.length		= OMAP243X_SDRC_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= OMAP243X_SMS_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SMS_PHYS),
+		.length		= OMAP243X_SMS_SIZE,
+		.type		= MT_DEVICE
+	},
+};
 #endif
+#endif
+
+#ifdef	CONFIG_ARCH_OMAP34XX
+static struct map_desc omap34xx_io_desc[] __initdata = {
 	{
-		.virtual	= DSP_MEM_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		= DSP_MEM_24XX_SIZE,
+		.virtual	= L3_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L3_34XX_PHYS),
+		.length		= L3_34XX_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= DSP_IPI_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		= DSP_IPI_24XX_SIZE,
+		.virtual	= L4_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
+		.length		= L4_34XX_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= DSP_MMU_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		= DSP_MMU_24XX_SIZE,
+		.virtual	= L4_WK_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_WK_34XX_PHYS),
+		.length		= L4_WK_34XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= OMAP34XX_GPMC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP34XX_GPMC_PHYS),
+		.length		= OMAP34XX_GPMC_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= OMAP343X_SMS_VIRT,
+		.pfn		= __phys_to_pfn(OMAP343X_SMS_PHYS),
+		.length		= OMAP343X_SMS_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= OMAP343X_SDRC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP343X_SDRC_PHYS),
+		.length		= OMAP343X_SDRC_SIZE,
 		.type		= MT_DEVICE
-	}
+	},
+	{
+		.virtual	= L4_PER_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_PER_34XX_PHYS),
+		.length		= L4_PER_34XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= L4_EMU_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_EMU_34XX_PHYS),
+		.length		= L4_EMU_34XX_SIZE,
+		.type		= MT_DEVICE
+	},
 };
+#endif
 
 void __init omap2_map_common_io(void)
 {
-	iotable_init(omap2_io_desc, ARRAY_SIZE(omap2_io_desc));
+#if defined(CONFIG_ARCH_OMAP2420)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
+#endif
+
+#if defined(CONFIG_ARCH_OMAP34XX)
+	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
+#endif
 
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
@@ -112,11 +201,6 @@ void __init omap2_init_common_hw(void)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
-/*
- * Need to Fix this for 2430
- */
-#ifndef CONFIG_ARCH_OMAP2430
 	omap2_init_memory();
-#endif
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 4759658..15a4f5b 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -127,6 +127,8 @@ void __init omap_init_irq(void)
 
 		if (cpu_is_omap24xx())
 			bank->base_reg = OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE);
+		else if (cpu_is_omap34xx())
+			bank->base_reg = OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE);
 
 		omap_irq_bank_init_one(bank);
 
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index ab1462b..882c702 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -101,6 +101,17 @@ u32 omap2_reprogram_sdrc(u32 level, u32 force)
 	return prev;
 }
 
+#if !defined(CONFIG_ARCH_OMAP2)
+void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+				u32 base_cs, u32 force_unlock)
+{
+}
+void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+				      u32 mem_type)
+{
+}
+#endif
+
 void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 {
 	unsigned long dll_cnt;
@@ -165,6 +176,9 @@ void __init omap2_init_memory(void)
 {
 	u32 l;
 
+	if (!cpu_is_omap2420())
+		return;
+
 	l = sms_read_reg(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
new file mode 100644
index 0000000..2c71461
--- /dev/null
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -0,0 +1,179 @@
+/*
+ * linux/arch/arm/mach-omap3/sram.S
+ *
+ * Omap3 specific functions that need to be run in internal SRAM
+ *
+ * (C) Copyright 2007
+ * Texas Instruments Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * (C) Copyright 2004
+ * Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/hardware.h>
+
+#include <mach/io.h>
+
+#include "sdrc.h"
+#include "cm.h"
+
+	.text
+
+/*
+ * Change frequency of core dpll
+ * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla r2 = sdrc_actim_ctrlb r3 = M2
+ */
+ENTRY(omap3_sram_configure_core_dpll)
+	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
+	cmp	r3, #0x2
+	blne	configure_sdrc
+	cmp	r3, #0x2
+	blne	lock_dll
+	cmp	r3, #0x1
+	blne	unlock_dll
+	bl	sdram_in_selfrefresh	@ put the SDRAM in self refresh
+	bl 	configure_core_dpll
+	bl	enable_sdrc
+	cmp	r3, #0x1
+	blne	wait_dll_unlock
+	cmp	r3, #0x2
+	blne	wait_dll_lock
+	cmp	r3, #0x1
+	blne	configure_sdrc
+	mov 	r0, #0 			@ return value
+	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
+unlock_dll:
+	ldr	r4, omap3_sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	orr	r5, r5, #0x4
+	str	r5, [r4]
+	bx	lr
+lock_dll:
+	ldr	r4, omap3_sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	bic	r5, r5, #0x4
+	str	r5, [r4]
+	bx	lr
+sdram_in_selfrefresh:
+	mov	r5, #0x0		@ Move 0 to R5
+	mcr	p15, 0, r5, c7, c10, 5	@ memory barrier
+	ldr	r4, omap3_sdrc_power	@ read the SDRC_POWER register
+	ldr	r5, [r4]		@ read the contents of SDRC_POWER
+	orr 	r5, r5, #0x40		@ enable self refresh on idle req
+	str 	r5, [r4]		@ write back to SDRC_POWER register
+	ldr	r4, omap3_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
+	ldr	r5, [r4]
+	bic	r5, r5, #0x2		@ disable iclk bit for SRDC
+	str 	r5, [r4]
+wait_sdrc_idle:
+	ldr 	r4, omap3_cm_idlest1_core
+	ldr 	r5, [r4]
+	and 	r5, r5, #0x2		@ check for SDRC idle
+	cmp 	r5, #2
+	bne 	wait_sdrc_idle
+	bx 	lr
+configure_core_dpll:
+	ldr 	r4, omap3_cm_clksel1_pll
+	ldr	r5, [r4]
+	ldr	r6, core_m2_mask_val	@ modify m2 for core dpll
+	and	r5, r5, r6
+	orr	r5, r5, r3, lsl #0x1B	@ r3 contains the M2 val
+	str	r5, [r4]
+	mov 	r5, #0x800		@ wait for the clock to stabilise
+	cmp	r3, #2
+	bne	wait_clk_stable
+	bx	lr
+wait_clk_stable:
+	subs 	r5, r5, #1
+	bne	wait_clk_stable
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	bx	lr
+enable_sdrc:
+	ldr 	r4, omap3_cm_iclken1_core
+	ldr	r5, [r4]
+	orr 	r5, r5, #0x2		@ enable iclk bit for SDRC
+	str 	r5, [r4]
+wait_sdrc_idle1:
+	ldr 	r4, omap3_cm_idlest1_core
+	ldr	r5, [r4]
+	and 	r5, r5, #0x2
+	cmp	r5, #0
+	bne	wait_sdrc_idle1
+	ldr	r4, omap3_sdrc_power
+	ldr	r5, [r4]
+	bic 	r5, r5, #0x40
+	str 	r5, [r4]
+	bx	lr
+wait_dll_lock:
+	ldr	r4, omap3_sdrc_dlla_status
+	ldr	r5, [r4]
+	and 	r5, r5, #0x4
+	cmp	r5, #0x4
+	bne	wait_dll_lock
+	bx	lr
+wait_dll_unlock:
+	ldr	r4, omap3_sdrc_dlla_status
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x0
+	bne	wait_dll_unlock
+	bx	lr
+configure_sdrc:
+	ldr	r4, omap3_sdrc_rfr_ctrl
+	str	r0, [r4]
+	ldr	r4, omap3_sdrc_actim_ctrla
+	str	r1, [r4]
+	ldr	r4, omap3_sdrc_actim_ctrlb
+	str	r2, [r4]
+	bx	lr
+
+omap3_sdrc_power:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+omap3_cm_clksel1_pll:
+	.word OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap3_cm_idlest1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
+omap3_cm_iclken1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
+omap3_sdrc_rfr_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap3_sdrc_actim_ctrla:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
+omap3_sdrc_actim_ctrlb:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_dlla_status:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
+omap3_sdrc_dlla_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
+core_m2_mask_val:
+	.word 0x07FFFFFF
+
+ENTRY(omap3_sram_configure_core_dpll_sz)
+	.word	. - omap3_sram_configure_core_dpll
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ef62bf2..a94f0c4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -15,6 +15,9 @@ config ARCH_OMAP1
 config ARCH_OMAP2
 	bool "TI OMAP2"
 
+config ARCH_OMAP3
+	bool "TI OMAP3"
+
 endchoice
 
 comment "OMAP Feature Selections"
@@ -112,13 +115,13 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX and 24XX.
+	  currently only available for OMAP16XX, 24XX and 34XX.
 
 endchoice
 
@@ -133,7 +136,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 3ca15de..3619bdc 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -95,6 +95,10 @@ static inline void omap_init_dsp(void) { }
 
 static void omap_init_kp(void)
 {
+	/* 2430 and 34xx keypad is on TWL4030 */
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		return;
+
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
 		omap_cfg_reg(D20_1610_KBC1);
@@ -441,8 +445,17 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP34XX)
+#define	OMAP_WDT_BASE		0x48314000
+#elif defined(CONFIG_ARCH_OMAP24XX)
+
+#ifdef CONFIG_ARCH_OMAP2430
+/* WDT2 */
+#define	OMAP_WDT_BASE		0x49016000
+#else
 #define	OMAP_WDT_BASE		0x48022000
+#endif
+
 #else
 #define	OMAP_WDT_BASE		0xfffeb000
 #endif
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
index 1b0039b..1b11f5c 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -35,6 +35,18 @@
 #ifdef CONFIG_OMAP_LL_DEBUG_UART3
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
+
+#elif	CONFIG_ARCH_OMAP3
+		moveq	\rx, #0x48000000	@ physical base address
+		movne	\rx, #0xd8000000	@ virtual base
+		orr	\rx, \rx, #0x0006a000
+#ifdef CONFIG_OMAP_LL_DEBUG_UART2
+		add	\rx, \rx, #0x00002000	@ UART 2
+#endif
+#ifdef CONFIG_OMAP_LL_DEBUG_UART3
+		add	\rx, \rx, #0x00fb0000	@ UART 3
+		add	\rx, \rx, #0x00006000
+#endif
 #endif
 		.endm
 
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index d4e9043..030118e 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -55,9 +55,17 @@
 1510:
 		.endm
 
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#endif
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
+#if defined(CONFIG_ARCH_OMAP24XX)
 #include <mach/omap24xx.h>
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+#include <mach/omap34xx.h>
+#endif
+
+#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt number */
 
 		.macro	disable_fiq
 		.endm
@@ -79,7 +87,7 @@
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
 2222:
-		ldrne	\irqnr, [\base, #IRQ_SIR_IRQ]
+		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
 
 		.endm
 
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 3c7b425..45b6784 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -84,6 +84,10 @@ struct gpmc_timings {
 	u16 access;		/* Start-cycle to first data valid delay */
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
+
+	/* The following are only on OMAP3430 */
+	u16 wr_access;		/* WRACCESSTIME */
+	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index dd0cf06..adc83b7 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -73,7 +73,6 @@
 #define L4_24XX_VIRT	0xd8000000
 #define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
 
-#ifdef CONFIG_ARCH_OMAP2430
 #define L4_WK_243X_PHYS		L4_WK_243X_BASE		/* 0x49000000 */
 #define L4_WK_243X_VIRT		0xd9000000
 #define L4_WK_243X_SIZE		SZ_1M
@@ -87,8 +86,6 @@
 #define OMAP243X_SMS_VIRT	0xFC000000
 #define OMAP243X_SMS_SIZE	SZ_1M
 
-#endif
-
 #define IO_OFFSET		0x90000000
 #define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
 #define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index fe0b3d3..39ba502 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -285,8 +285,72 @@
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
+#define INT_24XX_SPI3_IRQ	91
+
+#define INT_243X_MCBSP2_IRQ	16
+#define INT_243X_MCBSP3_IRQ	17
+#define INT_243X_MCBSP4_IRQ	18
+#define INT_243X_MCBSP5_IRQ	19
+#define INT_243X_MCBSP1_IRQ	64
+#define INT_243X_HS_USB_MC	92
+#define INT_243X_HS_USB_DMA	93
+#define INT_243X_CARKIT_IRQ	94
+
+#define INT_34XX_ST_MCBSP2_IRQ	4
+#define INT_34XX_ST_MCBSP3_IRQ	5
+#define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_PRCM_MPU_IRQ	11
+#define INT_34XX_MCBSP1_IRQ	16
+#define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_MCBSP3_IRQ	22
+#define INT_34XX_MCBSP4_IRQ	23
+#define INT_34XX_CAM_IRQ	24
+#define INT_34XX_MCBSP5_IRQ	27
+#define INT_34XX_GPIO_BANK1	29
+#define INT_34XX_GPIO_BANK2	30
+#define INT_34XX_GPIO_BANK3	31
+#define INT_34XX_GPIO_BANK4	32
+#define INT_34XX_GPIO_BANK5	33
+#define INT_34XX_GPIO_BANK6	34
+#define INT_34XX_USIM_IRQ	35
+#define INT_34XX_WDT3_IRQ	36
+#define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_PBIAS_IRQ	75
+#define INT_34XX_OHCI_IRQ	76
+#define INT_34XX_EHCI_IRQ	77
+#define INT_34XX_TLL_IRQ	78
+#define INT_34XX_MMC3_IRQ	94
+#define INT_34XX_GPT12_IRQ	95
 
 #define	INT_34XX_BENCH_MPU_EMUL	3
+#define INT_34XX_ST_MCBSP2_IRQ	4
+#define INT_34XX_ST_MCBSP3_IRQ	5
+#define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_PRCM_MPU_IRQ	11
+#define INT_34XX_MCBSP1_IRQ	16
+#define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_MCBSP3_IRQ	22
+#define INT_34XX_MCBSP4_IRQ	23
+#define INT_34XX_CAM_IRQ	24
+#define INT_34XX_MCBSP5_IRQ	27
+#define INT_34XX_GPIO_BANK1	29
+#define INT_34XX_GPIO_BANK2	30
+#define INT_34XX_GPIO_BANK3	31
+#define INT_34XX_GPIO_BANK4	32
+#define INT_34XX_GPIO_BANK5	33
+#define INT_34XX_GPIO_BANK6	34
+#define INT_34XX_USIM_IRQ	35
+#define INT_34XX_WDT3_IRQ	36
+#define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_PBIAS_IRQ	75
+#define INT_34XX_OHCI_IRQ	76
+#define INT_34XX_EHCI_IRQ	77
+#define INT_34XX_TLL_IRQ	78
+#define INT_34XX_MMC3_IRQ	94
+#define INT_34XX_GPT12_IRQ	95
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index a3074f2..c8d0aa1 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -91,7 +91,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index a325caf..d40cac6 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -38,7 +38,7 @@
  */
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #define PHYS_OFFSET		UL(0x80000000)
 #endif
 
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 556f0eb..24335d4 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -39,7 +39,6 @@
 /* interrupt controller */
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
-#define IRQ_SIR_IRQ		0x0040
 
 #define OMAP2420_CTRL_BASE	L4_24XX_BASE
 #define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 25ee381..a98c6c3 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -25,8 +25,8 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
-#define SDRC_ACTIM_CTRL_A	0x09c
-#define SDRC_ACTIM_CTRL_B	0x0a0
+#define SDRC_ACTIM_CTRL_A_0	0x09c
+#define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index e093234..ab35d62 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -21,6 +21,10 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 				      u32 mem_type);
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
+extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
+				     u32 sdrc_actim_ctrla,
+				     u32 sdrc_actim_ctrlb, u32 m2);
+
 /* Do not use these */
 extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap1_sram_reprogram_clock_sz;
@@ -53,4 +57,10 @@ extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 						u32 mem_type);
 extern unsigned long omap243x_sram_reprogram_sdrc_sz;
 
+
+extern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
+					  u32 sdrc_actim_ctrla,
+					  u32 sdrc_actim_ctrlb, u32 m2);
+extern unsigned long omap3_sram_configure_core_dpll_sz;
+
 #endif
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 06a28c7..06923f2 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -40,7 +40,7 @@ static inline void omap1_arch_reset(char mode)
 
 static inline void arch_reset(char mode)
 {
-	if (!cpu_is_omap24xx())
+	if (!cpu_class_is_omap2())
 		omap1_arch_reset(mode);
 	else
 		omap_prcm_arch_reset(mode);
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 0253c45..af326ef 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -47,11 +47,13 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP2
-	if (cpu_class_is_omap2()) {
+	if (cpu_is_omap24xx()) {
 		if (BETWEEN(p, L3_24XX_PHYS, L3_24XX_SIZE))
 			return XLATE(p, L3_24XX_PHYS, L3_24XX_VIRT);
 		if (BETWEEN(p, L4_24XX_PHYS, L4_24XX_SIZE))
 			return XLATE(p, L4_24XX_PHYS, L4_24XX_VIRT);
+	}
+	if (cpu_is_omap2420()) {
 		if (BETWEEN(p, DSP_MEM_24XX_PHYS, DSP_MEM_24XX_SIZE))
 			return XLATE(p, DSP_MEM_24XX_PHYS, DSP_MEM_24XX_VIRT);
 		if (BETWEEN(p, DSP_IPI_24XX_PHYS, DSP_IPI_24XX_SIZE))
@@ -59,14 +61,36 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 		if (BETWEEN(p, DSP_MMU_24XX_PHYS, DSP_MMU_24XX_SIZE))
 			return XLATE(p, DSP_MMU_24XX_PHYS, DSP_MMU_24XX_VIRT);
 	}
-#ifdef CONFIG_ARCH_OMAP2430
 	if (cpu_is_omap2430()) {
 		if (BETWEEN(p, L4_WK_243X_PHYS, L4_WK_243X_SIZE))
-			return XLATE(L4_WK_243X_PHYS, L4_WK_243X_VIRT);
+			return XLATE(p, L4_WK_243X_PHYS, L4_WK_243X_VIRT);
 		if (BETWEEN(p, OMAP243X_GPMC_PHYS, OMAP243X_GPMC_SIZE))
-			return XLATE(OMAP243X_GPMC_PHYS, OMAP243X_GPMC_VIRT);
+			return XLATE(p, OMAP243X_GPMC_PHYS, OMAP243X_GPMC_VIRT);
+		if (BETWEEN(p, OMAP243X_SDRC_PHYS, OMAP243X_SDRC_SIZE))
+			return XLATE(p, OMAP243X_SDRC_PHYS, OMAP243X_SDRC_VIRT);
+		if (BETWEEN(p, OMAP243X_SMS_PHYS, OMAP243X_SMS_SIZE))
+			return XLATE(p, OMAP243X_SMS_PHYS, OMAP243X_SMS_VIRT);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP3
+	if (cpu_is_omap34xx()) {
+		if (BETWEEN(p, L3_34XX_PHYS, L3_34XX_SIZE))
+			return XLATE(p, L3_34XX_PHYS, L3_34XX_VIRT);
+		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
+			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
+		if (BETWEEN(p, L4_WK_34XX_PHYS, L4_WK_34XX_SIZE))
+			return XLATE(p, L4_WK_34XX_PHYS, L4_WK_34XX_VIRT);
+		if (BETWEEN(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_SIZE))
+			return XLATE(p, OMAP34XX_GPMC_PHYS, OMAP34XX_GPMC_VIRT);
+		if (BETWEEN(p, OMAP343X_SMS_PHYS, OMAP343X_SMS_SIZE))
+			return XLATE(p, OMAP343X_SMS_PHYS, OMAP343X_SMS_VIRT);
+		if (BETWEEN(p, OMAP343X_SDRC_PHYS, OMAP343X_SDRC_SIZE))
+			return XLATE(p, OMAP343X_SDRC_PHYS, OMAP343X_SDRC_VIRT);
+		if (BETWEEN(p, L4_PER_34XX_PHYS, L4_PER_34XX_SIZE))
+			return XLATE(p, L4_PER_34XX_PHYS, L4_PER_34XX_VIRT);
+		if (BETWEEN(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_SIZE))
+			return XLATE(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_VIRT);
+	}
 #endif
 
 	return __arm_ioremap(p, size, type);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e0003e0..2e8402a 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -271,7 +271,7 @@ int __init omap1_sram_init(void)
 #define omap1_sram_init()	do {} while (0)
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2)
 
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 			      u32 base_cs, u32 force_unlock);
@@ -352,60 +352,41 @@ static inline int omap243x_sram_init(void)
 
 #ifdef CONFIG_ARCH_OMAP3
 
-static u32 (*_omap2_sram_reprogram_gpmc)(u32 perf_level);
-u32 omap2_sram_reprogram_gpmc(u32 perf_level)
-{
-	if (!_omap2_sram_reprogram_gpmc)
+static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
+					      u32 sdrc_actim_ctrla,
+					      u32 sdrc_actim_ctrlb,
+					      u32 m2);
+u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
+			      u32 sdrc_actim_ctrlb, u32 m2)
+ {
+	if (!_omap3_sram_configure_core_dpll)
 		omap_sram_error();
 
-	return _omap2_sram_reprogram_gpmc(perf_level);
-}
-
-static u32 (*_omap2_sram_configure_core_dpll)(u32 m, u32 n,
-						u32 freqsel, u32 m2);
-u32 omap2_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
-{
-	if (!_omap2_sram_configure_core_dpll)
-		omap_sram_error();
-
-	return _omap2_sram_configure_core_dpll(m, n, freqsel, m2);
-}
+	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
+					       sdrc_actim_ctrla,
+					       sdrc_actim_ctrlb, m2);
+ }
 
 /* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
 void restore_sram_functions(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
-	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
-		omap34xx_sram_reprogram_gpmc_sz);
-
-	_omap2_sram_configure_core_dpll =
-			omap_sram_push(omap34xx_sram_configure_core_dpll,
-					omap34xx_sram_configure_core_dpll_sz);
+	_omap3_sram_configure_core_dpll =
+		omap_sram_push(omap3_sram_configure_core_dpll,
+			       omap3_sram_configure_core_dpll_sz);
 }
 
-int __init omap34xx_sram_init(void)
+int __init omap3_sram_init(void)
 {
-	_omap2_sram_ddr_init = omap_sram_push(omap34xx_sram_ddr_init,
-					omap34xx_sram_ddr_init_sz);
-
-	_omap2_sram_reprogram_sdrc = omap_sram_push(omap34xx_sram_reprogram_sdrc,
-					omap34xx_sram_reprogram_sdrc_sz);
-
-	_omap2_set_prcm = omap_sram_push(omap34xx_sram_set_prcm,
-					omap34xx_sram_set_prcm_sz);
-
-	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
-					omap34xx_sram_reprogram_gpmc_sz);
-
-	_omap2_sram_configure_core_dpll =
-				omap_sram_push(omap34xx_sram_configure_core_dpll,
-					omap34xx_sram_configure_core_dpll_sz);
+	_omap3_sram_configure_core_dpll =
+		omap_sram_push(omap3_sram_configure_core_dpll,
+			       omap3_sram_configure_core_dpll_sz);
 
 	return 0;
 }
 #else
-static inline int omap34xx_sram_init(void)
+static inline int omap3_sram_init(void)
 {
 	return 0;
 }
@@ -423,7 +404,7 @@ int __init omap_sram_init(void)
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
-		omap34xx_sram_init();
+		omap3_sram_init();
 
 	return 0;
 }
