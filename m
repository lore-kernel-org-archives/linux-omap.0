From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2] OMAP1: Amstrad Delta: always build with FIQ handler linked in
Date: Fri, 5 Nov 2010 01:33:20 +0100
Message-ID: <201011050133.22180.jkrzyszt@tis.icnet.pl>
References: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:33542 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab0KEAds (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 20:33:48 -0400
In-Reply-To: <201011050126.01426.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Since there were no problem reports regarding the Amstrad Delta FIQ handler 
introduced in 2.6.35, we can now build and initalize it by default. The config 
option used for selecting it can now be dropped.

This change was requested by Tony Lindgren, the OMAP subsystem maintainer.

Created and tested against linux-2.6.37-rc1.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 arch/arm/mach-omap1/Kconfig           |   11 +----------
 arch/arm/mach-omap1/Makefile          |    4 ++--
 arch/arm/mach-omap1/board-ams-delta.c |    2 --
 3 files changed, 3 insertions(+), 14 deletions(-)

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
