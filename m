From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 49/55] ARM: OMAP4: move prcm44xx.h header to public location
Date: Mon, 31 Mar 2014 18:16:28 +0300
Message-ID: <1396278994-12624-50-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54797 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbaCaPTN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:13 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomains43xx_data.c   |    1 -
 arch/arm/mach-omap2/clockdomains44xx_data.c   |    2 +-
 arch/arm/mach-omap2/clockdomains54xx_data.c   |    2 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c    |    2 +-
 arch/arm/mach-omap2/cminst44xx.c              |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c     |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |    2 +-
 arch/arm/mach-omap2/powerdomains43xx_data.c   |    1 -
 arch/arm/mach-omap2/powerdomains44xx_data.c   |    2 +-
 arch/arm/mach-omap2/powerdomains54xx_data.c   |    2 +-
 arch/arm/mach-omap2/powerdomains7xx_data.c    |    2 +-
 arch/arm/mach-omap2/prcm44xx.h                |   53 -------------------------
 arch/arm/mach-omap2/prm44xx.c                 |    2 +-
 arch/arm/mach-omap2/prminst44xx.c             |    2 +-
 arch/arm/mach-omap2/voltage.c                 |    2 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    1 -
 include/linux/power/omap/prcm44xx.h           |   53 +++++++++++++++++++++++++
 17 files changed, 65 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prcm44xx.h
 create mode 100644 include/linux/power/omap/prcm44xx.h

diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
index 6d71c60..11a319b 100644
--- a/arch/arm/mach-omap2/clockdomains43xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 
 #include "clockdomain.h"
-#include "prcm44xx.h"
 #include "prcm43xx.h"
 
 static struct clockdomain l4_cefuse_43xx_clkdm = {
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 95192a0..a335303 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -28,7 +28,7 @@
 
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prcm_mpu44xx.h"
 
 /* Static Dependencies for OMAP4 Clock Domains */
diff --git a/arch/arm/mach-omap2/clockdomains54xx_data.c b/arch/arm/mach-omap2/clockdomains54xx_data.c
index 1a3c69d..59ea31e 100644
--- a/arch/arm/mach-omap2/clockdomains54xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains54xx_data.c
@@ -27,7 +27,7 @@
 
 #include "cm-regbits-54xx.h"
 #include "prm54xx.h"
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prcm_mpu54xx.h"
 
 /* Static Dependencies for OMAP4 Clock Domains */
diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 57d5df0..b169667 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -29,7 +29,7 @@
 
 #include "cm-regbits-7xx.h"
 #include "prm7xx.h"
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prcm_mpu7xx.h"
 
 /* Static Dependencies for DRA7xx Clock Domains */
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 0fd50d7..3b95fc6 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -27,7 +27,7 @@
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include <linux/power/omap/cm44xx.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include <linux/power/omap/prm44xx.h>
 #include "prcm_mpu44xx.h"
 #include <linux/power/omap/prcm-common.h>
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 50127e1..33f5774 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -57,7 +57,7 @@
 #include "omap4-sar-layout.h"
 #include "pm.h"
 #include "prcm_mpu44xx.h"
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 7262b3d..86ef5f6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -23,7 +23,7 @@
 #include <trace/events/power.h>
 
 #include <linux/power/omap/cm2xxx_3xxx.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/prm44xx.h>
 
diff --git a/arch/arm/mach-omap2/powerdomains43xx_data.c b/arch/arm/mach-omap2/powerdomains43xx_data.c
index b99eac7..91802f1 100644
--- a/arch/arm/mach-omap2/powerdomains43xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains43xx_data.c
@@ -14,7 +14,6 @@
 #include "powerdomain.h"
 
 #include <linux/power/omap/prcm-common.h>
-#include "prcm44xx.h"
 #include "prcm43xx.h"
 
 static struct powerdomain gfx_43xx_pwrdm = {
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index ea1ffc1..793c611 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -25,7 +25,7 @@
 #include "powerdomain.h"
 
 #include <linux/power/omap/prcm-common.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains54xx_data.c b/arch/arm/mach-omap2/powerdomains54xx_data.c
index b4a815b..37017f2 100644
--- a/arch/arm/mach-omap2/powerdomains54xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains54xx_data.c
@@ -24,7 +24,7 @@
 #include "powerdomain.h"
 
 #include <linux/power/omap/prcm-common.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prm54xx.h"
 #include "prcm_mpu54xx.h"
 
diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index cf33ef6..cedc84b 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -26,7 +26,7 @@
 #include "powerdomain.h"
 
 #include <linux/power/omap/prcm-common.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prm7xx.h"
 #include "prcm_mpu7xx.h"
 
diff --git a/arch/arm/mach-omap2/prcm44xx.h b/arch/arm/mach-omap2/prcm44xx.h
deleted file mode 100644
index 4fea2cf..0000000
--- a/arch/arm/mach-omap2/prcm44xx.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * OMAP4 PRCM definitions
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This file contains macros and functions that are common to all of
- * the PRM/CM/PRCM blocks on the OMAP4 devices: PRM, CM1, CM2,
- * PRCM_MPU, SCRM
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
-#define __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
-
-/*
- * OMAP4 PRCM partition IDs
- *
- * The numbers and order are arbitrary, but 0 is reserved for the
- * 'invalid' partition in case someone forgets to add a
- * .prcm_partition field.
- */
-#define OMAP4430_INVALID_PRCM_PARTITION		0
-#define OMAP4430_PRM_PARTITION			1
-#define OMAP4430_CM1_PARTITION			2
-#define OMAP4430_CM2_PARTITION			3
-#define OMAP4430_SCRM_PARTITION			4
-#define OMAP4430_PRCM_MPU_PARTITION		5
-
-#define OMAP54XX_PRM_PARTITION			1
-#define OMAP54XX_CM_CORE_AON_PARTITION		2
-#define OMAP54XX_CM_CORE_PARTITION		3
-#define OMAP54XX_SCRM_PARTITION			4
-#define OMAP54XX_PRCM_MPU_PARTITION		5
-
-#define DRA7XX_PRM_PARTITION                   1
-#define DRA7XX_CM_CORE_AON_PARTITION           2
-#define DRA7XX_CM_CORE_PARTITION               3
-#define DRA7XX_MPU_PRCM_PARTITION              5
-
-/*
- * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
- * IDs, plus one
- */
-#define OMAP4_MAX_PRCM_PARTITIONS		6
-
-
-#endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index cf312a8..69a974b 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -22,7 +22,7 @@
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prminst44xx_private.h"
 #include "powerdomain.h"
 #include <linux/power/omap/prm.h>
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 30015d1..5b7c17e 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -21,7 +21,7 @@
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "prcm_mpu44xx.h"
 
 #define OMAP4430_RST_GLOBAL_WARM_SW_MASK		(1 << 0)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 78f5a68..b707328 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -32,7 +32,7 @@
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
-#include "prcm44xx.h"
+#include <linux/power/omap/prcm44xx.h>
 #include "control.h"
 
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 479b412..f452ab8 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -25,7 +25,6 @@
 #include "soc.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
-#include "prcm44xx.h"
 #include "voltage.h"
 #include "omap_opp_data.h"
 #include "vc.h"
diff --git a/include/linux/power/omap/prcm44xx.h b/include/linux/power/omap/prcm44xx.h
new file mode 100644
index 0000000..4f58ed1
--- /dev/null
+++ b/include/linux/power/omap/prcm44xx.h
@@ -0,0 +1,53 @@
+/*
+ * OMAP4 PRCM definitions
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains macros and functions that are common to all of
+ * the PRM/CM/PRCM blocks on the OMAP4 devices: PRM, CM1, CM2,
+ * PRCM_MPU, SCRM
+ */
+
+#ifndef __LINUX_POWER_OMAP_PRCM44XX_H
+#define __LINUX_POWER_OMAP_PRCM44XX_H
+
+/*
+ * OMAP4 PRCM partition IDs
+ *
+ * The numbers and order are arbitrary, but 0 is reserved for the
+ * 'invalid' partition in case someone forgets to add a
+ * .prcm_partition field.
+ */
+#define OMAP4430_INVALID_PRCM_PARTITION		0
+#define OMAP4430_PRM_PARTITION			1
+#define OMAP4430_CM1_PARTITION			2
+#define OMAP4430_CM2_PARTITION			3
+#define OMAP4430_SCRM_PARTITION			4
+#define OMAP4430_PRCM_MPU_PARTITION		5
+
+#define OMAP54XX_PRM_PARTITION			1
+#define OMAP54XX_CM_CORE_AON_PARTITION		2
+#define OMAP54XX_CM_CORE_PARTITION		3
+#define OMAP54XX_SCRM_PARTITION			4
+#define OMAP54XX_PRCM_MPU_PARTITION		5
+
+#define DRA7XX_PRM_PARTITION                   1
+#define DRA7XX_CM_CORE_AON_PARTITION           2
+#define DRA7XX_CM_CORE_PARTITION               3
+#define DRA7XX_MPU_PRCM_PARTITION              5
+
+/*
+ * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
+ * IDs, plus one
+ */
+#define OMAP4_MAX_PRCM_PARTITIONS		6
+
+
+#endif
-- 
1.7.9.5

