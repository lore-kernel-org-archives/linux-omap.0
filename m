From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/14] OMAP: powerdomain: Move static allocations from
	powerdomains.h to a .c file
Date: Mon, 06 Dec 2010 18:25:03 -0700
Message-ID: <20101207012458.3708.30318.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0LGBnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:46 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@t.com>

powerdomains.h header today has only static definitions.  Adding any
function declarations into it and including it in multiple source file
is expected to cause issues.  Hence move all the static definitions
from powerdomains.h file into powerdomains_data.c file.

Also, create a new powerdomain section of the mach-omap2/Makefile, and
rearrange the prcm-common part of the Makefile, now that the
powerdomain code is in its own Makefile section.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: rearrange Makefile changes, tweaked commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                  |   17 ++++++++++-------
 arch/arm/mach-omap2/clockdomains.h            |    5 +++++
 arch/arm/mach-omap2/io.c                      |    3 +--
 arch/arm/mach-omap2/powerdomains_data.c       |   10 +++++-----
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 5 files changed, 22 insertions(+), 14 deletions(-)
 rename arch/arm/mach-omap2/{powerdomains.h => powerdomains_data.c} (97%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..ddc0a6f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -9,14 +9,13 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
-prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common) prm44xx.o $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -65,9 +64,13 @@ endif
 endif
 
 # PRCM
-obj-$(CONFIG_ARCH_OMAP2)		+= cm.o
-obj-$(CONFIG_ARCH_OMAP3)		+= cm.o
-obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm.o
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm4xxx.o
+
+# OMAP powerdomain framework
+powerdomain-common			+= powerdomain.o powerdomains_data.o
+obj-y					+= $(powerdomain-common)
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
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


