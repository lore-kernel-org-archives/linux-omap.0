From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 03/11] spi/coldfire-qspi: Convert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:18 +0100
Message-ID: <1375022606-7576-3-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59114 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab3G1Oo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:44:26 -0400
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-coldfire-qspi.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 0631b9d..e4265ea 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -354,24 +354,6 @@ static int mcfqspi_transfer_one_message(struct spi_master *master,
 
 }
 
-static int mcfqspi_prepare_transfer_hw(struct spi_master *master)
-{
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
-
-	pm_runtime_get_sync(mcfqspi->dev);
-
-	return 0;
-}
-
-static int mcfqspi_unprepare_transfer_hw(struct spi_master *master)
-{
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
-
-	pm_runtime_put_sync(mcfqspi->dev);
-
-	return 0;
-}
-
 static int mcfqspi_setup(struct spi_device *spi)
 {
 	if (spi->chip_select >= spi->master->num_chipselect) {
@@ -473,8 +455,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
 	master->setup = mcfqspi_setup;
 	master->transfer_one_message = mcfqspi_transfer_one_message;
-	master->prepare_transfer_hardware = mcfqspi_prepare_transfer_hw;
-	master->unprepare_transfer_hardware = mcfqspi_unprepare_transfer_hw;
+	master->auto_runtime_pm = true;
 
 	platform_set_drvdata(pdev, master);
 
-- 
1.8.3.2

