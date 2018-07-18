From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction once per transfer
Date: Thu, 19 Jul 2018 01:57:05 +0200
Message-ID: <20180718235710.18242-4-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

In its current shape, the driver sets data port direction before each
byte read/write operation, even during multi-byte transfers.  Optimize
that by setting the port direction only on first byte of each transfer.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 6ac38e9cfa1a..dfefcd79b420 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -72,50 +72,72 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
-	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
+	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+
+	ams_delta_write_next_byte(mtd, byte);
+}
+
+static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	u_char res;
+
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
 
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
+
+	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+
+	return ams_delta_read_next_byte(mtd);
+}
+
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	if (len > 0)
+		ams_delta_write_byte(mtd, buf[0]);
+	for (i = 1; i < len; i++)
+		ams_delta_write_next_byte(mtd, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	if (len > 0)
+		buf[0] = ams_delta_read_byte(mtd);
+	for (i = 1; i < len; i++)
+		buf[i] = ams_delta_read_next_byte(mtd);
 }
 
 /*
-- 
2.16.4
