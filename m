From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/9] OMAP clockdomain/powerdomain: remove
	CONFIG_OMAP_DEBUG_{CLOCK, POWER}DOMAIN
Date: Thu, 03 Dec 2009 06:45:33 -0700
Message-ID: <20091203134532.16229.49187.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbZLCNwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:22 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Avoid cluttering the Kconfig space with debug options that are rarely
used.  These can now be enabled and disabled by patching the "#undef DE=
BUG"
in the source files with "#define DEBUG", conforming to the practice fo=
r
the rest of the linux-omap code.

Also, while we're here, some lines in plat-omap/Kconfig use sets of
leading spaces when those lines should start with tabs.  Convert most
of them to use tabs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 +---
 arch/arm/mach-omap2/powerdomain.c |    4 +-
 arch/arm/plat-omap/Kconfig        |   62 ++++++++++++-----------------=
--------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
index fcd8232..1a45ed1 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -2,7 +2,7 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=C3=B6gander
  *
@@ -10,9 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifdef CONFIG_OMAP_DEBUG_CLOCKDOMAIN
-#  define DEBUG
-#endif
+#undef DEBUG
=20
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index b6990e3..9708f12 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -10,9 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifdef CONFIG_OMAP_DEBUG_POWERDOMAIN
-# define DEBUG
-#endif
+#undef DEBUG
=20
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..b6edaf6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -42,28 +42,6 @@ config OMAP_DEBUG_LEDS
 	depends on OMAP_DEBUG_DEVICES
 	default y if LEDS || LEDS_OMAP_DEBUG
=20
-config OMAP_DEBUG_POWERDOMAIN
-	bool "Emit debug messages from powerdomain layer"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
-	help
-	  Say Y here if you want to compile in powerdomain layer
-	  debugging messages for OMAP2/3.   These messages can
-	  provide more detail as to why some powerdomain calls
-	  may be failing, and will also emit a descriptive message
-	  for every powerdomain register write.  However, the
-	  extra detail costs some memory.
-
-config OMAP_DEBUG_CLOCKDOMAIN
-	bool "Emit debug messages from clockdomain layer"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
-	help
-	  Say Y here if you want to compile in clockdomain layer
-	  debugging messages for OMAP2/3.   These messages can
-	  provide more detail as to why some clockdomain calls
-	  may be failing, and will also emit a descriptive message
-	  for every clockdomain register write.  However, the
-	  extra detail costs some memory.
-
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
@@ -78,28 +56,28 @@ config OMAP_RESET_CLOCKS
=20
 config OMAP_MUX
 	bool "OMAP multiplexing support"
-        depends on ARCH_OMAP
+	depends on ARCH_OMAP
 	default y
-        help
-          Pin multiplexing support for OMAP boards. If your bootloader
-          sets the multiplexing correctly, say N. Otherwise, or if uns=
ure,
-          say Y.
+	help
+	  Pin multiplexing support for OMAP boards. If your bootloader
+	  sets the multiplexing correctly, say N. Otherwise, or if unsure,
+	  say Y.
=20
 config OMAP_MUX_DEBUG
 	bool "Multiplexing debug output"
-        depends on OMAP_MUX
-        help
-          Makes the multiplexing functions print out a lot of debug in=
fo.
-          This is useful if you want to find out the correct values of=
 the
-          multiplexing registers.
+	depends on OMAP_MUX
+	help
+	  Makes the multiplexing functions print out a lot of debug info.
+	  This is useful if you want to find out the correct values of the
+	  multiplexing registers.
=20
 config OMAP_MUX_WARNINGS
 	bool "Warn about pins the bootloader didn't set up"
-        depends on OMAP_MUX
-        default y
-        help
+	depends on OMAP_MUX
+	default y
+	help
 	  Choose Y here to warn whenever driver initialization logic needs
-	  to change the pin multiplexing setup.  When there are no warnings
+	  to change the pin multiplexing setup.	 When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
=20
 config OMAP_MCBSP
@@ -125,7 +103,7 @@ config OMAP_IOMMU_DEBUG
 	tristate
=20
 choice
-        prompt "System timer"
+	prompt "System timer"
 	default OMAP_MPU_TIMER
=20
 config OMAP_MPU_TIMER
@@ -148,11 +126,11 @@ config OMAP_32K_TIMER
 endchoice
=20
 config OMAP_32K_TIMER_HZ
-       int "Kernel internal timer frequency for 32KHz timer"
-       range 32 1024
-       depends on OMAP_32K_TIMER
-       default "128"
-       help
+	int "Kernel internal timer frequency for 32KHz timer"
+	range 32 1024
+	depends on OMAP_32K_TIMER
+	default "128"
+	help
 	  Kernel internal timer frequency should be a divisor of 32768,
 	  such as 64 or 128.
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
