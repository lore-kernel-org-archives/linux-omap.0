From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 07/11] spi/hspi: Convert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:22 +0100
Message-ID: <1375022606-7576-7-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-sh-hspi.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index daf2bf2..0b68cb5 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -99,21 +99,6 @@ static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u32 val)
 /*
  *		spi master function
  */
-static int hspi_prepare_transfer(struct spi_master *master)
-{
-	struct hspi_priv *hspi = spi_master_get_devdata(master);
-
-	pm_runtime_get_sync(hspi->dev);
-	return 0;
-}
-
-static int hspi_unprepare_transfer(struct spi_master *master)
-{
-	struct hspi_priv *hspi = spi_master_get_devdata(master);
-
-	pm_runtime_put_sync(hspi->dev);
-	return 0;
-}
 
 #define hspi_hw_cs_enable(hspi)		hspi_hw_cs_ctrl(hspi, 0)
 #define hspi_hw_cs_disable(hspi)	hspi_hw_cs_ctrl(hspi, 1)
@@ -316,9 +301,8 @@ static int hspi_probe(struct platform_device *pdev)
 	master->setup		= hspi_setup;
 	master->cleanup		= hspi_cleanup;
 	master->mode_bits	= SPI_CPOL | SPI_CPHA;
-	master->prepare_transfer_hardware	= hspi_prepare_transfer;
+	master->auto_runtime_pm = true;
 	master->transfer_one_message		= hspi_transfer_one_message;
-	master->unprepare_transfer_hardware	= hspi_unprepare_transfer;
 	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-- 
1.8.3.2
