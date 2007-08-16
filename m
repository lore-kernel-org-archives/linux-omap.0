From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 34/36] musb_hdrc: Search and replace bComplete with complete
Date: Thu, 16 Aug 2007 02:40:57 -0700
Message-ID: <11872573381837-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
	<118725733255-git-send-email-tony@atomide.com>
	<1187257334140-git-send-email-tony@atomide.com>
	<11872573361440-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573361440-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace bComplete with complete

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 29fc80d..933e292 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1027,7 +1027,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
-	u8			bComplete = FALSE;
+	u8			complete = FALSE;
 	irqreturn_t		retval = IRQ_NONE;
 
 	/* ep0 only has one queue, "in" */
@@ -1045,7 +1045,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	/* if we just did status stage, we are done */
 	if (MGC_END0_STATUS == musb->ep0_stage) {
 		retval = IRQ_HANDLED;
-		bComplete = TRUE;
+		complete = TRUE;
 	}
 
 	/* prepare status */
@@ -1076,7 +1076,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		retval = IRQ_HANDLED;
 		if (urb)
 			urb->status = status;
-		bComplete = TRUE;
+		complete = TRUE;
 
 		/* use the proper sequence to abort the transfer */
 		if (csr & MUSB_CSR0_H_REQPKT) {
@@ -1110,7 +1110,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		goto done;
 	}
 
-	if (!bComplete) {
+	if (!complete) {
 		/* call common logic and prepare response */
 		if (musb_h_ep0_continue(musb, len, urb)) {
 			/* more packets required */
@@ -1138,7 +1138,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		musb->ep0_stage = MGC_END0_IDLE;
 
 	/* call completion handler if done */
-	if (bComplete)
+	if (complete)
 		musb_advance_schedule(musb, urb, hw_ep, 1);
 done:
 	return retval;
-- 
1.5.2.3
