From: ajay.gupta-l0cyMroinI0@public.gmane.org
Subject: [PATCH] OMAP:MUSB: Fixes the TT programming.
Date: Fri, 22 Aug 2008 11:43:33 +0530
Message-ID: <1219385613-20108-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Fixes enumeration failures when a USB device attached to a LS hub is connected to OMAP EVM via HS hub. This is fixed by correctly programming hub address register in enqueue path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_host.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 52ac02a..90d3733 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1869,7 +1869,11 @@ static int musb_urb_enqueue(
 			/* set up tt info if needed */
 			if (urb->dev->tt) {
 				qh->h_port_reg = (u8) urb->dev->ttport;
-				qh->h_addr_reg |= 0x80;
+				if (urb->dev->tt->hub)
+					qh->h_addr_reg =
+						(u8) urb->dev->tt->hub->devnum;
+				if (urb->dev->tt->multi)
+					qh->h_addr_reg |= 0x80;
 			}
 		}
 	}
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
