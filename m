From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 12/14] mtd: rawnand: ams-delta: Drop useless local variable
Date: Wed, 12 Feb 2020 01:39:27 +0100
Message-ID: <20200212003929.6682-13-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46659 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgBLAka (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so229912ljd.13
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:28 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

For consistency with adjacent code patterns used in the driver probe
function, store data GPIO array pointer directly in a respective field
of the driver private structure instead of storing it intermediately
in a local variable for error checking.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 97e3b6629c72..a68b7006ed69 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -230,7 +230,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct gpio_descs *data_gpiods;
 	int (*probe)(struct platform_device *pdev, struct ams_delta_nand *priv);
 	int err = 0;
 
@@ -312,13 +311,12 @@ static int ams_delta_init(struct platform_device *pdev)
 	}
 
 	/* Request array of data pins, initialize them as input */
-	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
-	if (IS_ERR(data_gpiods)) {
-		err = PTR_ERR(data_gpiods);
+	priv->data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(priv->data_gpiods)) {
+		err = PTR_ERR(priv->data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
 		return err;
 	}
-	priv->data_gpiods = data_gpiods;
 	priv->data_in = true;
 
 	if (pdev->id_entry)
-- 
2.24.1
