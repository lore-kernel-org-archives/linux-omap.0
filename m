From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/8] usb: ehci: introduce CONFIG_USB_EHCI_HCD_OMAP
Date: Mon, 29 Nov 2010 22:55:32 +0530
Message-ID: <1291051537-23743-4-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Introduce the CONFIG_USB_EHCI_HCD_OMAP option to select
EHCI support on OMAP3 and later chips. This scales better
than having a long line of dependencies for each new OMAP
with EHCI support.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/Kconfig    |    8 ++++++++
 drivers/usb/host/ehci-hcd.c |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6f4f8e6..7c1f843 100644
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
index 502a7e6..1c80441 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
