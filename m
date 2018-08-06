From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
Date: Tue,  7 Aug 2018 00:29:17 +0200
Message-ID: <20180806222918.12644-12-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Try to address the driver performance issues by replacing traditional
get/set array function calls with their bitmap based equivalents.

As long as fast bitmap processing path is not implemented in the new
API extension, performance of the driver remains unchanged.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 30c461138195..7b08b2c441d3 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -78,15 +78,9 @@ static void ams_delta_write_commit(struct ams_delta_nand *priv)
 
 static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct gpio_descs *data_gpiods = priv->data_gpiods;
 	unsigned long bits = byte;
-	int i, value_array[data_gpiods->ndescs];
-
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		value_array[i] = test_bit(i, &bits);
 
-	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
-				  value_array);
+	gpiod_set_raw_array_bitmap(priv->data_gpiods, &bits);
 
 	ams_delta_write_commit(priv);
 }
@@ -106,22 +100,15 @@ static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
 
 static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct gpio_descs *data_gpiods = priv->data_gpiods;
-	unsigned long bits = 0;
-	int i, value_array[data_gpiods->ndescs];
+	unsigned long bits;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 
-	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
-				  value_array);
+	gpiod_get_raw_array_bitmap(priv->data_gpiods, &bits);
 
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		if (value_array[i])
-			__set_bit(i, &bits);
-
 	return bits;
 }
 
-- 
2.16.4
