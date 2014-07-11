From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 11/11] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds
Date: Thu, 10 Jul 2014 21:55:49 -0500
Message-ID: <1405047349-15101-12-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbaGKC57 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 22:57:59 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>

With all the requisite changes in place we can now enable the basic
PM support for AM33xx. This patch updates the various OMAP files
to enable suspend-resume on AM33xx.

Because the suspend resume functionality is different on AM33xx
than other OMAP platforms due to the need for M3 firmware and an
IPC channel to be in place, separate PM ops are used instead of
omap_pm_ops. These are now set using omap2_common_suspend_init
so the AM33xx can make a decision at runtime to enable suspend based
on the availabilty of aforementioned requirements.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4:
	Updated for rproc usage now.

 arch/arm/mach-omap2/Kconfig  |  1 +
 arch/arm/mach-omap2/Makefile |  2 ++
 arch/arm/mach-omap2/common.h |  9 +++++++++
 arch/arm/mach-omap2/io.c     |  1 +
 arch/arm/mach-omap2/pm.h     |  5 +++++
 arch/arm/mach-omap2/sram.c   | 10 +++++++++-
 arch/arm/mach-omap2/sram.h   |  2 ++
 7 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1c1ed73..f8a56e5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -59,6 +59,7 @@ config SOC_AM33XX
 	select ARCH_OMAP2PLUS
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
+	select WKUP_M3_RPROC if PM
 
 config SOC_AM43XX
 	bool "TI AM43x"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8ca99e9..3c8d30c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap-mpuss-lowpower.o
+obj-$(CONFIG_SOC_AM33XX)		+= pm33xx.o sleep33xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -97,6 +98,7 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 endif
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 1536338..1bcd475 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -75,6 +75,15 @@ static inline int omap4_pm_init_early(void)
 }
 #endif
 
+#if defined(CONFIG_PM) && defined(CONFIG_SOC_AM33XX)
+int am33xx_pm_init(void);
+#else
+static inline int am33xx_pm_init(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_OMAP_MUX
 int omap_mux_late_init(void);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4d4d150..fb23f83 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -590,6 +590,7 @@ void __init am33xx_init_early(void)
 void __init am33xx_init_late(void)
 {
 	omap_common_late_init();
+	am33xx_pm_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index e150102..b6f72a4 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,6 +81,11 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
+/* am33xx_do_wfi function pointer and size, for copy to SRAM */
+extern void am33xx_do_wfi(void);
+extern unsigned int am33xx_do_wfi_sz;
+extern unsigned int am33xx_resume_offset;
+
 /* save_secure_ram_context function pointer and size, for copy to SRAM */
 extern int save_secure_ram_context(u32 *addr);
 extern unsigned int save_secure_ram_context_sz;
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index ddf1818..2227f20 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -154,7 +154,7 @@ static void __init omap2_map_sram(void)
 		omap_sram_size -= SZ_16K;
 	}
 #endif
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || soc_is_am33xx()) {
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the
 		 * CORE DPLL M2 divider change code (in SRAM) runs with the
@@ -285,10 +285,18 @@ static inline int omap34xx_sram_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_SOC_AM33XX
 static inline int am33xx_sram_init(void)
 {
+	am33xx_push_sram_idle();
 	return 0;
 }
+#else
+static inline int am33xx_sram_init(void)
+{
+	return 0;
+}
+#endif
 
 int __init omap_sram_init(void)
 {
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index ca7277c..24788b5 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -62,8 +62,10 @@ extern unsigned long omap3_sram_configure_core_dpll_sz;
 
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
+extern void am33xx_push_sram_idle(void);
 #else
 static inline void omap_push_sram_idle(void) {}
+static inline void am33xx_push_sram_idle(void) {}
 #endif /* CONFIG_PM */
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.0

