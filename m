From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 10/23] mtd: rawnand: Pass a nand_chip object to
 chip->read_xxx() hooks
Date: Fri, 17 Aug 2018 18:09:09 +0200
Message-ID: <20180817160922.6224-11-boris.brezillon@bootlin.com>
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

Let's tackle all chip->read_xxx() hooks at once.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |  7 ++--
 drivers/mtd/nand/raw/atmel/nand-controller.c     | 10 +++---
 drivers/mtd/nand/raw/au1550nd.c                  | 15 ++++-----
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c | 10 +++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  7 ++--
 drivers/mtd/nand/raw/cafe_nand.c                 | 10 +++---
 drivers/mtd/nand/raw/cmx270_nand.c               |  7 ++--
 drivers/mtd/nand/raw/cs553x_nand.c               |  7 ++--
 drivers/mtd/nand/raw/davinci_nand.c              |  5 ++-
 drivers/mtd/nand/raw/denali.c                    | 11 ++++---
 drivers/mtd/nand/raw/diskonchip.c                | 32 +++++++-----------
 drivers/mtd/nand/raw/docg4.c                     | 13 +++-----
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  8 ++---
 drivers/mtd/nand/raw/fsl_ifc_nand.c              | 13 +++-----
 drivers/mtd/nand/raw/fsl_upm.c                   |  8 ++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       | 16 ++++-----
 drivers/mtd/nand/raw/hisi504_nand.c              |  8 ++---
 drivers/mtd/nand/raw/lpc32xx_slc.c               | 12 +++----
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  8 ++---
 drivers/mtd/nand/raw/mtk_nand.c                  |  7 ++--
 drivers/mtd/nand/raw/mxc_nand.c                  | 10 +++---
 drivers/mtd/nand/raw/nand_base.c                 | 41 ++++++++++--------------
 drivers/mtd/nand/raw/nandsim.c                   |  8 ++---
 drivers/mtd/nand/raw/ndfc.c                      |  3 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  8 ++---
 drivers/mtd/nand/raw/omap2.c                     | 24 ++++++++------
 drivers/mtd/nand/raw/orion_nand.c                |  3 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  6 ++--
 drivers/mtd/nand/raw/pasemi_nand.c               |  4 +--
 drivers/mtd/nand/raw/plat_nand.c                 | 11 +------
 drivers/mtd/nand/raw/qcom_nandc.c                |  6 ++--
 drivers/mtd/nand/raw/r852.c                      |  8 ++---
 drivers/mtd/nand/raw/s3c2410.c                   |  6 ++--
 drivers/mtd/nand/raw/sh_flctl.c                  | 10 +++---
 drivers/mtd/nand/raw/socrates_nand.c             | 10 +++---
 drivers/mtd/nand/raw/sunxi_nand.c                | 11 +++----
 drivers/mtd/nand/raw/tango_nand.c                | 12 +++----
 drivers/mtd/nand/raw/tmio_nand.c                 |  8 ++---
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  8 ++---
 drivers/mtd/nand/raw/xway_nand.c                 |  8 ++---
 drivers/staging/mt29f_spinand/mt29f_spinand.c    | 10 +++---
 include/linux/mtd/rawnand.h                      |  4 +--
 42 files changed, 186 insertions(+), 247 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index acf7971e815d..eb48c939c4ae 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -75,10 +75,9 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_byte(struct nand_chip *this)
 {
 	u_char res;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
@@ -99,12 +98,12 @@ static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 		ams_delta_write_byte(mtd, buf[i]);
 }
 
-static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
 	int i;
 
 	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+		buf[i] = ams_delta_read_byte(this);
 }
 
 /*
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index b5c401e76ed8..d2c692622a4f 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -410,9 +410,8 @@ static int atmel_nand_dma_transfer(struct atmel_nand_controller *nc,
 	return -EIO;
 }
 
-static u8 atmel_nand_read_byte(struct mtd_info *mtd)
+static u8 atmel_nand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 
 	return ioread8(nand->activecs->io.virt);
@@ -429,9 +428,8 @@ static void atmel_nand_write_byte(struct mtd_info *mtd, u8 byte)
 		iowrite8(byte, nand->activecs->io.virt);
 }
 
-static void atmel_nand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void atmel_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_nand_controller *nc;
 
@@ -883,8 +881,8 @@ static int atmel_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	if (ret)
 		return ret;
 
-	atmel_nand_read_buf(mtd, buf, mtd->writesize);
-	atmel_nand_read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	atmel_nand_read_buf(chip, buf, mtd->writesize);
+	atmel_nand_read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	ret = atmel_nand_pmecc_correct_data(chip, buf, raw);
 
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index d277a141c7d3..76ea4141eb10 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -29,13 +29,12 @@ struct au1550nd_ctx {
 
 /**
  * au_read_byte -  read one byte from the chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  *
  * read function for 8bit buswidth
  */
-static u_char au_read_byte(struct mtd_info *mtd)
+static u_char au_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	u_char ret = readb(this->IO_ADDR_R);
 	wmb(); /* drain writebuffer */
 	return ret;
@@ -57,13 +56,12 @@ static void au_write_byte(struct mtd_info *mtd, u_char byte)
 
 /**
  * au_read_byte16 -  read one byte endianness aware from the chip
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  *
  * read function for 16bit buswidth with endianness conversion
  */
-static u_char au_read_byte16(struct mtd_info *mtd)
+static u_char au_read_byte16(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	u_char ret = (u_char) cpu_to_le16(readw(this->IO_ADDR_R));
 	wmb(); /* drain writebuffer */
 	return ret;
@@ -104,16 +102,15 @@ static void au_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 
 /**
  * au_read_buf -  read chip data into buffer
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @buf:	buffer to store date
  * @len:	number of bytes to read
  *
  * read function for 8bit buswidth
  */
-static void au_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void au_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 
 	for (i = 0; i < len; i++) {
 		buf[i] = readb(this->IO_ADDR_R);
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 7022ffd271ad..cf3e45358c60 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -310,9 +310,9 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 	b47n->curr_command = command;
 }
 
-static u8 bcm47xxnflash_ops_bcm4706_read_byte(struct mtd_info *mtd)
+static u8 bcm47xxnflash_ops_bcm4706_read_byte(struct nand_chip *nand_chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 	struct bcma_drv_cc *cc = b47n->cc;
 	u32 tmp = 0;
@@ -338,16 +338,16 @@ static u8 bcm47xxnflash_ops_bcm4706_read_byte(struct mtd_info *mtd)
 	return 0;
 }
 
-static void bcm47xxnflash_ops_bcm4706_read_buf(struct mtd_info *mtd,
+static void bcm47xxnflash_ops_bcm4706_read_buf(struct nand_chip *nand_chip,
 					       uint8_t *buf, int len)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 
 	switch (b47n->curr_command) {
 	case NAND_CMD_READ0:
 	case NAND_CMD_READOOB:
-		bcm47xxnflash_ops_bcm4706_read(mtd, buf, len);
+		bcm47xxnflash_ops_bcm4706_read(nand_to_mtd(nand_chip), buf,
+					       len);
 		return;
 	}
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index d8fb2b5c19c9..7cbc6045f16d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1417,9 +1417,8 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		brcmnand_wp(mtd, 1);
 }
 
-static uint8_t brcmnand_read_byte(struct mtd_info *mtd)
+static uint8_t brcmnand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	uint8_t ret = 0;
@@ -1474,12 +1473,12 @@ static uint8_t brcmnand_read_byte(struct mtd_info *mtd)
 	return ret;
 }
 
-static void brcmnand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void brcmnand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++, buf++)
-		*buf = brcmnand_read_byte(mtd);
+		*buf = brcmnand_read_byte(chip);
 }
 
 static void brcmnand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index fe7c7db3cfe7..97d835f88b86 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -133,9 +133,8 @@ static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 		len, cafe->datalen);
 }
 
-static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void cafe_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	if (cafe->usedma)
@@ -148,13 +147,12 @@ static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	cafe->datalen += len;
 }
 
-static uint8_t cafe_read_byte(struct mtd_info *mtd)
+static uint8_t cafe_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	uint8_t d;
 
-	cafe_read_buf(mtd, &d, 1);
+	cafe_read_buf(chip, &d, 1);
 	cafe_dev_dbg(&cafe->pdev->dev, "Read %02x\n", d);
 
 	return d;
@@ -383,7 +381,7 @@ static int cafe_nand_read_page(struct nand_chip *chip, uint8_t *buf,
 		     cafe_readl(cafe, NAND_ECC_SYN01));
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	if (checkecc && cafe_readl(cafe, NAND_ECC_RESULT) & (1<<18)) {
 		unsigned short syn[8], pat[4];
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 2eb933a8f99e..232d32391b1f 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -49,10 +49,8 @@ static const struct mtd_partition partition_info[] = {
 };
 #define NUM_PARTITIONS (ARRAY_SIZE(partition_info))
 
-static u_char cmx270_read_byte(struct mtd_info *mtd)
+static u_char cmx270_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-
 	return (readl(this->IO_ADDR_R) >> 16);
 }
 
@@ -65,10 +63,9 @@ static void cmx270_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 		writel((*buf++ << 16), this->IO_ADDR_W);
 }
 
-static void cmx270_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void cmx270_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 
 	for (i=0; i<len; i++)
 		*buf++ = readl(this->IO_ADDR_R) >> 16;
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 193c3e8fa118..4394eeebec7f 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -93,10 +93,8 @@
 #define CS_NAND_ECC_CLRECC	(1<<1)
 #define CS_NAND_ECC_ENECC	(1<<0)
 
-static void cs553x_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void cs553x_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-
 	while (unlikely(len > 0x800)) {
 		memcpy_fromio(buf, this->IO_ADDR_R, 0x800);
 		buf += 0x800;
@@ -117,9 +115,8 @@ static void cs553x_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 	memcpy_toio(this->IO_ADDR_R, buf, len);
 }
 
-static unsigned char cs553x_read_byte(struct mtd_info *mtd)
+static unsigned char cs553x_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	return readb(this->IO_ADDR_R);
 }
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index c80b6c6da4aa..b879049e51c6 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -435,10 +435,9 @@ static int nand_davinci_correct_4bit(struct nand_chip *chip, u_char *data,
  * the two LSBs for NAND access ... so we can issue 32-bit reads/writes
  * and have that transparently morphed into multiple NAND operations.
  */
-static void nand_davinci_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void nand_davinci_read_buf(struct nand_chip *chip, uint8_t *buf,
+				  int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		ioread32_rep(chip->IO_ADDR_R, buf, len >> 2);
 	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index a6b6b6cc7360..7e2c6ba2524b 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -222,8 +222,9 @@ static uint32_t denali_check_irq(struct denali_nand_info *denali)
 	return irq_status;
 }
 
-static void denali_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void denali_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
 	int i;
@@ -242,9 +243,9 @@ static void denali_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 		denali->host_write(denali, addr, buf[i]);
 }
 
-static void denali_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
+static void denali_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
 	uint16_t *buf16 = (uint16_t *)buf;
 	int i;
@@ -265,11 +266,11 @@ static void denali_write_buf16(struct mtd_info *mtd, const uint8_t *buf,
 		denali->host_write(denali, addr, buf16[i]);
 }
 
-static uint8_t denali_read_byte(struct mtd_info *mtd)
+static uint8_t denali_read_byte(struct nand_chip *chip)
 {
 	uint8_t byte;
 
-	denali_read_buf(mtd, &byte, 1);
+	denali_read_buf(chip, &byte, 1);
 
 	return byte;
 }
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 142d21be874e..de1059069e8f 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -302,9 +302,8 @@ static void doc2000_write_byte(struct mtd_info *mtd, u_char datum)
 	WriteDOC(datum, docptr, 2k_CDSN_IO);
 }
 
-static u_char doc2000_read_byte(struct mtd_info *mtd)
+static u_char doc2000_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	u_char ret;
@@ -334,9 +333,8 @@ static void doc2000_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 		printk("\n");
 }
 
-static void doc2000_readbuf(struct mtd_info *mtd, u_char *buf, int len)
+static void doc2000_readbuf(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -344,14 +342,12 @@ static void doc2000_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 	if (debug)
 		printk("readbuf of %d bytes: ", len);
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		buf[i] = ReadDOC(docptr, 2k_CDSN_IO + i);
-	}
 }
 
-static void doc2000_readbuf_dword(struct mtd_info *mtd, u_char *buf, int len)
+static void doc2000_readbuf_dword(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -387,8 +383,8 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 	 */
 	udelay(50);
 
-	ret = this->read_byte(mtd) << 8;
-	ret |= this->read_byte(mtd);
+	ret = this->read_byte(this) << 8;
+	ret |= this->read_byte(this);
 
 	if (doc->ChipID == DOC_ChipID_Doc2k && try_dword && !nr) {
 		/* First chip probe. See if we get same results by 32-bit access */
@@ -447,7 +443,7 @@ static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
 	DoC_WaitReady(doc);
 	nand_status_op(this, NULL);
 	DoC_WaitReady(doc);
-	status = (int)this->read_byte(mtd);
+	status = (int)this->read_byte(this);
 
 	return status;
 }
@@ -463,9 +459,8 @@ static void doc2001_write_byte(struct mtd_info *mtd, u_char datum)
 	WriteDOC(datum, docptr, WritePipeTerm);
 }
 
-static u_char doc2001_read_byte(struct mtd_info *mtd)
+static u_char doc2001_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
@@ -490,9 +485,8 @@ static void doc2001_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 	WriteDOC(0x00, docptr, WritePipeTerm);
 }
 
-static void doc2001_readbuf(struct mtd_info *mtd, u_char *buf, int len)
+static void doc2001_readbuf(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -507,9 +501,8 @@ static void doc2001_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 	buf[i] = ReadDOC(docptr, LastDataRead);
 }
 
-static u_char doc2001plus_read_byte(struct mtd_info *mtd)
+static u_char doc2001plus_read_byte(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	u_char ret;
@@ -540,9 +533,8 @@ static void doc2001plus_writebuf(struct mtd_info *mtd, const u_char *buf, int le
 		printk("\n");
 }
 
-static void doc2001plus_readbuf(struct mtd_info *mtd, u_char *buf, int len)
+static void doc2001plus_readbuf(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
@@ -735,7 +727,7 @@ static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int colu
 		WriteDOC(NAND_CMD_STATUS, docptr, Mplus_FlashCmd);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
-		while (!(this->read_byte(mtd) & 0x40)) ;
+		while (!(this->read_byte(this) & 0x40)) ;
 		return;
 
 		/* This applies to read commands */
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index fbf98280913a..be439309fcfe 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -261,10 +261,9 @@ static inline void write_nop(void __iomem *docptr)
 	writew(0, docptr + DOC_NOP);
 }
 
-static void docg4_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void docg4_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 {
 	int i;
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	uint16_t *p = (uint16_t *) buf;
 	len >>= 1;
 
@@ -484,9 +483,8 @@ static int correct_data(struct mtd_info *mtd, uint8_t *buf, int page)
 	return numerrs;
 }
 
-static uint8_t docg4_read_byte(struct mtd_info *mtd)
+static uint8_t docg4_read_byte(struct nand_chip *nand)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 
 	dev_dbg(doc->dev, "%s\n", __func__);
@@ -809,11 +807,11 @@ static int read_page(struct mtd_info *mtd, struct nand_chip *nand,
 
 	dev_dbg(doc->dev, "%s: status = 0x%x\n", __func__, status);
 
-	docg4_read_buf(mtd, buf, DOCG4_PAGE_SIZE); /* read the page data */
+	docg4_read_buf(nand, buf, DOCG4_PAGE_SIZE); /* read the page data */
 
 	/* this device always reads oob after page data */
 	/* first 14 oob bytes read from I/O reg */
-	docg4_read_buf(mtd, nand->oob_poi, 14);
+	docg4_read_buf(nand, nand->oob_poi, 14);
 
 	/* last 2 read from another reg */
 	buf16 = (uint16_t *)(nand->oob_poi + 14);
@@ -859,7 +857,6 @@ static int docg4_read_page(struct nand_chip *nand, uint8_t *buf,
 
 static int docg4_read_oob(struct nand_chip *nand, int page)
 {
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t status;
@@ -885,7 +882,7 @@ static int docg4_read_oob(struct nand_chip *nand, int page)
 
 	dev_dbg(doc->dev, "%s: status = 0x%x\n", __func__, status);
 
-	docg4_read_buf(mtd, nand->oob_poi, 16);
+	docg4_read_buf(nand, nand->oob_poi, 16);
 
 	write_nop(docptr);
 	write_nop(docptr);
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index c992d7ad39d9..22326bcb8b62 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -581,9 +581,8 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
  * read a byte from either the FCM hardware buffer if it has any data left
  * otherwise issue a command to read a single byte.
  */
-static u8 fsl_elbc_read_byte(struct mtd_info *mtd)
+static u8 fsl_elbc_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
@@ -598,9 +597,8 @@ static u8 fsl_elbc_read_byte(struct mtd_info *mtd)
 /*
  * Read from the FCM Controller Data Buffer
  */
-static void fsl_elbc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void fsl_elbc_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	int avail;
@@ -720,7 +718,7 @@ static int fsl_elbc_read_page(struct nand_chip *chip, uint8_t *buf,
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		fsl_elbc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
+		fsl_elbc_read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	if (fsl_elbc_wait(mtd, chip) & NAND_STATUS_FAIL)
 		mtd->ecc_stats.failed++;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 92fbc948e6eb..2a5e2c88c7fc 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -544,9 +544,8 @@ static void fsl_ifc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
  * Read a byte from either the IFC hardware buffer
  * read function for 8-bit buswidth
  */
-static uint8_t fsl_ifc_read_byte(struct mtd_info *mtd)
+static uint8_t fsl_ifc_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	unsigned int offset;
 
@@ -567,9 +566,8 @@ static uint8_t fsl_ifc_read_byte(struct mtd_info *mtd)
  * Read two bytes from the IFC hardware buffer
  * read function for 16-bit buswith
  */
-static uint8_t fsl_ifc_read_byte16(struct mtd_info *mtd)
+static uint8_t fsl_ifc_read_byte16(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	uint16_t data;
 
@@ -590,9 +588,8 @@ static uint8_t fsl_ifc_read_byte16(struct mtd_info *mtd)
 /*
  * Read from the IFC Controller Data Buffer
  */
-static void fsl_ifc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void fsl_ifc_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	int avail;
 
@@ -688,11 +685,11 @@ static int fsl_ifc_read_page(struct nand_chip *chip, uint8_t *buf,
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		fsl_ifc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
+		fsl_ifc_read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	if (ctrl->nand_stat & IFC_NAND_EVTER_STAT_ECCER) {
 		if (!oob_required)
-			fsl_ifc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
+			fsl_ifc_read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 		return check_erased_page(chip, buf);
 	}
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 2763fd3ad512..965f71b31299 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -124,16 +124,16 @@ static void fun_select_chip(struct mtd_info *mtd, int mchip_nr)
 	}
 }
 
-static uint8_t fun_read_byte(struct mtd_info *mtd)
+static uint8_t fun_read_byte(struct nand_chip *chip)
 {
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 
 	return in_8(fun->chip.IO_ADDR_R);
 }
 
-static void fun_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void fun_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 	int i;
 
 	for (i = 0; i < len; i++)
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 09f33f6006a3..d0d5caa1b7a6 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -859,9 +859,8 @@ static void gpmi_select_chip(struct mtd_info *mtd, int chipnr)
 	this->current_chip = chipnr;
 }
 
-static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void gpmi_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "len is %d\n", len);
@@ -879,13 +878,12 @@ static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	gpmi_send_data(this, buf, len);
 }
 
-static uint8_t gpmi_read_byte(struct mtd_info *mtd)
+static uint8_t gpmi_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	uint8_t *buf = this->data_buffer_dma;
 
-	gpmi_read_buf(mtd, buf, 1);
+	gpmi_read_buf(chip, buf, 1);
 	return buf[0];
 }
 
@@ -1336,7 +1334,7 @@ static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 
 	/* Read out the conventional OOB. */
 	nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/*
 	 * Now, we want to make sure the block mark is correct. In the
@@ -1346,7 +1344,7 @@ static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 	if (GPMI_IS_MX23(this)) {
 		/* Read the block mark into the first byte of the OOB buffer. */
 		nand_read_page_op(chip, page, 0, NULL, 0);
-		chip->oob_poi[0] = chip->read_byte(mtd);
+		chip->oob_poi[0] = chip->read_byte(chip);
 	}
 
 	return 0;
@@ -1635,7 +1633,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 		 * and starts in the 12th byte of the page.
 		 */
 		nand_read_page_op(chip, page, 12, NULL, 0);
-		chip->read_buf(mtd, buffer, strlen(fingerprint));
+		chip->read_buf(chip, buffer, strlen(fingerprint));
 
 		/* Look for the fingerprint. */
 		if (!memcmp(buffer, fingerprint, strlen(fingerprint))) {
@@ -1771,7 +1769,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 		/* Send the command to read the conventional block mark. */
 		chip->select_chip(mtd, chipnr);
 		nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
-		block_mark = chip->read_byte(mtd);
+		block_mark = chip->read_byte(chip);
 		chip->select_chip(mtd, -1);
 
 		/*
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index fab3c7fcf77b..e1fe6963c908 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -364,9 +364,8 @@ static void hisi_nfc_select_chip(struct mtd_info *mtd, int chipselect)
 	host->chipselect = chipselect;
 }
 
-static uint8_t hisi_nfc_read_byte(struct mtd_info *mtd)
+static uint8_t hisi_nfc_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	if (host->command == NAND_CMD_STATUS)
@@ -390,9 +389,8 @@ hisi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	host->offset += len;
 }
 
-static void hisi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void hisi_nfc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	memcpy(buf, host->buffer + host->offset, len);
@@ -537,7 +535,7 @@ static int hisi_nand_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 	int stat_1, stat_2;
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* errors which can not be corrected by ECC */
 	if (host->irq_status & HINFC504_INTS_UE) {
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 6e4017ddacad..5820c86cb1f1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -359,9 +359,8 @@ static int lpc32xx_nand_ecc_calculate(struct nand_chip *chip,
 /*
  * Read a single byte from NAND device
  */
-static uint8_t lpc32xx_nand_read_byte(struct mtd_info *mtd)
+static uint8_t lpc32xx_nand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	return (uint8_t)readl(SLC_DATA(host->io_base));
@@ -370,9 +369,8 @@ static uint8_t lpc32xx_nand_read_byte(struct mtd_info *mtd)
 /*
  * Simple device read without ECC
  */
-static void lpc32xx_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void lpc32xx_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Direct device read with no ECC */
@@ -628,7 +626,7 @@ static int lpc32xx_nand_read_page_syndrome(struct nand_chip *chip, uint8_t *buf,
 	status = lpc32xx_xfer(mtd, buf, chip->ecc.steps, 1);
 
 	/* Get OOB data */
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* Convert to stored ECC format */
 	lpc32xx_slc_ecc_copy(tmpecc, (uint32_t *) host->ecc_buf, chip->ecc.steps);
@@ -669,8 +667,8 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct nand_chip *chip,
 	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* Raw reads can just use the FIFO interface */
-	chip->read_buf(mtd, buf, chip->ecc.size * chip->ecc.steps);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	chip->read_buf(chip, buf, chip->ecc.size * chip->ecc.steps);
+	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index 3c90d6955476..49031f5a3b6d 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -493,9 +493,9 @@ static void mpc5121_nfc_buf_copy(struct mtd_info *mtd, u_char *buf, int len,
 }
 
 /* Read data from NFC buffers */
-static void mpc5121_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void mpc5121_nfc_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
-	mpc5121_nfc_buf_copy(mtd, buf, len, 0);
+	mpc5121_nfc_buf_copy(nand_to_mtd(chip), buf, len, 0);
 }
 
 /* Write data to NFC buffers */
@@ -506,11 +506,11 @@ static void mpc5121_nfc_write_buf(struct mtd_info *mtd,
 }
 
 /* Read byte from NFC buffers */
-static u8 mpc5121_nfc_read_byte(struct mtd_info *mtd)
+static u8 mpc5121_nfc_read_byte(struct nand_chip *chip)
 {
 	u8 tmp;
 
-	mpc5121_nfc_read_buf(mtd, &tmp, sizeof(tmp));
+	mpc5121_nfc_read_buf(chip, &tmp, sizeof(tmp));
 
 	return tmp;
 }
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index c338a9646433..1c7392242d4d 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -438,9 +438,8 @@ static inline void mtk_nfc_wait_ioready(struct mtk_nfc *nfc)
 		dev_err(nfc->dev, "data not ready\n");
 }
 
-static inline u8 mtk_nfc_read_byte(struct mtd_info *mtd)
+static inline u8 mtk_nfc_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 	u32 reg;
 
@@ -467,12 +466,12 @@ static inline u8 mtk_nfc_read_byte(struct mtd_info *mtd)
 	return nfi_readb(nfc, NFI_DATAR);
 }
 
-static void mtk_nfc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void mtk_nfc_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++)
-		buf[i] = mtk_nfc_read_byte(mtd);
+		buf[i] = mtk_nfc_read_byte(chip);
 }
 
 static void mtk_nfc_write_byte(struct mtd_info *mtd, u8 byte)
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 597c74ea7e5e..8fed2919f35e 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -895,9 +895,8 @@ static int mxc_nand_write_oob(struct nand_chip *chip, int page)
 	return mxc_nand_write_page(chip, host->data_buf, false, page);
 }
 
-static u_char mxc_nand_read_byte(struct mtd_info *mtd)
+static u_char mxc_nand_read_byte(struct nand_chip *nand_chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint8_t ret;
 
@@ -941,9 +940,10 @@ static void mxc_nand_write_buf(struct mtd_info *mtd,
  * Flash first the data output cycle is initiated by the NFC, which copies
  * the data to RAMbuffer. This data of length len is then copied to buffer buf.
  */
-static void mxc_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void mxc_nand_read_buf(struct nand_chip *nand_chip, u_char *buf,
+			      int len)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	u16 col = host->buf_start;
 	int n = mtd->oobsize + mtd->writesize - col;
@@ -1429,7 +1429,7 @@ static int mxc_nand_get_features(struct mtd_info *mtd, struct nand_chip *chip,
 	host->buf_start = 0;
 
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		*subfeature_param++ = chip->read_byte(mtd);
+		*subfeature_param++ = chip->read_byte(chip);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cc386ee64a1b..e4686078011d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -254,26 +254,24 @@ static void nand_release_device(struct mtd_info *mtd)
 
 /**
  * nand_read_byte - [DEFAULT] read one byte from the chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * Default read function for 8bit buswidth
  */
-static uint8_t nand_read_byte(struct mtd_info *mtd)
+static uint8_t nand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	return readb(chip->IO_ADDR_R);
 }
 
 /**
  * nand_read_byte16 - [DEFAULT] read one byte endianness aware from the chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * Default read function for 16bit buswidth with endianness conversion.
  *
  */
-static uint8_t nand_read_byte16(struct mtd_info *mtd)
+static uint8_t nand_read_byte16(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	return (uint8_t) cpu_to_le16(readw(chip->IO_ADDR_R));
 }
 
@@ -362,16 +360,14 @@ static void nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 /**
  * nand_read_buf - [DEFAULT] read chip data into buffer
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: buffer to store date
  * @len: number of bytes to read
  *
  * Default read function for 8bit buswidth.
  */
-static void nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	ioread8_rep(chip->IO_ADDR_R, buf, len);
 }
 
@@ -393,15 +389,14 @@ static void nand_write_buf16(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 /**
  * nand_read_buf16 - [DEFAULT] read chip data into buffer
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: buffer to store date
  * @len: number of bytes to read
  *
  * Default read function for 16bit buswidth.
  */
-static void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
+static void nand_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u16 *p = (u16 *) buf;
 
 	ioread16_rep(chip->IO_ADDR_R, p, len >> 1);
@@ -1544,7 +1539,7 @@ int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 
 	chip->cmdfunc(mtd, NAND_CMD_READ0, offset_in_page, page);
 	if (len)
-		chip->read_buf(mtd, buf, len);
+		chip->read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1593,7 +1588,7 @@ static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 
 	chip->cmdfunc(mtd, NAND_CMD_PARAM, page, -1);
 	for (i = 0; i < len; i++)
-		p[i] = chip->read_byte(mtd);
+		p[i] = chip->read_byte(chip);
 
 	return 0;
 }
@@ -1656,7 +1651,7 @@ int nand_change_read_column_op(struct nand_chip *chip,
 
 	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset_in_page, -1);
 	if (len)
-		chip->read_buf(mtd, buf, len);
+		chip->read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1693,7 +1688,7 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 
 	chip->cmdfunc(mtd, NAND_CMD_READOOB, offset_in_oob, page);
 	if (len)
-		chip->read_buf(mtd, buf, len);
+		chip->read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -2009,7 +2004,7 @@ int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 	chip->cmdfunc(mtd, NAND_CMD_READID, addr, -1);
 
 	for (i = 0; i < len; i++)
-		id[i] = chip->read_byte(mtd);
+		id[i] = chip->read_byte(chip);
 
 	return 0;
 }
@@ -2048,7 +2043,7 @@ int nand_status_op(struct nand_chip *chip, u8 *status)
 
 	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
 	if (status)
-		*status = chip->read_byte(mtd);
+		*status = chip->read_byte(chip);
 
 	return 0;
 }
@@ -2229,7 +2224,7 @@ static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 
 	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		params[i] = chip->read_byte(mtd);
+		params[i] = chip->read_byte(chip);
 
 	return 0;
 }
@@ -2304,8 +2299,6 @@ EXPORT_SYMBOL_GPL(nand_reset_op);
 int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		      bool force_8bit)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!len || !buf)
 		return -EINVAL;
 
@@ -2325,9 +2318,9 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		unsigned int i;
 
 		for (i = 0; i < len; i++)
-			p[i] = chip->read_byte(mtd);
+			p[i] = chip->read_byte(chip);
 	} else {
-		chip->read_buf(mtd, buf, len);
+		chip->read_buf(chip, buf, len);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index e9f7b9e1aead..04feb4e8d112 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1872,9 +1872,8 @@ static void switch_state(struct nandsim *ns)
 	}
 }
 
-static u_char ns_nand_read_byte(struct mtd_info *mtd)
+static u_char ns_nand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nandsim *ns = nand_get_controller_data(chip);
 	u_char outb = 0x00;
 
@@ -2136,9 +2135,8 @@ static void ns_nand_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 	}
 }
 
-static void ns_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void ns_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nandsim *ns = nand_get_controller_data(chip);
 
 	/* Sanity and correctness checks */
@@ -2160,7 +2158,7 @@ static void ns_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 		int i;
 
 		for (i = 0; i < len; i++)
-			buf[i] = mtd_to_nand(mtd)->read_byte(mtd);
+			buf[i] = chip->read_byte(chip);
 
 		return;
 	}
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index de365729c282..1c5e7606e07f 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -116,9 +116,8 @@ static int ndfc_calculate_ecc(struct nand_chip *chip,
  * functions. No further checking, as nand_base will always read/write
  * page aligned.
  */
-static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void ndfc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t *p = (uint32_t *) buf;
 
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 0c675b6c0b6e..3a88da5ec97f 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -79,21 +79,21 @@ static const struct mtd_partition partitions[] = {
 	}
 };
 
-static unsigned char nuc900_nand_read_byte(struct mtd_info *mtd)
+static unsigned char nuc900_nand_read_byte(struct nand_chip *chip)
 {
 	unsigned char ret;
-	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
 
 	ret = (unsigned char)read_data_reg(nand);
 
 	return ret;
 }
 
-static void nuc900_nand_read_buf(struct mtd_info *mtd,
+static void nuc900_nand_read_buf(struct nand_chip *chip,
 				 unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
 
 	for (i = 0; i < len; i++)
 		buf[i] = (unsigned char)read_data_reg(nand);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index f1f8b6c1d654..4f2e5cd86050 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -337,12 +337,13 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 
 /**
  * omap_read_buf_pref - read data from NAND controller into buffer
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: buffer to store date
  * @len: number of bytes to read
  */
-static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
+static void omap_read_buf_pref(struct nand_chip *chip, u_char *buf, int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	uint32_t r_count = 0;
 	int ret = 0;
@@ -528,14 +529,17 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 
 /**
  * omap_read_buf_dma_pref - read data from NAND controller into buffer
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: buffer to store date
  * @len: number of bytes to read
  */
-static void omap_read_buf_dma_pref(struct mtd_info *mtd, u_char *buf, int len)
+static void omap_read_buf_dma_pref(struct nand_chip *chip, u_char *buf,
+				   int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	if (len <= mtd->oobsize)
-		omap_read_buf_pref(mtd, buf, len);
+		omap_read_buf_pref(chip, buf, len);
 	else
 		/* start transfer in DMA mode */
 		omap_nand_dma_transfer(mtd, buf, len, 0x0);
@@ -605,17 +609,19 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 
 /*
  * omap_read_buf_irq_pref - read data from NAND controller into buffer
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @buf: buffer to store date
  * @len: number of bytes to read
  */
-static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
+static void omap_read_buf_irq_pref(struct nand_chip *chip, u_char *buf,
+				   int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int ret = 0;
 
 	if (len <= mtd->oobsize) {
-		omap_read_buf_pref(mtd, buf, len);
+		omap_read_buf_pref(chip, buf, len);
 		return;
 	}
 
@@ -1642,7 +1648,7 @@ static int omap_read_page_bch(struct nand_chip *chip, uint8_t *buf,
 	chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 	/* Read data */
-	chip->read_buf(mtd, buf, mtd->writesize);
+	chip->read_buf(chip, buf, mtd->writesize);
 
 	/* Read oob bytes */
 	nand_change_read_column_op(chip,
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 5c58d91ffaee..870eabe6fff8 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -48,9 +48,8 @@ static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl
 	writeb(cmd, nc->IO_ADDR_W + offs);
 }
 
-static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void orion_nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	void __iomem *io_base = chip->IO_ADDR_R;
 #if defined(__LINUX_ARM_ARCH__) && __LINUX_ARM_ARCH__ >= 5
 	uint64_t *buf64;
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 5bc180536320..6156abb30b7a 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -38,17 +38,15 @@ struct oxnas_nand_ctrl {
 	struct nand_chip *chips[OXNAS_NAND_MAX_CHIPS];
 };
 
-static uint8_t oxnas_nand_read_byte(struct mtd_info *mtd)
+static uint8_t oxnas_nand_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
 
 	return readb(oxnas->io_base);
 }
 
-static void oxnas_nand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void oxnas_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
 
 	ioread8_rep(oxnas->io_base, buf, len);
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index c8e2ac04fb86..551e5db670be 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -43,10 +43,8 @@ static unsigned int lpcctl;
 static struct mtd_info *pasemi_nand_mtd;
 static const char driver_name[] = "pasemi-nand";
 
-static void pasemi_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void pasemi_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	while (len > 0x800) {
 		memcpy_fromio(buf, chip->IO_ADDR_R, 0x800);
 		buf += 0x800;
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 80e1a44f0465..5193806923ba 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -52,13 +52,6 @@ static void plat_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 	pdata->ctrl.write_buf(mtd_to_nand(mtd), buf, len);
 }
 
-static void plat_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
-{
-	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
-
-	pdata->ctrl.read_buf(mtd_to_nand(mtd), buf, len);
-}
-
 /*
  * Probe for the NAND device.
  */
@@ -111,9 +104,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	if (pdata->ctrl.write_buf)
 		data->chip.write_buf = plat_nand_write_buf;
 
-	if (pdata->ctrl.read_buf)
-		data->chip.read_buf = plat_nand_read_buf;
-
+	data->chip.read_buf = pdata->ctrl.read_buf;
 	data->chip.chip_delay = pdata->chip.chip_delay;
 	data->chip.options |= pdata->chip.options;
 	data->chip.bbt_options |= pdata->chip.bbt_options;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 2353a48debb2..881b955b3308 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2283,9 +2283,8 @@ static int qcom_nandc_block_markbad(struct mtd_info *mtd, loff_t ofs)
  * reading/writing page data, they are used for smaller data like reading
  * id, status etc
  */
-static uint8_t qcom_nandc_read_byte(struct mtd_info *mtd)
+static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u8 *buf = nandc->data_buffer;
@@ -2305,9 +2304,8 @@ static uint8_t qcom_nandc_read_byte(struct mtd_info *mtd)
 	return ret;
 }
 
-static void qcom_nandc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
 
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index aa5516b3b45f..07055bd657cd 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -266,9 +266,9 @@ static void r852_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 /*
  * Read data lines of the nand chip to retrieve data
  */
-static void r852_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void r852_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 	uint32_t reg;
 
 	if (dev->card_unstable) {
@@ -303,9 +303,9 @@ static void r852_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 /*
  * Read one byte from nand chip
  */
-static uint8_t r852_read_byte(struct mtd_info *mtd)
+static uint8_t r852_read_byte(struct nand_chip *chip)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 
 	/* Same problem as in r852_read_buf.... */
 	if (dev->card_unstable)
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index d57201d118d8..54c86ec612dd 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -675,14 +675,14 @@ static int s3c2440_nand_calculate_ecc(struct nand_chip *chip,
  * use read/write block to move the data buffers to/from the controller
 */
 
-static void s3c2410_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void s3c2410_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	readsb(this->IO_ADDR_R, buf, len);
 }
 
-static void s3c2440_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void s3c2440_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
+	struct mtd_info *mtd = nand_to_mtd(this);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	readsl(info->regs + S3C2440_NFDATA, buf, len >> 2);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index bb58edd2bdf0..6966a18f8ac4 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -618,7 +618,7 @@ static int flctl_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+		chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 	return 0;
 }
 
@@ -978,9 +978,9 @@ static void flctl_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	flctl->index += len;
 }
 
-static uint8_t flctl_read_byte(struct mtd_info *mtd)
+static uint8_t flctl_read_byte(struct nand_chip *chip)
 {
-	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct sh_flctl *flctl = mtd_to_flctl(nand_to_mtd(chip));
 	uint8_t data;
 
 	data = flctl->done_buff[flctl->index];
@@ -988,9 +988,9 @@ static uint8_t flctl_read_byte(struct mtd_info *mtd)
 	return data;
 }
 
-static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void flctl_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct sh_flctl *flctl = mtd_to_flctl(nand_to_mtd(chip));
 
 	memcpy(buf, &flctl->done_buff[flctl->index], len);
 	flctl->index += len;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 82ba371a8e18..007e37680b88 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -54,14 +54,14 @@ static void socrates_nand_write_buf(struct mtd_info *mtd,
 
 /**
  * socrates_nand_read_buf -  read chip data into buffer
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @buf:	buffer to store date
  * @len:	number of bytes to read
  */
-static void socrates_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void socrates_nand_read_buf(struct nand_chip *this, uint8_t *buf,
+				   int len)
 {
 	int i;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct socrates_nand_host *host = nand_get_controller_data(this);
 	uint32_t val;
 
@@ -78,10 +78,10 @@ static void socrates_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
  * socrates_nand_read_byte -  read one byte from the chip
  * @mtd:	MTD device structure
  */
-static uint8_t socrates_nand_read_byte(struct mtd_info *mtd)
+static uint8_t socrates_nand_read_byte(struct nand_chip *this)
 {
 	uint8_t byte;
-	socrates_nand_read_buf(mtd, &byte, sizeof(byte));
+	socrates_nand_read_buf(this, &byte, sizeof(byte));
 	return byte;
 }
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 86d666c0c03c..2a0e624eca6c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -464,9 +464,8 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 	sunxi_nand->selected = chip;
 }
 
-static void sunxi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
@@ -540,11 +539,11 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 	}
 }
 
-static uint8_t sunxi_nfc_read_byte(struct mtd_info *mtd)
+static uint8_t sunxi_nfc_read_byte(struct nand_chip *nand)
 {
 	uint8_t ret = 0;
 
-	sunxi_nfc_read_buf(mtd, &ret, 1);
+	sunxi_nfc_read_buf(nand, &ret, 1);
 
 	return ret;
 }
@@ -770,7 +769,7 @@ static void sunxi_nfc_randomizer_read_buf(struct mtd_info *mtd, uint8_t *buf,
 {
 	sunxi_nfc_randomizer_config(mtd, page, ecc);
 	sunxi_nfc_randomizer_enable(mtd);
-	sunxi_nfc_read_buf(mtd, buf, len);
+	sunxi_nfc_read_buf(mtd_to_nand(mtd), buf, len);
 	sunxi_nfc_randomizer_disable(mtd);
 }
 
@@ -995,7 +994,7 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 					   false);
 
 	if (!randomize)
-		sunxi_nfc_read_buf(mtd, oob + offset, len);
+		sunxi_nfc_read_buf(nand, oob + offset, len);
 	else
 		sunxi_nfc_randomizer_read_buf(mtd, oob + offset, len,
 					      false, page);
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 7c8f47546002..20d6fa983a6b 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -135,16 +135,16 @@ static int tango_dev_ready(struct mtd_info *mtd)
 	return readl_relaxed(nfc->pbus_base + PBUS_CS_CTRL) & PBUS_IORDY;
 }
 
-static u8 tango_read_byte(struct mtd_info *mtd)
+static u8 tango_read_byte(struct nand_chip *chip)
 {
-	struct tango_chip *tchip = to_tango_chip(mtd_to_nand(mtd));
+	struct tango_chip *tchip = to_tango_chip(chip);
 
 	return readb_relaxed(tchip->base + PBUS_DATA);
 }
 
-static void tango_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void tango_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct tango_chip *tchip = to_tango_chip(mtd_to_nand(mtd));
+	struct tango_chip *tchip = to_tango_chip(chip);
 
 	ioread8_rep(tchip->base + PBUS_DATA, buf, len);
 }
@@ -325,15 +325,13 @@ static int tango_write_page(struct nand_chip *chip, const u8 *buf,
 
 static void aux_read(struct nand_chip *chip, u8 **buf, int len, int *pos)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	*pos += len;
 
 	if (!*buf) {
 		/* skip over "len" bytes */
 		nand_change_read_column_op(chip, *pos, NULL, 0, false);
 	} else {
-		tango_read_buf(mtd, *buf, len);
+		tango_read_buf(chip, *buf, len);
 		*buf += len;
 	}
 }
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 734ff29705ce..570ea045fbce 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -225,9 +225,9 @@ tmio_nand_wait(struct mtd_info *mtd, struct nand_chip *nand_chip)
   *To prevent stale data from being read, tmio_nand_hwcontrol() clears
   *tmio->read_good.
  */
-static u_char tmio_nand_read_byte(struct mtd_info *mtd)
+static u_char tmio_nand_read_byte(struct nand_chip *chip)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 	unsigned int data;
 
 	if (tmio->read_good--)
@@ -252,9 +252,9 @@ tmio_nand_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 	tmio_iowrite16_rep(tmio->fcr + FCR_DATA, buf, len >> 1);
 }
 
-static void tmio_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void tmio_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 
 	tmio_ioread16_rep(tmio->fcr + FCR_DATA, buf, len >> 1);
 }
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 3c69d834de62..c68b638c4fe8 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -102,9 +102,9 @@ static void txx9ndfmc_write(struct platform_device *dev,
 	__raw_writel(val, ndregaddr(dev, reg));
 }
 
-static uint8_t txx9ndfmc_read_byte(struct mtd_info *mtd)
+static uint8_t txx9ndfmc_read_byte(struct nand_chip *chip)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 
 	return txx9ndfmc_read(dev, TXX9_NDFDTR);
 }
@@ -122,9 +122,9 @@ static void txx9ndfmc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 	txx9ndfmc_write(dev, mcr, TXX9_NDFMCR);
 }
 
-static void txx9ndfmc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+static void txx9ndfmc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 	void __iomem *ndfdtr = ndregaddr(dev, TXX9_NDFDTR);
 
 	while (len--)
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 1adb41acebfc..edbcfaa85ed8 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -125,17 +125,17 @@ static int xway_dev_ready(struct mtd_info *mtd)
 	return ltq_ebu_r32(EBU_NAND_WAIT) & NAND_WAIT_RD;
 }
 
-static unsigned char xway_read_byte(struct mtd_info *mtd)
+static unsigned char xway_read_byte(struct nand_chip *chip)
 {
-	return xway_readb(mtd, NAND_READ_DATA);
+	return xway_readb(nand_to_mtd(chip), NAND_READ_DATA);
 }
 
-static void xway_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void xway_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++)
-		buf[i] = xway_readb(mtd, NAND_WRITE_DATA);
+		buf[i] = xway_readb(nand_to_mtd(chip), NAND_WRITE_DATA);
 }
 
 static void xway_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 2b2f98efdb54..644c91ff2734 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -657,7 +657,7 @@ static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
 
 	nand_read_page_op(chip, page, 0, p, eccsize * eccsteps);
 	if (oob_required)
-		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+		chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	while (1) {
 		retval = spinand_read_status(info->spi, &status);
@@ -685,9 +685,9 @@ static void spinand_select_chip(struct mtd_info *mtd, int dev)
 {
 }
 
-static u8 spinand_read_byte(struct mtd_info *mtd)
+static u8 spinand_read_byte(struct nand_chip *chip)
 {
-	struct spinand_state *state = mtd_to_state(mtd);
+	struct spinand_state *state = mtd_to_state(nand_to_mtd(chip));
 	u8 data;
 
 	data = state->buf[state->buf_ptr];
@@ -732,9 +732,9 @@ static void spinand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	state->buf_ptr += len;
 }
 
-static void spinand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+static void spinand_read_buf(struct nand_chip *chip, u8 *buf, int len)
 {
-	struct spinand_state *state = mtd_to_state(mtd);
+	struct spinand_state *state = mtd_to_state(nand_to_mtd(chip));
 
 	memcpy(buf, state->buf + state->buf_ptr, len);
 	state->buf_ptr += len;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 527947e81447..f324a82fe6a2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1283,10 +1283,10 @@ struct nand_chip {
 	void __iomem *IO_ADDR_R;
 	void __iomem *IO_ADDR_W;
 
-	uint8_t (*read_byte)(struct mtd_info *mtd);
+	uint8_t (*read_byte)(struct nand_chip *chip);
 	void (*write_byte)(struct mtd_info *mtd, uint8_t byte);
 	void (*write_buf)(struct mtd_info *mtd, const uint8_t *buf, int len);
-	void (*read_buf)(struct mtd_info *mtd, uint8_t *buf, int len);
+	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*block_bad)(struct mtd_info *mtd, loff_t ofs);
 	int (*block_markbad)(struct mtd_info *mtd, loff_t ofs);
-- 
2.14.1
