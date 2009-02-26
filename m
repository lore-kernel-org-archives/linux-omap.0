From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/13] ARM: OMAP: No need to include board-h3.h from hardware.h
Date: Thu, 26 Feb 2009 15:56:08 -0800
Message-ID: <20090226235608.20192.53441.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51582 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBZX4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:56:12 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Also move board-h3.h to mach-omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h3-mmc.c         |    2 ++
 arch/arm/mach-omap1/board-h3.c             |    5 +++++
 arch/arm/mach-omap1/board-h3.h             |    5 +----
 arch/arm/plat-omap/include/mach/hardware.h |    4 ----
 4 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm/{plat-omap/include/mach/board-h3.h => mach-omap1/board-h3.h} (90%)

diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index fdfe793..0d8a3c1 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -19,6 +19,8 @@
 #include <mach/mmc.h>
 #include <mach/gpio.h>
 
+#include "board-h3.h"
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index bf08b6a..4b872f3 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -50,6 +50,11 @@
 #include <mach/dma.h>
 #include <mach/common.h>
 
+#include "board-h3.h"
+
+/* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
+#define OMAP1710_ETHR_START		0x04000300
+
 #define H3_TS_GPIO	48
 
 static int h3_keymap[] = {
diff --git a/arch/arm/plat-omap/include/mach/board-h3.h b/arch/arm/mach-omap1/board-h3.h
similarity index 90%
rename from arch/arm/plat-omap/include/mach/board-h3.h
rename to arch/arm/mach-omap1/board-h3.h
index 1888326..78de535 100644
--- a/arch/arm/plat-omap/include/mach/board-h3.h
+++ b/arch/arm/mach-omap1/board-h3.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-h3.h
+ * arch/arm/mach-omap1/board-h3.h
  *
  * Copyright (C) 2001 RidgeRun, Inc.
  * Copyright (C) 2004 Texas Instruments, Inc.
@@ -27,9 +27,6 @@
 #ifndef __ASM_ARCH_OMAP_H3_H
 #define __ASM_ARCH_OMAP_H3_H
 
-/* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
-#define OMAP1710_ETHR_START		0x04000300
-
 #define H3_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
 #	define H3_TPS_GPIO_MMC_PWR_EN	(H3_TPS_GPIO_BASE + 4)
 
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index ac4d8d0..040244c 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -298,10 +298,6 @@
 #include "board-innovator.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_H3
-#include "board-h3.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP_H4
 #include "board-h4.h"
 #endif

