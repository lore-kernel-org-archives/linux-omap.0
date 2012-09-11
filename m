From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/17] ARM: OMAP1: Move SoC specific headers from plat to
 mach for omap1
Date: Mon, 10 Sep 2012 22:31:24 -0700
Message-ID: <20120911053124.29637.99172.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48191 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754776Ab2IKFb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:28 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org

There's no need to have these in plat-omap any longer. Note that these
could eventually be made local to mach-omap1 instead of being in mach.

But to do that, at least various driver access using omap7xxx.h registers
needs to be fixed first.

Cc: spi-devel-general@lists.sourceforge.net
Cc: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-htcherald.c       |    2 +-
 arch/arm/mach-omap1/devices.c               |    2 +-
 arch/arm/mach-omap1/include/mach/hardware.h |    6 +++---
 arch/arm/mach-omap1/include/mach/omap1510.h |    3 +--
 arch/arm/mach-omap1/include/mach/omap16xx.h |    3 +--
 arch/arm/mach-omap1/include/mach/omap7xx.h  |    3 +--
 drivers/spi/spi-omap-uwire.c                |    3 ++-
 7 files changed, 10 insertions(+), 12 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap1510.h => mach-omap1/include/mach/omap1510.h} (97%)
 rename arch/arm/{plat-omap/include/plat/omap16xx.h => mach-omap1/include/mach/omap16xx.h} (99%)
 rename arch/arm/{plat-omap/include/plat/omap7xx.h => mach-omap1/include/mach/omap7xx.h} (98%)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index b9771b5..a5ac352 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -41,7 +41,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/omap7xx.h>
+#include <mach/omap7xx.h>
 #include <plat/keypad.h>
 #include <plat/mmc.h>
 
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1feca35..05fdbd9 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -23,8 +23,8 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
-#include <plat/omap7xx.h>
 
+#include <mach/omap7xx.h>
 #include <mach/camera.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index bd3b95e..84248d2 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -311,8 +311,8 @@ static inline u32 omap_cs3_phys(void)
  * ---------------------------------------------------------------------------
  */
 
-#include <plat/omap7xx.h>
-#include <plat/omap1510.h>
-#include <plat/omap16xx.h>
+#include "omap7xx.h"
+#include "omap1510.h"
+#include "omap16xx.h"
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/omap1510.h b/arch/arm/mach-omap1/include/mach/omap1510.h
similarity index 97%
rename from arch/arm/plat-omap/include/plat/omap1510.h
rename to arch/arm/mach-omap1/include/mach/omap1510.h
index d240046..8fe05d6 100644
--- a/arch/arm/plat-omap/include/plat/omap1510.h
+++ b/arch/arm/mach-omap1/include/mach/omap1510.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap1510.h
- *
+/*
  * Hardware definitions for TI OMAP1510 processor.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme@de.bosch.com>
diff --git a/arch/arm/plat-omap/include/plat/omap16xx.h b/arch/arm/mach-omap1/include/mach/omap16xx.h
similarity index 99%
rename from arch/arm/plat-omap/include/plat/omap16xx.h
rename to arch/arm/mach-omap1/include/mach/omap16xx.h
index e69e1d8..cd1c724 100644
--- a/arch/arm/plat-omap/include/plat/omap16xx.h
+++ b/arch/arm/mach-omap1/include/mach/omap16xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap16xx.h
- *
+/*
  * Hardware definitions for TI OMAP1610/5912/1710 processors.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme@de.bosch.com>
diff --git a/arch/arm/plat-omap/include/plat/omap7xx.h b/arch/arm/mach-omap1/include/mach/omap7xx.h
similarity index 98%
rename from arch/arm/plat-omap/include/plat/omap7xx.h
rename to arch/arm/mach-omap1/include/mach/omap7xx.h
index 48e4757..63da994 100644
--- a/arch/arm/plat-omap/include/plat/omap7xx.h
+++ b/arch/arm/mach-omap1/include/mach/omap7xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap7xx.h
- *
+/*
  * Hardware definitions for TI OMAP7XX processor.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme@de.bosch.com>
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 9b0d716..a3996a1 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -53,7 +53,8 @@
 #include <asm/mach-types.h>
 
 #include <plat/mux.h>
-#include <plat/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
+
+#include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
 
 
 /* FIXME address is now a platform device resource,

