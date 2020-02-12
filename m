From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 08/14] mtd: rawnand: ams-delta: Make read pulses optional
Date: Wed, 12 Feb 2020 01:39:23 +0100
Message-ID: <20200212003929.6682-9-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36778 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgBLAkZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so278576ljg.3
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:23 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Allow platforms to omit NRE pin from device configuration by requesting
that pin as optional.  In that case, also don't apply read pulse width
from chip SDR timings.  There should be no need for further code
adjustments as gpiolib can handle NULL GPIO descriptor pointers.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 11689218d23a..c481d73e3dcb 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -202,8 +202,10 @@ static int ams_delta_setup_data_interface(struct nand_chip *this, int csline,
 	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
-	priv->tRP = DIV_ROUND_UP(sdr->tRP_min, 1000);
-	dev_dbg(dev, "using %u ns read pulse width\n", priv->tRP);
+	if (priv->gpiod_nre) {
+		priv->tRP = DIV_ROUND_UP(sdr->tRP_min, 1000);
+		dev_dbg(dev, "using %u ns read pulse width\n", priv->tRP);
+	}
 
 	priv->tWP = DIV_ROUND_UP(sdr->tWP_min, 1000);
 	dev_dbg(dev, "using %u ns write pulse width\n", priv->tWP);
@@ -276,7 +278,8 @@ static int ams_delta_init(struct platform_device *pdev)
 		return err;
 	}
 
-	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_LOW);
+	priv->gpiod_nre = devm_gpiod_get_optional(&pdev->dev, "nre",
+						  GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_nre)) {
 		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
-- 
2.24.1
