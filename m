From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/11] spi/tegra20-sflash: Use core runtime PM
Date: Sun, 28 Jul 2013 15:43:25 +0100
Message-ID: <1375022606-7576-10-git-send-email-broonie@kernel.org>
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
 drivers/spi/spi-tegra20-sflash.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index f871c4e..1d814dc 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -325,20 +325,6 @@ static int tegra_sflash_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int tegra_sflash_prepare_transfer(struct spi_master *spi)
-{
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(spi);
-	int ret;
-
-	ret = pm_runtime_get_sync(tsd->dev);
-	if (ret < 0) {
-		dev_err(tsd->dev, "runtime PM get failed: %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
 static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -391,15 +377,6 @@ exit:
 	return ret;
 }
 
-static int tegra_sflash_unprepare_transfer(struct spi_master *spi)
-{
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(spi);
-
-	pm_runtime_put(tsd->dev);
-
-	return 0;
-}
-
 static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 {
 	struct spi_transfer *t = tsd->curr_xfer;
@@ -492,9 +469,8 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->setup = tegra_sflash_setup;
-	master->prepare_transfer_hardware = tegra_sflash_prepare_transfer;
 	master->transfer_one_message = tegra_sflash_transfer_one_message;
-	master->unprepare_transfer_hardware = tegra_sflash_unprepare_transfer;
+	master->auto_runtime_pm = true;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->bus_num = -1;
 
-- 
1.8.3.2
