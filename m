From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] MUSB: Fixes endpoint allocation logic
Date: Tue,  7 Oct 2008 15:06:30 +0530
Message-ID: <1223372190-8050-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

musb->periodic[] flag was getting set for an endpoint even when only rx
or tx is used.This patch adds two field musb->in[16] and musb->out[16]
in place of musb->periodic[32] which will enable endpoint allocation
flag setting on rx/tx basis of an endpoint.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
This patch is reworked and is now a seperate patch. Earlier it was a
part of below patch,
[MUSB: BULK request on different available endpoints]
http://marc.info/?l=linux-usb&m=122335817727285&w=2

I will resend above patch [BULK request on different available endpoints]
which will be seperate and will not have fix for endpoint allocation logic.

 drivers/usb/musb/musb_core.h |    3 ++-
 drivers/usb/musb/musb_host.c |   13 ++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 8222725..b2d15a6 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -331,7 +331,8 @@ struct musb {
 	struct list_head	control;	/* of musb_qh */
 	struct list_head	in_bulk;	/* of musb_qh */
 	struct list_head	out_bulk;	/* of musb_qh */
-	struct musb_qh		*periodic[32];	/* tree of interrupt+iso */
+	struct musb_qh	*in[16];
+	struct musb_qh	*out[16];
 #endif
 
 	/* called with IRQs blocked; ON/nonzero implies starting a session,
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8b4be01..bb42ba6 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -385,7 +385,10 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 			 * de-allocated if it's tracked and allocated;
 			 * and where we'd update the schedule tree...
 			 */
-			musb->periodic[ep->epnum] = NULL;
+			if (is_in)
+				musb->in[ep->epnum] = NULL;
+			else
+				musb->out[ep->epnum] = NULL;
 			kfree(qh);
 			qh = NULL;
 			break;
@@ -1715,7 +1718,8 @@ static int musb_schedule(
 	for (epnum = 1; epnum < musb->nr_endpoints; epnum++) {
 		int	diff;
 
-		if (musb->periodic[epnum])
+		if ((is_in && musb->in[epnum]) ||
+			(!is_in && musb->out[epnum]))
 			continue;
 		hw_ep = &musb->endpoints[epnum];
 		if (hw_ep == musb->bulk_ep)
@@ -1736,7 +1740,10 @@ static int musb_schedule(
 
 	idle = 1;
 	hw_ep = musb->endpoints + best_end;
-	musb->periodic[best_end] = qh;
+	if (is_in)
+		musb->in[best_end] = qh;
+	else
+		musb->out[best_end] = qh;
 	DBG(4, "qh %p periodic slot %d\n", qh, best_end);
 success:
 	qh->hw_ep = hw_ep;
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
