From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 14:14:12 +0200
Message-ID: <4094934.StqYY08vL5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63357 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbbEUMOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 08:14:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> to making omap1 support multiarch. After this series we still need to
> make omap1 use the common clock framework and fix up the drivers to not
> rely on includes from mach and plat directories.
> 
> Note that this branch depends on a GPIO driver fix in v4.1-rc3
> d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> 

fwiw, I have another patch in my 'multiplatform' series that will add
another baby step.

8<---
ARM: OMAP1: make header files local if possible

A number of header files in mach-omap1 are never included from outside
of mach-omap1, so we can move them directly to that directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index a95499ea8706..9fc70978823b 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -41,7 +41,7 @@
 
 #include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
-#include <mach/camera.h>
+#include "camera.h"
 #include <mach/usb.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0fb51d22c8b5..fad95b74bb65 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -29,7 +29,7 @@
 
 #include <mach/tc.h>
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 8340d684d8b6..cd146ed0538d 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -42,7 +42,7 @@
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 086ff34e072b..f7c8c63dd532 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -44,7 +44,7 @@
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <linux/omap-dma.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index ed4e045c2ad8..ae90bd02b3bf 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 0efd165b8227..209aecb0df68 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -46,7 +46,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <mach/tc.h>
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 1142ae431fe0..e5288cda1a6a 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <linux/omap-dma.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 54a547a96950..d672495f7441 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 87ec04ae40dd..aaf741b0aff6 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -36,7 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3d76f05407f0..150b57ba42bf 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -30,7 +30,7 @@
 
 #include <mach/tc.h>
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 4fcf19c78a08..a9373570bbb1 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <mach/board-sx1.h>
+#include "board-sx1.h"
 
 #include "mmc.h"
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 939991ea33d5..6c482254b37c 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -34,11 +34,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
-#include <mach/board-sx1.h>
+#include "board-sx1.h"
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/include/mach/board-sx1.h b/arch/arm/mach-omap1/board-sx1.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/board-sx1.h
rename to arch/arm/mach-omap1/board-sx1.h
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index e960687d0cb1..2c01147a27f9 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -32,8 +32,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-voiceblue.h>
-#include <mach/flash.h>
+#include "board-voiceblue.h"
+#include "flash.h"
 #include <mach/mux.h>
 #include <mach/tc.h>
 
diff --git a/arch/arm/mach-omap1/include/mach/board-voiceblue.h b/arch/arm/mach-omap1/board-voiceblue.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/board-voiceblue.h
rename to arch/arm/mach-omap1/board-voiceblue.h
diff --git a/arch/arm/mach-omap1/include/mach/camera.h b/arch/arm/mach-omap1/camera.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/camera.h
rename to arch/arm/mach-omap1/camera.h
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 325e6030095e..263c07a566cb 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -25,7 +25,7 @@
 #include <mach/mux.h>
 
 #include <mach/omap7xx.h>
-#include <mach/camera.h>
+#include "camera.h"
 #include <mach/hardware.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index b3fb531af94e..99cda402e1e2 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -11,7 +11,7 @@
 #include <linux/mtd/map.h>
 
 #include <mach/tc.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/include/mach/flash.h b/arch/arm/mach-omap1/flash.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/flash.h
rename to arch/arm/mach-omap1/flash.h

