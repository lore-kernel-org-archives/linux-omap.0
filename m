From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/17] ARM: OMAP2: Add common register access for 24xx and 34xx
Date: Wed,  9 Apr 2008 14:03:09 -0700
Message-ID: <1207775003-7429-4-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-04-09-210318
 <1207775003-7429-1-git-send-email-tony@atomide.com>
 <1207775003-7429-2-git-send-email-tony@atomide.com>
 <1207775003-7429-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63566 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483AbYDIVDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:03:32 -0400
In-Reply-To: <1207775003-7429-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

This patch adds common register access for 24xx and 34xx power
and clock management in order to share code between 24xx and 34xx.

Only change USB platform init code to use new register access, other
access will be changed in later patches.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile           |    4 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h  |  401 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm.h               |  126 ++++++++++
 arch/arm/mach-omap2/control.c          |   74 ++++++
 arch/arm/mach-omap2/prcm-common.h      |  317 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-24xx.h |  279 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm.h              |  318 +++++++++++++++++++++++++
 arch/arm/mach-omap2/sdrc.h             |   58 +++++
 arch/arm/plat-omap/usb.c               |   67 ++++--
 include/asm-arm/arch-omap/control.h    |  191 +++++++++++++++
 include/asm-arm/arch-omap/sdrc.h       |   75 ++++++
 include/asm-arm/arch-omap/usb.h        |    5 +-
 12 files changed, 1893 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm-regbits-24xx.h
 create mode 100644 arch/arm/mach-omap2/cm.h
 create mode 100644 arch/arm/mach-omap2/control.c
 create mode 100644 arch/arm/mach-omap2/prcm-common.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-24xx.h
 create mode 100644 arch/arm/mach-omap2/prm.h
 create mode 100644 arch/arm/mach-omap2/sdrc.h
 create mode 100644 include/asm-arm/arch-omap/control.h
 create mode 100644 include/asm-arm/arch-omap/sdrc.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ac343ec..b9313c9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,8 +3,8 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o devices.o \
-	 serial.o gpmc.o timer-gp.o
+obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o clock.o mux.o \
+		devices.o serial.o gpmc.o timer-gp.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o pm-domain.o sleep.o
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
new file mode 100644
index 0000000..20ac381
--- /dev/null
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -0,0 +1,401 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_CM_REGBITS_24XX_H
+#define __ARCH_ARM_MACH_OMAP2_CM_REGBITS_24XX_H
+
+/*
+ * OMAP24XX Clock Management register bits
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
+
+#include "cm.h"
+
+/* Bits shared between registers */
+
+/* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
+#define OMAP24XX_EN_CAM_SHIFT				31
+#define OMAP24XX_EN_CAM					(1 << 31)
+#define OMAP24XX_EN_WDT4_SHIFT				29
+#define OMAP24XX_EN_WDT4				(1 << 29)
+#define OMAP2420_EN_WDT3_SHIFT				28
+#define OMAP2420_EN_WDT3				(1 << 28)
+#define OMAP24XX_EN_MSPRO_SHIFT				27
+#define OMAP24XX_EN_MSPRO				(1 << 27)
+#define OMAP24XX_EN_FAC_SHIFT				25
+#define OMAP24XX_EN_FAC					(1 << 25)
+#define OMAP2420_EN_EAC_SHIFT				24
+#define OMAP2420_EN_EAC					(1 << 24)
+#define OMAP24XX_EN_HDQ_SHIFT				23
+#define OMAP24XX_EN_HDQ					(1 << 23)
+#define OMAP2420_EN_I2C2_SHIFT				20
+#define OMAP2420_EN_I2C2				(1 << 20)
+#define OMAP2420_EN_I2C1_SHIFT				19
+#define OMAP2420_EN_I2C1				(1 << 19)
+
+/* CM_FCLKEN2_CORE and CM_ICLKEN2_CORE shared bits */
+#define OMAP2430_EN_MCBSP5_SHIFT			5
+#define OMAP2430_EN_MCBSP5				(1 << 5)
+#define OMAP2430_EN_MCBSP4_SHIFT			4
+#define OMAP2430_EN_MCBSP4				(1 << 4)
+#define OMAP2430_EN_MCBSP3_SHIFT			3
+#define OMAP2430_EN_MCBSP3				(1 << 3)
+#define OMAP24XX_EN_SSI_SHIFT				1
+#define OMAP24XX_EN_SSI					(1 << 1)
+
+/* CM_FCLKEN_WKUP and CM_ICLKEN_WKUP shared bits */
+#define OMAP24XX_EN_MPU_WDT_SHIFT			3
+#define OMAP24XX_EN_MPU_WDT				(1 << 3)
+
+/* Bits specific to each register */
+
+/* CM_IDLEST_MPU */
+/* 2430 only */
+#define OMAP2430_ST_MPU					(1 << 0)
+
+/* CM_CLKSEL_MPU */
+#define OMAP24XX_CLKSEL_MPU_SHIFT			0
+#define OMAP24XX_CLKSEL_MPU_MASK			(0x1f << 0)
+
+/* CM_CLKSTCTRL_MPU */
+#define OMAP24XX_AUTOSTATE_MPU				(1 << 0)
+
+/* CM_FCLKEN1_CORE specific bits*/
+#define OMAP24XX_EN_TV_SHIFT				2
+#define OMAP24XX_EN_TV					(1 << 2)
+#define OMAP24XX_EN_DSS2_SHIFT				1
+#define OMAP24XX_EN_DSS2				(1 << 1)
+#define OMAP24XX_EN_DSS1_SHIFT				0
+#define OMAP24XX_EN_DSS1				(1 << 0)
+
+/* CM_FCLKEN2_CORE specific bits */
+#define OMAP2430_EN_I2CHS2_SHIFT			20
+#define OMAP2430_EN_I2CHS2				(1 << 20)
+#define OMAP2430_EN_I2CHS1_SHIFT			19
+#define OMAP2430_EN_I2CHS1				(1 << 19)
+#define OMAP2430_EN_MMCHSDB2_SHIFT			17
+#define OMAP2430_EN_MMCHSDB2				(1 << 17)
+#define OMAP2430_EN_MMCHSDB1_SHIFT			16
+#define OMAP2430_EN_MMCHSDB1				(1 << 16)
+
+/* CM_ICLKEN1_CORE specific bits */
+#define OMAP24XX_EN_MAILBOXES_SHIFT			30
+#define OMAP24XX_EN_MAILBOXES				(1 << 30)
+#define OMAP24XX_EN_DSS_SHIFT				0
+#define OMAP24XX_EN_DSS					(1 << 0)
+
+/* CM_ICLKEN2_CORE specific bits */
+
+/* CM_ICLKEN3_CORE */
+/* 2430 only */
+#define OMAP2430_EN_SDRC_SHIFT				2
+#define OMAP2430_EN_SDRC				(1 << 2)
+
+/* CM_ICLKEN4_CORE */
+#define OMAP24XX_EN_PKA_SHIFT				4
+#define OMAP24XX_EN_PKA					(1 << 4)
+#define OMAP24XX_EN_AES_SHIFT				3
+#define OMAP24XX_EN_AES					(1 << 3)
+#define OMAP24XX_EN_RNG_SHIFT				2
+#define OMAP24XX_EN_RNG					(1 << 2)
+#define OMAP24XX_EN_SHA_SHIFT				1
+#define OMAP24XX_EN_SHA					(1 << 1)
+#define OMAP24XX_EN_DES_SHIFT				0
+#define OMAP24XX_EN_DES					(1 << 0)
+
+/* CM_IDLEST1_CORE specific bits */
+#define OMAP24XX_ST_MAILBOXES				(1 << 30)
+#define OMAP24XX_ST_WDT4				(1 << 29)
+#define OMAP2420_ST_WDT3				(1 << 28)
+#define OMAP24XX_ST_MSPRO				(1 << 27)
+#define OMAP24XX_ST_FAC					(1 << 25)
+#define OMAP2420_ST_EAC					(1 << 24)
+#define OMAP24XX_ST_HDQ					(1 << 23)
+#define OMAP24XX_ST_I2C2				(1 << 20)
+#define OMAP24XX_ST_I2C1				(1 << 19)
+#define OMAP24XX_ST_MCBSP2				(1 << 16)
+#define OMAP24XX_ST_MCBSP1				(1 << 15)
+#define OMAP24XX_ST_DSS					(1 << 0)
+
+/* CM_IDLEST2_CORE */
+#define OMAP2430_ST_MCBSP5				(1 << 5)
+#define OMAP2430_ST_MCBSP4				(1 << 4)
+#define OMAP2430_ST_MCBSP3				(1 << 3)
+#define OMAP24XX_ST_SSI					(1 << 1)
+
+/* CM_IDLEST3_CORE */
+/* 2430 only */
+#define OMAP2430_ST_SDRC				(1 << 2)
+
+/* CM_IDLEST4_CORE */
+#define OMAP24XX_ST_PKA					(1 << 4)
+#define OMAP24XX_ST_AES					(1 << 3)
+#define OMAP24XX_ST_RNG					(1 << 2)
+#define OMAP24XX_ST_SHA					(1 << 1)
+#define OMAP24XX_ST_DES					(1 << 0)
+
+/* CM_AUTOIDLE1_CORE */
+#define OMAP24XX_AUTO_CAM				(1 << 31)
+#define OMAP24XX_AUTO_MAILBOXES				(1 << 30)
+#define OMAP24XX_AUTO_WDT4				(1 << 29)
+#define OMAP2420_AUTO_WDT3				(1 << 28)
+#define OMAP24XX_AUTO_MSPRO				(1 << 27)
+#define OMAP2420_AUTO_MMC				(1 << 26)
+#define OMAP24XX_AUTO_FAC				(1 << 25)
+#define OMAP2420_AUTO_EAC				(1 << 24)
+#define OMAP24XX_AUTO_HDQ				(1 << 23)
+#define OMAP24XX_AUTO_UART2				(1 << 22)
+#define OMAP24XX_AUTO_UART1				(1 << 21)
+#define OMAP24XX_AUTO_I2C2				(1 << 20)
+#define OMAP24XX_AUTO_I2C1				(1 << 19)
+#define OMAP24XX_AUTO_MCSPI2				(1 << 18)
+#define OMAP24XX_AUTO_MCSPI1				(1 << 17)
+#define OMAP24XX_AUTO_MCBSP2				(1 << 16)
+#define OMAP24XX_AUTO_MCBSP1				(1 << 15)
+#define OMAP24XX_AUTO_GPT12				(1 << 14)
+#define OMAP24XX_AUTO_GPT11				(1 << 13)
+#define OMAP24XX_AUTO_GPT10				(1 << 12)
+#define OMAP24XX_AUTO_GPT9				(1 << 11)
+#define OMAP24XX_AUTO_GPT8				(1 << 10)
+#define OMAP24XX_AUTO_GPT7				(1 << 9)
+#define OMAP24XX_AUTO_GPT6				(1 << 8)
+#define OMAP24XX_AUTO_GPT5				(1 << 7)
+#define OMAP24XX_AUTO_GPT4				(1 << 6)
+#define OMAP24XX_AUTO_GPT3				(1 << 5)
+#define OMAP24XX_AUTO_GPT2				(1 << 4)
+#define OMAP2420_AUTO_VLYNQ				(1 << 3)
+#define OMAP24XX_AUTO_DSS				(1 << 0)
+
+/* CM_AUTOIDLE2_CORE */
+#define OMAP2430_AUTO_MDM_INTC				(1 << 11)
+#define OMAP2430_AUTO_GPIO5				(1 << 10)
+#define OMAP2430_AUTO_MCSPI3				(1 << 9)
+#define OMAP2430_AUTO_MMCHS2				(1 << 8)
+#define OMAP2430_AUTO_MMCHS1				(1 << 7)
+#define OMAP2430_AUTO_USBHS				(1 << 6)
+#define OMAP2430_AUTO_MCBSP5				(1 << 5)
+#define OMAP2430_AUTO_MCBSP4				(1 << 4)
+#define OMAP2430_AUTO_MCBSP3				(1 << 3)
+#define OMAP24XX_AUTO_UART3				(1 << 2)
+#define OMAP24XX_AUTO_SSI				(1 << 1)
+#define OMAP24XX_AUTO_USB				(1 << 0)
+
+/* CM_AUTOIDLE3_CORE */
+#define OMAP24XX_AUTO_SDRC				(1 << 2)
+#define OMAP24XX_AUTO_GPMC				(1 << 1)
+#define OMAP24XX_AUTO_SDMA				(1 << 0)
+
+/* CM_AUTOIDLE4_CORE */
+#define OMAP24XX_AUTO_PKA				(1 << 4)
+#define OMAP24XX_AUTO_AES				(1 << 3)
+#define OMAP24XX_AUTO_RNG				(1 << 2)
+#define OMAP24XX_AUTO_SHA				(1 << 1)
+#define OMAP24XX_AUTO_DES				(1 << 0)
+
+/* CM_CLKSEL1_CORE */
+#define OMAP24XX_CLKSEL_USB_SHIFT			25
+#define OMAP24XX_CLKSEL_USB_MASK			(0x7 << 25)
+#define OMAP24XX_CLKSEL_SSI_SHIFT			20
+#define OMAP24XX_CLKSEL_SSI_MASK			(0x1f << 20)
+#define OMAP2420_CLKSEL_VLYNQ_SHIFT			15
+#define OMAP2420_CLKSEL_VLYNQ_MASK			(0x1f << 15)
+#define OMAP24XX_CLKSEL_DSS2_SHIFT			13
+#define OMAP24XX_CLKSEL_DSS2_MASK			(0x1 << 13)
+#define OMAP24XX_CLKSEL_DSS1_SHIFT			8
+#define OMAP24XX_CLKSEL_DSS1_MASK			(0x1f << 8)
+#define OMAP24XX_CLKSEL_L4_SHIFT			5
+#define OMAP24XX_CLKSEL_L4_MASK				(0x3 << 5)
+#define OMAP24XX_CLKSEL_L3_SHIFT			0
+#define OMAP24XX_CLKSEL_L3_MASK				(0x1f << 0)
+
+/* CM_CLKSEL2_CORE */
+#define OMAP24XX_CLKSEL_GPT12_SHIFT			22
+#define OMAP24XX_CLKSEL_GPT12_MASK			(0x3 << 22)
+#define OMAP24XX_CLKSEL_GPT11_SHIFT			20
+#define OMAP24XX_CLKSEL_GPT11_MASK			(0x3 << 20)
+#define OMAP24XX_CLKSEL_GPT10_SHIFT			18
+#define OMAP24XX_CLKSEL_GPT10_MASK			(0x3 << 18)
+#define OMAP24XX_CLKSEL_GPT9_SHIFT			16
+#define OMAP24XX_CLKSEL_GPT9_MASK			(0x3 << 16)
+#define OMAP24XX_CLKSEL_GPT8_SHIFT			14
+#define OMAP24XX_CLKSEL_GPT8_MASK			(0x3 << 14)
+#define OMAP24XX_CLKSEL_GPT7_SHIFT			12
+#define OMAP24XX_CLKSEL_GPT7_MASK			(0x3 << 12)
+#define OMAP24XX_CLKSEL_GPT6_SHIFT			10
+#define OMAP24XX_CLKSEL_GPT6_MASK			(0x3 << 10)
+#define OMAP24XX_CLKSEL_GPT5_SHIFT			8
+#define OMAP24XX_CLKSEL_GPT5_MASK			(0x3 << 8)
+#define OMAP24XX_CLKSEL_GPT4_SHIFT			6
+#define OMAP24XX_CLKSEL_GPT4_MASK			(0x3 << 6)
+#define OMAP24XX_CLKSEL_GPT3_SHIFT			4
+#define OMAP24XX_CLKSEL_GPT3_MASK			(0x3 << 4)
+#define OMAP24XX_CLKSEL_GPT2_SHIFT			2
+#define OMAP24XX_CLKSEL_GPT2_MASK			(0x3 << 2)
+
+/* CM_CLKSTCTRL_CORE */
+#define OMAP24XX_AUTOSTATE_DSS				(1 << 2)
+#define OMAP24XX_AUTOSTATE_L4				(1 << 1)
+#define OMAP24XX_AUTOSTATE_L3				(1 << 0)
+
+/* CM_FCLKEN_GFX */
+#define OMAP24XX_EN_3D_SHIFT				2
+#define OMAP24XX_EN_3D					(1 << 2)
+#define OMAP24XX_EN_2D_SHIFT				1
+#define OMAP24XX_EN_2D					(1 << 1)
+
+/* CM_ICLKEN_GFX specific bits */
+
+/* CM_IDLEST_GFX specific bits */
+
+/* CM_CLKSEL_GFX specific bits */
+
+/* CM_CLKSTCTRL_GFX */
+#define OMAP24XX_AUTOSTATE_GFX				(1 << 0)
+
+/* CM_FCLKEN_WKUP specific bits */
+
+/* CM_ICLKEN_WKUP specific bits */
+#define OMAP2430_EN_ICR_SHIFT				6
+#define OMAP2430_EN_ICR					(1 << 6)
+#define OMAP24XX_EN_OMAPCTRL_SHIFT			5
+#define OMAP24XX_EN_OMAPCTRL				(1 << 5)
+#define OMAP24XX_EN_WDT1_SHIFT				4
+#define OMAP24XX_EN_WDT1				(1 << 4)
+#define OMAP24XX_EN_32KSYNC_SHIFT			1
+#define OMAP24XX_EN_32KSYNC				(1 << 1)
+
+/* CM_IDLEST_WKUP specific bits */
+#define OMAP2430_ST_ICR					(1 << 6)
+#define OMAP24XX_ST_OMAPCTRL				(1 << 5)
+#define OMAP24XX_ST_WDT1				(1 << 4)
+#define OMAP24XX_ST_MPU_WDT				(1 << 3)
+#define OMAP24XX_ST_32KSYNC				(1 << 1)
+
+/* CM_AUTOIDLE_WKUP */
+#define OMAP24XX_AUTO_OMAPCTRL				(1 << 5)
+#define OMAP24XX_AUTO_WDT1				(1 << 4)
+#define OMAP24XX_AUTO_MPU_WDT				(1 << 3)
+#define OMAP24XX_AUTO_GPIOS				(1 << 2)
+#define OMAP24XX_AUTO_32KSYNC				(1 << 1)
+#define OMAP24XX_AUTO_GPT1				(1 << 0)
+
+/* CM_CLKSEL_WKUP */
+#define OMAP24XX_CLKSEL_GPT1_SHIFT			0
+#define OMAP24XX_CLKSEL_GPT1_MASK			(0x3 << 0)
+
+/* CM_CLKEN_PLL */
+#define OMAP24XX_EN_54M_PLL_SHIFT			6
+#define OMAP24XX_EN_54M_PLL_MASK			(0x3 << 6)
+#define OMAP24XX_EN_96M_PLL_SHIFT			2
+#define OMAP24XX_EN_96M_PLL_MASK			(0x3 << 2)
+#define OMAP24XX_EN_DPLL_SHIFT				0
+#define OMAP24XX_EN_DPLL_MASK				(0x3 << 0)
+
+/* CM_IDLEST_CKGEN */
+#define OMAP24XX_ST_54M_APLL				(1 << 9)
+#define OMAP24XX_ST_96M_APLL				(1 << 8)
+#define OMAP24XX_ST_54M_CLK				(1 << 6)
+#define OMAP24XX_ST_12M_CLK				(1 << 5)
+#define OMAP24XX_ST_48M_CLK				(1 << 4)
+#define OMAP24XX_ST_96M_CLK				(1 << 2)
+#define OMAP24XX_ST_CORE_CLK_SHIFT			0
+#define OMAP24XX_ST_CORE_CLK_MASK			(0x3 << 0)
+
+/* CM_AUTOIDLE_PLL */
+#define OMAP24XX_AUTO_54M_SHIFT				6
+#define OMAP24XX_AUTO_54M_MASK				(0x3 << 6)
+#define OMAP24XX_AUTO_96M_SHIFT				2
+#define OMAP24XX_AUTO_96M_MASK				(0x3 << 2)
+#define OMAP24XX_AUTO_DPLL_SHIFT			0
+#define OMAP24XX_AUTO_DPLL_MASK				(0x3 << 0)
+
+/* CM_CLKSEL1_PLL */
+#define OMAP2430_MAXDPLLFASTLOCK_SHIFT			28
+#define OMAP2430_MAXDPLLFASTLOCK_MASK			(0x7 << 28)
+#define OMAP24XX_APLLS_CLKIN_SHIFT			23
+#define OMAP24XX_APLLS_CLKIN_MASK			(0x7 << 23)
+#define OMAP24XX_DPLL_MULT_SHIFT			12
+#define OMAP24XX_DPLL_MULT_MASK				(0x3ff << 12)
+#define OMAP24XX_DPLL_DIV_SHIFT				8
+#define OMAP24XX_DPLL_DIV_MASK				(0xf << 8)
+#define OMAP24XX_54M_SOURCE_SHIFT			5
+#define OMAP24XX_54M_SOURCE				(1 << 5)
+#define OMAP2430_96M_SOURCE_SHIFT			4
+#define OMAP2430_96M_SOURCE				(1 << 4)
+#define OMAP24XX_48M_SOURCE_SHIFT			3
+#define OMAP24XX_48M_SOURCE				(1 << 3)
+#define OMAP2430_ALTCLK_SOURCE_SHIFT			0
+#define OMAP2430_ALTCLK_SOURCE_MASK			(0x7 << 0)
+
+/* CM_CLKSEL2_PLL */
+#define OMAP24XX_CORE_CLK_SRC_SHIFT			0
+#define OMAP24XX_CORE_CLK_SRC_MASK			(0x3 << 0)
+
+/* CM_FCLKEN_DSP */
+#define OMAP2420_EN_IVA_COP_SHIFT			10
+#define OMAP2420_EN_IVA_COP				(1 << 10)
+#define OMAP2420_EN_IVA_MPU_SHIFT			8
+#define OMAP2420_EN_IVA_MPU				(1 << 8)
+#define OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT		0
+#define OMAP24XX_CM_FCLKEN_DSP_EN_DSP			(1 << 0)
+
+/* CM_ICLKEN_DSP */
+#define OMAP2420_EN_DSP_IPI_SHIFT			1
+#define OMAP2420_EN_DSP_IPI				(1 << 1)
+
+/* CM_IDLEST_DSP */
+#define OMAP2420_ST_IVA					(1 << 8)
+#define OMAP2420_ST_IPI					(1 << 1)
+#define OMAP24XX_ST_DSP					(1 << 0)
+
+/* CM_AUTOIDLE_DSP */
+#define OMAP2420_AUTO_DSP_IPI				(1 << 1)
+
+/* CM_CLKSEL_DSP */
+#define OMAP2420_SYNC_IVA				(1 << 13)
+#define OMAP2420_CLKSEL_IVA_SHIFT			8
+#define OMAP2420_CLKSEL_IVA_MASK			(0x1f << 8)
+#define OMAP24XX_SYNC_DSP				(1 << 7)
+#define OMAP24XX_CLKSEL_DSP_IF_SHIFT			5
+#define OMAP24XX_CLKSEL_DSP_IF_MASK			(0x3 << 5)
+#define OMAP24XX_CLKSEL_DSP_SHIFT			0
+#define OMAP24XX_CLKSEL_DSP_MASK			(0x1f << 0)
+
+/* CM_CLKSTCTRL_DSP */
+#define OMAP2420_AUTOSTATE_IVA				(1 << 8)
+#define OMAP24XX_AUTOSTATE_DSP				(1 << 0)
+
+/* CM_FCLKEN_MDM */
+/* 2430 only */
+#define OMAP2430_EN_OSC_SHIFT				1
+#define OMAP2430_EN_OSC					(1 << 1)
+
+/* CM_ICLKEN_MDM */
+/* 2430 only */
+#define OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT		0
+#define OMAP2430_CM_ICLKEN_MDM_EN_MDM			(1 << 0)
+
+/* CM_IDLEST_MDM specific bits */
+/* 2430 only */
+
+/* CM_AUTOIDLE_MDM */
+/* 2430 only */
+#define OMAP2430_AUTO_OSC				(1 << 1)
+#define OMAP2430_AUTO_MDM				(1 << 0)
+
+/* CM_CLKSEL_MDM */
+/* 2430 only */
+#define OMAP2430_SYNC_MDM				(1 << 4)
+#define OMAP2430_CLKSEL_MDM_SHIFT			0
+#define OMAP2430_CLKSEL_MDM_MASK			(0xf << 0)
+
+/* CM_CLKSTCTRL_MDM */
+/* 2430 only */
+#define OMAP2430_AUTOSTATE_MDM				(1 << 0)
+
+#endif
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
new file mode 100644
index 0000000..436e1c5
--- /dev/null
+++ b/arch/arm/mach-omap2/cm.h
@@ -0,0 +1,126 @@
+#ifndef __ARCH_ASM_MACH_OMAP2_CM_H
+#define __ARCH_ASM_MACH_OMAP2_CM_H
+
+/*
+ * OMAP2/3 Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "prcm-common.h"
+
+#ifndef __ASSEMBLER__
+#define OMAP_CM_REGADDR(module, reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
+#else
+#define OMAP2420_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+#define OMAP2430_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+#define OMAP34XX_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+#endif
+
+/*
+ * Architecture-specific global CM registers
+ * Use cm_{read,write}_reg() with these registers.
+ * These registers appear once per CM module.
+ */
+
+#define OMAP3430_CM_REVISION		OMAP_CM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP3430_CM_SYSCONFIG		OMAP_CM_REGADDR(OCP_MOD, 0x0010)
+#define OMAP3430_CM_POLCTRL		OMAP_CM_REGADDR(OCP_MOD, 0x009c)
+
+#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+
+/*
+ * Module specific CM registers from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* Common between 24xx and 34xx */
+
+#define CM_FCLKEN					0x0000
+#define CM_FCLKEN1					CM_FCLKEN
+#define CM_CLKEN					CM_FCLKEN
+#define CM_ICLKEN					0x0010
+#define CM_ICLKEN1					CM_ICLKEN
+#define CM_ICLKEN2					0x0014
+#define CM_ICLKEN3					0x0018
+#define CM_IDLEST					0x0020
+#define CM_IDLEST1					CM_IDLEST
+#define CM_IDLEST2					0x0024
+#define CM_AUTOIDLE					0x0030
+#define CM_AUTOIDLE1					CM_AUTOIDLE
+#define CM_AUTOIDLE2					0x0034
+#define CM_AUTOIDLE3					0x0038
+#define CM_CLKSEL					0x0040
+#define CM_CLKSEL1					CM_CLKSEL
+#define CM_CLKSEL2					0x0044
+#define CM_CLKSTCTRL					0x0048
+
+
+/* Architecture-specific registers */
+
+#define OMAP24XX_CM_FCLKEN2				0x0004
+#define OMAP24XX_CM_ICLKEN4				0x001c
+#define OMAP24XX_CM_AUTOIDLE4				0x003c
+
+#define OMAP2430_CM_IDLEST3				0x0028
+
+#define OMAP3430_CM_CLKEN_PLL				0x0004
+#define OMAP3430ES2_CM_CLKEN2				0x0004
+#define OMAP3430ES2_CM_FCLKEN3				0x0008
+#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
+#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
+#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
+#define OMAP3430_CM_CLKSEL3				CM_CLKSTCTRL
+#define OMAP3430_CM_CLKSTST				0x004c
+#define OMAP3430ES2_CM_CLKSEL4				0x004c
+#define OMAP3430ES2_CM_CLKSEL5				0x0050
+#define OMAP3430_CM_CLKSEL2_EMU				0x0050
+#define OMAP3430_CM_CLKSEL3_EMU				0x0054
+
+
+/* Clock management domain register get/set */
+
+#ifndef __ASSEMBLER__
+static __inline__ void __attribute__((unused)) cm_write_mod_reg(u32 val,
+							s16 module, s16 idx)
+{
+	__raw_writel(val, OMAP_CM_REGADDR(module, idx));
+}
+
+static __inline__ u32 __attribute__((unused)) cm_read_mod_reg(s16 module,
+							s16 idx)
+{
+	return __raw_readl(OMAP_CM_REGADDR(module, idx));
+}
+#endif
+
+/* CM register bits shared between 24XX and 3430 */
+
+/* CM_CLKSEL_GFX */
+#define OMAP_CLKSEL_GFX_SHIFT				0
+#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
+
+/* CM_ICLKEN_GFX */
+#define OMAP_EN_GFX_SHIFT				0
+#define OMAP_EN_GFX					(1 << 0)
+
+/* CM_IDLEST_GFX */
+#define OMAP_ST_GFX					(1 << 0)
+
+
+#endif
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
new file mode 100644
index 0000000..a5d86a4
--- /dev/null
+++ b/arch/arm/mach-omap2/control.c
@@ -0,0 +1,74 @@
+/*
+ * OMAP2/3 System Control Module register access
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
+
+#include <asm/io.h>
+
+#include <asm/arch/control.h>
+
+static u32 omap2_ctrl_base;
+
+#define OMAP_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_ctrl_base \
+								+ (reg))
+
+void omap_ctrl_base_set(u32 base)
+{
+	omap2_ctrl_base = base;
+}
+
+u32 omap_ctrl_base_get(void)
+{
+	return omap2_ctrl_base;
+}
+
+u8 omap_ctrl_readb(u16 offset)
+{
+	return __raw_readb(OMAP_CTRL_REGADDR(offset));
+}
+
+u16 omap_ctrl_readw(u16 offset)
+{
+	return __raw_readw(OMAP_CTRL_REGADDR(offset));
+}
+
+u32 omap_ctrl_readl(u16 offset)
+{
+	return __raw_readl(OMAP_CTRL_REGADDR(offset));
+}
+
+void omap_ctrl_writeb(u8 val, u16 offset)
+{
+	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
+		 (u32)OMAP_CTRL_REGADDR(offset));
+
+	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
+}
+
+void omap_ctrl_writew(u16 val, u16 offset)
+{
+	pr_debug("omap_ctrl_writew: writing 0x%0x to 0x%0x\n", val,
+		 (u32)OMAP_CTRL_REGADDR(offset));
+
+	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
+}
+
+void omap_ctrl_writel(u32 val, u16 offset)
+{
+	pr_debug("omap_ctrl_writel: writing 0x%0x to 0x%0x\n", val,
+		 (u32)OMAP_CTRL_REGADDR(offset));
+
+	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
+}
+
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
new file mode 100644
index 0000000..cacb340
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -0,0 +1,317 @@
+#ifndef __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
+#define __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
+
+/*
+ * OMAP2/3 PRCM base and module definitions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+/* Module offsets from both CM_BASE & PRM_BASE */
+
+/*
+ * Offsets that are the same on 24xx and 34xx
+ *
+ * Technically, in terms of the TRM, OCP_MOD is 34xx only; PLL_MOD is
+ * CCR_MOD on 3430; and GFX_MOD only exists < 3430ES2.
+ */
+#define OCP_MOD						0x000
+#define MPU_MOD						0x100
+#define CORE_MOD					0x200
+#define GFX_MOD						0x300
+#define WKUP_MOD					0x400
+#define PLL_MOD						0x500
+
+
+/* Chip-specific module offsets */
+#define OMAP24XX_DSP_MOD				0x800
+
+#define OMAP2430_MDM_MOD				0xc00
+
+/* IVA2 module is < base on 3430 */
+#define OMAP3430_IVA2_MOD				-0x800
+#define OMAP3430ES2_SGX_MOD				GFX_MOD
+#define OMAP3430_CCR_MOD				PLL_MOD
+#define OMAP3430_DSS_MOD				0x600
+#define OMAP3430_CAM_MOD				0x700
+#define OMAP3430_PER_MOD				0x800
+#define OMAP3430_EMU_MOD				0x900
+#define OMAP3430_GR_MOD					0xa00
+#define OMAP3430_NEON_MOD				0xb00
+#define OMAP3430ES2_USBHOST_MOD				0xc00
+
+
+/* 24XX register bits shared between CM & PRM registers */
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP2420_EN_MMC_SHIFT				26
+#define OMAP2420_EN_MMC					(1 << 26)
+#define OMAP24XX_EN_UART2_SHIFT				22
+#define OMAP24XX_EN_UART2				(1 << 22)
+#define OMAP24XX_EN_UART1_SHIFT				21
+#define OMAP24XX_EN_UART1				(1 << 21)
+#define OMAP24XX_EN_MCSPI2_SHIFT			18
+#define OMAP24XX_EN_MCSPI2				(1 << 18)
+#define OMAP24XX_EN_MCSPI1_SHIFT			17
+#define OMAP24XX_EN_MCSPI1				(1 << 17)
+#define OMAP24XX_EN_MCBSP2_SHIFT			16
+#define OMAP24XX_EN_MCBSP2				(1 << 16)
+#define OMAP24XX_EN_MCBSP1_SHIFT			15
+#define OMAP24XX_EN_MCBSP1				(1 << 15)
+#define OMAP24XX_EN_GPT12_SHIFT				14
+#define OMAP24XX_EN_GPT12				(1 << 14)
+#define OMAP24XX_EN_GPT11_SHIFT				13
+#define OMAP24XX_EN_GPT11				(1 << 13)
+#define OMAP24XX_EN_GPT10_SHIFT				12
+#define OMAP24XX_EN_GPT10				(1 << 12)
+#define OMAP24XX_EN_GPT9_SHIFT				11
+#define OMAP24XX_EN_GPT9				(1 << 11)
+#define OMAP24XX_EN_GPT8_SHIFT				10
+#define OMAP24XX_EN_GPT8				(1 << 10)
+#define OMAP24XX_EN_GPT7_SHIFT				9
+#define OMAP24XX_EN_GPT7				(1 << 9)
+#define OMAP24XX_EN_GPT6_SHIFT				8
+#define OMAP24XX_EN_GPT6				(1 << 8)
+#define OMAP24XX_EN_GPT5_SHIFT				7
+#define OMAP24XX_EN_GPT5				(1 << 7)
+#define OMAP24XX_EN_GPT4_SHIFT				6
+#define OMAP24XX_EN_GPT4				(1 << 6)
+#define OMAP24XX_EN_GPT3_SHIFT				5
+#define OMAP24XX_EN_GPT3				(1 << 5)
+#define OMAP24XX_EN_GPT2_SHIFT				4
+#define OMAP24XX_EN_GPT2				(1 << 4)
+#define OMAP2420_EN_VLYNQ_SHIFT				3
+#define OMAP2420_EN_VLYNQ				(1 << 3)
+
+/* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_GPIO5_SHIFT				10
+#define OMAP2430_EN_GPIO5				(1 << 10)
+#define OMAP2430_EN_MCSPI3_SHIFT			9
+#define OMAP2430_EN_MCSPI3				(1 << 9)
+#define OMAP2430_EN_MMCHS2_SHIFT			8
+#define OMAP2430_EN_MMCHS2				(1 << 8)
+#define OMAP2430_EN_MMCHS1_SHIFT			7
+#define OMAP2430_EN_MMCHS1				(1 << 7)
+#define OMAP24XX_EN_UART3_SHIFT				2
+#define OMAP24XX_EN_UART3				(1 << 2)
+#define OMAP24XX_EN_USB_SHIFT				0
+#define OMAP24XX_EN_USB					(1 << 0)
+
+/* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_MDM_INTC_SHIFT			11
+#define OMAP2430_EN_MDM_INTC				(1 << 11)
+#define OMAP2430_EN_USBHS_SHIFT				6
+#define OMAP2430_EN_USBHS				(1 << 6)
+
+/* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
+#define OMAP2420_ST_MMC					(1 << 26)
+#define OMAP24XX_ST_UART2				(1 << 22)
+#define OMAP24XX_ST_UART1				(1 << 21)
+#define OMAP24XX_ST_MCSPI2				(1 << 18)
+#define OMAP24XX_ST_MCSPI1				(1 << 17)
+#define OMAP24XX_ST_GPT12				(1 << 14)
+#define OMAP24XX_ST_GPT11				(1 << 13)
+#define OMAP24XX_ST_GPT10				(1 << 12)
+#define OMAP24XX_ST_GPT9				(1 << 11)
+#define OMAP24XX_ST_GPT8				(1 << 10)
+#define OMAP24XX_ST_GPT7				(1 << 9)
+#define OMAP24XX_ST_GPT6				(1 << 8)
+#define OMAP24XX_ST_GPT5				(1 << 7)
+#define OMAP24XX_ST_GPT4				(1 << 6)
+#define OMAP24XX_ST_GPT3				(1 << 5)
+#define OMAP24XX_ST_GPT2				(1 << 4)
+#define OMAP2420_ST_VLYNQ				(1 << 3)
+
+/* CM_IDLEST2_CORE, PM_WKST2_CORE shared bits */
+#define OMAP2430_ST_MDM_INTC				(1 << 11)
+#define OMAP2430_ST_GPIO5				(1 << 10)
+#define OMAP2430_ST_MCSPI3				(1 << 9)
+#define OMAP2430_ST_MMCHS2				(1 << 8)
+#define OMAP2430_ST_MMCHS1				(1 << 7)
+#define OMAP2430_ST_USBHS				(1 << 6)
+#define OMAP24XX_ST_UART3				(1 << 2)
+#define OMAP24XX_ST_USB					(1 << 0)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP24XX_EN_GPIOS_SHIFT				2
+#define OMAP24XX_EN_GPIOS				(1 << 2)
+#define OMAP24XX_EN_GPT1_SHIFT				0
+#define OMAP24XX_EN_GPT1				(1 << 0)
+
+/* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
+#define OMAP24XX_ST_GPIOS				(1 << 2)
+#define OMAP24XX_ST_GPT1				(1 << 0)
+
+/* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
+#define OMAP2430_ST_MDM					(1 << 0)
+
+
+/* 3430 register bits shared between CM & PRM registers */
+
+/* CM_REVISION, PRM_REVISION shared bits */
+#define OMAP3430_REV_SHIFT				0
+#define OMAP3430_REV_MASK				(0xff << 0)
+
+/* CM_SYSCONFIG, PRM_SYSCONFIG shared bits */
+#define OMAP3430_AUTOIDLE				(1 << 0)
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_MMC2				(1 << 25)
+#define OMAP3430_EN_MMC2_SHIFT				25
+#define OMAP3430_EN_MMC1				(1 << 24)
+#define OMAP3430_EN_MMC1_SHIFT				24
+#define OMAP3430_EN_MCSPI4				(1 << 21)
+#define OMAP3430_EN_MCSPI4_SHIFT			21
+#define OMAP3430_EN_MCSPI3				(1 << 20)
+#define OMAP3430_EN_MCSPI3_SHIFT			20
+#define OMAP3430_EN_MCSPI2				(1 << 19)
+#define OMAP3430_EN_MCSPI2_SHIFT			19
+#define OMAP3430_EN_MCSPI1				(1 << 18)
+#define OMAP3430_EN_MCSPI1_SHIFT			18
+#define OMAP3430_EN_I2C3				(1 << 17)
+#define OMAP3430_EN_I2C3_SHIFT				17
+#define OMAP3430_EN_I2C2				(1 << 16)
+#define OMAP3430_EN_I2C2_SHIFT				16
+#define OMAP3430_EN_I2C1				(1 << 15)
+#define OMAP3430_EN_I2C1_SHIFT				15
+#define OMAP3430_EN_UART2				(1 << 14)
+#define OMAP3430_EN_UART2_SHIFT				14
+#define OMAP3430_EN_UART1				(1 << 13)
+#define OMAP3430_EN_UART1_SHIFT				13
+#define OMAP3430_EN_GPT11				(1 << 12)
+#define OMAP3430_EN_GPT11_SHIFT				12
+#define OMAP3430_EN_GPT10				(1 << 11)
+#define OMAP3430_EN_GPT10_SHIFT				11
+#define OMAP3430_EN_MCBSP5				(1 << 10)
+#define OMAP3430_EN_MCBSP5_SHIFT			10
+#define OMAP3430_EN_MCBSP1				(1 << 9)
+#define OMAP3430_EN_MCBSP1_SHIFT			9
+#define OMAP3430_EN_FSHOSTUSB				(1 << 5)
+#define OMAP3430_EN_FSHOSTUSB_SHIFT			5
+#define OMAP3430_EN_D2D					(1 << 3)
+#define OMAP3430_EN_D2D_SHIFT				3
+
+/* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_HSOTGUSB				(1 << 4)
+#define OMAP3430_EN_HSOTGUSB_SHIFT				4
+
+/* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
+#define OMAP3430_ST_MMC2				(1 << 25)
+#define OMAP3430_ST_MMC1				(1 << 24)
+#define OMAP3430_ST_MCSPI4				(1 << 21)
+#define OMAP3430_ST_MCSPI3				(1 << 20)
+#define OMAP3430_ST_MCSPI2				(1 << 19)
+#define OMAP3430_ST_MCSPI1				(1 << 18)
+#define OMAP3430_ST_I2C3				(1 << 17)
+#define OMAP3430_ST_I2C2				(1 << 16)
+#define OMAP3430_ST_I2C1				(1 << 15)
+#define OMAP3430_ST_UART2				(1 << 14)
+#define OMAP3430_ST_UART1				(1 << 13)
+#define OMAP3430_ST_GPT11				(1 << 12)
+#define OMAP3430_ST_GPT10				(1 << 11)
+#define OMAP3430_ST_MCBSP5				(1 << 10)
+#define OMAP3430_ST_MCBSP1				(1 << 9)
+#define OMAP3430_ST_FSHOSTUSB				(1 << 5)
+#define OMAP3430_ST_HSOTGUSB				(1 << 4)
+#define OMAP3430_ST_D2D					(1 << 3)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPIO1				(1 << 3)
+#define OMAP3430_EN_GPIO1_SHIFT				3
+#define OMAP3430_EN_GPT1				(1 << 0)
+#define OMAP3430_EN_GPT1_SHIFT				0
+
+/* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_SR2					(1 << 7)
+#define OMAP3430_EN_SR2_SHIFT				7
+#define OMAP3430_EN_SR1					(1 << 6)
+#define OMAP3430_EN_SR1_SHIFT				6
+
+/* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPT12				(1 << 1)
+#define OMAP3430_EN_GPT12_SHIFT				1
+
+/* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
+#define OMAP3430_ST_SR2					(1 << 7)
+#define OMAP3430_ST_SR1					(1 << 6)
+#define OMAP3430_ST_GPIO1				(1 << 3)
+#define OMAP3430_ST_GPT12				(1 << 1)
+#define OMAP3430_ST_GPT1				(1 << 0)
+
+/*
+ * CM_SLEEPDEP_GFX, CM_SLEEPDEP_DSS, CM_SLEEPDEP_CAM,
+ * CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_GFX,
+ * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
+ */
+#define OMAP3430_EN_MPU					(1 << 1)
+#define OMAP3430_EN_MPU_SHIFT				1
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+#define OMAP3430_EN_GPIO6				(1 << 17)
+#define OMAP3430_EN_GPIO6_SHIFT				17
+#define OMAP3430_EN_GPIO5				(1 << 16)
+#define OMAP3430_EN_GPIO5_SHIFT				16
+#define OMAP3430_EN_GPIO4				(1 << 15)
+#define OMAP3430_EN_GPIO4_SHIFT				15
+#define OMAP3430_EN_GPIO3				(1 << 14)
+#define OMAP3430_EN_GPIO3_SHIFT				14
+#define OMAP3430_EN_GPIO2				(1 << 13)
+#define OMAP3430_EN_GPIO2_SHIFT				13
+#define OMAP3430_EN_UART3				(1 << 11)
+#define OMAP3430_EN_UART3_SHIFT				11
+#define OMAP3430_EN_GPT9				(1 << 10)
+#define OMAP3430_EN_GPT9_SHIFT				10
+#define OMAP3430_EN_GPT8				(1 << 9)
+#define OMAP3430_EN_GPT8_SHIFT				9
+#define OMAP3430_EN_GPT7				(1 << 8)
+#define OMAP3430_EN_GPT7_SHIFT				8
+#define OMAP3430_EN_GPT6				(1 << 7)
+#define OMAP3430_EN_GPT6_SHIFT				7
+#define OMAP3430_EN_GPT5				(1 << 6)
+#define OMAP3430_EN_GPT5_SHIFT				6
+#define OMAP3430_EN_GPT4				(1 << 5)
+#define OMAP3430_EN_GPT4_SHIFT				5
+#define OMAP3430_EN_GPT3				(1 << 4)
+#define OMAP3430_EN_GPT3_SHIFT				4
+#define OMAP3430_EN_GPT2				(1 << 3)
+#define OMAP3430_EN_GPT2_SHIFT				3
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
+/* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
+ * be ST_* bits instead? */
+#define OMAP3430_EN_MCBSP4				(1 << 2)
+#define OMAP3430_EN_MCBSP4_SHIFT			2
+#define OMAP3430_EN_MCBSP3				(1 << 1)
+#define OMAP3430_EN_MCBSP3_SHIFT			1
+#define OMAP3430_EN_MCBSP2				(1 << 0)
+#define OMAP3430_EN_MCBSP2_SHIFT			0
+
+/* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3430_ST_GPIO6				(1 << 17)
+#define OMAP3430_ST_GPIO5				(1 << 16)
+#define OMAP3430_ST_GPIO4				(1 << 15)
+#define OMAP3430_ST_GPIO3				(1 << 14)
+#define OMAP3430_ST_GPIO2				(1 << 13)
+#define OMAP3430_ST_UART3				(1 << 11)
+#define OMAP3430_ST_GPT9				(1 << 10)
+#define OMAP3430_ST_GPT8				(1 << 9)
+#define OMAP3430_ST_GPT7				(1 << 8)
+#define OMAP3430_ST_GPT6				(1 << 7)
+#define OMAP3430_ST_GPT5				(1 << 6)
+#define OMAP3430_ST_GPT4				(1 << 5)
+#define OMAP3430_ST_GPT3				(1 << 4)
+#define OMAP3430_ST_GPT2				(1 << 3)
+
+/* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared bits */
+#define OMAP3430_EN_CORE				(1 << 0)
+
+#endif
+
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
new file mode 100644
index 0000000..c6d17a3
--- /dev/null
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -0,0 +1,279 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
+
+/*
+ * OMAP24XX Power/Reset Management register bits
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
+
+#include "prm.h"
+
+/* Bits shared between registers */
+
+/* PRCM_IRQSTATUS_MPU, PM_IRQSTATUS_DSP, PRCM_IRQSTATUS_IVA shared bits */
+#define OMAP24XX_VOLTTRANS_ST				(1 << 2)
+#define OMAP24XX_WKUP2_ST				(1 << 1)
+#define OMAP24XX_WKUP1_ST				(1 << 0)
+
+/* PRCM_IRQENABLE_MPU, PM_IRQENABLE_DSP, PRCM_IRQENABLE_IVA shared bits */
+#define OMAP24XX_VOLTTRANS_EN				(1 << 2)
+#define OMAP24XX_WKUP2_EN				(1 << 1)
+#define OMAP24XX_WKUP1_EN				(1 << 0)
+
+/* PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_DSP, PM_WKDEP_MDM shared bits */
+#define OMAP24XX_EN_MPU					(1 << 1)
+#define OMAP24XX_EN_CORE				(1 << 0)
+
+/*
+ * PM_PWSTCTRL_MPU, PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM
+ * shared bits
+ */
+#define OMAP24XX_MEMONSTATE_SHIFT			10
+#define OMAP24XX_MEMONSTATE_MASK			(0x3 << 10)
+#define OMAP24XX_MEMRETSTATE				(1 << 3)
+
+/* PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM shared bits */
+#define OMAP24XX_FORCESTATE				(1 << 18)
+
+/*
+ * PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP,
+ * PM_PWSTST_MDM shared bits
+ */
+#define OMAP24XX_CLKACTIVITY				(1 << 19)
+
+/* PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_DSP shared bits */
+#define OMAP24XX_LASTSTATEENTERED_SHIFT			4
+#define OMAP24XX_LASTSTATEENTERED_MASK			(0x3 << 4)
+
+/* PM_PWSTST_MPU and PM_PWSTST_DSP shared bits */
+#define OMAP2430_MEMSTATEST_SHIFT			10
+#define OMAP2430_MEMSTATEST_MASK			(0x3 << 10)
+
+/* PM_PWSTST_GFX, PM_PWSTST_DSP, PM_PWSTST_MDM shared bits */
+#define OMAP24XX_POWERSTATEST_SHIFT			0
+#define OMAP24XX_POWERSTATEST_MASK			(0x3 << 0)
+
+
+/* Bits specific to each register */
+
+/* PRCM_REVISION */
+#define OMAP24XX_REV_SHIFT				0
+#define OMAP24XX_REV_MASK				(0xff << 0)
+
+/* PRCM_SYSCONFIG */
+#define OMAP24XX_AUTOIDLE				(1 << 0)
+
+/* PRCM_IRQSTATUS_MPU specific bits */
+#define OMAP2430_DPLL_RECAL_ST				(1 << 6)
+#define OMAP24XX_TRANSITION_ST				(1 << 5)
+#define OMAP24XX_EVGENOFF_ST				(1 << 4)
+#define OMAP24XX_EVGENON_ST				(1 << 3)
+
+/* PRCM_IRQENABLE_MPU specific bits */
+#define OMAP2430_DPLL_RECAL_EN				(1 << 6)
+#define OMAP24XX_TRANSITION_EN				(1 << 5)
+#define OMAP24XX_EVGENOFF_EN				(1 << 4)
+#define OMAP24XX_EVGENON_EN				(1 << 3)
+
+/* PRCM_VOLTCTRL */
+#define OMAP24XX_AUTO_EXTVOLT				(1 << 15)
+#define OMAP24XX_FORCE_EXTVOLT				(1 << 14)
+#define OMAP24XX_SETOFF_LEVEL_SHIFT			12
+#define OMAP24XX_SETOFF_LEVEL_MASK			(0x3 << 12)
+#define OMAP24XX_MEMRETCTRL				(1 << 8)
+#define OMAP24XX_SETRET_LEVEL_SHIFT			6
+#define OMAP24XX_SETRET_LEVEL_MASK			(0x3 << 6)
+#define OMAP24XX_VOLT_LEVEL_SHIFT			0
+#define OMAP24XX_VOLT_LEVEL_MASK			(0x3 << 0)
+
+/* PRCM_VOLTST */
+#define OMAP24XX_ST_VOLTLEVEL_SHIFT			0
+#define OMAP24XX_ST_VOLTLEVEL_MASK			(0x3 << 0)
+
+/* PRCM_CLKSRC_CTRL specific bits */
+
+/* PRCM_CLKOUT_CTRL */
+#define OMAP2420_CLKOUT2_EN_SHIFT			15
+#define OMAP2420_CLKOUT2_EN				(1 << 15)
+#define OMAP2420_CLKOUT2_DIV_SHIFT			11
+#define OMAP2420_CLKOUT2_DIV_MASK			(0x7 << 11)
+#define OMAP2420_CLKOUT2_SOURCE_SHIFT			8
+#define OMAP2420_CLKOUT2_SOURCE_MASK			(0x3 << 8)
+#define OMAP24XX_CLKOUT_EN_SHIFT			7
+#define OMAP24XX_CLKOUT_EN				(1 << 7)
+#define OMAP24XX_CLKOUT_DIV_SHIFT			3
+#define OMAP24XX_CLKOUT_DIV_MASK			(0x7 << 3)
+#define OMAP24XX_CLKOUT_SOURCE_SHIFT			0
+#define OMAP24XX_CLKOUT_SOURCE_MASK			(0x3 << 0)
+
+/* PRCM_CLKEMUL_CTRL */
+#define OMAP24XX_EMULATION_EN_SHIFT			0
+#define OMAP24XX_EMULATION_EN				(1 << 0)
+
+/* PRCM_CLKCFG_CTRL */
+#define OMAP24XX_VALID_CONFIG				(1 << 0)
+
+/* PRCM_CLKCFG_STATUS */
+#define OMAP24XX_CONFIG_STATUS				(1 << 0)
+
+/* PRCM_VOLTSETUP specific bits */
+
+/* PRCM_CLKSSETUP specific bits */
+
+/* PRCM_POLCTRL */
+#define OMAP2420_CLKOUT2_POL				(1 << 10)
+#define OMAP24XX_CLKOUT_POL				(1 << 9)
+#define OMAP24XX_CLKREQ_POL				(1 << 8)
+#define OMAP2430_USE_POWEROK				(1 << 2)
+#define OMAP2430_POWEROK_POL				(1 << 1)
+#define OMAP24XX_EXTVOL_POL				(1 << 0)
+
+/* RM_RSTST_MPU specific bits */
+/* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" instead */
+
+/* PM_WKDEP_MPU specific bits */
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM			(1 << 5)
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP			(1 << 2)
+
+/* PM_EVGENCTRL_MPU specific bits */
+
+/* PM_EVEGENONTIM_MPU specific bits */
+
+/* PM_EVEGENOFFTIM_MPU specific bits */
+
+/* PM_PWSTCTRL_MPU specific bits */
+#define OMAP2430_FORCESTATE				(1 << 18)
+
+/* PM_PWSTST_MPU specific bits */
+/* INTRANSITION, CLKACTIVITY, POWERSTATE, MEMSTATEST are 2430 only */
+
+/* PM_WKEN1_CORE specific bits */
+
+/* PM_WKEN2_CORE specific bits */
+
+/* PM_WKST1_CORE specific bits*/
+
+/* PM_WKST2_CORE specific bits */
+
+/* PM_WKDEP_CORE specific bits*/
+#define OMAP2430_PM_WKDEP_CORE_EN_MDM			(1 << 5)
+#define OMAP24XX_PM_WKDEP_CORE_EN_GFX			(1 << 3)
+#define OMAP24XX_PM_WKDEP_CORE_EN_DSP			(1 << 2)
+
+/* PM_PWSTCTRL_CORE specific bits */
+#define OMAP24XX_MEMORYCHANGE				(1 << 20)
+#define OMAP24XX_MEM3ONSTATE_SHIFT			14
+#define OMAP24XX_MEM3ONSTATE_MASK			(0x3 << 14)
+#define OMAP24XX_MEM2ONSTATE_SHIFT			12
+#define OMAP24XX_MEM2ONSTATE_MASK			(0x3 << 12)
+#define OMAP24XX_MEM1ONSTATE_SHIFT			10
+#define OMAP24XX_MEM1ONSTATE_MASK			(0x3 << 10)
+#define OMAP24XX_MEM3RETSTATE				(1 << 5)
+#define OMAP24XX_MEM2RETSTATE				(1 << 4)
+#define OMAP24XX_MEM1RETSTATE				(1 << 3)
+
+/* PM_PWSTST_CORE specific bits */
+#define OMAP24XX_MEM3STATEST_SHIFT			14
+#define OMAP24XX_MEM3STATEST_MASK			(0x3 << 14)
+#define OMAP24XX_MEM2STATEST_SHIFT			12
+#define OMAP24XX_MEM2STATEST_MASK			(0x3 << 12)
+#define OMAP24XX_MEM1STATEST_SHIFT			10
+#define OMAP24XX_MEM1STATEST_MASK			(0x3 << 10)
+
+/* RM_RSTCTRL_GFX */
+#define OMAP24XX_GFX_RST				(1 << 0)
+
+/* RM_RSTST_GFX specific bits */
+#define OMAP24XX_GFX_SW_RST				(1 << 4)
+
+/* PM_PWSTCTRL_GFX specific bits */
+
+/* PM_WKDEP_GFX specific bits */
+/* 2430 often calls EN_WAKEUP "EN_WKUP" */
+
+/* RM_RSTCTRL_WKUP specific bits */
+
+/* RM_RSTTIME_WKUP specific bits */
+
+/* RM_RSTST_WKUP specific bits */
+/* 2430 calls EXTWMPU_RST "EXTWARM_RST" and GLOBALWMPU_RST "GLOBALWARM_RST" */
+#define OMAP24XX_EXTWMPU_RST				(1 << 6)
+#define OMAP24XX_SECU_WD_RST				(1 << 5)
+#define OMAP24XX_MPU_WD_RST				(1 << 4)
+#define OMAP24XX_SECU_VIOL_RST				(1 << 3)
+
+/* PM_WKEN_WKUP specific bits */
+
+/* PM_WKST_WKUP specific bits */
+
+/* RM_RSTCTRL_DSP */
+#define OMAP2420_RST_IVA				(1 << 8)
+#define OMAP24XX_RST2_DSP				(1 << 1)
+#define OMAP24XX_RST1_DSP				(1 << 0)
+
+/* RM_RSTST_DSP specific bits */
+/* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" */
+#define OMAP2420_IVA_SW_RST				(1 << 8)
+#define OMAP24XX_DSP_SW_RST2				(1 << 5)
+#define OMAP24XX_DSP_SW_RST1				(1 << 4)
+
+/* PM_WKDEP_DSP specific bits */
+
+/* PM_PWSTCTRL_DSP specific bits */
+/* 2430 only: MEMONSTATE, MEMRETSTATE */
+#define OMAP2420_MEMIONSTATE_SHIFT			12
+#define OMAP2420_MEMIONSTATE_MASK			(0x3 << 12)
+#define OMAP2420_MEMIRETSTATE				(1 << 4)
+
+/* PM_PWSTST_DSP specific bits */
+/* MEMSTATEST is 2430 only */
+#define OMAP2420_MEMISTATEST_SHIFT			12
+#define OMAP2420_MEMISTATEST_MASK			(0x3 << 12)
+
+/* PRCM_IRQSTATUS_DSP specific bits */
+
+/* PRCM_IRQENABLE_DSP specific bits */
+
+/* RM_RSTCTRL_MDM */
+/* 2430 only */
+#define OMAP2430_PWRON1_MDM				(1 << 1)
+#define OMAP2430_RST1_MDM				(1 << 0)
+
+/* RM_RSTST_MDM specific bits */
+/* 2430 only */
+#define OMAP2430_MDM_SECU_VIOL				(1 << 6)
+#define OMAP2430_MDM_SW_PWRON1				(1 << 5)
+#define OMAP2430_MDM_SW_RST1				(1 << 4)
+
+/* PM_WKEN_MDM */
+/* 2430 only */
+#define OMAP2430_PM_WKEN_MDM_EN_MDM			(1 << 0)
+
+/* PM_WKST_MDM specific bits */
+/* 2430 only */
+
+/* PM_WKDEP_MDM specific bits */
+/* 2430 only */
+
+/* PM_PWSTCTRL_MDM specific bits */
+/* 2430 only */
+#define OMAP2430_KILLDOMAINWKUP				(1 << 19)
+
+/* PM_PWSTST_MDM specific bits */
+/* 2430 only */
+
+/* PRCM_IRQSTATUS_IVA */
+/* 2420 only */
+
+/* PRCM_IRQENABLE_IVA */
+/* 2420 only */
+
+#endif
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
new file mode 100644
index 0000000..80c5260
--- /dev/null
+++ b/arch/arm/mach-omap2/prm.h
@@ -0,0 +1,318 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_H
+
+/*
+ * OMAP2/3 Power/Reset Management (PRM) register definitions
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
+
+#include "prcm-common.h"
+
+#ifndef __ASSEMBLER__
+#define OMAP_PRM_REGADDR(module, reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
+#else
+#define OMAP2420_PRM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+#define OMAP2430_PRM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+#define OMAP34XX_PRM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+#endif
+
+/*
+ * Architecture-specific global PRM registers
+ * Use prm_{read,write}_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
+ * IRQSTATUS and IRQENABLE bits.)
+ *
+ */
+
+#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP24XX_PRCM_VOLTCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP24XX_PRCM_VOLTST		OMAP_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP24XX_PRCM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP24XX_PRCM_CLKCFG_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP24XX_PRCM_CLKCFG_STATUS	OMAP_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP24XX_PRCM_VOLTSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP24XX_PRCM_CLKSSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP24XX_PRCM_POLCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0098)
+
+#define OMAP3430_PRM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP3430_PRM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
+
+
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
+#define OMAP3430_PRM_VC_CH_CONF		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
+#define OMAP3430_PRM_RSTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
+#define OMAP3430_PRM_RSTTIME		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
+#define OMAP3430_PRM_RSTST		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define OMAP3430_PRM_VOLTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+#define OMAP3430_PRM_VOLTSETUP1		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
+#define OMAP3430_PRM_VOLTOFFSET		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
+#define OMAP3430_PRM_CLKSETUP		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
+#define OMAP3430_PRM_POLCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
+#define OMAP3430_PRM_VOLTSETUP2		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
+#define OMAP3430_PRM_VP1_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
+#define OMAP3430_PRM_VP1_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
+#define OMAP3430_PRM_VP2_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
+#define OMAP3430_PRM_VP2_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+
+#define OMAP3430_PRM_CLKSEL		OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+
+/*
+ * Module specific PRM registers from PRM_BASE + domain offset
+ *
+ * Use prm_{read,write}_mod_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * {PM,RM}_* on both architectures.  (The exceptions are the IRQSTATUS
+ * and IRQENABLE bits.)
+ *
+ */
+
+/* Registers appearing on both 24xx and 34xx */
+
+#define RM_RSTCTRL					0x0050
+#define RM_RSTTIME					0x0054
+#define RM_RSTST					0x0058
+
+#define PM_WKEN						0x00a0
+#define PM_WKEN1					PM_WKEN
+#define PM_WKST						0x00b0
+#define PM_WKST1					PM_WKST
+#define PM_WKDEP					0x00c8
+#define PM_EVGENCTRL					0x00d4
+#define PM_EVGENONTIM					0x00d8
+#define PM_EVGENOFFTIM					0x00dc
+#define PM_PWSTCTRL					0x00e0
+#define PM_PWSTST					0x00e4
+
+#define OMAP3430_PM_MPUGRPSEL				0x00a4
+#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+
+#define OMAP3430_PM_IVAGRPSEL				0x00a8
+#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+
+#define OMAP3430_PM_PREPWSTST				0x00e8
+
+#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
+#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
+
+
+/* Architecture-specific registers */
+
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+#ifndef __ASSEMBLER__
+
+/* Power/reset management domain register get/set */
+
+static __inline__ void __attribute__((unused)) prm_write_mod_reg(u32 val,
+							s16 module, s16 idx)
+{
+	__raw_writel(val, OMAP_PRM_REGADDR(module, idx));
+}
+
+static __inline__ u32 __attribute__((unused)) prm_read_mod_reg(s16 module,
+							s16 idx)
+{
+	return __raw_readl(OMAP_PRM_REGADDR(module, idx));
+}
+
+#endif
+
+/*
+ * Bits common to specific registers
+ *
+ * The 3430 register and bit names are generally used,
+ * since they tend to make more sense
+ */
+
+/* PM_EVGENONTIM_MPU */
+/* Named PM_EVEGENONTIM_MPU on the 24XX */
+#define OMAP_ONTIMEVAL_SHIFT				0
+#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PM_EVGENOFFTIM_MPU */
+/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
+#define OMAP_OFFTIMEVAL_SHIFT				0
+#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PRM_CLKSETUP and PRCM_VOLTSETUP */
+/* Named PRCM_CLKSSETUP on the 24XX */
+#define OMAP_SETUP_TIME_SHIFT				0
+#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
+
+/* PRM_CLKSRC_CTRL */
+/* Named PRCM_CLKSRC_CTRL on the 24XX */
+#define OMAP_SYSCLKDIV_SHIFT				6
+#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
+#define OMAP_AUTOEXTCLKMODE_SHIFT			3
+#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
+#define OMAP_SYSCLKSEL_SHIFT				0
+#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
+
+/* PM_EVGENCTRL_MPU */
+#define OMAP_OFFLOADMODE_SHIFT				3
+#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
+#define OMAP_ONLOADMODE_SHIFT				1
+#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
+#define OMAP_ENABLE					(1 << 0)
+
+/* PRM_RSTTIME */
+/* Named RM_RSTTIME_WKUP on the 24xx */
+#define OMAP_RSTTIME2_SHIFT				8
+#define OMAP_RSTTIME2_MASK				(0x1f << 8)
+#define OMAP_RSTTIME1_SHIFT				0
+#define OMAP_RSTTIME1_MASK				(0xff << 0)
+
+
+/* PRM_RSTCTRL */
+/* Named RM_RSTCTRL_WKUP on the 24xx */
+/* 2420 calls RST_DPLL3 'RST_DPLL' */
+#define OMAP_RST_DPLL3					(1 << 2)
+#define OMAP_RST_GS					(1 << 1)
+
+
+/*
+ * Bits common to module-shared registers
+ *
+ * Not all registers of a particular type support all of these bits -
+ * check TRM if you are unsure
+ */
+
+/*
+ * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_INTRANSITION				(1 << 20)
+
+
+/*
+ * 24XX: PM_PWSTST_GFX, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_POWERSTATEST_SHIFT				0
+#define OMAP_POWERSTATEST_MASK				(0x3 << 0)
+
+/*
+ * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
+ *	 called 'COREWKUP_RST'
+ *
+ * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
+ *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
+ */
+#define OMAP_COREDOMAINWKUP_RST				(1 << 3)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_DOMAINWKUP_RST				(1 << 2)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
+ *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_GLOBALWARM_RST				(1 << 1)
+#define OMAP_GLOBALCOLD_RST				(1 << 0)
+
+/*
+ * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
+ *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
+ *
+ * 2430: PM_WKDEP_MDM
+ *
+ * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
+ *	 PM_WKDEP_PER
+ */
+#define OMAP_EN_WKUP					(1 << 4)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSP
+ *
+ * 2430: PM_PWSTCTRL_MDM
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON
+ */
+#define OMAP_LOGICRETSTATE				(1 << 2)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *       PM_PWSTCTRL_DSP, PM_PWSTST_MPU
+ *
+ * 2430: PM_PWSTCTRL_MDM shared bits
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE,
+ *	 PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON shared bits
+ */
+#define OMAP_POWERSTATE_SHIFT				0
+#define OMAP_POWERSTATE_MASK				(0x3 << 0)
+
+
+#endif
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
new file mode 100644
index 0000000..5b912f8
--- /dev/null
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -0,0 +1,58 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_SDRC_H
+#define __ARCH_ARM_MACH_OMAP2_SDRC_H
+
+/*
+ * OMAP2 SDRC register definitions
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
+#include <asm/arch/sdrc.h>
+
+#ifndef __ASSEMBLER__
+extern unsigned long omap2_sdrc_base;
+extern unsigned long omap2_sms_base;
+
+#define OMAP_SDRC_REGADDR(reg)						\
+		(void __iomem *)IO_ADDRESS(omap2_sdrc_base + (reg))
+#define OMAP_SMS_REGADDR(reg)						\
+		(void __iomem *)IO_ADDRESS(omap2_sms_base + (reg))
+
+/* SDRC global register get/set */
+
+static __inline__ void __attribute__((unused)) sdrc_write_reg(u32 val, u16 reg)
+{
+	__raw_writel(val, OMAP_SDRC_REGADDR(reg));
+}
+
+static __inline__ u32 __attribute__((unused)) sdrc_read_reg(u16 reg)
+{
+	return __raw_readl(OMAP_SDRC_REGADDR(reg));
+}
+
+/* SMS global register get/set */
+
+static __inline__ void __attribute__((unused)) sms_write_reg(u32 val, u16 reg)
+{
+	__raw_writel(val, OMAP_SMS_REGADDR(reg));
+}
+
+static __inline__ u32 __attribute__((unused)) sms_read_reg(u16 reg)
+{
+	return __raw_readl(OMAP_SMS_REGADDR(reg));
+}
+#else
+#define OMAP242X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
+#define OMAP243X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
+#define OMAP34XX_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
+#endif	/* __ASSEMBLER__ */
+
+#endif
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index a5aedf9..a619475 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -33,6 +33,7 @@
 #include <asm/system.h>
 #include <asm/hardware.h>
 
+#include <asm/arch/control.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/board.h>
@@ -76,7 +77,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef	CONFIG_ARCH_OMAP_OTG
+#if	defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_USB_MUSB_OTG)
 
 static struct otg_transceiver *xceiv;
 
@@ -110,12 +111,48 @@ EXPORT_SYMBOL(otg_set_transceiver);
 
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP15XX)
 
+static void omap2_usb_devconf_clear(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r &= ~USBTXWRMODEI(port, mask);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb_devconf_set(u8 port, u32 mask)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(port, mask);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_disable_5pinbitll(void)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r &= ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void omap2_usb2_enable_5pinunitll(void)
+{
+	u32 r;
+
+	r = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	r |= USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
+	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
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
@@ -187,19 +224,19 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
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
@@ -220,7 +257,7 @@ static u32 __init omap_usb1_init(unsigned nwires)
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB1_UNI_R;
 	if (cpu_is_omap24xx())
-		CONTROL_DEVCONF_REG &= ~USBT1WRMODEI(USB_BIDIR_TLL);
+		omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
 
 	if (nwires == 0)
 		return 0;
@@ -261,17 +298,17 @@ static u32 __init omap_usb1_init(unsigned nwires)
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
@@ -295,8 +332,7 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 	u32	syscon1 = 0;
 
 	if (cpu_is_omap24xx()) {
-		CONTROL_DEVCONF_REG &= ~(USBT2WRMODEI(USB_BIDIR_TLL)
-					| USBT2TLL5PI);
+		omap2_usb2_disable_5pinbitll();
 		alt_pingroup = 0;
 	}
 
@@ -343,17 +379,17 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
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
@@ -364,8 +400,7 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
 		 */
 		syscon1 = 3;
-		CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_UNIDIR_TLL)
-					| USBT2TLL5PI;
+		omap2_usb2_enable_5pinunitll();
 		break;
 	case 6:
 		if (cpu_is_omap24xx())
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
new file mode 100644
index 0000000..9944bb5
--- /dev/null
+++ b/include/asm-arm/arch-omap/control.h
@@ -0,0 +1,191 @@
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
+#define OMAP242X_CTRL_REGADDR(reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+
+/*
+ * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
+ * OMAP24XX and OMAP34XX.
+ */
+
+/* Control submodule offsets */
+
+#define OMAP2_CONTROL_INTERFACE		0x000
+#define OMAP2_CONTROL_PADCONFS		0x030
+#define OMAP2_CONTROL_GENERAL		0x270
+#define OMAP343X_CONTROL_MEM_WKUP	0x600
+#define OMAP343X_CONTROL_PADCONFS_WKUP	0xa00
+#define OMAP343X_CONTROL_GENERAL_WKUP	0xa60
+
+/* Control register offsets - read/write with omap_ctrl_{read,write}{bwl}() */
+
+#define OMAP2_CONTROL_SYSCONFIG		(OMAP2_CONTROL_INTERFACE + 0x10)
+
+/* CONTROL_GENERAL register offsets common to OMAP2 & 3 */
+#define OMAP2_CONTROL_DEVCONF0		(OMAP2_CONTROL_GENERAL + 0x0004)
+#define OMAP2_CONTROL_MSUSPENDMUX_0	(OMAP2_CONTROL_GENERAL + 0x0020)
+#define OMAP2_CONTROL_MSUSPENDMUX_1	(OMAP2_CONTROL_GENERAL + 0x0024)
+#define OMAP2_CONTROL_MSUSPENDMUX_2	(OMAP2_CONTROL_GENERAL + 0x0028)
+#define OMAP2_CONTROL_MSUSPENDMUX_3	(OMAP2_CONTROL_GENERAL + 0x002c)
+#define OMAP2_CONTROL_MSUSPENDMUX_4	(OMAP2_CONTROL_GENERAL + 0x0030)
+#define OMAP2_CONTROL_MSUSPENDMUX_5	(OMAP2_CONTROL_GENERAL + 0x0034)
+#define OMAP2_CONTROL_SEC_CTRL		(OMAP2_CONTROL_GENERAL + 0x0040)
+#define OMAP2_CONTROL_RPUB_KEY_H_0	(OMAP2_CONTROL_GENERAL + 0x0090)
+#define OMAP2_CONTROL_RPUB_KEY_H_1	(OMAP2_CONTROL_GENERAL + 0x0094)
+#define OMAP2_CONTROL_RPUB_KEY_H_2	(OMAP2_CONTROL_GENERAL + 0x0098)
+#define OMAP2_CONTROL_RPUB_KEY_H_3	(OMAP2_CONTROL_GENERAL + 0x009c)
+
+/* 242x-only CONTROL_GENERAL register offsets */
+#define OMAP242X_CONTROL_DEVCONF	OMAP2_CONTROL_DEVCONF0 /* match TRM */
+#define OMAP242X_CONTROL_OCM_RAM_PERM	(OMAP2_CONTROL_GENERAL + 0x0068)
+
+/* 243x-only CONTROL_GENERAL register offsets */
+/* CONTROL_IVA2_BOOT{ADDR,MOD} are at the same place on 343x - noted below */
+#define OMAP243X_CONTROL_DEVCONF1	(OMAP2_CONTROL_GENERAL + 0x0078)
+#define OMAP243X_CONTROL_CSIRXFE	(OMAP2_CONTROL_GENERAL + 0x007c)
+#define OMAP243X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP243X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP243X_CONTROL_IVA2_GEMCFG	(OMAP2_CONTROL_GENERAL + 0x0198)
+
+/* 24xx-only CONTROL_GENERAL register offsets */
+#define OMAP24XX_CONTROL_DEBOBS		(OMAP2_CONTROL_GENERAL + 0x0000)
+#define OMAP24XX_CONTROL_EMU_SUPPORT	(OMAP2_CONTROL_GENERAL + 0x0008)
+#define OMAP24XX_CONTROL_SEC_TEST	(OMAP2_CONTROL_GENERAL + 0x0044)
+#define OMAP24XX_CONTROL_PSA_CTRL	(OMAP2_CONTROL_GENERAL + 0x0048)
+#define OMAP24XX_CONTROL_PSA_CMD	(OMAP2_CONTROL_GENERAL + 0x004c)
+#define OMAP24XX_CONTROL_PSA_VALUE	(OMAP2_CONTROL_GENERAL + 0x0050)
+#define OMAP24XX_CONTROL_SEC_EMU	(OMAP2_CONTROL_GENERAL + 0x0060)
+#define OMAP24XX_CONTROL_SEC_TAP	(OMAP2_CONTROL_GENERAL + 0x0064)
+#define OMAP24XX_CONTROL_OCM_PUB_RAM_ADD	(OMAP2_CONTROL_GENERAL + 0x006c)
+#define OMAP24XX_CONTROL_EXT_SEC_RAM_START_ADD	(OMAP2_CONTROL_GENERAL + 0x0070)
+#define OMAP24XX_CONTROL_EXT_SEC_RAM_STOP_ADD	(OMAP2_CONTROL_GENERAL + 0x0074
+#define OMAP24XX_CONTROL_SEC_STATUS		(OMAP2_CONTROL_GENERAL + 0x0080)
+#define OMAP24XX_CONTROL_SEC_ERR_STATUS		(OMAP2_CONTROL_GENERAL + 0x0084)
+#define OMAP24XX_CONTROL_STATUS			(OMAP2_CONTROL_GENERAL + 0x0088)
+#define OMAP24XX_CONTROL_GENERAL_PURPOSE_STATUS	(OMAP2_CONTROL_GENERAL + 0x008c)
+#define OMAP24XX_CONTROL_RAND_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00a0)
+#define OMAP24XX_CONTROL_RAND_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00a4)
+#define OMAP24XX_CONTROL_RAND_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00a8)
+#define OMAP24XX_CONTROL_RAND_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00ac)
+#define OMAP24XX_CONTROL_CUST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00b0)
+#define OMAP24XX_CONTROL_CUST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00b4)
+#define OMAP24XX_CONTROL_TEST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00c0)
+#define OMAP24XX_CONTROL_TEST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00c4)
+#define OMAP24XX_CONTROL_TEST_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00c8)
+#define OMAP24XX_CONTROL_TEST_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00cc)
+#define OMAP24XX_CONTROL_TEST_KEY_4	(OMAP2_CONTROL_GENERAL + 0x00d0)
+#define OMAP24XX_CONTROL_TEST_KEY_5	(OMAP2_CONTROL_GENERAL + 0x00d4)
+#define OMAP24XX_CONTROL_TEST_KEY_6	(OMAP2_CONTROL_GENERAL + 0x00d8)
+#define OMAP24XX_CONTROL_TEST_KEY_7	(OMAP2_CONTROL_GENERAL + 0x00dc)
+#define OMAP24XX_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e0)
+#define OMAP24XX_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00e4)
+
+/* 34xx-only CONTROL_GENERAL register offsets */
+#define OMAP343X_CONTROL_PADCONF_OFF	(OMAP2_CONTROL_GENERAL + 0x0000)
+#define OMAP343X_CONTROL_MEM_DFTRW0	(OMAP2_CONTROL_GENERAL + 0x0008)
+#define OMAP343X_CONTROL_MEM_DFTRW1	(OMAP2_CONTROL_GENERAL + 0x000c)
+#define OMAP343X_CONTROL_DEVCONF1	(OMAP2_CONTROL_GENERAL + 0x0068)
+#define OMAP343X_CONTROL_CSIRXFE		(OMAP2_CONTROL_GENERAL + 0x006c)
+#define OMAP343X_CONTROL_SEC_STATUS		(OMAP2_CONTROL_GENERAL + 0x0070)
+#define OMAP343X_CONTROL_SEC_ERR_STATUS		(OMAP2_CONTROL_GENERAL + 0x0074)
+#define OMAP343X_CONTROL_SEC_ERR_STATUS_DEBUG	(OMAP2_CONTROL_GENERAL + 0x0078)
+#define OMAP343X_CONTROL_STATUS			(OMAP2_CONTROL_GENERAL + 0x0080)
+#define OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS	(OMAP2_CONTROL_GENERAL + 0x0084)
+#define OMAP343X_CONTROL_RPUB_KEY_H_4	(OMAP2_CONTROL_GENERAL + 0x00a0)
+#define OMAP343X_CONTROL_RAND_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00a8)
+#define OMAP343X_CONTROL_RAND_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00ac)
+#define OMAP343X_CONTROL_RAND_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00b0)
+#define OMAP343X_CONTROL_RAND_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00b4)
+#define OMAP343X_CONTROL_TEST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00c8)
+#define OMAP343X_CONTROL_TEST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00cc)
+#define OMAP343X_CONTROL_TEST_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00d0)
+#define OMAP343X_CONTROL_TEST_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00d4)
+#define OMAP343X_CONTROL_TEST_KEY_4	(OMAP2_CONTROL_GENERAL + 0x00d8)
+#define OMAP343X_CONTROL_TEST_KEY_5	(OMAP2_CONTROL_GENERAL + 0x00dc)
+#define OMAP343X_CONTROL_TEST_KEY_6	(OMAP2_CONTROL_GENERAL + 0x00e0)
+#define OMAP343X_CONTROL_TEST_KEY_7	(OMAP2_CONTROL_GENERAL + 0x00e4)
+#define OMAP343X_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e8)
+#define OMAP343X_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00ec)
+#define OMAP343X_CONTROL_TEST_KEY_10	(OMAP2_CONTROL_GENERAL + 0x00f0)
+#define OMAP343X_CONTROL_TEST_KEY_11	(OMAP2_CONTROL_GENERAL + 0x00f4)
+#define OMAP343X_CONTROL_TEST_KEY_12	(OMAP2_CONTROL_GENERAL + 0x00f8)
+#define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
+#define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+
+/*
+ * REVISIT: This list of registers is not comprehensive - there are more
+ * that should be added.
+ */
+
+/*
+ * Control module register bit defines - these should eventually go into
+ * their own regbits file.  Some of these will be complicated, depending
+ * on the device type (general-purpose, emulator, test, secure, bad, other)
+ * and the security mode (secure, non-secure, don't care)
+ */
+/* CONTROL_DEVCONF0 bits */
+#define OMAP24XX_USBSTANDBYCTRL		(1 << 15)
+#define OMAP2_MCBSP2_CLKS_MASK		(1 << 6)
+#define OMAP2_MCBSP1_CLKS_MASK		(1 << 2)
+
+/* CONTROL_DEVCONF1 bits */
+#define OMAP2_MCBSP5_CLKS_MASK		(1 << 4) /* > 242x */
+#define OMAP2_MCBSP4_CLKS_MASK		(1 << 2) /* > 242x */
+#define OMAP2_MCBSP3_CLKS_MASK		(1 << 0) /* > 242x */
+
+/* CONTROL_STATUS bits */
+#define OMAP2_DEVICETYPE_MASK		(0x7 << 8)
+#define OMAP2_SYSBOOT_5_MASK		(1 << 5)
+#define OMAP2_SYSBOOT_4_MASK		(1 << 4)
+#define OMAP2_SYSBOOT_3_MASK		(1 << 3)
+#define OMAP2_SYSBOOT_2_MASK		(1 << 2)
+#define OMAP2_SYSBOOT_1_MASK		(1 << 1)
+#define OMAP2_SYSBOOT_0_MASK		(1 << 0)
+
+#ifndef __ASSEMBLY__
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+extern void omap_ctrl_base_set(u32 base);
+extern u32 omap_ctrl_base_get(void);
+extern u8 omap_ctrl_readb(u16 offset);
+extern u16 omap_ctrl_readw(u16 offset);
+extern u32 omap_ctrl_readl(u16 offset);
+extern void omap_ctrl_writeb(u8 val, u16 offset);
+extern void omap_ctrl_writew(u16 val, u16 offset);
+extern void omap_ctrl_writel(u32 val, u16 offset);
+#else
+#define omap_ctrl_base_set(x)		WARN_ON(1)
+#define omap_ctrl_base_get()		0
+#define omap_ctrl_readb(x)		0
+#define omap_ctrl_readw(x)		0
+#define omap_ctrl_readl(x)		0
+#define omap_ctrl_writeb(x, y)		WARN_ON(1)
+#define omap_ctrl_writew(x, y)		WARN_ON(1)
+#define omap_ctrl_writel(x, y)		WARN_ON(1)
+#endif
+#endif	/* __ASSEMBLY__ */
+
+#endif /* __ASM_ARCH_CONTROL_H */
+
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
new file mode 100644
index 0000000..673b396
--- /dev/null
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -0,0 +1,75 @@
+#ifndef ____ASM_ARCH_SDRC_H
+#define ____ASM_ARCH_SDRC_H
+
+/*
+ * OMAP2/3 SDRC/SMS register definitions
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
+
+#include <asm/arch/io.h>
+
+/* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
+
+#define SDRC_SYSCONFIG		0x010
+#define SDRC_DLLA_CTRL		0x060
+#define SDRC_DLLA_STATUS	0x064
+#define SDRC_DLLB_CTRL		0x068
+#define SDRC_DLLB_STATUS	0x06C
+#define SDRC_POWER		0x070
+#define SDRC_MR_0		0x084
+#define SDRC_RFR_CTRL_0		0x0a4
+
+/*
+ * These values represent the number of memory clock cycles between
+ * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
+ * rows per device, and include a subtraction of a 50 cycle window in the
+ * event that the autorefresh command is delayed due to other SDRC activity.
+ * The '| 1' sets the ARE field to send one autorefresh when the autorefresh
+ * counter reaches 0.
+ *
+ * These represent optimal values for common parts, it won't work for all.
+ * As long as you scale down, most parameters are still work, they just
+ * become sub-optimal. The RFR value goes in the opposite direction. If you
+ * don't adjust it down as your clock period increases the refresh interval
+ * will not be met. Setting all parameters for complete worst case may work,
+ * but may cut memory performance by 2x. Due to errata the DLLs need to be
+ * unlocked and their value needs run time calibration.	A dynamic call is
+ * need for that as no single right value exists acorss production samples.
+ *
+ * Only the FULL speed values are given. Current code is such that rate
+ * changes must be made at DPLLoutx2. The actual value adjustment for low
+ * frequency operation will be handled by omap_set_performance()
+ *
+ * By having the boot loader boot up in the fastest L4 speed available likely
+ * will result in something which you can switch between.
+ */
+#define SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)
+#define SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
+#define SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
+#define SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
+#define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
+
+
+/*
+ * SMS register access
+ */
+
+
+#define OMAP242X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+#define OMAP243X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+#define OMAP343X_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+
+/* SMS register offsets - read/write with sms_{read,write}_reg() */
+
+#define SMS_SYSCONFIG		0x010
+/* REVISIT: fill in other SMS registers here */
+
+#endif
diff --git a/include/asm-arm/arch-omap/usb.h b/include/asm-arm/arch-omap/usb.h
index 99ae9ea..2147d18 100644
--- a/include/asm-arm/arch-omap/usb.h
+++ b/include/asm-arm/arch-omap/usb.h
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
-- 
1.5.3.6

