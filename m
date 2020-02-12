From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 01/14 v2] mtd: rawnand: ams-delta: Write protect device during probe
Date: Wed, 12 Feb 2020 01:39:16 +0100
Message-ID: <20200212003929.6682-2-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35401 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBLAkP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so281837ljb.2
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:14 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Initialise NWP GPIO pin as asserted to protect the device from hazard
during setup of other GPIO pins.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
v2: release write protection before calling nand_scan()

 drivers/mtd/nand/raw/ams-delta.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 8312182088c1..2501cfe00f43 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -251,8 +251,8 @@ static int ams_delta_init(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/* Set chip enabled, but  */
-	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	/* Set chip enabled but write protected */
+	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
@@ -309,6 +309,17 @@ static int ams_delta_init(struct platform_device *pdev)
 	nand_controller_init(&priv->base);
 	this->controller = &priv->base;
 
+	/*
+	 * FIXME: We should release write protection only after nand_scan() to
+	 * be on the safe side but we can't do that until we have a generic way
+	 * to assert/deassert WP from the core.  Even if the core shouldn't
+	 * write things in the nand_scan() path, it should have control on this
+	 * pin just in case we ever need to disable write protection during
+	 * chip detection/initialization.
+	 */
+	/* Release write protection */
+	gpiod_set_value(priv->gpiod_nwp, 1);
+
 	/* Scan to find existence of the device */
 	err = nand_scan(this, 1);
 	if (err)
@@ -336,6 +347,9 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
 
+	/* Apply write protection */
+	gpiod_set_value(priv->gpiod_nwp, 0);
+
 	/* Unregister device */
 	nand_release(mtd_to_nand(mtd));
 
-- 
2.24.1
