From: Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org>
Subject: Re: [PATCHv3 1/6] SPI omap2_mcspi.c: Check
 params before dereference or use
Date: Mon, 24 May 2010 10:20:27 -0400
Message-ID: <1274710827.2888.9.camel@quad>
References: <1268406713.14445.50.camel@quad>
	<AANLkTikCydr_Nj446sySru774pY2jXLKNUNVfW3LSK9R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTikCydr_Nj446sySru774pY2jXLKNUNVfW3LSK9R-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Check spi->chip_select for range before use.

The spi->controller_state check is already in 2.6.34-rc7

Signed-off-by: Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org>

 drivers/spi/omap2_mcspi.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index e0de0d0..0b35468 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -755,7 +755,6 @@ static void omap2_mcspi_cleanup(struct spi_device
*spi)
 	struct omap2_mcspi_cs	*cs;
 
 	mcspi = spi_master_get_devdata(spi->master);
-	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
 	if (spi->controller_state) {
 		/* Unlink controller state from context save list */
@@ -765,13 +764,17 @@ static void omap2_mcspi_cleanup(struct spi_device
*spi)
 		kfree(spi->controller_state);
 	}
 
-	if (mcspi_dma->dma_rx_channel != -1) {
-		omap_free_dma(mcspi_dma->dma_rx_channel);
-		mcspi_dma->dma_rx_channel = -1;
-	}
-	if (mcspi_dma->dma_tx_channel != -1) {
-		omap_free_dma(mcspi_dma->dma_tx_channel);
-		mcspi_dma->dma_tx_channel = -1;
+	if (spi->chip_select < spi->master->num_chipselect) {
+		mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+
+		if (mcspi_dma->dma_rx_channel != -1) {
+			omap_free_dma(mcspi_dma->dma_rx_channel);
+			mcspi_dma->dma_rx_channel = -1;
+		}
+		if (mcspi_dma->dma_tx_channel != -1) {
+			omap_free_dma(mcspi_dma->dma_tx_channel);
+			mcspi_dma->dma_tx_channel = -1;
+		}
 	}
 }


------------------------------------------------------------------------------
