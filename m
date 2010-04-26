From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 3/3] usb: ohci: Add Kconfig entries for ohci-omap3
Date: Mon, 26 Apr 2010 10:04:49 +0530
Message-ID: <1272256489-3389-4-git-send-email-gadiyar@ti.com>
References: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
 <1272256489-3389-2-git-send-email-gadiyar@ti.com>
 <1272256489-3389-3-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272256489-3389-3-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On OMAP systems, we have two different OHCI controllers. The legacy
one is present in OMAP1/2 chips, and the newer one comes bundled as
a companion to the EHCI controller on OMAP3 and newer chips.

We may have multi-omap configurations where OMAP2 and OMAP3
support may be enabled in the same kernel, and need a mechanism
to keep both drivers around.

This patch adds a Kconfig entry for each of these drivers.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
I've only tested the omap3_defconfig on omap3 boards, and
don't have any old omap1/omap2 boards around.

I'd like feedback on the approach used here, as I'm not sure
if this scales well - maybe we need to revisit the way we do
this platform glue code in *-hcd.c.

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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
