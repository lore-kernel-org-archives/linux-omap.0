From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] usb: otg: OMAP4430: Powerdown the internal PHY when USB is disabled
Date: Thu, 24 Mar 2011 16:36:33 +0530
Message-ID: <1300964793-6833-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Powerdown the internal UTMI PHY when USB is not enabled. This will
allow the OMAP core domain to transition to retention and offmode.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-musb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 35559f7..500d9db 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -169,5 +169,7 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 #else
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
+	if (cpu_is_omap44xx())
+		omap4430_phy_init(NULL);
 }
 #endif /* CONFIG_USB_MUSB_SOC */
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
