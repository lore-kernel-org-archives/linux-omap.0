From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v4 1/4] omap: dma: Fix buffering disable bit setting for omap24xx
Date: Mon,  4 Oct 2010 11:18:11 +0300
Message-ID: <1286180294-32618-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:58246 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab0JDISY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 04:18:24 -0400
In-Reply-To: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org

From: ext Jarkko Nikula <jhnikula@gmail.com>

An errata workaround for omap24xx is not setting the buffering disable bit
25 what is the purpose but channel enable bit 7 instead.

Background for this fix is the DMA stalling issue with ASoC omap-mcbsp
driver. Peter Ujfalusi <peter.ujfalusi@nokia.com> has found an issue in
recording that the DMA stall could happen if there were a buffer overrun
detected by ALSA and the DMA was stopped and restarted due that. This
problem is known to occur on both OMAP2420 and OMAP3. It can recover on
OMAP3 after dma free, dma request and reconfiguration cycle. However, on
OMAP2420 it seems that only way to recover is a reset.

Problem was not visible before the commit c12abc0. That commit changed that
the McBSP transmitter/receiver is released from reset only when needed. That
is, only enabled McBSP transmitter without transmission was able to prevent
this DMA stall problem in receiving side and underlying problem did not show
up until now. McBSP transmitter itself seems to no be reason since DMA
stall does not recover by enabling the transmission after stall.

Debugging showed that there were a DMA write active during DMA stop time and
it never completed even when restarting the DMA. Experimenting showed that
the DMA buffering disable bit could be used to avoid stalling when using
source synchronized transfers. However that could have performance hit and
OMAP3 TRM states that buffering disable is not allowed for destination
synchronized transfers so subsequent patch will implement a method to
complete DMA writes when stopping.

This patch is based on assumtion that complete lock-up on OMAP2420 is
different but related problem. I don't have access to OMAP2420 errata but
I believe this old workaround here is put for a reason but unfortunately
a wrong bit was typed and problem showed up only now.

v2: Issue is applicaple only to OMAP2420 and ES1.0 of OMAP2430. Thanks to
G, Manjunath Kondaiah <manjugk@ti.com> for noticing.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/dma.c              |    5 +++--
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ec7eddf..6914ccf 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -999,8 +999,9 @@ void omap_start_dma(int lch)
 	 * Errata: On ES2.0 BUFFERING disable must be set.
 	 * This will always fail on ES1.0
 	 */
-	if (cpu_is_omap24xx())
-		l |= OMAP_DMA_CCR_EN;
+	if (cpu_is_omap2420() ||
+	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
+		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
 	l |= OMAP_DMA_CCR_EN;
 	dma_write(l, CCR(lch));
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index af3a039..776ba44 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -335,6 +335,7 @@
 #define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
 
 #define OMAP_DMA_CCR_EN			(1 << 7)
+#define OMAP_DMA_CCR_BUFFERING_DISABLE	(1 << 25)
 
 #define OMAP_DMA_DATA_TYPE_S8		0x00
 #define OMAP_DMA_DATA_TYPE_S16		0x01
-- 
1.7.3

