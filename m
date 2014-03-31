From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 54/55] ARM: OMAP4: PRCM: move prcm_mpu_base definition to a public header
Date: Mon, 31 Mar 2014 18:16:33 +0300
Message-ID: <1396278994-12624-55-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbaCaPTy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:54 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Needed from both PRCM core code and mach-omap2 board code. This gets
rid of need to include the prcm_mpu_44xx_54xx.h header to the PRCM
core code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c         |    1 -
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h |    2 --
 arch/arm/mach-omap2/prminst44xx.c        |    1 -
 include/linux/power/omap/prcm-common.h   |    1 +
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 3d0b8ae..875634b 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -27,7 +27,6 @@
 #include <linux/power/omap/cm44xx.h>
 #include <linux/power/omap/prcm44xx.h>
 #include <linux/power/omap/prm44xx.h>
-#include "prcm_mpu44xx.h"
 #include <linux/power/omap/prcm-common.h>
 
 #define OMAP4430_IDLEST_SHIFT		16
diff --git a/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h b/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
index ca149e7..2b1c995 100644
--- a/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
@@ -24,8 +24,6 @@
 #define __ARCH_ARM_MACH_OMAP2_PRCM_MPU_44XX_54XX_H
 
 #ifndef __ASSEMBLER__
-extern void __iomem *prcm_mpu_base;
-
 extern u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 idx);
 extern u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst,
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 5b7c17e..e97d877 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -22,7 +22,6 @@
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
 #include <linux/power/omap/prcm44xx.h>
-#include "prcm_mpu44xx.h"
 
 #define OMAP4430_RST_GLOBAL_WARM_SW_MASK		(1 << 0)
 
diff --git a/include/linux/power/omap/prcm-common.h b/include/linux/power/omap/prcm-common.h
index b9cce23..a881607 100644
--- a/include/linux/power/omap/prcm-common.h
+++ b/include/linux/power/omap/prcm-common.h
@@ -535,6 +535,7 @@ enum {
 };
 
 extern void __iomem *clk_memmaps[];
+extern void __iomem *prcm_mpu_base;
 
 void omap_prcm_irq_cleanup(void);
 int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup);
-- 
1.7.9.5

