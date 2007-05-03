From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Enable host DMA for tusb6010
Date: Thu,  3 May 2007 16:41:53 +0000
Message-ID: <11782105223370-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11782105222073-git-send-email-tony@atomide.com>
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

This patch allows host to try to use DMA on tusb6010.

Please note that until tusb6010 DMA size limitations
are fixed, DMA happens with host side rarely.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ef473e9..440df48 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -236,7 +236,7 @@ start:
 
 		if (!pEnd->tx_channel)
 			musb_h_tx_start(pEnd);
-		else if (is_cppi_enabled())
+		else if (is_cppi_enabled() || tusb_dma_omap())
 			cppi_host_txdma_start(pEnd);
 	}
 }
@@ -806,7 +806,7 @@ static void musb_ep_program(struct musb *pThis, u8 bEnd,
 #endif
 
 		/* candidate for DMA */
-		if (is_cppi_enabled() && pDmaChannel) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
 
 			/* program endpoint CSRs first, then setup DMA.
 			 * assume CPPI setup succeeds.
@@ -897,7 +897,7 @@ static void musb_ep_program(struct musb *pThis, u8 bEnd,
 
 		/* kick things off */
 
-		if (is_cppi_enabled()) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
 			/* candidate for DMA */
 			if (pDmaChannel) {
 				pDmaChannel->dwActualLength = 0L;
-- 
1.4.4.2
