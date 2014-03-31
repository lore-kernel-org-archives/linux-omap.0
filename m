From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 43/55] ARM: OMAP4: PRM: get rid of prminst44xx.h header file
Date: Mon, 31 Mar 2014 18:16:22 +0300
Message-ID: <1396278994-12624-44-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49952 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbaCaPTX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:23 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Only contains a few function prototypes, so move these to the public
prm44xx.h header and remove the now unnecessary prminst44xx.h.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c                      |    1 -
 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    1 -
 arch/arm/mach-omap2/omap4-common.c            |    1 -
 arch/arm/mach-omap2/omap4-restart.c           |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c              |    1 -
 arch/arm/mach-omap2/prminst44xx.c             |    1 -
 arch/arm/mach-omap2/prminst44xx.h             |   27 -------------------------
 arch/arm/mach-omap2/prminst44xx_private.h     |    2 +-
 arch/arm/mach-omap2/voltage.c                 |    1 -
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    1 -
 include/linux/power/omap/prm44xx.h            |   12 +++++++++++
 11 files changed, 14 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prminst44xx.h

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ed677bb..96d498f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -48,7 +48,6 @@
 #include "prm.h"
 #include <linux/power/omap/cm.h>
 #include "prcm_mpu44xx.h"
-#include "prminst44xx.h"
 #include <linux/power/omap/cm44xx.h>
 #include "prm2xxx.h"
 #include "prm3xxx.h"
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 4b1b059..50127e1 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -57,7 +57,6 @@
 #include "omap4-sar-layout.h"
 #include "pm.h"
 #include "prcm_mpu44xx.h"
-#include "prminst44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6cd3f37..54e054a 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -35,7 +35,6 @@
 #include "iomap.h"
 #include "common.h"
 #include "mmc.h"
-#include "prminst44xx.h"
 #include "prcm_mpu44xx.h"
 #include "omap4-sar-layout.h"
 #include "omap-secure.h"
diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
index 41dfd7d..f0102d1 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -9,7 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/reboot.h>
-#include "prminst44xx.h"
+#include <linux/power/omap/prm44xx.h>
 
 /**
  * omap44xx_restart - trigger a software restart of the SoC
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4576f0b..096c43d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -159,7 +159,6 @@
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "prm33xx.h"
-#include "prminst44xx.h"
 #include "mux.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index feb508f..01f6b15 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -21,7 +21,6 @@
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
-#include "prminst44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
 
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
deleted file mode 100644
index fec8f18..0000000
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * OMAP4 Power/Reset Management (PRM) function prototypes
- *
- * Copyright (C) 2010 Nokia Corporation
- * Copyright (C) 2011 Texas Instruments, Inc.
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
-#define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
-
-extern void omap4_prminst_global_warm_sw_reset(void);
-
-extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
-					       u16 rstctrl_offs);
-extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
-					  u16 rstctrl_offs);
-extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
-					    u16 rstctrl_offs);
-void omap4_prminst_mpuss_clear_prev_logic_pwrst(void);
-
-extern void omap_prm_base_init(void);
-
-#endif
diff --git a/arch/arm/mach-omap2/prminst44xx_private.h b/arch/arm/mach-omap2/prminst44xx_private.h
index 59a6e55..5db33b7 100644
--- a/arch/arm/mach-omap2/prminst44xx_private.h
+++ b/arch/arm/mach-omap2/prminst44xx_private.h
@@ -12,7 +12,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRMINST44XX_PRIVATE_H
 #define __ARCH_ARM_MACH_OMAP2_PRMINST44XX_PRIVATE_H
 
-#include "prminst44xx.h"
+#include <linux/power/omap/prm44xx.h>
 
 /*
  * In an ideal world, we would not export these low-level functions,
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 3ac8fe1..78f5a68 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -33,7 +33,6 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm44xx.h"
-#include "prminst44xx.h"
 #include "control.h"
 
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 48b22a0..479b412 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -26,7 +26,6 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm44xx.h"
-#include "prminst44xx.h"
 #include "voltage.h"
 #include "omap_opp_data.h"
 #include "vc.h"
diff --git a/include/linux/power/omap/prm44xx.h b/include/linux/power/omap/prm44xx.h
index e5cd9f3..3c5852e 100644
--- a/include/linux/power/omap/prm44xx.h
+++ b/include/linux/power/omap/prm44xx.h
@@ -417,4 +417,16 @@
 #define OMAP4_PRM_MODEM_IF_CTRL_OFFSET			0x00f4
 #define OMAP4_PRM_VC_ERRST_OFFSET			0x00f8
 
+#ifndef __ASSEMBLER__
+void omap4_prminst_global_warm_sw_reset(void);
+int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+					u16 rstctrl_offs);
+int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
+				   u16 rstctrl_offs);
+int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
+				     u16 rstctrl_offs);
+void omap4_prminst_mpuss_clear_prev_logic_pwrst(void);
+void omap_prm_base_init(void);
+#endif
+
 #endif
-- 
1.7.9.5

