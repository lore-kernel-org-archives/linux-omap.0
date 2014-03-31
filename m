From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 47/55] ARM: OMAP2+: PRM: move prcm-common.h header to public location
Date: Mon, 31 Mar 2014 18:16:26 +0300
Message-ID: <1396278994-12624-48-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39366 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbaCaPUV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:20:21 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c                     |    2 +-
 arch/arm/mach-omap2/cm2xxx.h                     |    2 +-
 arch/arm/mach-omap2/cm33xx.c                     |    2 +-
 arch/arm/mach-omap2/cm3xxx.c                     |    2 +-
 arch/arm/mach-omap2/cm3xxx.h                     |    2 +-
 arch/arm/mach-omap2/cm_common.c                  |    2 +-
 arch/arm/mach-omap2/cminst44xx.c                 |    2 +-
 arch/arm/mach-omap2/pm.c                         |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains33xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains43xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains54xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains7xx_data.c       |    2 +-
 arch/arm/mach-omap2/prcm-common.h                |  537 ----------------------
 arch/arm/mach-omap2/prm.h                        |    2 +-
 arch/arm/mach-omap2/prm2xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx_private.h       |    2 +-
 arch/arm/mach-omap2/prm33xx.h                    |    2 +-
 arch/arm/mach-omap2/prm3xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm44xx.c                    |    2 +-
 arch/arm/mach-omap2/prm44xx.h                    |    2 +-
 arch/arm/mach-omap2/prm54xx.h                    |    2 +-
 arch/arm/mach-omap2/prm7xx.h                     |    2 +-
 arch/arm/mach-omap2/prm_common.c                 |    2 +-
 arch/arm/mach-omap2/prminst44xx.c                |    2 +-
 include/linux/power/omap/prcm-common.h           |  536 +++++++++++++++++++++
 29 files changed, 563 insertions(+), 564 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prcm-common.h
 create mode 100644 include/linux/power/omap/prcm-common.h

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 2385498..f7365c7 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -23,7 +23,7 @@
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx.h>
 #include "clockdomain.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 80e9892..169541e 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_CM2XXX_H
 #define __ARCH_ASM_MACH_OMAP2_CM2XXX_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx.h>
 
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 43e4f26..1f68cde 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -26,7 +26,7 @@
 #include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm33xx.h>
 #include <linux/power/omap/prm33xx.h>
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 #define AM33XX_MODULEMODE_SHIFT			0
 #define AM33XX_MODULEMODE_MASK			(0x3 << 0)
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index a80cd3e..01c69f2 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -23,7 +23,7 @@
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm3xxx.h>
 #include "clockdomain.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 5fdc14c..23846ff 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_CM3XXX_H
 #define __ARCH_ASM_MACH_OMAP2_CM3XXX_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include <linux/power/omap/cm3xxx.h>
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 3843f1f..0a21fa9 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -19,7 +19,7 @@
 #include <linux/power/omap/cm2xxx.h>
 #include <linux/power/omap/cm3xxx.h>
 #include <linux/power/omap/cm.h>
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 /*
  * cm_ll_data: function pointers to SoC-specific implementations of
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 084e5ce..5ebd8e3 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -30,7 +30,7 @@
 #include "prcm44xx.h"
 #include <linux/power/omap/prm44xx.h>
 #include "prcm_mpu44xx.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 #define OMAP4430_IDLEST_SHIFT		16
 #define OMAP4430_IDLEST_MASK		(0x3 << 16)
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e1b4141..f464aed 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -25,7 +25,7 @@
 #include "common.h"
 
 #include "soc.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "voltage.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 7b946f1..57abec8 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -33,7 +33,7 @@
 
 #include "powerdomain.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 
 /* OMAP2/3-common powerdomains */
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 266bd96..9506c0e 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -18,7 +18,7 @@
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm-regbits-24xx.h"
 
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
index 869adb8..0a7a5ca 100644
--- a/arch/arm/mach-omap2/powerdomains33xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -17,7 +17,7 @@
 #include <linux/init.h>
 
 #include "powerdomain.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm-regbits-33xx.h"
 #include "prm33xx.h"
 
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 7ba44db..be12876 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -18,7 +18,7 @@
 #include "soc.h"
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm-regbits-34xx.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
diff --git a/arch/arm/mach-omap2/powerdomains43xx_data.c b/arch/arm/mach-omap2/powerdomains43xx_data.c
index 95fee54..b99eac7 100644
--- a/arch/arm/mach-omap2/powerdomains43xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains43xx_data.c
@@ -13,7 +13,7 @@
 
 #include "powerdomain.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prcm44xx.h"
 #include "prcm43xx.h"
 
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 704664c..ea1ffc1 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -24,7 +24,7 @@
 
 #include "powerdomain.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prcm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains54xx_data.c b/arch/arm/mach-omap2/powerdomains54xx_data.c
index ce1d752..b4a815b 100644
--- a/arch/arm/mach-omap2/powerdomains54xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains54xx_data.c
@@ -23,7 +23,7 @@
 
 #include "powerdomain.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prcm44xx.h"
 #include "prm54xx.h"
 #include "prcm_mpu54xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 48151d1..cf33ef6 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -25,7 +25,7 @@
 
 #include "powerdomain.h"
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prcm44xx.h"
 #include "prm7xx.h"
 #include "prcm_mpu7xx.h"
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
deleted file mode 100644
index 1a05d04..0000000
--- a/arch/arm/mach-omap2/prcm-common.h
+++ /dev/null
@@ -1,537 +0,0 @@
-#ifndef __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
-#define __ARCH_ASM_MACH_OMAP2_PRCM_COMMON_H
-
-/*
- * OMAP2/3 PRCM base and module definitions
- *
- * Copyright (C) 2007-2009, 2011 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
- *
- * Written by Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/* Module offsets from both CM_BASE & PRM_BASE */
-
-/*
- * Offsets that are the same on 24xx and 34xx
- *
- * Technically, in terms of the TRM, OCP_MOD is 34xx only; PLL_MOD is
- * CCR_MOD on 3430; and GFX_MOD only exists < 3430ES2.
- */
-#define OCP_MOD						0x000
-#define MPU_MOD						0x100
-#define CORE_MOD					0x200
-#define GFX_MOD						0x300
-#define WKUP_MOD					0x400
-#define PLL_MOD						0x500
-
-
-/* Chip-specific module offsets */
-#define OMAP24XX_GR_MOD					OCP_MOD
-#define OMAP24XX_DSP_MOD				0x800
-
-#define OMAP2430_MDM_MOD				0xc00
-
-/* IVA2 module is < base on 3430 */
-#define OMAP3430_IVA2_MOD				-0x800
-#define OMAP3430ES2_SGX_MOD				GFX_MOD
-#define OMAP3430_CCR_MOD				PLL_MOD
-#define OMAP3430_DSS_MOD				0x600
-#define OMAP3430_CAM_MOD				0x700
-#define OMAP3430_PER_MOD				0x800
-#define OMAP3430_EMU_MOD				0x900
-#define OMAP3430_GR_MOD					0xa00
-#define OMAP3430_NEON_MOD				0xb00
-#define OMAP3430ES2_USBHOST_MOD				0xc00
-
-/*
- * TI81XX PRM module offsets
- */
-#define TI81XX_PRM_DEVICE_MOD			0x0000
-#define TI816X_PRM_ACTIVE_MOD			0x0a00
-#define TI81XX_PRM_DEFAULT_MOD			0x0b00
-#define TI816X_PRM_IVAHD0_MOD			0x0c00
-#define TI816X_PRM_IVAHD1_MOD			0x0d00
-#define TI816X_PRM_IVAHD2_MOD			0x0e00
-#define TI816X_PRM_SGX_MOD				0x0f00
-#define TI81XX_PRM_ALWON_MOD			0x1800
-
-/* 24XX register bits shared between CM & PRM registers */
-
-/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
-#define OMAP2420_EN_MMC_SHIFT				26
-#define OMAP2420_EN_MMC_MASK				(1 << 26)
-#define OMAP24XX_EN_UART2_SHIFT				22
-#define OMAP24XX_EN_UART2_MASK				(1 << 22)
-#define OMAP24XX_EN_UART1_SHIFT				21
-#define OMAP24XX_EN_UART1_MASK				(1 << 21)
-#define OMAP24XX_EN_MCSPI2_SHIFT			18
-#define OMAP24XX_EN_MCSPI2_MASK				(1 << 18)
-#define OMAP24XX_EN_MCSPI1_SHIFT			17
-#define OMAP24XX_EN_MCSPI1_MASK				(1 << 17)
-#define OMAP24XX_EN_MCBSP2_SHIFT			16
-#define OMAP24XX_EN_MCBSP2_MASK				(1 << 16)
-#define OMAP24XX_EN_MCBSP1_SHIFT			15
-#define OMAP24XX_EN_MCBSP1_MASK				(1 << 15)
-#define OMAP24XX_EN_GPT12_SHIFT				14
-#define OMAP24XX_EN_GPT12_MASK				(1 << 14)
-#define OMAP24XX_EN_GPT11_SHIFT				13
-#define OMAP24XX_EN_GPT11_MASK				(1 << 13)
-#define OMAP24XX_EN_GPT10_SHIFT				12
-#define OMAP24XX_EN_GPT10_MASK				(1 << 12)
-#define OMAP24XX_EN_GPT9_SHIFT				11
-#define OMAP24XX_EN_GPT9_MASK				(1 << 11)
-#define OMAP24XX_EN_GPT8_SHIFT				10
-#define OMAP24XX_EN_GPT8_MASK				(1 << 10)
-#define OMAP24XX_EN_GPT7_SHIFT				9
-#define OMAP24XX_EN_GPT7_MASK				(1 << 9)
-#define OMAP24XX_EN_GPT6_SHIFT				8
-#define OMAP24XX_EN_GPT6_MASK				(1 << 8)
-#define OMAP24XX_EN_GPT5_SHIFT				7
-#define OMAP24XX_EN_GPT5_MASK				(1 << 7)
-#define OMAP24XX_EN_GPT4_SHIFT				6
-#define OMAP24XX_EN_GPT4_MASK				(1 << 6)
-#define OMAP24XX_EN_GPT3_SHIFT				5
-#define OMAP24XX_EN_GPT3_MASK				(1 << 5)
-#define OMAP24XX_EN_GPT2_SHIFT				4
-#define OMAP24XX_EN_GPT2_MASK				(1 << 4)
-#define OMAP2420_EN_VLYNQ_SHIFT				3
-#define OMAP2420_EN_VLYNQ_MASK				(1 << 3)
-
-/* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
-#define OMAP2430_EN_GPIO5_SHIFT				10
-#define OMAP2430_EN_GPIO5_MASK				(1 << 10)
-#define OMAP2430_EN_MCSPI3_SHIFT			9
-#define OMAP2430_EN_MCSPI3_MASK				(1 << 9)
-#define OMAP2430_EN_MMCHS2_SHIFT			8
-#define OMAP2430_EN_MMCHS2_MASK				(1 << 8)
-#define OMAP2430_EN_MMCHS1_SHIFT			7
-#define OMAP2430_EN_MMCHS1_MASK				(1 << 7)
-#define OMAP24XX_EN_UART3_SHIFT				2
-#define OMAP24XX_EN_UART3_MASK				(1 << 2)
-#define OMAP24XX_EN_USB_SHIFT				0
-#define OMAP24XX_EN_USB_MASK				(1 << 0)
-
-/* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
-#define OMAP2430_EN_MDM_INTC_SHIFT			11
-#define OMAP2430_EN_MDM_INTC_MASK			(1 << 11)
-#define OMAP2430_EN_USBHS_SHIFT				6
-#define OMAP2430_EN_USBHS_MASK				(1 << 6)
-#define OMAP24XX_EN_GPMC_SHIFT				1
-#define OMAP24XX_EN_GPMC_MASK				(1 << 1)
-
-/* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
-#define OMAP2420_ST_MMC_SHIFT				26
-#define OMAP2420_ST_MMC_MASK				(1 << 26)
-#define OMAP24XX_ST_UART2_SHIFT				22
-#define OMAP24XX_ST_UART2_MASK				(1 << 22)
-#define OMAP24XX_ST_UART1_SHIFT				21
-#define OMAP24XX_ST_UART1_MASK				(1 << 21)
-#define OMAP24XX_ST_MCSPI2_SHIFT			18
-#define OMAP24XX_ST_MCSPI2_MASK				(1 << 18)
-#define OMAP24XX_ST_MCSPI1_SHIFT			17
-#define OMAP24XX_ST_MCSPI1_MASK				(1 << 17)
-#define OMAP24XX_ST_MCBSP2_SHIFT			16
-#define OMAP24XX_ST_MCBSP2_MASK				(1 << 16)
-#define OMAP24XX_ST_MCBSP1_SHIFT			15
-#define OMAP24XX_ST_MCBSP1_MASK				(1 << 15)
-#define OMAP24XX_ST_GPT12_SHIFT				14
-#define OMAP24XX_ST_GPT12_MASK				(1 << 14)
-#define OMAP24XX_ST_GPT11_SHIFT				13
-#define OMAP24XX_ST_GPT11_MASK				(1 << 13)
-#define OMAP24XX_ST_GPT10_SHIFT				12
-#define OMAP24XX_ST_GPT10_MASK				(1 << 12)
-#define OMAP24XX_ST_GPT9_SHIFT				11
-#define OMAP24XX_ST_GPT9_MASK				(1 << 11)
-#define OMAP24XX_ST_GPT8_SHIFT				10
-#define OMAP24XX_ST_GPT8_MASK				(1 << 10)
-#define OMAP24XX_ST_GPT7_SHIFT				9
-#define OMAP24XX_ST_GPT7_MASK				(1 << 9)
-#define OMAP24XX_ST_GPT6_SHIFT				8
-#define OMAP24XX_ST_GPT6_MASK				(1 << 8)
-#define OMAP24XX_ST_GPT5_SHIFT				7
-#define OMAP24XX_ST_GPT5_MASK				(1 << 7)
-#define OMAP24XX_ST_GPT4_SHIFT				6
-#define OMAP24XX_ST_GPT4_MASK				(1 << 6)
-#define OMAP24XX_ST_GPT3_SHIFT				5
-#define OMAP24XX_ST_GPT3_MASK				(1 << 5)
-#define OMAP24XX_ST_GPT2_SHIFT				4
-#define OMAP24XX_ST_GPT2_MASK				(1 << 4)
-#define OMAP2420_ST_VLYNQ_SHIFT				3
-#define OMAP2420_ST_VLYNQ_MASK				(1 << 3)
-
-/* CM_IDLEST2_CORE, PM_WKST2_CORE shared bits */
-#define OMAP2430_ST_MDM_INTC_SHIFT			11
-#define OMAP2430_ST_MDM_INTC_MASK			(1 << 11)
-#define OMAP2430_ST_GPIO5_SHIFT				10
-#define OMAP2430_ST_GPIO5_MASK				(1 << 10)
-#define OMAP2430_ST_MCSPI3_SHIFT			9
-#define OMAP2430_ST_MCSPI3_MASK				(1 << 9)
-#define OMAP2430_ST_MMCHS2_SHIFT			8
-#define OMAP2430_ST_MMCHS2_MASK				(1 << 8)
-#define OMAP2430_ST_MMCHS1_SHIFT			7
-#define OMAP2430_ST_MMCHS1_MASK				(1 << 7)
-#define OMAP2430_ST_USBHS_SHIFT				6
-#define OMAP2430_ST_USBHS_MASK				(1 << 6)
-#define OMAP24XX_ST_UART3_SHIFT				2
-#define OMAP24XX_ST_UART3_MASK				(1 << 2)
-#define OMAP24XX_ST_USB_SHIFT				0
-#define OMAP24XX_ST_USB_MASK				(1 << 0)
-
-/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP24XX_EN_GPIOS_SHIFT				2
-#define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
-#define OMAP24XX_EN_GPT1_SHIFT				0
-#define OMAP24XX_EN_GPT1_MASK				(1 << 0)
-
-/* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
-#define OMAP24XX_ST_GPIOS_SHIFT				2
-#define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
-#define OMAP24XX_ST_32KSYNC_SHIFT			1
-#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
-#define OMAP24XX_ST_GPT1_SHIFT				0
-#define OMAP24XX_ST_GPT1_MASK				(1 << 0)
-
-/* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
-#define OMAP2430_ST_MDM_SHIFT				0
-#define OMAP2430_ST_MDM_MASK				(1 << 0)
-
-
-/* 3430 register bits shared between CM & PRM registers */
-
-/* CM_REVISION, PRM_REVISION shared bits */
-#define OMAP3430_REV_SHIFT				0
-#define OMAP3430_REV_MASK				(0xff << 0)
-
-/* CM_SYSCONFIG, PRM_SYSCONFIG shared bits */
-#define OMAP3430_AUTOIDLE_MASK				(1 << 0)
-
-/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
-#define OMAP3430_EN_MMC3_MASK				(1 << 30)
-#define OMAP3430_EN_MMC3_SHIFT				30
-#define OMAP3430_EN_MMC2_MASK				(1 << 25)
-#define OMAP3430_EN_MMC2_SHIFT				25
-#define OMAP3430_EN_MMC1_MASK				(1 << 24)
-#define OMAP3430_EN_MMC1_SHIFT				24
-#define AM35XX_EN_UART4_MASK				(1 << 23)
-#define AM35XX_EN_UART4_SHIFT				23
-#define OMAP3430_EN_MCSPI4_MASK				(1 << 21)
-#define OMAP3430_EN_MCSPI4_SHIFT			21
-#define OMAP3430_EN_MCSPI3_MASK				(1 << 20)
-#define OMAP3430_EN_MCSPI3_SHIFT			20
-#define OMAP3430_EN_MCSPI2_MASK				(1 << 19)
-#define OMAP3430_EN_MCSPI2_SHIFT			19
-#define OMAP3430_EN_MCSPI1_MASK				(1 << 18)
-#define OMAP3430_EN_MCSPI1_SHIFT			18
-#define OMAP3430_EN_I2C3_MASK				(1 << 17)
-#define OMAP3430_EN_I2C3_SHIFT				17
-#define OMAP3430_EN_I2C2_MASK				(1 << 16)
-#define OMAP3430_EN_I2C2_SHIFT				16
-#define OMAP3430_EN_I2C1_MASK				(1 << 15)
-#define OMAP3430_EN_I2C1_SHIFT				15
-#define OMAP3430_EN_UART2_MASK				(1 << 14)
-#define OMAP3430_EN_UART2_SHIFT				14
-#define OMAP3430_EN_UART1_MASK				(1 << 13)
-#define OMAP3430_EN_UART1_SHIFT				13
-#define OMAP3430_EN_GPT11_MASK				(1 << 12)
-#define OMAP3430_EN_GPT11_SHIFT				12
-#define OMAP3430_EN_GPT10_MASK				(1 << 11)
-#define OMAP3430_EN_GPT10_SHIFT				11
-#define OMAP3430_EN_MCBSP5_MASK				(1 << 10)
-#define OMAP3430_EN_MCBSP5_SHIFT			10
-#define OMAP3430_EN_MCBSP1_MASK				(1 << 9)
-#define OMAP3430_EN_MCBSP1_SHIFT			9
-#define OMAP3430_EN_FSHOSTUSB_MASK			(1 << 5)
-#define OMAP3430_EN_FSHOSTUSB_SHIFT			5
-#define OMAP3430_EN_D2D_MASK				(1 << 3)
-#define OMAP3430_EN_D2D_SHIFT				3
-
-/* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
-#define OMAP3430_EN_HSOTGUSB_MASK			(1 << 4)
-#define OMAP3430_EN_HSOTGUSB_SHIFT			4
-
-/* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
-#define OMAP3430_ST_MMC3_SHIFT				30
-#define OMAP3430_ST_MMC3_MASK				(1 << 30)
-#define OMAP3430_ST_MMC2_SHIFT				25
-#define OMAP3430_ST_MMC2_MASK				(1 << 25)
-#define OMAP3430_ST_MMC1_SHIFT				24
-#define OMAP3430_ST_MMC1_MASK				(1 << 24)
-#define OMAP3430_ST_MCSPI4_SHIFT			21
-#define OMAP3430_ST_MCSPI4_MASK				(1 << 21)
-#define OMAP3430_ST_MCSPI3_SHIFT			20
-#define OMAP3430_ST_MCSPI3_MASK				(1 << 20)
-#define OMAP3430_ST_MCSPI2_SHIFT			19
-#define OMAP3430_ST_MCSPI2_MASK				(1 << 19)
-#define OMAP3430_ST_MCSPI1_SHIFT			18
-#define OMAP3430_ST_MCSPI1_MASK				(1 << 18)
-#define OMAP3430_ST_I2C3_SHIFT				17
-#define OMAP3430_ST_I2C3_MASK				(1 << 17)
-#define OMAP3430_ST_I2C2_SHIFT				16
-#define OMAP3430_ST_I2C2_MASK				(1 << 16)
-#define OMAP3430_ST_I2C1_SHIFT				15
-#define OMAP3430_ST_I2C1_MASK				(1 << 15)
-#define OMAP3430_ST_UART2_SHIFT				14
-#define OMAP3430_ST_UART2_MASK				(1 << 14)
-#define OMAP3430_ST_UART1_SHIFT				13
-#define OMAP3430_ST_UART1_MASK				(1 << 13)
-#define OMAP3430_ST_GPT11_SHIFT				12
-#define OMAP3430_ST_GPT11_MASK				(1 << 12)
-#define OMAP3430_ST_GPT10_SHIFT				11
-#define OMAP3430_ST_GPT10_MASK				(1 << 11)
-#define OMAP3430_ST_MCBSP5_SHIFT			10
-#define OMAP3430_ST_MCBSP5_MASK				(1 << 10)
-#define OMAP3430_ST_MCBSP1_SHIFT			9
-#define OMAP3430_ST_MCBSP1_MASK				(1 << 9)
-#define OMAP3430ES1_ST_FSHOSTUSB_SHIFT			5
-#define OMAP3430ES1_ST_FSHOSTUSB_MASK			(1 << 5)
-#define OMAP3430ES1_ST_HSOTGUSB_SHIFT			4
-#define OMAP3430ES1_ST_HSOTGUSB_MASK			(1 << 4)
-#define OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT		5
-#define OMAP3430ES2_ST_HSOTGUSB_IDLE_MASK		(1 << 5)
-#define OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT		4
-#define OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK		(1 << 4)
-#define OMAP3430_ST_D2D_SHIFT				3
-#define OMAP3430_ST_D2D_MASK				(1 << 3)
-
-/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_GPIO1_MASK				(1 << 3)
-#define OMAP3430_EN_GPIO1_SHIFT				3
-#define OMAP3430_EN_GPT12_MASK				(1 << 1)
-#define OMAP3430_EN_GPT12_SHIFT				1
-#define OMAP3430_EN_GPT1_MASK				(1 << 0)
-#define OMAP3430_EN_GPT1_SHIFT				0
-
-/* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_SR2_MASK				(1 << 7)
-#define OMAP3430_EN_SR2_SHIFT				7
-#define OMAP3430_EN_SR1_MASK				(1 << 6)
-#define OMAP3430_EN_SR1_SHIFT				6
-
-/* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_GPT12_MASK				(1 << 1)
-#define OMAP3430_EN_GPT12_SHIFT				1
-
-/* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
-#define OMAP3430_ST_SR2_SHIFT				7
-#define OMAP3430_ST_SR2_MASK				(1 << 7)
-#define OMAP3430_ST_SR1_SHIFT				6
-#define OMAP3430_ST_SR1_MASK				(1 << 6)
-#define OMAP3430_ST_GPIO1_SHIFT				3
-#define OMAP3430_ST_GPIO1_MASK				(1 << 3)
-#define OMAP3430_ST_32KSYNC_SHIFT			2
-#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
-#define OMAP3430_ST_GPT12_SHIFT				1
-#define OMAP3430_ST_GPT12_MASK				(1 << 1)
-#define OMAP3430_ST_GPT1_SHIFT				0
-#define OMAP3430_ST_GPT1_MASK				(1 << 0)
-
-/*
- * CM_SLEEPDEP_GFX, CM_SLEEPDEP_DSS, CM_SLEEPDEP_CAM,
- * CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_GFX,
- * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
- */
-#define OMAP3430_EN_MPU_MASK				(1 << 1)
-#define OMAP3430_EN_MPU_SHIFT				1
-
-/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
-
-#define OMAP3630_EN_UART4_MASK				(1 << 18)
-#define OMAP3630_EN_UART4_SHIFT				18
-#define OMAP3430_EN_GPIO6_MASK				(1 << 17)
-#define OMAP3430_EN_GPIO6_SHIFT				17
-#define OMAP3430_EN_GPIO5_MASK				(1 << 16)
-#define OMAP3430_EN_GPIO5_SHIFT				16
-#define OMAP3430_EN_GPIO4_MASK				(1 << 15)
-#define OMAP3430_EN_GPIO4_SHIFT				15
-#define OMAP3430_EN_GPIO3_MASK				(1 << 14)
-#define OMAP3430_EN_GPIO3_SHIFT				14
-#define OMAP3430_EN_GPIO2_MASK				(1 << 13)
-#define OMAP3430_EN_GPIO2_SHIFT				13
-#define OMAP3430_EN_UART3_MASK				(1 << 11)
-#define OMAP3430_EN_UART3_SHIFT				11
-#define OMAP3430_EN_GPT9_MASK				(1 << 10)
-#define OMAP3430_EN_GPT9_SHIFT				10
-#define OMAP3430_EN_GPT8_MASK				(1 << 9)
-#define OMAP3430_EN_GPT8_SHIFT				9
-#define OMAP3430_EN_GPT7_MASK				(1 << 8)
-#define OMAP3430_EN_GPT7_SHIFT				8
-#define OMAP3430_EN_GPT6_MASK				(1 << 7)
-#define OMAP3430_EN_GPT6_SHIFT				7
-#define OMAP3430_EN_GPT5_MASK				(1 << 6)
-#define OMAP3430_EN_GPT5_SHIFT				6
-#define OMAP3430_EN_GPT4_MASK				(1 << 5)
-#define OMAP3430_EN_GPT4_SHIFT				5
-#define OMAP3430_EN_GPT3_MASK				(1 << 4)
-#define OMAP3430_EN_GPT3_SHIFT				4
-#define OMAP3430_EN_GPT2_MASK				(1 << 3)
-#define OMAP3430_EN_GPT2_SHIFT				3
-
-/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
-/* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
- * be ST_* bits instead? */
-#define OMAP3430_EN_MCBSP4_MASK				(1 << 2)
-#define OMAP3430_EN_MCBSP4_SHIFT			2
-#define OMAP3430_EN_MCBSP3_MASK				(1 << 1)
-#define OMAP3430_EN_MCBSP3_SHIFT			1
-#define OMAP3430_EN_MCBSP2_MASK				(1 << 0)
-#define OMAP3430_EN_MCBSP2_SHIFT			0
-
-/* CM_IDLEST_PER, PM_WKST_PER shared bits */
-#define OMAP3630_ST_UART4_SHIFT				18
-#define OMAP3630_ST_UART4_MASK				(1 << 18)
-#define OMAP3430_ST_GPIO6_SHIFT				17
-#define OMAP3430_ST_GPIO6_MASK				(1 << 17)
-#define OMAP3430_ST_GPIO5_SHIFT				16
-#define OMAP3430_ST_GPIO5_MASK				(1 << 16)
-#define OMAP3430_ST_GPIO4_SHIFT				15
-#define OMAP3430_ST_GPIO4_MASK				(1 << 15)
-#define OMAP3430_ST_GPIO3_SHIFT				14
-#define OMAP3430_ST_GPIO3_MASK				(1 << 14)
-#define OMAP3430_ST_GPIO2_SHIFT				13
-#define OMAP3430_ST_GPIO2_MASK				(1 << 13)
-#define OMAP3430_ST_UART3_SHIFT				11
-#define OMAP3430_ST_UART3_MASK				(1 << 11)
-#define OMAP3430_ST_GPT9_SHIFT				10
-#define OMAP3430_ST_GPT9_MASK				(1 << 10)
-#define OMAP3430_ST_GPT8_SHIFT				9
-#define OMAP3430_ST_GPT8_MASK				(1 << 9)
-#define OMAP3430_ST_GPT7_SHIFT				8
-#define OMAP3430_ST_GPT7_MASK				(1 << 8)
-#define OMAP3430_ST_GPT6_SHIFT				7
-#define OMAP3430_ST_GPT6_MASK				(1 << 7)
-#define OMAP3430_ST_GPT5_SHIFT				6
-#define OMAP3430_ST_GPT5_MASK				(1 << 6)
-#define OMAP3430_ST_GPT4_SHIFT				5
-#define OMAP3430_ST_GPT4_MASK				(1 << 5)
-#define OMAP3430_ST_GPT3_SHIFT				4
-#define OMAP3430_ST_GPT3_MASK				(1 << 4)
-#define OMAP3430_ST_GPT2_SHIFT				3
-#define OMAP3430_ST_GPT2_MASK				(1 << 3)
-
-/* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared bits */
-#define OMAP3430_EN_CORE_SHIFT				0
-#define OMAP3430_EN_CORE_MASK				(1 << 0)
-
-
-
-/*
- * Maximum time(us) it takes to output the signal WUCLKOUT of the last
- * pad of the I/O ring after asserting WUCLKIN high.  Tero measured
- * the actual time at 7 to 8 microseconds on OMAP3 and 2 to 4
- * microseconds on OMAP4, so this timeout may be too high.
- */
-#define MAX_IOPAD_LATCH_TIME			100
-# ifndef __ASSEMBLER__
-
-#include <linux/delay.h>
-
-/**
- * omap_test_timeout - busy-loop, testing a condition
- * @cond: condition to test until it evaluates to true
- * @timeout: maximum number of microseconds in the timeout
- * @index: loop index (integer)
- *
- * Loop waiting for @cond to become true or until at least @timeout
- * microseconds have passed.  To use, define some integer @index in the
- * calling code.  After running, if @index == @timeout, then the loop has
- * timed out.
- */
-#define omap_test_timeout(cond, timeout, index)			\
-({								\
-	for (index = 0; index < timeout; index++) {		\
-		if (cond)					\
-			break;					\
-		udelay(1);					\
-	}							\
-})
-
-/**
- * struct omap_prcm_irq - describes a PRCM interrupt bit
- * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
- * @offset: the bit shift of the interrupt inside the IRQ{ENABLE,STATUS} regs
- * @priority: should this interrupt be handled before @priority=false IRQs?
- *
- * Describes interrupt bits inside the PRM_IRQ{ENABLE,STATUS}_MPU* registers.
- * On systems with multiple PRM MPU IRQ registers, the bitfields read from
- * the registers are concatenated, so @offset could be > 31 on these systems -
- * see omap_prm_irq_handler() for more details.  I/O ring interrupts should
- * have @priority set to true.
- */
-struct omap_prcm_irq {
-	const char *name;
-	unsigned int offset;
-	bool priority;
-};
-
-/**
- * struct omap_prcm_irq_setup - PRCM interrupt controller details
- * @ack: PRM register offset for the first PRM_IRQSTATUS_MPU register
- * @mask: PRM register offset for the first PRM_IRQENABLE_MPU register
- * @nr_regs: number of PRM_IRQ{STATUS,ENABLE}_MPU* registers
- * @nr_irqs: number of entries in the @irqs array
- * @irqs: ptr to an array of PRCM interrupt bits (see @nr_irqs)
- * @irq: MPU IRQ asserted when a PRCM interrupt arrives
- * @read_pending_irqs: fn ptr to determine if any PRCM IRQs are pending
- * @ocp_barrier: fn ptr to force buffered PRM writes to complete
- * @save_and_clear_irqen: fn ptr to save and clear IRQENABLE regs
- * @restore_irqen: fn ptr to save and clear IRQENABLE regs
- * @reconfigure_io_chain: fn ptr to reconfigure IO chain
- * @saved_mask: IRQENABLE regs are saved here during suspend
- * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
- * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
- * @suspended: set to true after Linux suspend code has called our ->prepare()
- * @suspend_save_flag: set to true after IRQ masks have been saved and disabled
- *
- * @saved_mask, @priority_mask, @base_irq, @suspended, and
- * @suspend_save_flag are populated dynamically, and are not to be
- * specified in static initializers.
- */
-struct omap_prcm_irq_setup {
-	u16 ack;
-	u16 mask;
-	u8 nr_regs;
-	u8 nr_irqs;
-	const struct omap_prcm_irq *irqs;
-	int irq;
-	void (*read_pending_irqs)(unsigned long *events);
-	void (*ocp_barrier)(void);
-	void (*save_and_clear_irqen)(u32 *saved_mask);
-	void (*restore_irqen)(u32 *saved_mask);
-	void (*reconfigure_io_chain)(void);
-	u32 *saved_mask;
-	u32 *priority_mask;
-	int base_irq;
-	bool suspended;
-	bool suspend_save_flag;
-};
-
-/* OMAP_PRCM_IRQ: convenience macro for creating struct omap_prcm_irq records */
-#define OMAP_PRCM_IRQ(_name, _offset, _priority) {	\
-	.name = _name,					\
-	.offset = _offset,				\
-	.priority = _priority				\
-	}
-
-struct of_device_id;
-
-extern void __iomem *clk_memmaps[];
-
-extern void omap_prcm_irq_cleanup(void);
-extern int omap_prcm_register_chain_handler(
-	struct omap_prcm_irq_setup *irq_setup);
-extern int omap_prcm_event_to_irq(const char *event);
-extern void omap_prcm_irq_prepare(void);
-extern void omap_prcm_irq_complete(void);
-void omap_pcs_legacy_init(int irq, void (*rearm)(void));
-int of_prcm_module_init(struct of_device_id *match_table);
-int of_cm_init(void);
-
-# endif
-
-#endif
-
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 8caa7af..6a02cf3 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -13,7 +13,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
 #define __ARCH_ARM_MACH_OMAP2_PRM_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 # ifndef __ASSEMBLER__
 extern void __iomem *prm_base;
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index feeaf00..b86486b 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm2xxx.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
index ebd6a09..c02a267 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_PRIVATE_H
 #define __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_PRIVATE_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm2xxx_3xxx.h>
 
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 7825b1c..598ba48 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM33XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm33xx.h>
 
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 6c06fce..693b5ad 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM3XXX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM3XXX_H
 
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/prm3xxx.h>
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 2b25710..705509a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -26,7 +26,7 @@
 #include "prminst44xx_private.h"
 #include "powerdomain.h"
 #include "prm.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm44xx_54xx.h>
 
 #define OMAP4430_GLOBAL_COLD_RST_SHIFT			0
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 52585e1..b7066fd 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -26,7 +26,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM44XX_H
 
 #include <linux/power/omap/prm44xx_54xx.h>
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm44xx.h>
 
diff --git a/arch/arm/mach-omap2/prm54xx.h b/arch/arm/mach-omap2/prm54xx.h
index 34a0835..250c2d5 100644
--- a/arch/arm/mach-omap2/prm54xx.h
+++ b/arch/arm/mach-omap2/prm54xx.h
@@ -22,7 +22,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM54XX_H
 
 #include <linux/power/omap/prm44xx_54xx.h>
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm54xx.h>
 
diff --git a/arch/arm/mach-omap2/prm7xx.h b/arch/arm/mach-omap2/prm7xx.h
index 2637d62..6e84906 100644
--- a/arch/arm/mach-omap2/prm7xx.h
+++ b/arch/arm/mach-omap2/prm7xx.h
@@ -23,7 +23,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM7XX_H
 
 #include <linux/power/omap/prm44xx_54xx.h>
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include "prm.h"
 #include <linux/power/omap/prm7xx.h>
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 653862b..acdd0f1 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -34,7 +34,7 @@
 #include <linux/power/omap/prm44xx.h>
 
 #include "prm.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 01f6b15..50c660d 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 
 #include "prm.h"
-#include "prcm-common.h"
+#include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
diff --git a/include/linux/power/omap/prcm-common.h b/include/linux/power/omap/prcm-common.h
new file mode 100644
index 0000000..67143a2
--- /dev/null
+++ b/include/linux/power/omap/prcm-common.h
@@ -0,0 +1,535 @@
+/*
+ * OMAP2/3 PRCM base and module definitions
+ *
+ * Copyright (C) 2007-2009, 2011 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_POWER_OMAP_PRCM_COMMON_H
+#define __LINUX_POWER_OMAP_PRCM_COMMON_H
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
+#define OMAP24XX_GR_MOD					OCP_MOD
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
+/*
+ * TI81XX PRM module offsets
+ */
+#define TI81XX_PRM_DEVICE_MOD			0x0000
+#define TI816X_PRM_ACTIVE_MOD			0x0a00
+#define TI81XX_PRM_DEFAULT_MOD			0x0b00
+#define TI816X_PRM_IVAHD0_MOD			0x0c00
+#define TI816X_PRM_IVAHD1_MOD			0x0d00
+#define TI816X_PRM_IVAHD2_MOD			0x0e00
+#define TI816X_PRM_SGX_MOD				0x0f00
+#define TI81XX_PRM_ALWON_MOD			0x1800
+
+/* 24XX register bits shared between CM & PRM registers */
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP2420_EN_MMC_SHIFT				26
+#define OMAP2420_EN_MMC_MASK				(1 << 26)
+#define OMAP24XX_EN_UART2_SHIFT				22
+#define OMAP24XX_EN_UART2_MASK				(1 << 22)
+#define OMAP24XX_EN_UART1_SHIFT				21
+#define OMAP24XX_EN_UART1_MASK				(1 << 21)
+#define OMAP24XX_EN_MCSPI2_SHIFT			18
+#define OMAP24XX_EN_MCSPI2_MASK				(1 << 18)
+#define OMAP24XX_EN_MCSPI1_SHIFT			17
+#define OMAP24XX_EN_MCSPI1_MASK				(1 << 17)
+#define OMAP24XX_EN_MCBSP2_SHIFT			16
+#define OMAP24XX_EN_MCBSP2_MASK				(1 << 16)
+#define OMAP24XX_EN_MCBSP1_SHIFT			15
+#define OMAP24XX_EN_MCBSP1_MASK				(1 << 15)
+#define OMAP24XX_EN_GPT12_SHIFT				14
+#define OMAP24XX_EN_GPT12_MASK				(1 << 14)
+#define OMAP24XX_EN_GPT11_SHIFT				13
+#define OMAP24XX_EN_GPT11_MASK				(1 << 13)
+#define OMAP24XX_EN_GPT10_SHIFT				12
+#define OMAP24XX_EN_GPT10_MASK				(1 << 12)
+#define OMAP24XX_EN_GPT9_SHIFT				11
+#define OMAP24XX_EN_GPT9_MASK				(1 << 11)
+#define OMAP24XX_EN_GPT8_SHIFT				10
+#define OMAP24XX_EN_GPT8_MASK				(1 << 10)
+#define OMAP24XX_EN_GPT7_SHIFT				9
+#define OMAP24XX_EN_GPT7_MASK				(1 << 9)
+#define OMAP24XX_EN_GPT6_SHIFT				8
+#define OMAP24XX_EN_GPT6_MASK				(1 << 8)
+#define OMAP24XX_EN_GPT5_SHIFT				7
+#define OMAP24XX_EN_GPT5_MASK				(1 << 7)
+#define OMAP24XX_EN_GPT4_SHIFT				6
+#define OMAP24XX_EN_GPT4_MASK				(1 << 6)
+#define OMAP24XX_EN_GPT3_SHIFT				5
+#define OMAP24XX_EN_GPT3_MASK				(1 << 5)
+#define OMAP24XX_EN_GPT2_SHIFT				4
+#define OMAP24XX_EN_GPT2_MASK				(1 << 4)
+#define OMAP2420_EN_VLYNQ_SHIFT				3
+#define OMAP2420_EN_VLYNQ_MASK				(1 << 3)
+
+/* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_GPIO5_SHIFT				10
+#define OMAP2430_EN_GPIO5_MASK				(1 << 10)
+#define OMAP2430_EN_MCSPI3_SHIFT			9
+#define OMAP2430_EN_MCSPI3_MASK				(1 << 9)
+#define OMAP2430_EN_MMCHS2_SHIFT			8
+#define OMAP2430_EN_MMCHS2_MASK				(1 << 8)
+#define OMAP2430_EN_MMCHS1_SHIFT			7
+#define OMAP2430_EN_MMCHS1_MASK				(1 << 7)
+#define OMAP24XX_EN_UART3_SHIFT				2
+#define OMAP24XX_EN_UART3_MASK				(1 << 2)
+#define OMAP24XX_EN_USB_SHIFT				0
+#define OMAP24XX_EN_USB_MASK				(1 << 0)
+
+/* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_MDM_INTC_SHIFT			11
+#define OMAP2430_EN_MDM_INTC_MASK			(1 << 11)
+#define OMAP2430_EN_USBHS_SHIFT				6
+#define OMAP2430_EN_USBHS_MASK				(1 << 6)
+#define OMAP24XX_EN_GPMC_SHIFT				1
+#define OMAP24XX_EN_GPMC_MASK				(1 << 1)
+
+/* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
+#define OMAP2420_ST_MMC_SHIFT				26
+#define OMAP2420_ST_MMC_MASK				(1 << 26)
+#define OMAP24XX_ST_UART2_SHIFT				22
+#define OMAP24XX_ST_UART2_MASK				(1 << 22)
+#define OMAP24XX_ST_UART1_SHIFT				21
+#define OMAP24XX_ST_UART1_MASK				(1 << 21)
+#define OMAP24XX_ST_MCSPI2_SHIFT			18
+#define OMAP24XX_ST_MCSPI2_MASK				(1 << 18)
+#define OMAP24XX_ST_MCSPI1_SHIFT			17
+#define OMAP24XX_ST_MCSPI1_MASK				(1 << 17)
+#define OMAP24XX_ST_MCBSP2_SHIFT			16
+#define OMAP24XX_ST_MCBSP2_MASK				(1 << 16)
+#define OMAP24XX_ST_MCBSP1_SHIFT			15
+#define OMAP24XX_ST_MCBSP1_MASK				(1 << 15)
+#define OMAP24XX_ST_GPT12_SHIFT				14
+#define OMAP24XX_ST_GPT12_MASK				(1 << 14)
+#define OMAP24XX_ST_GPT11_SHIFT				13
+#define OMAP24XX_ST_GPT11_MASK				(1 << 13)
+#define OMAP24XX_ST_GPT10_SHIFT				12
+#define OMAP24XX_ST_GPT10_MASK				(1 << 12)
+#define OMAP24XX_ST_GPT9_SHIFT				11
+#define OMAP24XX_ST_GPT9_MASK				(1 << 11)
+#define OMAP24XX_ST_GPT8_SHIFT				10
+#define OMAP24XX_ST_GPT8_MASK				(1 << 10)
+#define OMAP24XX_ST_GPT7_SHIFT				9
+#define OMAP24XX_ST_GPT7_MASK				(1 << 9)
+#define OMAP24XX_ST_GPT6_SHIFT				8
+#define OMAP24XX_ST_GPT6_MASK				(1 << 8)
+#define OMAP24XX_ST_GPT5_SHIFT				7
+#define OMAP24XX_ST_GPT5_MASK				(1 << 7)
+#define OMAP24XX_ST_GPT4_SHIFT				6
+#define OMAP24XX_ST_GPT4_MASK				(1 << 6)
+#define OMAP24XX_ST_GPT3_SHIFT				5
+#define OMAP24XX_ST_GPT3_MASK				(1 << 5)
+#define OMAP24XX_ST_GPT2_SHIFT				4
+#define OMAP24XX_ST_GPT2_MASK				(1 << 4)
+#define OMAP2420_ST_VLYNQ_SHIFT				3
+#define OMAP2420_ST_VLYNQ_MASK				(1 << 3)
+
+/* CM_IDLEST2_CORE, PM_WKST2_CORE shared bits */
+#define OMAP2430_ST_MDM_INTC_SHIFT			11
+#define OMAP2430_ST_MDM_INTC_MASK			(1 << 11)
+#define OMAP2430_ST_GPIO5_SHIFT				10
+#define OMAP2430_ST_GPIO5_MASK				(1 << 10)
+#define OMAP2430_ST_MCSPI3_SHIFT			9
+#define OMAP2430_ST_MCSPI3_MASK				(1 << 9)
+#define OMAP2430_ST_MMCHS2_SHIFT			8
+#define OMAP2430_ST_MMCHS2_MASK				(1 << 8)
+#define OMAP2430_ST_MMCHS1_SHIFT			7
+#define OMAP2430_ST_MMCHS1_MASK				(1 << 7)
+#define OMAP2430_ST_USBHS_SHIFT				6
+#define OMAP2430_ST_USBHS_MASK				(1 << 6)
+#define OMAP24XX_ST_UART3_SHIFT				2
+#define OMAP24XX_ST_UART3_MASK				(1 << 2)
+#define OMAP24XX_ST_USB_SHIFT				0
+#define OMAP24XX_ST_USB_MASK				(1 << 0)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP24XX_EN_GPIOS_SHIFT				2
+#define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
+#define OMAP24XX_EN_GPT1_SHIFT				0
+#define OMAP24XX_EN_GPT1_MASK				(1 << 0)
+
+/* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
+#define OMAP24XX_ST_GPIOS_SHIFT				2
+#define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
+#define OMAP24XX_ST_32KSYNC_SHIFT			1
+#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
+#define OMAP24XX_ST_GPT1_SHIFT				0
+#define OMAP24XX_ST_GPT1_MASK				(1 << 0)
+
+/* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
+#define OMAP2430_ST_MDM_SHIFT				0
+#define OMAP2430_ST_MDM_MASK				(1 << 0)
+
+
+/* 3430 register bits shared between CM & PRM registers */
+
+/* CM_REVISION, PRM_REVISION shared bits */
+#define OMAP3430_REV_SHIFT				0
+#define OMAP3430_REV_MASK				(0xff << 0)
+
+/* CM_SYSCONFIG, PRM_SYSCONFIG shared bits */
+#define OMAP3430_AUTOIDLE_MASK				(1 << 0)
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_MMC3_MASK				(1 << 30)
+#define OMAP3430_EN_MMC3_SHIFT				30
+#define OMAP3430_EN_MMC2_MASK				(1 << 25)
+#define OMAP3430_EN_MMC2_SHIFT				25
+#define OMAP3430_EN_MMC1_MASK				(1 << 24)
+#define OMAP3430_EN_MMC1_SHIFT				24
+#define AM35XX_EN_UART4_MASK				(1 << 23)
+#define AM35XX_EN_UART4_SHIFT				23
+#define OMAP3430_EN_MCSPI4_MASK				(1 << 21)
+#define OMAP3430_EN_MCSPI4_SHIFT			21
+#define OMAP3430_EN_MCSPI3_MASK				(1 << 20)
+#define OMAP3430_EN_MCSPI3_SHIFT			20
+#define OMAP3430_EN_MCSPI2_MASK				(1 << 19)
+#define OMAP3430_EN_MCSPI2_SHIFT			19
+#define OMAP3430_EN_MCSPI1_MASK				(1 << 18)
+#define OMAP3430_EN_MCSPI1_SHIFT			18
+#define OMAP3430_EN_I2C3_MASK				(1 << 17)
+#define OMAP3430_EN_I2C3_SHIFT				17
+#define OMAP3430_EN_I2C2_MASK				(1 << 16)
+#define OMAP3430_EN_I2C2_SHIFT				16
+#define OMAP3430_EN_I2C1_MASK				(1 << 15)
+#define OMAP3430_EN_I2C1_SHIFT				15
+#define OMAP3430_EN_UART2_MASK				(1 << 14)
+#define OMAP3430_EN_UART2_SHIFT				14
+#define OMAP3430_EN_UART1_MASK				(1 << 13)
+#define OMAP3430_EN_UART1_SHIFT				13
+#define OMAP3430_EN_GPT11_MASK				(1 << 12)
+#define OMAP3430_EN_GPT11_SHIFT				12
+#define OMAP3430_EN_GPT10_MASK				(1 << 11)
+#define OMAP3430_EN_GPT10_SHIFT				11
+#define OMAP3430_EN_MCBSP5_MASK				(1 << 10)
+#define OMAP3430_EN_MCBSP5_SHIFT			10
+#define OMAP3430_EN_MCBSP1_MASK				(1 << 9)
+#define OMAP3430_EN_MCBSP1_SHIFT			9
+#define OMAP3430_EN_FSHOSTUSB_MASK			(1 << 5)
+#define OMAP3430_EN_FSHOSTUSB_SHIFT			5
+#define OMAP3430_EN_D2D_MASK				(1 << 3)
+#define OMAP3430_EN_D2D_SHIFT				3
+
+/* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_HSOTGUSB_MASK			(1 << 4)
+#define OMAP3430_EN_HSOTGUSB_SHIFT			4
+
+/* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
+#define OMAP3430_ST_MMC3_SHIFT				30
+#define OMAP3430_ST_MMC3_MASK				(1 << 30)
+#define OMAP3430_ST_MMC2_SHIFT				25
+#define OMAP3430_ST_MMC2_MASK				(1 << 25)
+#define OMAP3430_ST_MMC1_SHIFT				24
+#define OMAP3430_ST_MMC1_MASK				(1 << 24)
+#define OMAP3430_ST_MCSPI4_SHIFT			21
+#define OMAP3430_ST_MCSPI4_MASK				(1 << 21)
+#define OMAP3430_ST_MCSPI3_SHIFT			20
+#define OMAP3430_ST_MCSPI3_MASK				(1 << 20)
+#define OMAP3430_ST_MCSPI2_SHIFT			19
+#define OMAP3430_ST_MCSPI2_MASK				(1 << 19)
+#define OMAP3430_ST_MCSPI1_SHIFT			18
+#define OMAP3430_ST_MCSPI1_MASK				(1 << 18)
+#define OMAP3430_ST_I2C3_SHIFT				17
+#define OMAP3430_ST_I2C3_MASK				(1 << 17)
+#define OMAP3430_ST_I2C2_SHIFT				16
+#define OMAP3430_ST_I2C2_MASK				(1 << 16)
+#define OMAP3430_ST_I2C1_SHIFT				15
+#define OMAP3430_ST_I2C1_MASK				(1 << 15)
+#define OMAP3430_ST_UART2_SHIFT				14
+#define OMAP3430_ST_UART2_MASK				(1 << 14)
+#define OMAP3430_ST_UART1_SHIFT				13
+#define OMAP3430_ST_UART1_MASK				(1 << 13)
+#define OMAP3430_ST_GPT11_SHIFT				12
+#define OMAP3430_ST_GPT11_MASK				(1 << 12)
+#define OMAP3430_ST_GPT10_SHIFT				11
+#define OMAP3430_ST_GPT10_MASK				(1 << 11)
+#define OMAP3430_ST_MCBSP5_SHIFT			10
+#define OMAP3430_ST_MCBSP5_MASK				(1 << 10)
+#define OMAP3430_ST_MCBSP1_SHIFT			9
+#define OMAP3430_ST_MCBSP1_MASK				(1 << 9)
+#define OMAP3430ES1_ST_FSHOSTUSB_SHIFT			5
+#define OMAP3430ES1_ST_FSHOSTUSB_MASK			(1 << 5)
+#define OMAP3430ES1_ST_HSOTGUSB_SHIFT			4
+#define OMAP3430ES1_ST_HSOTGUSB_MASK			(1 << 4)
+#define OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT		5
+#define OMAP3430ES2_ST_HSOTGUSB_IDLE_MASK		(1 << 5)
+#define OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT		4
+#define OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK		(1 << 4)
+#define OMAP3430_ST_D2D_SHIFT				3
+#define OMAP3430_ST_D2D_MASK				(1 << 3)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPIO1_MASK				(1 << 3)
+#define OMAP3430_EN_GPIO1_SHIFT				3
+#define OMAP3430_EN_GPT12_MASK				(1 << 1)
+#define OMAP3430_EN_GPT12_SHIFT				1
+#define OMAP3430_EN_GPT1_MASK				(1 << 0)
+#define OMAP3430_EN_GPT1_SHIFT				0
+
+/* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_SR2_MASK				(1 << 7)
+#define OMAP3430_EN_SR2_SHIFT				7
+#define OMAP3430_EN_SR1_MASK				(1 << 6)
+#define OMAP3430_EN_SR1_SHIFT				6
+
+/* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPT12_MASK				(1 << 1)
+#define OMAP3430_EN_GPT12_SHIFT				1
+
+/* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
+#define OMAP3430_ST_SR2_SHIFT				7
+#define OMAP3430_ST_SR2_MASK				(1 << 7)
+#define OMAP3430_ST_SR1_SHIFT				6
+#define OMAP3430_ST_SR1_MASK				(1 << 6)
+#define OMAP3430_ST_GPIO1_SHIFT				3
+#define OMAP3430_ST_GPIO1_MASK				(1 << 3)
+#define OMAP3430_ST_32KSYNC_SHIFT			2
+#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
+#define OMAP3430_ST_GPT12_SHIFT				1
+#define OMAP3430_ST_GPT12_MASK				(1 << 1)
+#define OMAP3430_ST_GPT1_SHIFT				0
+#define OMAP3430_ST_GPT1_MASK				(1 << 0)
+
+/*
+ * CM_SLEEPDEP_GFX, CM_SLEEPDEP_DSS, CM_SLEEPDEP_CAM,
+ * CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_GFX,
+ * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
+ */
+#define OMAP3430_EN_MPU_MASK				(1 << 1)
+#define OMAP3430_EN_MPU_SHIFT				1
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+
+#define OMAP3630_EN_UART4_MASK				(1 << 18)
+#define OMAP3630_EN_UART4_SHIFT				18
+#define OMAP3430_EN_GPIO6_MASK				(1 << 17)
+#define OMAP3430_EN_GPIO6_SHIFT				17
+#define OMAP3430_EN_GPIO5_MASK				(1 << 16)
+#define OMAP3430_EN_GPIO5_SHIFT				16
+#define OMAP3430_EN_GPIO4_MASK				(1 << 15)
+#define OMAP3430_EN_GPIO4_SHIFT				15
+#define OMAP3430_EN_GPIO3_MASK				(1 << 14)
+#define OMAP3430_EN_GPIO3_SHIFT				14
+#define OMAP3430_EN_GPIO2_MASK				(1 << 13)
+#define OMAP3430_EN_GPIO2_SHIFT				13
+#define OMAP3430_EN_UART3_MASK				(1 << 11)
+#define OMAP3430_EN_UART3_SHIFT				11
+#define OMAP3430_EN_GPT9_MASK				(1 << 10)
+#define OMAP3430_EN_GPT9_SHIFT				10
+#define OMAP3430_EN_GPT8_MASK				(1 << 9)
+#define OMAP3430_EN_GPT8_SHIFT				9
+#define OMAP3430_EN_GPT7_MASK				(1 << 8)
+#define OMAP3430_EN_GPT7_SHIFT				8
+#define OMAP3430_EN_GPT6_MASK				(1 << 7)
+#define OMAP3430_EN_GPT6_SHIFT				7
+#define OMAP3430_EN_GPT5_MASK				(1 << 6)
+#define OMAP3430_EN_GPT5_SHIFT				6
+#define OMAP3430_EN_GPT4_MASK				(1 << 5)
+#define OMAP3430_EN_GPT4_SHIFT				5
+#define OMAP3430_EN_GPT3_MASK				(1 << 4)
+#define OMAP3430_EN_GPT3_SHIFT				4
+#define OMAP3430_EN_GPT2_MASK				(1 << 3)
+#define OMAP3430_EN_GPT2_SHIFT				3
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
+/* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
+ * be ST_* bits instead? */
+#define OMAP3430_EN_MCBSP4_MASK				(1 << 2)
+#define OMAP3430_EN_MCBSP4_SHIFT			2
+#define OMAP3430_EN_MCBSP3_MASK				(1 << 1)
+#define OMAP3430_EN_MCBSP3_SHIFT			1
+#define OMAP3430_EN_MCBSP2_MASK				(1 << 0)
+#define OMAP3430_EN_MCBSP2_SHIFT			0
+
+/* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3630_ST_UART4_SHIFT				18
+#define OMAP3630_ST_UART4_MASK				(1 << 18)
+#define OMAP3430_ST_GPIO6_SHIFT				17
+#define OMAP3430_ST_GPIO6_MASK				(1 << 17)
+#define OMAP3430_ST_GPIO5_SHIFT				16
+#define OMAP3430_ST_GPIO5_MASK				(1 << 16)
+#define OMAP3430_ST_GPIO4_SHIFT				15
+#define OMAP3430_ST_GPIO4_MASK				(1 << 15)
+#define OMAP3430_ST_GPIO3_SHIFT				14
+#define OMAP3430_ST_GPIO3_MASK				(1 << 14)
+#define OMAP3430_ST_GPIO2_SHIFT				13
+#define OMAP3430_ST_GPIO2_MASK				(1 << 13)
+#define OMAP3430_ST_UART3_SHIFT				11
+#define OMAP3430_ST_UART3_MASK				(1 << 11)
+#define OMAP3430_ST_GPT9_SHIFT				10
+#define OMAP3430_ST_GPT9_MASK				(1 << 10)
+#define OMAP3430_ST_GPT8_SHIFT				9
+#define OMAP3430_ST_GPT8_MASK				(1 << 9)
+#define OMAP3430_ST_GPT7_SHIFT				8
+#define OMAP3430_ST_GPT7_MASK				(1 << 8)
+#define OMAP3430_ST_GPT6_SHIFT				7
+#define OMAP3430_ST_GPT6_MASK				(1 << 7)
+#define OMAP3430_ST_GPT5_SHIFT				6
+#define OMAP3430_ST_GPT5_MASK				(1 << 6)
+#define OMAP3430_ST_GPT4_SHIFT				5
+#define OMAP3430_ST_GPT4_MASK				(1 << 5)
+#define OMAP3430_ST_GPT3_SHIFT				4
+#define OMAP3430_ST_GPT3_MASK				(1 << 4)
+#define OMAP3430_ST_GPT2_SHIFT				3
+#define OMAP3430_ST_GPT2_MASK				(1 << 3)
+
+/* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared bits */
+#define OMAP3430_EN_CORE_SHIFT				0
+#define OMAP3430_EN_CORE_MASK				(1 << 0)
+
+
+
+/*
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last
+ * pad of the I/O ring after asserting WUCLKIN high.  Tero measured
+ * the actual time at 7 to 8 microseconds on OMAP3 and 2 to 4
+ * microseconds on OMAP4, so this timeout may be too high.
+ */
+#define MAX_IOPAD_LATCH_TIME			100
+# ifndef __ASSEMBLER__
+
+#include <linux/delay.h>
+
+/**
+ * omap_test_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until at least @timeout
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index == @timeout, then the loop has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)			\
+({								\
+	for (index = 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
+/**
+ * struct omap_prcm_irq - describes a PRCM interrupt bit
+ * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
+ * @offset: the bit shift of the interrupt inside the IRQ{ENABLE,STATUS} regs
+ * @priority: should this interrupt be handled before @priority=false IRQs?
+ *
+ * Describes interrupt bits inside the PRM_IRQ{ENABLE,STATUS}_MPU* registers.
+ * On systems with multiple PRM MPU IRQ registers, the bitfields read from
+ * the registers are concatenated, so @offset could be > 31 on these systems -
+ * see omap_prm_irq_handler() for more details.  I/O ring interrupts should
+ * have @priority set to true.
+ */
+struct omap_prcm_irq {
+	const char *name;
+	unsigned int offset;
+	bool priority;
+};
+
+/**
+ * struct omap_prcm_irq_setup - PRCM interrupt controller details
+ * @ack: PRM register offset for the first PRM_IRQSTATUS_MPU register
+ * @mask: PRM register offset for the first PRM_IRQENABLE_MPU register
+ * @nr_regs: number of PRM_IRQ{STATUS,ENABLE}_MPU* registers
+ * @nr_irqs: number of entries in the @irqs array
+ * @irqs: ptr to an array of PRCM interrupt bits (see @nr_irqs)
+ * @irq: MPU IRQ asserted when a PRCM interrupt arrives
+ * @read_pending_irqs: fn ptr to determine if any PRCM IRQs are pending
+ * @ocp_barrier: fn ptr to force buffered PRM writes to complete
+ * @save_and_clear_irqen: fn ptr to save and clear IRQENABLE regs
+ * @restore_irqen: fn ptr to save and clear IRQENABLE regs
+ * @reconfigure_io_chain: fn ptr to reconfigure IO chain
+ * @saved_mask: IRQENABLE regs are saved here during suspend
+ * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
+ * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
+ * @suspended: set to true after Linux suspend code has called our ->prepare()
+ * @suspend_save_flag: set to true after IRQ masks have been saved and disabled
+ *
+ * @saved_mask, @priority_mask, @base_irq, @suspended, and
+ * @suspend_save_flag are populated dynamically, and are not to be
+ * specified in static initializers.
+ */
+struct omap_prcm_irq_setup {
+	u16 ack;
+	u16 mask;
+	u8 nr_regs;
+	u8 nr_irqs;
+	const struct omap_prcm_irq *irqs;
+	int irq;
+	void (*read_pending_irqs)(unsigned long *events);
+	void (*ocp_barrier)(void);
+	void (*save_and_clear_irqen)(u32 *saved_mask);
+	void (*restore_irqen)(u32 *saved_mask);
+	void (*reconfigure_io_chain)(void);
+	u32 *saved_mask;
+	u32 *priority_mask;
+	int base_irq;
+	bool suspended;
+	bool suspend_save_flag;
+};
+
+/* OMAP_PRCM_IRQ: convenience macro for creating struct omap_prcm_irq records */
+#define OMAP_PRCM_IRQ(_name, _offset, _priority) {	\
+	.name = _name,					\
+	.offset = _offset,				\
+	.priority = _priority				\
+	}
+
+struct of_device_id;
+
+extern void __iomem *clk_memmaps[];
+
+void omap_prcm_irq_cleanup(void);
+int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup);
+int omap_prcm_event_to_irq(const char *event);
+void omap_prcm_irq_prepare(void);
+void omap_prcm_irq_complete(void);
+void omap_pcs_legacy_init(int irq, void (*rearm)(void));
+int of_prcm_module_init(struct of_device_id *match_table);
+int of_cm_init(void);
+
+# endif
+
+#endif
-- 
1.7.9.5

