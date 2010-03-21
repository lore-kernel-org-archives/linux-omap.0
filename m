From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH RFC 3/5] usb: ohci: Add Kconfig entries for ohci-omap3
Date: Sun, 21 Mar 2010 17:02:01 +0530
Message-ID: <1269171123-9874-4-git-send-email-gadiyar@ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0CULcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Mar 2010 07:32:09 -0400
In-Reply-To: <1269171123-9874-3-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

On OMAP systems, we have two different of OHCI controllers. The legacy
one is present in OMAP1/2 chips, and the newer one comes bundled as
a companion to the EHCI controller on OMAP3 and newer chips.

We may have multi-omap configurations where OMAP2 and OMAP3
support may be enabled in the same kernel, and need a mechanism
to keep both drivers around.

This patch adds a Kconfig entry for each of these drivers.
I've only tested the omap3_defconfig on omap3 boards, and
don't have any old omap1/omap2 boards around.

I'd like feedback on the approach used here, as I'm not sure
if this is a good way to go.

NYET-Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/Kconfig    |   15 +++++++++++++++
 drivers/usb/host/ohci-hcd.c |   31 +++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
+++ linux-2.6/drivers/usb/host/ohci-hcd.c
@@ -1006,9 +1006,14 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_s3c2410_driver
 #endif
 
-#ifdef CONFIG_ARCH_OMAP
+#ifdef CONFIG_USB_OHCI_HCD_OMAP1
 #include "ohci-omap.c"
-#define PLATFORM_DRIVER		ohci_hcd_omap_driver
+#define OMAP1_PLATFORM_DRIVER	ohci_hcd_omap_driver
+#endif
+
+#ifdef CONFIG_USB_OHCI_HCD_OMAP3
+#include "ohci-omap3.c"
+#define OMAP3_PLATFORM_DRIVER	ohci_hcd_omap3_driver
 #endif
 
 #ifdef CONFIG_ARCH_LH7A404
@@ -1092,6 +1097,8 @@ MODULE_LICENSE ("GPL");
 
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
+	!defined(OMAP1_PLATFORM_DRIVER) &&	\
+	!defined(OMAP3_PLATFORM_DRIVER) &&	\
 	!defined(OF_PLATFORM_DRIVER) &&	\
 	!defined(SA1111_DRIVER) &&	\
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
@@ -1133,6 +1140,18 @@ static int __init ohci_hcd_mod_init(void
 		goto error_platform;
 #endif
 
+#ifdef OMAP1_PLATFORM_DRIVER
+	retval = platform_driver_register(&OMAP1_PLATFORM_DRIVER);
+	if (retval < 0)
+		goto error_omap1_platform;
+#endif
+
+#ifdef OMAP3_PLATFORM_DRIVER
+	retval = platform_driver_register(&OMAP3_PLATFORM_DRIVER);
+	if (retval < 0)
+		goto error_omap3_platform;
+#endif
+
 #ifdef OF_PLATFORM_DRIVER
 	retval = of_register_platform_driver(&OF_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1200,6 +1219,14 @@ static int __init ohci_hcd_mod_init(void
 	platform_driver_unregister(&PLATFORM_DRIVER);
  error_platform:
 #endif
+#ifdef OMAP1_PLATFORM_DRIVER
+	platform_driver_unregister(&OMAP1_PLATFORM_DRIVER);
+ error_omap1_platform:
+#endif
+#ifdef OMAP3_PLATFORM_DRIVER
+	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
+ error_omap3_platform:
+#endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
 	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
  error_ps3:
Index: linux-2.6/drivers/usb/host/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/host/Kconfig
+++ linux-2.6/drivers/usb/host/Kconfig
@@ -207,6 +207,21 @@ config USB_OHCI_HCD
 	  To compile this driver as a module, choose M here: the
 	  module will be called ohci-hcd.
 
+config USB_OHCI_HCD_OMAP1
+	bool "OHCI support for OMAP1/2 chips"
+	depends on USB_OHCI_HCD && (ARCH_OMAP1 || ARCH_OMAP2)
+	default y
+	---help---
+	  Enables support for the OHCI controller on OMAP1/2 chips.
+
+config USB_OHCI_HCD_OMAP3
+	bool "OHCI support for OMAP3 and later chips"
+	depends on USB_OHCI_HCD && (ARCH_OMAP3 || ARCH_OMAP4)
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  OMAP3 and later chips.
+
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
 	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
