From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/17] ARM: OMAP2: Add register access for 34xx
Date: Fri, 28 Mar 2008 14:37:32 +0200
Message-ID: <20080328123731.GH24896@atomide.com>
References: <1205848935-12078-1-git-send-email-tony@atomide.com> <1205848935-12078-2-git-send-email-tony@atomide.com> <1205848935-12078-3-git-send-email-tony@atomide.com> <1205848935-12078-4-git-send-email-tony@atomide.com> <1205848935-12078-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fWddYNRDgTk9wQGZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53127 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbYC1Mhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 08:37:35 -0400
Content-Disposition: inline
In-Reply-To: <1205848935-12078-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080318 17:03]:
> This patch adds register access for 34xx power and clock management.

Here's an updated version of this patch. I've folded in two more patches
from Paul [1][2]. Patches change to use __ffs() instead of
mask_to_shift,
and clean up clock register defines.

Regards,

Tony

[1] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=f417e171cd2d2bd0302c8f420ee97295a165a39c
[2] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=70d19cc5c7999445b84e6ffea8e025512b877e8c

--fWddYNRDgTk9wQGZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0004-ARM-OMAP2-Add-register-access-for-34xx.patch"

>From e32923c7408d8731f5d6c551e39d7e49058034bb Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 18 Mar 2008 14:53:17 +0200
Subject: [PATCH] ARM: OMAP2: Add register access for 34xx

This patch adds register access for 34xx power and clock management.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  |  669 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h |  582 +++++++++++++++++++++++++++
 2 files changed, 1251 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm-regbits-34xx.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-34xx.h

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
new file mode 100644
index 0000000..3170408
--- /dev/null
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -0,0 +1,669 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_CM_REGBITS_34XX_H
+#define __ARCH_ARM_MACH_OMAP2_CM_REGBITS_34XX_H
+
+/*
+ * OMAP3430 Clock Management register bits
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
+#include "cm.h"
+
+/* Bits shared between registers */
+
+/* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
+#define OMAP3430ES2_EN_MMC3_MASK			(1 << 30)
+#define OMAP3430ES2_EN_MMC3_SHIFT			30
+#define OMAP3430_EN_MSPRO				(1 << 23)
+#define OMAP3430_EN_MSPRO_SHIFT				23
+#define OMAP3430_EN_HDQ					(1 << 22)
+#define OMAP3430_EN_HDQ_SHIFT				22
+#define OMAP3430ES1_EN_FSHOSTUSB			(1 << 5)
+#define OMAP3430ES1_EN_FSHOSTUSB_SHIFT			5
+#define OMAP3430ES1_EN_D2D				(1 << 3)
+#define OMAP3430ES1_EN_D2D_SHIFT			3
+#define OMAP3430_EN_SSI					(1 << 0)
+#define OMAP3430_EN_SSI_SHIFT				0
+
+/* CM_FCLKEN3_CORE and CM_ICLKEN3_CORE shared bits */
+#define OMAP3430ES2_EN_USBTLL_SHIFT			2
+#define OMAP3430ES2_EN_USBTLL_MASK			(1 << 2)
+
+/* CM_FCLKEN_WKUP and CM_ICLKEN_WKUP shared bits */
+#define OMAP3430_EN_WDT2				(1 << 5)
+#define OMAP3430_EN_WDT2_SHIFT				5
+
+/* CM_ICLKEN_CAM, CM_FCLKEN_CAM shared bits */
+#define OMAP3430_EN_CAM					(1 << 0)
+#define OMAP3430_EN_CAM_SHIFT				0
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER shared bits */
+#define OMAP3430_EN_WDT3				(1 << 12)
+#define OMAP3430_EN_WDT3_SHIFT				12
+
+/* CM_CLKSEL2_EMU, CM_CLKSEL3_EMU shared bits */
+#define OMAP3430_OVERRIDE_ENABLE			(1 << 19)
+
+
+/* Bits specific to each register */
+
+/* CM_FCLKEN_IVA2 */
+#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2			(1 << 0)
+
+/* CM_CLKEN_PLL_IVA2 */
+#define OMAP3430_IVA2_DPLL_RAMPTIME_SHIFT		8
+#define OMAP3430_IVA2_DPLL_RAMPTIME_MASK		(0x3 << 8)
+#define OMAP3430_IVA2_DPLL_FREQSEL_SHIFT		4
+#define OMAP3430_IVA2_DPLL_FREQSEL_MASK			(0xf << 4)
+#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_MASK		(1 << 3)
+#define OMAP3430_EN_IVA2_DPLL_SHIFT			0
+#define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
+
+/* CM_IDLEST_IVA2 */
+#define OMAP3430_ST_IVA2				(1 << 0)
+
+/* CM_IDLEST_PLL_IVA2 */
+#define OMAP3430_ST_IVA2_CLK				(1 << 0)
+
+/* CM_AUTOIDLE_PLL_IVA2 */
+#define OMAP3430_AUTO_IVA2_DPLL_SHIFT			0
+#define OMAP3430_AUTO_IVA2_DPLL_MASK			(0x7 << 0)
+
+/* CM_CLKSEL1_PLL_IVA2 */
+#define OMAP3430_IVA2_CLK_SRC_SHIFT			19
+#define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
+#define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
+#define OMAP3430_IVA2_DPLL_DIV_MASK			(0x7f << 0)
+
+/* CM_CLKSEL2_PLL_IVA2 */
+#define OMAP3430_IVA2_DPLL_CLKOUT_DIV_SHIFT		0
+#define OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK		(0x1f << 0)
+
+/* CM_CLKSTCTRL_IVA2 */
+#define OMAP3430_CLKTRCTRL_IVA2_SHIFT			0
+#define OMAP3430_CLKTRCTRL_IVA2_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_IVA2 */
+#define OMAP3430_CLKACTIVITY_IVA2			(1 << 0)
+
+/* CM_REVISION specific bits */
+
+/* CM_SYSCONFIG specific bits */
+
+/* CM_CLKEN_PLL_MPU */
+#define OMAP3430_MPU_DPLL_RAMPTIME_SHIFT		8
+#define OMAP3430_MPU_DPLL_RAMPTIME_MASK			(0x3 << 8)
+#define OMAP3430_MPU_DPLL_FREQSEL_SHIFT			4
+#define OMAP3430_MPU_DPLL_FREQSEL_MASK			(0xf << 4)
+#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_MASK		(1 << 3)
+#define OMAP3430_EN_MPU_DPLL_SHIFT			0
+#define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
+
+/* CM_IDLEST_MPU */
+#define OMAP3430_ST_MPU					(1 << 0)
+
+/* CM_IDLEST_PLL_MPU */
+#define OMAP3430_ST_MPU_CLK				(1 << 0)
+
+/* CM_AUTOIDLE_PLL_MPU */
+#define OMAP3430_AUTO_MPU_DPLL_SHIFT			0
+#define OMAP3430_AUTO_MPU_DPLL_MASK			(0x7 << 0)
+
+/* CM_CLKSEL1_PLL_MPU */
+#define OMAP3430_MPU_CLK_SRC_SHIFT			19
+#define OMAP3430_MPU_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_MPU_DPLL_MULT_SHIFT			8
+#define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3430_MPU_DPLL_DIV_SHIFT			0
+#define OMAP3430_MPU_DPLL_DIV_MASK			(0x7f << 0)
+
+/* CM_CLKSEL2_PLL_MPU */
+#define OMAP3430_MPU_DPLL_CLKOUT_DIV_SHIFT		0
+#define OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK		(0x1f << 0)
+
+/* CM_CLKSTCTRL_MPU */
+#define OMAP3430_CLKTRCTRL_MPU_SHIFT			0
+#define OMAP3430_CLKTRCTRL_MPU_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_MPU */
+#define OMAP3430_CLKACTIVITY_MPU			(1 << 0)
+
+/* CM_FCLKEN1_CORE specific bits */
+
+/* CM_ICLKEN1_CORE specific bits */
+#define OMAP3430_EN_ICR					(1 << 29)
+#define OMAP3430_EN_ICR_SHIFT				29
+#define OMAP3430_EN_AES2				(1 << 28)
+#define OMAP3430_EN_AES2_SHIFT				28
+#define OMAP3430_EN_SHA12				(1 << 27)
+#define OMAP3430_EN_SHA12_SHIFT				27
+#define OMAP3430_EN_DES2				(1 << 26)
+#define OMAP3430_EN_DES2_SHIFT				26
+#define OMAP3430ES1_EN_FAC				(1 << 8)
+#define OMAP3430ES1_EN_FAC_SHIFT			8
+#define OMAP3430_EN_MAILBOXES				(1 << 7)
+#define OMAP3430_EN_MAILBOXES_SHIFT			7
+#define OMAP3430_EN_OMAPCTRL				(1 << 6)
+#define OMAP3430_EN_OMAPCTRL_SHIFT			6
+#define OMAP3430_EN_SDRC				(1 << 1)
+#define OMAP3430_EN_SDRC_SHIFT				1
+
+/* CM_ICLKEN2_CORE */
+#define OMAP3430_EN_PKA					(1 << 4)
+#define OMAP3430_EN_PKA_SHIFT				4
+#define OMAP3430_EN_AES1				(1 << 3)
+#define OMAP3430_EN_AES1_SHIFT				3
+#define OMAP3430_EN_RNG					(1 << 2)
+#define OMAP3430_EN_RNG_SHIFT				2
+#define OMAP3430_EN_SHA11				(1 << 1)
+#define OMAP3430_EN_SHA11_SHIFT				1
+#define OMAP3430_EN_DES1				(1 << 0)
+#define OMAP3430_EN_DES1_SHIFT				0
+
+/* CM_FCLKEN3_CORE specific bits */
+#define OMAP3430ES2_EN_TS_SHIFT				1
+#define OMAP3430ES2_EN_TS_MASK				(1 << 1)
+#define OMAP3430ES2_EN_CPEFUSE_SHIFT			0
+#define OMAP3430ES2_EN_CPEFUSE_MASK			(1 << 0)
+
+/* CM_IDLEST1_CORE specific bits */
+#define OMAP3430_ST_ICR					(1 << 29)
+#define OMAP3430_ST_AES2				(1 << 28)
+#define OMAP3430_ST_SHA12				(1 << 27)
+#define OMAP3430_ST_DES2				(1 << 26)
+#define OMAP3430_ST_MSPRO				(1 << 23)
+#define OMAP3430_ST_HDQ					(1 << 22)
+#define OMAP3430ES1_ST_FAC				(1 << 8)
+#define OMAP3430ES1_ST_MAILBOXES			(1 << 7)
+#define OMAP3430_ST_OMAPCTRL				(1 << 6)
+#define OMAP3430_ST_SDMA				(1 << 2)
+#define OMAP3430_ST_SDRC				(1 << 1)
+#define OMAP3430_ST_SSI					(1 << 0)
+
+/* CM_IDLEST2_CORE */
+#define OMAP3430_ST_PKA					(1 << 4)
+#define OMAP3430_ST_AES1				(1 << 3)
+#define OMAP3430_ST_RNG					(1 << 2)
+#define OMAP3430_ST_SHA11				(1 << 1)
+#define OMAP3430_ST_DES1				(1 << 0)
+
+/* CM_IDLEST3_CORE */
+#define OMAP3430ES2_ST_USBTLL_SHIFT			2
+#define OMAP3430ES2_ST_USBTLL_MASK			(1 << 2)
+
+/* CM_AUTOIDLE1_CORE */
+#define OMAP3430_AUTO_AES2				(1 << 28)
+#define OMAP3430_AUTO_AES2_SHIFT			28
+#define OMAP3430_AUTO_SHA12				(1 << 27)
+#define OMAP3430_AUTO_SHA12_SHIFT			27
+#define OMAP3430_AUTO_DES2				(1 << 26)
+#define OMAP3430_AUTO_DES2_SHIFT			26
+#define OMAP3430_AUTO_MMC2				(1 << 25)
+#define OMAP3430_AUTO_MMC2_SHIFT			25
+#define OMAP3430_AUTO_MMC1				(1 << 24)
+#define OMAP3430_AUTO_MMC1_SHIFT			24
+#define OMAP3430_AUTO_MSPRO				(1 << 23)
+#define OMAP3430_AUTO_MSPRO_SHIFT			23
+#define OMAP3430_AUTO_HDQ				(1 << 22)
+#define OMAP3430_AUTO_HDQ_SHIFT				22
+#define OMAP3430_AUTO_MCSPI4				(1 << 21)
+#define OMAP3430_AUTO_MCSPI4_SHIFT			21
+#define OMAP3430_AUTO_MCSPI3				(1 << 20)
+#define OMAP3430_AUTO_MCSPI3_SHIFT			20
+#define OMAP3430_AUTO_MCSPI2				(1 << 19)
+#define OMAP3430_AUTO_MCSPI2_SHIFT			19
+#define OMAP3430_AUTO_MCSPI1				(1 << 18)
+#define OMAP3430_AUTO_MCSPI1_SHIFT			18
+#define OMAP3430_AUTO_I2C3				(1 << 17)
+#define OMAP3430_AUTO_I2C3_SHIFT			17
+#define OMAP3430_AUTO_I2C2				(1 << 16)
+#define OMAP3430_AUTO_I2C2_SHIFT			16
+#define OMAP3430_AUTO_I2C1				(1 << 15)
+#define OMAP3430_AUTO_I2C1_SHIFT			15
+#define OMAP3430_AUTO_UART2				(1 << 14)
+#define OMAP3430_AUTO_UART2_SHIFT			14
+#define OMAP3430_AUTO_UART1				(1 << 13)
+#define OMAP3430_AUTO_UART1_SHIFT			13
+#define OMAP3430_AUTO_GPT11				(1 << 12)
+#define OMAP3430_AUTO_GPT11_SHIFT			12
+#define OMAP3430_AUTO_GPT10				(1 << 11)
+#define OMAP3430_AUTO_GPT10_SHIFT			11
+#define OMAP3430_AUTO_MCBSP5				(1 << 10)
+#define OMAP3430_AUTO_MCBSP5_SHIFT			10
+#define OMAP3430_AUTO_MCBSP1				(1 << 9)
+#define OMAP3430_AUTO_MCBSP1_SHIFT			9
+#define OMAP3430ES1_AUTO_FAC				(1 << 8)
+#define OMAP3430ES1_AUTO_FAC_SHIFT			8
+#define OMAP3430_AUTO_MAILBOXES				(1 << 7)
+#define OMAP3430_AUTO_MAILBOXES_SHIFT			7
+#define OMAP3430_AUTO_OMAPCTRL				(1 << 6)
+#define OMAP3430_AUTO_OMAPCTRL_SHIFT			6
+#define OMAP3430ES1_AUTO_FSHOSTUSB			(1 << 5)
+#define OMAP3430ES1_AUTO_FSHOSTUSB_SHIFT		5
+#define OMAP3430_AUTO_HSOTGUSB				(1 << 4)
+#define OMAP3430_AUTO_HSOTGUSB_SHIFT			4
+#define OMAP3430ES1_AUTO_D2D				(1 << 3)
+#define OMAP3430ES1_AUTO_D2D_SHIFT			3
+#define OMAP3430_AUTO_SSI				(1 << 0)
+#define OMAP3430_AUTO_SSI_SHIFT				0
+
+/* CM_AUTOIDLE2_CORE */
+#define OMAP3430_AUTO_PKA				(1 << 4)
+#define OMAP3430_AUTO_PKA_SHIFT				4
+#define OMAP3430_AUTO_AES1				(1 << 3)
+#define OMAP3430_AUTO_AES1_SHIFT			3
+#define OMAP3430_AUTO_RNG				(1 << 2)
+#define OMAP3430_AUTO_RNG_SHIFT				2
+#define OMAP3430_AUTO_SHA11				(1 << 1)
+#define OMAP3430_AUTO_SHA11_SHIFT			1
+#define OMAP3430_AUTO_DES1				(1 << 0)
+#define OMAP3430_AUTO_DES1_SHIFT			0
+
+/* CM_AUTOIDLE3_CORE */
+#define OMAP3430ES2_AUTO_USBTLL_SHIFT			2
+#define OMAP3430ES2_AUTO_USBTLL_MASK			(1 << 2)
+
+/* CM_CLKSEL_CORE */
+#define OMAP3430_CLKSEL_SSI_SHIFT			8
+#define OMAP3430_CLKSEL_SSI_MASK			(0xf << 8)
+#define OMAP3430_CLKSEL_GPT11_MASK			(1 << 7)
+#define OMAP3430_CLKSEL_GPT11_SHIFT			7
+#define OMAP3430_CLKSEL_GPT10_MASK			(1 << 6)
+#define OMAP3430_CLKSEL_GPT10_SHIFT			6
+#define OMAP3430ES1_CLKSEL_FSHOSTUSB_SHIFT		4
+#define OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK		(0x3 << 4)
+#define OMAP3430_CLKSEL_L4_SHIFT			2
+#define OMAP3430_CLKSEL_L4_MASK				(0x3 << 2)
+#define OMAP3430_CLKSEL_L3_SHIFT			0
+#define OMAP3430_CLKSEL_L3_MASK				(0x3 << 0)
+
+/* CM_CLKSTCTRL_CORE */
+#define OMAP3430ES1_CLKTRCTRL_D2D_SHIFT			4
+#define OMAP3430ES1_CLKTRCTRL_D2D_MASK			(0x3 << 4)
+#define OMAP3430_CLKTRCTRL_L4_SHIFT			2
+#define OMAP3430_CLKTRCTRL_L4_MASK			(0x3 << 2)
+#define OMAP3430_CLKTRCTRL_L3_SHIFT			0
+#define OMAP3430_CLKTRCTRL_L3_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_CORE */
+#define OMAP3430ES1_CLKACTIVITY_D2D			(1 << 2)
+#define OMAP3430_CLKACTIVITY_L4				(1 << 1)
+#define OMAP3430_CLKACTIVITY_L3				(1 << 0)
+
+/* CM_FCLKEN_GFX */
+#define OMAP3430ES1_EN_3D				(1 << 2)
+#define OMAP3430ES1_EN_3D_SHIFT				2
+#define OMAP3430ES1_EN_2D				(1 << 1)
+#define OMAP3430ES1_EN_2D_SHIFT				1
+
+/* CM_ICLKEN_GFX specific bits */
+
+/* CM_IDLEST_GFX specific bits */
+
+/* CM_CLKSEL_GFX specific bits */
+
+/* CM_SLEEPDEP_GFX specific bits */
+
+/* CM_CLKSTCTRL_GFX */
+#define OMAP3430ES1_CLKTRCTRL_GFX_SHIFT			0
+#define OMAP3430ES1_CLKTRCTRL_GFX_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_GFX */
+#define OMAP3430ES1_CLKACTIVITY_GFX			(1 << 0)
+
+/* CM_FCLKEN_SGX */
+#define OMAP3430ES2_EN_SGX_SHIFT			1
+#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
+
+/* CM_CLKSEL_SGX */
+#define OMAP3430ES2_CLKSEL_SGX_SHIFT			0
+#define OMAP3430ES2_CLKSEL_SGX_MASK			(0x7 << 0)
+
+/* CM_FCLKEN_WKUP specific bits */
+#define OMAP3430ES2_EN_USIMOCP_SHIFT			9
+
+/* CM_ICLKEN_WKUP specific bits */
+#define OMAP3430_EN_WDT1				(1 << 4)
+#define OMAP3430_EN_WDT1_SHIFT				4
+#define OMAP3430_EN_32KSYNC				(1 << 2)
+#define OMAP3430_EN_32KSYNC_SHIFT			2
+
+/* CM_IDLEST_WKUP specific bits */
+#define OMAP3430_ST_WDT2				(1 << 5)
+#define OMAP3430_ST_WDT1				(1 << 4)
+#define OMAP3430_ST_32KSYNC				(1 << 2)
+
+/* CM_AUTOIDLE_WKUP */
+#define OMAP3430_AUTO_WDT2				(1 << 5)
+#define OMAP3430_AUTO_WDT2_SHIFT			5
+#define OMAP3430_AUTO_WDT1				(1 << 4)
+#define OMAP3430_AUTO_WDT1_SHIFT			4
+#define OMAP3430_AUTO_GPIO1				(1 << 3)
+#define OMAP3430_AUTO_GPIO1_SHIFT			3
+#define OMAP3430_AUTO_32KSYNC				(1 << 2)
+#define OMAP3430_AUTO_32KSYNC_SHIFT			2
+#define OMAP3430_AUTO_GPT12				(1 << 1)
+#define OMAP3430_AUTO_GPT12_SHIFT			1
+#define OMAP3430_AUTO_GPT1				(1 << 0)
+#define OMAP3430_AUTO_GPT1_SHIFT			0
+
+/* CM_CLKSEL_WKUP */
+#define OMAP3430ES2_CLKSEL_USIMOCP_MASK			(0xf << 3)
+#define OMAP3430_CLKSEL_RM_SHIFT			1
+#define OMAP3430_CLKSEL_RM_MASK				(0x3 << 1)
+#define OMAP3430_CLKSEL_GPT1_SHIFT			0
+#define OMAP3430_CLKSEL_GPT1_MASK			(1 << 0)
+
+/* CM_CLKEN_PLL */
+#define OMAP3430_PWRDN_EMU_PERIPH_SHIFT			31
+#define OMAP3430_PWRDN_CAM_SHIFT			30
+#define OMAP3430_PWRDN_DSS1_SHIFT			29
+#define OMAP3430_PWRDN_TV_SHIFT				28
+#define OMAP3430_PWRDN_96M_SHIFT			27
+#define OMAP3430_PERIPH_DPLL_RAMPTIME_SHIFT		24
+#define OMAP3430_PERIPH_DPLL_RAMPTIME_MASK		(0x3 << 24)
+#define OMAP3430_PERIPH_DPLL_FREQSEL_SHIFT		20
+#define OMAP3430_PERIPH_DPLL_FREQSEL_MASK		(0xf << 20)
+#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT	19
+#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_MASK		(1 << 19)
+#define OMAP3430_EN_PERIPH_DPLL_SHIFT			16
+#define OMAP3430_EN_PERIPH_DPLL_MASK			(0x7 << 16)
+#define OMAP3430_PWRDN_EMU_CORE_SHIFT			12
+#define OMAP3430_CORE_DPLL_RAMPTIME_SHIFT		8
+#define OMAP3430_CORE_DPLL_RAMPTIME_MASK		(0x3 << 8)
+#define OMAP3430_CORE_DPLL_FREQSEL_SHIFT		4
+#define OMAP3430_CORE_DPLL_FREQSEL_MASK			(0xf << 4)
+#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD_MASK		(1 << 3)
+#define OMAP3430_EN_CORE_DPLL_SHIFT			0
+#define OMAP3430_EN_CORE_DPLL_MASK			(0x7 << 0)
+
+/* CM_CLKEN2_PLL */
+#define OMAP3430ES2_EN_PERIPH2_DPLL_LPMODE_SHIFT		10
+#define OMAP3430ES2_PERIPH2_DPLL_RAMPTIME_MASK		(0x3 << 8)
+#define OMAP3430ES2_PERIPH2_DPLL_FREQSEL_SHIFT		4
+#define OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK		(0xf << 4)
+#define OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT	3
+#define OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT		0
+#define OMAP3430ES2_EN_PERIPH2_DPLL_MASK		(0x7 << 0)
+
+/* CM_IDLEST_CKGEN */
+#define OMAP3430_ST_54M_CLK				(1 << 5)
+#define OMAP3430_ST_12M_CLK				(1 << 4)
+#define OMAP3430_ST_48M_CLK				(1 << 3)
+#define OMAP3430_ST_96M_CLK				(1 << 2)
+#define OMAP3430_ST_PERIPH_CLK				(1 << 1)
+#define OMAP3430_ST_CORE_CLK				(1 << 0)
+
+/* CM_IDLEST2_CKGEN */
+#define OMAP3430ES2_ST_120M_CLK_SHIFT			1
+#define OMAP3430ES2_ST_120M_CLK_MASK			(1 << 1)
+#define OMAP3430ES2_ST_PERIPH2_CLK_SHIFT		0
+#define OMAP3430ES2_ST_PERIPH2_CLK_MASK			(1 << 0)
+
+/* CM_AUTOIDLE_PLL */
+#define OMAP3430_AUTO_PERIPH_DPLL_SHIFT			3
+#define OMAP3430_AUTO_PERIPH_DPLL_MASK			(0x7 << 3)
+#define OMAP3430_AUTO_CORE_DPLL_SHIFT			0
+#define OMAP3430_AUTO_CORE_DPLL_MASK			(0x7 << 0)
+
+/* CM_CLKSEL1_PLL */
+/* Note that OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK was (0x3 << 27) on 3430ES1 */
+#define OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT		27
+#define OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK		(0x1f << 27)
+#define OMAP3430_CORE_DPLL_MULT_SHIFT			16
+#define OMAP3430_CORE_DPLL_MULT_MASK			(0x7ff << 16)
+#define OMAP3430_CORE_DPLL_DIV_SHIFT			8
+#define OMAP3430_CORE_DPLL_DIV_MASK			(0x7f << 8)
+#define OMAP3430_SOURCE_54M				(1 << 5)
+#define OMAP3430_SOURCE_48M				(1 << 3)
+
+/* CM_CLKSEL2_PLL */
+#define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
+#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
+#define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
+
+/* CM_CLKSEL3_PLL */
+#define OMAP3430_DIV_96M_SHIFT				0
+#define OMAP3430_DIV_96M_MASK				(0x1f << 0)
+
+/* CM_CLKSEL4_PLL */
+#define OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT		8
+#define OMAP3430ES2_PERIPH2_DPLL_MULT_MASK		(0x7ff << 8)
+#define OMAP3430ES2_PERIPH2_DPLL_DIV_SHIFT		0
+#define OMAP3430ES2_PERIPH2_DPLL_DIV_MASK		(0x7f << 0)
+
+/* CM_CLKSEL5_PLL */
+#define OMAP3430ES2_DIV_120M_SHIFT			0
+#define OMAP3430ES2_DIV_120M_MASK			(0x1f << 0)
+
+/* CM_CLKOUT_CTRL */
+#define OMAP3430_CLKOUT2_EN_SHIFT			7
+#define OMAP3430_CLKOUT2_EN				(1 << 7)
+#define OMAP3430_CLKOUT2_DIV_SHIFT			3
+#define OMAP3430_CLKOUT2_DIV_MASK			(0x7 << 3)
+#define OMAP3430_CLKOUT2SOURCE_SHIFT			0
+#define OMAP3430_CLKOUT2SOURCE_MASK			(0x3 << 0)
+
+/* CM_FCLKEN_DSS */
+#define OMAP3430_EN_TV					(1 << 2)
+#define OMAP3430_EN_TV_SHIFT				2
+#define OMAP3430_EN_DSS2				(1 << 1)
+#define OMAP3430_EN_DSS2_SHIFT				1
+#define OMAP3430_EN_DSS1				(1 << 0)
+#define OMAP3430_EN_DSS1_SHIFT				0
+
+/* CM_ICLKEN_DSS */
+#define OMAP3430_CM_ICLKEN_DSS_EN_DSS			(1 << 0)
+#define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
+
+/* CM_IDLEST_DSS */
+#define OMAP3430_ST_DSS					(1 << 0)
+
+/* CM_AUTOIDLE_DSS */
+#define OMAP3430_AUTO_DSS				(1 << 0)
+#define OMAP3430_AUTO_DSS_SHIFT				0
+
+/* CM_CLKSEL_DSS */
+#define OMAP3430_CLKSEL_TV_SHIFT			8
+#define OMAP3430_CLKSEL_TV_MASK				(0x1f << 8)
+#define OMAP3430_CLKSEL_DSS1_SHIFT			0
+#define OMAP3430_CLKSEL_DSS1_MASK			(0x1f << 0)
+
+/* CM_SLEEPDEP_DSS specific bits */
+
+/* CM_CLKSTCTRL_DSS */
+#define OMAP3430_CLKTRCTRL_DSS_SHIFT			0
+#define OMAP3430_CLKTRCTRL_DSS_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_DSS */
+#define OMAP3430_CLKACTIVITY_DSS			(1 << 0)
+
+/* CM_FCLKEN_CAM specific bits */
+
+/* CM_ICLKEN_CAM specific bits */
+
+/* CM_IDLEST_CAM */
+#define OMAP3430_ST_CAM					(1 << 0)
+
+/* CM_AUTOIDLE_CAM */
+#define OMAP3430_AUTO_CAM				(1 << 0)
+#define OMAP3430_AUTO_CAM_SHIFT				0
+
+/* CM_CLKSEL_CAM */
+#define OMAP3430_CLKSEL_CAM_SHIFT			0
+#define OMAP3430_CLKSEL_CAM_MASK			(0x1f << 0)
+
+/* CM_SLEEPDEP_CAM specific bits */
+
+/* CM_CLKSTCTRL_CAM */
+#define OMAP3430_CLKTRCTRL_CAM_SHIFT			0
+#define OMAP3430_CLKTRCTRL_CAM_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_CAM */
+#define OMAP3430_CLKACTIVITY_CAM			(1 << 0)
+
+/* CM_FCLKEN_PER specific bits */
+
+/* CM_ICLKEN_PER specific bits */
+
+/* CM_IDLEST_PER */
+#define OMAP3430_ST_WDT3				(1 << 12)
+#define OMAP3430_ST_MCBSP4				(1 << 2)
+#define OMAP3430_ST_MCBSP3				(1 << 1)
+#define OMAP3430_ST_MCBSP2				(1 << 0)
+
+/* CM_AUTOIDLE_PER */
+#define OMAP3430_AUTO_GPIO6				(1 << 17)
+#define OMAP3430_AUTO_GPIO6_SHIFT			17
+#define OMAP3430_AUTO_GPIO5				(1 << 16)
+#define OMAP3430_AUTO_GPIO5_SHIFT			16
+#define OMAP3430_AUTO_GPIO4				(1 << 15)
+#define OMAP3430_AUTO_GPIO4_SHIFT			15
+#define OMAP3430_AUTO_GPIO3				(1 << 14)
+#define OMAP3430_AUTO_GPIO3_SHIFT			14
+#define OMAP3430_AUTO_GPIO2				(1 << 13)
+#define OMAP3430_AUTO_GPIO2_SHIFT			13
+#define OMAP3430_AUTO_WDT3				(1 << 12)
+#define OMAP3430_AUTO_WDT3_SHIFT			12
+#define OMAP3430_AUTO_UART3				(1 << 11)
+#define OMAP3430_AUTO_UART3_SHIFT			11
+#define OMAP3430_AUTO_GPT9				(1 << 10)
+#define OMAP3430_AUTO_GPT9_SHIFT			10
+#define OMAP3430_AUTO_GPT8				(1 << 9)
+#define OMAP3430_AUTO_GPT8_SHIFT			9
+#define OMAP3430_AUTO_GPT7				(1 << 8)
+#define OMAP3430_AUTO_GPT7_SHIFT			8
+#define OMAP3430_AUTO_GPT6				(1 << 7)
+#define OMAP3430_AUTO_GPT6_SHIFT			7
+#define OMAP3430_AUTO_GPT5				(1 << 6)
+#define OMAP3430_AUTO_GPT5_SHIFT			6
+#define OMAP3430_AUTO_GPT4				(1 << 5)
+#define OMAP3430_AUTO_GPT4_SHIFT			5
+#define OMAP3430_AUTO_GPT3				(1 << 4)
+#define OMAP3430_AUTO_GPT3_SHIFT			4
+#define OMAP3430_AUTO_GPT2				(1 << 3)
+#define OMAP3430_AUTO_GPT2_SHIFT			3
+#define OMAP3430_AUTO_MCBSP4				(1 << 2)
+#define OMAP3430_AUTO_MCBSP4_SHIFT			2
+#define OMAP3430_AUTO_MCBSP3				(1 << 1)
+#define OMAP3430_AUTO_MCBSP3_SHIFT			1
+#define OMAP3430_AUTO_MCBSP2				(1 << 0)
+#define OMAP3430_AUTO_MCBSP2_SHIFT			0
+
+/* CM_CLKSEL_PER */
+#define OMAP3430_CLKSEL_GPT9_MASK			(1 << 7)
+#define OMAP3430_CLKSEL_GPT9_SHIFT			7
+#define OMAP3430_CLKSEL_GPT8_MASK			(1 << 6)
+#define OMAP3430_CLKSEL_GPT8_SHIFT			6
+#define OMAP3430_CLKSEL_GPT7_MASK			(1 << 5)
+#define OMAP3430_CLKSEL_GPT7_SHIFT			5
+#define OMAP3430_CLKSEL_GPT6_MASK			(1 << 4)
+#define OMAP3430_CLKSEL_GPT6_SHIFT			4
+#define OMAP3430_CLKSEL_GPT5_MASK			(1 << 3)
+#define OMAP3430_CLKSEL_GPT5_SHIFT			3
+#define OMAP3430_CLKSEL_GPT4_MASK			(1 << 2)
+#define OMAP3430_CLKSEL_GPT4_SHIFT			2
+#define OMAP3430_CLKSEL_GPT3_MASK			(1 << 1)
+#define OMAP3430_CLKSEL_GPT3_SHIFT			1
+#define OMAP3430_CLKSEL_GPT2_MASK			(1 << 0)
+#define OMAP3430_CLKSEL_GPT2_SHIFT			0
+
+/* CM_SLEEPDEP_PER specific bits */
+#define OMAP3430_CM_SLEEPDEP_PER_EN_IVA2		(1 << 2)
+
+/* CM_CLKSTCTRL_PER */
+#define OMAP3430_CLKTRCTRL_PER_SHIFT			0
+#define OMAP3430_CLKTRCTRL_PER_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_PER */
+#define OMAP3430_CLKACTIVITY_PER			(1 << 0)
+
+/* CM_CLKSEL1_EMU */
+#define OMAP3430_DIV_DPLL4_SHIFT			24
+#define OMAP3430_DIV_DPLL4_MASK				(0x1f << 24)
+#define OMAP3430_DIV_DPLL3_SHIFT			16
+#define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
+#define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
+#define OMAP3430_CLKSEL_TRACECLK_MASK			(0x7 << 11)
+#define OMAP3430_CLKSEL_PCLK_SHIFT			8
+#define OMAP3430_CLKSEL_PCLK_MASK			(0x7 << 8)
+#define OMAP3430_CLKSEL_PCLKX2_SHIFT			6
+#define OMAP3430_CLKSEL_PCLKX2_MASK			(0x3 << 6)
+#define OMAP3430_CLKSEL_ATCLK_SHIFT			4
+#define OMAP3430_CLKSEL_ATCLK_MASK			(0x3 << 4)
+#define OMAP3430_TRACE_MUX_CTRL_SHIFT			2
+#define OMAP3430_TRACE_MUX_CTRL_MASK			(0x3 << 2)
+#define OMAP3430_MUX_CTRL_SHIFT				0
+#define OMAP3430_MUX_CTRL_MASK				(0x3 << 0)
+
+/* CM_CLKSTCTRL_EMU */
+#define OMAP3430_CLKTRCTRL_EMU_SHIFT			0
+#define OMAP3430_CLKTRCTRL_EMU_MASK			(0x3 << 0)
+
+/* CM_CLKSTST_EMU */
+#define OMAP3430_CLKACTIVITY_EMU			(1 << 0)
+
+/* CM_CLKSEL2_EMU specific bits */
+#define OMAP3430_CORE_DPLL_EMU_MULT_SHIFT		8
+#define OMAP3430_CORE_DPLL_EMU_MULT_MASK		(0x7ff << 8)
+#define OMAP3430_CORE_DPLL_EMU_DIV_SHIFT		0
+#define OMAP3430_CORE_DPLL_EMU_DIV_MASK			(0x7f << 0)
+
+/* CM_CLKSEL3_EMU specific bits */
+#define OMAP3430_PERIPH_DPLL_EMU_MULT_SHIFT		8
+#define OMAP3430_PERIPH_DPLL_EMU_MULT_MASK		(0x7ff << 8)
+#define OMAP3430_PERIPH_DPLL_EMU_DIV_SHIFT		0
+#define OMAP3430_PERIPH_DPLL_EMU_DIV_MASK		(0x7f << 0)
+
+/* CM_POLCTRL */
+#define OMAP3430_CLKOUT2_POL				(1 << 0)
+
+/* CM_IDLEST_NEON */
+#define OMAP3430_ST_NEON				(1 << 0)
+
+/* CM_CLKSTCTRL_NEON */
+#define OMAP3430_CLKTRCTRL_NEON_SHIFT			0
+#define OMAP3430_CLKTRCTRL_NEON_MASK			(0x3 << 0)
+
+/* CM_FCLKEN_USBHOST */
+#define OMAP3430ES2_EN_USBHOST2_SHIFT			1
+#define OMAP3430ES2_EN_USBHOST2_MASK			(1 << 1)
+#define OMAP3430ES2_EN_USBHOST1_SHIFT			0
+#define OMAP3430ES2_EN_USBHOST1_MASK			(1 << 0)
+
+/* CM_ICLKEN_USBHOST */
+#define OMAP3430ES2_EN_USBHOST_SHIFT			0
+#define OMAP3430ES2_EN_USBHOST_MASK			(1 << 0)
+
+/* CM_IDLEST_USBHOST */
+
+/* CM_AUTOIDLE_USBHOST */
+#define OMAP3430ES2_AUTO_USBHOST_SHIFT			0
+#define OMAP3430ES2_AUTO_USBHOST_MASK			(1 << 0)
+
+/* CM_SLEEPDEP_USBHOST */
+#define OMAP3430ES2_EN_MPU_SHIFT			1
+#define OMAP3430ES2_EN_MPU_MASK				(1 << 1)
+#define OMAP3430ES2_EN_IVA2_SHIFT			2
+#define OMAP3430ES2_EN_IVA2_MASK			(1 << 2)
+
+/* CM_CLKSTCTRL_USBHOST */
+#define OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT		0
+#define OMAP3430ES2_CLKTRCTRL_USBHOST_MASK		(3 << 0)
+
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
new file mode 100644
index 0000000..b4686bc
--- /dev/null
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -0,0 +1,582 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
+
+/*
+ * OMAP3430 Power/Reset Management register bits
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
+#include "prm.h"
+
+/* Shared register bits */
+
+/* PRM_VC_CMD_VAL_0, PRM_VC_CMD_VAL_1 shared bits */
+#define OMAP3430_ON_SHIFT				24
+#define OMAP3430_ON_MASK				(0xff << 24)
+#define OMAP3430_ONLP_SHIFT				16
+#define OMAP3430_ONLP_MASK				(0xff << 16)
+#define OMAP3430_RET_SHIFT				8
+#define OMAP3430_RET_MASK				(0xff << 8)
+#define OMAP3430_OFF_SHIFT				0
+#define OMAP3430_OFF_MASK				(0xff << 0)
+
+/* PRM_VP1_CONFIG, PRM_VP2_CONFIG shared bits */
+#define OMAP3430_ERROROFFSET_SHIFT			24
+#define OMAP3430_ERROROFFSET_MASK			(0xff << 24)
+#define OMAP3430_ERRORGAIN_SHIFT			16
+#define OMAP3430_ERRORGAIN_MASK				(0xff << 16)
+#define OMAP3430_INITVOLTAGE_SHIFT			8
+#define OMAP3430_INITVOLTAGE_MASK			(0xff << 8)
+#define OMAP3430_TIMEOUTEN				(1 << 3)
+#define OMAP3430_INITVDD				(1 << 2)
+#define OMAP3430_FORCEUPDATE				(1 << 1)
+#define OMAP3430_VPENABLE				(1 << 0)
+
+/* PRM_VP1_VSTEPMIN, PRM_VP2_VSTEPMIN shared bits */
+#define OMAP3430_SMPSWAITTIMEMIN_SHIFT			8
+#define OMAP3430_SMPSWAITTIMEMIN_MASK			(0xffff << 8)
+#define OMAP3430_VSTEPMIN_SHIFT				0
+#define OMAP3430_VSTEPMIN_MASK				(0xff << 0)
+
+/* PRM_VP1_VSTEPMAX, PRM_VP2_VSTEPMAX shared bits */
+#define OMAP3430_SMPSWAITTIMEMAX_SHIFT			8
+#define OMAP3430_SMPSWAITTIMEMAX_MASK			(0xffff << 8)
+#define OMAP3430_VSTEPMAX_SHIFT				0
+#define OMAP3430_VSTEPMAX_MASK				(0xff << 0)
+
+/* PRM_VP1_VLIMITTO, PRM_VP2_VLIMITTO shared bits */
+#define OMAP3430_VDDMAX_SHIFT				24
+#define OMAP3430_VDDMAX_MASK				(0xff << 24)
+#define OMAP3430_VDDMIN_SHIFT				16
+#define OMAP3430_VDDMIN_MASK				(0xff << 16)
+#define OMAP3430_TIMEOUT_SHIFT				0
+#define OMAP3430_TIMEOUT_MASK				(0xffff << 0)
+
+/* PRM_VP1_VOLTAGE, PRM_VP2_VOLTAGE shared bits */
+#define OMAP3430_VPVOLTAGE_SHIFT			0
+#define OMAP3430_VPVOLTAGE_MASK				(0xff << 0)
+
+/* PRM_VP1_STATUS, PRM_VP2_STATUS shared bits */
+#define OMAP3430_VPINIDLE				(1 << 0)
+
+/* PM_WKDEP_IVA2, PM_WKDEP_MPU shared bits */
+#define OMAP3430_EN_PER					(1 << 7)
+
+/* PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE shared bits */
+#define OMAP3430_MEMORYCHANGE				(1 << 3)
+
+/* PM_PWSTST_IVA2, PM_PWSTST_CORE shared bits */
+#define OMAP3430_LOGICSTATEST				(1 << 2)
+
+/* PM_PREPWSTST_IVA2, PM_PREPWSTST_CORE shared bits */
+#define OMAP3430_LASTLOGICSTATEENTERED				(1 << 2)
+
+/*
+ * PM_PREPWSTST_IVA2, PM_PREPWSTST_MPU, PM_PREPWSTST_CORE,
+ * PM_PREPWSTST_GFX, PM_PREPWSTST_DSS, PM_PREPWSTST_CAM,
+ * PM_PREPWSTST_PER, PM_PREPWSTST_NEON shared bits
+ */
+#define OMAP3430_LASTPOWERSTATEENTERED_SHIFT			0
+#define OMAP3430_LASTPOWERSTATEENTERED_MASK			(0x3 << 0)
+
+/* PRM_IRQSTATUS_IVA2, PRM_IRQSTATUS_MPU shared bits */
+#define OMAP3430_WKUP_ST				(1 << 0)
+
+/* PRM_IRQENABLE_IVA2, PRM_IRQENABLE_MPU shared bits */
+#define OMAP3430_WKUP_EN					(1 << 0)
+
+/* PM_MPUGRPSEL1_CORE, PM_IVA2GRPSEL1_CORE shared bits */
+#define OMAP3430_GRPSEL_MMC2				(1 << 25)
+#define OMAP3430_GRPSEL_MMC1				(1 << 24)
+#define OMAP3430_GRPSEL_MCSPI4				(1 << 21)
+#define OMAP3430_GRPSEL_MCSPI3				(1 << 20)
+#define OMAP3430_GRPSEL_MCSPI2				(1 << 19)
+#define OMAP3430_GRPSEL_MCSPI1				(1 << 18)
+#define OMAP3430_GRPSEL_I2C3				(1 << 17)
+#define OMAP3430_GRPSEL_I2C2				(1 << 16)
+#define OMAP3430_GRPSEL_I2C1				(1 << 15)
+#define OMAP3430_GRPSEL_UART2				(1 << 14)
+#define OMAP3430_GRPSEL_UART1				(1 << 13)
+#define OMAP3430_GRPSEL_GPT11				(1 << 12)
+#define OMAP3430_GRPSEL_GPT10				(1 << 11)
+#define OMAP3430_GRPSEL_MCBSP5				(1 << 10)
+#define OMAP3430_GRPSEL_MCBSP1				(1 << 9)
+#define OMAP3430_GRPSEL_HSOTGUSB			(1 << 4)
+#define OMAP3430_GRPSEL_D2D				(1 << 3)
+
+/*
+ * PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM,
+ * PM_PWSTCTRL_PER shared bits
+ */
+#define OMAP3430_MEMONSTATE_SHIFT			16
+#define OMAP3430_MEMONSTATE_MASK			(0x3 << 16)
+#define OMAP3430_MEMRETSTATE				(1 << 8)
+
+/* PM_MPUGRPSEL_PER, PM_IVA2GRPSEL_PER shared bits */
+#define OMAP3430_GRPSEL_GPIO6				(1 << 17)
+#define OMAP3430_GRPSEL_GPIO5				(1 << 16)
+#define OMAP3430_GRPSEL_GPIO4				(1 << 15)
+#define OMAP3430_GRPSEL_GPIO3				(1 << 14)
+#define OMAP3430_GRPSEL_GPIO2				(1 << 13)
+#define OMAP3430_GRPSEL_UART3				(1 << 11)
+#define OMAP3430_GRPSEL_GPT9				(1 << 10)
+#define OMAP3430_GRPSEL_GPT8				(1 << 9)
+#define OMAP3430_GRPSEL_GPT7				(1 << 8)
+#define OMAP3430_GRPSEL_GPT6				(1 << 7)
+#define OMAP3430_GRPSEL_GPT5				(1 << 6)
+#define OMAP3430_GRPSEL_GPT4				(1 << 5)
+#define OMAP3430_GRPSEL_GPT3				(1 << 4)
+#define OMAP3430_GRPSEL_GPT2				(1 << 3)
+#define OMAP3430_GRPSEL_MCBSP4				(1 << 2)
+#define OMAP3430_GRPSEL_MCBSP3				(1 << 1)
+#define OMAP3430_GRPSEL_MCBSP2				(1 << 0)
+
+/* PM_MPUGRPSEL_WKUP, PM_IVA2GRPSEL_WKUP shared bits */
+#define OMAP3430_GRPSEL_IO				(1 << 8)
+#define OMAP3430_GRPSEL_SR2				(1 << 7)
+#define OMAP3430_GRPSEL_SR1				(1 << 6)
+#define OMAP3430_GRPSEL_GPIO1				(1 << 3)
+#define OMAP3430_GRPSEL_GPT12				(1 << 1)
+#define OMAP3430_GRPSEL_GPT1				(1 << 0)
+
+/* Bits specific to each register */
+
+/* RM_RSTCTRL_IVA2 */
+#define OMAP3430_RST3_IVA2				(1 << 2)
+#define OMAP3430_RST2_IVA2				(1 << 1)
+#define OMAP3430_RST1_IVA2				(1 << 0)
+
+/* RM_RSTST_IVA2 specific bits */
+#define OMAP3430_EMULATION_VSEQ_RST			(1 << 13)
+#define OMAP3430_EMULATION_VHWA_RST			(1 << 12)
+#define OMAP3430_EMULATION_IVA2_RST			(1 << 11)
+#define OMAP3430_IVA2_SW_RST3				(1 << 10)
+#define OMAP3430_IVA2_SW_RST2				(1 << 9)
+#define OMAP3430_IVA2_SW_RST1				(1 << 8)
+
+/* PM_WKDEP_IVA2 specific bits */
+
+/* PM_PWSTCTRL_IVA2 specific bits */
+#define OMAP3430_L2FLATMEMONSTATE_SHIFT			22
+#define OMAP3430_L2FLATMEMONSTATE_MASK			(0x3 << 22)
+#define OMAP3430_SHAREDL2CACHEFLATONSTATE_SHIFT		20
+#define OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK		(0x3 << 20)
+#define OMAP3430_L1FLATMEMONSTATE_SHIFT			18
+#define OMAP3430_L1FLATMEMONSTATE_MASK			(0x3 << 18)
+#define OMAP3430_SHAREDL1CACHEFLATONSTATE_SHIFT		16
+#define OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK		(0x3 << 16)
+#define OMAP3430_L2FLATMEMRETSTATE			(1 << 11)
+#define OMAP3430_SHAREDL2CACHEFLATRETSTATE		(1 << 10)
+#define OMAP3430_L1FLATMEMRETSTATE			(1 << 9)
+#define OMAP3430_SHAREDL1CACHEFLATRETSTATE		(1 << 8)
+
+/* PM_PWSTST_IVA2 specific bits */
+#define OMAP3430_L2FLATMEMSTATEST_SHIFT			10
+#define OMAP3430_L2FLATMEMSTATEST_MASK			(0x3 << 10)
+#define OMAP3430_SHAREDL2CACHEFLATSTATEST_SHIFT		8
+#define OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK		(0x3 << 8)
+#define OMAP3430_L1FLATMEMSTATEST_SHIFT			6
+#define OMAP3430_L1FLATMEMSTATEST_MASK			(0x3 << 6)
+#define OMAP3430_SHAREDL1CACHEFLATSTATEST_SHIFT		4
+#define OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK		(0x3 << 4)
+
+/* PM_PREPWSTST_IVA2 specific bits */
+#define OMAP3430_LASTL2FLATMEMSTATEENTERED_SHIFT		10
+#define OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK			(0x3 << 10)
+#define OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_SHIFT	8
+#define OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK		(0x3 << 8)
+#define OMAP3430_LASTL1FLATMEMSTATEENTERED_SHIFT		6
+#define OMAP3430_LASTL1FLATMEMSTATEENTERED_MASK			(0x3 << 6)
+#define OMAP3430_LASTSHAREDL1CACHEFLATSTATEENTERED_SHIFT	4
+#define OMAP3430_LASTSHAREDL1CACHEFLATSTATEENTERED_MASK		(0x3 << 4)
+
+/* PRM_IRQSTATUS_IVA2 specific bits */
+#define OMAP3430_PRM_IRQSTATUS_IVA2_IVA2_DPLL_ST	(1 << 2)
+#define OMAP3430_FORCEWKUP_ST				(1 << 1)
+
+/* PRM_IRQENABLE_IVA2 specific bits */
+#define OMAP3430_PRM_IRQENABLE_IVA2_IVA2_DPLL_RECAL_EN		(1 << 2)
+#define OMAP3430_FORCEWKUP_EN					(1 << 1)
+
+/* PRM_REVISION specific bits */
+
+/* PRM_SYSCONFIG specific bits */
+
+/* PRM_IRQSTATUS_MPU specific bits */
+#define OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT		25
+#define OMAP3430ES2_SND_PERIPH_DPLL_ST			(1 << 25)
+#define OMAP3430_VC_TIMEOUTERR_ST			(1 << 24)
+#define OMAP3430_VC_RAERR_ST				(1 << 23)
+#define OMAP3430_VC_SAERR_ST				(1 << 22)
+#define OMAP3430_VP2_TRANXDONE_ST			(1 << 21)
+#define OMAP3430_VP2_EQVALUE_ST				(1 << 20)
+#define OMAP3430_VP2_NOSMPSACK_ST			(1 << 19)
+#define OMAP3430_VP2_MAXVDD_ST				(1 << 18)
+#define OMAP3430_VP2_MINVDD_ST				(1 << 17)
+#define OMAP3430_VP2_OPPCHANGEDONE_ST			(1 << 16)
+#define OMAP3430_VP1_TRANXDONE_ST			(1 << 15)
+#define OMAP3430_VP1_EQVALUE_ST				(1 << 14)
+#define OMAP3430_VP1_NOSMPSACK_ST			(1 << 13)
+#define OMAP3430_VP1_MAXVDD_ST				(1 << 12)
+#define OMAP3430_VP1_MINVDD_ST				(1 << 11)
+#define OMAP3430_VP1_OPPCHANGEDONE_ST			(1 << 10)
+#define OMAP3430_IO_ST					(1 << 9)
+#define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST		(1 << 8)
+#define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT	8
+#define OMAP3430_MPU_DPLL_ST				(1 << 7)
+#define OMAP3430_MPU_DPLL_ST_SHIFT			7
+#define OMAP3430_PERIPH_DPLL_ST				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_ST_SHIFT			6
+#define OMAP3430_CORE_DPLL_ST				(1 << 5)
+#define OMAP3430_CORE_DPLL_ST_SHIFT			5
+#define OMAP3430_TRANSITION_ST				(1 << 4)
+#define OMAP3430_EVGENOFF_ST				(1 << 3)
+#define OMAP3430_EVGENON_ST				(1 << 2)
+#define OMAP3430_FS_USB_WKUP_ST				(1 << 1)
+
+/* PRM_IRQENABLE_MPU specific bits */
+#define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT		25
+#define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN			(1 << 25)
+#define OMAP3430_VC_TIMEOUTERR_EN				(1 << 24)
+#define OMAP3430_VC_RAERR_EN					(1 << 23)
+#define OMAP3430_VC_SAERR_EN					(1 << 22)
+#define OMAP3430_VP2_TRANXDONE_EN				(1 << 21)
+#define OMAP3430_VP2_EQVALUE_EN					(1 << 20)
+#define OMAP3430_VP2_NOSMPSACK_EN				(1 << 19)
+#define OMAP3430_VP2_MAXVDD_EN					(1 << 18)
+#define OMAP3430_VP2_MINVDD_EN					(1 << 17)
+#define OMAP3430_VP2_OPPCHANGEDONE_EN				(1 << 16)
+#define OMAP3430_VP1_TRANXDONE_EN				(1 << 15)
+#define OMAP3430_VP1_EQVALUE_EN					(1 << 14)
+#define OMAP3430_VP1_NOSMPSACK_EN				(1 << 13)
+#define OMAP3430_VP1_MAXVDD_EN					(1 << 12)
+#define OMAP3430_VP1_MINVDD_EN					(1 << 11)
+#define OMAP3430_VP1_OPPCHANGEDONE_EN				(1 << 10)
+#define OMAP3430_IO_EN						(1 << 9)
+#define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN		(1 << 8)
+#define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT	8
+#define OMAP3430_MPU_DPLL_RECAL_EN				(1 << 7)
+#define OMAP3430_MPU_DPLL_RECAL_EN_SHIFT			7
+#define OMAP3430_PERIPH_DPLL_RECAL_EN				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT			6
+#define OMAP3430_CORE_DPLL_RECAL_EN				(1 << 5)
+#define OMAP3430_CORE_DPLL_RECAL_EN_SHIFT			5
+#define OMAP3430_TRANSITION_EN					(1 << 4)
+#define OMAP3430_EVGENOFF_EN					(1 << 3)
+#define OMAP3430_EVGENON_EN					(1 << 2)
+#define OMAP3430_FS_USB_WKUP_EN					(1 << 1)
+
+/* RM_RSTST_MPU specific bits */
+#define OMAP3430_EMULATION_MPU_RST			(1 << 11)
+
+/* PM_WKDEP_MPU specific bits */
+#define OMAP3430_PM_WKDEP_MPU_EN_DSS			(1 << 5)
+#define OMAP3430_PM_WKDEP_MPU_EN_IVA2			(1 << 2)
+
+/* PM_EVGENCTRL_MPU */
+#define OMAP3430_OFFLOADMODE_SHIFT			3
+#define OMAP3430_OFFLOADMODE_MASK			(0x3 << 3)
+#define OMAP3430_ONLOADMODE_SHIFT			1
+#define OMAP3430_ONLOADMODE_MASK			(0x3 << 1)
+#define OMAP3430_ENABLE					(1 << 0)
+
+/* PM_EVGENONTIM_MPU */
+#define OMAP3430_ONTIMEVAL_SHIFT			0
+#define OMAP3430_ONTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PM_EVGENOFFTIM_MPU */
+#define OMAP3430_OFFTIMEVAL_SHIFT			0
+#define OMAP3430_OFFTIMEVAL_MASK			(0xffffffff << 0)
+
+/* PM_PWSTCTRL_MPU specific bits */
+#define OMAP3430_L2CACHEONSTATE_SHIFT			16
+#define OMAP3430_L2CACHEONSTATE_MASK			(0x3 << 16)
+#define OMAP3430_L2CACHERETSTATE			(1 << 8)
+#define OMAP3430_LOGICL1CACHERETSTATE			(1 << 2)
+
+/* PM_PWSTST_MPU specific bits */
+#define OMAP3430_L2CACHESTATEST_SHIFT			6
+#define OMAP3430_L2CACHESTATEST_MASK			(0x3 << 6)
+#define OMAP3430_LOGICL1CACHESTATEST			(1 << 2)
+
+/* PM_PREPWSTST_MPU specific bits */
+#define OMAP3430_LASTL2CACHESTATEENTERED_SHIFT		6
+#define OMAP3430_LASTL2CACHESTATEENTERED_MASK		(0x3 << 6)
+#define OMAP3430_LASTLOGICL1CACHESTATEENTERED		(1 << 2)
+
+/* RM_RSTCTRL_CORE */
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON		(1 << 1)
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST			(1 << 0)
+
+/* RM_RSTST_CORE specific bits */
+#define OMAP3430_MODEM_SECURITY_VIOL_RST		(1 << 10)
+#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RSTPWRON	(1 << 9)
+#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RST		(1 << 8)
+
+/* PM_WKEN1_CORE specific bits */
+
+/* PM_MPUGRPSEL1_CORE specific bits */
+#define OMAP3430_GRPSEL_FSHOSTUSB			(1 << 5)
+
+/* PM_IVA2GRPSEL1_CORE specific bits */
+
+/* PM_WKST1_CORE specific bits */
+
+/* PM_PWSTCTRL_CORE specific bits */
+#define OMAP3430_MEM2ONSTATE_SHIFT			18
+#define OMAP3430_MEM2ONSTATE_MASK			(0x3 << 18)
+#define OMAP3430_MEM1ONSTATE_SHIFT			16
+#define OMAP3430_MEM1ONSTATE_MASK			(0x3 << 16)
+#define OMAP3430_MEM2RETSTATE				(1 << 9)
+#define OMAP3430_MEM1RETSTATE				(1 << 8)
+
+/* PM_PWSTST_CORE specific bits */
+#define OMAP3430_MEM2STATEST_SHIFT			6
+#define OMAP3430_MEM2STATEST_MASK			(0x3 << 6)
+#define OMAP3430_MEM1STATEST_SHIFT			4
+#define OMAP3430_MEM1STATEST_MASK			(0x3 << 4)
+
+/* PM_PREPWSTST_CORE specific bits */
+#define OMAP3430_LASTMEM2STATEENTERED_SHIFT		6
+#define OMAP3430_LASTMEM2STATEENTERED_MASK		(0x3 << 6)
+#define OMAP3430_LASTMEM1STATEENTERED_SHIFT		4
+#define OMAP3430_LASTMEM1STATEENTERED_MASK		(0x3 << 4)
+
+/* RM_RSTST_GFX specific bits */
+
+/* PM_WKDEP_GFX specific bits */
+#define OMAP3430_PM_WKDEP_GFX_EN_IVA2			(1 << 2)
+
+/* PM_PWSTCTRL_GFX specific bits */
+
+/* PM_PWSTST_GFX specific bits */
+
+/* PM_PREPWSTST_GFX specific bits */
+
+/* PM_WKEN_WKUP specific bits */
+#define OMAP3430_EN_IO					(1 << 8)
+
+/* PM_MPUGRPSEL_WKUP specific bits */
+
+/* PM_IVA2GRPSEL_WKUP specific bits */
+
+/* PM_WKST_WKUP specific bits */
+#define OMAP3430_ST_IO					(1 << 8)
+
+/* PRM_CLKSEL */
+#define OMAP3430_SYS_CLKIN_SEL_SHIFT			0
+#define OMAP3430_SYS_CLKIN_SEL_MASK			(0x7 << 0)
+
+/* PRM_CLKOUT_CTRL */
+#define OMAP3430_CLKOUT_EN				(1 << 7)
+#define OMAP3430_CLKOUT_EN_SHIFT			7
+
+/* RM_RSTST_DSS specific bits */
+
+/* PM_WKEN_DSS */
+#define OMAP3430_PM_WKEN_DSS_EN_DSS			(1 << 0)
+
+/* PM_WKDEP_DSS specific bits */
+#define OMAP3430_PM_WKDEP_DSS_EN_IVA2			(1 << 2)
+
+/* PM_PWSTCTRL_DSS specific bits */
+
+/* PM_PWSTST_DSS specific bits */
+
+/* PM_PREPWSTST_DSS specific bits */
+
+/* RM_RSTST_CAM specific bits */
+
+/* PM_WKDEP_CAM specific bits */
+#define OMAP3430_PM_WKDEP_CAM_EN_IVA2			(1 << 2)
+
+/* PM_PWSTCTRL_CAM specific bits */
+
+/* PM_PWSTST_CAM specific bits */
+
+/* PM_PREPWSTST_CAM specific bits */
+
+/* PM_PWSTCTRL_USBHOST specific bits */
+#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
+
+/* RM_RSTST_PER specific bits */
+
+/* PM_WKEN_PER specific bits */
+
+/* PM_MPUGRPSEL_PER specific bits */
+
+/* PM_IVA2GRPSEL_PER specific bits */
+
+/* PM_WKST_PER specific bits */
+
+/* PM_WKDEP_PER specific bits */
+#define OMAP3430_PM_WKDEP_PER_EN_IVA2			(1 << 2)
+
+/* PM_PWSTCTRL_PER specific bits */
+
+/* PM_PWSTST_PER specific bits */
+
+/* PM_PREPWSTST_PER specific bits */
+
+/* RM_RSTST_EMU specific bits */
+
+/* PM_PWSTST_EMU specific bits */
+
+/* PRM_VC_SMPS_SA */
+#define OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT		16
+#define OMAP3430_PRM_VC_SMPS_SA_SA1_MASK		(0x7f << 16)
+#define OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT		0
+#define OMAP3430_PRM_VC_SMPS_SA_SA0_MASK		(0x7f << 0)
+
+/* PRM_VC_SMPS_VOL_RA */
+#define OMAP3430_VOLRA1_SHIFT				16
+#define OMAP3430_VOLRA1_MASK				(0xff << 16)
+#define OMAP3430_VOLRA0_SHIFT				0
+#define OMAP3430_VOLRA0_MASK				(0xff << 0)
+
+/* PRM_VC_SMPS_CMD_RA */
+#define OMAP3430_CMDRA1_SHIFT				16
+#define OMAP3430_CMDRA1_MASK				(0xff << 16)
+#define OMAP3430_CMDRA0_SHIFT				0
+#define OMAP3430_CMDRA0_MASK				(0xff << 0)
+
+/* PRM_VC_CMD_VAL_0 specific bits */
+
+/* PRM_VC_CMD_VAL_1 specific bits */
+
+/* PRM_VC_CH_CONF */
+#define OMAP3430_CMD1					(1 << 20)
+#define OMAP3430_RACEN1					(1 << 19)
+#define OMAP3430_RAC1					(1 << 18)
+#define OMAP3430_RAV1					(1 << 17)
+#define OMAP3430_PRM_VC_CH_CONF_SA1			(1 << 16)
+#define OMAP3430_CMD0					(1 << 4)
+#define OMAP3430_RACEN0					(1 << 3)
+#define OMAP3430_RAC0					(1 << 2)
+#define OMAP3430_RAV0					(1 << 1)
+#define OMAP3430_PRM_VC_CH_CONF_SA0			(1 << 0)
+
+/* PRM_VC_I2C_CFG */
+#define OMAP3430_HSMASTER				(1 << 5)
+#define OMAP3430_SREN					(1 << 4)
+#define OMAP3430_HSEN					(1 << 3)
+#define OMAP3430_MCODE_SHIFT				0
+#define OMAP3430_MCODE_MASK				(0x7 << 0)
+
+/* PRM_VC_BYPASS_VAL */
+#define OMAP3430_VALID					(1 << 24)
+#define OMAP3430_DATA_SHIFT				16
+#define OMAP3430_DATA_MASK				(0xff << 16)
+#define OMAP3430_REGADDR_SHIFT				8
+#define OMAP3430_REGADDR_MASK				(0xff << 8)
+#define OMAP3430_SLAVEADDR_SHIFT			0
+#define OMAP3430_SLAVEADDR_MASK				(0x7f << 0)
+
+/* PRM_RSTCTRL */
+#define OMAP3430_RST_DPLL3				(1 << 2)
+#define OMAP3430_RST_GS					(1 << 1)
+
+/* PRM_RSTTIME */
+#define OMAP3430_RSTTIME2_SHIFT				8
+#define OMAP3430_RSTTIME2_MASK				(0x1f << 8)
+#define OMAP3430_RSTTIME1_SHIFT				0
+#define OMAP3430_RSTTIME1_MASK				(0xff << 0)
+
+/* PRM_RSTST */
+#define OMAP3430_ICECRUSHER_RST				(1 << 10)
+#define OMAP3430_ICEPICK_RST				(1 << 9)
+#define OMAP3430_VDD2_VOLTAGE_MANAGER_RST		(1 << 8)
+#define OMAP3430_VDD1_VOLTAGE_MANAGER_RST		(1 << 7)
+#define OMAP3430_EXTERNAL_WARM_RST			(1 << 6)
+#define OMAP3430_SECURE_WD_RST				(1 << 5)
+#define OMAP3430_MPU_WD_RST				(1 << 4)
+#define OMAP3430_SECURITY_VIOL_RST			(1 << 3)
+#define OMAP3430_GLOBAL_SW_RST				(1 << 1)
+#define OMAP3430_GLOBAL_COLD_RST			(1 << 0)
+
+/* PRM_VOLTCTRL */
+#define OMAP3430_SEL_VMODE				(1 << 4)
+#define OMAP3430_SEL_OFF				(1 << 3)
+#define OMAP3430_AUTO_OFF				(1 << 2)
+#define OMAP3430_AUTO_RET				(1 << 1)
+#define OMAP3430_AUTO_SLEEP				(1 << 0)
+
+/* PRM_SRAM_PCHARGE */
+#define OMAP3430_PCHARGE_TIME_SHIFT			0
+#define OMAP3430_PCHARGE_TIME_MASK			(0xff << 0)
+
+/* PRM_CLKSRC_CTRL */
+#define OMAP3430_SYSCLKDIV_SHIFT			6
+#define OMAP3430_SYSCLKDIV_MASK				(0x3 << 6)
+#define OMAP3430_AUTOEXTCLKMODE_SHIFT			3
+#define OMAP3430_AUTOEXTCLKMODE_MASK			(0x3 << 3)
+#define OMAP3430_SYSCLKSEL_SHIFT			0
+#define OMAP3430_SYSCLKSEL_MASK				(0x3 << 0)
+
+/* PRM_VOLTSETUP1 */
+#define OMAP3430_SETUP_TIME2_SHIFT			16
+#define OMAP3430_SETUP_TIME2_MASK			(0xffff << 16)
+#define OMAP3430_SETUP_TIME1_SHIFT			0
+#define OMAP3430_SETUP_TIME1_MASK			(0xffff << 0)
+
+/* PRM_VOLTOFFSET */
+#define OMAP3430_OFFSET_TIME_SHIFT			0
+#define OMAP3430_OFFSET_TIME_MASK			(0xffff << 0)
+
+/* PRM_CLKSETUP */
+#define OMAP3430_SETUP_TIME_SHIFT			0
+#define OMAP3430_SETUP_TIME_MASK			(0xffff << 0)
+
+/* PRM_POLCTRL */
+#define OMAP3430_OFFMODE_POL				(1 << 3)
+#define OMAP3430_CLKOUT_POL				(1 << 2)
+#define OMAP3430_CLKREQ_POL				(1 << 1)
+#define OMAP3430_EXTVOL_POL				(1 << 0)
+
+/* PRM_VOLTSETUP2 */
+#define OMAP3430_OFFMODESETUPTIME_SHIFT			0
+#define OMAP3430_OFFMODESETUPTIME_MASK			(0xffff << 0)
+
+/* PRM_VP1_CONFIG specific bits */
+
+/* PRM_VP1_VSTEPMIN specific bits */
+
+/* PRM_VP1_VSTEPMAX specific bits */
+
+/* PRM_VP1_VLIMITTO specific bits */
+
+/* PRM_VP1_VOLTAGE specific bits */
+
+/* PRM_VP1_STATUS specific bits */
+
+/* PRM_VP2_CONFIG specific bits */
+
+/* PRM_VP2_VSTEPMIN specific bits */
+
+/* PRM_VP2_VSTEPMAX specific bits */
+
+/* PRM_VP2_VLIMITTO specific bits */
+
+/* PRM_VP2_VOLTAGE specific bits */
+
+/* PRM_VP2_STATUS specific bits */
+
+/* RM_RSTST_NEON specific bits */
+
+/* PM_WKDEP_NEON specific bits */
+
+/* PM_PWSTCTRL_NEON specific bits */
+
+/* PM_PWSTST_NEON specific bits */
+
+/* PM_PREPWSTST_NEON specific bits */
+
+#endif
-- 
1.5.3.6


--fWddYNRDgTk9wQGZ--
