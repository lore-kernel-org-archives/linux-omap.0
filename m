From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP2/3: Remove OMAP_CM_REGADDR
Date: Thu, 14 May 2009 16:28:24 -0700
Message-ID: <20090514232824.19331.55102.stgit@localhost>
References: <20090514231820.19331.65419.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50664 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbZENX2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:28:30 -0400
In-Reply-To: <20090514231820.19331.65419.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Processor specific macros should be used instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.h            |    2 ++
 arch/arm/mach-omap2/clock34xx.h            |    2 ++
 arch/arm/mach-omap2/cm.h                   |    5 -----
 arch/arm/plat-omap/include/mach/omap24xx.h |   10 ----------
 arch/arm/plat-omap/include/mach/omap34xx.h |    6 ------
 5 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index f0e4480..458f00c 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -26,9 +26,11 @@
 
 /* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420
+#define OMAP_CM_REGADDR			OMAP2420_CM_REGADDR
 #define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2420_PRCM_CLKOUT_CTRL
 #define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2420_PRCM_CLKEMUL_CTRL
 #else
+#define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
 #define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2430_PRCM_CLKOUT_CTRL
 #define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2430_PRCM_CLKEMUL_CTRL
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 017a30e..496f0e9 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -27,6 +27,8 @@
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 
+#define OMAP_CM_REGADDR		OMAP34XX_CM_REGADDR
+
 static unsigned long omap3_dpll_recalc(struct clk *clk);
 static unsigned long omap3_clkoutx2_recalc(struct clk *clk);
 static void omap3_dpll_allow_idle(struct clk *clk);
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index efc082a..1d3c93b 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -16,17 +16,12 @@
 
 #include "prcm-common.h"
 
-#ifndef __ASSEMBLER__
-#define OMAP_CM_REGADDR(module, reg)					\
-			IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
-#else
 #define OMAP2420_CM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 #define OMAP34XX_CM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
-#endif
 
 /*
  * Architecture-specific global CM registers
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 60f8324..696edfc 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -85,15 +85,5 @@
 #define OMAP24XX_SEC_AES_BASE	(OMAP24XX_SEC_BASE + 0x6000)
 #define OMAP24XX_SEC_PKA_BASE	(OMAP24XX_SEC_BASE + 0x8000)
 
-#if defined(CONFIG_ARCH_OMAP2420)
-
-#define OMAP2_CM_BASE		OMAP2420_CM_BASE
-
-#elif defined(CONFIG_ARCH_OMAP2430)
-
-#define OMAP2_CM_BASE		OMAP2430_CM_BASE
-
-#endif
-
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 36c99ca..cc25733 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -83,12 +83,6 @@
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
-#if defined(CONFIG_ARCH_OMAP3430)
-
-#define OMAP2_CM_BASE			OMAP3430_CM_BASE
-
-#endif
-
 #define OMAP34XX_DSP_BASE	0x58000000
 #define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
 #define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)

