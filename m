From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/17] ARM: OMAP2+: use system reset info from device tree data
Date: Thu, 24 Sep 2015 17:26:52 +0300
Message-ID: <1443104818-993-12-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

System reset mapping used by reboot is now provided through DT data and
a reset controller. Use this instead of the hardcoded PRM API.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile         |    6 ------
 arch/arm/mach-omap2/am33xx-restart.c |   27 ---------------------------
 arch/arm/mach-omap2/board-generic.c  |   16 ++++++++--------
 arch/arm/mach-omap2/common.c         |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common.h         |    2 ++
 arch/arm/mach-omap2/omap2-restart.c  |    2 +-
 arch/arm/mach-omap2/omap3-restart.c  |    2 +-
 arch/arm/mach-omap2/omap4-restart.c  |   27 ---------------------------
 arch/arm/mach-omap2/ti81xx-restart.c |   34 ----------------------------------
 9 files changed, 41 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am33xx-restart.c
 delete mode 100644 arch/arm/mach-omap2/omap4-restart.c
 delete mode 100644 arch/arm/mach-omap2/ti81xx-restart.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9358696..491dc6e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -57,13 +57,7 @@ AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
 # Restart code (OMAP4/5 currently in omap4-common.c)
 obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
-obj-$(CONFIG_SOC_TI81XX)		+= ti81xx-restart.o
-obj-$(CONFIG_SOC_AM33XX)		+= am33xx-restart.o
-obj-$(CONFIG_SOC_AM43XX)		+= omap4-restart.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap3-restart.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap4-restart.o
-obj-$(CONFIG_SOC_OMAP5)			+= omap4-restart.o
-obj-$(CONFIG_SOC_DRA7XX)		+= omap4-restart.o
 
 # Pin multiplexing
 obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
deleted file mode 100644
index 5bace6a..0000000
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * am33xx-restart.c - Code common to all AM33xx machines.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/reboot.h>
-
-#include "common.h"
-#include "prm.h"
-
-/**
- * am3xx_restart - trigger a software restart of the SoC
- * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
- * @cmd: passed from the userspace program rebooting the system (if provided)
- *
- * Resets the SoC.  For @cmd, see the 'reboot' syscall in
- * kernel/sys.c.  No return value.
- */
-void am33xx_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* TODO: Handle mode and cmd if necessary */
-
-	omap_prm_reset_system();
-}
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 24c9afc..6a82a9c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -177,7 +177,7 @@ DT_MACHINE_START(TI814X_DT, "Generic ti814x (Flattened Device Tree)")
 	.init_late	= ti81xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= ti814x_boards_compat,
-	.restart	= ti81xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 
 static const char *const ti816x_boards_compat[] __initconst = {
@@ -194,7 +194,7 @@ DT_MACHINE_START(TI816X_DT, "Generic ti816x (Flattened Device Tree)")
 	.init_late	= ti81xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= ti816x_boards_compat,
-	.restart	= ti81xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
 
@@ -212,7 +212,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_late	= am33xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= am33xx_boards_compat,
-	.restart	= am33xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
 
@@ -237,7 +237,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_late	= omap4430_init_late,
 	.init_time	= omap4_local_timer_init,
 	.dt_compat	= omap4_boards_compat,
-	.restart	= omap44xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
 
@@ -259,7 +259,7 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.init_late	= omap5_init_late,
 	.init_time	= omap5_realtime_timer_init,
 	.dt_compat	= omap5_boards_compat,
-	.restart	= omap44xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
 
@@ -281,7 +281,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= am43_boards_compat,
-	.restart	= omap44xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
 
@@ -304,7 +304,7 @@ DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.init_time	= omap5_realtime_timer_init,
 	.dt_compat	= dra74x_boards_compat,
-	.restart	= omap44xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 
 static const char *const dra72x_boards_compat[] __initconst = {
@@ -323,6 +323,6 @@ DT_MACHINE_START(DRA72X_DT, "Generic DRA72X (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.init_time	= omap5_realtime_timer_init,
 	.dt_compat	= dra72x_boards_compat,
-	.restart	= omap44xx_restart,
+	.restart	= omap_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 484cdad..8afb4ac 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -14,9 +14,13 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/reset.h>
 
 #include "common.h"
 #include "omap-secure.h"
+#include "soc.h"
+
+static struct reset_control *omap_reset_control;
 
 /*
  * Stub function for OMAP2 so that common files
@@ -32,3 +36,28 @@ void __init omap_reserve(void)
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
 }
+
+void omap_restart(enum reboot_mode mode, const char *cmd)
+{
+	if (omap_reset_control)
+		reset_control_assert(omap_reset_control);
+
+	while (1)
+		;
+}
+
+static int __init omap_init_restart(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_name(NULL, "system_reset");
+	omap_reset_control = of_reset_control_get(np, "system");
+	if (IS_ERR(omap_reset_control)) {
+		pr_err("%s: no reset controller, reboot not functional.\n",
+		       __func__);
+		omap_reset_control = NULL;
+	}
+
+	return 0;
+}
+omap_late_initcall(omap_init_restart);
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 92e92cf..51d6068 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -148,6 +148,8 @@ static inline void omap_soc_device_init(void)
 }
 #endif
 
+void omap_restart(enum reboot_mode mode, const char *cmd);
+
 #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
 void omap2xxx_restart(enum reboot_mode mode, const char *cmd);
 #else
diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
index d937b2e..f6dd4fc 100644
--- a/arch/arm/mach-omap2/omap2-restart.c
+++ b/arch/arm/mach-omap2/omap2-restart.c
@@ -40,7 +40,7 @@ void omap2xxx_restart(enum reboot_mode mode, const char *cmd)
 
 	/* XXX Should save the cmd argument for use after the reboot */
 
-	omap_prm_reset_system();
+	omap_restart(mode, cmd);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap3-restart.c b/arch/arm/mach-omap2/omap3-restart.c
index 4bdd22e..5669137 100644
--- a/arch/arm/mach-omap2/omap3-restart.c
+++ b/arch/arm/mach-omap2/omap3-restart.c
@@ -31,5 +31,5 @@
 void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
 {
 	omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
-	omap_prm_reset_system();
+	omap_restart(mode, cmd);
 }
diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
deleted file mode 100644
index e17136a..0000000
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * omap4-restart.c - Common to OMAP4 and OMAP5
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/types.h>
-#include <linux/reboot.h>
-#include "common.h"
-#include "prm.h"
-
-/**
- * omap44xx_restart - trigger a software restart of the SoC
- * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
- * @cmd: passed from the userspace program rebooting the system (if provided)
- *
- * Resets the SoC.  For @cmd, see the 'reboot' syscall in
- * kernel/sys.c.  No return value.
- */
-void omap44xx_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* XXX Should save 'cmd' into scratchpad for use after reboot */
-	omap_prm_reset_system();
-}
diff --git a/arch/arm/mach-omap2/ti81xx-restart.c b/arch/arm/mach-omap2/ti81xx-restart.c
deleted file mode 100644
index 6c3ce7c..0000000
--- a/arch/arm/mach-omap2/ti81xx-restart.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/reboot.h>
-
-#include "iomap.h"
-#include "common.h"
-#include "control.h"
-#include "prm3xxx.h"
-
-#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
-#define TI81XX_GLOBAL_RST_COLD		BIT(1)
-
-/**
- * ti81xx_restart - trigger a software restart of the SoC
- * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
- * @cmd: passed from the userspace program rebooting the system (if provided)
- *
- * Resets the SoC.  For @cmd, see the 'reboot' syscall in
- * kernel/sys.c.  No return value.
- *
- * NOTE: Warm reset does not seem to work, may require resetting
- * clocks to bypass mode.
- */
-void ti81xx_restart(enum reboot_mode mode, const char *cmd)
-{
-	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
-				   TI81XX_PRM_DEVICE_RSTCTRL);
-	while (1);
-}
-- 
1.7.9.5
