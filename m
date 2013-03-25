From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 02/18] ARM: OMAP5: PM: Update CPU context register offset
Date: Mon, 25 Mar 2013 15:34:54 +0530
Message-ID: <1364205910-32392-3-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50639 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab3CYKDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:03:49 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP5, RM_CPUi_CPUi_CONTEXT offset has changed. Update the code
so that same code works for OMAP4+ devices.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index d9e4843..b1441b1 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -56,6 +56,7 @@
 #include "omap4-sar-layout.h"
 #include "pm.h"
 #include "prcm_mpu44xx.h"
+#include "prcm_mpu54xx.h"
 #include "prminst44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
@@ -92,6 +93,7 @@ extern void omap4_cpu_resume(void);
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
 static void __iomem *sar_base;
+static u32 cpu_context_offset;
 
 static int default_finish_suspend(unsigned long cpu_state)
 {
@@ -164,14 +166,14 @@ static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
 
 	if (cpu_id) {
 		reg = omap4_prcm_mpu_read_inst_reg(OMAP4430_PRCM_MPU_CPU1_INST,
-					OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET);
+					cpu_context_offset);
 		omap4_prcm_mpu_write_inst_reg(reg, OMAP4430_PRCM_MPU_CPU1_INST,
-					OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET);
+					cpu_context_offset);
 	} else {
 		reg = omap4_prcm_mpu_read_inst_reg(OMAP4430_PRCM_MPU_CPU0_INST,
-					OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET);
+					cpu_context_offset);
 		omap4_prcm_mpu_write_inst_reg(reg, OMAP4430_PRCM_MPU_CPU0_INST,
-					OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET);
+					cpu_context_offset);
 	}
 }
 
@@ -410,6 +412,9 @@ int __init omap4_mpuss_init(void)
 		omap_pm_ops.finish_suspend = omap4_finish_suspend;
 		omap_pm_ops.resume = omap4_cpu_resume;
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
+		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
+	} else if (soc_is_omap54xx()) {
+		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 	}
 
 	return 0;
-- 
1.7.9.5

