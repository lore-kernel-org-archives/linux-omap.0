From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Sun, 25 Dec 2011 14:30:28 +0530
Message-ID: <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1LYJAr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Dec 2011 04:00:47 -0500
In-Reply-To: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>

This patch adds AM33XX power domain data (powerdomains33xx_data.c)
and header file with respective PRM register offsets.
PRM module in AM33XX family of device is close to that of OMAP4 PRM
with respect to register bit-fields and offsets, so reusing all
existing OMAP4 API's to access AM33XX PRM module.

Also, hook up the AM33XX power domain to OMAP framework.

This patch is based on OMAP4 cleanup patch of hardcoded reg-offs for
PWRSTCTRL & PWRSTST.
Patch -
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60468.html

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    3 +
 arch/arm/mach-omap2/io.c                    |    1 +
 arch/arm/mach-omap2/omap_hwmod.c            |    1 +
 arch/arm/mach-omap2/powerdomain.h           |    5 +-
 arch/arm/mach-omap2/powerdomains33xx_data.c |  134 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.h               |  118 +++++++++++++++++++++++
 6 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8d90f9f..d30c50c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -114,6 +114,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
 					   powerdomain2xxx_3xxx.o \
 					   powerdomains3xxx_data.o \
 					   powerdomains2xxx_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= prminst44xx.o \
+					   powerdomain44xx.o \
+					   powerdomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d50cbd7..5f96aa5 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -473,6 +473,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
+	am33xx_powerdomains_init();
 	omap3xxx_clk_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4fd53d4..34dc29b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -150,6 +150,7 @@
 #include "cminst44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "mux.h"

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 9ebb872..284eb22 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -67,9 +67,9 @@

 /*
  * Maximum number of clockdomains that can be associated with a powerdomain.
- * CORE powerdomain on OMAP4 is the worst case
+ * CORE powerdomain on AM33XX is the worst case
  */
-#define PWRDM_MAX_CLKDMS	9
+#define PWRDM_MAX_CLKDMS	11

 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
@@ -227,6 +227,7 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
+extern void am33xx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);

 extern struct pwrdm_ops omap2_pwrdm_operations;
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
new file mode 100644
index 0000000..a8b06d1
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -0,0 +1,134 @@
+/*
+ * AM33XX Power domains framework
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
+#include "prcm44xx.h"
+
+static struct powerdomain gfx_33xx_pwrdm = {
+	.name			= "gfx_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_GFX_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.pwrstctrl_offs		= AM33XX_PM_GFX_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_GFX_PWRSTST_OFFSET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0]	= PWRSTS_OFF_RET,	/* gfx_mem */
+	},
+	.pwrsts_mem_on		= {
+		[0]	= PWRSTS_ON,		/* gfx_mem */
+	},
+};
+
+static struct powerdomain rtc_33xx_pwrdm = {
+	.name			= "rtc_pwrdm",
+	.voltdm			= { .name = "rtc" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_RTC_MOD,
+	.pwrsts			= PWRSTS_ON,
+	.pwrstctrl_offs		= AM33XX_PM_RTC_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_RTC_PWRSTST_OFFSET,
+};
+
+static struct powerdomain wkup_33xx_pwrdm = {
+	.name			= "wkup_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_WKUP_MOD,
+	.pwrsts			= PWRSTS_ON,
+	.pwrstctrl_offs		= AM33XX_PM_WKUP_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_WKUP_PWRSTST_OFFSET,
+};
+
+static struct powerdomain per_33xx_pwrdm = {
+	.name			= "per_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_PER_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.pwrstctrl_offs		= AM33XX_PM_PER_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_PER_PWRSTST_OFFSET,
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
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_MPU_MOD,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.pwrstctrl_offs		= AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
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
+	.name			= "cefuse_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
+	.prcm_offs		= AM33XX_PRM_CEFUSE_MOD,
+	.pwrsts			= PWRSTS_OFF_ON,
+	.pwrstctrl_offs		= AM33XX_PM_CEFUSE_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_CEFUSE_PWRSTST_OFFSET,
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
+	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_am33xx);
+	pwrdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
new file mode 100644
index 0000000..aa1e8c7
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -0,0 +1,118 @@
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
+#endif
--
1.7.0.4

