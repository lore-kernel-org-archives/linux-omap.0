From: David Brownell <david-b@pacbell.net>
Subject: Re: Cannot stall an endpoint 0 control transfer from a data stage
	cal lback function
Date: Tue, 21 Aug 2007 16:58:05 -0700
Message-ID: <200708211658.05301.david-b@pacbell.net>
References: <0474A5584072DA1197F50007E90E6B1141D5E1@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <0474A5584072DA1197F50007E90E6B1141D5E1@PORTIA>
Content-Disposition: inline
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
Cc: Geoffrey Tam <geoffrey@evertz.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 21 August 2007, Geoffrey Tam wrote:
> Sorry for the long delay.
> 
> I just tried out the latest code on the git tree, and it does not work for
> me. It does not allow me to stall an endpoint.

I was wondering what happened to this problem report ... I cleaned
up your old patch and fixed some things that were wrong, maybe this
one will work better.

- Dave



======	CUT HERE
Gadget drivers are supposed to be able to cause EP0 protocol stalls by
issuing an appropriate request from the callback issued when the DATA
stage completes ... not only from the setup() callback or from some
thread that decides how to handle the request.

This fix is based on a patch from Geoffrey Tam <geoffrey@evertz.com>,
and addresses that by updating the endpoint state AFTER the callback
is issued, providing the correct IRQ-acking CSR to the halt() so it
can just mask in the SEND_STALL bit, and ensuring that only the CSR
is still written only once even on this new code path.

Also includes a few small cleanups:  avoid "this" variable name, and
pack device bitfields more efficiently (wasting less space).

Allegedly helps file_storage on Davinci.

---
 drivers/usb/musb/musb_core.h       |    8 ++--
 drivers/usb/musb/musb_gadget_ep0.c |   61 +++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 23 deletions(-)

--- o26.orig/drivers/usb/musb/musb_gadget_ep0.c	2007-08-21 16:52:00.000000000 -0700
+++ o26/drivers/usb/musb/musb_gadget_ep0.c	2007-08-21 16:54:11.000000000 -0700
@@ -197,8 +197,8 @@ service_in_request(struct musb *musb,
  */
 static void musb_g_ep0_giveback(struct musb *musb, struct usb_request *req)
 {
-	musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 	musb_g_giveback(&musb->endpoints[0].ep_in, req, 0);
+	musb->ep0_state = MUSB_EP0_STAGE_SETUP;
 }
 
 /*
@@ -434,13 +434,13 @@ stall:
 /* we have an ep0out data packet
  * Context:  caller holds controller lock
  */
-static void ep0_rxstate(struct musb *this)
+static void ep0_rxstate(struct musb *musb)
 {
-	void __iomem		*regs = this->control_ep->regs;
+	void __iomem		*regs = musb->control_ep->regs;
 	struct usb_request	*req;
 	u16			tmp;
 
-	req = next_ep0_request(this);
+	req = next_ep0_request(musb);
 
 	/* read packet and ack; or stall because of gadget driver bug:
 	 * should have provided the rx buffer before setup() returned.
@@ -455,25 +455,29 @@ static void ep0_rxstate(struct musb *thi
 			req->status = -EOVERFLOW;
 			tmp = len;
 		}
-		musb_read_fifo(&this->endpoints[0], tmp, buf);
+		musb_read_fifo(&musb->endpoints[0], tmp, buf);
 		req->actual += tmp;
 		tmp = MUSB_CSR0_P_SVDRXPKTRDY;
 		if (tmp < 64 || req->actual == req->length) {
-			this->ep0_state = MUSB_EP0_STAGE_STATUSIN;
+			musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
 			tmp |= MUSB_CSR0_P_DATAEND;
 		} else
 			req = NULL;
 	} else
 		tmp = MUSB_CSR0_P_SVDRXPKTRDY | MUSB_CSR0_P_SENDSTALL;
-	musb_writew(regs, MUSB_CSR0, tmp);
 
 
-	/* NOTE:  we "should" hold off reporting DATAEND and going to
-	 * STATUSIN until after the completion handler decides whether
-	 * to issue a stall instead, since this hardware can do that.
+	/* Completion handler may choose to stall, e.g. because the
+	 * message just received holds invalid data.
 	 */
-	if (req)
-		musb_g_ep0_giveback(this, req);
+	if (req) {
+		musb->ackpend = tmp;
+		musb_g_ep0_giveback(musb, req);
+		if (!musb->ackpend)
+			return;
+		musb->ackpend = 0;
+	}
+	musb_writew(regs, MUSB_CSR0, tmp);
 }
 
 /*
@@ -511,16 +515,21 @@ static void ep0_txstate(struct musb *mus
 	} else
 		request = NULL;
 
-	/* send it out, triggering a "txpktrdy cleared" irq */
-	musb_writew(regs, MUSB_CSR0, csr);
-
 	/* report completions as soon as the fifo's loaded; there's no
 	 * win in waiting till this last packet gets acked.  (other than
 	 * very precise fault reporting, needed by USB TMC; possible with
 	 * this hardware, but not usable from portable gadget drivers.)
 	 */
-	if (request)
+	if (request) {
+		musb->ackpend = csr;
 		musb_g_ep0_giveback(musb, request);
+		if (!musb->ackpend)
+			return;
+		musb->ackpend = 0;
+	}
+
+	/* send it out, triggering a "txpktrdy cleared" irq */
+	musb_writew(regs, MUSB_CSR0, csr);
 }
 
 /*
@@ -920,6 +929,7 @@ static int musb_g_ep0_halt(struct usb_ep
 	musb = ep->musb;
 	base = musb->mregs;
 	regs = musb->control_ep->regs;
+	status = 0;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -928,17 +938,30 @@ static int musb_g_ep0_halt(struct usb_ep
 		goto cleanup;
 	}
 
+	musb_ep_select(base, 0);
+	csr = musb->ackpend;
+
 	switch (musb->ep0_state) {
+
+	/* Stalls are usually issued after parsing SETUP packet, either
+	 * directly in irq context from setup() or else later.
+	 */
 	case MUSB_EP0_STAGE_TX:		/* control-IN data */
 	case MUSB_EP0_STAGE_ACKWAIT:	/* STALL for zero-length data */
 	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
-		status = 0;
-
-		musb_ep_select(base, 0);
 		csr = musb_readw(regs, MUSB_CSR0);
+		/* FALLTHROUGH */
+
+	/* It's also OK to issue stalls during callbacks when a non-empty
+	 * DATA stage buffer has been read (or even written).
+	 */
+	case MUSB_EP0_STAGE_STATUSIN:	/* control-OUT status */
+	case MUSB_EP0_STAGE_STATUSOUT:	/* control-IN status */
+
 		csr |= MUSB_CSR0_P_SENDSTALL;
 		musb_writew(regs, MUSB_CSR0, csr);
 		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
+		musb->ackpend = 0;
 		break;
 	default:
 		DBG(1, "ep0 can't halt in state %d\n", musb->ep0_state);
--- o26.orig/drivers/usb/musb/musb_core.h	2007-08-21 16:52:00.000000000 -0700
+++ o26/drivers/usb/musb/musb_core.h	2007-08-21 16:54:11.000000000 -0700
@@ -393,6 +393,9 @@ struct musb {
 
 	u8			min_power;	/* vbus for periph, in mA/2 */
 
+	int			a_wait_bcon;	/* VBUS timeout in msecs */
+	unsigned long		idle_timeout;	/* Next timeout in jiffies */
+
 	/* active means connected and not suspended */
 	unsigned		is_active:1;
 
@@ -400,9 +403,6 @@ struct musb {
 	unsigned is_host:1;
 	unsigned ignore_disconnect:1;	/* during bus resets */
 
-	int			a_wait_bcon;	/* VBUS timeout in msecs */
-	unsigned long		idle_timeout;	/* Next timeout in jiffies */
-
 #ifdef C_MP_TX
 	unsigned bulk_split:1;
 #define	can_bulk_split(musb,type) \
@@ -442,10 +442,10 @@ struct musb {
 	unsigned test_mode:1;
 	unsigned softconnect:1;
 
-	enum musb_g_ep0_state	ep0_state;
 	u8			address;
 	u8			test_mode_nr;
 	u16			ackpend;		/* ep0 */
+	enum musb_g_ep0_state	ep0_state;
 	struct usb_gadget	g;			/* the gadget */
 	struct usb_gadget_driver *gadget_driver;	/* its driver */
 #endif
