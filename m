From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 3/4] ARM: OMAP2+: pm33xx-core: Add platform code needed for
 PM
Date: Fri, 23 Feb 2018 09:43:56 -0600
Message-ID: <20180223154357.23504-4-d-gerlach@ti.com>
References: <20180223154357.23504-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223154357.23504-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
all of the C struct member offsets and sizes as macros by processing
pm-asm-offsets.c into assembly code and then extracting the relevant
data as is done for the generated platform asm-offsets.h files.

Finally, add amx3_common_pm_init to create a dummy platform_device for
pm33xx so that our soon to be introduced pm33xx module can probe on
am335x and am437x platforms to enable basic suspend to mem and standby
support.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/Kconfig          |   1 +
 arch/arm/mach-omap2/Makefile         |  16 +++
 arch/arm/mach-omap2/common.h         |   7 ++
 arch/arm/mach-omap2/io.c             |   2 +
 arch/arm/mach-omap2/pm-asm-offsets.c |  31 ++++++
 arch/arm/mach-omap2/pm.h             |   3 +
 arch/arm/mach-omap2/pm33xx-core.c    | 189 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep33xx.S      |   2 +
 arch/arm/mach-omap2/sleep43xx.S      |   2 +
 include/linux/platform_data/pm33xx.h |  42 ++++++++
 10 files changed, 295 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm-asm-offsets.c
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 include/linux/platform_data/pm33xx.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 00b1f17f8d44..9f27b486a536 100644
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
index c15bbcad5f67..4603c30fef73 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -88,6 +88,8 @@ omap-4-5-pm-common			+= pm44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_SOC_AM33XX)		+= pm33xx-core.o sleep33xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= pm33xx-core.o sleep43xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -95,6 +97,8 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep43xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 endif
 
@@ -232,3 +236,15 @@ obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
 obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
+
+arch/arm/mach-omap2/pm-asm-offsets.s: arch/arm/mach-omap2/pm-asm-offsets.c
+	$(call if_changed_dep,cc_s_c)
+
+include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
+	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
+
+# For rule to generate ti-emif-asm-offsets.h dependency
+include drivers/memory/Makefile.asm-offsets
+
+arch/arm/mach-omap2/sleep33xx.o: include/generated/ti-pm-asm-offsets.h include/generated/ti-emif-asm-offsets.h
+arch/arm/mach-omap2/sleep43xx.o: include/generated/ti-pm-asm-offsets.h include/generated/ti-emif-asm-offsets.h
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index bc202835371b..fbe0b78bf489 100644
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
index cb5d7314cf99..cf546dfe3b32 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -622,6 +622,7 @@ void __init am33xx_init_early(void)
 void __init am33xx_init_late(void)
 {
 	omap_common_late_init();
+	amx3_common_pm_init();
 }
 #endif
 
@@ -646,6 +647,7 @@ void __init am43xx_init_late(void)
 {
 	omap_common_late_init();
 	omap2_clk_enable_autoidle_all();
+	amx3_common_pm_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm-asm-offsets.c b/arch/arm/mach-omap2/pm-asm-offsets.c
new file mode 100644
index 000000000000..6d4392da7c11
--- /dev/null
+++ b/arch/arm/mach-omap2/pm-asm-offsets.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI AM33XX and AM43XX PM Assembly Offsets
+ *
+ * Copyright (C) 2017-2018 Texas Instruments Inc.
+ */
+
+#include <linux/kbuild.h>
+#include <linux/platform_data/pm33xx.h>
+
+int main(void)
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
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 8e30772cfe32..c73776b82348 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,6 +81,9 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
+extern struct am33xx_pm_sram_addr am33xx_pm_sram;
+extern struct am33xx_pm_sram_addr am43xx_pm_sram;
+
 extern void omap3_save_scratchpad_contents(void);
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
new file mode 100644
index 000000000000..93c0b5ba9f09
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM33XX Arch Power Management Routines
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Dave Gerlach
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
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 04015f98b6e3..218d79930b04 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -6,6 +6,8 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
+#include <generated/ti-emif-asm-offsets.h>
+#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/ti-emif-sram.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 0defc735e319..59770a69396b 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -6,6 +6,8 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
+#include <generated/ti-emif-asm-offsets.h>
+#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/ti-emif-sram.h>
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
new file mode 100644
index 000000000000..f9bed2a0af9d
--- /dev/null
+++ b/include/linux/platform_data/pm33xx.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI pm33xx platform data
+ *
+ * Copyright (C) 2016-2018 Texas Instruments, Inc.
+ *	Dave Gerlach <d-gerlach@ti.com>
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
+#endif /* __ASSEMBLER__ */
+#endif /* _LINUX_PLATFORM_DATA_PM33XX_H */
-- 
2.16.1
