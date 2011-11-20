From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Sun, 20 Nov 2011 22:49:07 +0530
Message-ID: <1321809555-13833-4-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab1KTRTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 12:19:51 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Rachna Patil <rachna@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch adds AM33XX power domain data,
corresponding API's to access PRM module and
PRM register offsets & bit fields.

Signed-off-by: Rachna Patil <rachna@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h           |    4 +-
 arch/arm/mach-omap2/powerdomain33xx.c       |  155 ++++++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c |  115 +++++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h      |  357 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.h               |  123 +++++++++
 arch/arm/mach-omap2/prminst33xx.c           |   74 ++++++
 arch/arm/mach-omap2/prminst33xx.h           |   25 ++
 7 files changed, 852 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/prminst33xx.c
 create mode 100644 arch/arm/mach-omap2/prminst33xx.h

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..9efa823 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -69,7 +69,7 @@
  * Maximum number of clockdomains that can be associated with a powerdomain.
  * CORE powerdomain on OMAP4 is the worst case
  */
-#define PWRDM_MAX_CLKDMS	9
+#define PWRDM_MAX_CLKDMS	11

 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
@@ -223,10 +223,12 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
+extern void am33xx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);

 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
+extern struct pwrdm_ops am33xx_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;

 /* Common Internal functions used across OMAP rev's */
diff --git a/arch/arm/mach-omap2/powerdomain33xx.c b/arch/arm/mach-omap2/powerdomain33xx.c
new file mode 100644
index 0000000..80bfd42
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain33xx.c
@@ -0,0 +1,155 @@
+/*
+ * AM33XX Powerdomain control
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <plat/prcm.h>
+
+#include "powerdomain.h"
+#include "prm33xx.h"
+#include "prm-regbits-33xx.h"
+#include "prminst33xx.h"
+
+
+static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	am33xx_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
+					(pwrst << OMAP_POWERSTATE_SHIFT),
+					pwrdm->prcm_offs, AM33XX_PM_PWSTCTRL);
+	return 0;
+}
+
+static int am33xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTCTRL);
+	v &= OMAP_POWERSTATE_MASK;
+	v >>= OMAP_POWERSTATE_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTST);
+	v &= OMAP_POWERSTATEST_MASK;
+	v >>= OMAP_POWERSTATEST_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTST);
+	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
+	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
+{
+	am33xx_prminst_rmw_inst_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
+			(1 << AM33XX_LOWPOWERSTATECHANGE_SHIFT),
+			pwrdm->prcm_offs, AM33XX_PM_PWSTCTRL);
+	return 0;
+}
+
+static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	am33xx_prminst_rmw_inst_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
+			AM33XX_LASTPOWERSTATEENTERED_MASK,
+			pwrdm->prcm_offs, AM33XX_PM_PWSTST);
+	return 0;
+}
+
+static int am33xx_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u32 v;
+
+	v = pwrst << __ffs(AM33XX_LOGICRETSTATE_MASK);
+	am33xx_prminst_rmw_inst_reg_bits(AM33XX_LOGICRETSTATE_MASK, v,
+			pwrdm->prcm_offs, AM33XX_PM_PWSTCTRL);
+
+	return 0;
+}
+
+static int am33xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTST);
+	v &= AM33XX_LOGICSTATEST_MASK;
+	v >>= AM33XX_LOGICSTATEST_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTCTRL);
+	v &= AM33XX_LOGICRETSTATE_MASK;
+	v >>= AM33XX_LOGICRETSTATE_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	u32 c = 0;
+
+	/*
+	 * REVISIT: pwrdm_wait_transition() may be better implemented
+	 * via a callback and a periodic timer check -- how long do we expect
+	 * powerdomain transitions to take?
+	 */
+
+	/* XXX Is this udelay() value meaningful? */
+	while ((am33xx_prminst_read_inst_reg(pwrdm->prcm_offs, AM33XX_PM_PWSTST)
+		& OMAP_INTRANSITION_MASK) && (c++ < PWRDM_TRANSITION_BAILOUT))
+		udelay(1);
+
+	if (c > PWRDM_TRANSITION_BAILOUT) {
+		printk(KERN_ERR "powerdomain: waited too long for "
+			"powerdomain %s to complete transition\n", pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+
+struct pwrdm_ops am33xx_pwrdm_operations = {
+	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
+	.pwrdm_clear_all_prev_pwrst	= am33xx_pwrdm_clear_all_prev_pwrst,
+	.pwrdm_set_lowpwrstchange	= am33xx_pwrdm_set_lowpwrstchange,
+	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
+};
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
new file mode 100644
index 0000000..e69e62a
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -0,0 +1,115 @@
+/*
+ * AM33Xx Power domains framework
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+#include <linux/init.h>
+
+#include "powerdomain.h"
+#include "prcm-common.h"
+#include "prm33xx.h"
+
+static struct powerdomain gfx_33xx_pwrdm = {
+	.name			= "gfx_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_GFX_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] 	= PWRSTS_OFF_RET,		/* gfx_mem */
+	},
+	.pwrsts_mem_on		= {
+		[0]	= PWRSTS_ON,		/* gfx_mem */
+	},
+};
+
+static struct powerdomain rtc_33xx_pwrdm = {
+	.name			= "rtc_pwrdm",
+	.voltdm			= { .name = "rtc" },
+	.prcm_offs		= AM33XX_PRM_RTC_MOD,
+	.pwrsts			= PWRSTS_ON,
+};
+
+static struct powerdomain wkup_33xx_pwrdm = {
+	.name			= "wkup_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_WKUP_MOD,
+	.pwrsts			= PWRSTS_ON,
+};
+
+static struct powerdomain per_33xx_pwrdm = {
+	.name			= "per_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_PER_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 3,
+	.pwrsts_mem_ret		= {
+		[0]	= PWRSTS_OFF_RET,	/* icss_mem */
+		[1]	= PWRSTS_OFF_RET,	/* per_mem */
+		[2]	= PWRSTS_OFF_RET,	/* ram_mem */
+	},
+	.pwrsts_mem_on		= {
+		[0]	= PWRSTS_ON,		/* icss_mem */
+		[1]	= PWRSTS_ON,		/* per_mem */
+		[2]	= PWRSTS_ON,		/* ram_mem */
+	},
+};
+
+static struct powerdomain mpu_33xx_pwrdm = {
+	.name			= "mpu_pwrdm",
+	.voltdm			= { .name = "mpu" },
+	.prcm_offs		= AM33XX_PRM_MPU_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 3,
+	.pwrsts_mem_ret		= {
+		[0]	= PWRSTS_OFF_RET,	/* mpu_l1 */
+		[1]	= PWRSTS_OFF_RET,	/* mpu_l2 */
+		[2]	= PWRSTS_OFF_RET,	/* mpu_ram */
+	},
+	.pwrsts_mem_on		= {
+		[0]	= PWRSTS_ON,		/* mpu_l1 */
+		[1]	= PWRSTS_ON,		/* mpu_l2 */
+		[2]	= PWRSTS_ON,		/* mpu_ram */
+	},
+};
+
+static struct powerdomain cefuse_33xx_pwrdm = {
+	.name		= "cefuse_pwrdm",
+	.voltdm		= { .name = "core" },
+	.prcm_offs	= AM33XX_PRM_CEFUSE_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain *powerdomains_am33xx[] __initdata = {
+	&gfx_33xx_pwrdm,
+	&rtc_33xx_pwrdm,
+	&wkup_33xx_pwrdm,
+	&per_33xx_pwrdm,
+	&mpu_33xx_pwrdm,
+	&cefuse_33xx_pwrdm,
+	NULL,
+};
+
+void __init am33xx_powerdomains_init(void)
+{
+	pwrdm_register_platform_funcs(&am33xx_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_am33xx);
+	pwrdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
new file mode 100644
index 0000000..5299287
--- /dev/null
+++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
@@ -0,0 +1,357 @@
+/*
+ * AM33XX Power Management register bits
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+
+#include "prm.h"
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_ACT_EXPORT_SHIFT			1
+#define AM33XX_ABBOFF_ACT_EXPORT_MASK			BITFIELD(1, 1)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_SLEEP_EXPORT_SHIFT		2
+#define AM33XX_ABBOFF_SLEEP_EXPORT_MASK			BITFIELD(2, 2)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_AIPOFF_SHIFT				8
+#define AM33XX_AIPOFF_MASK				BITFIELD(8, 8)
+
+/* Used by PM_WKUP_PWRSTST */
+#define AM33XX_DEBUGSS_MEM_STATEST_SHIFT		17
+#define AM33XX_DEBUGSS_MEM_STATEST_MASK			BITFIELD(17, 18)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_DISABLE_RTA_EXPORT_SHIFT			0
+#define AM33XX_DISABLE_RTA_EXPORT_MASK			BITFIELD(0, 0)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_CORE_RECAL_EN_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_EN_MASK			BITFIELD(12, 12)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_CORE_RECAL_ST_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_ST_MASK			BITFIELD(12, 12)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DDR_RECAL_EN_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_EN_MASK			BITFIELD(14, 14)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DDR_RECAL_ST_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_ST_MASK			BITFIELD(14, 14)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DISP_RECAL_EN_SHIFT			15
+#define AM33XX_DPLL_DISP_RECAL_EN_MASK			BITFIELD(15, 15)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DISP_RECAL_ST_SHIFT			13
+#define AM33XX_DPLL_DISP_RECAL_ST_MASK			BITFIELD(13, 13)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_MPU_RECAL_EN_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_EN_MASK			BITFIELD(11, 11)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_MPU_RECAL_ST_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_ST_MASK			BITFIELD(11, 11)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_PER_RECAL_EN_SHIFT			13
+#define AM33XX_DPLL_PER_RECAL_EN_MASK			BITFIELD(13, 13)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_PER_RECAL_ST_SHIFT			15
+#define AM33XX_DPLL_PER_RECAL_ST_MASK			BITFIELD(15, 15)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_EMULATION_M3_RST_SHIFT			6
+#define AM33XX_EMULATION_M3_RST_MASK			BITFIELD(6, 6)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_EMULATION_MPU_RST_SHIFT			5
+#define AM33XX_EMULATION_MPU_RST_MASK			BITFIELD(5, 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC1_EXPORT_SHIFT			3
+#define AM33XX_ENFUNC1_EXPORT_MASK			BITFIELD(3, 3)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC3_EXPORT_SHIFT			5
+#define AM33XX_ENFUNC3_EXPORT_MASK			BITFIELD(5, 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC4_SHIFT				6
+#define AM33XX_ENFUNC4_MASK				BITFIELD(6, 6)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC5_SHIFT				7
+#define AM33XX_ENFUNC5_MASK				BITFIELD(7, 7)
+
+/* Used by PRM_RSTST */
+#define AM33XX_EXTERNAL_WARM_RST_SHIFT			5
+#define AM33XX_EXTERNAL_WARM_RST_MASK			BITFIELD(5, 5)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_FORCEWKUP_EN_SHIFT			10
+#define AM33XX_FORCEWKUP_EN_MASK			BITFIELD(10, 10)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_FORCEWKUP_ST_SHIFT			10
+#define AM33XX_FORCEWKUP_ST_MASK			BITFIELD(10, 10)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_ONSTATE_SHIFT			17
+#define AM33XX_GFX_MEM_ONSTATE_MASK			BITFIELD(17, 18)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_RETSTATE_SHIFT			6
+#define AM33XX_GFX_MEM_RETSTATE_MASK			BITFIELD(6, 6)
+
+/* Used by PM_GFX_PWRSTST */
+#define AM33XX_GFX_MEM_STATEST_SHIFT			4
+#define AM33XX_GFX_MEM_STATEST_MASK			BITFIELD(4, 5)
+
+/* Used by RM_GFX_RSTCTRL, RM_GFX_RSTST */
+#define AM33XX_GFX_RST_SHIFT				0
+#define AM33XX_GFX_RST_MASK				(1 << 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_COLD_RST_SHIFT			0
+#define AM33XX_GLOBAL_COLD_RST_MASK			BITFIELD(0, 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_WARM_SW_RST_SHIFT			1
+#define AM33XX_GLOBAL_WARM_SW_RST_MASK			BITFIELD(1, 1)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_ICECRUSHER_M3_RST_SHIFT			7
+#define AM33XX_ICECRUSHER_M3_RST_MASK			BITFIELD(7, 7)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_ICECRUSHER_MPU_RST_SHIFT			6
+#define AM33XX_ICECRUSHER_MPU_RST_MASK			BITFIELD(6, 6)
+
+/* Used by PRM_RSTST */
+#define AM33XX_ICEPICK_RST_SHIFT			9
+#define AM33XX_ICEPICK_RST_MASK				BITFIELD(9, 9)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_ICSS_LRST_SHIFT				1
+#define AM33XX_ICSS_LRST_MASK				BITFIELD(1, 1)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_ICSS_MEM_ONSTATE_SHIFT			5
+#define AM33XX_ICSS_MEM_ONSTATE_MASK			BITFIELD(5, 6)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_ICSS_MEM_RETSTATE_SHIFT			7
+#define AM33XX_ICSS_MEM_RETSTATE_MASK			BITFIELD(7, 7)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_ICSS_MEM_STATEST_SHIFT			23
+#define AM33XX_ICSS_MEM_STATEST_MASK			BITFIELD(23, 24)
+
+/*
+ * Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST,
+ * PM_WKUP_PWRSTST, PM_RTC_PWRSTST
+ */
+#define AM33XX_INTRANSITION_SHIFT			20
+#define AM33XX_INTRANSITION_MASK			BITFIELD(20, 20)
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
+#define AM33XX_LOGICRETSTATE_3_3_MASK			BITFIELD(3, 3)
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
+#define AM33XX_MPU_L1_ONSTATE_MASK			BITFIELD(18, 19)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L1_RETSTATE_SHIFT			22
+#define AM33XX_MPU_L1_RETSTATE_MASK			BITFIELD(22, 22)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L1_STATEST_SHIFT			6
+#define AM33XX_MPU_L1_STATEST_MASK			BITFIELD(6, 7)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_ONSTATE_SHIFT			20
+#define AM33XX_MPU_L2_ONSTATE_MASK			BITFIELD(20, 21)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_RETSTATE_SHIFT			23
+#define AM33XX_MPU_L2_RETSTATE_MASK			BITFIELD(23, 23)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L2_STATEST_SHIFT			8
+#define AM33XX_MPU_L2_STATEST_MASK			BITFIELD(8, 9)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_ONSTATE_SHIFT			16
+#define AM33XX_MPU_RAM_ONSTATE_MASK			BITFIELD(16, 17)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_RETSTATE_SHIFT			24
+#define AM33XX_MPU_RAM_RETSTATE_MASK			BITFIELD(24, 24)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_RAM_STATEST_SHIFT			4
+#define AM33XX_MPU_RAM_STATEST_MASK			BITFIELD(4, 5)
+
+/* Used by PRM_RSTST */
+#define AM33XX_MPU_SECURITY_VIOL_RST_SHIFT		2
+#define AM33XX_MPU_SECURITY_VIOL_RST_MASK		BITFIELD(2, 2)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_PCHARGECNT_VALUE_SHIFT			0
+#define AM33XX_PCHARGECNT_VALUE_MASK			BITFIELD(0, 5)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_PCI_LRST_SHIFT				0
+#define AM33XX_PCI_LRST_MASK				BITFIELD(0, 0)
+
+/* Renamed from PCI_LRST Used by RM_PER_RSTST */
+#define AM33XX_PCI_LRST_5_5_SHIFT			5
+#define AM33XX_PCI_LRST_5_5_MASK			BITFIELD(5, 5)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_ONSTATE_SHIFT			25
+#define AM33XX_PER_MEM_ONSTATE_MASK			BITFIELD(25, 26)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_RETSTATE_SHIFT			29
+#define AM33XX_PER_MEM_RETSTATE_MASK			BITFIELD(29, 29)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_PER_MEM_STATEST_SHIFT			17
+#define AM33XX_PER_MEM_STATEST_MASK			BITFIELD(17, 18)
+
+/*
+ * Used by PM_GFX_PWRSTCTRL, PM_CEFUSE_PWRSTCTRL, PM_PER_PWRSTCTRL,
+ * PM_MPU_PWRSTCTRL
+ */
+#define AM33XX_POWERSTATE_SHIFT				0
+#define AM33XX_POWERSTATE_MASK				BITFIELD(0, 1)
+
+/* Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST */
+#define AM33XX_POWERSTATEST_SHIFT			0
+#define AM33XX_POWERSTATEST_MASK			BITFIELD(0, 1)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_ONSTATE_SHIFT			30
+#define AM33XX_RAM_MEM_ONSTATE_MASK			BITFIELD(30, 31)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_RETSTATE_SHIFT			27
+#define AM33XX_RAM_MEM_RETSTATE_MASK			BITFIELD(27, 27)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_RAM_MEM_STATEST_SHIFT			21
+#define AM33XX_RAM_MEM_STATEST_MASK			BITFIELD(21, 22)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_RETMODE_ENABLE_SHIFT			0
+#define AM33XX_RETMODE_ENABLE_MASK			BITFIELD(0, 0)
+
+/* Used by REVISION_PRM */
+#define AM33XX_REV_SHIFT				0
+#define AM33XX_REV_MASK					BITFIELD(0, 7)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME1_SHIFT				0
+#define AM33XX_RSTTIME1_MASK				BITFIELD(0, 7)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME2_SHIFT				8
+#define AM33XX_RSTTIME2_MASK				BITFIELD(8, 12)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_COLD_SW_SHIFT			1
+#define AM33XX_RST_GLOBAL_COLD_SW_MASK			BITFIELD(1, 1)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_WARM_SW_SHIFT			0
+#define AM33XX_RST_GLOBAL_WARM_SW_MASK			BITFIELD(0, 0)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_SLPCNT_VALUE_SHIFT			16
+#define AM33XX_SLPCNT_VALUE_MASK			BITFIELD(16, 23)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAMLDO_STATUS_SHIFT			8
+#define AM33XX_SRAMLDO_STATUS_MASK			BITFIELD(8, 8)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAM_IN_TRANSITION_SHIFT			9
+#define AM33XX_SRAM_IN_TRANSITION_MASK			BITFIELD(9, 9)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_STARTUP_COUNT_SHIFT			24
+#define AM33XX_STARTUP_COUNT_MASK			BITFIELD(24, 31)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_TRANSITION_EN_SHIFT			8
+#define AM33XX_TRANSITION_EN_MASK			BITFIELD(8, 8)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_TRANSITION_ST_SHIFT			8
+#define AM33XX_TRANSITION_ST_MASK			BITFIELD(8, 8)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_VSETUPCNT_VALUE_SHIFT			8
+#define AM33XX_VSETUPCNT_VALUE_MASK			BITFIELD(8, 15)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT0_RST_SHIFT				3
+#define AM33XX_WDT0_RST_MASK				BITFIELD(3, 3)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT1_RST_SHIFT				4
+#define AM33XX_WDT1_RST_MASK				BITFIELD(4, 4)
+
+/* Used by RM_WKUP_RSTCTRL */
+#define AM33XX_WKUP_M3_LRST_SHIFT			3
+#define AM33XX_WKUP_M3_LRST_MASK			BITFIELD(3, 3)
+
+/* Renamed from WKUP_M3_LRST Used by RM_WKUP_RSTST */
+#define AM33XX_WKUP_M3_LRST_5_5_SHIFT			5
+#define AM33XX_WKUP_M3_LRST_5_5_MASK			BITFIELD(5, 5)
+#endif
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
new file mode 100644
index 0000000..0fd5c6e
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -0,0 +1,123 @@
+/*
+ * AM33XX PRM instance offset macros
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+/* Register offsets (used from OMAP4) */
+#define AM33XX_PM_PWSTCTRL		0x0000
+#define AM33XX_PM_PWSTST		0x0004
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
+#endif
diff --git a/arch/arm/mach-omap2/prminst33xx.c b/arch/arm/mach-omap2/prminst33xx.c
new file mode 100644
index 0000000..88382ba
--- /dev/null
+++ b/arch/arm/mach-omap2/prminst33xx.c
@@ -0,0 +1,74 @@
+/*
+ * AM33XX PRM instance functions
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+#include "prm33xx.h"
+#include "prminst33xx.h"
+#include "prm-regbits-33xx.h"
+
+#define AM33XX_PRM_MOD_SIZE	0x100
+#define AM33XX_PRM_MOD_START	AM33XX_PRM_PER_MOD
+#define PRM_REG_SZ		0x4
+
+/*
+ * PRM Offsets are screwed up, and they are not consistent across modules.
+ * Below are the offsets for PWRSTCTRL and PWRSTST for respective modules.
+ */
+static u16 off_fixup[][2] = {
+	{ 0xC, 0x8 },	/* AM33XX_PRM_PER_MOD */
+	{ 0x4, 0x8 },	/* AM33XX_PRM_WKUP_MOD */
+	{ 0x0, 0x4 },	/* AM33XX_PRM_MPU_MOD */
+	/* XXX: PRM_DEVICE: offsets are invalid for powerdomain*/
+	{ 0x0, 0x0 },	/* AM33XX_PRM_DEVICE_MOD */
+	{ 0x0, 0x4 },	/* AM33XX_PRM_RTC_MOD */
+	{ 0x0, 0x10 },	/* AM33XX_PRM_GFX_MOD */
+	{ 0x0, 0x4 },	/* AM33XX_PRM_CEFUSE_MOD */
+};
+
+/* Read a register in a PRM instance */
+u32 am33xx_prminst_read_inst_reg(s16 inst, u16 idx)
+{
+	int i = (inst - AM33XX_PRM_MOD_START) / AM33XX_PRM_MOD_SIZE;
+
+	return __raw_readl(prm_base + inst + off_fixup[i][idx / PRM_REG_SZ]);
+}
+
+/* Write into a register in a PRM instance */
+void am33xx_prminst_write_inst_reg(u32 val, s16 inst, u16 idx)
+{
+	int i = (inst - AM33XX_PRM_MOD_START) / AM33XX_PRM_MOD_SIZE;
+
+	__raw_writel(val, prm_base + inst + off_fixup[i][idx / PRM_REG_SZ]);
+}
+
+/* Read-modify-write a register in PRM. Caller must lock */
+u32 am33xx_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
+{
+	u32 v;
+
+	v = am33xx_prminst_read_inst_reg(inst, idx);
+	v &= ~mask;
+	v |= bits;
+	am33xx_prminst_write_inst_reg(v, inst, idx);
+
+	return v;
+}
diff --git a/arch/arm/mach-omap2/prminst33xx.h b/arch/arm/mach-omap2/prminst33xx.h
new file mode 100644
index 0000000..0f167c0
--- /dev/null
+++ b/arch/arm/mach-omap2/prminst33xx.h
@@ -0,0 +1,25 @@
+/*
+ * AM33XX Power/Reset Management (PRM) function prototypes
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+#ifndef __ARCH_ASM_MACH_OMAP2_PRMINST33XX_H
+#define __ARCH_ASM_MACH_OMAP2_PRMINST33XX_H
+
+extern u32 am33xx_prminst_read_inst_reg(s16 inst, u16 idx);
+extern void am33xx_prminst_write_inst_reg(u32 val, s16 inst, u16 idx);
+extern u32 am33xx_prminst_rmw_inst_reg_bits(u32 mask, u32 bits,
+					   s16 inst, s16 idx);
+extern void am33xx_prm_global_warm_sw_reset(void);
+
+#endif
--
1.7.0.4

