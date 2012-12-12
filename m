From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] spi: omap2: disable DMA requests before complete()
Date: Wed, 12 Dec 2012 10:45:59 +0200
Message-ID: <1355301960-21523-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

No actual errors have been found for completing
before disabling DMA request lines, but it just
looks more semantically correct that on our DMA
callback we quiesce the whole thing before stating
transfer is finished.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b610f52..68446db 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -298,10 +298,10 @@ static void omap2_mcspi_rx_callback(void *data)
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	complete(&mcspi_dma->dma_rx_completion);
-
 	/* We must disable the DMA RX request */
 	omap2_mcspi_set_dma_req(spi, 1, 0);
+
+	complete(&mcspi_dma->dma_rx_completion);
 }
 
 static void omap2_mcspi_tx_callback(void *data)
@@ -310,10 +310,10 @@ static void omap2_mcspi_tx_callback(void *data)
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	complete(&mcspi_dma->dma_tx_completion);
-
 	/* We must disable the DMA TX request */
 	omap2_mcspi_set_dma_req(spi, 0, 0);
+
+	complete(&mcspi_dma->dma_tx_completion);
 }
 
 static void omap2_mcspi_tx_dma(struct spi_device *spi,
-- 
1.8.1.rc1.5.g7e0651a
