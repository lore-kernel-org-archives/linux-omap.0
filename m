From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 14/29] CORE context save/restore
Date: Thu, 11 Sep 2008 15:33:58 +0300
Message-ID: <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43095 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbYIKMeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:50 -0400
In-Reply-To: <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the CORE context save/restore routines
- save/restores the following
	1) PRCM registers
	2) INTC context
	3) System Control module context
	4) Padconf
---
 arch/arm/mach-omap2/cpuidle34xx.c         |  608 ++++++++++++++++++++++-------
 arch/arm/mach-omap2/cpuidle34xx.h         |   33 ++-
 arch/arm/mach-omap2/pm34xx.c              |  144 +++++++-
 arch/arm/mach-omap2/prm.h                 |    2 +
 arch/arm/mach-omap2/serial.c              |   19 +-
 arch/arm/mach-omap2/sleep34xx.S           |   12 +-
 arch/arm/plat-omap/include/mach/common.h  |    2 +-
 arch/arm/plat-omap/include/mach/control.h |   22 +-
 arch/arm/plat-omap/include/mach/prcm.h    |   56 +++-
 arch/arm/plat-omap/sram.c                 |    9 +-
 drivers/serial/8250.c                     |   20 +
 11 files changed, 755 insertions(+), 172 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ee58873..a02da6d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,7 +28,382 @@
 #include <asm/arch/powerdomain.h>
 #include <asm/arch/clockdomain.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/control.h>
+#include <linux/sched.h>
 #include "cpuidle34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+#include "prm.h"
+#include "pm.h"
+#include "clock34xx.h"
+
+static int padconf_saved;
+void omap3_save_prcm_ctx(void)
+{
+	prcm_sleep_save[1] = omap_readl(INTC_MIR_0);
+	prcm_sleep_save[2] = omap_readl(INTC_MIR_1);
+	prcm_sleep_save[3] = omap_readl(INTC_MIR_2);
+	prcm_sleep_save[4] = omap_readl(CONTROL_PADCONF_SYS_NIRQ);
+	prcm_sleep_save[5] = omap_readl(OMAP34XX_GPIO1_IRQENABLE1);
+	prcm_sleep_save[6] = omap_readl(OMAP34XX_GPIO1_WAKEUPEN);
+	prcm_sleep_save[7] = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
+	prcm_sleep_save[8] = __raw_readl(OMAP3430_CM_SYSCONFIG);
+	prcm_sleep_save[9] = cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
+	prcm_sleep_save[10] = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	prcm_sleep_save[11] = cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
+	prcm_sleep_save[12] = cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
+	prcm_sleep_save[13] = cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
+	prcm_sleep_save[14] = cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
+	prcm_sleep_save[15] = cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[16] = cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
+	prcm_sleep_save[17] = cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+	prcm_sleep_save[18] = __raw_readl(OMAP3430_CM_POLCTRL);
+	prcm_sleep_save[19] = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
+	prcm_sleep_save[20] = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	prcm_sleep_save[21] = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	prcm_sleep_save[22] = cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
+	prcm_sleep_save[23] = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
+	prcm_sleep_save[24] = cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
+	prcm_sleep_save[25] = cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
+	prcm_sleep_save[26] = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
+	prcm_sleep_save[27] = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+							      CM_FCLKEN);
+	prcm_sleep_save[28] = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
+	prcm_sleep_save[29] = cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
+	prcm_sleep_save[30] = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+	prcm_sleep_save[31] = cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
+	prcm_sleep_save[32] = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
+	prcm_sleep_save[33] = cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
+	prcm_sleep_save[34] = cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
+	prcm_sleep_save[35] = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
+	prcm_sleep_save[36] = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+							      CM_ICLKEN);
+	prcm_sleep_save[37] = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+	prcm_sleep_save[38] = cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
+	prcm_sleep_save[39] = cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+	prcm_sleep_save[40] = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[41] = cm_read_mod_reg(MPU_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[42] = cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[43] = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+							      CM_CLKSTCTRL);
+	prcm_sleep_save[44] = cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[45] = cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[46] = cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[47] = cm_read_mod_reg(OMAP3430_NEON_MOD, CM_CLKSTCTRL);
+	prcm_sleep_save[48] = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+							      CM_CLKSTCTRL);
+	prcm_sleep_save[49] = cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
+	prcm_sleep_save[50] = cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
+	prcm_sleep_save[51] = cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
+	prcm_sleep_save[52] = cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
+	prcm_sleep_save[53] = cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
+	prcm_sleep_save[54] = cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
+	prcm_sleep_save[55] = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	prcm_sleep_save[56] = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+							      CM_AUTOIDLE);
+	prcm_sleep_save[57] = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+						      OMAP3430_CM_SLEEPDEP);
+	prcm_sleep_save[58] = cm_read_mod_reg(OMAP3430_DSS_MOD,
+						      OMAP3430_CM_SLEEPDEP);
+	prcm_sleep_save[59] = cm_read_mod_reg(OMAP3430_CAM_MOD,
+						      OMAP3430_CM_SLEEPDEP);
+	prcm_sleep_save[60] = cm_read_mod_reg(OMAP3430_PER_MOD,
+						      OMAP3430_CM_SLEEPDEP);
+	prcm_sleep_save[61] = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+						      OMAP3430_CM_SLEEPDEP);
+	prcm_sleep_save[62] = __raw_readl(OMAP3430_CM_CLKOUT_CTRL);
+	prcm_sleep_save[63] = __raw_readl(OMAP3430_PRM_CLKOUT_CTRL);
+	prcm_sleep_save[64] = prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
+	prcm_sleep_save[65] = prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
+	prcm_sleep_save[66] = prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
+	prcm_sleep_save[67] = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
+	prcm_sleep_save[68] = prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
+	prcm_sleep_save[69] = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+							       PM_WKDEP);
+	prcm_sleep_save[70] = prm_read_mod_reg(CORE_MOD,
+					      OMAP3430_PM_MPUGRPSEL1);
+	prcm_sleep_save[71] = prm_read_mod_reg(OMAP3430_IVA2_MOD,
+					      OMAP3430_PM_IVAGRPSEL1);
+	prcm_sleep_save[72] = prm_read_mod_reg(CORE_MOD,
+					      OMAP3430ES2_PM_MPUGRPSEL3);
+	prcm_sleep_save[73] = prm_read_mod_reg(CORE_MOD,
+					      OMAP3430ES2_PM_IVAGRPSEL3);
+	prcm_sleep_save[74] = prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
+	prcm_sleep_save[75] = prm_read_mod_reg(WKUP_MOD,
+					      OMAP3430_PM_IVAGRPSEL);
+	prcm_sleep_save[76] = prm_read_mod_reg(OMAP3430_PER_MOD,
+					      OMAP3430_PM_MPUGRPSEL);
+	prcm_sleep_save[77] = prm_read_mod_reg(OMAP3430_PER_MOD,
+					      OMAP3430_PM_IVAGRPSEL);
+	prcm_sleep_save[78] = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	return;
+}
+
+void omap3_restore_prcm_ctx(void)
+{
+	omap_writel(prcm_sleep_save[1], INTC_MIR_0);
+	omap_writel(prcm_sleep_save[2], INTC_MIR_1);
+	omap_writel(prcm_sleep_save[3], INTC_MIR_2);
+	omap_writel(prcm_sleep_save[4], CONTROL_PADCONF_SYS_NIRQ);
+	omap_writel(prcm_sleep_save[5], OMAP34XX_GPIO1_IRQENABLE1);
+	omap_writel(prcm_sleep_save[6], OMAP34XX_GPIO1_WAKEUPEN);
+	cm_write_mod_reg(prcm_sleep_save[7], OMAP3430_IVA2_MOD, CM_CLKSEL2);
+	__raw_writel(prcm_sleep_save[8], OMAP3430_CM_SYSCONFIG);
+	cm_write_mod_reg(prcm_sleep_save[9], OMAP3430ES2_SGX_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_sleep_save[10], WKUP_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_sleep_save[11], OMAP3430_DSS_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_sleep_save[12], OMAP3430_CAM_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_sleep_save[13], OMAP3430_PER_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_sleep_save[14], OMAP3430_EMU_MOD, CM_CLKSEL1);
+	cm_write_mod_reg(prcm_sleep_save[15], OMAP3430_EMU_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[16], PLL_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_sleep_save[17], PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+	__raw_writel(prcm_sleep_save[18], OMAP3430_CM_POLCTRL);
+	cm_write_mod_reg(prcm_sleep_save[19], OMAP3430_IVA2_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[20], CORE_MOD, CM_FCLKEN1);
+	cm_write_mod_reg(prcm_sleep_save[21], CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	cm_write_mod_reg(prcm_sleep_save[22], OMAP3430ES2_SGX_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[23], WKUP_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[24], OMAP3430_DSS_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[25], OMAP3430_CAM_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[26], OMAP3430_PER_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[27], OMAP3430ES2_USBHOST_MOD,
+							       CM_FCLKEN);
+	cm_write_mod_reg(prcm_sleep_save[28], CORE_MOD, CM_ICLKEN1);
+	cm_write_mod_reg(prcm_sleep_save[29], CORE_MOD, CM_ICLKEN2);
+	cm_write_mod_reg(prcm_sleep_save[30], CORE_MOD, CM_ICLKEN3);
+	cm_write_mod_reg(prcm_sleep_save[31], OMAP3430ES2_SGX_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[32], WKUP_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[33], OMAP3430_DSS_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[34], OMAP3430_CAM_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[35], OMAP3430_PER_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[36], OMAP3430ES2_USBHOST_MOD,
+								CM_ICLKEN);
+	cm_write_mod_reg(prcm_sleep_save[37], OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_sleep_save[38], MPU_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_sleep_save[39], PLL_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[40], OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[41], MPU_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[42], CORE_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[43], OMAP3430ES2_SGX_MOD,
+						       CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[44], OMAP3430_DSS_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[45], OMAP3430_CAM_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[46], OMAP3430_PER_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[47], OMAP3430_NEON_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[48], OMAP3430ES2_USBHOST_MOD,
+							       CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_sleep_save[49], CORE_MOD, CM_AUTOIDLE1);
+	cm_write_mod_reg(prcm_sleep_save[50], CORE_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_sleep_save[51], CORE_MOD, CM_AUTOIDLE3);
+	cm_write_mod_reg(prcm_sleep_save[52], WKUP_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[53], OMAP3430_DSS_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[54], OMAP3430_CAM_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[55], OMAP3430_PER_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[56], OMAP3430ES2_USBHOST_MOD,
+							       CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_sleep_save[57], OMAP3430ES2_SGX_MOD,
+						       OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_sleep_save[58], OMAP3430_DSS_MOD,
+						       OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_sleep_save[59], OMAP3430_CAM_MOD,
+						       OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_sleep_save[60], OMAP3430_PER_MOD,
+						       OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_sleep_save[61], OMAP3430ES2_USBHOST_MOD,
+						       OMAP3430_CM_SLEEPDEP);
+	__raw_writel(prcm_sleep_save[62], OMAP3430_CM_CLKOUT_CTRL);
+	__raw_writel(prcm_sleep_save[63], OMAP3430_PRM_CLKOUT_CTRL);
+	prm_write_mod_reg(prcm_sleep_save[64], OMAP3430ES2_SGX_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[65], OMAP3430_DSS_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[66], OMAP3430_CAM_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[67], OMAP3430_PER_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[68], OMAP3430_NEON_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[69], OMAP3430ES2_USBHOST_MOD,
+							       PM_WKDEP);
+	prm_write_mod_reg(prcm_sleep_save[70], CORE_MOD,
+					       OMAP3430_PM_MPUGRPSEL1);
+	prm_write_mod_reg(prcm_sleep_save[71], OMAP3430_IVA2_MOD,
+					       OMAP3430_PM_IVAGRPSEL1);
+	prm_write_mod_reg(prcm_sleep_save[72], CORE_MOD,
+					       OMAP3430ES2_PM_MPUGRPSEL3);
+	prm_write_mod_reg(prcm_sleep_save[73], CORE_MOD,
+					       OMAP3430ES2_PM_IVAGRPSEL3);
+	prm_write_mod_reg(prcm_sleep_save[74], WKUP_MOD,
+					       OMAP3430_PM_MPUGRPSEL);
+	prm_write_mod_reg(prcm_sleep_save[75], WKUP_MOD,
+					       OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(prcm_sleep_save[76], OMAP3430_PER_MOD,
+					       OMAP3430_PM_MPUGRPSEL);
+	prm_write_mod_reg(prcm_sleep_save[77], OMAP3430_PER_MOD,
+					       OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(prcm_sleep_save[78], WKUP_MOD, PM_WKEN);
+	return;
+}
+
+static void omap_save_intc_ctx(void)
+{
+	int ind = 0;
+	intc_context.sysconfig = omap_readl(INTCPS_SYSCONFIG);
+	intc_context.protection =  omap_readl(INTCPS_PROTECTION);
+	intc_context.idle = omap_readl(INTCPS_IDLE);
+	intc_context.threshold = omap_readl(INTCPS_THRESHOLD);
+	for (ind = 0; ind < 96; ind++)
+	       intc_context.ilr[ind] =
+		       omap_readl(INTC_BASE + (0x100 + 0x4*ind));
+	/* MIRs are saved and restore with other PRCM registers */
+}
+
+static void omap_restore_intc_ctx(void)
+{
+	int ind = 0;
+	omap_writel(intc_context.sysconfig, INTCPS_SYSCONFIG);
+	omap_writel(intc_context.protection, INTCPS_PROTECTION);
+	omap_writel(intc_context.idle, INTCPS_IDLE);
+	omap_writel(intc_context.threshold, INTCPS_THRESHOLD);
+	for (ind = 0; ind < 96; ind++)
+	       omap_writel(intc_context.ilr[ind],
+		       INTC_BASE + (0x100 + 0x4*ind));
+	/* MIRs are saved and restore with other PRCM registers */
+}
+
+static void omap_save_control_ctx(void)
+{
+	control_ctx.sysconfig = omap_ctrl_readl(OMAP2_CONTROL_SYSCONFIG);
+	control_ctx.devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	control_ctx.mem_dftrw0 = omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW0);
+	control_ctx.mem_dftrw1 = omap_ctrl_readl(OMAP343X_CONTROL_MEM_DFTRW1);
+	control_ctx.msuspendmux_0 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_0);
+	control_ctx.msuspendmux_1 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_1);
+	control_ctx.msuspendmux_2 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_2);
+	control_ctx.msuspendmux_3 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_3);
+	control_ctx.msuspendmux_4 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_4);
+	control_ctx.msuspendmux_5 =
+		       omap_ctrl_readl(OMAP2_CONTROL_MSUSPENDMUX_5);
+	control_ctx.sec_ctrl = omap_ctrl_readl(OMAP2_CONTROL_SEC_CTRL);
+	control_ctx.devconf1 = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	control_ctx.csirxfe = omap_ctrl_readl(OMAP343X_CONTROL_CSIRXFE);
+	control_ctx.iva2_bootaddr =
+		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTADDR);
+	control_ctx.iva2_bootmod =
+		       omap_ctrl_readl(OMAP343X_CONTROL_IVA2_BOOTMOD);
+	control_ctx.debobs_0 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_0);
+	control_ctx.debobs_1 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_1);
+	control_ctx.debobs_2 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_2);
+	control_ctx.debobs_3 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_3);
+	control_ctx.debobs_4 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_4);
+	control_ctx.debobs_5 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_5);
+	control_ctx.debobs_6 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_6);
+	control_ctx.debobs_7 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_7);
+	control_ctx.debobs_8 = omap_ctrl_readl(OMAP343X_CONTROL_DEBOBS_8);
+	control_ctx.prog_io0 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO0);
+	control_ctx.prog_io1 = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
+	control_ctx.dss_dpll_spreading =
+	       omap_ctrl_readl(OMAP343X_CONTROL_DSS_DPLL_SPREADING);
+	control_ctx.core_dpll_spreading =
+	       omap_ctrl_readl(OMAP343X_CONTROL_CORE_DPLL_SPREADING);
+	control_ctx.per_dpll_spreading =
+	       omap_ctrl_readl(OMAP343X_CONTROL_PER_DPLL_SPREADING);
+	control_ctx.usbhost_dpll_spreading =
+	       omap_ctrl_readl(OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
+	control_ctx.pbias_lite = omap_ctrl_readl(OMAP343X_CONTROL_PBIAS_LITE);
+	control_ctx.temp_sensor = omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);
+	control_ctx.sramldo4 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO4);
+	control_ctx.sramldo5 = omap_ctrl_readl(OMAP343X_CONTROL_SRAMLDO5);
+	control_ctx.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
+	return;
+}
+
+static void omap_restore_control_ctx(void)
+{
+	omap_ctrl_writel(control_ctx.sysconfig, OMAP2_CONTROL_SYSCONFIG);
+	omap_ctrl_writel(control_ctx.devconf0, OMAP2_CONTROL_DEVCONF0);
+	omap_ctrl_writel(control_ctx.mem_dftrw0, OMAP343X_CONTROL_MEM_DFTRW0);
+	omap_ctrl_writel(control_ctx.mem_dftrw1, OMAP343X_CONTROL_MEM_DFTRW1);
+	omap_ctrl_writel(control_ctx.msuspendmux_0,
+					       OMAP2_CONTROL_MSUSPENDMUX_0);
+	omap_ctrl_writel(control_ctx.msuspendmux_1,
+					       OMAP2_CONTROL_MSUSPENDMUX_1);
+	omap_ctrl_writel(control_ctx.msuspendmux_2,
+					       OMAP2_CONTROL_MSUSPENDMUX_2);
+	omap_ctrl_writel(control_ctx.msuspendmux_3,
+					       OMAP2_CONTROL_MSUSPENDMUX_3);
+	omap_ctrl_writel(control_ctx.msuspendmux_4,
+					       OMAP2_CONTROL_MSUSPENDMUX_4);
+	omap_ctrl_writel(control_ctx.msuspendmux_5,
+					       OMAP2_CONTROL_MSUSPENDMUX_5);
+	omap_ctrl_writel(control_ctx.sec_ctrl, OMAP2_CONTROL_SEC_CTRL);
+	omap_ctrl_writel(control_ctx.devconf1, OMAP343X_CONTROL_DEVCONF1);
+	omap_ctrl_writel(control_ctx.csirxfe, OMAP343X_CONTROL_CSIRXFE);
+	omap_ctrl_writel(control_ctx.iva2_bootaddr,
+					       OMAP343X_CONTROL_IVA2_BOOTADDR);
+	omap_ctrl_writel(control_ctx.iva2_bootmod,
+					       OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap_ctrl_writel(control_ctx.debobs_0, OMAP343X_CONTROL_DEBOBS_0);
+	omap_ctrl_writel(control_ctx.debobs_1, OMAP343X_CONTROL_DEBOBS_1);
+	omap_ctrl_writel(control_ctx.debobs_2, OMAP343X_CONTROL_DEBOBS_2);
+	omap_ctrl_writel(control_ctx.debobs_3, OMAP343X_CONTROL_DEBOBS_3);
+	omap_ctrl_writel(control_ctx.debobs_4, OMAP343X_CONTROL_DEBOBS_4);
+	omap_ctrl_writel(control_ctx.debobs_5, OMAP343X_CONTROL_DEBOBS_5);
+	omap_ctrl_writel(control_ctx.debobs_6, OMAP343X_CONTROL_DEBOBS_6);
+	omap_ctrl_writel(control_ctx.debobs_7, OMAP343X_CONTROL_DEBOBS_7);
+	omap_ctrl_writel(control_ctx.debobs_8, OMAP343X_CONTROL_DEBOBS_8);
+	omap_ctrl_writel(control_ctx.prog_io0, OMAP343X_CONTROL_PROG_IO0);
+	omap_ctrl_writel(control_ctx.prog_io1, OMAP343X_CONTROL_PROG_IO1);
+	omap_ctrl_writel(control_ctx.dss_dpll_spreading,
+			       OMAP343X_CONTROL_DSS_DPLL_SPREADING);
+	omap_ctrl_writel(control_ctx.core_dpll_spreading,
+			       OMAP343X_CONTROL_CORE_DPLL_SPREADING);
+	omap_ctrl_writel(control_ctx.per_dpll_spreading,
+			       OMAP343X_CONTROL_PER_DPLL_SPREADING);
+	omap_ctrl_writel(control_ctx.usbhost_dpll_spreading,
+			       OMAP343X_CONTROL_USBHOST_DPLL_SPREADING);
+	omap_ctrl_writel(control_ctx.pbias_lite, OMAP343X_CONTROL_PBIAS_LITE);
+	omap_ctrl_writel(control_ctx.temp_sensor, OMAP343X_CONTROL_TEMP_SENSOR);
+	omap_ctrl_writel(control_ctx.sramldo4, OMAP343X_CONTROL_SRAMLDO4);
+	omap_ctrl_writel(control_ctx.sramldo5, OMAP343X_CONTROL_SRAMLDO5);
+	omap_ctrl_writel(control_ctx.csi, OMAP343X_CONTROL_CSI);
+	return;
+}
+
+void omap3_save_core_ctx(void)
+{
+	u32 control_padconf_off;
+
+	if (!padconf_saved) {
+	       /* Save the padconf registers */
+	       control_padconf_off = omap_readl(CONTROL_PADCONF_OFF);
+	       control_padconf_off |= 2;
+	       omap_writel(control_padconf_off, CONTROL_PADCONF_OFF);
+	       /* wait for the save to complete */
+	       while (!omap_readl(CONTROL_GENERAL_PURPOSE_STATUS) & 0x1);
+	       padconf_saved = 1;
+	}
+	/* Save the Interrupt controller context */
+	omap_save_intc_ctx();
+	/* Save the GPMC context */
+	omap_save_gpmc_ctx();
+	/* Save the system control module context, padconf already save above*/
+	omap_save_control_ctx();
+}
+
+void omap3_restore_core_ctx(void)
+{
+	/* Restore the control module context, padconf restored by h/w */
+	omap_restore_control_ctx();
+	/* Restore the GPMC context */
+	omap_restore_gpmc_ctx();
+	/* Restore the interrupt controller context */
+	omap_restore_intc_ctx();
+	padconf_saved = 0;
+}
 
 #ifdef CONFIG_CPU_IDLE
 
@@ -42,6 +417,8 @@ static int omap3_idle_bm_check(void)
 	return 0;
 }
 
+
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 /* omap3_enter_idle - Programs OMAP3 to enter the specified state.
  * returns the total time during which the system was idle.
  */
@@ -50,8 +427,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	struct powerdomain *mpu_pd, *core_pd, *per_pd, *neon_pd;
-	int per_pwrst, neon_pwrst;
+	struct powerdomain *mpu_pd, *core_pd;
 
 	current_cx_state = *cx;
 
@@ -60,79 +436,37 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 		return 0;
 	}
 
+	local_irq_disable();
+	local_fiq_disable();
+
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
 
+	if (cx->type > OMAP3_STATE_C1)
+		sched_clock_idle_sleep_event(); /* about to enter deep idle */
+
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
-	per_pd = pwrdm_lookup("per_pwrdm");
-	neon_pd = pwrdm_lookup("neon_pwrdm");
 
-	/* Reset previous power state registers */
-	pwrdm_clear_all_prev_pwrst(mpu_pd);
-	pwrdm_clear_all_prev_pwrst(neon_pd);
-	pwrdm_clear_all_prev_pwrst(core_pd);
-	pwrdm_clear_all_prev_pwrst(per_pd);
+	set_pwrdm_state(mpu_pd, cx->mpu_state);
+	set_pwrdm_state(core_pd, cx->core_state);
 
 	if (omap_irq_pending())
-		return 0;
-
-	per_pwrst = pwrdm_read_pwrst(per_pd);
-	neon_pwrst = pwrdm_read_pwrst(neon_pd);
-
-	/* Program MPU to target state */
-	if (cx->mpu_state < PWRDM_POWER_ON) {
-		if (neon_pwrst == PWRDM_POWER_ON) {
-			if (cx->mpu_state == PWRDM_POWER_RET)
-				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
-			else if (cx->mpu_state == PWRDM_POWER_OFF)
-				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_OFF);
-		}
-		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
-	}
-
-	/* Program CORE and PER to target state */
-	if (cx->core_state < PWRDM_POWER_ON) {
-		if (per_pwrst == PWRDM_POWER_ON) {
-			omap2_gpio_prepare_for_retention();
-			per_gpio_clk_disable();
-			omap_serial_enable_clocks(0);
-		}
-		pwrdm_set_next_pwrst(core_pd, cx->core_state);
-	}
-
-	*(scratchpad_restore_addr) = restore_pointer_address;
+		goto return_sleep_time;
 
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
-	*(scratchpad_restore_addr) = 0x0;
-
-	/* Program MPU/NEON to ON */
-	if (cx->mpu_state < PWRDM_POWER_ON) {
-		if (neon_pwrst == PWRDM_POWER_ON)
-			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_ON);
-		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
-	}
+return_sleep_time:
+	getnstimeofday(&ts_postidle);
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-	if (cx->core_state < PWRDM_POWER_ON) {
-		if (per_pwrst == PWRDM_POWER_ON) {
-			omap_serial_enable_clocks(1);
-			per_gpio_clk_enable();
-			omap2_gpio_resume_after_retention();
-		}
-		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
-	}
+	if (cx->type > OMAP3_STATE_C1)
+		sched_clock_idle_wakeup_event(timespec_to_ns(&ts_idle));
 
-	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
-			       pwrdm_read_prev_pwrst(mpu_pd),
-			       pwrdm_read_prev_pwrst(neon_pd));
-	pr_debug("PER prev st:%x,CORE prev st:%x\n",
-			       pwrdm_read_prev_pwrst(per_pd),
-			       pwrdm_read_prev_pwrst(core_pd));
+	local_irq_enable();
+	local_fiq_enable();
 
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 	return (u32)timespec_to_ns(&ts_idle)/1000;
 }
 
@@ -143,25 +477,28 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	int i, j;
 
 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
-
-		/* Find current state in list */
-		for (i = 0; i < OMAP3_MAX_STATES; i++)
-			if (state == &dev->states[i])
-				break;
-		BUG_ON(i == OMAP3_MAX_STATES);
-
-		/* Back up to non 'CHECK_BM' state */
-		for (j = i - 1;  j > 0; j--) {
-			struct cpuidle_state *s = &dev->states[j];
-
-			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
-				new_state = s;
-				break;
+		if (dev->safe_state)
+			return dev->safe_state->enter(dev, dev->safe_state);
+		else {
+			/* Find current state in list */
+			for (i = 0; i < OMAP3_MAX_STATES; i++)
+				if (state == &dev->states[i])
+					break;
+			BUG_ON(i == OMAP3_MAX_STATES);
+
+			/* Back up to non 'CHECK_BM' state */
+			for (j = i - 1;  j >= 0; j--) {
+				struct cpuidle_state *s = &dev->states[j];
+
+				if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
+					new_state = s;
+					break;
+				}
 			}
+			pr_debug("%s: Bus activity: Entering %s\
+				(instead of %s)\n", __func__,
+				 new_state->name, state->name);
 		}
-
-		pr_debug("%s: Bus activity: Entering %s (instead of %s)\n",
-			__func__, new_state->name, state->name);
 	}
 
 	return omap3_enter_idle(dev, new_state ? : state);
@@ -183,79 +520,79 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 void omap_init_power_states(void)
 {
 	/* C0 . System executing code */
-	omap3_power_states[0].valid = 1;
-	omap3_power_states[0].type = OMAP3_STATE_C0;
-	omap3_power_states[0].sleep_latency = 0;
-	omap3_power_states[0].wakeup_latency = 0;
-	omap3_power_states[0].threshold = 0;
-	omap3_power_states[0].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[0].core_state = PWRDM_POWER_ON;
-	omap3_power_states[0].flags = CPUIDLE_FLAG_SHALLOW;
+	omap3_power_states[OMAP3_STATE_C0].valid = 1;
+	omap3_power_states[OMAP3_STATE_C0].type = OMAP3_STATE_C0;
+	omap3_power_states[OMAP3_STATE_C0].sleep_latency = 0;
+	omap3_power_states[OMAP3_STATE_C0].wakeup_latency = 0;
+	omap3_power_states[OMAP3_STATE_C0].threshold = 0;
+	omap3_power_states[OMAP3_STATE_C0].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].flags = CPUIDLE_FLAG_SHALLOW;
 
 	/* C1 . MPU WFI + Core active */
-	omap3_power_states[1].valid = 1;
-	omap3_power_states[1].type = OMAP3_STATE_C1;
-	omap3_power_states[1].sleep_latency = 10;
-	omap3_power_states[1].wakeup_latency = 10;
-	omap3_power_states[1].threshold = 30;
-	omap3_power_states[1].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[1].core_state = PWRDM_POWER_ON;
-	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C1].valid = 1;
+	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
+	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 10;
+	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 10;
+	omap3_power_states[OMAP3_STATE_C1].threshold = 30;
+	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID |
 						CPUIDLE_FLAG_SHALLOW;
 
 	/* C2 . MPU CSWR + Core active */
-	omap3_power_states[2].valid = 1;
-	omap3_power_states[2].type = OMAP3_STATE_C2;
-	omap3_power_states[2].sleep_latency = 50;
-	omap3_power_states[2].wakeup_latency = 50;
-	omap3_power_states[2].threshold = 300;
-	omap3_power_states[2].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C2].valid = 1;
+	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
+	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 50;
+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 50;
+	omap3_power_states[OMAP3_STATE_C2].threshold = 300;
+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
 						CPUIDLE_FLAG_BALANCED;
 
 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[3].valid = 1;
-	omap3_power_states[3].type = OMAP3_STATE_C3;
-	omap3_power_states[3].sleep_latency = 1500;
-	omap3_power_states[3].wakeup_latency = 1800;
-	omap3_power_states[3].threshold = 4000;
-	omap3_power_states[3].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[3].core_state = PWRDM_POWER_ON;
-	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID |
-			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C3].valid = 1;
+	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
+	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
+	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
+	omap3_power_states[OMAP3_STATE_C3].threshold = 4000;
+	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED;
 
 	/* C4 . MPU CSWR + Core CSWR*/
-	omap3_power_states[4].valid = 1;
-	omap3_power_states[4].type = OMAP3_STATE_C4;
-	omap3_power_states[4].sleep_latency = 2500;
-	omap3_power_states[4].wakeup_latency = 7500;
-	omap3_power_states[4].threshold = 12000;
-	omap3_power_states[4].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[4].core_state = PWRDM_POWER_RET;
-	omap3_power_states[4].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C4].valid = 1;
+	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
+	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
+	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
+	omap3_power_states[OMAP3_STATE_C4].threshold = 12000;
+	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[5].valid = 1;
-	omap3_power_states[5].type = OMAP3_STATE_C5;
-	omap3_power_states[5].sleep_latency = 3000;
-	omap3_power_states[5].wakeup_latency = 8500;
-	omap3_power_states[5].threshold = 15000;
-	omap3_power_states[5].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[5].core_state = PWRDM_POWER_RET;
-	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C5].valid = 1;
+	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
+	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
+	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
+	omap3_power_states[OMAP3_STATE_C5].threshold = 15000;
+	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core OFF */
-	omap3_power_states[6].valid = 0;
-	omap3_power_states[6].type = OMAP3_STATE_C6;
-	omap3_power_states[6].sleep_latency = 10000;
-	omap3_power_states[6].wakeup_latency = 30000;
-	omap3_power_states[6].threshold = 300000;
-	omap3_power_states[6].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].core_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C6].valid = 1;
+	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
+	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
+	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
+	omap3_power_states[OMAP3_STATE_C6].threshold = 300000;
+	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
 }
 
@@ -273,6 +610,7 @@ int omap3_idle_init(void)
 	struct omap3_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;
+	char clk_name[11];
 
 	clear_scratchpad_contents();
 	save_scratchpad_contents();
@@ -294,6 +632,8 @@ int omap3_idle_init(void)
 		state->flags = cx->flags;
 		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
 			omap3_enter_idle_bm : omap3_enter_idle;
+		if (cx->type == OMAP3_STATE_C1)
+			dev->safe_state = state;
 		sprintf(state->name, "C%d", count+1);
 		count++;
 	}
diff --git a/arch/arm/mach-omap2/cpuidle34xx.h b/arch/arm/mach-omap2/cpuidle34xx.h
index f2ebe68..a2036cf 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.h
+++ b/arch/arm/mach-omap2/cpuidle34xx.h
@@ -30,20 +30,42 @@
 #define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
 #define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
 
-/* Currently, we support only upto C2 */
-#define MAX_SUPPORTED_STATES 3
+/* Interrupt Controller registers */
+#define INTC_BASE	0x48200000
+#define INTC_MIR_0	0x48200084
+#define INTC_MIR_1	0x482000A4
+#define INTC_MIR_2	0x482000C4
+#define INTCPS_SYSCONFIG	0x48200010
+#define INTCPS_PROTECTION	0x4820004C
+#define INTCPS_IDLE	0x48200050
+#define INTCPS_THRESHOLD	0x48200068
+
+#define CONTROL_PADCONF_SYS_NIRQ	0x480021E0
+#define CONTROL_PADCONF_OFF	0x48002270
+#define CONTROL_GENERAL_PURPOSE_STATUS	0x480022F4
+
+#define OMAP34XX_GPIO1_IRQENABLE1	0x4831001c
+#define OMAP34XX_GPIO1_WAKEUPEN	0x48310020
+#define OMAP34XX_GPIO1_FALLINGDETECT	0x4831004c
 
 extern unsigned short clocks_off_while_idle;
 extern void omap_sram_idle(void);
 extern int omap_irq_pending(void);
 extern void per_gpio_clk_enable(void);
 extern void per_gpio_clk_disable(void);
-extern void omap_serial_enable_clocks(int enable);
+extern void omap_serial_enable_clocks(int enable, int unum);
 extern int omap3_can_sleep();
 extern void clear_scratchpad_contents(void);
 extern void save_scratchpad_contents(void);
 extern u32 *scratchpad_restore_addr;
 extern u32 restore_pointer_address;
+extern void omap3_save_per_ctx();
+extern void omap3_restore_per_ctx();
+extern void omap_save_uart_ctx(int);
+extern void omap_restore_uart_ctx(int);
+extern void omap3_restore_sram_ctx();
+extern int omap3_can_sleep();
+extern int omap_serial_can_sleep();
 
 struct omap3_processor_cx {
 	u8 valid;
@@ -59,5 +81,10 @@ struct omap3_processor_cx {
 void omap_init_power_states(void);
 int omap3_idle_init(void);
 
+/* TODO fix the size:100 */
+static unsigned int prcm_sleep_save[100];
+static struct int_controller_context intc_context;
+static struct control_module_context control_ctx;
+
 #endif /* ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX */
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index acfca0b..da6eae1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -65,6 +65,20 @@ static void (*_omap_sram_idle)(u32 *addr, int save_state);
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *neon_pwrdm, *per_pwrdm;
+static struct powerdomain *core_pwrdm;
+
+void omap3_save_per_ctx(void);
+void omap3_restore_per_ctx(void);
+void omap3_save_core_ctx(void);
+void omap3_restore_core_ctx(void);
+void omap3_save_sram_ctx(void);
+void omap3_restore_sram_ctx(void);
+void omap3_save_prcm_ctx(void);
+void omap3_restore_prcm_ctx(void);
+void omap_save_uart_ctx(int unum);
+void omap_restore_uart_ctx(int unum);
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 /* Dynamic GPIO clock handling for sleep routines.
  * omap_sram_idle() will call these functions and they will dynamically
@@ -163,7 +177,6 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
 		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
 	}
-
 	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
 		/* USBHOST */
 		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
@@ -234,11 +247,19 @@ void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0;
+	int mpu_next_state = PWRDM_POWER_ON, core_next_state = PWRDM_POWER_ON,
+		per_next_state = PWRDM_POWER_ON;
+	int mpu_prev_state, core_prev_state, per_prev_state;
 
 	if (!_omap_sram_idle)
 		return;
 
+	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
+	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
+	pwrdm_clear_all_prev_pwrst(core_pwrdm);
+	pwrdm_clear_all_prev_pwrst(per_pwrdm);
+
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
@@ -257,11 +278,76 @@ void omap_sram_idle(void)
 
 	pm_dbg_pre_suspend();
 
+	/* NEON control */
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+	set_pwrdm_state(neon_pwrdm, mpu_next_state);
+
+	/* CORE & PER */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		/* PER changes only with core */
+		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+		if (per_next_state < PWRDM_POWER_ON) {
+			if (per_next_state == PWRDM_POWER_OFF) {
+				omap3_save_per_ctx();
+				omap_save_uart_ctx(2);
+			}
+			per_gpio_clk_disable();
+			omap_serial_enable_clocks(0, 2);
+		}
+		if (core_next_state == PWRDM_POWER_OFF) {
+			omap3_save_core_ctx();
+			omap3_save_prcm_ctx();
+			omap_save_uart_ctx(0);
+			omap_save_uart_ctx(1);
+		}
+		omap_serial_enable_clocks(0, 0);
+		omap_serial_enable_clocks(0, 1);
+		if (core_next_state == PWRDM_POWER_OFF)
+			omap3_save_prcm_ctx();
+		/* Enable IO-PAD wakeup */
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+	}
+
+	*(scratchpad_restore_addr) = restore_pointer_address;
+
 	_omap_sram_idle(context_mem, save_state);
+
+	*(scratchpad_restore_addr) = 0x0;
+
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
 		restore_table_entry();
 
+	if (core_next_state < PWRDM_POWER_ON) {
+		/* Disable IO-PAD wakeup */
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
+		if (core_prev_state == PWRDM_POWER_OFF)
+			omap3_restore_prcm_ctx();
+		omap_serial_enable_clocks(1, 0);
+		omap_serial_enable_clocks(1, 1);
+		if (core_prev_state == PWRDM_POWER_OFF) {
+			omap3_restore_core_ctx();
+			omap3_restore_sram_ctx();
+			omap_restore_uart_ctx(0);
+			omap_restore_uart_ctx(1);
+		}
+		if (per_next_state < PWRDM_POWER_ON) {
+			per_gpio_clk_enable();
+			/* This would be actually more effective */
+			omap_serial_enable_clocks(1, 2);
+			per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
+			if (per_prev_state == PWRDM_POWER_OFF) {
+				omap3_restore_per_ctx();
+				/* This would be actually more effective */
+				omap_restore_uart_ctx(2);
+			}
+		}
+		omap2_gpio_resume_after_retention();
+	}
+
 	pm_dbg_post_suspend();
 }
 
@@ -394,12 +480,16 @@ static void omap3_pm_idle(void)
 
 	omap2_gpio_prepare_for_retention();
 
-	omap_serial_enable_clocks(0);
+	omap_serial_enable_clocks(0, 0);
+	omap_serial_enable_clocks(0, 1);
+	omap_serial_enable_clocks(0, 2);
 	per_gpio_clk_disable();
 
 	omap_sram_idle();
 
-	omap_serial_enable_clocks(1);
+	omap_serial_enable_clocks(1, 0);
+	omap_serial_enable_clocks(1, 1);
+	omap_serial_enable_clocks(1, 2);
 	per_gpio_clk_enable();
 
 	omap2_gpio_resume_after_retention();
@@ -437,12 +527,16 @@ static int omap3_pm_suspend(void)
 
 	omap2_gpio_prepare_for_retention();
 
-	omap_serial_enable_clocks(0);
+	omap_serial_enable_clocks(0, 0);
+	omap_serial_enable_clocks(0, 1);
+	omap_serial_enable_clocks(0, 2);
 	per_gpio_clk_disable();
 
 	omap_sram_idle();
 
-	omap_serial_enable_clocks(1);
+	omap_serial_enable_clocks(1, 0);
+	omap_serial_enable_clocks(1, 1);
+	omap_serial_enable_clocks(1, 2);
 	per_gpio_clk_enable();
 
 	omap2_gpio_resume_after_retention();
@@ -653,6 +747,16 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
+void omap3_save_per_ctx(void)
+{
+	omap_gpio_save();
+}
+
+void omap3_restore_per_ctx(void)
+{
+	omap_gpio_restore();
+}
+
 static struct power_state *get_pwrst_node(const char *name)
 {
 	struct powerdomain *pwrdm;
@@ -722,8 +826,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm"))
-		pwrst->next_state = PWRDM_POWER_RET;
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||
+			!strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
+			!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+		pwrst->next_state = PWRDM_POWER_ON;
 	else
 		pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);
@@ -746,6 +852,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
+void omap_push_sram_idle()
+{
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+					omap34xx_cpu_suspend_sz);
+}
+
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
@@ -757,6 +869,7 @@ int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
+	save_scratchpad_contents();
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
@@ -784,10 +897,11 @@ int __init omap3_pm_init(void)
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
 		goto err2;
 	}
+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
-
+	omap_push_sram_idle();
 	suspend_set_ops(&omap_pm_ops);
 
 #ifndef CONFIG_CPU_IDLE
@@ -801,6 +915,9 @@ int __init omap3_pm_init(void)
 		gpio_fcks[i-1] = clk_get(NULL, clk_name);
 	}
 
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+
 err1:
 	return ret;
 err2:
@@ -878,8 +995,11 @@ void save_scratchpad_contents(void)
 	*(scratchpad_address++) = __raw_readl(OMAP3430_PRM_CLKSEL);
 	*(scratchpad_address++) = cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
 	*(scratchpad_address++) = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	/* TODO OMAP3430_CM_CLKEN_PLL is defined 0x4 */
+	/**(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+		OMAP3430_CM_CLKEN_PLL);*/
 	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
-				      OMAP3430_CM_CLKEN_PLL);
+				      0x0);
 	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
 				      OMAP3430_CM_AUTOIDLE_PLL);
 	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 3c6418e..a344e40 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -137,9 +137,11 @@
 
 #define OMAP3430_PM_MPUGRPSEL				0x00a4
 #define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
 
 #define OMAP3430_PM_IVAGRPSEL				0x00a8
 #define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
 
 #define OMAP3430_PM_PREPWSTST				0x00e8
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 879d7c1..c189cc9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -157,20 +157,17 @@ static void omap_serial_kick(void)
 		NSEC_PER_MSEC);
 }
 
-void omap_serial_enable_clocks(int enable)
+void omap_serial_enable_clocks(int enable, int unum)
 {
-	int i;
 	if (uart_clocks_off_while_idle == 0)
 		return;
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		if (uart_ick[i] && uart_fck[i]) {
-			if (enable) {
-				clk_enable(uart_ick[i]);
-				clk_enable(uart_fck[i]);
-			} else {
-				clk_disable(uart_ick[i]);
-				clk_disable(uart_fck[i]);
-			}
+	if (uart_ick[unum] && uart_fck[unum]) {
+		if (enable) {
+			clk_enable(uart_ick[unum]);
+			clk_enable(uart_fck[unum]);
+		} else {
+			clk_disable(uart_ick[unum]);
+			clk_disable(uart_fck[unum]);
 		}
 	}
 }
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 7cce8ef..efafa7e 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -457,10 +457,12 @@ loop2:
 	mov     r9, r4
 	/* create working copy of max way size*/
 loop3:
-	/* factor way and cache number into r11 */
-	orr     r11, r10, r9, lsl r5
-	/* factor index number into r11 */
-	orr     r11, r11, r7, lsl r2
+ 	orr	r11, r10, r9, lsl r5	 @ factor way and cache number into r11
+ 	orr	r11, r11, r7, lsl r2	 @ factor index number into r11
+ 	lsl	r6, r9, r5
+ 	orr	r11, r10, r6		 @ factor way and cache number into r11
+ 	lsl	r6, r7, r2
+ 	orr	r11, r11, r6		 @ factor index number into r11
 	/*clean & invalidate by set/way */
 	mcr     p15, 0, r11, c7, c10, 2
 	/* decrement the way*/
@@ -475,7 +477,7 @@ skip:
 	cmp     r3, r10
 	bgt     loop1
 finished:
-	/*swith back to cache level 0 */
+	/*switch back to cache level 0 */
 	mov     r10, #0
 	/* select current cache level in cssr */
 	mcr     p15, 2, r10, c0, c0, 0
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 489add6..faba335 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -34,7 +34,7 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
-extern void omap_serial_enable_clocks(int enable);
+extern void omap_serial_enable_clocks(int enable, int unum);
 extern int omap_serial_can_sleep(void);
 extern void omap_gpio_save(void);
 extern void omap_gpio_restore(void);
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 9ca0e08..ef8cf12 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -149,7 +149,27 @@
 #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
-#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP343X_CONTROL_DEBOBS_0	(OMAP2_CONTROL_GENERAL + 0x01B0)
+#define OMAP343X_CONTROL_DEBOBS_1	(OMAP2_CONTROL_GENERAL + 0x01B4)
+#define OMAP343X_CONTROL_DEBOBS_2	(OMAP2_CONTROL_GENERAL + 0x01B8)
+#define OMAP343X_CONTROL_DEBOBS_3	(OMAP2_CONTROL_GENERAL + 0x01BC)
+#define OMAP343X_CONTROL_DEBOBS_4	(OMAP2_CONTROL_GENERAL + 0x01C0)
+#define OMAP343X_CONTROL_DEBOBS_5	(OMAP2_CONTROL_GENERAL + 0x01C4)
+#define OMAP343X_CONTROL_DEBOBS_6	(OMAP2_CONTROL_GENERAL + 0x01C8)
+#define OMAP343X_CONTROL_DEBOBS_7	(OMAP2_CONTROL_GENERAL + 0x01CC)
+#define OMAP343X_CONTROL_DEBOBS_8	(OMAP2_CONTROL_GENERAL + 0x01D0)
+#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
+#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
+#define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)
+#define OMAP343X_CONTROL_CORE_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E4)
+#define OMAP343X_CONTROL_PER_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E8)
+#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING (OMAP2_CONTROL_GENERAL + 0x01EC)
+#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02B0)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02B4)
+#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8)
+#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
+#define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02b4)
+
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
diff --git a/arch/arm/plat-omap/include/mach/prcm.h b/arch/arm/plat-omap/include/mach/prcm.h
index 80dddcb..f5fe518 100644
--- a/arch/arm/plat-omap/include/mach/prcm.h
+++ b/arch/arm/plat-omap/include/mach/prcm.h
@@ -30,9 +30,57 @@ void cm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 cm_read_mod_reg(s16 module, u16 idx);
 u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
-#endif
-
-
-
+#ifdef CONFIG_ARCH_OMAP3
+/* Structure to save interrupt controller context */
+struct int_controller_context {
+	u32 sysconfig;
+	u32 protection;
+	u32 idle;
+	u32 threshold;
+	u32 ilr[96];
+	u32 mir_0;
+	u32 mir_1;
+	u32 mir_2;
+};
 
+/* Structure to save control module context */
+struct control_module_context {
+	u32 sysconfig;
+	u32 devconf0;
+	u32 mem_dftrw0;
+	u32 mem_dftrw1;
+	u32 msuspendmux_0;
+	u32 msuspendmux_1;
+	u32 msuspendmux_2;
+	u32 msuspendmux_3;
+	u32 msuspendmux_4;
+	u32 msuspendmux_5;
+	u32 sec_ctrl;
+	u32 devconf1;
+	u32 csirxfe;
+	u32 iva2_bootaddr;
+	u32 iva2_bootmod;
+	u32 debobs_0;
+	u32 debobs_1;
+	u32 debobs_2;
+	u32 debobs_3;
+	u32 debobs_4;
+	u32 debobs_5;
+	u32 debobs_6;
+	u32 debobs_7;
+	u32 debobs_8;
+	u32 prog_io0;
+	u32 prog_io1;
+	u32 dss_dpll_spreading;
+	u32 core_dpll_spreading;
+	u32 per_dpll_spreading;
+	u32 usbhost_dpll_spreading;
+	u32 pbias_lite;
+	u32 temp_sensor;
+	u32 sramldo4;
+	u32 sramldo5;
+	u32 csi;
+};
 
+#endif /* CONFIG_ARCH_OMAP3 */
+#endif /* __ASM_ARM_ARCH_OMAP_PRCM_H */
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 853048d..9cfb77f 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -26,6 +26,7 @@
 #include <mach/board.h>
 
 #include <mach/control.h>
+#include <mach/pm.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 # include "../mach-omap2/prm.h"
@@ -75,6 +76,8 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 					 unsigned long sram_size,
 					 unsigned long pstart_avail,
 					 unsigned long size_avail);
+extern void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clocks);
+extern void omap_push_sram_idle();
 
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -108,6 +111,7 @@ static int is_sram_locked(void)
 		return 1; /* assume locked with no PPA or security driver */
 }
 
+
 /*
  * The amount of SRAM depends on the core type.
  * Note that we cannot try to test for SRAM here because writes
@@ -368,13 +372,14 @@ u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
  }
 
 /* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
-void restore_sram_functions(void)
+void omap3_restore_sram_ctx(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	omap_push_sram_idle();
 }
 
 int __init omap3_sram_init(void)
@@ -382,6 +387,8 @@ int __init omap3_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+				omap34xx_cpu_suspend_sz);
 
 	return 0;
 }
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 39aca22..aa21e12 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1214,6 +1214,15 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		p->ier &= ~UART_IER_THRI;
 		serial_out(p, UART_IER, p->ier);
 	}
+#ifdef CONFIG_ARCH_OMAP3
+	{
+		unsigned int tmp;
+		/* Allow dynamic handshake to allow OCP bus idle. RX events
+		 * can do async wake */
+		tmp = (serial_in(p, UART_OMAP_SYSC) & 0x7) | (2 << 3);
+		serial_out(p, UART_OMAP_SYSC, tmp); /* smart-idle */
+	}
+#endif
 }
 
 static void serial8250_stop_tx(struct uart_port *port)
@@ -1261,6 +1270,17 @@ static void serial8250_start_tx(struct uart_port *port)
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+#ifdef CONFIG_ARCH_OMAP3
+	{
+		unsigned int tmp;
+		/* Disallow OCP bus idle. UART TX irqs are not seen during
+		 * bus idle. Alternative is to set kernel timer at fifo
+		 * drain rate.
+		 */
+		tmp = (serial_in(up, UART_OMAP_SYSC) & 0x7) | (1 << 3);
+		serial_out(up, UART_OMAP_SYSC, tmp); /* no-idle */
+	}
+#endif
 }
 
 static void serial8250_stop_rx(struct uart_port *port)
-- 
1.6.0

