From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/19] omap: Rename mmc-twl4030 files to hsmmc
Date: Thu, 11 Feb 2010 16:51:13 -0800
Message-ID: <20100212005113.24958.14769.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51115 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0BLAuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:32 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

mmc-twl4030.[ch] no longer has any dependency on twl4030
and should be renamed to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile                 |   28 +++++++++++++-------------
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/hsmmc.c                  |    4 ++--
 arch/arm/mach-omap2/hsmmc.h                  |    0 
 15 files changed, 28 insertions(+), 28 deletions(-)
 rename arch/arm/mach-omap2/{mmc-twl4030.c => hsmmc.c} (98%)
 rename arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index af5853f..dfc49a0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -87,43 +87,43 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
-					   mmc-twl4030.o \
+					   hsmmc.o \
 					   board-sdp-flash.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
 					   board-rx51-peripherals.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o \
+					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o \
+					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 18497b7..a43c094 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,7 +38,7 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
 
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2e38e5b..6c7261b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -45,7 +45,7 @@
 
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 65c96bc..58f6683 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -46,7 +46,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define CM_T35_GPIO_PENDOWN	57
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 9f75433..ea7bfba 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,7 +30,7 @@
 #include <plat/usb.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f169967..f2b47cb 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -44,7 +44,7 @@
 #include <plat/usb.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index bf91bf7..7812da0 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -45,7 +45,7 @@
 #include <plat/timer-gp.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index fde27cf..3087be2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -44,7 +44,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index bc482ab..6343703 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -43,7 +43,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OMAP3_PANDORA_TS_GPIO		94
 
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 63436e9..1e3f53c 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -50,7 +50,7 @@
 #include <plat/timer-gp.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #include <asm/setup.h>
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 61abe09..3fc918b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -48,7 +48,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index acafdbc..b2de206 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -34,7 +34,7 @@
 #include <plat/gpmc-smc91x.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 1e3dfb6..52940a4 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,7 +24,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/hsmmc.c
similarity index 98%
rename from arch/arm/mach-omap2/mmc-twl4030.c
rename to arch/arm/mach-omap2/hsmmc.c
index 6f8f29e..df1cf72 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/mmc-twl4030.c
+ * linux/arch/arm/mach-omap2/hsmmc.c
  *
  * Copyright (C) 2007-2008 Texas Instruments
  * Copyright (C) 2008 Nokia Corporation
@@ -17,7 +17,7 @@
 #include <plat/control.h>
 #include <plat/mmc.h>
 
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/hsmmc.h
similarity index 100%
rename from arch/arm/mach-omap2/mmc-twl4030.h
rename to arch/arm/mach-omap2/hsmmc.h

