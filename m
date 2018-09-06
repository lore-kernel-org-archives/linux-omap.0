From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 15/23] mtd: rawnand: Pass a nand_chip object to
 chip->dev_ready()
Date: Thu,  6 Sep 2018 14:05:27 +0200
Message-ID: <20180906120535.21255-16-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
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

Let's tackle the chip->dev_ready() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |  2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  6 ++----
 drivers/mtd/nand/raw/au1550nd.c                  |  6 +++---
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  3 +--
 drivers/mtd/nand/raw/cafe_nand.c                 |  3 +--
 drivers/mtd/nand/raw/cmx270_nand.c               |  2 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  3 +--
 drivers/mtd/nand/raw/davinci_nand.c              |  4 ++--
 drivers/mtd/nand/raw/denali.c                    |  4 ++--
 drivers/mtd/nand/raw/diskonchip.c                |  5 ++---
 drivers/mtd/nand/raw/fsl_upm.c                   |  6 +++---
 drivers/mtd/nand/raw/gpio.c                      |  4 ++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  3 +--
 drivers/mtd/nand/raw/jz4740_nand.c               |  4 ++--
 drivers/mtd/nand/raw/jz4780_nand.c               |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  3 +--
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  3 +--
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  2 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |  4 ++--
 drivers/mtd/nand/raw/mxc_nand.c                  |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 10 +++++-----
 drivers/mtd/nand/raw/nandsim.c                   |  2 +-
 drivers/mtd/nand/raw/ndfc.c                      |  3 +--
 drivers/mtd/nand/raw/nuc900_nand.c               |  6 +++---
 drivers/mtd/nand/raw/omap2.c                     |  4 ++--
 drivers/mtd/nand/raw/pasemi_nand.c               |  2 +-
 drivers/mtd/nand/raw/plat_nand.c                 | 12 +-----------
 drivers/mtd/nand/raw/r852.c                      |  6 +++---
 drivers/mtd/nand/raw/s3c2410.c                   |  9 ++++++---
 drivers/mtd/nand/raw/sharpsl.c                   |  4 ++--
 drivers/mtd/nand/raw/socrates_nand.c             |  3 +--
 drivers/mtd/nand/raw/sunxi_nand.c                |  3 +--
 drivers/mtd/nand/raw/tango_nand.c                |  3 +--
 drivers/mtd/nand/raw/tmio_nand.c                 |  8 ++++----
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  4 ++--
 drivers/mtd/nand/raw/xway_nand.c                 |  2 +-
 include/linux/mtd/rawnand.h                      |  2 +-
 37 files changed, 68 insertions(+), 88 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 8121d26194cf..48413203dbc2 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -130,7 +130,7 @@ static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 		ams_delta_write_byte(this, cmd);
 }
 
-static int ams_delta_nand_ready(struct mtd_info *mtd)
+static int ams_delta_nand_ready(struct nand_chip *this)
 {
 	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
 }
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index f088bff06723..2dcd8aa0ce0b 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -475,9 +475,8 @@ static void atmel_nand_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 		iowrite8_rep(nand->activecs->io.virt, buf, len);
 }
 
-static int atmel_nand_dev_ready(struct mtd_info *mtd)
+static int atmel_nand_dev_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 
 	return gpiod_get_value(nand->activecs->rb.gpio);
@@ -499,9 +498,8 @@ static void atmel_nand_select_chip(struct nand_chip *chip, int cs)
 		chip->dev_ready = atmel_nand_dev_ready;
 }
 
-static int atmel_hsmc_nand_dev_ready(struct mtd_info *mtd)
+static int atmel_hsmc_nand_dev_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_hsmc_nand_controller *nc;
 	u32 status;
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 1bae3b2779aa..1f0fba8d87c6 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -213,7 +213,7 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 	wmb(); /* Drain the writebuffer */
 }
 
-int au1550_device_ready(struct mtd_info *mtd)
+int au1550_device_ready(struct nand_chip *this)
 {
 	return (alchemy_rdsmem(AU1000_MEM_STSTAT) & 0x1) ? 1 : 0;
 }
@@ -341,7 +341,7 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 		/* Apply a short delay always to ensure that we do wait tWB. */
 		ndelay(100);
 		/* Wait for a chip to become ready... */
-		for (i = this->chip_delay; !this->dev_ready(mtd) && i > 0; --i)
+		for (i = this->chip_delay; !this->dev_ready(this) && i > 0; --i)
 			udelay(1);
 
 		/* Release -CE and re-enable interrupts. */
@@ -352,7 +352,7 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 	/* Apply this short delay always to ensure that we do wait tWB. */
 	ndelay(100);
 
-	while(!this->dev_ready(mtd));
+	while(!this->dev_ready(this));
 }
 
 static int find_nand_cs(unsigned long nand_base)
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index d326f9d3648b..f6f694b3cd8e 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -196,9 +196,8 @@ static void bcm47xxnflash_ops_bcm4706_select_chip(struct nand_chip *chip,
 	return;
 }
 
-static int bcm47xxnflash_ops_bcm4706_dev_ready(struct mtd_info *mtd)
+static int bcm47xxnflash_ops_bcm4706_dev_ready(struct nand_chip *nand_chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 
 	return !!(bcma_cc_read32(b47n->cc, BCMA_CC_NFLASH_CTL) & NCTL_READY);
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index af6870269f9c..60a2eecc2b2a 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -100,9 +100,8 @@ static const char *part_probes[] = { "cmdlinepart", "RedBoot", NULL };
 #define cafe_readl(cafe, addr)			readl((cafe)->mmio + CAFE_##addr)
 #define cafe_writel(cafe, datum, addr)		writel(datum, (cafe)->mmio + CAFE_##addr)
 
-static int cafe_device_ready(struct mtd_info *mtd)
+static int cafe_device_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	int result = !!(cafe_readl(cafe, NAND_STATUS) & 0x40000000);
 	uint32_t irqs = cafe_readl(cafe, NAND_IRQ);
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index a0f0ad2da6f1..e8458036419b 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -119,7 +119,7 @@ static void cmx270_hwcontrol(struct nand_chip *this, int dat,
 /*
  *	read device ready pin
  */
-static int cmx270_device_ready(struct mtd_info *mtd)
+static int cmx270_device_ready(struct nand_chip *this)
 {
 	dsb();
 
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index b7432f086f9b..c1628c03282a 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -141,9 +141,8 @@ static void cs553x_hwcontrol(struct nand_chip *this, int cmd,
 		cs553x_write_byte(this, cmd);
 }
 
-static int cs553x_device_ready(struct mtd_info *mtd)
+static int cs553x_device_ready(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *mmio_base = this->IO_ADDR_R;
 	unsigned char foo = readb(mmio_base + MM_NAND_STS);
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index c2a3ad10610c..4b261c73b240 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -460,9 +460,9 @@ static void nand_davinci_write_buf(struct nand_chip *chip, const uint8_t *buf,
  * Check hardware register for wait status. Returns 1 if device is ready,
  * 0 if it is still busy.
  */
-static int nand_davinci_dev_ready(struct mtd_info *mtd)
+static int nand_davinci_dev_ready(struct nand_chip *chip)
 {
-	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
 
 	return davinci_nand_readl(info, NANDFSR_OFFSET) & BIT(0);
 }
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 6529780e31a4..7258dd13b3f9 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -296,9 +296,9 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
 }
 
-static int denali_dev_ready(struct mtd_info *mtd)
+static int denali_dev_ready(struct nand_chip *chip)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 
 	return !!(denali_check_irq(denali) & INTR__INT_ACT);
 }
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 16498b277764..e40a4e120c7b 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -739,12 +739,11 @@ static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int colu
 	 * any case on any machine. */
 	ndelay(100);
 	/* wait until command is processed */
-	while (!this->dev_ready(mtd)) ;
+	while (!this->dev_ready(this)) ;
 }
 
-static int doc200x_dev_ready(struct mtd_info *mtd)
+static int doc200x_dev_ready(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 7a2488c6c212..48c5215f9a0e 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -52,9 +52,9 @@ static inline struct fsl_upm_nand *to_fsl_upm_nand(struct mtd_info *mtdinfo)
 			    chip);
 }
 
-static int fun_chip_ready(struct mtd_info *mtd)
+static int fun_chip_ready(struct nand_chip *chip)
 {
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 
 	if (gpio_get_value(fun->rnb_gpio[fun->mchip_number]))
 		return 1;
@@ -69,7 +69,7 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 		struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 		int cnt = 1000000;
 
-		while (--cnt && !fun_chip_ready(mtd))
+		while (--cnt && !fun_chip_ready(&fun->chip))
 			cpu_relax();
 		if (!cnt)
 			dev_err(fun->dev, "tired waiting for RNB\n");
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 722a930ac836..273437c1ae6c 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -94,9 +94,9 @@ static void gpio_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 	gpio_nand_dosync(gpiomtd);
 }
 
-static int gpio_nand_devready(struct mtd_info *mtd)
+static int gpio_nand_devready(struct nand_chip *chip)
 {
-	struct gpiomtd *gpiomtd = gpio_nand_getpriv(mtd);
+	struct gpiomtd *gpiomtd = gpio_nand_getpriv(nand_to_mtd(chip));
 
 	return gpiod_get_value(gpiomtd->rdy);
 }
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 460f2f77a424..1ed594a155ed 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -816,9 +816,8 @@ static void gpmi_cmd_ctrl(struct nand_chip *chip, int data, unsigned int ctrl)
 	this->command_length = 0;
 }
 
-static int gpmi_dev_ready(struct mtd_info *mtd)
+static int gpmi_dev_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	return gpmi_is_ready(this, this->current_chip);
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 7999e691e636..946a71cf816d 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -127,9 +127,9 @@ static void jz_nand_cmd_ctrl(struct nand_chip *chip, int dat,
 		writeb(dat, chip->IO_ADDR_W);
 }
 
-static int jz_nand_dev_ready(struct mtd_info *mtd)
+static int jz_nand_dev_ready(struct nand_chip *chip)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	return gpiod_get_value_cansleep(nand->busy_gpio);
 }
 
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 1d2cba546258..d54b2774f7f9 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -109,9 +109,9 @@ static void jz4780_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 		writeb(cmd, cs->base + OFFSET_CMD);
 }
 
-static int jz4780_nand_dev_ready(struct mtd_info *mtd)
+static int jz4780_nand_dev_ready(struct nand_chip *chip)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 
 	return !gpiod_get_value_cansleep(nand->busy_gpio);
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 0e989d944ddb..726cd8868ac3 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -302,9 +302,8 @@ static void lpc32xx_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
 /*
  * Read Device Ready (NAND device _and_ controller ready)
  */
-static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
+static int lpc32xx_nand_device_ready(struct nand_chip *nand_chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if ((readb(MLC_ISR(host->io_base)) &
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index e42584de875c..26d27a81f814 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -303,9 +303,8 @@ static void lpc32xx_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 /*
  * Read the Device Ready pin
  */
-static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
+static int lpc32xx_nand_device_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int rdy = 0;
 
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index c2002c4d467b..ba7af061c0eb 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -320,7 +320,7 @@ static void ads5121_select_chip(struct nand_chip *nand, int chip)
 }
 
 /* Read NAND Ready/Busy signal */
-static int mpc5121_nfc_dev_ready(struct mtd_info *mtd)
+static int mpc5121_nfc_dev_ready(struct nand_chip *nand)
 {
 	/*
 	 * NFC handles ready/busy signal internally. Therefore, this function
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 6baa41483931..cf8c42fb8feb 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -402,9 +402,9 @@ static void mtk_nfc_select_chip(struct nand_chip *nand, int chip)
 	nfi_writel(nfc, mtk_nand->sels[chip], NFI_CSEL);
 }
 
-static int mtk_nfc_dev_ready(struct mtd_info *mtd)
+static int mtk_nfc_dev_ready(struct nand_chip *nand)
 {
-	struct mtk_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
+	struct mtk_nfc *nfc = nand_get_controller_data(nand);
 
 	if (nfi_readl(nfc, NFI_STA) & STA_BUSY)
 		return 0;
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index d070ce461b69..82e5b1864399 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -701,7 +701,7 @@ static void mxc_nand_enable_hwecc_v3(struct nand_chip *chip, bool enable)
 }
 
 /* This functions is used by upper layer to checks if device is ready */
-static int mxc_nand_dev_ready(struct mtd_info *mtd)
+static int mxc_nand_dev_ready(struct nand_chip *chip)
 {
 	/*
 	 * NFC handles R/B internally. Therefore, this function
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f0d70164a2f1..66dae8b69fe8 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -603,7 +603,7 @@ static void panic_nand_wait_ready(struct mtd_info *mtd, unsigned long timeo)
 
 	/* Wait for the device to get ready */
 	for (i = 0; i < timeo; i++) {
-		if (chip->dev_ready(mtd))
+		if (chip->dev_ready(chip))
 			break;
 		touch_softlockup_watchdog();
 		mdelay(1);
@@ -627,12 +627,12 @@ void nand_wait_ready(struct nand_chip *chip)
 	/* Wait until command is processed or timeout occurs */
 	timeo = jiffies + msecs_to_jiffies(timeo);
 	do {
-		if (chip->dev_ready(mtd))
+		if (chip->dev_ready(chip))
 			return;
 		cond_resched();
 	} while (time_before(jiffies, timeo));
 
-	if (!chip->dev_ready(mtd))
+	if (!chip->dev_ready(chip))
 		pr_warn_ratelimited("timeout while waiting for chip to become ready\n");
 }
 EXPORT_SYMBOL_GPL(nand_wait_ready);
@@ -1068,7 +1068,7 @@ static void panic_nand_wait(struct mtd_info *mtd, struct nand_chip *chip,
 	int i;
 	for (i = 0; i < timeo; i++) {
 		if (chip->dev_ready) {
-			if (chip->dev_ready(mtd))
+			if (chip->dev_ready(chip))
 				break;
 		} else {
 			int ret;
@@ -1116,7 +1116,7 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		timeo = jiffies + msecs_to_jiffies(timeo);
 		do {
 			if (chip->dev_ready) {
-				if (chip->dev_ready(mtd))
+				if (chip->dev_ready(chip))
 					break;
 			} else {
 				ret = nand_read_data_op(chip, &status,
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index a6b626c935a8..f750783d5d6a 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2099,7 +2099,7 @@ static void ns_hwcontrol(struct nand_chip *chip, int cmd, unsigned int bitmask)
 		ns_nand_write_byte(chip, cmd);
 }
 
-static int ns_device_ready(struct mtd_info *mtd)
+static int ns_device_ready(struct nand_chip *chip)
 {
 	NS_DBG("device_ready\n");
 	return 1;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 05ac7bf94874..b96070a3afff 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -71,9 +71,8 @@ static void ndfc_hwcontrol(struct nand_chip *chip, int cmd, unsigned int ctrl)
 		writel(cmd & 0xFF, ndfc->ndfcbase + NDFC_ALE);
 }
 
-static int ndfc_ready(struct mtd_info *mtd)
+static int ndfc_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	return in_be32(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 357b3cf03195..4029b802243d 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -120,9 +120,9 @@ static int nuc900_check_rb(struct nuc900_nand *nand)
 	return val;
 }
 
-static int nuc900_nand_devready(struct mtd_info *mtd)
+static int nuc900_nand_devready(struct nand_chip *chip)
 {
-	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(nand_to_mtd(chip));
 	int ready;
 
 	ready = (nuc900_check_rb(nand)) ? 1 : 0;
@@ -205,7 +205,7 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 	 * any case on any machine. */
 	ndelay(100);
 
-	while (!chip->dev_ready(mtd))
+	while (!chip->dev_ready(chip))
 		;
 }
 
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 4bae782cd877..eef9cbadd3c4 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1021,9 +1021,9 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
  *
  * Returns true if ready and false if busy.
  */
-static int omap_dev_ready(struct mtd_info *mtd)
+static int omap_dev_ready(struct nand_chip *chip)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 
 	return gpiod_get_value(info->ready_gpiod);
 }
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index 661ba57f2934..a1e3bf7a276b 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -80,7 +80,7 @@ static void pasemi_hwcontrol(struct nand_chip *chip, int cmd,
 	inl(lpcctl);
 }
 
-int pasemi_device_ready(struct mtd_info *mtd)
+int pasemi_device_ready(struct nand_chip *chip)
 {
 	return !!(inl(lpcctl) & LBICTRL_LPCCTL_NR);
 }
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index bfb5d8e7b00b..d65e4084dea4 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -23,13 +23,6 @@ struct plat_nand_data {
 	void __iomem		*io_base;
 };
 
-static int plat_nand_dev_ready(struct mtd_info *mtd)
-{
-	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
-
-	return pdata->ctrl.dev_ready(mtd_to_nand(mtd));
-}
-
 /*
  * Probe for the NAND device.
  */
@@ -70,10 +63,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.IO_ADDR_R = data->io_base;
 	data->chip.IO_ADDR_W = data->io_base;
 	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
-
-	if (pdata->ctrl.dev_ready)
-		data->chip.dev_ready = plat_nand_dev_ready;
-
+	data->chip.dev_ready = pdata->ctrl.dev_ready;
 	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.write_buf = pdata->ctrl.write_buf;
 	data->chip.read_buf = pdata->ctrl.read_buf;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index e90549e031a7..4331ff856fa5 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -373,7 +373,7 @@ static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		msecs_to_jiffies(400) : msecs_to_jiffies(20));
 
 	while (time_before(jiffies, timeout))
-		if (chip->dev_ready(mtd))
+		if (chip->dev_ready(chip))
 			break;
 
 	nand_status_op(chip, &status);
@@ -390,9 +390,9 @@ static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
  * Check if card is ready
  */
 
-static int r852_ready(struct mtd_info *mtd)
+static int r852_ready(struct nand_chip *chip)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 	return !(r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_BUSY);
 }
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 98ba94936631..1d549f5e53f5 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -493,20 +493,23 @@ static void s3c2440_nand_hwcontrol(struct nand_chip *chip, int cmd,
  * returns 0 if the nand is busy, 1 if it is ready
 */
 
-static int s3c2410_nand_devready(struct mtd_info *mtd)
+static int s3c2410_nand_devready(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	return readb(info->regs + S3C2410_NFSTAT) & S3C2410_NFSTAT_BUSY;
 }
 
-static int s3c2440_nand_devready(struct mtd_info *mtd)
+static int s3c2440_nand_devready(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	return readb(info->regs + S3C2440_NFSTAT) & S3C2440_NFSTAT_READY;
 }
 
-static int s3c2412_nand_devready(struct mtd_info *mtd)
+static int s3c2412_nand_devready(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	return readb(info->regs + S3C2412_NFSTAT) & S3C2412_NFSTAT_READY;
 }
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 7486a00b1ae5..31abbe33798e 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -78,9 +78,9 @@ static void sharpsl_nand_hwcontrol(struct nand_chip *chip, int cmd,
 		writeb(cmd, chip->IO_ADDR_W);
 }
 
-static int sharpsl_nand_dev_ready(struct mtd_info *mtd)
+static int sharpsl_nand_dev_ready(struct nand_chip *chip)
 {
-	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(mtd);
+	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(nand_to_mtd(chip));
 	return !((readb(sharpsl->io + FLASHCTL) & FLRYBY) == 0);
 }
 
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index c44b19fc1350..64ea9a014054 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -112,9 +112,8 @@ static void socrates_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
 /*
  * Read the Device Ready pin.
  */
-static int socrates_nand_device_ready(struct mtd_info *mtd)
+static int socrates_nand_device_ready(struct nand_chip *nand_chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct socrates_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (in_be32(host->io_base) & FPGA_NAND_BUSY)
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1d85ff02afdb..fe30fb589ffb 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -400,9 +400,8 @@ static void sunxi_nfc_dma_op_cleanup(struct mtd_info *mtd,
 	       nfc->regs + NFC_REG_CTL);
 }
 
-static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
+static int sunxi_nfc_dev_ready(struct nand_chip *nand)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	u32 mask;
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index c8fb03f71a3b..cc719bc49b68 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -127,9 +127,8 @@ static void tango_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 		writeb_relaxed(dat, tchip->base + PBUS_ADDR);
 }
 
-static int tango_dev_ready(struct mtd_info *mtd)
+static int tango_dev_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct tango_nfc *nfc = to_tango_nfc(chip->controller);
 
 	return readl_relaxed(nfc->pbus_base + PBUS_CS_CTRL) & PBUS_IORDY;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 1221353b11a7..7096fa3d50ab 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -158,9 +158,9 @@ static void tmio_nand_hwcontrol(struct nand_chip *chip, int cmd,
 		tmio_iowrite8(cmd, chip->IO_ADDR_W);
 }
 
-static int tmio_nand_dev_ready(struct mtd_info *mtd)
+static int tmio_nand_dev_ready(struct nand_chip *chip)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 
 	return !(tmio_ioread8(tmio->fcr + FCR_STATUS) & FCR_STATUS_BUSY);
 }
@@ -198,10 +198,10 @@ tmio_nand_wait(struct mtd_info *mtd, struct nand_chip *nand_chip)
 	tmio_iowrite8(0x81, tmio->fcr + FCR_IMR);
 
 	timeout = wait_event_timeout(nand_chip->controller->wq,
-		tmio_nand_dev_ready(mtd),
+		tmio_nand_dev_ready(nand_chip),
 		msecs_to_jiffies(nand_chip->state == FL_ERASING ? 400 : 20));
 
-	if (unlikely(!tmio_nand_dev_ready(mtd))) {
+	if (unlikely(!tmio_nand_dev_ready(nand_chip))) {
 		tmio_iowrite8(0x00, tmio->fcr + FCR_IMR);
 		dev_warn(&tmio->dev->dev, "still busy with %s after %d ms\n",
 			nand_chip->state == FL_ERASING ? "erase" : "program",
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index f3bce6fb1fac..c84b2ad84cf7 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -162,9 +162,9 @@ static void txx9ndfmc_cmd_ctrl(struct nand_chip *chip, int cmd,
 	mmiowb();
 }
 
-static int txx9ndfmc_dev_ready(struct mtd_info *mtd)
+static int txx9ndfmc_dev_ready(struct nand_chip *chip)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 
 	return !(txx9ndfmc_read(dev, TXX9_NDFSR) & TXX9_NDFSR_BUSY);
 }
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 3b38d31c59c6..3d91e98df5a8 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -121,7 +121,7 @@ static void xway_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
 		;
 }
 
-static int xway_dev_ready(struct mtd_info *mtd)
+static int xway_dev_ready(struct nand_chip *chip)
 {
 	return ltq_ebu_r32(EBU_NAND_WAIT) & NAND_WAIT_RD;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b53ccc7139c2..404ac7d4b279 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1291,7 +1291,7 @@ struct nand_chip {
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
-	int (*dev_ready)(struct mtd_info *mtd);
+	int (*dev_ready)(struct nand_chip *chip);
 	void (*cmdfunc)(struct mtd_info *mtd, unsigned command, int column,
 			int page_addr);
 	int(*waitfunc)(struct mtd_info *mtd, struct nand_chip *this);
-- 
2.14.1
