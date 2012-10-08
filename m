From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c to be
 OMAP2+ only for now
Date: Mon, 8 Oct 2012 01:46:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54179 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2JHBqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 21:46:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, grinberg@compulab.co.il


Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
debug_card_init() function") results in the following new sparse[1]
warning:

arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?

Normally this could be fixed by including the appropriate header file
in plat-omap/debug-devices.c, but the header file now exists only in
mach-omap2/, so this would require a "sideways include" and is thus
impractical.  It turns out that only code in mach-omap2/ currently
uses the debug-devices.c and debug-leds.c files, so move them there.
In the long term, these devices should be created by DT, and the code
should be moved into drivers/ somewhere.

While doing this migration, improve the Kconfig help text and fix
some checkpatch/CodingStyle issues.

...

1. https://sparse.wiki.kernel.org/index.php/Main_Page

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap2/Kconfig                        |   13 +++++++++++++
 arch/arm/mach-omap2/Makefile                       |    6 ++++++
 arch/arm/{plat-omap => mach-omap2}/debug-devices.c |    7 +++++--
 arch/arm/{plat-omap => mach-omap2}/debug-leds.c    |    7 ++-----
 arch/arm/plat-omap/Kconfig                         |    9 ---------
 arch/arm/plat-omap/Makefile                        |    2 --
 6 files changed, 26 insertions(+), 18 deletions(-)
 rename arch/arm/{plat-omap => mach-omap2}/debug-devices.c (93%)
 rename arch/arm/{plat-omap => mach-omap2}/debug-leds.c (96%)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a6219ea..3ba2d5f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -370,6 +370,19 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config OMAP_DEBUG_DEVICES
+	bool
+	help
+	  Partial support for some peripherals on some debug daughtercards
+	  that can be attached to some older TI reference boards.
+
+config OMAP_DEBUG_LEDS
+	def_bool y if NEW_LEDS
+	depends on OMAP_DEBUG_DEVICES
+	help
+	  Enables the use of some debugging LEDs that are present on the
+	  debug daughtercards on some older TI reference boards.
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fe40d9e..12fc983 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -280,3 +280,9 @@ emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
 obj-y					+= $(emac-m) $(emac-y)
 
 obj-y					+= common-board-devices.o twl-common.o
+
+
+# Debug devices available on some TI board daughtercards -- optional
+
+obj-$(CONFIG_OMAP_DEBUG_DEVICES)	+= debug-devices.o
+obj-$(CONFIG_OMAP_DEBUG_LEDS)		+= debug-leds.o
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/mach-omap2/debug-devices.c
similarity index 93%
rename from arch/arm/plat-omap/debug-devices.c
rename to arch/arm/mach-omap2/debug-devices.c
index c7a4c09..00407af1 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/mach-omap2/debug-devices.c
@@ -17,7 +17,10 @@
 
 #include <mach/hardware.h>
 
-/* Many OMAP development platforms reuse the same "debug board"; these
+#include "debug-devices.h"
+
+/*
+ * Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
  */
 
@@ -80,7 +83,7 @@ int __init debug_card_init(u32 addr, unsigned gpio)
 
 	status = gpio_request(gpio, "SMC91x irq");
 	if (status < 0) {
-		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
+		pr_err("GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;
 	}
 	gpio_direction_input(gpio);
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/mach-omap2/debug-leds.c
similarity index 96%
rename from arch/arm/plat-omap/debug-leds.c
rename to arch/arm/mach-omap2/debug-leds.c
index ea29bbe..c12350b 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/mach-omap2/debug-leds.c
@@ -146,11 +146,8 @@ static struct platform_driver led_driver = {
 
 static int __init fpga_init(void)
 {
-	if (machine_is_omap_h4()
-			|| machine_is_omap_h3()
-			|| machine_is_omap_h2()
-			|| machine_is_omap_perseus2()
-			)
+	if (machine_is_omap_h4() || machine_is_omap_h3() ||
+	    machine_is_omap_h2() || machine_is_omap_perseus2())
 		return platform_driver_register(&led_driver);
 	return 0;
 }
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ca83a76..4ae003f 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -36,15 +36,6 @@ endchoice
 
 comment "OMAP Feature Selections"
 
-config OMAP_DEBUG_DEVICES
-	bool
-	help
-	  For debug cards on TI reference boards.
-
-config OMAP_DEBUG_LEDS
-	def_bool y if NEW_LEDS
-	depends on OMAP_DEBUG_DEVICES
-
 config POWER_AVS_OMAP
 	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
 	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index dacaee0..f8fc0f9 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -12,8 +12,6 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
-obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
-obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
 obj-y += $(i2c-omap-m) $(i2c-omap-y)
 
-- 
1.7.10.4

