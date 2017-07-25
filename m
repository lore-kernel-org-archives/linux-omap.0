From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 3/4] ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
Date: Tue, 25 Jul 2017 09:44:13 -0500
Message-ID: <20170725144414.7129-4-d-gerlach@ti.com>
References: <20170725144414.7129-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725144414.7129-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Most of the PM code needed for am335x and am437x can be moved into a
module under drivers but some core code must remain in mach-omap2 at the
moment. This includes some internal clockdomain APIs and low-level ARM
APIs which are also not exported for use by modules.

Implement a few functions that handle these low-level platform
operations can be passed to the pm33xx module through the use of
platform data.

In addition to this, to be able to share data structures between C and
the sleep33xx and sleep43xx assembly code, we can automatically generate
all of the C struct member offsets and sizes as macros by making use of
the ARM asm-offsets file. In the same header that we define our data
structures in we also define all the macros in an inline function and by
adding a call to this in the asm_offsets file all macros are properly
generated and available to the assembly code without cluttering up the
asm-offsets file.

Finally, add amx3_common_pm_init to create a dummy platform_device for
pm33xx so that our soon to be introduced pm33xx module can probe on
am335x and am437x platforms to enable basic suspend to mem and standby
support.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v2->v3:
* Squash in patch 5 from v2, which is uses static code from this patch
  add does not need to be a separate patch.
* Make am33xx_pm_get_pdata static
* (Previously patch 5) Properly zero devinfo and set .id to -1 in
  amx3_common_pm_init
* Avoid extern definition for asm-offsets definition and use a stub instead
  of defining out in asm-offsets.

 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm/mach-omap2/Kconfig          |   1 +
 arch/arm/mach-omap2/Makefile         |   4 +
 arch/arm/mach-omap2/common.h         |   7 ++
 arch/arm/mach-omap2/io.c             |   2 +
 arch/arm/mach-omap2/pm.h             |   3 +
 arch/arm/mach-omap2/pm33xx-core.c    | 197 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/pm33xx.h |  74 +++++++++++++
 8 files changed, 290 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 include/linux/platform_data/pm33xx.h

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 46a7a6c41db7..1c79f663b06c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -28,6 +28,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
+#include <linux/platform_data/pm33xx.h>
 #include <linux/ti-emif-sram.h>
 
 /*
@@ -186,6 +187,7 @@ int main(void)
 #endif
   BLANK();
   ti_emif_offsets();
+  amx3_pm_asm_offsets();
 
   return 0; 
 }
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0465338183c7..940173fa0992 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -72,6 +72,7 @@ config SOC_AM43XX
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select OMAP_INTERCONNECT
+	select ARM_CPU_SUSPEND if PM
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 779fb1f680b3..8fd4f5947902 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -87,6 +87,8 @@ omap-4-5-pm-common			+= pm44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_SOC_AM33XX)		+= pm33xx-core.o sleep33xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= pm33xx-core.o sleep43xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -94,6 +96,8 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep43xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 endif
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 8cc6338fcb12..89bd0f47ceb3 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -77,6 +77,13 @@ static inline int omap4_pm_init_early(void)
 }
 #endif
 
+#if defined(CONFIG_PM) && (defined(CONFIG_SOC_AM33XX) || \
+	defined(CONFIG_SOC_AM43XX))
+void amx3_common_pm_init(void);
+#else
+static inline void amx3_common_pm_init(void) { }
+#endif
+
 extern void omap2_init_common_infrastructure(void);
 
 extern void omap_init_time(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1d739d1a0a65..566681ed478f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -623,6 +623,7 @@ void __init am33xx_init_early(void)
 void __init am33xx_init_late(void)
 {
 	omap_common_late_init();
+	amx3_common_pm_init();
 }
 #endif
 
@@ -647,6 +648,7 @@ void __init am43xx_init_late(void)
 {
 	omap_common_late_init();
 	omap2_clk_enable_autoidle_all();
+	amx3_common_pm_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b668719b9b25..35bed9ff2b80 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,6 +81,9 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
+extern struct am33xx_pm_sram_addr am33xx_pm_sram;
+extern struct am33xx_pm_sram_addr am43xx_pm_sram;
+
 /* save_secure_ram_context function pointer and size, for copy to SRAM */
 extern int save_secure_ram_context(u32 *addr);
 extern unsigned int save_secure_ram_context_sz;
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
new file mode 100644
index 000000000000..d45f992d72ac
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -0,0 +1,197 @@
+/*
+ * AM33XX Arch Power Management Routines
+ *
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ *	Dave Gerlach
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
+#include <asm/smp_scu.h>
+#include <asm/suspend.h>
+#include <linux/errno.h>
+#include <linux/platform_data/pm33xx.h>
+
+#include "cm33xx.h"
+#include "common.h"
+#include "control.h"
+#include "clockdomain.h"
+#include "iomap.h"
+#include "omap_hwmod.h"
+#include "pm.h"
+#include "powerdomain.h"
+#include "prm33xx.h"
+#include "soc.h"
+#include "sram.h"
+
+static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
+static struct clockdomain *gfx_l4ls_clkdm;
+static void __iomem *scu_base;
+
+static int __init am43xx_map_scu(void)
+{
+	scu_base = ioremap(scu_a9_get_base(), SZ_256);
+
+	if (!scu_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int amx3_common_init(void)
+{
+	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+
+	if ((!gfx_pwrdm) || (!per_pwrdm) || (!mpu_pwrdm))
+		return -ENODEV;
+
+	(void)clkdm_for_each(omap_pm_clkdms_setup, NULL);
+
+	/* CEFUSE domain can be turned off post bootup */
+	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
+	if (cefuse_pwrdm)
+		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
+	else
+		pr_err("PM: Failed to get cefuse_pwrdm\n");
+
+	return 0;
+}
+
+static int am33xx_suspend_init(void)
+{
+	int ret;
+
+	gfx_l4ls_clkdm = clkdm_lookup("gfx_l4ls_gfx_clkdm");
+
+	if (!gfx_l4ls_clkdm) {
+		pr_err("PM: Cannot lookup gfx_l4ls_clkdm clockdomains\n");
+		return -ENODEV;
+	}
+
+	ret = amx3_common_init();
+
+	return ret;
+}
+
+static int am43xx_suspend_init(void)
+{
+	int ret = 0;
+
+	ret = am43xx_map_scu();
+	if (ret) {
+		pr_err("PM: Could not ioremap SCU\n");
+		return ret;
+	}
+
+	ret = amx3_common_init();
+
+	return ret;
+}
+
+static void amx3_pre_suspend_common(void)
+{
+	omap_set_pwrdm_state(gfx_pwrdm, PWRDM_POWER_OFF);
+}
+
+static void amx3_post_suspend_common(void)
+{
+	int status;
+	/*
+	 * Because gfx_pwrdm is the only one under MPU control,
+	 * comment on transition status
+	 */
+	status = pwrdm_read_pwrst(gfx_pwrdm);
+	if (status != PWRDM_POWER_OFF)
+		pr_err("PM: GFX domain did not transition: %x\n", status);
+}
+
+static int am33xx_suspend(unsigned int state, int (*fn)(unsigned long))
+{
+	int ret = 0;
+
+	amx3_pre_suspend_common();
+	ret = cpu_suspend(0, fn);
+	amx3_post_suspend_common();
+
+	/*
+	 * BUG: GFX_L4LS clock domain needs to be woken up to
+	 * ensure thet L4LS clock domain does not get stuck in
+	 * transition. If that happens L3 module does not get
+	 * disabled, thereby leading to PER power domain
+	 * transition failing
+	 */
+
+	clkdm_wakeup(gfx_l4ls_clkdm);
+	clkdm_sleep(gfx_l4ls_clkdm);
+
+	return ret;
+}
+
+static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long))
+{
+	int ret = 0;
+
+	amx3_pre_suspend_common();
+	scu_power_mode(scu_base, SCU_PM_POWEROFF);
+	ret = cpu_suspend(0, fn);
+	scu_power_mode(scu_base, SCU_PM_NORMAL);
+	amx3_post_suspend_common();
+
+	return ret;
+}
+
+static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
+{
+	if (soc_is_am33xx())
+		return &am33xx_pm_sram;
+	else if (soc_is_am437x())
+		return &am43xx_pm_sram;
+	else
+		return NULL;
+}
+
+static struct am33xx_pm_platform_data am33xx_ops = {
+	.init = am33xx_suspend_init,
+	.soc_suspend = am33xx_suspend,
+	.get_sram_addrs = amx3_get_sram_addrs,
+};
+
+static struct am33xx_pm_platform_data am43xx_ops = {
+	.init = am43xx_suspend_init,
+	.soc_suspend = am43xx_suspend,
+	.get_sram_addrs = amx3_get_sram_addrs,
+};
+
+static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
+{
+	if (soc_is_am33xx())
+		return &am33xx_ops;
+	else if (soc_is_am437x())
+		return &am43xx_ops;
+	else
+		return NULL;
+}
+
+void __init amx3_common_pm_init(void)
+{
+	struct am33xx_pm_platform_data *pdata;
+	struct platform_device_info devinfo;
+
+	pdata = am33xx_pm_get_pdata();
+
+	memset(&devinfo, 0, sizeof(devinfo));
+	devinfo.name = "pm33xx";
+	devinfo.data = pdata;
+	devinfo.size_data = sizeof(*pdata);
+	devinfo.id = -1;
+	platform_device_register_full(&devinfo);
+}
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
new file mode 100644
index 000000000000..ef2571501477
--- /dev/null
+++ b/include/linux/platform_data/pm33xx.h
@@ -0,0 +1,74 @@
+/*
+ * TI pm33xx platform data
+ *
+ * Copyright (C) 2016-2017 Texas Instruments, Inc.
+ *	Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_PM33XX_H
+#define _LINUX_PLATFORM_DATA_PM33XX_H
+
+#include <linux/kbuild.h>
+#include <linux/types.h>
+
+#ifndef __ASSEMBLER__
+struct am33xx_pm_sram_addr {
+	void (*do_wfi)(void);
+	unsigned long *do_wfi_sz;
+	unsigned long *resume_offset;
+	unsigned long *emif_sram_table;
+	unsigned long *ro_sram_data;
+};
+
+struct am33xx_pm_platform_data {
+	int	(*init)(void);
+	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long));
+	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
+};
+
+struct am33xx_pm_sram_data {
+	u32 wfi_flags;
+	u32 l2_aux_ctrl_val;
+	u32 l2_prefetch_ctrl_val;
+} __packed __aligned(8);
+
+struct am33xx_pm_ro_sram_data {
+	u32 amx3_pm_sram_data_virt;
+	u32 amx3_pm_sram_data_phys;
+} __packed __aligned(8);
+
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
+static inline void amx3_pm_asm_offsets(void)
+{
+	DEFINE(AMX3_PM_WFI_FLAGS_OFFSET,
+	       offsetof(struct am33xx_pm_sram_data, wfi_flags));
+	DEFINE(AMX3_PM_L2_AUX_CTRL_VAL_OFFSET,
+	       offsetof(struct am33xx_pm_sram_data, l2_aux_ctrl_val));
+	DEFINE(AMX3_PM_L2_PREFETCH_CTRL_VAL_OFFSET,
+	       offsetof(struct am33xx_pm_sram_data, l2_prefetch_ctrl_val));
+	DEFINE(AMX3_PM_SRAM_DATA_SIZE, sizeof(struct am33xx_pm_sram_data));
+
+	BLANK();
+
+	DEFINE(AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET,
+	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_virt));
+	DEFINE(AMX3_PM_RO_SRAM_DATA_PHYS_OFFSET,
+	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_phys));
+	DEFINE(AMX3_PM_RO_SRAM_DATA_SIZE,
+	       sizeof(struct am33xx_pm_ro_sram_data));
+}
+#else
+static inline void amx3_pm_asm_offsets(void) {}
+#endif
+
+#endif /* __ASSEMBLER__ */
+#endif /* _LINUX_PLATFORM_DATA_PM33XX_H */
-- 
2.13.0
