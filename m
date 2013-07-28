From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 06/11] spi/pxa2xx: Convert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:21 +0100
Message-ID: <1375022606-7576-6-git-send-email-broonie@kernel.org>
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
 drivers/spi/spi-pxa2xx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e0fd6f6..2eb06ee 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -811,14 +811,6 @@ static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int pxa2xx_spi_prepare_transfer(struct spi_master *master)
-{
-	struct driver_data *drv_data = spi_master_get_devdata(master);
-
-	pm_runtime_get_sync(&drv_data->pdev->dev);
-	return 0;
-}
-
 static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
 {
 	struct driver_data *drv_data = spi_master_get_devdata(master);
@@ -827,8 +819,6 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
 	write_SSCR0(read_SSCR0(drv_data->ioaddr) & ~SSCR0_SSE,
 		    drv_data->ioaddr);
 
-	pm_runtime_mark_last_busy(&drv_data->pdev->dev);
-	pm_runtime_put_autosuspend(&drv_data->pdev->dev);
 	return 0;
 }
 
@@ -1141,8 +1131,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->cleanup = cleanup;
 	master->setup = setup;
 	master->transfer_one_message = pxa2xx_spi_transfer_one_message;
-	master->prepare_transfer_hardware = pxa2xx_spi_prepare_transfer;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
+	master->auto_runtime_pm = true;
 
 	drv_data->ssp_type = ssp->type;
 	drv_data->null_dma_buf = (u32 *)PTR_ALIGN(&drv_data[1], DMA_ALIGNMENT);
-- 
1.8.3.2
