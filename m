From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 20/29] ARM: OMAP1: Move flash.h from plat to mach
Date: Wed, 19 Sep 2012 14:06:22 -0700
Message-ID: <20120919210622.28074.79557.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26440 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:23 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is only used by omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c      |    2 +-
 arch/arm/mach-omap1/board-h2.c           |    2 +-
 arch/arm/mach-omap1/board-h3.c           |    2 +-
 arch/arm/mach-omap1/board-innovator.c    |    2 +-
 arch/arm/mach-omap1/board-osk.c          |    2 +-
 arch/arm/mach-omap1/board-palmte.c       |    2 +-
 arch/arm/mach-omap1/board-palmtt.c       |    2 +-
 arch/arm/mach-omap1/board-palmz71.c      |    2 +-
 arch/arm/mach-omap1/board-perseus2.c     |    2 +-
 arch/arm/mach-omap1/board-sx1.c          |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c    |    2 +-
 arch/arm/mach-omap1/flash.c              |    2 +-
 arch/arm/mach-omap1/include/mach/flash.h |    0 
 13 files changed, 12 insertions(+), 12 deletions(-)
 rename arch/arm/{plat-omap/include/plat/flash.h => mach-omap1/include/mach/flash.h} (100%)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 81c41cc..228e4ca 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -29,7 +29,7 @@
 
 #include <plat/tc.h>
 #include <mach/mux.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <plat/fpga.h>
 #include <mach/keypad.h>
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index ce99021..166f90c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -43,7 +43,7 @@
 #include <plat/tc.h>
 #include <plat/irda.h>
 #include <mach/keypad.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 76411dd..6c44bb4 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -44,7 +44,7 @@
 #include <plat/tc.h>
 #include <mach/keypad.h>
 #include <plat/dma.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2469811..3ed0d87 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <plat/fpga.h>
 #include <plat/tc.h>
 #include <mach/keypad.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index eda3890..8d00068 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -46,7 +46,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 58ef785..cbe17fa 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 7ab487c..5df8672 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/led.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 4ce3278..b087ba0 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -36,7 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index deb0b00..3f485ce 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -30,7 +30,7 @@
 #include <plat/tc.h>
 #include <mach/mux.h>
 #include <plat/fpga.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/keypad.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index e5edabf..87637e7 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -33,7 +33,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/irda.h>
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 64289ea..ad75e34 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/board-voiceblue.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
 
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 401eb3c..73ae616 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -11,7 +11,7 @@
 #include <linux/mtd/map.h>
 
 #include <plat/tc.h>
-#include <plat/flash.h>
+#include <mach/flash.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/plat-omap/include/plat/flash.h b/arch/arm/mach-omap1/include/mach/flash.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/flash.h
rename to arch/arm/mach-omap1/include/mach/flash.h

