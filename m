From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 05/14] mtd: rawnand: ams-delta: Enable OF partition info support
Date: Wed, 12 Feb 2020 01:39:20 +0100
Message-ID: <20200212003929.6682-6-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgBLAkU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so239979ljj.11
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:19 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Provide MTD layer with device OF node info required by OF partition
parser.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 25f121adea6f..fb96f6a3b0b3 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -222,6 +222,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd->dev.parent = &pdev->dev;
 
 	nand_set_controller_data(this, priv);
+	nand_set_flash_node(this, pdev->dev.of_node);
 
 	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(priv->gpiod_rdy)) {
-- 
2.24.1
