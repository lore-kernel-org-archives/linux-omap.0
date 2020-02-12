From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 10/14] mtd: rawnand: ams-delta: Add module device tables
Date: Wed, 12 Feb 2020 01:39:25 +0100
Message-ID: <20200212003929.6682-11-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45514 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgBLAk1 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so248858lfa.12
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:26 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

In preparation for merging the driver with "gpio-nand", introduce
module device tables where new device models can be accommodated as
soon as respective support is added.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 0c88e94e9b71..9857ce25debf 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -370,11 +370,29 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id gpio_nand_of_id_table[] = {
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, gpio_nand_of_id_table);
+
+static const struct platform_device_id gpio_nand_plat_id_table[] = {
+	{
+		.name	= "ams-delta-nand",
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, gpio_nand_plat_id_table);
+
 static struct platform_driver ams_delta_nand_driver = {
 	.probe		= ams_delta_init,
 	.remove		= ams_delta_cleanup,
+	.id_table	= gpio_nand_plat_id_table,
 	.driver		= {
 		.name	= "ams-delta-nand",
+		.of_match_table = of_match_ptr(gpio_nand_of_id_table),
 	},
 };
 
-- 
2.24.1
