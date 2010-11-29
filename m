From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/4] arm: omap4: select USB_ARCH_HAS_EHCI
Date: Mon, 29 Nov 2010 22:56:11 +0530
Message-ID: <1291051572-24084-4-git-send-email-gadiyar@ti.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291051572-24084-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP4 has an on-chip EHCI controller. Select USB_ARCH_HAS_EHCI
to allow the EHCI driver to be built on OMAP4.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ab784bf..766727c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	select ARM_GIC
 	select PL310_ERRATA_588369
 	select ARM_ERRATA_720789
+	select USB_ARCH_HAS_EHCI
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
