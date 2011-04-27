From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: musb: omap2430: Fix retention idle on musb peripheral only boards
Date: Wed, 27 Apr 2011 17:02:37 +0300
Message-ID: <1303912957-10279-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Recent runtime pm and hwmod conversions for 2.6.39 broke the musb peripheral
mode OMAP retention idle on boards where the board mode in struct
musb_hdrc_platform_data is set to MUSB_PERIPHERAL.

These conversions changed the way how the OTG_SYSCONFIG register is
configured and used in runtime. Before 2.6.39 smart standby/idle modes were
activated statically in OTG_SYSCONFIG. Those modes allow that the musb is
able to idle when peripheral device is not connected to host.

In 2.6.39 the OTG_SYSCONFIG is updated runtime depending on VBUS status.
No standby/idle modes are used when device is connected and force
standby/idle when disconnected.

Unfortunately VBUS disconnect event that handles the disconnect case lets
the peripheral musb to idle only when board mode is MUSB_OTG. Fix this by
checking the peripheral mode also.

Signed-off-by: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
For 2.6.39 as this fixes the PM regression on those OMAP3 boards that use
musb in peripheral mode only.
---
 drivers/usb/musb/omap2430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 57a27fa..e9e60b6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -270,7 +270,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		DBG(4, "VBUS Disconnect\n");
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
-		if (is_otg_enabled(musb))
+		if (is_otg_enabled(musb) || is_peripheral_enabled(musb))
 			if (musb->gadget_driver)
 #endif
 			{
-- 
1.7.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
