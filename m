From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: otg: Fix build errors if USB_MUSB_OMAP2PLUS is selected as module
Date: Mon, 29 Oct 2012 16:44:46 +0200
Message-ID: <1351521886-24170-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

TWL4030_USB & TWL6030_USB must depend on USB_MUSB_OMAP2PLUS in Kconfig else
we get build errors with

CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_OMAP2PLUS=m
CONFIG_TWL4030_USB=y
CONFIG_TWL6030_USB=y

LD      init/built-in.o
drivers/built-in.o: In function `twl4030_usb_irq':
drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl4030_usb_phy_init':
drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'

drivers/built-in.o: In function `twl6030_usb_irq':
drivers/usb/otg/twl6030-usb.c:230: undefined reference to `omap_musb_mailbox'
drivers/usb/otg/twl6030-usb.c:225: undefined reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl6030_usbotg_irq':
drivers/usb/otg/twl6030-usb.c:259: undefined reference to `omap_musb_mailbox'

CC: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index d8c8a42..6223062 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
 
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL4030
@@ -68,7 +68,7 @@ config TWL4030_USB
 
 config TWL6030_USB
 	tristate "TWL6030 USB Transceiver Driver"
-	depends on TWL4030_CORE && OMAP_USB2
+	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL6030
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
