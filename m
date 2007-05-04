From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] musb_hdrc: Enable host DMA for tusb6010
Date: Fri, 4 May 2007 10:05:18 -0700
Message-ID: <20070504170518.GG12331@atomide.com>
References: <11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11782105223370-git-send-email-tony@atomide.com>
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


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [070503 09:42]:
> This patch allows host to try to use DMA on tusb6010.

Here's an updated version of this to fix the compile
problem Kevin pointed out on non-tusb systems.

Tony


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0002-musb_hdrc-Enable-host-DMA-for-tusb6010.txt"

>From cac0b797100c284366305471b8d12ca7daa73861 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 6 Feb 2007 15:41:54 -0800
Subject: [PATCH] musb_hdrc: Enable host DMA for tusb6010

This patch allows host to try to use DMA on tusb6010.

Please note that until tusb6010 DMA size limitations
are fixed, DMA happens with host side rarely.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
@@ -806,7 +806,7 @@ static void musb_ep_program(struct musb 
 #endif
 
 		/* candidate for DMA */
-		if (is_cppi_enabled() && pDmaChannel) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
 
 			/* program endpoint CSRs first, then setup DMA.
 			 * assume CPPI setup succeeds.
@@ -897,7 +897,7 @@ static void musb_ep_program(struct musb 
 
 		/* kick things off */
 
-		if (is_cppi_enabled()) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
 			/* candidate for DMA */
 			if (pDmaChannel) {
 				pDmaChannel->dwActualLength = 0L;
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -73,6 +73,11 @@ struct musb_hw_ep;
 #define	is_cppi_enabled()	0
 #endif
 
+#ifdef CONFIG_USB_TUSB_OMAP_DMA
+#define tusb_dma_omap()			1
+#else
+#define tusb_dma_omap()			0
+#endif
 
 /*
  * DMA channel status ... updated by the dma controller driver whenever that


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--17pEHd4RhPHOinZp--
