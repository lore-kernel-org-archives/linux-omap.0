From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RFC] [PATCH 6/7] usb: ehci: Introduce CONFIG_USB_EHCI_HCD_OMAP3
Date: Thu, 19 Aug 2010 05:19:36 +0530
Message-ID: <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab0HSLtT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Aug 2010 07:49:19 -0400
In-Reply-To: <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Introduce the CONFIG_USB_EHCI_HCD_OMAP3 option to select
EHCI support on OMAP3 and later chips. This scales better
than having a long line of dependencies for each new OMAP
with EHCI support.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/Kconfig    |    8 ++++++++
 drivers/usb/host/ehci-hcd.c |    2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/usb/host/ehci-hcd.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-hcd.c
+++ linux-2.6/drivers/usb/host/ehci-hcd.c
@@ -1157,7 +1157,7 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
+#ifdef CONFIG_USB_EHCI_HCD_OMAP3
 #include "ehci-omap.c"
 #define        PLATFORM_DRIVER         ehci_hcd_omap_driver
 #endif
Index: linux-2.6/drivers/usb/host/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/host/Kconfig
+++ linux-2.6/drivers/usb/host/Kconfig
@@ -126,6 +126,14 @@ config USB_EHCI_MXC
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_HCD_OMAP3
+	bool "EHCI support for OMAP3 and later chips"
+	depends on USB_EHCI_HCD && (ARCH_OMAP3 || ARCH_OMAP4)
+	default y
+	--- help ---
+	  Enables support for the on-chip EHCI controller on
+	  OMAP3 and later chips.
+
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
 	depends on USB_EHCI_HCD && PPC_OF
