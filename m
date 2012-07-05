From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] spi: omap2-mcspi: Fix the dma_unmap warning
Date: Thu, 5 Jul 2012 14:53:27 +0530
Message-ID: <1341480207-5651-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Shubhrajyoti, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The dma_map and dma_unmap should have same parameter
passed otherwise we get the below warn.

ks8851 spi1.0: DMA-API: device driver tries to free DMA memory it has not allocated [device address=0x000000009f22]

[    2.066925] Modules linked in:
[    2.070312]
[    2.071929] [<c001c250>] (unwind_backtrace+0x0/0x130) from [<c0043d84>] (warn_slowpath_common+0x4c/0x64)
[    2.081909] [<c0043d84>] (warn_slowpath_common+0x4c/0x64) from [<c0043e30>] (warn_slowpath_fmt+0x30/0x40)
[    2.091949] [<c0043e30>] (warn_slowpath_fmt+0x30/0x40) from [<c0293824>] (check_unmap+0x6d0/0x7b0)
[    2.101348] [<c0293824>] (check_unmap+0x6d0/0x7b0) from [<c02939cc>] (debug_dma_unmap_page+0x64/0x70)
[    2.111053] [<c02939cc>] (debug_dma_unmap_page+0x64/0x70) from [<c03519a4>] (omap2_mcspi_txrx_dma+0x2d8/0x4fc)
[    2.121582] [<c03519a4>] (omap2_mcspi_txrx_dma+0x2d8/0x4fc) from [<c03524d8>] (omap2_mcspi_work.clone.4+0xf0/0x290)
[    2.132537] [<c03524d8>] (omap2_mcspi_work.clone.4+0xf0/0x290) from [<c0352900>] (omap2_mcspi_transfer_one_message+0x288/0x438)
[    2.144592] [<c0352900>] (omap2_mcspi_transfer_one_message+0x288/0x438) from [<c03503bc>] (spi_pump_messages+0x100/0x160)
[    2.156127] [<c03503bc>] (spi_pump_messages+0x100/0x160) from [<c006635c>] (kthread_worker_fn+0xac/0x180)
[    2.166168] [<c006635c>] (kthread_worker_fn+0xac/0x180) from [<c0066578>] (kthread+0x90/0x9c)
[    2.175140] [<c0066578>] (kthread+0x90/0x9c) from [<c00157fc>] (kernel_thread_exit+0x0/0x8)
[    2.183898] ---[ end trace d1830ce6e44292f2 ]---

Fix the warn by changing the unmap parameter to the one used while doing
dma_map.

Reported-by: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0c73dd4..37ccdb7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -388,7 +388,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
-		dma_unmap_single(&spi->dev, xfer->tx_dma, count, DMA_TO_DEVICE);
+		dma_unmap_single(mcspi->dev, xfer->tx_dma, count,
+				 DMA_TO_DEVICE);
 
 		/* for TX_ONLY mode, be sure all words have shifted out */
 		if (rx == NULL) {
@@ -403,7 +404,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (rx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
-		dma_unmap_single(&spi->dev, xfer->rx_dma, count, DMA_FROM_DEVICE);
+		dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
+				 DMA_FROM_DEVICE);
 		omap2_mcspi_set_enable(spi, 0);
 
 		if (l & OMAP2_MCSPI_CHCONF_TURBO) {
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
