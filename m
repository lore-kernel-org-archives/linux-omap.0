From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: MUSB: DMA interrupt locking fix
Date: Fri, 31 Aug 2007 16:31:06 -0700
Message-ID: <20070831233106.164731855@mvista.com>
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

dma_controller_irq() should take the lock (and disable interrupts) as
the main interrupt handler does since the functions it calls assume
this to be the case.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: dev/drivers/usb/musb/musbhsdma.c
===================================================================
--- dev.orig/drivers/usb/musb/musbhsdma.c
+++ dev/drivers/usb/musb/musbhsdma.c
@@ -296,6 +296,7 @@ static irqreturn_t dma_controller_irq(in
 	struct musb_dma_controller *controller =
 		(struct musb_dma_controller *)private_data;
 	struct musb_dma_channel *pImplChannel;
+	struct musb *musb = controller->pDmaPrivate;
 	u8 *mbase = controller->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bChannel;
@@ -303,6 +304,9 @@ static irqreturn_t dma_controller_irq(in
 	u32 dwAddress;
 	u8 int_hsdma;
 	irqreturn_t retval = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&musb->lock, flags);
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 	if (!int_hsdma)
@@ -358,7 +362,7 @@ static irqreturn_t dma_controller_irq(in
 						MUSB_TXCSR_TXPKTRDY);
 				} else
 					musb_dma_completion(
-						controller->pDmaPrivate,
+						musb,
 						pImplChannel->epnum,
 						pImplChannel->transmit);
 			}
@@ -366,6 +370,7 @@ static irqreturn_t dma_controller_irq(in
 	}
 	retval = IRQ_HANDLED;
 done:
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return retval;
 }
 
--
