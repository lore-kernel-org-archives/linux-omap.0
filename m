From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] musb: fixes vbus off issue after disconnect
Date: Thu, 30 Oct 2008 14:43:08 +0530
Message-ID: <1225357988-10985-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Vbus is switched off (after a_wait_bcon) whenever a device
is disconnected from musb host even when musb is configured
only as host.Earlier we use to switch on the power using
[echo "F" >/proc/driver/musb_hdrc] but now this proc entry is
deleted thus musb doesn't work after device disconnect.

This patch puts is_otg_enabled() check before scheduling
a switch-off timer in disconnect path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index dbf8861..6856da3 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -767,7 +767,7 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
 		case OTG_STATE_A_HOST:
 		case OTG_STATE_A_SUSPEND:
 			musb_root_disconnect(musb);
-			if (musb->a_wait_bcon != 0)
+			if (musb->a_wait_bcon != 0 && is_otg_enabled(musb))
 				musb_platform_try_idle(musb, jiffies
 					+ msecs_to_jiffies(musb->a_wait_bcon));
 			break;
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
