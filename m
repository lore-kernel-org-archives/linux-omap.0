From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] MUSB: Removes compilation warning in gadget mode
Date: Thu,  4 Sep 2008 16:04:45 +0530
Message-ID: <1220524485-8283-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes compilation warning when musb is configured in gadget mode.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 472c304..ea5c504 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -53,7 +53,9 @@ static void musb_do_idle(unsigned long _musb)
 {
 	struct musb	*musb = (void *)_musb;
 	unsigned long	flags;
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
 	u8	power;
+#endif
 	u8	devctl;
 
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
