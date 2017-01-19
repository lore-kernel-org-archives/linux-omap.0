From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: Tiny dma in transfers won't complete with cpp41
Date: Wed, 18 Jan 2017 16:49:18 -0800
Message-ID: <20170119004918.9986-3-tony@atomide.com>
References: <20170119004918.9986-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119004918.9986-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

At least with the cppi41 dma, size 1 in dma transfers will just wait
until the device is disconnected. And it also seems that enumerating
a USB stick with a hub can take a USB reset with smallish size in
transfers.

This causes timeouts in cppi41 dma runtime PM.

Fix the issue by adding a minimum size of 16 which is based on my
obeservations on BeagleBone to make enumerating more reliable.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -743,7 +743,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 	musb_ep_select(mbase, epnum);
 
-	if (is_out && !len) {
+	/*
+	 * Skip dma for zero sized out and small in transfers.
+	 * At least cppi41 in dma will just hang with size of 1 until the
+	 * device is connected. For sizes 8 and less it seems to take a
+	 * long time to complete. Let's use minimum size of 16 to avoid
+	 * tiny in DMA transfers.
+	 */
+	if ((is_out && !len) || (!is_out && (len < 16))) {
 		use_dma = 0;
 		csr = musb_readw(epio, MUSB_TXCSR);
 		csr &= ~MUSB_TXCSR_DMAENAB;
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
