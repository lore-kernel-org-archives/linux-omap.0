From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 25/55] ARM: OMAP4: CM: remove unnecessary cm44xx.h header file
Date: Mon, 31 Mar 2014 18:16:04 +0300
Message-ID: <1396278994-12624-26-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49842 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbaCaPSJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:09 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Contains only two defines used by a single source code file, so move the
definitions over and delete the file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.h      |   26 --------------------------
 arch/arm/mach-omap2/cm_common.c   |    3 ++-
 arch/arm/mach-omap2/cminst44xx.c  |    4 +++-
 arch/arm/mach-omap2/powerdomain.c |    1 -
 4 files changed, 5 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cm44xx.h

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
deleted file mode 100644
index 3380bee..0000000
--- a/arch/arm/mach-omap2/cm44xx.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * OMAP4 Clock Management (CM) definitions
- *
- * Copyright (C) 2007-2011 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
- *
- * Written by Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * OMAP4 has two separate CM blocks, CM1 and CM2.  This file contains
- * macros and function prototypes that are applicable to both.
- */
-#ifndef __ARCH_ASM_MACH_OMAP2_CM44XX_H
-#define __ARCH_ASM_MACH_OMAP2_CM44XX_H
-
-
-#include "prcm-common.h"
-#include "cm.h"
-
-#define OMAP4_CM_CLKSTCTRL				0x0000
-#define OMAP4_CM_STATICDEP				0x0004
-
-#endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index f8f9343..8655538 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -18,7 +18,8 @@
 
 #include <linux/power/omap/cm2xxx.h>
 #include <linux/power/omap/cm3xxx.h>
-#include "cm44xx.h"
+#include "cm.h"
+#include "prcm-common.h"
 
 /*
  * cm_ll_data: function pointers to SoC-specific implementations of
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 58e01c7..dfb1a93 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -25,7 +25,6 @@
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
-#include "cm44xx.h"
 #include "cminst44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
@@ -44,6 +43,9 @@
 #define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP	0x2
 #define OMAP34XX_CLKSTCTRL_ENABLE_AUTO	0x3
 
+#define OMAP4_CM_CLKSTCTRL		0x0000
+#define OMAP4_CM_STATICDEP		0x0004
+
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
  *
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index faebd5f..62649ba 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -24,7 +24,6 @@
 
 #include "cm2xxx_3xxx.h"
 #include "prcm44xx.h"
-#include "cm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 
-- 
1.7.9.5

