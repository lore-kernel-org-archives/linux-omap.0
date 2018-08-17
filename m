From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 11/23] mtd: rawnand: Pass a nand_chip object to
 chip->write_xxx() hooks
Date: Fri, 17 Aug 2018 18:09:10 +0200
Message-ID: <20180817160922.6224-12-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mans Rullgard <mans@mansr.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, Gregory Clement <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-omap@vger.kernel.org

Let's make the raw NAND API consistent by patching all helpers and
hooks to take a nand_chip object instead of an mtd_info one or
remove the mtd_info object when both are passed.

Let's tackle all chip->write_xxx() hooks at once.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |  9 +++---
 drivers/mtd/nand/raw/atmel/nand-controller.c     | 12 +++----
 drivers/mtd/nand/raw/au1550nd.c                  | 34 +++++++++-----------
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  6 ++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  5 ++-
 drivers/mtd/nand/raw/cafe_nand.c                 |  5 ++-
 drivers/mtd/nand/raw/cmx270_nand.c               |  4 +--
 drivers/mtd/nand/raw/cs553x_nand.c               |  9 ++----
 drivers/mtd/nand/raw/davinci_nand.c              |  6 ++--
 drivers/mtd/nand/raw/denali.c                    | 13 ++++----
 drivers/mtd/nand/raw/diskonchip.c                | 20 +++++-------
 drivers/mtd/nand/raw/docg4.c                     | 10 +++---
 drivers/mtd/nand/raw/fsl_elbc_nand.c             | 10 +++---
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  6 ++--
 drivers/mtd/nand/raw/fsl_upm.c                   |  4 +--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  3 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |  5 ++-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  8 ++---
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  6 ++--
 drivers/mtd/nand/raw/mtk_nand.c                  |  8 ++---
 drivers/mtd/nand/raw/mxc_nand.c                  |  8 ++---
 drivers/mtd/nand/raw/nand_base.c                 | 41 ++++++++++--------------
 drivers/mtd/nand/raw/nand_hynix.c                |  2 +-
 drivers/mtd/nand/raw/nandsim.c                   |  9 +++---
 drivers/mtd/nand/raw/ndfc.c                      |  3 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  4 +--
 drivers/mtd/nand/raw/omap2.c                     | 36 ++++++++++++---------
 drivers/mtd/nand/raw/oxnas_nand.c                |  4 +--
 drivers/mtd/nand/raw/pasemi_nand.c               |  5 ++-
 drivers/mtd/nand/raw/plat_nand.c                 | 12 +------
 drivers/mtd/nand/raw/qcom_nandc.c                |  3 +-
 drivers/mtd/nand/raw/r852.c                      |  4 +--
 drivers/mtd/nand/raw/s3c2410.c                   |  6 ++--
 drivers/mtd/nand/raw/sh_flctl.c                  |  6 ++--
 drivers/mtd/nand/raw/socrates_nand.c             |  7 ++--
 drivers/mtd/nand/raw/sunxi_nand.c                |  5 ++-
 drivers/mtd/nand/raw/tango_nand.c                |  8 ++---
 drivers/mtd/nand/raw/tmio_nand.c                 |  4 +--
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  4 +--
 drivers/mtd/nand/raw/xway_nand.c                 |  4 +--
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  4 +--
 include/linux/mtd/rawnand.h                      |  4 +--
 42 files changed, 163 insertions(+), 203 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index eb48c939c4ae..d742b9444429 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -63,9 +63,8 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_byte(struct nand_chip *this, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
@@ -89,13 +88,13 @@ static u_char ams_delta_read_byte(struct nand_chip *this)
 	return res;
 }
 
-static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
+static void ams_delta_write_buf(struct nand_chip *this, const u_char *buf,
 				int len)
 {
 	int i;
 
 	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+		ams_delta_write_byte(this, buf[i]);
 }
 
 static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
@@ -128,7 +127,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+		ams_delta_write_byte(mtd_to_nand(mtd), cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index d2c692622a4f..f15f7fe469cd 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -417,9 +417,8 @@ static u8 atmel_nand_read_byte(struct nand_chip *chip)
 	return ioread8(nand->activecs->io.virt);
 }
 
-static void atmel_nand_write_byte(struct mtd_info *mtd, u8 byte)
+static void atmel_nand_write_byte(struct nand_chip *chip, u8 byte)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 
 	if (chip->options & NAND_BUSWIDTH_16)
@@ -452,9 +451,8 @@ static void atmel_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
 		ioread8_rep(nand->activecs->io.virt, buf, len);
 }
 
-static void atmel_nand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void atmel_nand_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_nand_controller *nc;
 
@@ -841,7 +839,7 @@ static int atmel_nand_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
 	if (ret)
 		return ret;
 
-	atmel_nand_write_buf(mtd, buf, mtd->writesize);
+	atmel_nand_write_buf(chip, buf, mtd->writesize);
 
 	ret = atmel_nand_pmecc_generate_eccbytes(chip, raw);
 	if (ret) {
@@ -851,7 +849,7 @@ static int atmel_nand_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
 
 	atmel_nand_pmecc_disable(chip, raw);
 
-	atmel_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	atmel_nand_write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -942,7 +940,7 @@ static int atmel_hsmc_nand_pmecc_write_pg(struct nand_chip *chip,
 	if (ret)
 		return ret;
 
-	atmel_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	atmel_nand_write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	nc->op.cmds[0] = NAND_CMD_PAGEPROG;
 	nc->op.ncmds = 1;
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 76ea4141eb10..f1cc9f672262 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -24,7 +24,7 @@ struct au1550nd_ctx {
 
 	int cs;
 	void __iomem *base;
-	void (*write_byte)(struct mtd_info *, u_char);
+	void (*write_byte)(struct nand_chip *, u_char);
 };
 
 /**
@@ -42,14 +42,13 @@ static u_char au_read_byte(struct nand_chip *this)
 
 /**
  * au_write_byte -  write one byte to the chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @byte:	pointer to data byte to write
  *
  * write function for 8it buswidth
  */
-static void au_write_byte(struct mtd_info *mtd, u_char byte)
+static void au_write_byte(struct nand_chip *this, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	writeb(byte, this->IO_ADDR_W);
 	wmb(); /* drain writebuffer */
 }
@@ -69,30 +68,28 @@ static u_char au_read_byte16(struct nand_chip *this)
 
 /**
  * au_write_byte16 -  write one byte endianness aware to the chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @byte:	pointer to data byte to write
  *
  * write function for 16bit buswidth with endianness conversion
  */
-static void au_write_byte16(struct mtd_info *mtd, u_char byte)
+static void au_write_byte16(struct nand_chip *this, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	writew(le16_to_cpu((u16) byte), this->IO_ADDR_W);
 	wmb(); /* drain writebuffer */
 }
 
 /**
  * au_write_buf -  write buffer to chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @buf:	data buffer
  * @len:	number of bytes to write
  *
  * write function for 8bit buswidth
  */
-static void au_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void au_write_buf(struct nand_chip *this, const u_char *buf, int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 
 	for (i = 0; i < len; i++) {
 		writeb(buf[i], this->IO_ADDR_W);
@@ -120,16 +117,15 @@ static void au_read_buf(struct nand_chip *this, u_char *buf, int len)
 
 /**
  * au_write_buf16 -  write buffer to chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @buf:	data buffer
  * @len:	number of bytes to write
  *
  * write function for 16bit buswidth
  */
-static void au_write_buf16(struct mtd_info *mtd, const u_char *buf, int len)
+static void au_write_buf16(struct nand_chip *this, const u_char *buf, int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	u16 *p = (u16 *) buf;
 	len >>= 1;
 
@@ -272,9 +268,9 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 			column -= 256;
 			readcmd = NAND_CMD_READ1;
 		}
-		ctx->write_byte(mtd, readcmd);
+		ctx->write_byte(this, readcmd);
 	}
-	ctx->write_byte(mtd, command);
+	ctx->write_byte(this, command);
 
 	/* Set ALE and clear CLE to start address cycle */
 	au1550_hwcontrol(mtd, NAND_CTL_CLRCLE);
@@ -288,10 +284,10 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 			if (this->options & NAND_BUSWIDTH_16 &&
 					!nand_opcode_8bits(command))
 				column >>= 1;
-			ctx->write_byte(mtd, column);
+			ctx->write_byte(this, column);
 		}
 		if (page_addr != -1) {
-			ctx->write_byte(mtd, (u8)(page_addr & 0xff));
+			ctx->write_byte(this, (u8)(page_addr & 0xff));
 
 			if (command == NAND_CMD_READ0 ||
 			    command == NAND_CMD_READ1 ||
@@ -309,10 +305,10 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 				au1550_hwcontrol(mtd, NAND_CTL_SETNCE);
 			}
 
-			ctx->write_byte(mtd, (u8)(page_addr >> 8));
+			ctx->write_byte(this, (u8)(page_addr >> 8));
 
 			if (this->options & NAND_ROW_ADDR_3)
-				ctx->write_byte(mtd,
+				ctx->write_byte(this,
 						((page_addr >> 16) & 0x0f));
 		}
 		/* Latch in address */
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index cf3e45358c60..83eec2812aa0 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -354,15 +354,15 @@ static void bcm47xxnflash_ops_bcm4706_read_buf(struct nand_chip *nand_chip,
 	pr_err("Invalid command for buf read: 0x%X\n", b47n->curr_command);
 }
 
-static void bcm47xxnflash_ops_bcm4706_write_buf(struct mtd_info *mtd,
+static void bcm47xxnflash_ops_bcm4706_write_buf(struct nand_chip *nand_chip,
 						const uint8_t *buf, int len)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 
 	switch (b47n->curr_command) {
 	case NAND_CMD_SEQIN:
-		bcm47xxnflash_ops_bcm4706_write(mtd, buf, len);
+		bcm47xxnflash_ops_bcm4706_write(nand_to_mtd(nand_chip), buf,
+						len);
 		return;
 	}
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 7cbc6045f16d..e24e77b27618 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1481,11 +1481,10 @@ static void brcmnand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 		*buf = brcmnand_read_byte(chip);
 }
 
-static void brcmnand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
-				   int len)
+static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
+			       int len)
 {
 	int i;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 
 	switch (host->last_cmd) {
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 97d835f88b86..f801333161c9 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -117,9 +117,8 @@ static int cafe_device_ready(struct mtd_info *mtd)
 }
 
 
-static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void cafe_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	if (cafe->usedma)
@@ -540,7 +539,7 @@ static int cafe_nand_write_page_lowlevel(struct nand_chip *chip,
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* Set up ECC autogeneration */
 	cafe->ctl2 |= (1<<30);
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 232d32391b1f..4e5c8b7721ab 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -54,10 +54,10 @@ static u_char cmx270_read_byte(struct nand_chip *this)
 	return (readl(this->IO_ADDR_R) >> 16);
 }
 
-static void cmx270_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void cmx270_write_buf(struct nand_chip *this, const u_char *buf,
+			     int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 
 	for (i=0; i<len; i++)
 		writel((*buf++ << 16), this->IO_ADDR_W);
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 4394eeebec7f..442fa583db44 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -103,10 +103,8 @@ static void cs553x_read_buf(struct nand_chip *this, u_char *buf, int len)
 	memcpy_fromio(buf, this->IO_ADDR_R, len);
 }
 
-static void cs553x_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void cs553x_write_buf(struct nand_chip *this, const u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-
 	while (unlikely(len > 0x800)) {
 		memcpy_toio(this->IO_ADDR_R, buf, 0x800);
 		buf += 0x800;
@@ -120,9 +118,8 @@ static unsigned char cs553x_read_byte(struct nand_chip *this)
 	return readb(this->IO_ADDR_R);
 }
 
-static void cs553x_write_byte(struct mtd_info *mtd, u_char byte)
+static void cs553x_write_byte(struct nand_chip *this, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	int i = 100000;
 
 	while (i && readb(this->IO_ADDR_R + MM_NAND_STS) & CS_NAND_CTLR_BUSY) {
@@ -142,7 +139,7 @@ static void cs553x_hwcontrol(struct mtd_info *mtd, int cmd,
 		writeb(ctl, mmio_base + MM_NAND_CTL);
 	}
 	if (cmd != NAND_CMD_NONE)
-		cs553x_write_byte(mtd, cmd);
+		cs553x_write_byte(this, cmd);
 }
 
 static int cs553x_device_ready(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index b879049e51c6..02a2d3b05e34 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -446,11 +446,9 @@ static void nand_davinci_read_buf(struct nand_chip *chip, uint8_t *buf,
 		ioread8_rep(chip->IO_ADDR_R, buf, len);
 }
 
-static void nand_davinci_write_buf(struct mtd_info *mtd,
-		const uint8_t *buf, int len)
+static void nand_davinci_write_buf(struct nand_chip *chip, const uint8_t *buf,
+				   int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		iowrite32_rep(chip->IO_ADDR_R, buf, len >> 2);
 	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 7e2c6ba2524b..eeb3f3843355 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -233,9 +233,10 @@ static void denali_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 		buf[i] = denali->host_read(denali, addr);
 }
 
-static void denali_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void denali_write_buf(struct nand_chip *chip, const uint8_t *buf,
+			     int len)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
 	int i;
 
@@ -254,10 +255,10 @@ static void denali_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
 		buf16[i] = denali->host_read(denali, addr);
 }
 
-static void denali_write_buf16(struct mtd_info *mtd, const uint8_t *buf,
+static void denali_write_buf16(struct nand_chip *chip, const uint8_t *buf,
 			       int len)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
 	const uint16_t *buf16 = (const uint16_t *)buf;
 	int i;
@@ -275,9 +276,9 @@ static uint8_t denali_read_byte(struct nand_chip *chip)
 	return byte;
 }
 
-static void denali_write_byte(struct mtd_info *mtd, uint8_t byte)
+static void denali_write_byte(struct nand_chip *chip, uint8_t byte)
 {
-	denali_write_buf(mtd, &byte, 1);
+	denali_write_buf(chip, &byte, 1);
 }
 
 static void denali_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index de1059069e8f..a1bc2f7436db 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -290,9 +290,8 @@ static inline int DoC_WaitReady(struct doc_priv *doc)
 	return ret;
 }
 
-static void doc2000_write_byte(struct mtd_info *mtd, u_char datum)
+static void doc2000_write_byte(struct nand_chip *this, u_char datum)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
@@ -316,9 +315,9 @@ static u_char doc2000_read_byte(struct nand_chip *this)
 	return ret;
 }
 
-static void doc2000_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
+static void doc2000_writebuf(struct nand_chip *this, const u_char *buf,
+			     int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -448,9 +447,8 @@ static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
 	return status;
 }
 
-static void doc2001_write_byte(struct mtd_info *mtd, u_char datum)
+static void doc2001_write_byte(struct nand_chip *this, u_char datum)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
@@ -472,9 +470,8 @@ static u_char doc2001_read_byte(struct nand_chip *this)
 	return ReadDOC(docptr, LastDataRead);
 }
 
-static void doc2001_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
+static void doc2001_writebuf(struct nand_chip *this, const u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -515,9 +512,8 @@ static u_char doc2001plus_read_byte(struct nand_chip *this)
 	return ret;
 }
 
-static void doc2001plus_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
+static void doc2001plus_writebuf(struct nand_chip *this, const u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -638,9 +634,9 @@ static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 	if (cmd != NAND_CMD_NONE) {
 		if (DoC_is_2000(doc))
-			doc2000_write_byte(mtd, cmd);
+			doc2000_write_byte(this, cmd);
 		else
-			doc2001_write_byte(mtd, cmd);
+			doc2001_write_byte(this, cmd);
 	}
 }
 
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index be439309fcfe..8987d273397b 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -271,10 +271,10 @@ static void docg4_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 		p[i] = readw(nand->IO_ADDR_R);
 }
 
-static void docg4_write_buf16(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void docg4_write_buf16(struct nand_chip *nand, const uint8_t *buf,
+			      int len)
 {
 	int i;
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	uint16_t *p = (uint16_t *) buf;
 	len >>= 1;
 
@@ -964,10 +964,10 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 	write_nop(docptr);
 
 	/* write the page data */
-	docg4_write_buf16(mtd, buf, DOCG4_PAGE_SIZE);
+	docg4_write_buf16(nand, buf, DOCG4_PAGE_SIZE);
 
 	/* oob bytes 0 through 5 are written to I/O reg */
-	docg4_write_buf16(mtd, nand->oob_poi, 6);
+	docg4_write_buf16(nand, nand->oob_poi, 6);
 
 	/* oob byte 6 written to a separate reg */
 	writew(nand->oob_poi[6], docptr + DOCG4_OOB_6_7);
@@ -995,7 +995,7 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 		memcpy(ecc_buf, &nand->oob_poi[8], 8);
 	}
 
-	docg4_write_buf16(mtd, ecc_buf, 8);
+	docg4_write_buf16(nand, ecc_buf, 8);
 	write_nop(docptr);
 	write_nop(docptr);
 	writew(0, docptr + DOC_DATAEND);
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 22326bcb8b62..14d246323e94 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -543,9 +543,9 @@ static void fsl_elbc_select_chip(struct mtd_info *mtd, int chip)
 /*
  * Write buf to the FCM Controller Data Buffer
  */
-static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void fsl_elbc_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
@@ -735,7 +735,7 @@ static int fsl_elbc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	fsl_elbc_write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -750,8 +750,8 @@ static int fsl_elbc_write_subpage(struct nand_chip *chip, uint32_t offset,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
-	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	fsl_elbc_write_buf(chip, buf, mtd->writesize);
+	fsl_elbc_write_buf(chip, chip->oob_poi, mtd->oobsize);
 	return nand_prog_page_end_op(chip);
 }
 
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 2a5e2c88c7fc..e1276c3cdd85 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -518,9 +518,9 @@ static void fsl_ifc_select_chip(struct mtd_info *mtd, int chip)
 /*
  * Write buf to the IFC NAND Controller Data Buffer
  */
-static void fsl_ifc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void fsl_ifc_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
@@ -709,7 +709,7 @@ static int fsl_ifc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	fsl_ifc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	fsl_ifc_write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 965f71b31299..5d66b582f9c0 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -140,9 +140,9 @@ static void fun_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 		buf[i] = in_8(fun->chip.IO_ADDR_R);
 }
 
-static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void fun_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 	int i;
 
 	for (i = 0; i < len; i++) {
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index d0d5caa1b7a6..bd1b8445b358 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -868,9 +868,8 @@ static void gpmi_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 	gpmi_read_data(this, buf, len);
 }
 
-static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void gpmi_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "len is %d\n", len);
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index e1fe6963c908..b4e5bfd30022 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -380,9 +380,8 @@ static uint8_t hisi_nfc_read_byte(struct nand_chip *chip)
 }
 
 static void
-hisi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+hisi_nfc_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	memcpy(host->buffer + host->offset, buf, len);
@@ -583,7 +582,7 @@ static int hisi_nand_write_page_hwecc(struct nand_chip *chip,
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+		chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 5820c86cb1f1..d04b30989041 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -381,9 +381,9 @@ static void lpc32xx_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
 /*
  * Simple device write without ECC
  */
-static void lpc32xx_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void lpc32xx_nand_write_buf(struct nand_chip *chip, const uint8_t *buf,
+				   int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Direct device write with no ECC */
@@ -706,7 +706,7 @@ static int lpc32xx_nand_write_page_syndrome(struct nand_chip *chip,
 	lpc32xx_slc_ecc_copy(pb, (uint32_t *)host->ecc_buf, chip->ecc.steps);
 
 	/* Write ECC data to device */
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -724,7 +724,7 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct nand_chip *chip,
 	/* Raw writes can just use the FIFO interface */
 	nand_prog_page_begin_op(chip, page, 0, buf,
 				chip->ecc.size * chip->ecc.steps);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index 49031f5a3b6d..dc573a0b5fe1 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -499,10 +499,10 @@ static void mpc5121_nfc_read_buf(struct nand_chip *chip, u_char *buf, int len)
 }
 
 /* Write data to NFC buffers */
-static void mpc5121_nfc_write_buf(struct mtd_info *mtd,
-						const u_char *buf, int len)
+static void mpc5121_nfc_write_buf(struct nand_chip *chip, const u_char *buf,
+				  int len)
 {
-	mpc5121_nfc_buf_copy(mtd, (u_char *)buf, len, 1);
+	mpc5121_nfc_buf_copy(nand_to_mtd(chip), (u_char *)buf, len, 1);
 }
 
 /* Read byte from NFC buffers */
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 1c7392242d4d..bd2002a1fabd 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -474,9 +474,9 @@ static void mtk_nfc_read_buf(struct nand_chip *chip, u8 *buf, int len)
 		buf[i] = mtk_nfc_read_byte(chip);
 }
 
-static void mtk_nfc_write_byte(struct mtd_info *mtd, u8 byte)
+static void mtk_nfc_write_byte(struct nand_chip *chip, u8 byte)
 {
-	struct mtk_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
+	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 	u32 reg;
 
 	reg = nfi_readl(nfc, NFI_STA) & NFI_FSM_MASK;
@@ -495,12 +495,12 @@ static void mtk_nfc_write_byte(struct mtd_info *mtd, u8 byte)
 	nfi_writeb(nfc, byte, NFI_DATAW);
 }
 
-static void mtk_nfc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void mtk_nfc_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++)
-		mtk_nfc_write_byte(mtd, buf[i]);
+		mtk_nfc_write_byte(chip, buf[i]);
 }
 
 static int mtk_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 8fed2919f35e..d5d8f8c16b60 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -921,10 +921,10 @@ static u_char mxc_nand_read_byte(struct nand_chip *nand_chip)
 /* Write data of length len to buffer buf. The data to be
  * written on NAND Flash is first copied to RAMbuffer. After the Data Input
  * Operation by the NFC, the data is written to NAND Flash */
-static void mxc_nand_write_buf(struct mtd_info *mtd,
-				const u_char *buf, int len)
+static void mxc_nand_write_buf(struct nand_chip *nand_chip, const u_char *buf,
+			       int len)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	u16 col = host->buf_start;
 	int n = mtd->oobsize + mtd->writesize - col;
@@ -1405,7 +1405,7 @@ static int mxc_nand_set_features(struct mtd_info *mtd, struct nand_chip *chip,
 	host->buf_start = 0;
 
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(mtd, subfeature_param[i]);
+		chip->write_byte(chip, subfeature_param[i]);
 
 	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
 	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e4686078011d..6c20c0b805a3 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -300,28 +300,25 @@ static void nand_select_chip(struct mtd_info *mtd, int chipnr)
 
 /**
  * nand_write_byte - [DEFAULT] write single byte to chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @byte: value to write
  *
  * Default function to write a byte to I/O[7:0]
  */
-static void nand_write_byte(struct mtd_info *mtd, uint8_t byte)
+static void nand_write_byte(struct nand_chip *chip, uint8_t byte)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	chip->write_buf(mtd, &byte, 1);
+	chip->write_buf(chip, &byte, 1);
 }
 
 /**
  * nand_write_byte16 - [DEFAULT] write single byte to a chip with width 16
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @byte: value to write
  *
  * Default function to write a byte to I/O[7:0] on a 16-bit wide chip.
  */
-static void nand_write_byte16(struct mtd_info *mtd, uint8_t byte)
+static void nand_write_byte16(struct nand_chip *chip, uint8_t byte)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	uint16_t word = byte;
 
 	/*
@@ -340,21 +337,19 @@ static void nand_write_byte16(struct mtd_info *mtd, uint8_t byte)
 	 * neither an address nor a command transfer. Let's assume a 0 on the
 	 * upper I/O lines is OK.
 	 */
-	chip->write_buf(mtd, (uint8_t *)&word, 2);
+	chip->write_buf(chip, (uint8_t *)&word, 2);
 }
 
 /**
  * nand_write_buf - [DEFAULT] write buffer to chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: data buffer
  * @len: number of bytes to write
  *
  * Default write function for 8bit buswidth.
  */
-static void nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void nand_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	iowrite8_rep(chip->IO_ADDR_W, buf, len);
 }
 
@@ -373,15 +368,15 @@ static void nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 
 /**
  * nand_write_buf16 - [DEFAULT] write buffer to chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: data buffer
  * @len: number of bytes to write
  *
  * Default write function for 16bit buswidth.
  */
-static void nand_write_buf16(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void nand_write_buf16(struct nand_chip *chip, const uint8_t *buf,
+			     int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u16 *p = (u16 *) buf;
 
 	iowrite16_rep(chip->IO_ADDR_W, p, len >> 1);
@@ -1801,7 +1796,7 @@ int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
 
 	if (buf)
-		chip->write_buf(mtd, buf, len);
+		chip->write_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1886,7 +1881,7 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 						len, true);
 	} else {
 		chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
-		chip->write_buf(mtd, buf, len);
+		chip->write_buf(chip, buf, len);
 		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
 		status = chip->waitfunc(mtd, chip);
 	}
@@ -1955,7 +1950,7 @@ int nand_change_write_column_op(struct nand_chip *chip,
 
 	chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset_in_page, -1);
 	if (len)
-		chip->write_buf(mtd, buf, len);
+		chip->write_buf(chip, buf, len);
 
 	return 0;
 }
@@ -2175,7 +2170,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 
 	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(mtd, params[i]);
+		chip->write_byte(chip, params[i]);
 
 	ret = chip->waitfunc(mtd, chip);
 	if (ret < 0)
@@ -2343,8 +2338,6 @@ EXPORT_SYMBOL_GPL(nand_read_data_op);
 int nand_write_data_op(struct nand_chip *chip, const void *buf,
 		       unsigned int len, bool force_8bit)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!len || !buf)
 		return -EINVAL;
 
@@ -2364,9 +2357,9 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
 		unsigned int i;
 
 		for (i = 0; i < len; i++)
-			chip->write_byte(mtd, p[i]);
+			chip->write_byte(chip, p[i]);
 	} else {
-		chip->write_buf(mtd, buf, len);
+		chip->write_buf(chip, buf, len);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 4ffbb26e76d6..197256c2e1ee 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -111,7 +111,7 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 	}
 
 	chip->cmdfunc(mtd, NAND_CMD_NONE, column, -1);
-	chip->write_byte(mtd, val);
+	chip->write_byte(chip, val);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 04feb4e8d112..880ba12e07ba 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1933,9 +1933,8 @@ static u_char ns_nand_read_byte(struct nand_chip *chip)
 	return outb;
 }
 
-static void ns_nand_write_byte(struct mtd_info *mtd, u_char byte)
+static void ns_nand_write_byte(struct nand_chip *chip, u_char byte)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nandsim *ns = nand_get_controller_data(chip);
 
 	/* Sanity and correctness checks */
@@ -2098,7 +2097,7 @@ static void ns_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int bitmask)
 	ns->lines.ce = bitmask & NAND_NCE ? 1 : 0;
 
 	if (cmd != NAND_CMD_NONE)
-		ns_nand_write_byte(mtd, cmd);
+		ns_nand_write_byte(chip, cmd);
 }
 
 static int ns_device_ready(struct mtd_info *mtd)
@@ -2107,9 +2106,9 @@ static int ns_device_ready(struct mtd_info *mtd)
 	return 1;
 }
 
-static void ns_nand_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void ns_nand_write_buf(struct nand_chip *chip, const u_char *buf,
+			      int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nandsim *ns = nand_get_controller_data(chip);
 
 	/* Check that chip is expecting data input */
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 1c5e7606e07f..ace646b8a6e6 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -125,9 +125,8 @@ static void ndfc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 		*p++ = in_be32(ndfc->ndfcbase + NDFC_DATA);
 }
 
-static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void ndfc_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t *p = (uint32_t *) buf;
 
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 3a88da5ec97f..357b3cf03195 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -99,11 +99,11 @@ static void nuc900_nand_read_buf(struct nand_chip *chip,
 		buf[i] = (unsigned char)read_data_reg(nand);
 }
 
-static void nuc900_nand_write_buf(struct mtd_info *mtd,
+static void nuc900_nand_write_buf(struct nand_chip *chip,
 				  const unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
 
 	for (i = 0; i < len; i++)
 		write_data_reg(nand, buf[i]);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 4f2e5cd86050..5a2bf1ed9c86 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -384,13 +384,14 @@ static void omap_read_buf_pref(struct nand_chip *chip, u_char *buf, int len)
 
 /**
  * omap_write_buf_pref - write buffer to NAND controller
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: data buffer
  * @len: number of bytes to write
  */
-static void omap_write_buf_pref(struct mtd_info *mtd,
-					const u_char *buf, int len)
+static void omap_write_buf_pref(struct nand_chip *chip, const u_char *buf,
+				int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	uint32_t w_count = 0;
 	int i = 0, ret = 0;
@@ -547,18 +548,20 @@ static void omap_read_buf_dma_pref(struct nand_chip *chip, u_char *buf,
 
 /**
  * omap_write_buf_dma_pref - write buffer to NAND controller
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: data buffer
  * @len: number of bytes to write
  */
-static void omap_write_buf_dma_pref(struct mtd_info *mtd,
-					const u_char *buf, int len)
+static void omap_write_buf_dma_pref(struct nand_chip *chip, const u_char *buf,
+				    int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	if (len <= mtd->oobsize)
-		omap_write_buf_pref(mtd, buf, len);
+		omap_write_buf_pref(chip, buf, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, (u_char *)buf, len, 0x1);
 }
 
 /*
@@ -657,20 +660,21 @@ static void omap_read_buf_irq_pref(struct nand_chip *chip, u_char *buf,
 
 /*
  * omap_write_buf_irq_pref - write buffer to NAND controller
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: data buffer
  * @len: number of bytes to write
  */
-static void omap_write_buf_irq_pref(struct mtd_info *mtd,
-					const u_char *buf, int len)
+static void omap_write_buf_irq_pref(struct nand_chip *chip, const u_char *buf,
+				    int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int ret = 0;
 	unsigned long tim, limit;
 	u32 val;
 
 	if (len <= mtd->oobsize) {
-		omap_write_buf_pref(mtd, buf, len);
+		omap_write_buf_pref(chip, buf, len);
 		return;
 	}
 
@@ -1537,7 +1541,7 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
-	chip->write_buf(mtd, buf, mtd->writesize);
+	chip->write_buf(chip, buf, mtd->writesize);
 
 	/* Update ecc vector from GPMC result registers */
 	omap_calculate_ecc_bch_multi(mtd, buf, &ecc_calc[0]);
@@ -1548,7 +1552,7 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 		return ret;
 
 	/* Write ecc vector to OOB area */
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -1589,7 +1593,7 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
-	chip->write_buf(mtd, buf, mtd->writesize);
+	chip->write_buf(chip, buf, mtd->writesize);
 
 	for (step = 0; step < ecc_steps; step++) {
 		/* mask ECC of un-touched subpages by padding 0xFF */
@@ -1614,7 +1618,7 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 		return ret;
 
 	/* write OOB buffer to NAND device */
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 6156abb30b7a..93c04bec471d 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -52,9 +52,9 @@ static void oxnas_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
 	ioread8_rep(oxnas->io_base, buf, len);
 }
 
-static void oxnas_nand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void oxnas_nand_write_buf(struct nand_chip *chip, const u8 *buf,
+				 int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
 
 	iowrite8_rep(oxnas->io_base, buf, len);
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index 551e5db670be..70aff4180ab7 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -53,10 +53,9 @@ static void pasemi_read_buf(struct nand_chip *chip, u_char *buf, int len)
 	memcpy_fromio(buf, chip->IO_ADDR_R, len);
 }
 
-static void pasemi_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void pasemi_write_buf(struct nand_chip *chip, const u_char *buf,
+			     int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	while (len > 0x800) {
 		memcpy_toio(chip->IO_ADDR_R, buf, 0x800);
 		buf += 0x800;
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 5193806923ba..adfc3f50e8d5 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -44,14 +44,6 @@ static void plat_nand_select_chip(struct mtd_info *mtd, int cs)
 	pdata->ctrl.select_chip(mtd_to_nand(mtd), cs);
 }
 
-static void plat_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
-				int len)
-{
-	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
-
-	pdata->ctrl.write_buf(mtd_to_nand(mtd), buf, len);
-}
-
 /*
  * Probe for the NAND device.
  */
@@ -101,9 +93,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	if (pdata->ctrl.select_chip)
 		data->chip.select_chip = plat_nand_select_chip;
 
-	if (pdata->ctrl.write_buf)
-		data->chip.write_buf = plat_nand_write_buf;
-
+	data->chip.write_buf = pdata->ctrl.write_buf;
 	data->chip.read_buf = pdata->ctrl.read_buf;
 	data->chip.chip_delay = pdata->chip.chip_delay;
 	data->chip.options |= pdata->chip.options;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 881b955b3308..0c158ce480be 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2313,10 +2313,9 @@ static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 	nandc->buf_start += real_len;
 }
 
-static void qcom_nandc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *buf,
 				 int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
 
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 07055bd657cd..19f49ca1ed5b 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -232,9 +232,9 @@ static void r852_do_dma(struct r852_device *dev, uint8_t *buf, int do_read)
 /*
  * Program data lines of the nand chip to send data to it
  */
-static void r852_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void r852_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 	uint32_t reg;
 
 	/* Don't allow any access to hardware if we suspect card removal */
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 54c86ec612dd..a420a84eaf51 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -696,16 +696,16 @@ static void s3c2440_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
 	}
 }
 
-static void s3c2410_nand_write_buf(struct mtd_info *mtd, const u_char *buf,
+static void s3c2410_nand_write_buf(struct nand_chip *this, const u_char *buf,
 				   int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	writesb(this->IO_ADDR_W, buf, len);
 }
 
-static void s3c2440_nand_write_buf(struct mtd_info *mtd, const u_char *buf,
+static void s3c2440_nand_write_buf(struct nand_chip *this, const u_char *buf,
 				   int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(this);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	writesl(info->regs + S3C2440_NFDATA, buf, len >> 2);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 6966a18f8ac4..742b7eb82ab7 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -628,7 +628,7 @@ static int flctl_write_page_hwecc(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
 	return nand_prog_page_end_op(chip);
 }
 
@@ -970,9 +970,9 @@ static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 	}
 }
 
-static void flctl_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+static void flctl_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct sh_flctl *flctl = mtd_to_flctl(nand_to_mtd(chip));
 
 	memcpy(&flctl->done_buff[flctl->index], buf, len);
 	flctl->index += len;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 007e37680b88..deedc1cd4dee 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -34,15 +34,14 @@ struct socrates_nand_host {
 
 /**
  * socrates_nand_write_buf -  write buffer to chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @buf:	data buffer
  * @len:	number of bytes to write
  */
-static void socrates_nand_write_buf(struct mtd_info *mtd,
-		const uint8_t *buf, int len)
+static void socrates_nand_write_buf(struct nand_chip *this, const uint8_t *buf,
+				    int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct socrates_nand_host *host = nand_get_controller_data(this);
 
 	for (i = 0; i < len; i++) {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 2a0e624eca6c..80d9d2f8f5de 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -501,10 +501,9 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 	}
 }
 
-static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 				int len)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
@@ -760,7 +759,7 @@ static void sunxi_nfc_randomizer_write_buf(struct mtd_info *mtd,
 {
 	sunxi_nfc_randomizer_config(mtd, page, ecc);
 	sunxi_nfc_randomizer_enable(mtd);
-	sunxi_nfc_write_buf(mtd, buf, len);
+	sunxi_nfc_write_buf(mtd_to_nand(mtd), buf, len);
 	sunxi_nfc_randomizer_disable(mtd);
 }
 
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 20d6fa983a6b..7fc95c6980a7 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -149,9 +149,9 @@ static void tango_read_buf(struct nand_chip *chip, u8 *buf, int len)
 	ioread8_rep(tchip->base + PBUS_DATA, buf, len);
 }
 
-static void tango_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void tango_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
-	struct tango_chip *tchip = to_tango_chip(mtd_to_nand(mtd));
+	struct tango_chip *tchip = to_tango_chip(chip);
 
 	iowrite8_rep(tchip->base + PBUS_DATA, buf, len);
 }
@@ -338,15 +338,13 @@ static void aux_read(struct nand_chip *chip, u8 **buf, int len, int *pos)
 
 static void aux_write(struct nand_chip *chip, const u8 **buf, int len, int *pos)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	*pos += len;
 
 	if (!*buf) {
 		/* skip over "len" bytes */
 		nand_change_write_column_op(chip, *pos, NULL, 0, false);
 	} else {
-		tango_write_buf(mtd, *buf, len);
+		tango_write_buf(chip, *buf, len);
 		*buf += len;
 	}
 }
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 570ea045fbce..d627d855b254 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -245,9 +245,9 @@ static u_char tmio_nand_read_byte(struct nand_chip *chip)
   *buffer functions.
  */
 static void
-tmio_nand_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+tmio_nand_write_buf(struct nand_chip *chip, const u_char *buf, int len)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 
 	tmio_iowrite16_rep(tmio->fcr + FCR_DATA, buf, len >> 1);
 }
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index c68b638c4fe8..b7ff8eca441b 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -109,10 +109,10 @@ static uint8_t txx9ndfmc_read_byte(struct nand_chip *chip)
 	return txx9ndfmc_read(dev, TXX9_NDFDTR);
 }
 
-static void txx9ndfmc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+static void txx9ndfmc_write_buf(struct nand_chip *chip, const uint8_t *buf,
 				int len)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 	void __iomem *ndfdtr = ndregaddr(dev, TXX9_NDFDTR);
 	u32 mcr = txx9ndfmc_read(dev, TXX9_NDFMCR);
 
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index edbcfaa85ed8..77759f27d154 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -138,12 +138,12 @@ static void xway_read_buf(struct nand_chip *chip, u_char *buf, int len)
 		buf[i] = xway_readb(nand_to_mtd(chip), NAND_WRITE_DATA);
 }
 
-static void xway_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++)
-		xway_writeb(mtd, NAND_WRITE_DATA, buf[i]);
+		xway_writeb(nand_to_mtd(chip), NAND_WRITE_DATA, buf[i]);
 }
 
 /*
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 644c91ff2734..7e9ee17a389b 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -724,9 +724,9 @@ static int spinand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	return 0;
 }
 
-static void spinand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+static void spinand_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 {
-	struct spinand_state *state = mtd_to_state(mtd);
+	struct spinand_state *state = mtd_to_state(nand_to_mtd(chip));
 
 	memcpy(state->buf + state->buf_ptr, buf, len);
 	state->buf_ptr += len;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f324a82fe6a2..cd94cb3b9c2e 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1284,8 +1284,8 @@ struct nand_chip {
 	void __iomem *IO_ADDR_W;
 
 	uint8_t (*read_byte)(struct nand_chip *chip);
-	void (*write_byte)(struct mtd_info *mtd, uint8_t byte);
-	void (*write_buf)(struct mtd_info *mtd, const uint8_t *buf, int len);
+	void (*write_byte)(struct nand_chip *chip, uint8_t byte);
+	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
 	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*block_bad)(struct mtd_info *mtd, loff_t ofs);
-- 
2.14.1
