From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 05/11] spi/pl022: Convert to core runtime PM
Date: Sun, 28 Jul 2013 15:43:20 +0100
Message-ID: <1375022606-7576-5-git-send-email-broonie@kernel.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59135 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3G1OoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:44:09 -0400
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-pl022.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index abef061..07e6db6 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1555,18 +1555,6 @@ static int pl022_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int pl022_prepare_transfer_hardware(struct spi_master *master)
-{
-	struct pl022 *pl022 = spi_master_get_devdata(master);
-
-	/*
-	 * Just make sure we have all we need to run the transfer by syncing
-	 * with the runtime PM framework.
-	 */
-	pm_runtime_get_sync(&pl022->adev->dev);
-	return 0;
-}
-
 static int pl022_unprepare_transfer_hardware(struct spi_master *master)
 {
 	struct pl022 *pl022 = spi_master_get_devdata(master);
@@ -1575,13 +1563,6 @@ static int pl022_unprepare_transfer_hardware(struct spi_master *master)
 	writew((readw(SSP_CR1(pl022->virtbase)) &
 		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 
-	if (pl022->master_info->autosuspend_delay > 0) {
-		pm_runtime_mark_last_busy(&pl022->adev->dev);
-		pm_runtime_put_autosuspend(&pl022->adev->dev);
-	} else {
-		pm_runtime_put(&pl022->adev->dev);
-	}
-
 	return 0;
 }
 
@@ -2139,7 +2120,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->num_chipselect = num_cs;
 	master->cleanup = pl022_cleanup;
 	master->setup = pl022_setup;
-	master->prepare_transfer_hardware = pl022_prepare_transfer_hardware;
+	master->auto_runtime_pm = true;
 	master->transfer_one_message = pl022_transfer_one_message;
 	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
 	master->rt = platform_info->rt;
-- 
1.8.3.2

