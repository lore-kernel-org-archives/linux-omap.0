From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 18/26] ARM: OMAP4: CM: make cminst direct register access functions static
Date: Mon, 1 Sep 2014 21:09:07 +0300
Message-ID: <1409594955-1476-19-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624AbaIASKM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:12 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These shall not be accessed outside the CM driver. This also removes the
need for the cminst44xx.h header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   20 ++++++++++----------
 arch/arm/mach-omap2/cminst44xx.h |   29 -----------------------------
 2 files changed, 10 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cminst44xx.h

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index ac03410..95a8cff 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -26,7 +26,6 @@
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include "cm44xx.h"
-#include "cminst44xx.h"
 #include "cm-regbits-34xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
@@ -74,6 +73,8 @@ void omap_cm_base_init(void)
 
 /* Private functions */
 
+static u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx);
+
 /**
  * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
@@ -110,10 +111,8 @@ static bool _is_module_ready(u8 part, u16 inst, u16 clkctrl_offs)
 		v == CLKCTRL_IDLEST_INTERFACE_IDLE) ? true : false;
 }
 
-/* Public functions */
-
 /* Read a register in a CM instance */
-u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
+static u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -122,7 +121,7 @@ u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 }
 
 /* Write into a register in a CM instance */
-void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
+static void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -131,8 +130,8 @@ void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 }
 
 /* Read-modify-write a register in CM1. Caller must lock */
-u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
-				   s16 idx)
+static u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
+					  s16 idx)
 {
 	u32 v;
 
@@ -144,17 +143,18 @@ u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
 	return v;
 }
 
-u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
+static u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, bits, part, inst, idx);
 }
 
-u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
+static u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
+					    s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, 0x0, part, inst, idx);
 }
 
-u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
+static u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
 {
 	u32 v;
 
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
deleted file mode 100644
index 3ef3bf6..0000000
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * OMAP4 Clock Management (CM) function prototypes
- *
- * Copyright (C) 2010 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
-#define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
-
-/*
- * In an ideal world, we would not export these low-level functions,
- * but this will probably take some time to fix properly
- */
-u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx);
-void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx);
-u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
-				   u16 inst, s16 idx);
-u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst,
-				   s16 idx);
-u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
-				     s16 idx);
-extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
-					   u32 mask);
-
-#endif
-- 
1.7.9.5

