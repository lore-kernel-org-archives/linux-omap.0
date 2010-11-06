From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2] OMAP1: drop AMS_DELTA_FIQ config option
Date: Sat, 6 Nov 2010 02:55:58 +0100
Message-ID: <201011060256.00485.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56906 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab0KFB5p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:57:45 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

This patches removes a config option that was used to select a FIQ 
handler to be build for Amstrad Delta, as required by the on-board serio 
interface driver. Not having any problem reports received since it was 
introduced in 2.6.35, the FIQ handler can now be built and initialized by 
default, thus reqiring no extra config option.

This change was requested by Tony Lindgren, the OMAP subsystem maintainer.

Created and tested against linux-2.6.37-rc1

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v1 -> v2 changes:
- it does not make sense to split into 2 patches, fold together - requested by 
  Dmitry Torokhov - thanks.

 arch/arm/mach-omap1/Kconfig           |   11 +----------
 arch/arm/mach-omap1/Makefile          |    4 ++--
 arch/arm/mach-omap1/board-ams-delta.c |    2 --
 drivers/input/serio/Kconfig           |    1 -
 4 files changed, 3 insertions(+), 15 deletions(-)

--- linux-2.6.37-rc1/arch/arm/mach-omap1/board-ams-delta.c.orig	2010-11-01 22:41:04.000000000 +0100
+++ linux-2.6.37-rc1/arch/arm/mach-omap1/board-ams-delta.c	2010-11-04 21:25:33.000000000 +0100
@@ -307,9 +307,7 @@ static void __init ams_delta_init(void)
 #endif
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
-#ifdef CONFIG_AMS_DELTA_FIQ
 	ams_delta_init_fiq();
-#endif
 
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
 }
--- linux-2.6.37-rc1/arch/arm/mach-omap1/Makefile.orig	2010-11-01 22:41:04.000000000 +0100
+++ linux-2.6.37-rc1/arch/arm/mach-omap1/Makefile	2010-11-04 21:27:45.000000000 +0100
@@ -39,8 +39,8 @@ obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board
 obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
 obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
-obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
-obj-$(CONFIG_AMS_DELTA_FIQ)		+= ams-delta-fiq.o ams-delta-fiq-handler.o
+obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o ams-delta-fiq.o \
+					   ams-delta-fiq-handler.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
 obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
 
--- linux-2.6.37-rc1/arch/arm/mach-omap1/Kconfig.orig	2010-11-01 22:41:04.000000000 +0100
+++ linux-2.6.37-rc1/arch/arm/mach-omap1/Kconfig	2010-11-04 21:28:06.000000000 +0100
@@ -152,20 +152,11 @@ config MACH_NOKIA770
 config MACH_AMS_DELTA
 	bool "Amstrad E3 (Delta)"
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
+	select FIQ
 	help
 	  Support for the Amstrad E3 (codename Delta) videophone. Say Y here
 	  if you have such a device.
 
-config AMS_DELTA_FIQ
-	bool "Fast Interrupt Request (FIQ) support for the E3"
-	depends on MACH_AMS_DELTA
-	select FIQ
-	help
-	  Provide a FIQ handler for the E3.
-	  This allows for fast handling of interrupts generated
-	  by the clock line of the E3 mailboard (or a PS/2 keyboard)
-	  connected to the GPIO based external keyboard port.
-
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
--- linux-2.6.37-rc1/drivers/input/serio/Kconfig.orig	2010-11-01 22:41:51.000000000 +0100
+++ linux-2.6.37-rc1/drivers/input/serio/Kconfig	2010-11-04 21:28:55.000000000 +0100
@@ -214,7 +214,6 @@ config SERIO_AMS_DELTA
 	tristate "Amstrad Delta (E3) mailboard support"
 	depends on MACH_AMS_DELTA
 	default y
-	select AMS_DELTA_FIQ
 	---help---
 	  Say Y here if you have an E3 and want to use its mailboard,
 	  or any standard AT keyboard connected to the mailboard port.
