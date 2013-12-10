From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] phy: omap_usb2: fix module dependency
Date: Tue, 10 Dec 2013 14:24:57 -0600
Message-ID: <1386707097-25650-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Due to over-use of select statements, we could
fall into a situation where CONFIG_USB_PHY would
be enabled while CONFIG_USB_SUPPORT wouldn't.

This would generate a situation where usb_bind_phy()
would not be defined and kernel build for some
OMAP2PLUS platforms would fail.

Fix this by replacing a 'select' with a more proper
'depends on'.

Reported-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a344f3d..d8b1a9a 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -24,9 +24,9 @@ config PHY_EXYNOS_MIPI_VIDEO
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
+	depends on OMAP_CONTROL_USB
 	select GENERIC_PHY
 	select USB_PHY
-	select OMAP_CONTROL_USB
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
-- 
1.8.4.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
