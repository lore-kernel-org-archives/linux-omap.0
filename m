From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch" to the spi tree
Date: Tue, 15 Jan 2019 19:08:37 +0000 (GMT)
Message-ID: <20190115190837.4BBE11127848@debutante.sirena.org.uk>
References: <20190115065832.23705-1-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115065832.23705-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: stable@vger.kernel.org, David Lechner <david@lechnology.com>David Lechner <david@lechnology.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>David Lechner <david@lechnology.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From baf8b9f8d260c55a86405f70a384c29cda888476 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Tue, 15 Jan 2019 12:28:32 +0530
Subject: [PATCH] spi: omap2-mcspi: Fix DMA and FIFO event trigger size
 mismatch

Commit b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
broke SPI transfers where bits_per_word != 8. This is because of
mimsatch between McSPI FIFO level event trigger size (SPI word length) and
DMA request size(word length * maxburst). This leads to data
corruption, lockup and errors like:

	spi1.0: EOW timed out

Fix this by setting DMA maxburst size to 1 so that
McSPI FIFO level event trigger size matches DMA request size.

Fixes: b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
Cc: stable@vger.kernel.org
Reported-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2fd8881fcd65..8be304379628 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = es;
-	cfg.dst_maxburst = es;
+	cfg.src_maxburst = 1;
+	cfg.dst_maxburst = 1;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.20.1
