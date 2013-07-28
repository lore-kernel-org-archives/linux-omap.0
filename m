From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/11] spi/s3c64xx: Use core for runtime PM
Date: Sun, 28 Jul 2013 15:43:23 +0100
Message-ID: <1375022606-7576-8-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375022606-7576-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c9d0b12..62f32c4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -356,8 +356,6 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	while (!is_polling(sdd) && !acquire_dma(sdd))
 		usleep_range(10000, 11000);
 
-	pm_runtime_get_sync(&sdd->pdev->dev);
-
 	return 0;
 }
 
@@ -372,7 +370,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 		sdd->ops->release((enum dma_ch)sdd->tx_dma.ch,
 					&s3c64xx_spi_dma_client);
 	}
-	pm_runtime_put(&sdd->pdev->dev);
 
 	return 0;
 }
@@ -1375,6 +1372,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					SPI_BPW_MASK(8);
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->auto_runtime_pm = true;
 
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sdd->regs)) {
-- 
1.8.3.2
