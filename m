From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/13] ARM: OMAP2+: PRCM: remove obsolete prcm.[ch]
Date: Thu, 25 Oct 2012 17:21:23 -0600
Message-ID: <20121025232122.17558.35828.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38300 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2JYXYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:06 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

arch/arm/mach-omap2/prcm.c and arch/arm/plat-omap/include/plat/prcm.h
are now completely unused and can be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/reset.c            |    2 -
 arch/arm/mach-omap2/Makefile           |    2 +
 arch/arm/mach-omap2/clkt2xxx_apll.c    |    1 -
 arch/arm/mach-omap2/clkt_iclk.c        |    1 -
 arch/arm/mach-omap2/clock.c            |    1 -
 arch/arm/mach-omap2/cpuidle34xx.c      |    1 -
 arch/arm/mach-omap2/io.c               |    1 -
 arch/arm/mach-omap2/omap_hwmod.c       |    1 -
 arch/arm/mach-omap2/pm34xx.c           |    1 -
 arch/arm/mach-omap2/powerdomain.c      |    2 -
 arch/arm/mach-omap2/prcm.c             |   63 --------------------------------
 arch/arm/mach-omap2/prm2xxx.c          |    1 -
 arch/arm/mach-omap2/prm3xxx.c          |    1 -
 arch/arm/mach-omap2/prm44xx.c          |    1 -
 arch/arm/mach-omap2/prm_common.c       |    1 -
 arch/arm/plat-omap/include/plat/prcm.h |   35 ------------------
 16 files changed, 1 insertion(+), 114 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prcm.c
 delete mode 100644 arch/arm/plat-omap/include/plat/prcm.h

diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index a0a9f97..2007d41 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -4,8 +4,6 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <plat/prcm.h>
-
 #include <mach/hardware.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index aa0f59c..870f63e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
 endif
 
 # PRCM
-obj-y					+= prcm.o prm_common.o cm_common.o
+obj-y					+= prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index d47f6f7..6c8a8fc 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 
 #include <plat/clock.h>
-#include <plat/prcm.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 3d43fba..66a7475 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 
 #include <plat/clock.h>
-#include <plat/prcm.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 19acf08..bbd6184 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -26,7 +26,6 @@
 #include <asm/cpu.h>
 
 #include <plat/clock.h>
-#include <plat/prcm.h>
 
 #include <trace/events/power.h>
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index bc27569..bca7a88 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -27,7 +27,6 @@
 #include <linux/export.h>
 #include <linux/cpu_pm.h>
 
-#include <plat/prcm.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8573e6c..49b0d8e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,7 +32,6 @@
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
 #include <plat/dma.h>
-#include <plat/prcm.h>
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 85e8874..ad98d97 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -141,7 +141,6 @@
 
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
-#include <plat/prcm.h>
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c0f8a78..26ea418 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -39,7 +39,6 @@
 #include "clockdomain.h"
 #include "powerdomain.h"
 #include <plat/sdrc.h>
-#include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1678a32..dea62a9 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -29,8 +29,6 @@
 
 #include <asm/cpu.h>
 
-#include <plat/prcm.h>
-
 #include "powerdomain.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
deleted file mode 100644
index 8a603fe..0000000
--- a/arch/arm/mach-omap2/prcm.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/prcm.c
- *
- * OMAP 24xx Power Reset and Clock Management (PRCM) functions
- *
- * Copyright (C) 2005 Nokia Corporation
- *
- * Written by Tony Lindgren <tony.lindgren@nokia.com>
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Rajendra Nayak <rnayak@ti.com>
- *
- * Some pieces of code Copyright (C) 2005 Texas Instruments, Inc.
- * Upgraded with OMAP4 support by Abhijit Pagare <abhijitpagare@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/export.h>
-
-#include "common.h"
-#include <plat/prcm.h>
-
-#include "clock.h"
-#include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
-#include "prm2xxx_3xxx.h"
-#include "prm44xx.h"
-#include "prminst44xx.h"
-#include "cminst44xx.h"
-#include "prm-regbits-24xx.h"
-#include "prm-regbits-44xx.h"
-#include "control.h"
-
-
-/*
- * Stubbed functions so that common files continue to build when
- * custom builds are used
- * XXX These are temporary and should be removed at the earliest possible
- * opportunity
- */
-int __weak omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-
-void __weak omap4_cminst_module_enable(u8 mode, u8 part, u16 inst,
-				s16 cdoffs, u16 clkctrl_offs)
-{
-}
-
-void __weak omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-				 u16 clkctrl_offs)
-{
-}
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 1f777bf..bf24fc4 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -20,7 +20,6 @@
 
 #include "common.h"
 #include <plat/cpu.h>
-#include <plat/prcm.h>
 
 #include "vp.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 5435673..b86116c 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -20,7 +20,6 @@
 
 #include "common.h"
 #include <plat/cpu.h>
-#include <plat/prcm.h>
 
 #include "vp.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a799e95..6d3467a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -18,7 +18,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/prcm.h>
 
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index c089246..2216505 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 
 #include <plat/common.h>
-#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
deleted file mode 100644
index 08eda93..0000000
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/prcm.h
- *
- * Access definations for use in OMAP24XX clock and power management
- *
- * Copyright (C) 2005 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * XXX This file is deprecated.  The PRCM is an OMAP2+-only subsystem,
- * so this file doesn't belong in plat-omap/include/plat.  Please
- * do not add anything new to this file.
- */
-
-#ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
-#define __ASM_ARM_ARCH_OMAP_PRCM_H
-
-/* XXX To be removed */
-
-#endif
-
-
-


