From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/16] ARM: OMAP: Make plat/common.h local to mach-omap1 and
 mach-omap2
Date: Thu, 04 Oct 2012 15:04:40 -0700
Message-ID: <20121004220440.26676.32717.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11078 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751591Ab2JDWEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:41 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We cannot keep this in plat/common.h for common zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/common.h                       |    2 +-
 arch/arm/mach-omap2/cm33xx.c                       |    2 +-
 arch/arm/mach-omap2/common.h                       |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/prm33xx.c                      |    2 +-
 arch/arm/mach-omap2/prm_common.c                   |    2 +-
 arch/arm/plat-omap/common.c                        |    2 +-
 arch/arm/plat-omap/common.h                        |    7 ++-----
 arch/arm/plat-omap/counter_32k.c                   |    2 +-
 10 files changed, 11 insertions(+), 14 deletions(-)
 rename arch/arm/plat-omap/{include/plat/common.h => common.h} (92%)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 306b7ac..9f2d8b6 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -26,7 +26,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
 #define __ARCH_ARM_MACH_OMAP1_COMMON_H
 
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 #include <linux/mtd/mtd.h>
 #include <linux/i2c-omap.h>
 
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 13f56eaf..b4938ab 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -22,7 +22,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 
 #include "cm.h"
 #include "cm33xx.h"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index a68b421..d3cd625 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -36,7 +36,7 @@
 
 #include <plat/cpu.h>
 #include <plat/serial.h>
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 
 #include "i2c.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 8851bbb..62ae397 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -12,7 +12,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
 #include <plat/dma.h>
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 #include "hdq1w.h"
 
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 964d61d..d59c5ea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,8 +29,8 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
-#include <plat/common.h>
 #include <plat/iommu.h>
+#include "../plat-omap/common.h"
 
 #include "omap_hwmod_common_data.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index e7dbb6c..624ade5 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 
 #include "common.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6b4d332..6fabbd8 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
-#include <plat/common.h>
+#include "../plat-omap/common.h"
 #include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..cfea68c 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
 #include <plat/dma.h>
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/common.h
similarity index 92%
rename from arch/arm/plat-omap/include/plat/common.h
rename to arch/arm/plat-omap/common.h
index 55c0f8b..e196d13 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/common.h
@@ -1,7 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/common.h
- *
- * Header for code common to all OMAP machines.
+ * Header for shared OMAP code in plat-omap.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -27,13 +25,12 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
-#include <plat/omap_hwmod.h>
-
 extern int __init omap_init_clocksource_32k(void __iomem *vbase);
 
 extern void __init omap_check_revision(void);
 
 extern void omap_reserve(void);
+struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
 void omap_sram_init(void);
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2e826f1..f43dbc3 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -22,7 +22,7 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */

