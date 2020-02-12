From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 09/14] mtd: rawnand: ams-delta: Handle more GPIO pins as optional
Date: Wed, 12 Feb 2020 01:39:24 +0100
Message-ID: <20200212003929.6682-10-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37841 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgBLAk1 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id v17so272166ljg.4
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:25 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

In order to make the driver more useful on platforms other than Amstrad
Delta, allow GPIO descriptor pointers of possibly non-critical NWP and
NCE pins to be initialised as NULL.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index c481d73e3dcb..0c88e94e9b71 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -264,14 +264,16 @@ static int ams_delta_init(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Set chip enabled but write protected */
-	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	priv->gpiod_nwp = devm_gpiod_get_optional(&pdev->dev, "nwp",
+						  GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
 		return err;
 	}
 
-	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_LOW);
+	priv->gpiod_nce = devm_gpiod_get_optional(&pdev->dev, "nce",
+						  GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_nce)) {
 		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
-- 
2.24.1
