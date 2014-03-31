From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 15/55] ARM: AM33xx: CM: remove references to cm-regbits-33xx.h from CM core code
Date: Mon, 31 Mar 2014 18:15:54 +0300
Message-ID: <1396278994-12624-16-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39097 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbaCaPRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:40 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make CM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c |    9 ++++++++-
 arch/arm/mach-omap2/cm33xx.h |    1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 40a22e5..728ac3f 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -26,9 +26,16 @@
 #include "cm.h"
 #include "cm33xx.h"
 #include "cm-regbits-34xx.h"
-#include "cm-regbits-33xx.h"
 #include "prm33xx.h"
 
+#define AM33XX_MODULEMODE_SHIFT			0
+#define AM33XX_MODULEMODE_MASK			(0x3 << 0)
+
+#define AM33XX_CLKTRCTRL_SHIFT			0
+#define AM33XX_CLKTRCTRL_MASK			(0x3 << 0)
+#define AM33XX_IDLEST_SHIFT			16
+#define AM33XX_IDLEST_MASK			(0x3 << 16)
+
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
  *
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 15a778c..8f9e479 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -18,7 +18,6 @@
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
 #include "cm.h"
-#include "cm-regbits-33xx.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
-- 
1.7.9.5

