From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 34/55] ARM: AM33XX: PRM: move parts of the prm33xx.h header file to public location
Date: Mon, 31 Mar 2014 18:16:13 +0300
Message-ID: <1396278994-12624-35-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbaCaPSb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:31 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Parts of this file are needed from both the driver and mach-omap2 board
code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/am33xx-restart.c |    2 +-
 arch/arm/mach-omap2/cm33xx.c         |    3 ++-
 arch/arm/mach-omap2/prm33xx.c        |    3 ++-
 arch/arm/mach-omap2/prm33xx.h        |   23 +---------------------
 include/linux/power/omap/prm33xx.h   |   36 ++++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/power/omap/prm33xx.h

diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index 7286389..9ae249c 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -10,7 +10,7 @@
 
 #include "common.h"
 #include "prm-regbits-33xx.h"
-#include "prm33xx.h"
+#include <linux/power/omap/prm33xx.h>
 
 /**
  * am3xx_restart - trigger a software restart of the SoC
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 7717eeb..43e4f26 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -25,7 +25,8 @@
 #include "clockdomain.h"
 #include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm33xx.h>
-#include "prm33xx.h"
+#include <linux/power/omap/prm33xx.h>
+#include "prcm-common.h"
 
 #define AM33XX_MODULEMODE_SHIFT			0
 #define AM33XX_MODULEMODE_MASK			(0x3 << 0)
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index a08b1da..436cd12 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -18,9 +18,10 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/power/omap/prm33xx.h>
 
 #include "powerdomain.h"
-#include "prm33xx.h"
+#include "prm.h"
 
 #define AM33XX_LASTPOWERSTATEENTERED_SHIFT	24
 #define AM33XX_LASTPOWERSTATEENTERED_MASK	(0x3 << 24)
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 9b9918d..7825b1c 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -18,23 +18,13 @@
 
 #include "prcm-common.h"
 #include "prm.h"
+#include <linux/power/omap/prm33xx.h>
 
 #define AM33XX_PRM_BASE               0x44E00000
 
 #define AM33XX_PRM_REGADDR(inst, reg)                         \
 	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
 
-
-/* PRM instances */
-#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
-#define AM33XX_PRM_PER_MOD		0x0C00
-#define AM33XX_PRM_WKUP_MOD		0x0D00
-#define AM33XX_PRM_MPU_MOD		0x0E00
-#define AM33XX_PRM_DEVICE_MOD		0x0F00
-#define AM33XX_PRM_RTC_MOD		0x1000
-#define AM33XX_PRM_GFX_MOD		0x1100
-#define AM33XX_PRM_CEFUSE_MOD		0x1200
-
 /* PRM */
 
 /* PRM.OCP_SOCKET_PRM register offsets */
@@ -117,15 +107,4 @@
 #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
-#ifndef __ASSEMBLER__
-extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
-extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
-extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
-extern void am33xx_prm_global_warm_sw_reset(void);
-extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
-		u16 rstctrl_offs);
-extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
-extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
-		u16 rstctrl_offs, u16 rstst_offs);
-#endif /* ASSEMBLER */
 #endif
diff --git a/include/linux/power/omap/prm33xx.h b/include/linux/power/omap/prm33xx.h
new file mode 100644
index 0000000..ea72bf0
--- /dev/null
+++ b/include/linux/power/omap/prm33xx.h
@@ -0,0 +1,36 @@
+/*
+ * AM33XX PRM instance offset macros
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_POWER_OMAP_PRM33XX_H
+#define __LINUX_POWER_OMAP_PRM33XX_H
+
+/* PRM instances */
+#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
+#define AM33XX_PRM_PER_MOD		0x0C00
+#define AM33XX_PRM_WKUP_MOD		0x0D00
+#define AM33XX_PRM_MPU_MOD		0x0E00
+#define AM33XX_PRM_DEVICE_MOD		0x0F00
+#define AM33XX_PRM_RTC_MOD		0x1000
+#define AM33XX_PRM_GFX_MOD		0x1100
+#define AM33XX_PRM_CEFUSE_MOD		0x1200
+
+#ifndef __ASSEMBLER__
+void am33xx_prm_global_warm_sw_reset(void);
+int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs);
+int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
+int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
+				  u16 rstctrl_offs, u16 rstst_offs);
+#endif /* ASSEMBLER */
+#endif
-- 
1.7.9.5

