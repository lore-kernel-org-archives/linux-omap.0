From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH, RESEND] usb: musb: fix Kconfig regression
Date: Sat, 28 Feb 2015 00:19:41 +0100
Message-ID: <2671702.mSdaGStNT3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sre-GFxCN5SEZAc@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

A recent bug fix I did that was marked for stable backports
introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.

I was missing the fact that the PHY driver already stubs out the
omap_control_usb_set_mode, and we only need to add a dependency
to prevent the musb-omap2430 driver from being built-in when
the phy driver is a loadable module, but we should not prevent it
from being built altogether when the phy driver is disabled.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: ca784be36cc725 ("usb: start using the control module driver")
Acked-by: Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.9+
---
Same patch as first time, now with correct recipient and with Pavel's
Ack added.

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 14e1628483d9..39db8b603627 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -79,7 +79,8 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS && USB && OMAP_CONTROL_PHY
+	depends on ARCH_OMAP2PLUS && USB
+	depends on OMAP_CONTROL_PHY || !OMAP_CONTROL_PHY
 	select GENERIC_PHY
 
 config USB_MUSB_AM35X

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
