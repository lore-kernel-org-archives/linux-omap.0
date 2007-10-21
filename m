From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] musb_hdrc: Removed nestedness in musb_gadget_ep0
Date: Sun, 21 Oct 2007 16:20:51 -0700
Message-ID: <11930088583835-git-send-email-tony@atomide.com>
References: musb-2007-10-21
 <119300885686-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <119300885686-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Return early to leave out one level of nestedness.
No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget_ep0.c |  326 ++++++++++++++++++------------------
 1 files changed, 160 insertions(+), 166 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 3529359..82222e0 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -234,199 +234,193 @@ __acquires(musb->lock)
 	const u8 recip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
 	/* the gadget driver handles everything except what we MUST handle */
-	if ((ctrlrequest->bRequestType & USB_TYPE_MASK)
-			== USB_TYPE_STANDARD) {
-		switch (ctrlrequest->bRequest) {
-		case USB_REQ_SET_ADDRESS:
-			/* change it after the status stage */
-			musb->set_address = true;
-			musb->address = (u8) (ctrlrequest->wValue & 0x7f);
+	if ((ctrlrequest->bRequestType & USB_TYPE_MASK) != USB_TYPE_STANDARD) {
+		handled = 0;
+		goto out;
+	}
+
+	switch (ctrlrequest->bRequest) {
+	case USB_REQ_SET_ADDRESS:
+		/* change it after the status stage */
+		musb->set_address = true;
+		musb->address = (u8) (ctrlrequest->wValue & 0x7f);
+		handled = 1;
+		break;
+
+	case USB_REQ_CLEAR_FEATURE:
+		switch (recip) {
+		case USB_RECIP_DEVICE:
+			if (ctrlrequest->wValue != USB_DEVICE_REMOTE_WAKEUP)
+				break;
+			musb->may_wakeup = 0;
 			handled = 1;
 			break;
+		case USB_RECIP_INTERFACE:
+			break;
+		case USB_RECIP_ENDPOINT:
+		{
+			const u8 epnum = ctrlrequest->wIndex & 0x0f;
+			struct musb_ep *musb_ep;
 
-		case USB_REQ_CLEAR_FEATURE:
-			switch (recip) {
-			case USB_RECIP_DEVICE:
-				if (ctrlrequest->wValue
-						!= USB_DEVICE_REMOTE_WAKEUP)
-					break;
-				musb->may_wakeup = 0;
-				handled = 1;
-				break;
-			case USB_RECIP_INTERFACE:
-				break;
-			case USB_RECIP_ENDPOINT:{
-				const u8 epnum = ctrlrequest->wIndex & 0x0f;
-				struct musb_ep *musb_ep;
-
-				if (epnum == 0
-						|| epnum >= MUSB_C_NUM_EPS
-						|| ctrlrequest->wValue
-							!= USB_ENDPOINT_HALT)
+			if (epnum == 0 || epnum >= MUSB_C_NUM_EPS
+				|| ctrlrequest->wValue != USB_ENDPOINT_HALT)
 					break;
 
-				if (ctrlrequest->wIndex & USB_DIR_IN)
-					musb_ep = &musb->endpoints[epnum].ep_in;
-				else
-					musb_ep = &musb->endpoints[epnum].ep_out;
-				if (!musb_ep->desc)
-					break;
+			if (ctrlrequest->wIndex & USB_DIR_IN)
+				musb_ep = &musb->endpoints[epnum].ep_in;
+			else
+				musb_ep = &musb->endpoints[epnum].ep_out;
+			if (!musb_ep->desc)
+				break;
 
-				/* REVISIT do it directly, no locking games */
-				spin_unlock(&musb->lock);
-				musb_gadget_set_halt(&musb_ep->end_point, 0);
-				spin_lock(&musb->lock);
+			/* REVISIT do it directly, no locking games */
+			spin_unlock(&musb->lock);
+			musb_gadget_set_halt(&musb_ep->end_point, 0);
+			spin_lock(&musb->lock);
 
-				/* select ep0 again */
-				musb_ep_select(mbase, 0);
-				handled = 1;
-				} break;
-			default:
-				/* class, vendor, etc ... delegate */
-				handled = 0;
-				break;
-			}
+			/* select ep0 again */
+			musb_ep_select(mbase, 0);
+			handled = 1;
+		}
+		break;
+		default:
+			/* class, vendor, etc ... delegate */
+			handled = 0;
 			break;
+		}
+		break;
 
-		case USB_REQ_SET_FEATURE:
-			switch (recip) {
-			case USB_RECIP_DEVICE:
-				handled = 1;
-				switch (ctrlrequest->wValue) {
-				case USB_DEVICE_REMOTE_WAKEUP:
-					musb->may_wakeup = 1;
-					break;
-				case USB_DEVICE_TEST_MODE:
-					if (musb->g.speed != USB_SPEED_HIGH)
-						goto stall;
-					if (ctrlrequest->wIndex & 0xff)
-						goto stall;
-
-					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
-						musb->test_mode_nr =
-							MUSB_TEST_J;
-						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
-						musb->test_mode_nr =
-							MUSB_TEST_K;
-						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
-						musb->test_mode_nr =
-							MUSB_TEST_SE0_NAK;
-						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
-						musb->test_mode_nr =
-							MUSB_TEST_PACKET;
-						break;
-					default:
-						goto stall;
-					}
-
-					/* enter test mode after irq */
-					if (handled > 0)
-						musb->test_mode = true;
+	case USB_REQ_SET_FEATURE:
+		switch (recip) {
+		case USB_RECIP_DEVICE:
+			handled = 1;
+			switch (ctrlrequest->wValue) {
+			case USB_DEVICE_REMOTE_WAKEUP:
+				musb->may_wakeup = 1;
+				break;
+			case USB_DEVICE_TEST_MODE:
+				if (musb->g.speed != USB_SPEED_HIGH)
+					goto stall;
+				if (ctrlrequest->wIndex & 0xff)
+					goto stall;
+
+				switch (ctrlrequest->wIndex >> 8) {
+				case 1:
+					pr_debug("TEST_J\n");
+					/* TEST_J */
+					musb->test_mode_nr = MUSB_TEST_J;
 					break;
-#ifdef CONFIG_USB_MUSB_OTG
-				case USB_DEVICE_B_HNP_ENABLE:
-					if (!musb->g.is_otg)
-						goto stall;
-					musb->g.b_hnp_enable = 1;
-					musb_try_b_hnp_enable(musb);
+				case 2:
+					/* TEST_K */
+					pr_debug("TEST_K\n");
+					musb->test_mode_nr = MUSB_TEST_K;
 					break;
-				case USB_DEVICE_A_HNP_SUPPORT:
-					if (!musb->g.is_otg)
-						goto stall;
-					musb->g.a_hnp_support = 1;
+				case 3:
+					/* TEST_SE0_NAK */
+					pr_debug("TEST_SE0_NAK\n");
+					musb->test_mode_nr =
+						MUSB_TEST_SE0_NAK;
 					break;
-				case USB_DEVICE_A_ALT_HNP_SUPPORT:
-					if (!musb->g.is_otg)
-						goto stall;
-					musb->g.a_alt_hnp_support = 1;
+				case 4:
+					/* TEST_PACKET */
+					pr_debug("TEST_PACKET\n");
+					musb->test_mode_nr = MUSB_TEST_PACKET;
 					break;
-#endif
-stall:
 				default:
-					handled = -EINVAL;
-					break;
+					goto stall;
 				}
-				break;
 
-			case USB_RECIP_INTERFACE:
+				/* enter test mode after irq */
+				if (handled > 0)
+					musb->test_mode = true;
+				break;
+#ifdef CONFIG_USB_MUSB_OTG
+			case USB_DEVICE_B_HNP_ENABLE:
+				if (!musb->g.is_otg)
+					goto stall;
+				musb->g.b_hnp_enable = 1;
+				musb_try_b_hnp_enable(musb);
+				break;
+			case USB_DEVICE_A_HNP_SUPPORT:
+				if (!musb->g.is_otg)
+					goto stall;
+				musb->g.a_hnp_support = 1;
 				break;
+			case USB_DEVICE_A_ALT_HNP_SUPPORT:
+				if (!musb->g.is_otg)
+					goto stall;
+				musb->g.a_alt_hnp_support = 1;
+				break;
+#endif
+stall:
+			default:
+				handled = -EINVAL;
+				break;
+			}
+			break;
 
-			case USB_RECIP_ENDPOINT:{
-				const u8		epnum =
-					ctrlrequest->wIndex & 0x0f;
-				struct musb_ep		*musb_ep;
-				struct musb_hw_ep	*ep;
-				void __iomem		*regs;
-				int			is_in;
-				u16			csr;
-
-				if (epnum == 0
-						|| epnum >= MUSB_C_NUM_EPS
-						|| ctrlrequest->wValue
-							!= USB_ENDPOINT_HALT)
-					break;
+		case USB_RECIP_INTERFACE:
+			break;
 
-				ep = musb->endpoints + epnum;
-				regs = ep->regs;
-				is_in = ctrlrequest->wIndex & USB_DIR_IN;
-				if (is_in)
-					musb_ep = &ep->ep_in;
-				else
-					musb_ep = &ep->ep_out;
-				if (!musb_ep->desc)
+		case USB_RECIP_ENDPOINT:
+		{
+			const u8		epnum = ctrlrequest->wIndex & 0x0f;
+			struct musb_ep		*musb_ep;
+			struct musb_hw_ep	*ep;
+			void __iomem		*regs;
+			int			is_in;
+			u16			csr;
+
+			if (epnum == 0 || epnum >= MUSB_C_NUM_EPS
+				|| ctrlrequest->wValue != USB_ENDPOINT_HALT)
 					break;
 
-				musb_ep_select(mbase, epnum);
-				if (is_in) {
-					csr = musb_readw(regs,
-							MUSB_TXCSR);
-					if (csr & MUSB_TXCSR_FIFONOTEMPTY)
-						csr |= MUSB_TXCSR_FLUSHFIFO;
-					csr |= MUSB_TXCSR_P_SENDSTALL
-						| MUSB_TXCSR_CLRDATATOG
-						| MUSB_TXCSR_P_WZC_BITS;
-					musb_writew(regs, MUSB_TXCSR,
-							csr);
-				} else {
-					csr = musb_readw(regs,
-							MUSB_RXCSR);
-					csr |= MUSB_RXCSR_P_SENDSTALL
-						| MUSB_RXCSR_FLUSHFIFO
-						| MUSB_RXCSR_CLRDATATOG
-						| MUSB_TXCSR_P_WZC_BITS;
-					musb_writew(regs, MUSB_RXCSR,
-							csr);
-				}
-
-				/* select ep0 again */
-				musb_ep_select(mbase, 0);
-				handled = 1;
-				} break;
-
-			default:
-				/* class, vendor, etc ... delegate */
-				handled = 0;
+			ep = musb->endpoints + epnum;
+			regs = ep->regs;
+			is_in = ctrlrequest->wIndex & USB_DIR_IN;
+			if (is_in)
+				musb_ep = &ep->ep_in;
+			else
+				musb_ep = &ep->ep_out;
+			if (!musb_ep->desc)
 				break;
+
+			musb_ep_select(mbase, epnum);
+			if (is_in) {
+				csr = musb_readw(regs, MUSB_TXCSR);
+				if (csr & MUSB_TXCSR_FIFONOTEMPTY)
+					csr |= MUSB_TXCSR_FLUSHFIFO;
+				csr |= MUSB_TXCSR_P_SENDSTALL
+					| MUSB_TXCSR_CLRDATATOG
+					| MUSB_TXCSR_P_WZC_BITS;
+				musb_writew(regs, MUSB_TXCSR, csr);
+			} else {
+				csr = musb_readw(regs, MUSB_RXCSR);
+				csr |= MUSB_RXCSR_P_SENDSTALL
+					| MUSB_RXCSR_FLUSHFIFO
+					| MUSB_RXCSR_CLRDATATOG
+					| MUSB_TXCSR_P_WZC_BITS;
+				musb_writew(regs, MUSB_RXCSR, csr);
 			}
-			break;
+
+			/* select ep0 again */
+			musb_ep_select(mbase, 0);
+			handled = 1;
+		}
+		break;
+
 		default:
-			/* delegate SET_CONFIGURATION, etc */
+			/* class, vendor, etc ... delegate */
 			handled = 0;
+			break;
 		}
-	} else
+		break;
+	default:
+		/* delegate SET_CONFIGURATION, etc */
 		handled = 0;
+	}
+
+out:
 	return handled;
 }
 
-- 
1.5.2.5
