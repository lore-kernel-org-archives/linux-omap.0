From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] musb_hdrc: Search and replace MGC_END_OFFSET with
	MUSB_EP_OFFSET
Date: Fri, 17 Aug 2007 04:44:39 -0700
Message-ID: <11873510882998-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11873510862981-git-send-email-tony@atomide.com>
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

Search and replace MGC_END_OFFSET with MUSB_EP_OFFSET

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h  |    6 +++---
 drivers/usb/musb/musbhsdma.c |   10 +++++-----
 drivers/usb/musb/plat_uds.c  |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 8a18c18..27b5957 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -221,18 +221,18 @@ enum musb_g_ep0_state {
 #if	defined(CONFIG_USB_TUSB6010)
 #define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MGC_END_OFFSET			MUSB_TUSB_OFFSET
+#define	MUSB_EP_OFFSET			MUSB_TUSB_OFFSET
 
 /* "flat" mapping: each endpoint has its own i/o address */
 #elif	defined(MUSB_FLAT_REG)
 #define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)),((void)(_epnum)))
-#define	MGC_END_OFFSET			MUSB_FLAT_OFFSET
+#define	MUSB_EP_OFFSET			MUSB_FLAT_OFFSET
 
 /* "indexed" mapping: INDEX register controls register bank select */
 #else
 #define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MGC_END_OFFSET			MUSB_INDEXED_OFFSET
+#define	MUSB_EP_OFFSET			MUSB_INDEXED_OFFSET
 #endif
 
 /****************************** FUNCTIONS ********************************/
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 653addb..48e5531 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -263,22 +263,22 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		if (pImplChannel->transmit) {
 
 			csr = musb_readw(mbase,
-				MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR));
+				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_TXCSR));
 			csr &= ~(MUSB_TXCSR_AUTOSET |
 				 MUSB_TXCSR_DMAENAB |
 				 MUSB_TXCSR_DMAMODE);
 			musb_writew(mbase,
-					MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
+					MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
 					csr);
 		}
 		else {
 			csr = musb_readw(mbase,
-				MGC_END_OFFSET(pImplChannel->epnum,MUSB_RXCSR));
+				MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_RXCSR));
 			csr &= ~(MUSB_RXCSR_AUTOCLEAR |
 				 MUSB_RXCSR_DMAENAB |
 				 MUSB_RXCSR_DMAMODE);
 			musb_writew(mbase,
-					MGC_END_OFFSET(pImplChannel->epnum,MUSB_RXCSR),
+					MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_RXCSR),
 					csr);
 		}
 
@@ -356,7 +356,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					musb_ep_select(mbase,
 						pImplChannel->epnum);
 					musb_writew(mbase,
-						MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
+						MUSB_EP_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
 						MUSB_TXCSR_TXPKTRDY);
 				} else
 					musb_dma_completion(
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 6e7a973..8a2bb3e 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1380,7 +1380,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 			hw_ep->conf = mbase + 0x400 + (((i - 1) & 0xf) << 2);
 #endif
 
-		hw_ep->regs = MGC_END_OFFSET(i, 0) + mbase;
+		hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		hw_ep->target_regs = MUSB_BUSCTL_OFFSET(i, 0) + mbase;
 		hw_ep->rx_reinit = 1;
-- 
1.5.2.3
