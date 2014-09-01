From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 19/26] ARM: OMAP4+: CM: remove omap4_cm1/cm2_* functions
Date: Mon, 1 Sep 2014 21:09:08 +0300
Message-ID: <1409594955-1476-20-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35729 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbaIASKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:21 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not used for anything, so remove both the implementations and
header file references.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile       |    2 +-
 arch/arm/mach-omap2/cm1_44xx.h     |    2 --
 arch/arm/mach-omap2/cm1_54xx.h     |    2 --
 arch/arm/mach-omap2/cm1_7xx.h      |    2 --
 arch/arm/mach-omap2/cm2_44xx.h     |    2 --
 arch/arm/mach-omap2/cm2_54xx.h     |    2 --
 arch/arm/mach-omap2/cm2_7xx.h      |    2 --
 arch/arm/mach-omap2/cm44xx.c       |   49 ------------------------------------
 arch/arm/mach-omap2/cm_44xx_54xx.h |   36 --------------------------
 9 files changed, 1 insertion(+), 98 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cm44xx.c
 delete mode 100644 arch/arm/mach-omap2/cm_44xx_54xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 69bbcba..759da02 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -110,7 +110,7 @@ obj-y					+= prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
+omap-prcm-4-5-common			=  cminst44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
diff --git a/arch/arm/mach-omap2/cm1_44xx.h b/arch/arm/mach-omap2/cm1_44xx.h
index 5ae8fe3..a594992 100644
--- a/arch/arm/mach-omap2/cm1_44xx.h
+++ b/arch/arm/mach-omap2/cm1_44xx.h
@@ -25,8 +25,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM1_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM1_44XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM1 base address */
 #define OMAP4430_CM1_BASE		0x4a004000
 
diff --git a/arch/arm/mach-omap2/cm1_54xx.h b/arch/arm/mach-omap2/cm1_54xx.h
index 90b3348..fd245df 100644
--- a/arch/arm/mach-omap2/cm1_54xx.h
+++ b/arch/arm/mach-omap2/cm1_54xx.h
@@ -22,8 +22,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM1_54XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM1_54XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM1 base address */
 #define OMAP54XX_CM_CORE_AON_BASE		0x4a004000
 
diff --git a/arch/arm/mach-omap2/cm1_7xx.h b/arch/arm/mach-omap2/cm1_7xx.h
index ca6fa1f..2f1c09e 100644
--- a/arch/arm/mach-omap2/cm1_7xx.h
+++ b/arch/arm/mach-omap2/cm1_7xx.h
@@ -23,8 +23,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM1_7XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM1_7XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM1 base address */
 #define DRA7XX_CM_CORE_AON_BASE		0x4a005000
 
diff --git a/arch/arm/mach-omap2/cm2_44xx.h b/arch/arm/mach-omap2/cm2_44xx.h
index ee5136d..7521abf 100644
--- a/arch/arm/mach-omap2/cm2_44xx.h
+++ b/arch/arm/mach-omap2/cm2_44xx.h
@@ -25,8 +25,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM2_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM2_44XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM2 base address */
 #define OMAP4430_CM2_BASE		0x4a008000
 
diff --git a/arch/arm/mach-omap2/cm2_54xx.h b/arch/arm/mach-omap2/cm2_54xx.h
index 2683231..ff4040c 100644
--- a/arch/arm/mach-omap2/cm2_54xx.h
+++ b/arch/arm/mach-omap2/cm2_54xx.h
@@ -21,8 +21,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM2_54XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM2_54XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM2 base address */
 #define OMAP54XX_CM_CORE_BASE		0x4a008000
 
diff --git a/arch/arm/mach-omap2/cm2_7xx.h b/arch/arm/mach-omap2/cm2_7xx.h
index e966e3a..ce63fdb 100644
--- a/arch/arm/mach-omap2/cm2_7xx.h
+++ b/arch/arm/mach-omap2/cm2_7xx.h
@@ -22,8 +22,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM2_7XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM2_7XX_H
 
-#include "cm_44xx_54xx.h"
-
 /* CM2 base address */
 #define DRA7XX_CM_CORE_BASE		0x4a008000
 
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
deleted file mode 100644
index fe5cc7b..0000000
--- a/arch/arm/mach-omap2/cm44xx.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * OMAP4 CM1, CM2 module low-level functions
- *
- * Copyright (C) 2010 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * These functions are intended to be used only by the cminst44xx.c file.
- * XXX Perhaps we should just move them there and make them static.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include "cm.h"
-#include "cm1_44xx.h"
-#include "cm2_44xx.h"
-
-/* CM1 hardware module low-level functions */
-
-/* Read a register in CM1 */
-u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
-{
-	return readl_relaxed(cm_base + inst + reg);
-}
-
-/* Write into a register in CM1 */
-void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 reg)
-{
-	writel_relaxed(val, cm_base + inst + reg);
-}
-
-/* Read a register in CM2 */
-u32 omap4_cm2_read_inst_reg(s16 inst, u16 reg)
-{
-	return readl_relaxed(cm2_base + inst + reg);
-}
-
-/* Write into a register in CM2 */
-void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 reg)
-{
-	writel_relaxed(val, cm2_base + inst + reg);
-}
diff --git a/arch/arm/mach-omap2/cm_44xx_54xx.h b/arch/arm/mach-omap2/cm_44xx_54xx.h
deleted file mode 100644
index cbb2116..0000000
--- a/arch/arm/mach-omap2/cm_44xx_54xx.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * OMAP44xx and OMAP54xx CM1/CM2 function prototypes
- *
- * Copyright (C) 2009-2013 Texas Instruments, Inc.
- * Copyright (C) 2009-2010 Nokia Corporation
- *
- * Paul Walmsley (paul@pwsan.com)
- * Rajendra Nayak (rnayak@ti.com)
- * Benoit Cousson (b-cousson@ti.com)
- *
- * This file is automatically generated from the OMAP hardware databases.
- * We respectfully ask that any modifications to this file be coordinated
- * with the public linux-omap@vger.kernel.org mailing list and the
- * authors above to ensure that the autogeneration scripts are kept
- * up-to-date with the file contents.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CM_44XX_54XX_H
-#define __ARCH_ARM_MACH_OMAP2_CM_44XX_55XX_H
-
-/* CM1 Function prototypes */
-extern u32 omap4_cm1_read_inst_reg(s16 inst, u16 idx);
-extern void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 idx);
-extern u32 omap4_cm1_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
-
-/* CM2 Function prototypes */
-extern u32 omap4_cm2_read_inst_reg(s16 inst, u16 idx);
-extern void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 idx);
-extern u32 omap4_cm2_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
-
-#endif
-- 
1.7.9.5

