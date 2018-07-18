From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
Date: Thu, 19 Jul 2018 01:57:09 +0200
Message-ID: <20180718235710.18242-8-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

The plan is to replace data port readw()/writew() operations with GPIO
callbacks provided by gpio-omap driver.  For acceptable performance the
GPIO chip must support get/set_multiple() GPIO callbacks.

In order to avoid data corruption, we require the array of data GPIO
descriptors obtained with gpiod_get_array() to meet some strict
requirements:
- all pins must belong to the same single GPIO chip,
- array index of each pin descriptor must match its hardware number,
- pin polarity must not be inverted,
- pin hardware configuration must not be open drain nor open source.

Let's implement the above described sanity checks before replacing the
readw()/writew() operations witn GPIO callbacks.  If a check fails,
return -EINVAL to indicate the board provided GPIO setup is invalid.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 87 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index ad62c0245458..bd501f385e78 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -190,7 +191,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
 	struct gpio_descs *data_gpiods;
-	int err = 0;
+	struct gpio_chip *data_gpioc;
+	unsigned long mask, bits;
+	int i, err = 0;
 
 	if (!res)
 		return -ENXIO;
@@ -298,6 +301,88 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_mtd;
 	}
 
+	/* Use GPIO chip of first data GPIO pin descriptor */
+	data_gpioc = gpiod_to_chip(data_gpiods->desc[0]);
+
+	/*
+	 * For acceptable performance require the data GPIO
+	 * chip to support get/set_multiple() callbacks.
+	 */
+	if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
+		err = -EINVAL;
+		dev_err(&pdev->dev,
+			"data GPIO chip does not support get/set_multiple()\n");
+		goto out_mtd;
+	}
+
+	/* Verify if get_multiple() returns all pins low as initialized above */
+	mask = (1 << data_gpiods->ndescs) - 1;
+	err = data_gpioc->get_multiple(data_gpioc, &mask, &bits);
+	if (err) {
+		dev_err(&pdev->dev,
+			"data GPIO chip get_multiple() failed: %d\n", err);
+		goto out_mtd;
+	}
+	if (bits) {
+		err = -EINVAL;
+		dev_err(&pdev->dev,
+			"mismmatch of data GPIO initial value: %lu\n", bits);
+		goto out_mtd;
+	}
+
+	/* Verify each data GPIO pin */
+	for (i = 0; i < data_gpiods->ndescs; i++) {
+		/* Require all pins belong to the same GPIO chip */
+		if (gpiod_to_chip(data_gpiods->desc[i]) != data_gpioc) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "GPIO chip mismatch of data bit %d\n",
+				i);
+			goto out_mtd;
+		}
+
+		/* Require all pins active high (not inverted) */
+		if (gpiod_is_active_low(data_gpiods->desc[i])) {
+			err = -EINVAL;
+			dev_err(&pdev->dev,
+				"unsupported polarity of data GPIO bit %d\n",
+				i);
+			goto out_mtd;
+		}
+
+		/*
+		 * Require pin gpiod array index to match hardware pin number.
+		 * Verified by setting the pin high with gpiod_set_raw_value()
+		 * then reading it back with gpiochip->get() for comparison.
+		 */
+		gpiod_set_raw_value(data_gpiods->desc[i], 1);
+		err = data_gpioc->get(data_gpioc, i);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"data bit %d GPIO chip get() failed: %d\n", i,
+				err);
+			goto out_mtd;
+		}
+		if (!err) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "mismatch of data GPIO bit %d value\n",
+				i);
+			goto out_mtd;
+		}
+
+		/*
+		 * Check for unsupported pin hardware configuration.  Use
+		 * just verified gpiod array index as hardware pin number.
+		 */
+		if (gpiochip_line_is_open_drain(data_gpioc, i) ||
+		    gpiochip_line_is_open_source(data_gpioc, i)) {
+			err = -EINVAL;
+			dev_err(&pdev->dev,
+				"unsupported mode of data GPIO bit %d\n",
+				i);
+			goto out_mtd;
+		}
+	}
+
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-- 
2.16.4
