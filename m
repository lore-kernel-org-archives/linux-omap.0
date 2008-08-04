From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: musb fix
Date: Mon, 4 Aug 2008 15:24:29 +0300
Message-ID: <20080804122429.GE30539@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45504 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYHDMXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 08:23:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

Please before merging with mailine apply the attached patch so musb
driver won't break compilation.

We now have a standard WARN() macro so to avoid conflicts we change
musb's WARN() to WARNING.

-- 
balbi

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="musb.diff"

From: David Brownell <david-b@pacbell.net>

Latest musb_hdrc code wouldn't:
  * build ... because there's now a standard WARN() macro
  * build without false printf format warnings ... "%zd" is for ssize_t,
    while "%zu" is for size_t

Signed-off-by: David Brownell <david-b@pacbell.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index e6770d6..e03aa99 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -862,10 +862,10 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
 
 	/* we always expect at least one reusable BD! */
 	if (!tail) {
-		WARN("rx dma%d -- no BDs? need %d\n", rx->index, n_bds);
+		WARNING("rx dma%d -- no BDs? need %d\n", rx->index, n_bds);
 		return;
 	} else if (i < n_bds)
-		WARN("rx dma%d -- only %d of %d BDs\n", rx->index, i, n_bds);
+		WARNING("rx dma%d -- only %d of %d BDs\n", rx->index, i, n_bds);
 
 	tail->next = NULL;
 	tail->hw_next = 0;
@@ -963,13 +963,13 @@ static int cppi_channel_program(struct dma_channel *ch,
 	case MUSB_DMA_STATUS_BUS_ABORT:
 	case MUSB_DMA_STATUS_CORE_ABORT:
 		/* fault irq handler should have handled cleanup */
-		WARN("%cX DMA%d not cleaned up after abort!\n",
+		WARNING("%cX DMA%d not cleaned up after abort!\n",
 				cppi_ch->transmit ? 'T' : 'R',
 				cppi_ch->index);
 		/* WARN_ON(1); */
 		break;
 	case MUSB_DMA_STATUS_BUSY:
-		WARN("program active channel?  %cX DMA%d\n",
+		WARNING("program active channel?  %cX DMA%d\n",
 				cppi_ch->transmit ? 'T' : 'R',
 				cppi_ch->index);
 		/* WARN_ON(1); */
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index acd2aa8..75baf18 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -120,7 +120,7 @@ void musb_platform_disable(struct musb *musb)
 	musb_writel(musb->ctrl_base, DAVINCI_USB_EOI_REG, 0);
 
 	if (is_dma_capable() && !dma_off)
-		WARN("dma still active\n");
+		WARNING("dma still active\n");
 }
 
 
@@ -329,7 +329,7 @@ static irqreturn_t davinci_interrupt(int irq, void *__hci)
 			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
 			musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
 			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
-			WARN("VBUS error workaround (delay coming)\n");
+			WARNING("VBUS error workaround (delay coming)\n");
 		} else if (is_host_enabled(musb) && drvvbus) {
 			musb->is_active = 1;
 			MUSB_HST_MODE(musb);
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 75c3013..1404a10 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -443,7 +443,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				MUSB_DEV_MODE(musb);
 				break;
 			default:
-				WARN("bogus %s RESUME (%s)\n",
+				WARNING("bogus %s RESUME (%s)\n",
 					"host",
 					otg_state_string(musb));
 			}
@@ -477,7 +477,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				break;
 #endif
 			default:
-				WARN("bogus %s RESUME (%s)\n",
+				WARNING("bogus %s RESUME (%s)\n",
 					"peripheral",
 					otg_state_string(musb));
 			}
@@ -799,7 +799,7 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
 			break;
 #endif	/* GADGET */
 		default:
-			WARN("unhandled DISCONNECT transition (%s)\n",
+			WARNING("unhandled DISCONNECT transition (%s)\n",
 				otg_state_string(musb));
 			break;
 		}
diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index 0743972..3bdb311 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -38,7 +38,7 @@
 #define yprintk(facility, format, args...) \
 	do { printk(facility "%s %d: " format , \
 	__func__, __LINE__ , ## args); } while (0)
-#define WARN(fmt, args...) yprintk(KERN_WARNING, fmt, ## args)
+#define WARNING(fmt, args...) yprintk(KERN_WARNING, fmt, ## args)
 #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
 #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
 
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 303b6f6..b3773f1 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -466,7 +466,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				csr = musb_readw(epio, MUSB_TXCSR);
 				request->actual += musb_ep->dma->actual_len;
 				DBG(4, "TXCSR%d %04x, dma off, "
-						"len %Zd, req %p\n",
+						"len %zu, req %p\n",
 					epnum, csr,
 					musb_ep->dma->actual_len,
 					request);
@@ -795,7 +795,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		request->actual += musb_ep->dma->actual_len;
 
-		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
+		DBG(4, "RXCSR%d %04x, dma off, %04x, len %zu, req %p\n",
 			epnum, csr,
 			musb_readw(epio, MUSB_RXCSR),
 			musb_ep->dma->actual_len, request);
@@ -1886,7 +1886,7 @@ void musb_g_resume(struct musb *musb)
 		}
 		break;
 	default:
-		WARN("unhandled RESUME transition (%s)\n",
+		WARNING("unhandled RESUME transition (%s)\n",
 				otg_state_string(musb));
 	}
 }
@@ -1916,7 +1916,7 @@ void musb_g_suspend(struct musb *musb)
 		/* REVISIT if B_HOST, clear DEVCTL.HOSTREQ;
 		 * A_PERIPHERAL may need care too
 		 */
-		WARN("unhandled SUSPEND transition (%s)\n",
+		WARNING("unhandled SUSPEND transition (%s)\n",
 				otg_state_string(musb));
 	}
 }
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 52ac02a..08e421f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -584,7 +584,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	} else {
 		csr = musb_readw(ep->regs, MUSB_RXCSR);
 		if (csr & MUSB_RXCSR_RXPKTRDY)
-			WARN("rx%d, packet/%d ready?\n", ep->epnum,
+			WARNING("rx%d, packet/%d ready?\n", ep->epnum,
 				musb_readw(ep->regs, MUSB_RXCOUNT));
 
 		musb_h_flush_rxfifo(ep, MUSB_RXCSR_CLRDATATOG);
@@ -1403,7 +1403,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 	pipe = urb->pipe;
 
-	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zd)\n",
+	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zu)\n",
 		epnum, rx_csr, urb->actual_length,
 		dma ? dma->actual_len : 0);
 
@@ -1486,7 +1486,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			done = true;
 		}
 
-		DBG(2, "RXCSR%d %04x, reqpkt, len %zd%s\n", epnum, rx_csr,
+		DBG(2, "RXCSR%d %04x, reqpkt, len %zu%s\n", epnum, rx_csr,
 				xfer_len, dma ? ", dma" : "");
 		rx_csr &= ~MUSB_RXCSR_H_REQPKT;
 
@@ -2125,7 +2125,7 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 		return 0;
 
 	if (is_host_active(musb) && musb->is_active) {
-		WARN("trying to suspend as %s is_active=%i\n",
+		WARNING("trying to suspend as %s is_active=%i\n",
 			otg_state_string(musb), musb->is_active);
 		return -EBUSY;
 	} else
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index da683eb..6184941 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -680,7 +680,7 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 			reg |= MUSB_DEVCTL_HR;
 			musb_writeb(mbase, MUSB_DEVCTL, reg);
 			/* MUSB_HST_MODE( ((struct musb*)data) ); */
-			/* WARN("Host Mode\n"); */
+			/* WARNING("Host Mode\n"); */
 		}
 		break;
 

--2oS5YaxWCcQjTEyO--
