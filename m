From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] musb_hdrc: Build usb-musb based on config entry,
	clean-up Makefile
Date: Thu, 12 Feb 2009 11:17:19 -0800
Message-ID: <20090212191719.19766.24459.stgit@localhost>
References: <20090212191408.19766.62874.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60047 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400AbZBLTRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:17:25 -0500
In-Reply-To: <20090212191408.19766.62874.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

Build usb-musb based on config entry, clean-up Makefile

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile          |   17 ++++++-----------
 arch/arm/mach-omap2/usb-musb.c        |    7 -------
 arch/arm/plat-omap/include/mach/usb.h |    7 +++++++
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 631166d..fad8af4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,27 +44,24 @@ obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   mmc-twl4030.o \
-					   usb-musb.o \
 					   usb-ehci.o
 obj-$(CONFIG_MACH_OMAP2EVM)		+= board-omap2evm.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   mmc-twl4030.o \
-					   usb-musb.o \
 					   usb-ehci.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   mmc-twl4030.o \
-					   usb-musb.o usb-ehci.o \
+					   usb-ehci.o \
 					   board-omap3evm-flash.o \
 					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   usb-musb.o usb-ehci.o \
+					   usb-ehci.o \
 					   mmc-twl4030.o \
 					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
-					   mmc-twl4030.o \
-					   usb-musb.o
+					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
@@ -80,19 +77,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
 					   board-rx51-video.o \
 					   board-rx51-peripherals.o \
-					   mmc-twl4030.o \
-					   usb-musb.o
+					   mmc-twl4030.o
 
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o \
-					   usb-musb.o \
 					   usb-ehci.o \
 					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o \
-					   usb-musb.o \
 					   usb-ehci.o
 
-# TUSB 6010 chips
+# Platform specific device init code
+obj-$(CONFIG_USB_MUSB_SOC)		+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 897c07d..327af7d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -33,7 +33,6 @@
 #include <mach/mux.h>
 #include <mach/usb.h>
 
-#ifdef CONFIG_USB_MUSB_SOC
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
@@ -146,13 +145,9 @@ static struct platform_device musb_device = {
 	.num_resources	= ARRAY_SIZE(musb_resources),
 	.resource	= musb_resources,
 };
-#endif
-
 
 void __init usb_musb_init(void)
 {
-#ifdef CONFIG_USB_MUSB_SOC
-
 	if (cpu_is_omap243x()) {
 		musb_resources[0].start = OMAP243X_HS_BASE;
 		musb_plat.clock = "usbhs_ick";
@@ -167,6 +162,4 @@ void __init usb_musb_init(void)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
 	}
-#endif
 }
-
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index 7d7b2b0..e69c5ad 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -27,7 +27,14 @@
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
+#ifdef CONFIG_USB_MUSB_SOC
 extern void usb_musb_init(void);
+#else
+static inline void usb_musb_init(void)
+{
+}
+#endif
+
 extern void usb_ehci_init(void);
 
 #endif

