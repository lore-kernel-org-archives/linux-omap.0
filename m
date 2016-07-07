From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH v3 1/4] spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
Date: Thu,  7 Jul 2016 12:17:48 -0500
Message-ID: <1467911871-4508-2-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467911871-4508-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP35x and OMAP37x mentions in the McSPI End-of-Transfer Sequences section
that if the McSPI is configured as a Master and only DMA RX is being
performed then the DMA transfer size needs to be reduced by 1 or 2.

This was originally implemented by:
commit 57c5c28dbc83 ("spi: omap2_mcspi rxdma bugfix")

This patch adds comments to clarify what is going on in the code since its
not obvious what problem its addressing.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1d237e9..c47f958 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -459,6 +459,11 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	count = xfer->len;
 	dma_count = xfer->len;
 
+	/*
+	 *  In the "End-of-Transfer Procedure" section for DMA RX in OMAP35x TRM
+	 *  it mentions reducing DMA transfer length by one element in master
+	 *  normal mode.
+	 */
 	if (mcspi->fifo_depth == 0)
 		dma_count -= es;
 
@@ -478,6 +483,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
+		/*
+		 *  Reduce DMA transfer length by one more if McSPI is
+		 *  configured in turbo mode.
+		 */
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
 			dma_count -= es;
 
@@ -507,6 +516,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	if (mcspi->fifo_depth > 0)
 		return count;
 
+	/*
+	 *  Due to the DMA transfer length reduction the missing bytes must
+	 *  be read manually to receive all of the expected data.
+	 */
 	omap2_mcspi_set_enable(spi, 0);
 
 	elements = element_count - 1;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
