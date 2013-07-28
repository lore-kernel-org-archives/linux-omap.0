From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 02/11] spi/bcm63xx: Convert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:17 +0100
Message-ID: <1375022606-7576-2-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59101 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab3G1OoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:44:24 -0400
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-bcm63xx.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 9fd7a39..4ac028d 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -231,24 +231,6 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	return 0;
 }
 
-static int bcm63xx_spi_prepare_transfer(struct spi_master *master)
-{
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
-
-	pm_runtime_get_sync(&bs->pdev->dev);
-
-	return 0;
-}
-
-static int bcm63xx_spi_unprepare_transfer(struct spi_master *master)
-{
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
-
-	pm_runtime_put(&bs->pdev->dev);
-
-	return 0;
-}
-
 static int bcm63xx_spi_transfer_one(struct spi_master *master,
 					struct spi_message *m)
 {
@@ -412,11 +394,10 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->num_chipselect;
-	master->prepare_transfer_hardware = bcm63xx_spi_prepare_transfer;
-	master->unprepare_transfer_hardware = bcm63xx_spi_unprepare_transfer;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->auto_runtime_pm = true;
 	bs->msg_type_shift = pdata->msg_type_shift;
 	bs->msg_ctl_width = pdata->msg_ctl_width;
 	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
-- 
1.8.3.2

