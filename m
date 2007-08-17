From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] musb_hdrc: Search and replace MGC_END0 with MUSB_EP0
Date: Fri, 17 Aug 2007 04:44:38 -0700
Message-ID: <11873510862981-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <118735108469-git-send-email-tony@atomide.com>
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

Search and replace MGC_END0 with MUSB_EP0

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   76 ++++++++++++++++++++--------------------
 drivers/usb/musb/musb_gadget.c |    2 +-
 drivers/usb/musb/musb_host.c   |   20 +++++-----
 drivers/usb/musb/musbdefs.h    |   22 ++++++------
 drivers/usb/musb/plat_uds.c    |    4 +-
 5 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index 36473fb..e63e983 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -58,12 +58,12 @@
 static char *decode_ep0stage(u8 stage)
 {
 	switch(stage) {
-	case MGC_END0_STAGE_SETUP:	return "idle";
-	case MGC_END0_STAGE_TX:		return "in";
-	case MGC_END0_STAGE_RX:		return "out";
-	case MGC_END0_STAGE_ACKWAIT:	return "wait";
-	case MGC_END0_STAGE_STATUSIN:	return "in/status";
-	case MGC_END0_STAGE_STATUSOUT:	return "out/status";
+	case MUSB_EP0_STAGE_SETUP:	return "idle";
+	case MUSB_EP0_STAGE_TX:		return "in";
+	case MUSB_EP0_STAGE_RX:		return "out";
+	case MUSB_EP0_STAGE_ACKWAIT:	return "wait";
+	case MUSB_EP0_STAGE_STATUSIN:	return "in/status";
+	case MUSB_EP0_STAGE_STATUSOUT:	return "out/status";
 	default:			return "?";
 	}
 }
@@ -197,7 +197,7 @@ service_in_request(struct musb *musb,
  */
 static void musb_g_ep0_giveback(struct musb *musb, struct usb_request *req)
 {
-	musb->ep0_state = MGC_END0_STAGE_SETUP;
+	musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 	musb_g_giveback(&musb->endpoints[0].ep_in, req, 0);
 }
 
@@ -459,7 +459,7 @@ static void ep0_rxstate(struct musb *this)
 		req->actual += tmp;
 		tmp = MUSB_CSR0_P_SVDRXPKTRDY;
 		if (tmp < 64 || req->actual == req->length) {
-			this->ep0_state = MGC_END0_STAGE_STATUSIN;
+			this->ep0_state = MUSB_EP0_STAGE_STATUSIN;
 			tmp |= MUSB_CSR0_P_DATAEND;
 		} else
 			req = NULL;
@@ -506,7 +506,7 @@ static void ep0_txstate(struct musb *musb)
 	/* update the flags */
 	if (fifo_count < MUSB_MAX_END0_PACKET
 			|| request->actual == request->length) {
-		musb->ep0_state = MGC_END0_STAGE_STATUSOUT;
+		musb->ep0_state = MUSB_EP0_STAGE_STATUSOUT;
 		csr |= MUSB_CSR0_P_DATAEND;
 	} else
 		request = NULL;
@@ -565,16 +565,16 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 	if (req->wLength == 0) {
 		if (req->bRequestType & USB_DIR_IN)
 			musb->ackpend |= MUSB_CSR0_TXPKTRDY;
-		musb->ep0_state = MGC_END0_STAGE_ACKWAIT;
+		musb->ep0_state = MUSB_EP0_STAGE_ACKWAIT;
 	} else if (req->bRequestType & USB_DIR_IN) {
-		musb->ep0_state = MGC_END0_STAGE_TX;
+		musb->ep0_state = MUSB_EP0_STAGE_TX;
 		musb_writew(regs, MUSB_CSR0, MUSB_CSR0_P_SVDRXPKTRDY);
 		while ((musb_readw(regs, MUSB_CSR0)
 				& MUSB_CSR0_RXPKTRDY) != 0)
 			cpu_relax();
 		musb->ackpend = 0;
 	} else
-		musb->ep0_state = MGC_END0_STAGE_RX;
+		musb->ep0_state = MUSB_EP0_STAGE_RX;
 }
 
 static int
@@ -619,7 +619,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		musb_writew(regs, MUSB_CSR0,
 				csr & ~MUSB_CSR0_P_SENTSTALL);
 		retval = IRQ_HANDLED;
-		musb->ep0_state = MGC_END0_STAGE_SETUP;
+		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 		csr = musb_readw(regs, MUSB_CSR0);
 	}
 
@@ -627,7 +627,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	if (csr & MUSB_CSR0_P_SETUPEND) {
 		musb_writew(regs, MUSB_CSR0, MUSB_CSR0_P_SVDSETUPEND);
 		retval = IRQ_HANDLED;
-		musb->ep0_state = MGC_END0_STAGE_SETUP;
+		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 		csr = musb_readw(regs, MUSB_CSR0);
 		/* NOTE:  request may need completion */
 	}
@@ -638,7 +638,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	 */
 	switch (musb->ep0_state) {
 
-	case MGC_END0_STAGE_TX:
+	case MUSB_EP0_STAGE_TX:
 		/* irq on clearing txpktrdy */
 		if ((csr & MUSB_CSR0_TXPKTRDY) == 0) {
 			ep0_txstate(musb);
@@ -646,7 +646,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		}
 		break;
 
-	case MGC_END0_STAGE_RX:
+	case MUSB_EP0_STAGE_RX:
 		/* irq on set rxpktrdy */
 		if (csr & MUSB_CSR0_RXPKTRDY) {
 			ep0_rxstate(musb);
@@ -654,7 +654,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		}
 		break;
 
-	case MGC_END0_STAGE_STATUSIN:
+	case MUSB_EP0_STAGE_STATUSIN:
 		/* end of sequence #2 (OUT/RX state) or #3 (no data) */
 
 		/* update address (if needed) only @ the end of the
@@ -679,7 +679,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		}
 		/* FALLTHROUGH */
 
-	case MGC_END0_STAGE_STATUSOUT:
+	case MUSB_EP0_STAGE_STATUSOUT:
 		/* end of sequence #1: write to host (TX state) */
 		{
 			struct usb_request	*req;
@@ -689,10 +689,10 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 				musb_g_ep0_giveback(musb, req);
 		}
 		retval = IRQ_HANDLED;
-		musb->ep0_state = MGC_END0_STAGE_SETUP;
+		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 		/* FALLTHROUGH */
 
-	case MGC_END0_STAGE_SETUP:
+	case MUSB_EP0_STAGE_SETUP:
 		if (csr & MUSB_CSR0_RXPKTRDY) {
 			struct usb_ctrlrequest	setup;
 			int			handled = 0;
@@ -724,7 +724,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			 * device/endpoint feature set/clear operations)
 			 * plus SET_CONFIGURATION and others we must
 			 */
-			case MGC_END0_STAGE_ACKWAIT:
+			case MUSB_EP0_STAGE_ACKWAIT:
 				handled = service_zero_data_request(
 						musb, &setup);
 
@@ -732,7 +732,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 				if (handled > 0) {
 					musb->ackpend |= MUSB_CSR0_P_DATAEND;
 					musb->ep0_state =
-						MGC_END0_STAGE_STATUSIN;
+						MUSB_EP0_STAGE_STATUSIN;
 				}
 				break;
 
@@ -740,18 +740,18 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			 * requests that we can't forward, GET_DESCRIPTOR
 			 * and others that we must
 			 */
-			case MGC_END0_STAGE_TX:
+			case MUSB_EP0_STAGE_TX:
 				handled = service_in_request(musb, &setup);
 				if (handled > 0) {
 					musb->ackpend = MUSB_CSR0_TXPKTRDY
 						| MUSB_CSR0_P_DATAEND;
 					musb->ep0_state =
-						MGC_END0_STAGE_STATUSOUT;
+						MUSB_EP0_STAGE_STATUSOUT;
 				}
 				break;
 
 			/* sequence #2 (OUT from host), always forward */
-			default:		/* MGC_END0_STAGE_RX */
+			default:		/* MUSB_EP0_STAGE_RX */
 				break;
 			}
 
@@ -774,7 +774,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 stall:
 				DBG(3, "stall (%d)\n", handled);
 				musb->ackpend |= MUSB_CSR0_P_SENDSTALL;
-				musb->ep0_state = MGC_END0_STAGE_SETUP;
+				musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 finish:
 				musb_writew(regs, MUSB_CSR0,
 						musb->ackpend);
@@ -783,7 +783,7 @@ finish:
 		}
 		break;
 
-	case MGC_END0_STAGE_ACKWAIT:
+	case MUSB_EP0_STAGE_ACKWAIT:
 		/* This should not happen. But happens with tusb6010 with
 		 * g_file_storage and high speed. Do nothing.
 		 */
@@ -794,7 +794,7 @@ finish:
 		/* "can't happen" */
 		WARN_ON(1);
 		musb_writew(regs, MUSB_CSR0, MUSB_CSR0_P_SENDSTALL);
-		musb->ep0_state = MGC_END0_STAGE_SETUP;
+		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 		break;
 	}
 
@@ -846,9 +846,9 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	}
 
 	switch (musb->ep0_state) {
-	case MGC_END0_STAGE_RX:		/* control-OUT data */
-	case MGC_END0_STAGE_TX:		/* control-IN data */
-	case MGC_END0_STAGE_ACKWAIT:	/* zero-length data */
+	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
+	case MUSB_EP0_STAGE_TX:		/* control-IN data */
+	case MUSB_EP0_STAGE_ACKWAIT:	/* zero-length data */
 		status = 0;
 		break;
 	default:
@@ -868,15 +868,15 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	musb_ep_select(musb->mregs, 0);
 
 	/* sequence #1, IN ... start writing the data */
-	if (musb->ep0_state == MGC_END0_STAGE_TX)
+	if (musb->ep0_state == MUSB_EP0_STAGE_TX)
 		ep0_txstate(musb);
 
 	/* sequence #3, no-data ... issue IN status */
-	else if (musb->ep0_state == MGC_END0_STAGE_ACKWAIT) {
+	else if (musb->ep0_state == MUSB_EP0_STAGE_ACKWAIT) {
 		if (req->request.length)
 			status = -EINVAL;
 		else {
-			musb->ep0_state = MGC_END0_STAGE_STATUSIN;
+			musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
 			musb_writew(regs, MUSB_CSR0,
 					musb->ackpend | MUSB_CSR0_P_DATAEND);
 			musb->ackpend = 0;
@@ -929,16 +929,16 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	}
 
 	switch (musb->ep0_state) {
-	case MGC_END0_STAGE_TX:		/* control-IN data */
-	case MGC_END0_STAGE_ACKWAIT:	/* STALL for zero-length data */
-	case MGC_END0_STAGE_RX:		/* control-OUT data */
+	case MUSB_EP0_STAGE_TX:		/* control-IN data */
+	case MUSB_EP0_STAGE_ACKWAIT:	/* STALL for zero-length data */
+	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
 		status = 0;
 
 		musb_ep_select(base, 0);
 		csr = musb_readw(regs, MUSB_CSR0);
 		csr |= MUSB_CSR0_P_SENDSTALL;
 		musb_writew(regs, MUSB_CSR0, csr);
-		musb->ep0_state = MGC_END0_STAGE_SETUP;
+		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 		break;
 	default:
 		DBG(1, "ep0 can't halt in state %d\n", musb->ep0_state);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6fcc088..fa15c59 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2015,7 +2015,7 @@ __acquires(musb->lock)
 	musb->is_suspended = 0;
 	MUSB_DEV_MODE(musb);
 	musb->address = 0;
-	musb->ep0_state = MGC_END0_STAGE_SETUP;
+	musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 
 	musb->may_wakeup = 0;
 	musb->g.b_hnp_enable = 0;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 4aa491d..e924853 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -189,7 +189,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		/* control transfers always start with SETUP */
 		is_in = 0;
 		hw_ep->out_qh = qh;
-		musb->ep0_stage = MGC_END0_START;
+		musb->ep0_stage = MUSB_EP0_START;
 		buf = urb->setup_packet;
 		len = 8;
 		break;
@@ -953,7 +953,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 	struct usb_ctrlrequest	*request;
 
 	switch (musb->ep0_stage) {
-	case MGC_END0_IN:
+	case MUSB_EP0_IN:
 		fifo_dest = urb->transfer_buffer + urb->actual_length;
 		fifo_count = min(len, ((u16) (urb->transfer_buffer_length
 					- urb->actual_length)));
@@ -971,7 +971,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 				urb->transfer_buffer_length)
 			more = TRUE;
 		break;
-	case MGC_END0_START:
+	case MUSB_EP0_START:
 		request = (struct usb_ctrlrequest *) urb->setup_packet;
 
 		if (!request->wLength) {
@@ -979,16 +979,16 @@ static int musb_h_ep0_continue(struct musb *musb,
 			break;
 		} else if (request->bRequestType & USB_DIR_IN) {
 			DBG(4, "start IN-DATA\n");
-			musb->ep0_stage = MGC_END0_IN;
+			musb->ep0_stage = MUSB_EP0_IN;
 			more = TRUE;
 			break;
 		} else {
 			DBG(4, "start OUT-DATA\n");
-			musb->ep0_stage = MGC_END0_OUT;
+			musb->ep0_stage = MUSB_EP0_OUT;
 			more = TRUE;
 		}
 		/* FALLTHROUGH */
-	case MGC_END0_OUT:
+	case MUSB_EP0_OUT:
 		fifo_count = min(qh->maxpacket, ((u16)
 				(urb->transfer_buffer_length
 				- urb->actual_length)));
@@ -1043,7 +1043,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		csr, qh, len, urb, musb->ep0_stage);
 
 	/* if we just did status stage, we are done */
-	if (MGC_END0_STATUS == musb->ep0_stage) {
+	if (MUSB_EP0_STATUS == musb->ep0_stage) {
 		retval = IRQ_HANDLED;
 		complete = TRUE;
 	}
@@ -1114,7 +1114,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		/* call common logic and prepare response */
 		if (musb_h_ep0_continue(musb, len, urb)) {
 			/* more packets required */
-			csr = (MGC_END0_IN == musb->ep0_stage)
+			csr = (MUSB_EP0_IN == musb->ep0_stage)
 				?  MUSB_CSR0_H_REQPKT : MUSB_CSR0_TXPKTRDY;
 		} else {
 			/* data transfer complete; perform status phase */
@@ -1127,7 +1127,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 					| MUSB_CSR0_TXPKTRDY;
 
 			/* flag status stage */
-			musb->ep0_stage = MGC_END0_STATUS;
+			musb->ep0_stage = MUSB_EP0_STATUS;
 
 			DBG(5, "ep0 STATUS, csr %04x\n", csr);
 
@@ -1135,7 +1135,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		musb_writew(epio, MUSB_CSR0, csr);
 		retval = IRQ_HANDLED;
 	} else
-		musb->ep0_stage = MGC_END0_IDLE;
+		musb->ep0_stage = MUSB_EP0_IDLE;
 
 	/* call completion handler if done */
 	if (complete)
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 8ad6c42..8a18c18 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -181,21 +181,21 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
 
 /* host side ep0 states */
 enum musb_h_ep0_state {
-	MGC_END0_IDLE,
-	MGC_END0_START,			/* expect ack of setup */
-	MGC_END0_IN,			/* expect IN DATA */
-	MGC_END0_OUT,			/* expect ack of OUT DATA */
-	MGC_END0_STATUS,		/* expect ack of STATUS */
+	MUSB_EP0_IDLE,
+	MUSB_EP0_START,			/* expect ack of setup */
+	MUSB_EP0_IN,			/* expect IN DATA */
+	MUSB_EP0_OUT,			/* expect ack of OUT DATA */
+	MUSB_EP0_STATUS,		/* expect ack of STATUS */
 } __attribute__ ((packed));
 
 /* peripheral side ep0 states */
 enum musb_g_ep0_state {
-	MGC_END0_STAGE_SETUP,		/* idle, waiting for setup */
-	MGC_END0_STAGE_TX,		/* IN data */
-	MGC_END0_STAGE_RX,		/* OUT data */
-	MGC_END0_STAGE_STATUSIN,	/* (after OUT data) */
-	MGC_END0_STAGE_STATUSOUT,	/* (after IN data) */
-	MGC_END0_STAGE_ACKWAIT,		/* after zlp, before statusin */
+	MUSB_EP0_STAGE_SETUP,		/* idle, waiting for setup */
+	MUSB_EP0_STAGE_TX,		/* IN data */
+	MUSB_EP0_STAGE_RX,		/* OUT data */
+	MUSB_EP0_STAGE_STATUSIN,	/* (after OUT data) */
+	MUSB_EP0_STAGE_STATUSOUT,	/* (after IN data) */
+	MUSB_EP0_STAGE_ACKWAIT,		/* after zlp, before statusin */
 } __attribute__ ((packed));
 
 /* OTG protocol constants */
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index c828bd1..6e7a973 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -467,7 +467,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 		 * a_wait_vrise_tmout triggers VBUS_ERROR transitions
 		 */
 		musb_writeb(mbase, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
-		musb->ep0_stage = MGC_END0_START;
+		musb->ep0_stage = MUSB_EP0_START;
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
 		musb_set_vbus(musb, 1);
@@ -550,7 +550,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 		musb->is_active = 1;
 		set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
-		musb->ep0_stage = MGC_END0_START;
+		musb->ep0_stage = MUSB_EP0_START;
 
 #ifdef CONFIG_USB_MUSB_OTG
 		/* flush endpoints when transitioning from Device Mode */
-- 
1.5.2.3
