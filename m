From: Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
Subject: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Wed, 15 Mar 2017 15:08:01 +0100
Message-ID: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessio Igor Bogani <abogani-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With usb-musb port in host mode, when the device
is disconnected, either logically (because of a mode switch) or
physically (by pulling the cable), the USB port should keep
suppling VBUS, with no interruption, to prevent power loss on
USB powered devices.

Signed-off-by: Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 7c047c4..5d9986b 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -245,7 +245,7 @@ static int dsps_check_status(struct musb *musb, void *unused)
 		dsps_mod_timer_optional(glue);
 		break;
 	case OTG_STATE_A_WAIT_BCON:
-		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+		musb_writeb(musb->mregs, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
 		skip_session = 1;
 		/* fall */
 
-- 
2.10.1 (Apple Git-78)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
