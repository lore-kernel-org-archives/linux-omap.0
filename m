From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+ 01/11] musb: fix power field to hold all possible values
Date: Wed, 24 Mar 2010 13:47:49 +0200
Message-ID: <1269431279-22438-2-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
the 'power' field has to hold values above 255.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 568578d..876ca8d 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -46,7 +46,7 @@ struct ehci_hcd_omap_platform_data {
 struct omap_musb_board_data {
 	u8	interface_type;
 	u8	mode;
-	u8	power;
+	u16	power;
 };
 
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
-- 
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
