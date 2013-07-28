From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 09/11] spi/tegra114: Use core runtime PM
Date: Sun, 28 Jul 2013 15:43:24 +0100
Message-ID: <1375022606-7576-9-git-send-email-broonie@kernel.org>
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
 drivers/spi/spi-tegra114.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e7d48a1..2e208dc 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -803,20 +803,6 @@ static int tegra_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int tegra_spi_prepare_transfer(struct spi_master *spi)
-{
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi);
-	int ret;
-
-	ret = pm_runtime_get_sync(tspi->dev);
-	if (ret < 0) {
-		dev_err(tspi->dev, "runtime PM get failed: %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -870,15 +856,6 @@ exit:
 	return ret;
 }
 
-static int tegra_spi_unprepare_transfer(struct spi_master *spi)
-{
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi);
-
-	pm_runtime_put(tspi->dev);
-
-	return 0;
-}
-
 static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 {
 	struct spi_transfer *t = tspi->curr_xfer;
@@ -1064,11 +1041,10 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->setup = tegra_spi_setup;
-	master->prepare_transfer_hardware = tegra_spi_prepare_transfer;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-	master->unprepare_transfer_hardware = tegra_spi_unprepare_transfer;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->bus_num = -1;
+	master->auto_runtime_pm = true;
 
 	tspi->master = master;
 	tspi->dev = &pdev->dev;
-- 
1.8.3.2
