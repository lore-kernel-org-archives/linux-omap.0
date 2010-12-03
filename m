From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 1/6] OMAP: powerdomain: Move static allocations from powerdomains.h to a .c file
Date: Fri,  3 Dec 2010 17:08:48 +0530
Message-ID: <1291376333-13603-2-git-send-email-rnayak@ti.com>
References: <1291376333-13603-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758495Ab0LCLjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 06:39:06 -0500
In-Reply-To: <1291376333-13603-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@t.com>, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@t.com>

powerdomains.h header today has only static definitions.
Adding any function declarations into
it and including it in multiple source file is
expected to cause issues.
Hence move all the static definitions from powerdomains.h
file into powerdomains_data.c file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/clockdomains.h                 |    5 +++++
 arch/arm/mach-omap2/io.c                           |    3 +--
 .../{powerdomains.h => powerdomains_data.c}        |   10 +++++-----
 arch/arm/plat-omap/include/plat/powerdomain.h      |    1 +
 5 files changed, 13 insertions(+), 8 deletions(-)
 rename arch/arm/mach-omap2/{powerdomains.h => powerdomains_data.c} (97%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..5e20bc5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -9,7 +9,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
-prcm-common				= prcm.o powerdomain.o
+prcm-common				= prcm.o powerdomain.o powerdomains_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 8fc19ff..2a3b10a 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -38,6 +38,11 @@
 #include <plat/clockdomain.h>
 #include "cm.h"
 #include "prm.h"
+#include "cm-regbits-24xx.h"
+#include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
+#include "prm-regbits-24xx.h"
+#include "prm-regbits-34xx.h"
 
 /*
  * Clockdomain dependencies for wkdeps/sleepdeps
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..b5b385d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -40,7 +40,6 @@
 
 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
-#include "powerdomains.h"
 
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
@@ -316,7 +315,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 {
 	u8 skip_setup_idle = 0;
 
-	pwrdm_init(powerdomains_omap);
+	pwrdm_fw_init();
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
 		omap2420_hwmod_init();
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains_data.c
similarity index 97%
rename from arch/arm/mach-omap2/powerdomains.h
rename to arch/arm/mach-omap2/powerdomains_data.c
index 105cbca..475763e 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains_data.c
@@ -18,9 +18,6 @@
  *    Clock Domain Framework
  */
 
-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
-
 /*
  * This file contains all of the powerdomains that have some element
  * of software control for the OMAP24xx and OMAP34xx chips.
@@ -49,6 +46,7 @@
  * address offset is different between the C55 and C64 DSPs.
  */
 
+#include <linux/init.h>
 #include <plat/powerdomain.h>
 
 #include "prcm-common.h"
@@ -149,5 +147,7 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	NULL
 };
 
-
-#endif
+void pwrdm_fw_init(void)
+{
+	pwrdm_init(powerdomains_omap);
+}
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 9ca420d..e322b39 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -118,6 +118,7 @@ struct powerdomain {
 };
 
 
+void pwrdm_fw_init(void);
 void pwrdm_init(struct powerdomain **pwrdm_list);
 
 struct powerdomain *pwrdm_lookup(const char *name);
-- 
1.7.0.4

