From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 09/15] ARM: OMAP: AM33XX: Remove unnecessary include and use __ASSEMBLER__ macros
Date: Fri, 2 Nov 2012 18:02:40 +0530
Message-ID: <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760988Ab2KBMed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:33 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Get rid of some unnecessary header file inclusions
and also use __ASSEMBLER__ macros to allow the
various register offsets from PM assembly code
which be added in a subsequent patch.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 arch/arm/mach-omap2/cm33xx.h         |   10 ++++------
 arch/arm/mach-omap2/prm33xx.h        |    2 ++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 17e3de5..78dc85b 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 5fa0b62..91515f1 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,16 +17,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
 #include "common.h"
 
 #include "cm.h"
 #include "cm-regbits-33xx.h"
-#include "cm33xx.h"
+#include "iomap.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
@@ -381,6 +376,7 @@
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL			AM33XX_CM_REGADDR(AM33XX_CM_CEFUSE_MOD, 0x0020)
 
 
+#ifndef __ASSEMBLER__
 extern bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs);
@@ -417,4 +413,6 @@ static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
 }
 #endif
 
+#endif	/* ASSEMBLER */
+
 #endif
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 181fdab..3683376 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -117,6 +117,7 @@
 #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
+#ifndef __ASSEMBLER__
 extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
 extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
 extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
@@ -126,4 +127,5 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
 extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
+#endif	/* __ASSEMBLER__ */
 #endif
-- 
1.7.0.4

