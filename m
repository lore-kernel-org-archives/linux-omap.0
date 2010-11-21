From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 03/11] usb: ehci: introduce CONFIG_USB_EHCI_HCD_OMAP
Date: Mon, 22 Nov 2010 00:10:06 +0530
Message-ID: <1290364814-4417-4-git-send-email-gadiyar@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab0KUSk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Nov 2010 13:40:26 -0500
In-Reply-To: <1290364814-4417-3-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Keshava Munegowda <keshava_mgowda@ti.com>

Introduce the CONFIG_USB_EHCI_HCD_OMAP option to select
EHCI support on OMAP3 and later chips. This scales better
than having a long line of dependencies for each new OMAP
with EHCI support.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/Kconfig    |    8 ++++++++
 drivers/usb/host/ehci-hcd.c |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2391c39..6a7c688 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -133,6 +133,14 @@ config USB_EHCI_MXC
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_HCD_OMAP
+	bool "EHCI support for OMAP3 and later chips"
+	depends on USB_EHCI_HCD && ARCH_OMAP
+	default y
+	--- help ---
+	  Enables support for the on-chip EHCI controller on
+	  OMAP3 and later chips.
+
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
 	depends on USB_EHCI_HCD && PPC_OF
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 87157db..2f06ba4 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1171,7 +1171,7 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
+#ifdef CONFIG_USB_EHCI_HCD_OMAP
 #include "ehci-omap.c"
 #define        PLATFORM_DRIVER         ehci_hcd_omap_driver
 #endif
-- 
1.7.0.4

