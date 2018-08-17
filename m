From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 14/23] mtd: rawnand: Pass a nand_chip object to
 chip->cmd_ctrl()
Date: Fri, 17 Aug 2018 18:09:13 +0200
Message-ID: <20180817160922.6224-15-boris.brezillon@bootlin.com>
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

Let's tackle the chip->cmd_ctrl() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |  4 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  6 +--
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  7 ++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  4 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |  3 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  3 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  5 +--
 drivers/mtd/nand/raw/denali.c                    |  4 +-
 drivers/mtd/nand/raw/diskonchip.c                | 22 +++++------
 drivers/mtd/nand/raw/fsl_upm.c                   | 10 ++---
 drivers/mtd/nand/raw/gpio.c                      |  5 ++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  3 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  6 +--
 drivers/mtd/nand/raw/jz4780_nand.c               |  4 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  3 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  5 +--
 drivers/mtd/nand/raw/mtk_nand.c                  |  5 ++-
 drivers/mtd/nand/raw/nand_base.c                 | 47 ++++++++++++------------
 drivers/mtd/nand/raw/nandsim.c                   |  3 +-
 drivers/mtd/nand/raw/ndfc.c                      |  3 +-
 drivers/mtd/nand/raw/omap2.c                     |  6 +--
 drivers/mtd/nand/raw/orion_nand.c                |  4 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  3 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |  4 +-
 drivers/mtd/nand/raw/plat_nand.c                 | 11 +-----
 drivers/mtd/nand/raw/r852.c                      |  4 +-
 drivers/mtd/nand/raw/s3c2410.c                   |  6 ++-
 drivers/mtd/nand/raw/sharpsl.c                   |  5 +--
 drivers/mtd/nand/raw/socrates_nand.c             |  5 +--
 drivers/mtd/nand/raw/sunxi_nand.c                |  3 +-
 drivers/mtd/nand/raw/tango_nand.c                |  4 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |  7 ++--
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  3 +-
 drivers/mtd/nand/raw/xway_nand.c                 |  4 +-
 include/linux/mtd/rawnand.h                      |  2 +-
 35 files changed, 98 insertions(+), 125 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index d742b9444429..8121d26194cf 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -113,7 +113,7 @@ static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
  * NAND_CLE: bit 1 -> bit 7
  * NAND_ALE: bit 2 -> bit 6
  */
-static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
+static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 				unsigned int ctrl)
 {
 
@@ -127,7 +127,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd_to_nand(mtd), cmd);
+		ams_delta_write_byte(this, cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index debc73bfe79a..df20c46f0128 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -594,10 +594,9 @@ static int atmel_nfc_exec_op(struct atmel_hsmc_nand_controller *nc, bool poll)
 	return ret;
 }
 
-static void atmel_hsmc_nand_cmd_ctrl(struct mtd_info *mtd, int dat,
+static void atmel_hsmc_nand_cmd_ctrl(struct nand_chip *chip, int dat,
 				     unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_hsmc_nand_controller *nc;
 
@@ -621,10 +620,9 @@ static void atmel_hsmc_nand_cmd_ctrl(struct mtd_info *mtd, int dat,
 	}
 }
 
-static void atmel_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+static void atmel_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 				unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_nand_controller *nc;
 
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index c8e30b0308bc..d326f9d3648b 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -170,10 +170,9 @@ static void bcm47xxnflash_ops_bcm4706_write(struct mtd_info *mtd,
  * NAND chip ops
  **************************************************/
 
-static void bcm47xxnflash_ops_bcm4706_cmd_ctrl(struct mtd_info *mtd, int cmd,
-					       unsigned int ctrl)
+static void bcm47xxnflash_ops_bcm4706_cmd_ctrl(struct nand_chip *nand_chip,
+					       int cmd, unsigned int ctrl)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 	u32 code = 0;
 
@@ -229,7 +228,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 
 	switch (command) {
 	case NAND_CMD_RESET:
-		nand_chip->cmd_ctrl(mtd, command, NAND_CTRL_CLE);
+		nand_chip->cmd_ctrl(nand_chip, command, NAND_CTRL_CLE);
 
 		ndelay(100);
 		nand_wait_ready(nand_chip);
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e24e77b27618..80f5b4b9ee75 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1231,8 +1231,8 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
  * NAND MTD API: read/program/erase
  ***********************************************************************/
 
-static void brcmnand_cmd_ctrl(struct mtd_info *mtd, int dat,
-	unsigned int ctrl)
+static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
+			      unsigned int ctrl)
 {
 	/* intentionally left blank */
 }
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 4e5c8b7721ab..a0f0ad2da6f1 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -86,10 +86,9 @@ static void nand_cs_off(void)
 /*
  *	hardware specific access to control-lines
  */
-static void cmx270_hwcontrol(struct mtd_info *mtd, int dat,
+static void cmx270_hwcontrol(struct nand_chip *this, int dat,
 			     unsigned int ctrl)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned int nandaddr = (unsigned int)this->IO_ADDR_W;
 
 	dsb();
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 442fa583db44..b7432f086f9b 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -129,10 +129,9 @@ static void cs553x_write_byte(struct nand_chip *this, u_char byte)
 	writeb(byte, this->IO_ADDR_W + 0x801);
 }
 
-static void cs553x_hwcontrol(struct mtd_info *mtd, int cmd,
+static void cs553x_hwcontrol(struct nand_chip *this, int cmd,
 			     unsigned int ctrl)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *mmio_base = this->IO_ADDR_R;
 	if (ctrl & NAND_CTRL_CHANGE) {
 		unsigned char ctl = (ctrl & ~NAND_CTRL_CHANGE ) ^ 0x01;
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 85bc801424b0..c2a3ad10610c 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -97,12 +97,11 @@ static inline void davinci_nand_writel(struct davinci_nand_info *info,
  * Access to hardware control lines:  ALE, CLE, secondary chipselect.
  */
 
-static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
+static void nand_davinci_hwcontrol(struct nand_chip *nand, int cmd,
 				   unsigned int ctrl)
 {
-	struct davinci_nand_info	*info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(nand));
 	void __iomem			*addr = info->current_cs;
-	struct nand_chip		*nand = mtd_to_nand(mtd);
 
 	/* Did the control lines change? */
 	if (ctrl & NAND_CTRL_CHANGE) {
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 8261f070113e..af6b600bb009 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -281,9 +281,9 @@ static void denali_write_byte(struct nand_chip *chip, uint8_t byte)
 	denali_write_buf(chip, &byte, 1);
 }
 
-static void denali_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
+static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	uint32_t type;
 
 	if (ctrl & NAND_CLE)
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 9cbcf020cabe..16498b277764 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -83,7 +83,7 @@ static u_char empty_write_ecc[6] = { 0x4b, 0x00, 0xe2, 0x0e, 0x93, 0xf7 };
 #define DoC_is_Millennium(doc) ((doc)->ChipID == DOC_ChipID_DocMil)
 #define DoC_is_2000(doc) ((doc)->ChipID == DOC_ChipID_Doc2k)
 
-static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
+static void doc200x_hwcontrol(struct nand_chip *this, int cmd,
 			      unsigned int bitmask);
 static void doc200x_select_chip(struct nand_chip *this, int chip);
 
@@ -372,10 +372,10 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 	uint16_t ret;
 
 	doc200x_select_chip(this, nr);
-	doc200x_hwcontrol(mtd, NAND_CMD_READID,
+	doc200x_hwcontrol(this, NAND_CMD_READID,
 			  NAND_CTRL_CLE | NAND_CTRL_CHANGE);
-	doc200x_hwcontrol(mtd, 0, NAND_CTRL_ALE | NAND_CTRL_CHANGE);
-	doc200x_hwcontrol(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	doc200x_hwcontrol(this, 0, NAND_CTRL_ALE | NAND_CTRL_CHANGE);
+	doc200x_hwcontrol(this, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 
 	/* We can't use dev_ready here, but at least we wait for the
 	 * command to complete
@@ -393,10 +393,10 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 		} ident;
 		void __iomem *docptr = doc->virtadr;
 
-		doc200x_hwcontrol(mtd, NAND_CMD_READID,
+		doc200x_hwcontrol(this, NAND_CMD_READID,
 				  NAND_CTRL_CLE | NAND_CTRL_CHANGE);
-		doc200x_hwcontrol(mtd, 0, NAND_CTRL_ALE | NAND_CTRL_CHANGE);
-		doc200x_hwcontrol(mtd, NAND_CMD_NONE,
+		doc200x_hwcontrol(this, 0, NAND_CTRL_ALE | NAND_CTRL_CHANGE);
+		doc200x_hwcontrol(this, NAND_CMD_NONE,
 				  NAND_NCE | NAND_CTRL_CHANGE);
 
 		udelay(50);
@@ -587,7 +587,6 @@ static void doc2001plus_select_chip(struct nand_chip *this, int chip)
 
 static void doc200x_select_chip(struct nand_chip *this, int chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(this);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int floor = 0;
@@ -602,12 +601,12 @@ static void doc200x_select_chip(struct nand_chip *this, int chip)
 	chip -= (floor * doc->chips_per_floor);
 
 	/* 11.4.4 -- deassert CE before changing chip */
-	doc200x_hwcontrol(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+	doc200x_hwcontrol(this, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
 
 	WriteDOC(floor, docptr, FloorSelect);
 	WriteDOC(chip, docptr, CDSNDeviceSelect);
 
-	doc200x_hwcontrol(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	doc200x_hwcontrol(this, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 
 	doc->curchip = chip;
 	doc->curfloor = floor;
@@ -615,10 +614,9 @@ static void doc200x_select_chip(struct nand_chip *this, int chip)
 
 #define CDSN_CTRL_MSK (CDSN_CTRL_CE | CDSN_CTRL_CLE | CDSN_CTRL_ALE)
 
-static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
+static void doc200x_hwcontrol(struct nand_chip *this, int cmd,
 			      unsigned int ctrl)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index fbdd439fcda7..387e7c3eff0e 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -78,10 +78,9 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 	}
 }
 
-static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void fun_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 	u32 mar;
 
 	if (!(ctrl & fun->last_ctrl)) {
@@ -110,11 +109,10 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static void fun_select_chip(struct nand_chip *chip, int mchip_nr)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 
 	if (mchip_nr == -1) {
-		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+		chip->cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
 	} else if (mchip_nr >= 0 && mchip_nr < NAND_MAX_CHIPS) {
 		fun->mchip_number = mchip_nr;
 		chip->IO_ADDR_R = fun->io_base + fun->mchip_offsets[mchip_nr];
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 0e7d00faf33c..722a930ac836 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -73,9 +73,10 @@ static void gpio_nand_dosync(struct gpiomtd *gpiomtd)
 static inline void gpio_nand_dosync(struct gpiomtd *gpiomtd) {}
 #endif
 
-static void gpio_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void gpio_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
+			       unsigned int ctrl)
 {
-	struct gpiomtd *gpiomtd = gpio_nand_getpriv(mtd);
+	struct gpiomtd *gpiomtd = gpio_nand_getpriv(nand_to_mtd(chip));
 
 	gpio_nand_dosync(gpiomtd);
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 2dce9b62ebe7..460f2f77a424 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -783,9 +783,8 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 	return -ENOMEM;
 }
 
-static void gpmi_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
+static void gpmi_cmd_ctrl(struct nand_chip *chip, int data, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret;
 
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index b6e68048b83d..7999e691e636 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -99,10 +99,10 @@ static void jz_nand_select_chip(struct nand_chip *chip, int chipnr)
 	nand->selected_bank = banknr;
 }
 
-static void jz_nand_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
+static void jz_nand_cmd_ctrl(struct nand_chip *chip, int dat,
+			     unsigned int ctrl)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	uint32_t reg;
 	void __iomem *bank_base = nand->bank_base[nand->selected_bank];
 
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 3afa3094623d..cf0c20c492ab 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -86,10 +86,10 @@ static void jz4780_nand_select_chip(struct nand_chip *chip, int chipnr)
 	nfc->selected = chipnr;
 }
 
-static void jz4780_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+static void jz4780_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 				 unsigned int ctrl)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
 	struct jz4780_nand_cs *cs;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 79a02acb0517..0e989d944ddb 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -286,10 +286,9 @@ static void lpc32xx_nand_setup(struct lpc32xx_nand_host *host)
 /*
  * Hardware specific access to control lines
  */
-static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+static void lpc32xx_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
 				  unsigned int ctrl)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (cmd != NAND_CMD_NONE) {
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index d04b30989041..e42584de875c 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -278,11 +278,10 @@ static void lpc32xx_nand_setup(struct lpc32xx_nand_host *host)
 /*
  * Hardware specific access to control lines
  */
-static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
-	unsigned int ctrl)
+static void lpc32xx_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
+				  unsigned int ctrl)
 {
 	uint32_t tmp;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Does CE state need to be changed? */
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 6e5d4afd6b1a..6baa41483931 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -412,9 +412,10 @@ static int mtk_nfc_dev_ready(struct mtd_info *mtd)
 	return 1;
 }
 
-static void mtk_nfc_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
+static void mtk_nfc_cmd_ctrl(struct nand_chip *chip, int dat,
+			     unsigned int ctrl)
 {
-	struct mtk_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
+	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 
 	if (ctrl & NAND_ALE) {
 		mtk_nfc_send_address(nfc, dat);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index add85235497e..f0d70164a2f1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -286,8 +286,7 @@ static void nand_select_chip(struct nand_chip *chip, int chipnr)
 {
 	switch (chipnr) {
 	case -1:
-		chip->cmd_ctrl(nand_to_mtd(chip), NAND_CMD_NONE,
-			       0 | NAND_CTRL_CHANGE);
+		chip->cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
 		break;
 	case 0:
 		break;
@@ -760,11 +759,11 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 			column -= 256;
 			readcmd = NAND_CMD_READ1;
 		}
-		chip->cmd_ctrl(mtd, readcmd, ctrl);
+		chip->cmd_ctrl(chip, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
 	if (command != NAND_CMD_NONE)
-		chip->cmd_ctrl(mtd, command, ctrl);
+		chip->cmd_ctrl(chip, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -774,17 +773,17 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 		if (chip->options & NAND_BUSWIDTH_16 &&
 				!nand_opcode_8bits(command))
 			column >>= 1;
-		chip->cmd_ctrl(mtd, column, ctrl);
+		chip->cmd_ctrl(chip, column, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
 	if (page_addr != -1) {
-		chip->cmd_ctrl(mtd, page_addr, ctrl);
+		chip->cmd_ctrl(chip, page_addr, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
-		chip->cmd_ctrl(mtd, page_addr >> 8, ctrl);
+		chip->cmd_ctrl(chip, page_addr >> 8, ctrl);
 		if (chip->options & NAND_ROW_ADDR_3)
-			chip->cmd_ctrl(mtd, page_addr >> 16, ctrl);
+			chip->cmd_ctrl(chip, page_addr >> 16, ctrl);
 	}
-	chip->cmd_ctrl(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	chip->cmd_ctrl(chip, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 
 	/*
 	 * Program and erase have their own busy handlers status and sequential
@@ -806,9 +805,9 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 		if (chip->dev_ready)
 			break;
 		udelay(chip->chip_delay);
-		chip->cmd_ctrl(mtd, NAND_CMD_STATUS,
+		chip->cmd_ctrl(chip, NAND_CMD_STATUS,
 			       NAND_CTRL_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(mtd,
+		chip->cmd_ctrl(chip,
 			       NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 		/* EZ-NAND can take upto 250ms as per ONFi v4.0 */
 		nand_wait_status_ready(mtd, 250);
@@ -887,7 +886,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 
 	/* Command latch cycle */
 	if (command != NAND_CMD_NONE)
-		chip->cmd_ctrl(mtd, command,
+		chip->cmd_ctrl(chip, command,
 			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
@@ -899,23 +898,23 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 			if (chip->options & NAND_BUSWIDTH_16 &&
 					!nand_opcode_8bits(command))
 				column >>= 1;
-			chip->cmd_ctrl(mtd, column, ctrl);
+			chip->cmd_ctrl(chip, column, ctrl);
 			ctrl &= ~NAND_CTRL_CHANGE;
 
 			/* Only output a single addr cycle for 8bits opcodes. */
 			if (!nand_opcode_8bits(command))
-				chip->cmd_ctrl(mtd, column >> 8, ctrl);
+				chip->cmd_ctrl(chip, column >> 8, ctrl);
 		}
 		if (page_addr != -1) {
-			chip->cmd_ctrl(mtd, page_addr, ctrl);
-			chip->cmd_ctrl(mtd, page_addr >> 8,
+			chip->cmd_ctrl(chip, page_addr, ctrl);
+			chip->cmd_ctrl(chip, page_addr >> 8,
 				       NAND_NCE | NAND_ALE);
 			if (chip->options & NAND_ROW_ADDR_3)
-				chip->cmd_ctrl(mtd, page_addr >> 16,
+				chip->cmd_ctrl(chip, page_addr >> 16,
 					       NAND_NCE | NAND_ALE);
 		}
 	}
-	chip->cmd_ctrl(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	chip->cmd_ctrl(chip, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 
 	/*
 	 * Program and erase have their own busy handlers status, sequential
@@ -942,9 +941,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 		if (chip->dev_ready)
 			break;
 		udelay(chip->chip_delay);
-		chip->cmd_ctrl(mtd, NAND_CMD_STATUS,
+		chip->cmd_ctrl(chip, NAND_CMD_STATUS,
 			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(mtd, NAND_CMD_NONE,
+		chip->cmd_ctrl(chip, NAND_CMD_NONE,
 			       NAND_NCE | NAND_CTRL_CHANGE);
 		/* EZ-NAND can take upto 250ms as per ONFi v4.0 */
 		nand_wait_status_ready(mtd, 250);
@@ -952,9 +951,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 
 	case NAND_CMD_RNDOUT:
 		/* No ready / busy check necessary */
-		chip->cmd_ctrl(mtd, NAND_CMD_RNDOUTSTART,
+		chip->cmd_ctrl(chip, NAND_CMD_RNDOUTSTART,
 			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(mtd, NAND_CMD_NONE,
+		chip->cmd_ctrl(chip, NAND_CMD_NONE,
 			       NAND_NCE | NAND_CTRL_CHANGE);
 
 		nand_ccs_delay(chip);
@@ -970,9 +969,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 		if (column == -1 && page_addr == -1)
 			return;
 
-		chip->cmd_ctrl(mtd, NAND_CMD_READSTART,
+		chip->cmd_ctrl(chip, NAND_CMD_READSTART,
 			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(mtd, NAND_CMD_NONE,
+		chip->cmd_ctrl(chip, NAND_CMD_NONE,
 			       NAND_NCE | NAND_CTRL_CHANGE);
 
 		/* This applies to read commands */
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 880ba12e07ba..a6b626c935a8 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2087,9 +2087,8 @@ static void ns_nand_write_byte(struct nand_chip *chip, u_char byte)
 	return;
 }
 
-static void ns_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int bitmask)
+static void ns_hwcontrol(struct nand_chip *chip, int cmd, unsigned int bitmask)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nandsim *ns = nand_get_controller_data(chip);
 
 	ns->lines.cle = bitmask & NAND_CLE ? 1 : 0;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 5f8870e6054e..4187f65bb294 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -58,9 +58,8 @@ static void ndfc_select_chip(struct nand_chip *nchip, int chip)
 	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 }
 
-static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void ndfc_hwcontrol(struct nand_chip *chip, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	if (cmd == NAND_CMD_NONE)
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 5a2bf1ed9c86..4bae782cd877 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -240,7 +240,7 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
 
 /**
  * omap_hwcontrol - hardware specific access to control-lines
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @cmd: command to device
  * @ctrl:
  * NAND_NCE: bit 0 -> don't care
@@ -249,9 +249,9 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
  *
  * NOTE: boards may use different bits for these!!
  */
-static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void omap_hwcontrol(struct nand_chip *chip, int cmd, unsigned int ctrl)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 870eabe6fff8..92d8f249ee97 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -26,9 +26,9 @@ struct orion_nand_info {
 	struct clk *clk;
 };
 
-static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void orion_nand_cmd_ctrl(struct nand_chip *nc, int cmd,
+				unsigned int ctrl)
 {
-	struct nand_chip *nc = mtd_to_nand(mtd);
 	struct orion_nand_data *board = nand_get_controller_data(nc);
 	u32 offs;
 
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 93c04bec471d..ab32df146505 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -61,10 +61,9 @@ static void oxnas_nand_write_buf(struct nand_chip *chip, const u8 *buf,
 }
 
 /* Single CS command control */
-static void oxnas_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+static void oxnas_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 				unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct oxnas_nand_ctrl *oxnas = nand_get_controller_data(chip);
 
 	if (ctrl & NAND_CLE)
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index 70aff4180ab7..661ba57f2934 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -64,11 +64,9 @@ static void pasemi_write_buf(struct nand_chip *chip, const u_char *buf,
 	memcpy_toio(chip->IO_ADDR_R, buf, len);
 }
 
-static void pasemi_hwcontrol(struct mtd_info *mtd, int cmd,
+static void pasemi_hwcontrol(struct nand_chip *chip, int cmd,
 			     unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	if (cmd == NAND_CMD_NONE)
 		return;
 
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index dd9e241b7584..bfb5d8e7b00b 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -23,13 +23,6 @@ struct plat_nand_data {
 	void __iomem		*io_base;
 };
 
-static void plat_nand_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
-{
-	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
-
-	pdata->ctrl.cmd_ctrl(mtd_to_nand(mtd), dat, ctrl);
-}
-
 static int plat_nand_dev_ready(struct mtd_info *mtd)
 {
 	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
@@ -76,9 +69,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 
 	data->chip.IO_ADDR_R = data->io_base;
 	data->chip.IO_ADDR_W = data->io_base;
-
-	if (pdata->ctrl.cmd_ctrl)
-		data->chip.cmd_ctrl = plat_nand_cmd_ctrl;
+	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 
 	if (pdata->ctrl.dev_ready)
 		data->chip.dev_ready = plat_nand_dev_ready;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 312a971aa456..e90549e031a7 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -317,9 +317,9 @@ static uint8_t r852_read_byte(struct nand_chip *chip)
 /*
  * Control several chip lines & send commands
  */
-static void r852_cmdctl(struct mtd_info *mtd, int dat, unsigned int ctrl)
+static void r852_cmdctl(struct nand_chip *chip, int dat, unsigned int ctrl)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 
 	if (dev->card_unstable)
 		return;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 353011e7fb79..98ba94936631 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -456,9 +456,10 @@ static void s3c2410_nand_select_chip(struct nand_chip *this, int chip)
  * Issue command and address cycles to the chip
 */
 
-static void s3c2410_nand_hwcontrol(struct mtd_info *mtd, int cmd,
+static void s3c2410_nand_hwcontrol(struct nand_chip *chip, int cmd,
 				   unsigned int ctrl)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	if (cmd == NAND_CMD_NONE)
@@ -472,9 +473,10 @@ static void s3c2410_nand_hwcontrol(struct mtd_info *mtd, int cmd,
 
 /* command and control functions */
 
-static void s3c2440_nand_hwcontrol(struct mtd_info *mtd, int cmd,
+static void s3c2440_nand_hwcontrol(struct nand_chip *chip, int cmd,
 				   unsigned int ctrl)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	if (cmd == NAND_CMD_NONE)
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 4d931ce71af5..7486a00b1ae5 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -59,11 +59,10 @@ static inline struct sharpsl_nand *mtd_to_sharpsl(struct mtd_info *mtd)
  *	NAND_ALE: bit 2 -> bit 2
  *
  */
-static void sharpsl_nand_hwcontrol(struct mtd_info *mtd, int cmd,
+static void sharpsl_nand_hwcontrol(struct nand_chip *chip, int cmd,
 				   unsigned int ctrl)
 {
-	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(nand_to_mtd(chip));
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		unsigned char bits = ctrl & 0x07;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index deedc1cd4dee..c44b19fc1350 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -87,10 +87,9 @@ static uint8_t socrates_nand_read_byte(struct nand_chip *this)
 /*
  * Hardware specific access to control-lines
  */
-static void socrates_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
-		unsigned int ctrl)
+static void socrates_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
+				   unsigned int ctrl)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct socrates_nand_host *host = nand_get_controller_data(nand_chip);
 	uint32_t val;
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 97a0666df615..1d85ff02afdb 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -547,10 +547,9 @@ static uint8_t sunxi_nfc_read_byte(struct nand_chip *nand)
 	return ret;
 }
 
-static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
+static void sunxi_nfc_cmd_ctrl(struct nand_chip *nand, int dat,
 			       unsigned int ctrl)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 5e0bc2993e5d..c8fb03f71a3b 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -116,9 +116,9 @@ struct tango_chip {
 
 #define TIMING(t0, t1, t2, t3) ((t0) << 24 | (t1) << 16 | (t2) << 8 | (t3))
 
-static void tango_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
+static void tango_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 {
-	struct tango_chip *tchip = to_tango_chip(mtd_to_nand(mtd));
+	struct tango_chip *tchip = to_tango_chip(chip);
 
 	if (ctrl & NAND_CLE)
 		writeb_relaxed(dat, tchip->base + PBUS_CMD);
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index d627d855b254..1221353b11a7 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -126,11 +126,10 @@ static inline struct tmio_nand *mtd_to_tmio(struct mtd_info *mtd)
 
 /*--------------------------------------------------------------------------*/
 
-static void tmio_nand_hwcontrol(struct mtd_info *mtd, int cmd,
-				   unsigned int ctrl)
+static void tmio_nand_hwcontrol(struct nand_chip *chip, int cmd,
+				unsigned int ctrl)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		u8 mode;
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index b7ff8eca441b..f3bce6fb1fac 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -131,10 +131,9 @@ static void txx9ndfmc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 		*buf++ = __raw_readl(ndfdtr);
 }
 
-static void txx9ndfmc_cmd_ctrl(struct mtd_info *mtd, int cmd,
+static void txx9ndfmc_cmd_ctrl(struct nand_chip *chip, int cmd,
 			       unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct txx9ndfmc_priv *txx9_priv = nand_get_controller_data(chip);
 	struct platform_device *dev = txx9_priv->dev;
 	struct txx9ndfmc_platform_data *plat = dev_get_platdata(&dev->dev);
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index a6388fa1dce7..3b38d31c59c6 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -105,8 +105,10 @@ static void xway_select_chip(struct nand_chip *chip, int select)
 	}
 }
 
-static void xway_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+static void xway_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	if (cmd == NAND_CMD_NONE)
 		return;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 0d8e2708e125..b53ccc7139c2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1290,7 +1290,7 @@ struct nand_chip {
 	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
-	void (*cmd_ctrl)(struct mtd_info *mtd, int dat, unsigned int ctrl);
+	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
 	int (*dev_ready)(struct mtd_info *mtd);
 	void (*cmdfunc)(struct mtd_info *mtd, unsigned command, int column,
 			int page_addr);
-- 
2.14.1
