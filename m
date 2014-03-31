From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/55] ARM: OMAP2+: PRCM: cleanup some header includes
Date: Mon, 31 Mar 2014 18:15:41 +0300
Message-ID: <1396278994-12624-3-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbaCaPRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:23 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Some of the includes are totally unnecessary, remove some others in
preparation to make the PRCM its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.h                  |    3 ++-
 arch/arm/mach-omap2/cm33xx.h                       |    3 ---
 arch/arm/mach-omap2/cm44xx.c                       |    2 --
 arch/arm/mach-omap2/cm_common.c                    |    1 -
 arch/arm/mach-omap2/cminst44xx.c                   |    2 --
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    1 +
 arch/arm/mach-omap2/powerdomain.c                  |    1 +
 arch/arm/mach-omap2/powerdomain.h                  |    3 +--
 arch/arm/mach-omap2/prcm-common.h                  |    2 ++
 arch/arm/mach-omap2/prcm_mpu44xx.h                 |    1 -
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    1 -
 arch/arm/mach-omap2/prm33xx.c                      |    1 -
 12 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f17f006..82c37b1 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -18,7 +18,6 @@
 
 #include "powerdomain.h"
 #include "clock.h"
-#include "omap_hwmod.h"
 
 /*
  * Clockdomain flags
@@ -98,6 +97,8 @@ struct clkdm_dep {
 /* Possible flags for struct clockdomain._flags */
 #define _CLKDM_FLAG_HWSUP_ENABLED		BIT(0)
 
+struct omap_hwmod;
+
 /**
  * struct clockdomain - OMAP clockdomain
  * @name: clockdomain name
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index cfb8891..15a778c 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,11 +17,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include "common.h"
-
 #include "cm.h"
 #include "cm-regbits-33xx.h"
-#include "iomap.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 5627072..37ba6e8 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -18,8 +18,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "iomap.h"
-#include "common.h"
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 40b3b5a..9e2482a 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -18,7 +18,6 @@
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm44xx.h"
-#include "common.h"
 
 /*
  * cm_ll_data: function pointers to SoC-specific implementations of
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 731ca13..d27d2bd 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -21,8 +21,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "iomap.h"
-#include "common.h"
 #include "clockdomain.h"
 #include "cm.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 0f17862..a579b89 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -24,6 +24,7 @@
 #include "prm33xx.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
+#include "common.h"
 
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
 #define RSTCTRL(oh, rstctrl) ((oh).prcm.omap4.rstctrl_offs = (rstctrl))
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 93a2a6e..faebd5f 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -32,6 +32,7 @@
 
 #include "powerdomain.h"
 #include "clockdomain.h"
+#include "voltage.h"
 
 #include "soc.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index da5a59a..f472711 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -21,8 +21,6 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
-#include "voltage.h"
-
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
@@ -75,6 +73,7 @@
 
 struct clockdomain;
 struct powerdomain;
+struct voltagedomain;
 
 /**
  * struct powerdomain - OMAP powerdomain
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index e982598..ee2384a 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -428,6 +428,8 @@
 #define MAX_IOPAD_LATCH_TIME			100
 # ifndef __ASSEMBLER__
 
+#include <linux/delay.h>
+
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 059bd4f..ac9cb45 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -26,7 +26,6 @@
 #define __ARCH_ARM_MACH_OMAP2_PRCM_MPU44XX_H
 
 #include "prcm_mpu_44xx_54xx.h"
-#include "common.h"
 
 #define OMAP4430_PRCM_MPU_BASE			0x48243000
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 5209823..d891499 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -16,7 +16,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include "powerdomain.h"
 #include "prm2xxx_3xxx_private.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 7204407..0660105 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include "powerdomain.h"
 #include "prm33xx.h"
 #include "prm-regbits-33xx.h"
-- 
1.7.9.5

