From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP: Remove unnecessary mach and plat includes
Date: Thu, 01 Nov 2012 15:48:20 -0700
Message-ID: <20121101224820.2103.72431.stgit@muffinssi.local>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28284 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762306Ab2KAWsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 18:48:23 -0400
In-Reply-To: <20121101224703.2103.95474.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Now mach/hardware.h is empty for omap2+ and can be
removed except for plat-omap/dmtimer.c for omap1.

Also the include of mach/irqs.h can now be removed
for shared plat-omap/i2c.c as it's no longer needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 -
 arch/arm/mach-omap2/board-cm-t35.c  |    2 --
 arch/arm/mach-omap2/hsmmc.c         |    1 -
 arch/arm/plat-omap/debug-devices.c  |    1 -
 arch/arm/plat-omap/dmtimer.c        |    4 +---
 arch/arm/plat-omap/fb.c             |    1 -
 arch/arm/plat-omap/i2c.c            |    2 --
 7 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 3fc6d83..d1c0162 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -28,7 +28,6 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index cf9449b..a8cad22 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -44,8 +44,6 @@
 #include <video/omap-panel-tfp410.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
-#include <mach/hardware.h>
-
 #include "common.h"
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index e3406dc..4a96433 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <mach/hardware.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index b49be51..a609e21 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <plat/debug-devices.h>
 
 /* Many OMAP development platforms reuse the same "debug board"; these
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9a0bbc4..82231a7 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,8 +43,6 @@
 
 #include <plat/dmtimer.h>
 
-#include <mach/hardware.h>
-
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
@@ -270,7 +268,7 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
 #if defined(CONFIG_ARCH_OMAP1)
-
+#include <mach/hardware.h>
 /**
  * omap_dm_timer_modify_idlect_mask - Check if any running timers use ARMXOR
  * @inputmask: current value of idlect mask
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index f868cae..3a77b30 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -30,7 +30,6 @@
 #include <linux/io.h>
 #include <linux/omapfb.h>
 
-#include <mach/hardware.h>
 #include <asm/mach/map.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 4645dd4..f9df624 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -33,8 +33,6 @@
 
 #include <plat/i2c.h>
 
-#include <mach/irqs.h>
-
 #define OMAP_I2C_MAX_CONTROLLERS 4
 static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 

