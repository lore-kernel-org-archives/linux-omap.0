From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 3/3] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around __omap2_set_globals
Date: Thu, 28 Jun 2012 20:29:27 +0530
Message-ID: <1340895567-22766-4-git-send-email-hvaibhav@ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38252 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab2F1O7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:59:46 -0400
In-Reply-To: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

The function __omap2_set_globals() can be common across all
platforms/architectures, even in case of omap4, internally it
calls same set of functions as in __omap2_set_globals() function
(except for sdrc).
This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
so that we can reuse same function across omap2/3/4...

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>

Changes from V1:
	- Added Makefile rule to build sdrc.c file for new
	  option SOC_HAS_OMAP2_SDRC (as per Kevin's comment).
---
 arch/arm/mach-omap2/Kconfig  |    8 ++++++++
 arch/arm/mach-omap2/Makefile |    3 ++-
 arch/arm/mach-omap2/common.c |    8 +-------
 arch/arm/mach-omap2/common.h |    5 +++++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 208b950..82d9d18 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -21,12 +21,16 @@ config ARCH_OMAP2PLUS_TYPICAL
 	help
 	  Compile a kernel suitable for booting most boards

+config SOC_HAS_OMAP2_SDRC
+	bool "OMAP2 SDRAM Controller support"
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
+	select SOC_HAS_OMAP2_SDRC

 config ARCH_OMAP3
 	bool "TI OMAP3"
@@ -39,6 +43,7 @@ config ARCH_OMAP3
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
 	select MULTI_IRQ_HANDLER
+	select SOC_HAS_OMAP2_SDRC

 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -66,16 +71,19 @@ config SOC_OMAP2420
 	depends on ARCH_OMAP2
 	default y
 	select OMAP_DM_TIMER
+	select SOC_HAS_OMAP2_SDRC

 config SOC_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 	default y
+	select SOC_HAS_OMAP2_SDRC

 config SOC_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
 	default y
+	select SOC_HAS_OMAP2_SDRC

 config SOC_TI81XX
 	bool "TI81XX support"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e5c17d3..3767164 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o

-omap-2-3-common				= irq.o sdrc.o
+omap-2-3-common				= irq.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
@@ -23,6 +23,7 @@ obj-y += mcbsp.o
 endif

 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
+obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o

 # SMP support ONLY available for OMAP4

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8a6953a..7978e5e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -29,8 +29,6 @@

 /* Global address base setup code */

-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
 static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 {
 	omap2_set_globals_tap(omap2_globals);
@@ -39,8 +37,6 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 	omap2_set_globals_prcm(omap2_globals);
 }

-#endif
-
 #if defined(CONFIG_SOC_OMAP2420)

 static struct omap_globals omap242x_globals = {
@@ -171,9 +167,7 @@ static struct omap_globals omap4_globals = {

 void __init omap2_set_globals_443x(void)
 {
-	omap2_set_globals_tap(&omap4_globals);
-	omap2_set_globals_control(&omap4_globals);
-	omap2_set_globals_prcm(&omap4_globals);
+	__omap2_set_globals(&omap4_globals);
 }

 void __init omap4_map_io(void)
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 5d99c1b..404f172 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -174,7 +174,12 @@ void omap2_set_globals_am33xx(void);

 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
+#if defined(CONFIG_SOC_HAS_OMAP2_SDRC)
 void omap2_set_globals_sdrc(struct omap_globals *);
+#else
+static inline void omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
+{ }
+#endif
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);

--
1.7.0.4

