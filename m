From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ti-qspi: Use dma_engine wrapper for dma memcpy call" to the spi tree
Date: Fri, 24 Mar 2017 19:17:06 +0000
Message-ID: <E1crUhu-0006HD-39@debutante>
References: <20170324064215.7326-1-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170324064215.7326-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: spi-ti-qspi: Use dma_engine wrapper for dma memcpy call

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1351aaeb50b2ae5eb5469b3d3d0a84073a127a39 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Fri, 24 Mar 2017 12:12:15 +0530
Subject: [PATCH] spi: spi-ti-qspi: Use dma_engine wrapper for dma memcpy call

Instead of calling device_prep_dma_memcpy() directly with dma_device
pointer, use the newly introduced dmaengine_prep_dma_memcpy() wrapper
API.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ec6fb09e2e17..bd19a20a122e 100644
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
