From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] musb: Remove unwanted message in boot log
Date: Tue,  3 Nov 2009 12:05:40 +0530
Message-ID: <1257230140-12958-2-git-send-email-ajay.gupta@ti.com>
References: <1257230140-12958-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1257230140-12958-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Removes below unnecessary log of almost 28 lines during boot.

musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, max 512
musb_hdrc: hw_ep 1rx, max 512
...
...
musb_hdrc: hw_ep 13shared, max 4096
musb_hdrc: hw_ep 14shared, max 1024
musb_hdrc: hw_ep 15shared, max 1024

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index ec67ec7..0005dea 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1454,7 +1454,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 #endif
 
 		if (hw_ep->max_packet_sz_tx) {
-			printk(KERN_DEBUG
+			DBG(1,
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				hw_ep->is_shared_fifo ? "shared" : "tx",
@@ -1463,7 +1463,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 				hw_ep->max_packet_sz_tx);
 		}
 		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
-			printk(KERN_DEBUG
+			DBG(1,
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				"rx",
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
