From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 16/23] mtd: rawnand: Pass a nand_chip object to chip->cmdfunc()
Date: Fri, 17 Aug 2018 18:09:15 +0200
Message-ID: <20180817160922.6224-17-boris.brezillon@bootlin.com>
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

Let's tackle the chip->cmdfunc() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/au1550nd.c                  |  7 ++--
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  4 +--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  4 +--
 drivers/mtd/nand/raw/cafe_nand.c                 |  4 +--
 drivers/mtd/nand/raw/diskonchip.c                |  5 +--
 drivers/mtd/nand/raw/docg4.c                     |  4 +--
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  4 +--
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  6 ++--
 drivers/mtd/nand/raw/hisi504_nand.c              |  6 ++--
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  8 ++---
 drivers/mtd/nand/raw/mxc_nand.c                  |  6 ++--
 drivers/mtd/nand/raw/nand_base.c                 | 46 ++++++++++++------------
 drivers/mtd/nand/raw/nand_hynix.c                |  7 ++--
 drivers/mtd/nand/raw/nuc900_nand.c               |  5 +--
 drivers/mtd/nand/raw/qcom_nandc.c                |  3 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |  3 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  4 +--
 include/linux/mtd/rawnand.h                      |  2 +-
 18 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 1f0fba8d87c6..d0ec8606e769 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -236,14 +236,15 @@ static void au1550_select_chip(struct nand_chip *this, int chip)
 
 /**
  * au1550_command - Send command to NAND device
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @command:	the command to be sent
  * @column:	the column address for this command, -1 if none
  * @page_addr:	the page address for this command, -1 if none
  */
-static void au1550_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
+static void au1550_command(struct nand_chip *this, unsigned command,
+			   int column, int page_addr)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(this);
 	struct au1550nd_ctx *ctx = container_of(this, struct au1550nd_ctx,
 						chip);
 	int ce_override = 0, i;
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index f6f694b3cd8e..59e1b88aae38 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -210,11 +210,11 @@ static int bcm47xxnflash_ops_bcm4706_dev_ready(struct nand_chip *nand_chip)
  * registers of ChipCommon core. Hacking cmd_ctrl to understand and convert
  * standard commands would be much more complicated.
  */
-static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
+static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct nand_chip *nand_chip,
 					      unsigned command, int column,
 					      int page_addr)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
 	struct bcm47xxnflash *b47n = nand_get_controller_data(nand_chip);
 	struct bcma_drv_cc *cc = b47n->cc;
 	u32 ctlcode;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 80f5b4b9ee75..4b814a39b24f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1310,10 +1310,10 @@ static int brcmnand_low_level_op(struct brcmnand_host *host,
 	return brcmnand_waitfunc(mtd, chip);
 }
 
-static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
+static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
 			     int column, int page_addr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u64 addr = (u64)page_addr << chip->page_shift;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 60a2eecc2b2a..801045d77872 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -156,10 +156,10 @@ static uint8_t cafe_read_byte(struct nand_chip *chip)
 	return d;
 }
 
-static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
+static void cafe_nand_cmdfunc(struct nand_chip *chip, unsigned command,
 			      int column, int page_addr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	int adrbytes = 0;
 	uint32_t ctl1;
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index e40a4e120c7b..64bf0624343d 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -637,9 +637,10 @@ static void doc200x_hwcontrol(struct nand_chip *this, int cmd,
 	}
 }
 
-static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
+static void doc2001plus_command(struct nand_chip *this, unsigned command,
+				int column, int page_addr)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(this);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 762ed5599d47..c76d765bb1aa 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -705,12 +705,12 @@ static uint32_t mtd_to_docg4_address(int page, int column)
 	return (g4_page << 16) | g4_index;	      /* pack */
 }
 
-static void docg4_command(struct mtd_info *mtd, unsigned command, int column,
+static void docg4_command(struct nand_chip *nand, unsigned command, int column,
 			  int page_addr)
 {
 	/* handle standard nand commands */
 
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	uint32_t g4_addr = mtd_to_docg4_address(page_addr, column);
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 74b804a61f2d..93b82af3e518 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -317,10 +317,10 @@ static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
 }
 
 /* cmdfunc send commands to the FCM */
-static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
+static void fsl_elbc_cmdfunc(struct nand_chip *chip, unsigned int command,
                              int column, int page_addr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 5b98c9e1adf8..26f06d0594e6 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -300,9 +300,9 @@ static void fsl_ifc_do_read(struct nand_chip *chip,
 }
 
 /* cmdfunc send commands to the IFC NAND Machine */
-static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
-			     int column, int page_addr) {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+static void fsl_ifc_cmdfunc(struct nand_chip *chip, unsigned int command,
+			    int column, int page_addr) {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 86dd7b54159d..928a320c8517 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -429,10 +429,10 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr)
 	}
 }
 
-static void hisi_nfc_cmdfunc(struct mtd_info *mtd, unsigned command, int column,
-		int page_addr)
+static void hisi_nfc_cmdfunc(struct nand_chip *chip, unsigned command,
+			     int column, int page_addr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 	int is_cache_invalid = 1;
 	unsigned int flag = 0;
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index ba7af061c0eb..bd027674898d 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -330,10 +330,10 @@ static int mpc5121_nfc_dev_ready(struct nand_chip *nand)
 }
 
 /* Write command to NAND flash */
-static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,
-							int column, int page)
+static void mpc5121_nfc_command(struct nand_chip *chip, unsigned command,
+				int column, int page)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	prv->column = (column >= 0) ? column : 0;
@@ -364,7 +364,7 @@ static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,
 		break;
 
 	case NAND_CMD_SEQIN:
-		mpc5121_nfc_command(mtd, NAND_CMD_READ0, column, page);
+		mpc5121_nfc_command(chip, NAND_CMD_READ0, column, page);
 		column = 0;
 		break;
 
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 82e5b1864399..a03a33656cf4 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1333,10 +1333,10 @@ static void preset_v3(struct mtd_info *mtd)
 
 /* Used by the upper layer to write command to NAND Flash for
  * different operations to be carried out on NAND Flash */
-static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
-				int column, int page_addr)
+static void mxc_nand_command(struct nand_chip *nand_chip, unsigned command,
+			     int column, int page_addr)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	dev_dbg(host->dev, "mxc_nand_command (cmd = 0x%x, col = 0x%x, page = 0x%x)\n",
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 66dae8b69fe8..a74264f36a70 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -730,7 +730,7 @@ EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
 
 /**
  * nand_command - [DEFAULT] Send command to NAND device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @command: the command to be sent
  * @column: the column address for this command, -1 if none
  * @page_addr: the page address for this command, -1 if none
@@ -738,10 +738,10 @@ EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
  * Send command to NAND device. This function is used for small page devices
  * (512 Bytes per page).
  */
-static void nand_command(struct mtd_info *mtd, unsigned int command,
+static void nand_command(struct nand_chip *chip, unsigned int command,
 			 int column, int page_addr)
 {
-	register struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ctrl = NAND_CTRL_CLE | NAND_CTRL_CHANGE;
 
 	/* Write out the command to the device */
@@ -864,7 +864,7 @@ static void nand_ccs_delay(struct nand_chip *chip)
 
 /**
  * nand_command_lp - [DEFAULT] Send command to NAND large page device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @command: the command to be sent
  * @column: the column address for this command, -1 if none
  * @page_addr: the page address for this command, -1 if none
@@ -873,10 +873,10 @@ static void nand_ccs_delay(struct nand_chip *chip)
  * devices. We don't have the separate regions as we have in the small page
  * devices. We must emulate NAND_CMD_READOOB to keep the code compatible.
  */
-static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
+static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 			    int column, int page_addr)
 {
-	register struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	/* Emulate NAND_CMD_READOOB */
 	if (command == NAND_CMD_READOOB) {
@@ -1530,7 +1530,7 @@ int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 						 buf, len);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_READ0, offset_in_page, page);
+	chip->cmdfunc(chip, NAND_CMD_READ0, offset_in_page, page);
 	if (len)
 		chip->read_buf(chip, buf, len);
 
@@ -1579,7 +1579,7 @@ static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_PARAM, page, -1);
+	chip->cmdfunc(chip, NAND_CMD_PARAM, page, -1);
 	for (i = 0; i < len; i++)
 		p[i] = chip->read_byte(chip);
 
@@ -1642,7 +1642,7 @@ int nand_change_read_column_op(struct nand_chip *chip,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset_in_page, -1);
+	chip->cmdfunc(chip, NAND_CMD_RNDOUT, offset_in_page, -1);
 	if (len)
 		chip->read_buf(chip, buf, len);
 
@@ -1679,7 +1679,7 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 					 mtd->writesize + offset_in_oob,
 					 buf, len);
 
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, offset_in_oob, page);
+	chip->cmdfunc(chip, NAND_CMD_READOOB, offset_in_oob, page);
 	if (len)
 		chip->read_buf(chip, buf, len);
 
@@ -1791,7 +1791,7 @@ int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
 		return nand_exec_prog_page_op(chip, page, offset_in_page, buf,
 					      len, false);
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
+	chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
 
 	if (buf)
 		chip->write_buf(chip, buf, len);
@@ -1833,7 +1833,7 @@ int nand_prog_page_end_op(struct nand_chip *chip)
 		if (ret)
 			return ret;
 	} else {
-		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
 		ret = chip->waitfunc(mtd, chip);
 		if (ret < 0)
 			return ret;
@@ -1878,9 +1878,9 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 		status = nand_exec_prog_page_op(chip, page, offset_in_page, buf,
 						len, true);
 	} else {
-		chip->cmdfunc(mtd, NAND_CMD_SEQIN, offset_in_page, page);
+		chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
 		chip->write_buf(chip, buf, len);
-		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
 		status = chip->waitfunc(mtd, chip);
 	}
 
@@ -1946,7 +1946,7 @@ int nand_change_write_column_op(struct nand_chip *chip,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset_in_page, -1);
+	chip->cmdfunc(chip, NAND_CMD_RNDIN, offset_in_page, -1);
 	if (len)
 		chip->write_buf(chip, buf, len);
 
@@ -1994,7 +1994,7 @@ int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_READID, addr, -1);
+	chip->cmdfunc(chip, NAND_CMD_READID, addr, -1);
 
 	for (i = 0; i < len; i++)
 		id[i] = chip->read_byte(chip);
@@ -2034,7 +2034,7 @@ int nand_status_op(struct nand_chip *chip, u8 *status)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+	chip->cmdfunc(chip, NAND_CMD_STATUS, -1, -1);
 	if (status)
 		*status = chip->read_byte(chip);
 
@@ -2066,7 +2066,7 @@ int nand_exit_status_op(struct nand_chip *chip)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_READ0, -1, -1);
+	chip->cmdfunc(chip, NAND_CMD_READ0, -1, -1);
 
 	return 0;
 }
@@ -2115,8 +2115,8 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 		if (ret)
 			return ret;
 	} else {
-		chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
-		chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+		chip->cmdfunc(chip, NAND_CMD_ERASE1, -1, page);
+		chip->cmdfunc(chip, NAND_CMD_ERASE2, -1, -1);
 
 		ret = chip->waitfunc(mtd, chip);
 		if (ret < 0)
@@ -2166,7 +2166,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
+	chip->cmdfunc(chip, NAND_CMD_SET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		chip->write_byte(chip, params[i]);
 
@@ -2215,7 +2215,7 @@ static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, feature, -1);
+	chip->cmdfunc(chip, NAND_CMD_GET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		params[i] = chip->read_byte(chip);
 
@@ -2270,7 +2270,7 @@ int nand_reset_op(struct nand_chip *chip)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+	chip->cmdfunc(chip, NAND_CMD_RESET, -1, -1);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 197256c2e1ee..fa873e517131 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -79,8 +79,6 @@ static bool hynix_nand_has_valid_jedecid(struct nand_chip *chip)
 
 static int hynix_nand_cmd_op(struct nand_chip *chip, u8 cmd)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (chip->exec_op) {
 		struct nand_op_instr instrs[] = {
 			NAND_OP_CMD(cmd, 0),
@@ -90,14 +88,13 @@ static int hynix_nand_cmd_op(struct nand_chip *chip, u8 cmd)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, cmd, -1, -1);
+	chip->cmdfunc(chip, cmd, -1, -1);
 
 	return 0;
 }
 
 static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	u16 column = ((u16)addr << 8) | addr;
 
 	if (chip->exec_op) {
@@ -110,7 +107,7 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_NONE, column, -1);
+	chip->cmdfunc(chip, NAND_CMD_NONE, column, -1);
 	chip->write_byte(chip, val);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 4029b802243d..3aae5fda5399 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -129,10 +129,11 @@ static int nuc900_nand_devready(struct nand_chip *chip)
 	return ready;
 }
 
-static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
+static void nuc900_nand_command_lp(struct nand_chip *chip,
+				   unsigned int command,
 				   int column, int page_addr)
 {
-	register struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	if (command == NAND_CMD_READOOB) {
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 952cb735f4cc..8fe5f4c612e5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1441,10 +1441,9 @@ static void post_command(struct qcom_nand_host *host, int command)
  * NAND_CMD_READOOB would never be called because we have our own versions
  * of read_oob ops for nand_ecc_ctrl.
  */
-static void qcom_nandc_command(struct mtd_info *mtd, unsigned int command,
+static void qcom_nandc_command(struct nand_chip *chip, unsigned int command,
 			       int column, int page_addr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index e2a4939971b5..4b1c7e435937 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -750,9 +750,10 @@ static void execmd_write_oob(struct mtd_info *mtd)
 	}
 }
 
-static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
+static void flctl_cmdfunc(struct nand_chip *chip, unsigned int command,
 			int column, int page_addr)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	uint32_t read_cmd = 0;
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index c0df8b6ab19b..724e66c92fd2 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -759,10 +759,10 @@ static void spinand_reset(struct spi_device *spi_nand)
 		dev_err(&spi_nand->dev, "wait timedout!\n");
 }
 
-static void spinand_cmdfunc(struct mtd_info *mtd, unsigned int command,
+static void spinand_cmdfunc(struct nand_chip *chip, unsigned int command,
 			    int column, int page)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct spinand_info *info = nand_get_controller_data(chip);
 	struct spinand_state *state = info->priv;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 404ac7d4b279..2a74de9012c4 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1292,7 +1292,7 @@ struct nand_chip {
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
 	int (*dev_ready)(struct nand_chip *chip);
-	void (*cmdfunc)(struct mtd_info *mtd, unsigned command, int column,
+	void (*cmdfunc)(struct nand_chip *chip, unsigned command, int column,
 			int page_addr);
 	int(*waitfunc)(struct mtd_info *mtd, struct nand_chip *this);
 	int (*exec_op)(struct nand_chip *chip,
-- 
2.14.1
