From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] usb otg: TWL4030_USB depends on USB_MUSB_OMAP2PLUS in Kconfig
Date: Thu, 23 Aug 2012 22:38:44 +0200
Message-ID: <1345754324-12068-1-git-send-email-pmeerw@pmeerw.net>
References: <20120820113624.GP17455@arwen.pp.htv.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120820113624.GP17455-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
---
 drivers/usb/otg/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 13fd1ddf..fefca18 100644
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
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
