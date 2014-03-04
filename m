From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 15/18] ARM: OMAP4+: PRM: make prm register access internal to PRM driver only
Date: Tue, 4 Mar 2014 18:19:15 +0200
Message-ID: <1393949958-816-16-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48493 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbaCDQUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:34 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Removed exported prototypes from the public header file for the direct
register access. Also made a new driver API for clearing mpuss previous
logic powerstate so that the register APIs are no longer needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   15 ++----------
 arch/arm/mach-omap2/prm44xx.c             |    2 +-
 arch/arm/mach-omap2/prminst44xx.c         |   12 ++++++++++
 arch/arm/mach-omap2/prminst44xx.h         |   10 +-------
 arch/arm/mach-omap2/prminst44xx_private.h |   37 +++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prminst44xx_private.h

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 667915d..53ed6c0 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -144,17 +144,6 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
 }
 
-/* Helper functions for MPUSS OSWR */
-static inline void mpuss_clear_prev_logic_pwrst(void)
-{
-	u32 reg;
-
-	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
-	omap4_prminst_write_inst_reg(reg, OMAP4430_PRM_PARTITION,
-		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
-}
-
 static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
 {
 	u32 reg;
@@ -252,7 +241,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * Check MPUSS next state and save interrupt controller if needed.
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
 	 */
-	mpuss_clear_prev_logic_pwrst();
+	omap4_prminst_mpuss_clear_prev_logic_pwrst();
 	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
 		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
 		save_state = 2;
@@ -382,7 +371,7 @@ int __init omap4_mpuss_init(void)
 		return -ENODEV;
 	}
 	pwrdm_clear_all_prev_pwrst(mpuss_pd);
-	mpuss_clear_prev_logic_pwrst();
+	omap4_prminst_mpuss_clear_prev_logic_pwrst();
 
 	/* Save device type on scratchpad for low level code to use */
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 03a6034..3655e16 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -26,7 +26,7 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
-#include "prminst44xx.h"
+#include "prminst44xx_private.h"
 #include "powerdomain.h"
 
 /* Static data */
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 6334b96..00b69d1 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -191,3 +191,15 @@ void omap4_prminst_global_warm_sw_reset(void)
 				    OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 }
+
+void omap4_prminst_mpuss_clear_prev_logic_pwrst(void)
+{
+	u32 reg;
+
+	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+					  OMAP4430_PRM_MPU_INST,
+					  OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+	omap4_prminst_write_inst_reg(reg, OMAP4430_PRM_PARTITION,
+				     OMAP4430_PRM_MPU_INST,
+				     OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index a2ede2d..fec8f18 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -12,15 +12,6 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 
-/*
- * In an ideal world, we would not export these low-level functions,
- * but this will probably take some time to fix properly
- */
-extern u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx);
-extern void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
-extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
-					   s16 inst, u16 idx);
-
 extern void omap4_prminst_global_warm_sw_reset(void);
 
 extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
@@ -29,6 +20,7 @@ extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 					  u16 rstctrl_offs);
 extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 					    u16 rstctrl_offs);
+void omap4_prminst_mpuss_clear_prev_logic_pwrst(void);
 
 extern void omap_prm_base_init(void);
 
diff --git a/arch/arm/mach-omap2/prminst44xx_private.h b/arch/arm/mach-omap2/prminst44xx_private.h
new file mode 100644
index 0000000..c36be15
--- /dev/null
+++ b/arch/arm/mach-omap2/prminst44xx_private.h
@@ -0,0 +1,25 @@
+/*
+ * OMAP4 Power/Reset Management (PRM) function prototypes
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRMINST44XX_PRIVATE_H
+#define __ARCH_ARM_MACH_OMAP2_PRMINST44XX_PRIVATE_H
+
+#include "prminst44xx.h"
+
+/*
+ * In an ideal world, we would not export these low-level functions,
+ * but this will probably take some time to fix properly
+ */
+u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx);
+void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
+u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
+				    s16 inst, u16 idx);
+#endif
-- 
1.7.9.5

