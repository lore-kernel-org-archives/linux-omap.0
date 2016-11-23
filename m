From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: Fix trying to free already-free IRQ 4
Date: Wed, 23 Nov 2016 08:51:27 -0800
Message-ID: <20161123165127.1795-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

When unloading omap2430, we can get the following splat:

WARNING: CPU: 1 PID: 295 at kernel/irq/manage.c:1478 __free_irq+0xa8/0x2c8
Trying to free already-free IRQ 4
...
[<c01a8b78>] (free_irq) from [<bf0aea84>]
(musbhs_dma_controller_destroy+0x28/0xb0 [musb_hdrc])
[<bf0aea84>] (musbhs_dma_controller_destroy [musb_hdrc]) from
[<bf09f88c>] (musb_remove+0xf0/0x12c [musb_hdrc])
[<bf09f88c>] (musb_remove [musb_hdrc]) from [<c056a384>]
(platform_drv_remove+0x24/0x3c)
...

This is because the irq number in use is 260 nowadays, and the dma
controller is using u8 instead of int.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Found one more issue.. This has been around for years so can probably
wait until after v4.10-rc1. Probably should be tagged stable to avoid
multiple people debugging this over and over.

---
 drivers/usb/musb/musbhsdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -157,5 +157,5 @@ struct musb_dma_controller {
 	void __iomem			*base;
 	u8				channel_count;
 	u8				used_channels;
-	u8				irq;
+	int				irq;
 };
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
