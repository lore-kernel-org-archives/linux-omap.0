From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 04/11] spi/omap2: Covert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:19 +0100
Message-ID: <1375022606-7576-4-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59127 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab3G1Oo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:44:28 -0400
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-omap2-mcspi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 5994039..973c1cb 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -335,23 +335,6 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 }
 
-static int omap2_prepare_transfer(struct spi_master *master)
-{
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
-
-	pm_runtime_get_sync(mcspi->dev);
-	return 0;
-}
-
-static int omap2_unprepare_transfer(struct spi_master *master)
-{
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
-
-	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
-	return 0;
-}
-
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
 	unsigned long timeout;
@@ -1318,8 +1301,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = omap2_mcspi_setup;
-	master->prepare_transfer_hardware = omap2_prepare_transfer;
-	master->unprepare_transfer_hardware = omap2_unprepare_transfer;
+	master->auto_runtime_pm = true;
 	master->transfer_one_message = omap2_mcspi_transfer_one_message;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
-- 
1.8.3.2

