From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] spi: spi-ti-qspi: Use dma_engine wrapper for dma memcpy call
Date: Fri, 24 Mar 2017 12:12:15 +0530
Message-ID: <20170324064215.7326-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Instead of calling device_prep_dma_memcpy() directly with dma_device
pointer, use the newly introduced dmaengine_prep_dma_memcpy() wrapper
API.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ad76a44fee6f..5c8b48e39715 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -401,8 +401,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	struct dma_async_tx_descriptor *tx;
 	int ret;
 
-	tx = dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
-					     len, flags);
+	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
 	if (!tx) {
 		dev_err(qspi->dev, "device_prep_dma_memcpy error\n");
 		return -EIO;
-- 
2.11.0
