From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 09/11] OMAP2+: clockdomain: move header file from plat-omap
 to mach-omap2
Date: Tue, 14 Dec 2010 22:39:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142237290.15971@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061842.30541.15900.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60681 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab0LOFjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 00:39:47 -0500
In-Reply-To: <20101208061842.30541.15900.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <greg@kroah.com>


On Tue, 7 Dec 2010, Paul Walmsley wrote:

> The OMAP clockdomain code and data is all OMAP2+-specific.  This seems
> unlikely to change any time soon.  Move plat-omap/include/plat/clockdomain.h
> to mach-omap2/clockdomain.h.  The primary point of doing this is to remove
> the temptation for unrelated upper-layer code to access clockdomain code
> and data directly.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

This patch has been updated to get DSPBridge building again. 

The DSPBridge should not be touching the clockdomain headers; this is
just a temporary workaround until the DSPBridge people fix the code.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 14 Dec 2010 13:03:49 -0700
Subject: [PATCH] OMAP2+: clockdomain: move header file from plat-omap to mach-omap2

The OMAP clockdomain code and data is all OMAP2+-specific.  This seems
unlikely to change any time soon.  Move plat-omap/include/plat/clockdomain.h
to mach-omap2/clockdomain.h.  The primary point of doing this is to remove
the temptation for unrelated upper-layer code to access clockdomain code
and data directly.

DSPBridge also uses the clockdomain headers for some reason, so,
modify it also. The DSPBridge code should not be including the
clockdomain headers; these should be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>
---
 arch/arm/mach-omap2/clock.c                        |    2 +-
 arch/arm/mach-omap2/clockdomain.c                  |    2 +-
 .../include/plat => mach-omap2}/clockdomain.h      |    6 ++----
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    2 +-
 arch/arm/mach-omap2/io.c                           |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/pm-debug.c                     |    2 +-
 arch/arm/mach-omap2/pm.c                           |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/powerdomain.c                  |    2 +-
 drivers/staging/tidspbridge/core/_tiomap.h         |    7 ++++++-
 14 files changed, 20 insertions(+), 17 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/clockdomain.h (97%)

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
index e5605c2..650bf68 100644
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
index 1732fb3..ab2d1ed 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -41,7 +41,7 @@
 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
 
-#include <plat/clockdomain.h>
+#include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1312ce2..e1358ba 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -139,7 +139,7 @@
 
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
diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
index 7fac488..a3190e7 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -19,8 +19,13 @@
 #ifndef _TIOMAP_
 #define _TIOMAP_
 
+/*
+ * XXX These powerdomain.h/clockdomain.h includes are wrong and should
+ * be removed.  No driver should call pwrdm_* or clkdm_* functions
+ * directly; they should rely on OMAP core code to do this.
+ */
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
+#include <mach-omap2/clockdomain.h>
 /*
  * XXX These mach-omap2/ includes are wrong and should be removed.  No
  * driver should read or write to PRM/CM registers directly; they
-- 
1.7.2.3

