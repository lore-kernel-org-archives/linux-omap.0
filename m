From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 2/4] mtd: rawnand: ams-delta: Request data port GPIO resource
Date: Wed, 21 Nov 2018 12:08:04 +0100
Message-ID: <20181121110806.32076-3-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Data port used by the driver is actually an OMAP MPUIO device, already
under control of gpio-omap driver.  For that reason we used to not
request the memory region of the port as that would fail because the
region is already busy.  Despite that, we are still accessing the port
by just ioremapping it and performing read/write operations.  Moreover,
we are doing that without any proteciton from other users legally
manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over GPIO consumer
API.  Before that happens, already prevent from other users accessing
the port pins by requesting an array of its GPIO descriptors.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/ams-delta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index f8eb4a419e77..bb50dda05654 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -190,6 +190,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
+	struct gpio_descs *data_gpiods;
 	int err = 0;
 
 	if (!res)
@@ -275,8 +276,14 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto err_unmap;
 	}
 
-	/* Initialize data port direction to a known state */
-	ams_delta_dir_input(priv, true);
+	/* Request array of data pins, initialize them as input */
+	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(data_gpiods)) {
+		err = PTR_ERR(data_gpiods);
+		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
+		goto err_unmap;
+	}
+	priv->data_in = true;
 
 	/* Initialize the NAND controller object embedded in ams_delta_nand. */
 	priv->base.ops = &ams_delta_ops;
-- 
2.18.1
