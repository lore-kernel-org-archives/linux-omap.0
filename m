From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/16] ARM: OMAP2: Add minimal omap3430 support
Date: Fri,  6 Jun 2008 19:12:41 -0700
Message-ID: <1212804762-18413-14-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
 <1212804762-18413-6-git-send-email-tony@atomide.com>
 <1212804762-18413-7-git-send-email-tony@atomide.com>
 <1212804762-18413-8-git-send-email-tony@atomide.com>
 <1212804762-18413-9-git-send-email-tony@atomide.com>
 <1212804762-18413-10-git-send-email-tony@atomide.com>
 <1212804762-18413-11-git-send-email-tony@atomide.com>
 <1212804762-18413-12-git-send-email-tony@atomide.com>
 <1212804762-18413-13-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56873 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092AbYFGCNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:13:16 -0400
In-Reply-To: <1212804762-18413-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Tony Lindgren <tony@atomide.com>

From: Syed Mohammed Khasim <x0khasim@ti.com>

Add minimal omap3430 support

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
index 4e84673..e1734ae 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
+obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 # Power Management
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d825100..314994b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -113,6 +113,59 @@ static struct map_desc omap243x_io_desc[] __initdata = {
 #endif
 #endif
 
+#ifdef	CONFIG_ARCH_OMAP34XX
+static struct map_desc omap34xx_io_desc[] __initdata = {
+	{
+		.virtual	= L3_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L3_34XX_PHYS),
+		.length		= L3_34XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= L4_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
+		.length		= L4_34XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
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
+		.type		= MT_DEVICE
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
+};
+#endif
+
 void __init omap2_map_common_io(void)
 {
 #if defined(CONFIG_ARCH_OMAP2420)
@@ -125,6 +178,10 @@ void __init omap2_map_common_io(void)
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
 #endif
 
+#if defined(CONFIG_ARCH_OMAP34XX)
+	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
+#endif
+
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
 	 * revision check below.
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index f064f72..8ff6fef 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -37,11 +37,9 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
 		/* MPU INTC */
-		.base_reg	= IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	= 0,
 		.nr_irqs	= 96,
-	}, {
-		/* XXX: DSP INTC */
-	}
+	},
 };
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -118,10 +116,10 @@ void __init omap_init_irq(void)
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+		if (cpu_is_omap24xx())
+			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
+		if (cpu_is_omap34xx())
+			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
 		omap_irq_bank_init_one(bank);
 
 		nr_irqs += bank->nr_irqs;
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
 
diff --git a/include/asm-arm/arch-omap/debug-macro.S b/include/asm-arm/arch-omap/debug-macro.S
index ca4f577..3866e04 100644
--- a/include/asm-arm/arch-omap/debug-macro.S
+++ b/include/asm-arm/arch-omap/debug-macro.S
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
 
diff --git a/include/asm-arm/arch-omap/entry-macro.S b/include/asm-arm/arch-omap/entry-macro.S
index 369093a..6c836e2 100644
--- a/include/asm-arm/arch-omap/entry-macro.S
+++ b/include/asm-arm/arch-omap/entry-macro.S
@@ -55,9 +55,15 @@
 1510:
 		.endm
 
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#endif
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
+#if defined(CONFIG_ARCH_OMAP24XX)
 #include <asm/arch/omap24xx.h>
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+#include <asm/arch/omap34xx.h>
+#endif
 
 		.macro	disable_fiq
 		.endm
diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
index 0b13557..ad272f2 100644
--- a/include/asm-arm/arch-omap/io.h
+++ b/include/asm-arm/arch-omap/io.h
@@ -88,6 +88,63 @@
 #define OMAP243X_SMS_VIRT	0xFC000000
 #define OMAP243X_SMS_SIZE	SZ_1M
 
+#elif defined(CONFIG_ARCH_OMAP3)
+
+/* We map both L3 and L4 on OMAP3 */
+#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
+#define L3_34XX_VIRT		0xf8000000
+#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
+
+#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 */
+#define L4_34XX_VIRT		0xd8000000
+#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
+ * Need to look at the Size 4M for L4.
+ * VPOM3430 was not working for Int controller
+ */
+
+#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE /* 0x48300000 */
+#define L4_WK_34XX_VIRT		0xd8300000
+#define L4_WK_34XX_SIZE		SZ_1M
+
+#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE /* 0x49000000 */
+#define L4_PER_34XX_VIRT	0xd9000000
+#define L4_PER_34XX_SIZE	SZ_1M
+
+#define L4_EMU_34XX_PHYS	L4_34XX_EMU_BASE /* 0x54000000 */
+#define L4_EMU_34XX_VIRT	0xe4000000
+#define L4_EMU_34XX_SIZE	SZ_64M
+
+#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE /* 0x6E000000 */
+#define OMAP34XX_GPMC_VIRT	0xFE000000
+#define OMAP34XX_GPMC_SIZE	SZ_1M
+
+#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE /* 0x6C000000 */
+#define OMAP343X_SMS_VIRT	0xFC000000
+#define OMAP343X_SMS_SIZE	SZ_1M
+
+#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE /* 0x6D000000 */
+#define OMAP343X_SDRC_VIRT	0xFD000000
+#define OMAP343X_SDRC_SIZE	SZ_1M
+
+
+#define IO_OFFSET		0x90000000
+#define IO_ADDRESS(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_p2v(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
+
+/* DSP */
+#define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_34XX_VIRT	0xe0000000
+#define DSP_MEM_34XX_SIZE	0x28000
+#define DSP_IPI_34XX_PHYS	OMAP34XX_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_34XX_VIRT	0xe1000000
+#define DSP_IPI_34XX_SIZE	SZ_4K
+#define DSP_MMU_34XX_PHYS	OMAP34XX_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_34XX_VIRT	0xe2000000
+#define DSP_MMU_34XX_SIZE	SZ_4K
+
 #endif
 
 #define IO_OFFSET	0x90000000
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index f901e8b..956f53c 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -324,6 +324,33 @@
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95
 
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
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
index 26c78f6..82627bb 100644
--- a/include/asm-arm/arch-omap/mcbsp.h
+++ b/include/asm-arm/arch-omap/mcbsp.h
@@ -91,7 +91,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
diff --git a/include/asm-arm/arch-omap/memory.h b/include/asm-arm/arch-omap/memory.h
index 14cba97..d22c13d 100644
--- a/include/asm-arm/arch-omap/memory.h
+++ b/include/asm-arm/arch-omap/memory.h
@@ -38,7 +38,7 @@
  */
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #define PHYS_OFFSET		UL(0x80000000)
 #endif
 
