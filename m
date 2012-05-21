From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/6] ARM: OMAP AM33xx: PRM: add PRM support
Date: Mon, 21 May 2012 12:41:59 -0600
Message-ID: <20120521184158.22565.51351.stgit@dusk>
References: <20120521184053.22565.90037.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37460 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771Ab2EUSpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 14:45:13 -0400
In-Reply-To: <20120521184053.22565.90037.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

As far as PRM/CM/PRCM modules are concerned, AM33XX device is
different than OMAP3 and OMAP4 architectures; so we need to handle it
separately.  This patch adds support for the PRM APIs required for
AM33XX device.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: separated the PRM parts of "ARM: OMAP3+: am33xx: Add
 powerdomain & PRM support" into this patch; fixed Makefile prm33xx.o
 location; cleaned up some checkpatch violations; updated for 3.5]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile           |    2 
 arch/arm/mach-omap2/prm-regbits-33xx.h |  357 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.c          |  134 ++++++++++++
 arch/arm/mach-omap2/prm33xx.h          |  129 ++++++++++++
 4 files changed, 621 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 464e14c..32aed2d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -91,7 +91,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
-obj-$(CONFIG_SOC_AM33XX)		+= prcm.o
+obj-$(CONFIG_SOC_AM33XX)		+= prcm.o prm33xx.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
new file mode 100644
index 0000000..0221b5c
--- /dev/null
+++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
@@ -0,0 +1,357 @@
+/*
+ * AM33XX PRM_XXX register bits
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+
+#include "prm.h"
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_ACT_EXPORT_SHIFT			1
+#define AM33XX_ABBOFF_ACT_EXPORT_MASK			(1 << 1)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_SLEEP_EXPORT_SHIFT		2
+#define AM33XX_ABBOFF_SLEEP_EXPORT_MASK			(1 << 2)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_AIPOFF_SHIFT				8
+#define AM33XX_AIPOFF_MASK				(1 << 8)
+
+/* Used by PM_WKUP_PWRSTST */
+#define AM33XX_DEBUGSS_MEM_STATEST_SHIFT		17
+#define AM33XX_DEBUGSS_MEM_STATEST_MASK			(0x3 << 17)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_DISABLE_RTA_EXPORT_SHIFT			0
+#define AM33XX_DISABLE_RTA_EXPORT_MASK			(1 << 0)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_CORE_RECAL_EN_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_EN_MASK			(1 << 12)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_CORE_RECAL_ST_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_ST_MASK			(1 << 12)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DDR_RECAL_EN_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_EN_MASK			(1 << 14)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DDR_RECAL_ST_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_ST_MASK			(1 << 14)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DISP_RECAL_EN_SHIFT			15
+#define AM33XX_DPLL_DISP_RECAL_EN_MASK			(1 << 15)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DISP_RECAL_ST_SHIFT			13
+#define AM33XX_DPLL_DISP_RECAL_ST_MASK			(1 << 13)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_MPU_RECAL_EN_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_EN_MASK			(1 << 11)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_MPU_RECAL_ST_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_ST_MASK			(1 << 11)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_PER_RECAL_EN_SHIFT			13
+#define AM33XX_DPLL_PER_RECAL_EN_MASK			(1 << 13)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_PER_RECAL_ST_SHIFT			15
+#define AM33XX_DPLL_PER_RECAL_ST_MASK			(1 << 15)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_EMULATION_M3_RST_SHIFT			6
+#define AM33XX_EMULATION_M3_RST_MASK			(1 << 6)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_EMULATION_MPU_RST_SHIFT			5
+#define AM33XX_EMULATION_MPU_RST_MASK			(1 << 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC1_EXPORT_SHIFT			3
+#define AM33XX_ENFUNC1_EXPORT_MASK			(1 << 3)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC3_EXPORT_SHIFT			5
+#define AM33XX_ENFUNC3_EXPORT_MASK			(1 << 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC4_SHIFT				6
+#define AM33XX_ENFUNC4_MASK				(1 << 6)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC5_SHIFT				7
+#define AM33XX_ENFUNC5_MASK				(1 << 7)
+
+/* Used by PRM_RSTST */
+#define AM33XX_EXTERNAL_WARM_RST_SHIFT			5
+#define AM33XX_EXTERNAL_WARM_RST_MASK			(1 << 5)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_FORCEWKUP_EN_SHIFT			10
+#define AM33XX_FORCEWKUP_EN_MASK			(1 << 10)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_FORCEWKUP_ST_SHIFT			10
+#define AM33XX_FORCEWKUP_ST_MASK			(1 << 10)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_ONSTATE_SHIFT			17
+#define AM33XX_GFX_MEM_ONSTATE_MASK			(0x3 << 17)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_RETSTATE_SHIFT			6
+#define AM33XX_GFX_MEM_RETSTATE_MASK			(1 << 6)
+
+/* Used by PM_GFX_PWRSTST */
+#define AM33XX_GFX_MEM_STATEST_SHIFT			4
+#define AM33XX_GFX_MEM_STATEST_MASK			(0x3 << 4)
+
+/* Used by RM_GFX_RSTCTRL, RM_GFX_RSTST */
+#define AM33XX_GFX_RST_SHIFT				0
+#define AM33XX_GFX_RST_MASK				(1 << 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_COLD_RST_SHIFT			0
+#define AM33XX_GLOBAL_COLD_RST_MASK			(1 << 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_WARM_SW_RST_SHIFT			1
+#define AM33XX_GLOBAL_WARM_SW_RST_MASK			(1 << 1)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_ICECRUSHER_M3_RST_SHIFT			7
+#define AM33XX_ICECRUSHER_M3_RST_MASK			(1 << 7)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_ICECRUSHER_MPU_RST_SHIFT			6
+#define AM33XX_ICECRUSHER_MPU_RST_MASK			(1 << 6)
+
+/* Used by PRM_RSTST */
+#define AM33XX_ICEPICK_RST_SHIFT			9
+#define AM33XX_ICEPICK_RST_MASK				(1 << 9)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_PRUSS_LRST_SHIFT				1
+#define AM33XX_PRUSS_LRST_MASK				(1 << 1)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PRUSS_MEM_ONSTATE_SHIFT			5
+#define AM33XX_PRUSS_MEM_ONSTATE_MASK			(0x3 << 5)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PRUSS_MEM_RETSTATE_SHIFT			7
+#define AM33XX_PRUSS_MEM_RETSTATE_MASK			(1 << 7)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_PRUSS_MEM_STATEST_SHIFT			23
+#define AM33XX_PRUSS_MEM_STATEST_MASK			(0x3 << 23)
+
+/*
+ * Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST,
+ * PM_WKUP_PWRSTST, PM_RTC_PWRSTST
+ */
+#define AM33XX_INTRANSITION_SHIFT			20
+#define AM33XX_INTRANSITION_MASK			(1 << 20)
+
+/* Used by PM_CEFUSE_PWRSTST */
+#define AM33XX_LASTPOWERSTATEENTERED_SHIFT		24
+#define AM33XX_LASTPOWERSTATEENTERED_MASK		(0x3 << 24)
+
+/* Used by PM_GFX_PWRSTCTRL, PM_MPU_PWRSTCTRL, PM_RTC_PWRSTCTRL */
+#define AM33XX_LOGICRETSTATE_SHIFT			2
+#define AM33XX_LOGICRETSTATE_MASK			(1 << 2)
+
+/* Renamed from LOGICRETSTATE Used by PM_PER_PWRSTCTRL, PM_WKUP_PWRSTCTRL */
+#define AM33XX_LOGICRETSTATE_3_3_SHIFT			3
+#define AM33XX_LOGICRETSTATE_3_3_MASK			(1 << 3)
+
+/*
+ * Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST,
+ * PM_WKUP_PWRSTST, PM_RTC_PWRSTST
+ */
+#define AM33XX_LOGICSTATEST_SHIFT			2
+#define AM33XX_LOGICSTATEST_MASK			(1 << 2)
+
+/*
+ * Used by PM_GFX_PWRSTCTRL, PM_CEFUSE_PWRSTCTRL, PM_PER_PWRSTCTRL,
+ * PM_MPU_PWRSTCTRL, PM_WKUP_PWRSTCTRL, PM_RTC_PWRSTCTRL
+ */
+#define AM33XX_LOWPOWERSTATECHANGE_SHIFT		4
+#define AM33XX_LOWPOWERSTATECHANGE_MASK			(1 << 4)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L1_ONSTATE_SHIFT			18
+#define AM33XX_MPU_L1_ONSTATE_MASK			(0x3 << 18)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L1_RETSTATE_SHIFT			22
+#define AM33XX_MPU_L1_RETSTATE_MASK			(1 << 22)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L1_STATEST_SHIFT			6
+#define AM33XX_MPU_L1_STATEST_MASK			(0x3 << 6)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_ONSTATE_SHIFT			20
+#define AM33XX_MPU_L2_ONSTATE_MASK			(0x3 << 20)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_RETSTATE_SHIFT			23
+#define AM33XX_MPU_L2_RETSTATE_MASK			(1 << 23)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L2_STATEST_SHIFT			8
+#define AM33XX_MPU_L2_STATEST_MASK			(0x3 << 8)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_ONSTATE_SHIFT			16
+#define AM33XX_MPU_RAM_ONSTATE_MASK			(0x3 << 16)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_RETSTATE_SHIFT			24
+#define AM33XX_MPU_RAM_RETSTATE_MASK			(1 << 24)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_RAM_STATEST_SHIFT			4
+#define AM33XX_MPU_RAM_STATEST_MASK			(0x3 << 4)
+
+/* Used by PRM_RSTST */
+#define AM33XX_MPU_SECURITY_VIOL_RST_SHIFT		2
+#define AM33XX_MPU_SECURITY_VIOL_RST_MASK		(1 << 2)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_PCHARGECNT_VALUE_SHIFT			0
+#define AM33XX_PCHARGECNT_VALUE_MASK			(0x3f << 0)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_PCI_LRST_SHIFT				0
+#define AM33XX_PCI_LRST_MASK				(1 << 0)
+
+/* Renamed from PCI_LRST Used by RM_PER_RSTST */
+#define AM33XX_PCI_LRST_5_5_SHIFT			5
+#define AM33XX_PCI_LRST_5_5_MASK			(1 << 5)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_ONSTATE_SHIFT			25
+#define AM33XX_PER_MEM_ONSTATE_MASK			(0x3 << 25)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_RETSTATE_SHIFT			29
+#define AM33XX_PER_MEM_RETSTATE_MASK			(1 << 29)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_PER_MEM_STATEST_SHIFT			17
+#define AM33XX_PER_MEM_STATEST_MASK			(0x3 << 17)
+
+/*
+ * Used by PM_GFX_PWRSTCTRL, PM_CEFUSE_PWRSTCTRL, PM_PER_PWRSTCTRL,
+ * PM_MPU_PWRSTCTRL
+ */
+#define AM33XX_POWERSTATE_SHIFT				0
+#define AM33XX_POWERSTATE_MASK				(0x3 << 0)
+
+/* Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST */
+#define AM33XX_POWERSTATEST_SHIFT			0
+#define AM33XX_POWERSTATEST_MASK			(0x3 << 0)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_ONSTATE_SHIFT			30
+#define AM33XX_RAM_MEM_ONSTATE_MASK			(0x3 << 30)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_RETSTATE_SHIFT			27
+#define AM33XX_RAM_MEM_RETSTATE_MASK			(1 << 27)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_RAM_MEM_STATEST_SHIFT			21
+#define AM33XX_RAM_MEM_STATEST_MASK			(0x3 << 21)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_RETMODE_ENABLE_SHIFT			0
+#define AM33XX_RETMODE_ENABLE_MASK			(1 << 0)
+
+/* Used by REVISION_PRM */
+#define AM33XX_REV_SHIFT				0
+#define AM33XX_REV_MASK					(0xff << 0)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME1_SHIFT				0
+#define AM33XX_RSTTIME1_MASK				(0xff << 0)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME2_SHIFT				8
+#define AM33XX_RSTTIME2_MASK				(0x1f << 8)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_COLD_SW_SHIFT			1
+#define AM33XX_RST_GLOBAL_COLD_SW_MASK			(1 << 1)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_WARM_SW_SHIFT			0
+#define AM33XX_RST_GLOBAL_WARM_SW_MASK			(1 << 0)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_SLPCNT_VALUE_SHIFT			16
+#define AM33XX_SLPCNT_VALUE_MASK			(0xff << 16)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAMLDO_STATUS_SHIFT			8
+#define AM33XX_SRAMLDO_STATUS_MASK			(1 << 8)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAM_IN_TRANSITION_SHIFT			9
+#define AM33XX_SRAM_IN_TRANSITION_MASK			(1 << 9)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_STARTUP_COUNT_SHIFT			24
+#define AM33XX_STARTUP_COUNT_MASK			(0xff << 24)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_TRANSITION_EN_SHIFT			8
+#define AM33XX_TRANSITION_EN_MASK			(1 << 8)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_TRANSITION_ST_SHIFT			8
+#define AM33XX_TRANSITION_ST_MASK			(1 << 8)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_VSETUPCNT_VALUE_SHIFT			8
+#define AM33XX_VSETUPCNT_VALUE_MASK			(0xff << 8)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT0_RST_SHIFT				3
+#define AM33XX_WDT0_RST_MASK				(1 << 3)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT1_RST_SHIFT				4
+#define AM33XX_WDT1_RST_MASK				(1 << 4)
+
+/* Used by RM_WKUP_RSTCTRL */
+#define AM33XX_WKUP_M3_LRST_SHIFT			3
+#define AM33XX_WKUP_M3_LRST_MASK			(1 << 3)
+
+/* Renamed from WKUP_M3_LRST Used by RM_WKUP_RSTST */
+#define AM33XX_WKUP_M3_LRST_5_5_SHIFT			5
+#define AM33XX_WKUP_M3_LRST_5_5_MASK			(1 << 5)
+
+#endif
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
new file mode 100644
index 0000000..7444855
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -0,0 +1,134 @@
+/*
+ * AM33XX PRM functions
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "common.h"
+#include "prm33xx.h"
+#include "prm-regbits-33xx.h"
+
+/* Read a register in a PRM instance */
+u32 am33xx_prm_read_reg(s16 inst, u16 idx)
+{
+	return __raw_readl(prm_base + inst + idx);
+}
+
+/* Write into a register in a PRM instance */
+void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
+{
+	__raw_writel(val, prm_base + inst + idx);
+}
+
+/* Read-modify-write a register in PRM. Caller must lock */
+u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(inst, idx);
+	v &= ~mask;
+	v |= bits;
+	am33xx_prm_write_reg(v, inst, idx);
+
+	return v;
+}
+
+/**
+ * am33xx_prm_is_hardreset_asserted - read the HW reset line state of
+ * submodules contained in the hwmod module
+ * @shift: register bit shift corresponding to the reset line to check
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_offs: RM_RSTCTRL register address offset for this module
+ *
+ * Returns 1 if the (sub)module hardreset line is currently asserted,
+ * 0 if the (sub)module hardreset line is not currently asserted, or
+ * -EINVAL upon parameter error.
+ */
+int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(inst, rstctrl_offs);
+	v &= 1 << shift;
+	v >>= shift;
+
+	return v;
+}
+
+/**
+ * am33xx_prm_assert_hardreset - assert the HW reset line of a submodule
+ * @shift: register bit shift corresponding to the reset line to assert
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * place the submodule into reset.  Returns 0 upon success or -EINVAL
+ * upon an argument error.
+ */
+int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs)
+{
+	u32 mask = 1 << shift;
+
+	am33xx_prm_rmw_reg_bits(mask, mask, inst, rstctrl_offs);
+
+	return 0;
+}
+
+/**
+ * am33xx_prm_deassert_hardreset - deassert a submodule hardreset line and
+ * wait
+ * @shift: register bit shift corresponding to the reset line to deassert
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @rstst_reg: RM_RSTST register address for this module
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * take the submodule out of reset and wait until the PRCM indicates
+ * that the reset has completed before returning.  Returns 0 upon success or
+ * -EINVAL upon an argument error, -EEXIST if the submodule was already out
+ * of reset, or -EBUSY if the submodule did not exit reset promptly.
+ */
+int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+		u16 rstctrl_offs, u16 rstst_offs)
+{
+	int c;
+	u32 mask = 1 << shift;
+
+	/* Check the current status to avoid  de-asserting the line twice */
+	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
+		return -EEXIST;
+
+	/* Clear the reset status by writing 1 to the status bit */
+	am33xx_prm_rmw_reg_bits(0xffffffff, mask, inst, rstst_offs);
+	/* de-assert the reset control line */
+	am33xx_prm_rmw_reg_bits(mask, 0, inst, rstctrl_offs);
+	/* wait the status to be set */
+
+	omap_test_timeout(am33xx_prm_is_hardreset_asserted(shift, inst,
+				rstst_offs), MAX_MODULE_HARDRESET_WAIT, c);
+
+	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
+}
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
new file mode 100644
index 0000000..3f25c56
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -0,0 +1,129 @@
+/*
+ * AM33XX PRM instance offset macros
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
+
+#include "prcm-common.h"
+#include "prm.h"
+
+#define AM33XX_PRM_BASE               0x44E00000
+
+#define AM33XX_PRM_REGADDR(inst, reg)                         \
+	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
+
+
+/* PRM instances */
+#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
+#define AM33XX_PRM_PER_MOD		0x0C00
+#define AM33XX_PRM_WKUP_MOD		0x0D00
+#define AM33XX_PRM_MPU_MOD		0x0E00
+#define AM33XX_PRM_DEVICE_MOD		0x0F00
+#define AM33XX_PRM_RTC_MOD		0x1000
+#define AM33XX_PRM_GFX_MOD		0x1100
+#define AM33XX_PRM_CEFUSE_MOD		0x1200
+
+/* PRM */
+
+/* PRM.OCP_SOCKET_PRM register offsets */
+#define AM33XX_REVISION_PRM_OFFSET		0x0000
+#define AM33XX_REVISION_PRM			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0000)
+#define AM33XX_PRM_IRQSTATUS_MPU_OFFSET		0x0004
+#define AM33XX_PRM_IRQSTATUS_MPU		AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0004)
+#define AM33XX_PRM_IRQENABLE_MPU_OFFSET		0x0008
+#define AM33XX_PRM_IRQENABLE_MPU		AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0008)
+#define AM33XX_PRM_IRQSTATUS_M3_OFFSET		0x000c
+#define AM33XX_PRM_IRQSTATUS_M3			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x000c)
+#define AM33XX_PRM_IRQENABLE_M3_OFFSET		0x0010
+#define AM33XX_PRM_IRQENABLE_M3			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0010)
+
+/* PRM.PER_PRM register offsets */
+#define AM33XX_RM_PER_RSTCTRL_OFFSET		0x0000
+#define AM33XX_RM_PER_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0000)
+#define AM33XX_RM_PER_RSTST_OFFSET		0x0004
+#define AM33XX_RM_PER_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0004)
+#define AM33XX_PM_PER_PWRSTST_OFFSET		0x0008
+#define AM33XX_PM_PER_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0008)
+#define AM33XX_PM_PER_PWRSTCTRL_OFFSET		0x000c
+#define AM33XX_PM_PER_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x000c)
+
+/* PRM.WKUP_PRM register offsets */
+#define AM33XX_RM_WKUP_RSTCTRL_OFFSET		0x0000
+#define AM33XX_RM_WKUP_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0000)
+#define AM33XX_PM_WKUP_PWRSTCTRL_OFFSET		0x0004
+#define AM33XX_PM_WKUP_PWRSTCTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0004)
+#define AM33XX_PM_WKUP_PWRSTST_OFFSET		0x0008
+#define AM33XX_PM_WKUP_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0008)
+#define AM33XX_RM_WKUP_RSTST_OFFSET		0x000c
+#define AM33XX_RM_WKUP_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x000c)
+
+/* PRM.MPU_PRM register offsets */
+#define AM33XX_PM_MPU_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_MPU_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0000)
+#define AM33XX_PM_MPU_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_MPU_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0004)
+#define AM33XX_RM_MPU_RSTST_OFFSET		0x0008
+#define AM33XX_RM_MPU_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0008)
+
+/* PRM.DEVICE_PRM register offsets */
+#define AM33XX_PRM_RSTCTRL_OFFSET		0x0000
+#define AM33XX_PRM_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0000)
+#define AM33XX_PRM_RSTTIME_OFFSET		0x0004
+#define AM33XX_PRM_RSTTIME			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0004)
+#define AM33XX_PRM_RSTST_OFFSET			0x0008
+#define AM33XX_PRM_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0008)
+#define AM33XX_PRM_SRAM_COUNT_OFFSET		0x000c
+#define AM33XX_PRM_SRAM_COUNT			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x000c)
+#define AM33XX_PRM_LDO_SRAM_CORE_SETUP_OFFSET	0x0010
+#define AM33XX_PRM_LDO_SRAM_CORE_SETUP		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0010)
+#define AM33XX_PRM_LDO_SRAM_CORE_CTRL_OFFSET	0x0014
+#define AM33XX_PRM_LDO_SRAM_CORE_CTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0014)
+#define AM33XX_PRM_LDO_SRAM_MPU_SETUP_OFFSET	0x0018
+#define AM33XX_PRM_LDO_SRAM_MPU_SETUP		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0018)
+#define AM33XX_PRM_LDO_SRAM_MPU_CTRL_OFFSET	0x001c
+#define AM33XX_PRM_LDO_SRAM_MPU_CTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x001c)
+
+/* PRM.RTC_PRM register offsets */
+#define AM33XX_PM_RTC_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_RTC_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_RTC_MOD, 0x0000)
+#define AM33XX_PM_RTC_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_RTC_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_RTC_MOD, 0x0004)
+
+/* PRM.GFX_PRM register offsets */
+#define AM33XX_PM_GFX_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_GFX_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0000)
+#define AM33XX_RM_GFX_RSTCTRL_OFFSET		0x0004
+#define AM33XX_RM_GFX_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0004)
+#define AM33XX_PM_GFX_PWRSTST_OFFSET		0x0010
+#define AM33XX_PM_GFX_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0010)
+#define AM33XX_RM_GFX_RSTST_OFFSET		0x0014
+#define AM33XX_RM_GFX_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0014)
+
+/* PRM.CEFUSE_PRM register offsets */
+#define AM33XX_PM_CEFUSE_PWRSTCTRL_OFFSET	0x0000
+#define AM33XX_PM_CEFUSE_PWRSTCTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0000)
+#define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
+
+extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
+extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
+extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+extern void am33xx_prm_global_warm_sw_reset(void);
+extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
+		u16 rstctrl_offs);
+extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
+extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+		u16 rstctrl_offs, u16 rstst_offs);
+#endif


