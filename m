From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/36] musb_hdrc: Search and replace bIntr with int_hsdma
Date: Thu, 16 Aug 2007 02:40:29 -0700
Message-ID: <11872572743878-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572713057-git-send-email-tony@atomide.com>
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

Search and replace bIntr with int_hsdma

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhsdma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 7641f1a..081ca82 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -304,15 +304,15 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	u8 bChannel;
 	u16 csr;
 	u32 dwAddress;
-	u8 bIntr;
+	u8 int_hsdma;
 	irqreturn_t retval = IRQ_NONE;
 
-	bIntr = musb_readb(mbase, MGC_O_HSDMA_INTR);
-	if (!bIntr)
+	int_hsdma = musb_readb(mbase, MGC_O_HSDMA_INTR);
+	if (!int_hsdma)
 		goto done;
 
 	for (bChannel = 0; bChannel < MGC_HSDMA_CHANNELS; bChannel++) {
-		if (bIntr & (1 << bChannel)) {
+		if (int_hsdma & (1 << bChannel)) {
 			pImplChannel = (struct musb_dma_channel *)
 					&(pController->aChannel[bChannel]);
 			pChannel = &pImplChannel->Channel;
-- 
1.5.2.3
