From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer resolution on read/write
Date: Thu, 19 Jul 2018 01:57:06 +0200
Message-ID: <20180718235710.18242-5-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Further optimize processing speed of read/write callback functions by
resolving private structure pointer only once per callback and passing
it to all subfunctions instead of mtd_info.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 44 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index dfefcd79b420..d7e4c9dbef67 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -72,10 +72,9 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 
 	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
@@ -83,21 +82,18 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 
-	ams_delta_write_next_byte(mtd, byte);
+	ams_delta_write_next_byte(priv, byte);
 }
 
-static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 	u_char res;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
@@ -108,36 +104,46 @@ static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
 	return res;
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_first_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 
-	return ams_delta_read_next_byte(mtd);
+	return ams_delta_read_next_byte(priv);
+}
+
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+
+	return ams_delta_read_first_byte(priv);
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (len > 0)
-		ams_delta_write_byte(mtd, buf[0]);
+		ams_delta_write_first_byte(priv, buf[0]);
 	for (i = 1; i < len; i++)
-		ams_delta_write_next_byte(mtd, buf[i]);
+		ams_delta_write_next_byte(priv, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (len > 0)
-		buf[0] = ams_delta_read_byte(mtd);
+		buf[0] = ams_delta_read_first_byte(priv);
 	for (i = 1; i < len; i++)
-		buf[i] = ams_delta_read_next_byte(mtd);
+		buf[i] = ams_delta_read_next_byte(priv);
 }
 
 /*
@@ -161,7 +167,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+		ams_delta_write_first_byte(priv, cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
-- 
2.16.4
