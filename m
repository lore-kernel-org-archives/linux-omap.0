From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/13] ARM: OMAP: No need to include board-h2.h from hardware.h
Date: Thu, 26 Feb 2009 15:54:51 -0800
Message-ID: <20090226235451.20192.81270.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50863 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbZBZXyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:54:54 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Also move board-h2.h to mach-omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h2-mmc.c         |    2 ++
 arch/arm/mach-omap1/board-h2.c             |    5 +++++
 arch/arm/mach-omap1/board-h2.h             |    5 +----
 arch/arm/plat-omap/include/mach/hardware.h |    4 ----
 4 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm/{plat-omap/include/mach/board-h2.h => mach-omap1/board-h2.h} (90%)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 409fa56..44d4a96 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -19,6 +19,8 @@
 #include <mach/mmc.h>
 #include <mach/gpio.h>
 
+#include "board-h2.h"
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 0d784a7..b31b6d9 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -46,6 +46,11 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 
+#include "board-h2.h"
+
+/* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
+#define OMAP1610_ETHR_START		0x04000300
+
 static int h2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
diff --git a/arch/arm/plat-omap/include/mach/board-h2.h b/arch/arm/mach-omap1/board-h2.h
similarity index 90%
rename from arch/arm/plat-omap/include/mach/board-h2.h
rename to arch/arm/mach-omap1/board-h2.h
index 15531c8..315e266 100644
--- a/arch/arm/plat-omap/include/mach/board-h2.h
+++ b/arch/arm/mach-omap1/board-h2.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-h2.h
+ * arch/arm/mach-omap1/board-h2.h
  *
  * Hardware definitions for TI OMAP1610 H2 board.
  *
@@ -29,9 +29,6 @@
 #ifndef __ASM_ARCH_OMAP_H2_H
 #define __ASM_ARCH_OMAP_H2_H
 
-/* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
-#define OMAP1610_ETHR_START		0x04000300
-
 #define H2_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
 #	define H2_TPS_GPIO_MMC_PWR_EN	(H2_TPS_GPIO_BASE + 3)
 
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 5b59188..ac4d8d0 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -298,10 +298,6 @@
 #include "board-innovator.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_H2
-#include "board-h2.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP_H3
 #include "board-h3.h"
 #endif

