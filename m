From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/11] arm: omap4: add USBHOST and related base addresses
Date: Mon, 22 Nov 2010 00:10:10 +0530
Message-ID: <1290364814-4417-8-git-send-email-gadiyar@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
 <1290364814-4417-6-git-send-email-gadiyar@ti.com>
 <1290364814-4417-7-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290364814-4417-7-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add base addresses for USBHOST, USBTLL, EHCI and OHCI to
the header file.

This will disappear when the drivers are converted to use
the hwmod database, however this patch is needed until then.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 8b3f12f..ea2b8a6 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,10 @@
 #define OMAP4_MMU1_BASE			0x55082000
 #define OMAP4_MMU2_BASE			0x4A066000
 
+#define OMAP44XX_USBTLL_BASE		(L4_44XX_BASE + 0x62000)
+#define OMAP44XX_UHH_CONFIG_BASE	(L4_44XX_BASE + 0x64000)
+#define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
+#define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
