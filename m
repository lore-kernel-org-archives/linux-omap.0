From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/52] musb_hdrc: Search and replace bEnd0Stage with
	ep0_stage
Date: Mon, 13 Aug 2007 06:48:51 -0700
Message-ID: <1187013007355-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130052666-git-send-email-tony@atomide.com>
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

Search and replace bEnd0Stage with ep0_stage

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   20 ++++++++++----------
 drivers/usb/musb/musbdefs.h  |    2 +-
 drivers/usb/musb/plat_uds.c  |    4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -189,7 +189,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		/* control transfers always start with SETUP */
 		is_in = 0;
 		hw_ep->out_qh = qh;
-		musb->bEnd0Stage = MGC_END0_START;
+		musb->ep0_stage = MGC_END0_START;
 		pBuffer = urb->setup_packet;
 		dwLength = 8;
 		break;
@@ -952,7 +952,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 	struct musb_qh		*qh = hw_ep->in_qh;
 	struct usb_ctrlrequest	*pRequest;
 
-	switch (musb->bEnd0Stage) {
+	switch (musb->ep0_stage) {
 	case MGC_END0_IN:
 		pFifoDest = pUrb->transfer_buffer + pUrb->actual_length;
 		fifo_count = min(len, ((u16) (pUrb->transfer_buffer_length
@@ -979,12 +979,12 @@ static int musb_h_ep0_continue(struct musb *musb,
 			break;
 		} else if (pRequest->bRequestType & USB_DIR_IN) {
 			DBG(4, "start IN-DATA\n");
-			musb->bEnd0Stage = MGC_END0_IN;
+			musb->ep0_stage = MGC_END0_IN;
 			bMore = TRUE;
 			break;
 		} else {
 			DBG(4, "start OUT-DATA\n");
-			musb->bEnd0Stage = MGC_END0_OUT;
+			musb->ep0_stage = MGC_END0_OUT;
 			bMore = TRUE;
 		}
 		/* FALLTHROUGH */
@@ -1005,7 +1005,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 		}
 		break;
 	default:
-		ERR("bogus ep0 stage %d\n", musb->bEnd0Stage);
+		ERR("bogus ep0 stage %d\n", musb->ep0_stage);
 		break;
 	}
 
@@ -1040,10 +1040,10 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 			: 0;
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
-		wCsrVal, qh, len, pUrb, musb->bEnd0Stage);
+		wCsrVal, qh, len, pUrb, musb->ep0_stage);
 
 	/* if we just did status stage, we are done */
-	if (MGC_END0_STATUS == musb->bEnd0Stage) {
+	if (MGC_END0_STATUS == musb->ep0_stage) {
 		retval = IRQ_HANDLED;
 		bComplete = TRUE;
 	}
@@ -1114,7 +1114,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		/* call common logic and prepare response */
 		if (musb_h_ep0_continue(musb, len, pUrb)) {
 			/* more packets required */
-			wCsrVal = (MGC_END0_IN == musb->bEnd0Stage)
+			wCsrVal = (MGC_END0_IN == musb->ep0_stage)
 				?  MGC_M_CSR0_H_REQPKT : MGC_M_CSR0_TXPKTRDY;
 		} else {
 			/* data transfer complete; perform status phase */
@@ -1127,7 +1127,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 					| MGC_M_CSR0_TXPKTRDY;
 
 			/* flag status stage */
-			musb->bEnd0Stage = MGC_END0_STATUS;
+			musb->ep0_stage = MGC_END0_STATUS;
 
 			DBG(5, "ep0 STATUS, csr %04x\n", wCsrVal);
 
@@ -1135,7 +1135,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 		retval = IRQ_HANDLED;
 	} else
-		musb->bEnd0Stage = MGC_END0_IDLE;
+		musb->ep0_stage = MGC_END0_IDLE;
 
 	/* call completion handler if done */
 	if (bComplete)
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -355,7 +355,7 @@ struct musb {
 	u32			port1_status;
 	unsigned long		rh_timer;
 
-	enum musb_h_ep0_state	bEnd0Stage;
+	enum musb_h_ep0_state	ep0_stage;
 
 	/* bulk traffic normally dedicates endpoint hardware, and each
 	 * direction has its own ring of host side endpoints.
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -467,7 +467,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		 * a_wait_vrise_tmout triggers VBUS_ERROR transitions
 		 */
 		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
-		musb->bEnd0Stage = MGC_END0_START;
+		musb->ep0_stage = MGC_END0_START;
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
 		musb_set_vbus(musb, 1);
@@ -550,7 +550,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		musb->is_active = 1;
 		set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
-		musb->bEnd0Stage = MGC_END0_START;
+		musb->ep0_stage = MGC_END0_START;
 
 #ifdef CONFIG_USB_MUSB_OTG
 		/* flush endpoints when transitioning from Device Mode */
-- 
1.5.2.3
