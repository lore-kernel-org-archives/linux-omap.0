From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 11/14] mtd: rawnand: ams-delta: Support custom driver initialisation
Date: Wed, 12 Feb 2020 01:39:26 +0100
Message-ID: <20200212003929.6682-12-jmkrzyszt@gmail.com>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39799 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgBLAka (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id t23so269789lfk.6
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:27 -0800 (PST)
In-Reply-To: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

In preparation for extending the driver with custom I/O support, try to
obtain device specific initialisation routine from a matching device
table entry and run it as an additional step of device probe.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 9857ce25debf..97e3b6629c72 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/nand-gpio.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
@@ -230,6 +231,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct nand_chip *this;
 	struct mtd_info *mtd;
 	struct gpio_descs *data_gpiods;
+	int (*probe)(struct platform_device *pdev, struct ams_delta_nand *priv);
 	int err = 0;
 
 	if (pdata) {
@@ -319,6 +321,15 @@ static int ams_delta_init(struct platform_device *pdev)
 	priv->data_gpiods = data_gpiods;
 	priv->data_in = true;
 
+	if (pdev->id_entry)
+		probe = (void *) pdev->id_entry->driver_data;
+	else
+		probe = of_device_get_match_data(&pdev->dev);
+	if (probe)
+		err = probe(pdev, priv);
+	if (err)
+		return err;
+
 	/* Initialize the NAND controller object embedded in ams_delta_nand. */
 	priv->base.ops = &ams_delta_ops;
 	nand_controller_init(&priv->base);
-- 
2.24.1
