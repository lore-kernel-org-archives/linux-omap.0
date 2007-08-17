From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] musb_hdrc: Search and replace MGC_O_HSDMA with
	MUSB_HSDMA
Date: Fri, 17 Aug 2007 04:44:40 -0700
Message-ID: <11873510911954-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11873510882998-git-send-email-tony@atomide.com>
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

Search and replace MGC_O_HSDMA with MUSB_HSDMA

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhsdma.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 48e5531..eb3d27d 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -44,14 +44,14 @@
 #include "omap2430.h"
 #endif
 
-#define MGC_O_HSDMA_BASE		0x200
-#define MGC_O_HSDMA_INTR		(MGC_O_HSDMA_BASE + 0)
-#define MGC_O_HSDMA_CONTROL		0x4
-#define MGC_O_HSDMA_ADDRESS		0x8
-#define MGC_O_HSDMA_COUNT		0xc
+#define MUSB_HSDMA_BASE		0x200
+#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
+#define MUSB_HSDMA_CONTROL		0x4
+#define MUSB_HSDMA_ADDRESS		0x8
+#define MUSB_HSDMA_COUNT		0xc
 
 #define MGC_HSDMA_CHANNEL_OFFSET(_bChannel, _offset)		\
-		(MGC_O_HSDMA_BASE + (_bChannel << 4) + _offset)
+		(MUSB_HSDMA_BASE + (_bChannel << 4) + _offset)
 
 /* control register (16-bit): */
 #define MUSB_HSDMA_ENABLE_SHIFT		0
@@ -208,15 +208,15 @@ static void configure_channel(struct dma_channel *pChannel,
 
 	/* address/count */
 	musb_writel(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_ADDRESS),
+		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS),
 		    dma_addr);
 	musb_writel(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT),
+		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT),
 		    len);
 
 	/* control (this should start things) */
 	musb_writew(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_CONTROL),
+		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL),
 		    csr);
 }
 
@@ -283,11 +283,11 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		}
 
 		musb_writew(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_CONTROL), 0);
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL), 0);
 		musb_writel(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_ADDRESS), 0);
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS), 0);
 		musb_writel(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT), 0);
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT), 0);
 
 		pChannel->status = MUSB_DMA_STATUS_FREE;
 	}
@@ -307,7 +307,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	u8 int_hsdma;
 	irqreturn_t retval = IRQ_NONE;
 
-	int_hsdma = musb_readb(mbase, MGC_O_HSDMA_INTR);
+	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 	if (!int_hsdma)
 		goto done;
 
@@ -319,7 +319,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 			csr = musb_readw(mbase,
 				       MGC_HSDMA_CHANNEL_OFFSET(bChannel,
-							MGC_O_HSDMA_CONTROL));
+							MUSB_HSDMA_CONTROL));
 
 			if (csr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
 				pImplChannel->Channel.status =
@@ -328,7 +328,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				dwAddress = musb_readl(mbase,
 						MGC_HSDMA_CHANNEL_OFFSET(
 							bChannel,
-							MGC_O_HSDMA_ADDRESS));
+							MUSB_HSDMA_ADDRESS));
 				pChannel->actual_len =
 				    dwAddress - pImplChannel->dwStartAddress;
 
-- 
1.5.2.3
