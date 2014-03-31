From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 20/55] ARM: OMAP3+: PRCM: remove references to cm-regbits-34xx.h from PRCM core code
Date: Mon, 31 Mar 2014 18:15:59 +0300
Message-ID: <1396278994-12624-21-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaCaPRz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:55 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make PRCM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c             |    6 +++++-
 arch/arm/mach-omap2/cm3xxx.c             |    8 +++++++-
 arch/arm/mach-omap2/cminst44xx.c         |    6 +++++-
 arch/arm/mach-omap2/powerdomain-common.c |    1 -
 arch/arm/mach-omap2/prm3xxx.c            |    7 ++++++-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 728ac3f..c7be4e4 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -25,7 +25,6 @@
 #include "clockdomain.h"
 #include "cm.h"
 #include "cm33xx.h"
-#include "cm-regbits-34xx.h"
 #include "prm33xx.h"
 
 #define AM33XX_MODULEMODE_SHIFT			0
@@ -36,6 +35,11 @@
 #define AM33XX_IDLEST_SHIFT			16
 #define AM33XX_IDLEST_MASK			(0x3 << 16)
 
+#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
+#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
+#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
+
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
  *
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 989590e..859c2fd 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -22,9 +22,15 @@
 #include "cm.h"
 #include "cm2xxx_3xxx_private.h"
 #include "cm3xxx.h"
-#include "cm-regbits-34xx.h"
 #include "clockdomain.h"
 
+#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
+#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
+#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
+
+#define OMAP3430_AUTO_PERIPH_DPLL_MASK		(0x7 << 3)
+
 static const u8 omap3xxx_cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
 };
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index c2712d3..58e01c7 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -27,7 +27,6 @@
 #include "cm2_44xx.h"
 #include "cm44xx.h"
 #include "cminst44xx.h"
-#include "cm-regbits-34xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
@@ -40,6 +39,11 @@
 #define OMAP4430_MODULEMODE_SHIFT	0
 #define OMAP4430_MODULEMODE_MASK	(0x3 << 0)
 
+#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO	0x0
+#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP	0x1
+#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP	0x2
+#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO	0x3
+
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
  *
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index c40e5f0..2c62cd9 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -16,7 +16,6 @@
 #include <linux/bug.h>
 #include "pm.h"
 #include "cm.h"
-#include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 8ae209a..852bc4d 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -24,7 +24,6 @@
 #include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx_private.h"
 #include "cm3xxx.h"
-#include "cm-regbits-34xx.h"
 
 #define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
 #define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
@@ -79,6 +78,12 @@
 #define OMAP3430_LASTPOWERSTATEENTERED_MASK		(0x3 << 0)
 #define OMAP3430_LOGICSTATEST_MASK			(1 << 2)
 
+#define OMAP3430ES2_EN_USBHOST2_SHIFT			1
+
+#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK		(1 << 0)
+
+#define OMAP3430_CLKACTIVITY_IVA2_MASK			(1 << 0)
+
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
 	OMAP_PRCM_IRQ("io",	9,	1),
-- 
1.7.9.5

