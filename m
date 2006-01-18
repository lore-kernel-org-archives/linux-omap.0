From: Antti P Miettinen <ananaza@iki.fi>
Subject: USB gadget driver
Date: Wed, 18 Jan 2006 14:17:36 +0200
Message-ID: <p2gy81d4tnj.fsf@doris.dna.fi>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

While doing development for an OMAP2420 board I noticed that the
"workaround for seemingly-lost IRQs for RX ACKs" in omap_udc.c needs a
little tweak in order to prevent NFS root over usbnet from hanging.
According to the documentation the status flag register should only be
accessed when endpoint select bit is set in the EP_NUM register. See
e.g. SPRU761A, end of page 78 (about STAT_FLG register):

"This register cannot be read if EP_NUM.EP_SEL bit is not asserted for the
endpoint."

Similar statement seems to be in the specs for other OMAPs too.

As a change for the workaround seem to have an effect it seems that
there is indeed an underlying "IRQs get lost" problem?

In principle reading the status flag in proc_ep_show() would need
similar change, but I'm not sure how the EP selection would interact
with interrupt processing. Actually I'm not sure how this change
interacts with interrupt processing either but at least it cured the
hangs for the 2420.

It seems that usbnet with Nokia 770 is also a bit unreliable but this
change does not seem to have an effect. Does someone have an OMAP
based system where usbnet is reliable?

--- drivers/usb/gadget/omap_udc.c~	2005-12-13 14:49:29.000000000 +0200
+++ drivers/usb/gadget/omap_udc.c	2006-01-16 15:20:52.000000000 +0200
@@ -1897,7 +1897,7 @@
 
 	spin_lock_irqsave(&ep->udc->lock, flags);
 	if (!list_empty(&ep->queue) && ep->ackwait) {
-		use_ep(ep, 0);
+		use_ep(ep, UDC_EP_SEL);
 		stat_flg = UDC_STAT_FLG_REG;
 
 		if ((stat_flg & UDC_ACK) && (!(stat_flg & UDC_FIFO_EN)
@@ -1907,12 +1907,14 @@
 			VDBG("%s: lose, %04x\n", ep->ep.name, stat_flg);
 			req = container_of(ep->queue.next,
 					struct omap_req, queue);
-			UDC_EP_NUM_REG = ep->bEndpointAddress | UDC_EP_SEL;
 			(void) read_fifo(ep, req);
 			UDC_EP_NUM_REG = ep->bEndpointAddress;
 			UDC_CTRL_REG = UDC_SET_FIFO_EN;
 			ep->ackwait = 1 + ep->double_buf;
 		}
+		else {
+		    deselect_ep();
+		}
 	}
 	mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
 	spin_unlock_irqrestore(&ep->udc->lock, flags);

-- 
http://www.iki.fi/~ananaza/
