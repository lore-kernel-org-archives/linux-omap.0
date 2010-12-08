From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/11] OMAP2+: clockdomain: move header file from plat-omap to
	mach-omap2
Date: Tue, 07 Dec 2010 23:18:43 -0700
Message-ID: <20101208061842.30541.15900.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0LHGT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:56 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

The OMAP clockdomain code and data is all OMAP2+-specific.  This seems
unlikely to change any time soon.  Move plat-omap/include/plat/clockdomain.h
to mach-omap2/clockdomain.h.  The primary point of doing this is to remove
the temptation for unrelated upper-layer code to access clockdomain code
and data directly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock.c                      |    2 +-
 arch/arm/mach-omap2/clockdomain.c                |    2 +-
 arch/arm/mach-omap2/clockdomain.h                |    6 ++----
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |    2 +-
 arch/arm/mach-omap2/io.c                         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |    2 +-
 arch/arm/mach-omap2/pm-debug.c                   |    2 +-
 arch/arm/mach-omap2/pm.c                         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                     |    2 +-
 arch/arm/mach-omap2/pm34xx.c                     |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 13 files changed, 14 insertions(+), 16 deletions(-)
 rename arch/arm/{plat-omap/include/plat/clockdomain.h => mach-omap2/clockdomain.h} (97%)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index cda2f1d..2a2f152 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -24,7 +24,7 @@
 #include <linux/bitops.h>
 
 #include <plat/clock.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 84cdd1d..dadfb3f 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -35,7 +35,7 @@
 
 #include <plat/clock.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/prcm.h>
 
 /* clkdm_list contains all registered struct clockdomains */
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
similarity index 97%
rename from arch/arm/plat-omap/include/plat/clockdomain.h
rename to arch/arm/mach-omap2/clockdomain.h
index e91ae92..372c646 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -11,12 +11,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * XXX This should be moved to mach-omap2/ at the earliest opportunity.
  */
 
-#ifndef __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
-#define __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
 
 #include <linux/init.h>
 
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 6e9ec49..e4a7133 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -35,7 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 2d3d1ef..51920fc 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -26,7 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d50b45..568dff7 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,7 +28,7 @@
 #include <plat/prcm.h>
 #include <plat/irqs.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/serial.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d05638ac..1151f4a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -41,7 +41,7 @@
 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
 
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 63d3f4d..10bd001 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,7 +138,7 @@
 
 #include <plat/common.h>
 #include <plat/cpu.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/powerdomain.h>
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 73f8ec0..3fc7707 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -30,7 +30,7 @@
 #include <plat/clock.h>
 #include <plat/board.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/dmtimer.h>
 
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 59ca03b..60cfe67 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -19,7 +19,7 @@
 #include <plat/common.h>
 
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 
 static struct omap_device_pm_latency *pm_lats;
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index f13e2ca..7d4933b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -51,7 +51,7 @@
 #include "control.h"
 
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8ea8051..43c1a43 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -31,7 +31,7 @@
 #include <linux/console.h>
 
 #include <plat/sram.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/powerdomain.h>
 #include <plat/serial.h>
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index a76ad3f..7eb7ba4 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -27,7 +27,7 @@
 
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/prcm.h>
 
 #include "pm.h"


