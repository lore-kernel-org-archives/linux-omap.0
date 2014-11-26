From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH v5 4/4] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds
Date: Wed, 26 Nov 2014 15:52:33 -0600
Message-ID: <c5c9586aef3eb4ccddeefd0f40b20d60eeb062c8.1417038624.git.d-gerlach@ti.com>
References: <cover.1417038624.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34823 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbaKZVxU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 16:53:20 -0500
In-Reply-To: <cover.1417038624.git.d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>

With all the requisite changes in place we can now enable basic
PM support for AM33xx. This patch updates the various OMAP files
to enable suspend-resume on AM33xx.

Because the suspend resume functionality is different on AM33xx
than other OMAP platforms due to the need for M3 firmware and an
IPC channel to be in place, separate PM ops are used instead of
omap_pm_ops.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/Makefile | 2 ++
 arch/arm/mach-omap2/common.h | 9 +++++++++
 arch/arm/mach-omap2/io.c     | 1 +
 arch/arm/mach-omap2/pm.h     | 6 ++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d9e9412..6d1464d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,7 @@ omap-4-5-pm-common			=  pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_SOC_AM33XX)		+= pm33xx.o sleep33xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
@@ -97,6 +98,7 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 endif
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 377eea8..64bf9a8 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -76,6 +76,15 @@ static inline int omap4_pm_init_early(void)
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
index 03cbb16..4b7828a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -575,6 +575,7 @@ void __init am33xx_init_early(void)
 void __init am33xx_init_late(void)
 {
 	omap_common_late_init();
+	am33xx_pm_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 425bfcd..9e19340 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -81,6 +81,12 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
+/* am33xx_do_wfi function pointer and size, for copy to SRAM */
+extern void am33xx_do_wfi(void);
+extern unsigned int am33xx_do_wfi_sz;
+extern unsigned int am33xx_resume_offset;
+extern unsigned long am33xx_emif_sram_table;
+
 /* save_secure_ram_context function pointer and size, for copy to SRAM */
 extern int save_secure_ram_context(u32 *addr);
 extern unsigned int save_secure_ram_context_sz;
-- 
2.1.0

