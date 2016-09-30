From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: Call pm_runtime from musb_gadget_queue
Date: Fri, 30 Sep 2016 11:10:10 -0700
Message-ID: <20160930181010.3829-3-tony@atomide.com>
References: <20160930181010.3829-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160930181010.3829-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If we're booting pandaboard using NFSroot over built-in g_ether, we
can get the following after booting once and doing a warm reset:

g_ether gadget: ecm_open
g_ether gadget: notify connect true
...
WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147
l3_interrupt_handler+0x220/0x34c
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read):
Data Access in User mode du ring Functional access
...

Fix the issue by calling pm_runtime functions from
musb_gadget_queue.

Note that in the long run we should be able to queue the pending
transfers if pm_runtime is not active, and flush the queue from
pm_runtime_resume.

Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1255,6 +1255,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 
 	map_dma_buffer(request, musb, musb_ep);
 
+	pm_runtime_get_sync(musb->controller);
 	spin_lock_irqsave(&musb->lock, lockflags);
 
 	/* don't queue if the ep is down */
@@ -1275,6 +1276,9 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 
 unlock:
 	spin_unlock_irqrestore(&musb->lock, lockflags);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
+
 	return status;
 }
 
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
