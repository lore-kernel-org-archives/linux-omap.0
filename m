From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] omap: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Fri, 16 Oct 2009 16:42:01 -0700
Message-ID: <20091016234201.2463.63549.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51015 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZJPXl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:41:58 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch splits OMAP2_IO_ADDRESS to OMAP2_L3_IO_ADDRESS and
OMAP2_L4_IO_ADDRESS to reclaim more IO space.

The omap_read*() and omap_write*() functions will work only over
L4 address space. Current omap kernel stack uses these functions
only to access registers over L4 io address space

Note that these macros should only be used when ioremap does
not work. Please use ioremap instead in all new code.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm.h                      |    6 ++-
 arch/arm/mach-omap2/pm-debug.c                |    3 +-
 arch/arm/mach-omap2/prm.h                     |    6 ++-
 arch/arm/mach-omap2/sdrc.h                    |    9 +++--
 arch/arm/mach-omap2/sram242x.S                |    4 +-
 arch/arm/mach-omap2/sram243x.S                |    4 +-
 arch/arm/plat-omap/common.c                   |   44 +++++++++++++------------
 arch/arm/plat-omap/include/mach/control.h     |   15 +++++----
 arch/arm/plat-omap/include/mach/entry-macro.S |    6 ++-
 arch/arm/plat-omap/include/mach/io.h          |    6 ++-
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 ++-
 arch/arm/plat-omap/io.c                       |   12 +++----
 arch/arm/plat-omap/sram.c                     |   20 ++++++-----
 13 files changed, 75 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index cfd0b72..a2fcfcc 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 #define OMAP34XX_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global CM registers
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 2fc4d6a..deed1dd 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -51,7 +51,8 @@ int omap2_pm_debug;
 	regs[reg_count++].val = __raw_readl(reg)
 #define DUMP_INTC_REG(reg, off) \
 	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(OMAP2_IO_ADDRESS(0x480fe000 + (off)))
+	regs[reg_count++].val = \
+			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
 
 static int __init pm_dbg_init(void);
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 03c467c..a117f85 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
 #define OMAP2430_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
 #define OMAP34XX_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global PRM registers
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 0837eda..345183d 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -48,9 +48,12 @@ static inline u32 sms_read_reg(u16 reg)
 	return __raw_readl(OMAP_SMS_REGADDR(reg));
 }
 #else
-#define OMAP242X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
-#define OMAP243X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
-#define OMAP34XX_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
+#define OMAP242X_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
+#define OMAP243X_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
+#define OMAP34XX_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
 #endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 9b62208..92e6e1a 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -128,7 +128,7 @@ omap242x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_sdi_timer_32ksynct_cr:
-	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 ENTRY(omap242x_sram_ddr_init_sz)
 	.word	. - omap242x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap242x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_srs_timer_32ksynct:
-	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap242x_sram_reprogram_sdrc_sz)
 	.word	. - omap242x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index df2cd92..ab49736 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -128,7 +128,7 @@ omap243x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_sdi_timer_32ksynct_cr:
-	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 ENTRY(omap243x_sram_ddr_init_sz)
 	.word	. - omap243x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap243x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_srs_timer_32ksynct:
-	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap243x_sram_reprogram_sdrc_sz)
 	.word	. - omap243x_sram_reprogram_sdrc
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3a4768d..1aa58d2 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -224,12 +224,12 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x48014000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP2420_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP2420_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
 };
 
 void __init omap2_set_globals_242x(void)
@@ -242,12 +242,12 @@ void __init omap2_set_globals_242x(void)
 
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4900a000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP2430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
 };
 
 void __init omap2_set_globals_243x(void)
@@ -260,12 +260,12 @@ void __init omap2_set_globals_243x(void)
 
 static struct omap_globals omap343x_globals = {
 	.class	= OMAP343X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
 };
 
 void __init omap2_set_globals_343x(void)
@@ -277,10 +277,10 @@ void __init omap2_set_globals_343x(void)
 #if defined(CONFIG_ARCH_OMAP4)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4830a000),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4830a000),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 826d317..805819f 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -20,15 +20,18 @@
 
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #else
-#define OMAP242X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
-#define OMAP243X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
-#define OMAP343X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define OMAP242X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 3bad928..2aea566 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -68,9 +68,9 @@
 
 /* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
 #if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
-#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #elif defined(CONFIG_ARCH_OMAP34XX)
-#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
 #include <mach/omap44xx.h>
@@ -104,7 +104,7 @@
 
 		.endm
 #else
-#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
 
 		/*
 		 * The interrupt numbering scheme is defined in the
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 8d32df3..c475be7 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -63,9 +63,11 @@
 #define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
 #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
 
-#define OMAP2_IO_OFFSET		0x90000000
-#define OMAP2_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_IO_OFFSET) /* L3 and L4 */
+#define OMAP2_L3_IO_OFFSET	0x90000000
+#define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
+#define OMAP2_L4_IO_OFFSET	0x90000000
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
 /*
  * ----------------------------------------------------------------------------
  * Omap1 specific IO mapping
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 1c09c78..7b58a5f 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -80,11 +80,11 @@
  */
 
 #define OMAP242X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
 #define OMAP243X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
 #define OMAP343X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 23a205f..eb74ab2 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -142,7 +142,7 @@ u8 omap_readb(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readb(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readb(OMAP2_IO_ADDRESS(pa));
+		return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readb);
 
@@ -151,7 +151,7 @@ u16 omap_readw(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readw(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readw(OMAP2_IO_ADDRESS(pa));
+		return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readw);
 
@@ -160,7 +160,7 @@ u32 omap_readl(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readl(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readl(OMAP2_IO_ADDRESS(pa));
+		return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readl);
 
@@ -169,7 +169,7 @@ void omap_writeb(u8 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writeb(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writeb);
 
@@ -178,7 +178,7 @@ void omap_writew(u16 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writew(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writew);
 
@@ -187,6 +187,6 @@ void omap_writel(u32 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writel(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 75d1f26..93bdbaf 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -56,16 +56,16 @@
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
 
-#define OMAP24XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68005048)
-#define OMAP24XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68005050)
-#define OMAP24XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68005058)
-
-#define OMAP34XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68012848)
-#define OMAP34XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68012850)
-#define OMAP34XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68012858)
-#define OMAP34XX_VA_ADDR_MATCH2		OMAP2_IO_ADDRESS(0x68012880)
-#define OMAP34XX_VA_SMS_RG_ATT0		OMAP2_IO_ADDRESS(0x6C000048)
-#define OMAP34XX_VA_CONTROL_STAT	OMAP2_IO_ADDRESS(0x480022F0)
+#define OMAP24XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68005048)
+#define OMAP24XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68005050)
+#define OMAP24XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68005058)
+
+#define OMAP34XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68012848)
+#define OMAP34XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68012850)
+#define OMAP34XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68012858)
+#define OMAP34XX_VA_ADDR_MATCH2		OMAP2_L3_IO_ADDRESS(0x68012880)
+#define OMAP34XX_VA_SMS_RG_ATT0		OMAP2_L3_IO_ADDRESS(0x6C000048)
+#define OMAP34XX_VA_CONTROL_STAT	OMAP2_L4_IO_ADDRESS(0x480022F0)
 
 #define GP_DEVICE		0x300
 

