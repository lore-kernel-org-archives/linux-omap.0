From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 08/19] mtd: rawnand: Deprecate ->{set,get}_features() hooks
Date: Fri,  7 Sep 2018 00:38:40 +0200
Message-ID: <20180906223851.6964-9-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Ryan Mallon <rmallon@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Those hooks should be replaced by a proper ->exec_op() implementation.
Move them to the nand_legacy struct to make it clear.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |   4 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |   4 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |   4 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |   4 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |   4 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |   4 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |   4 +-
 drivers/mtd/nand/raw/nand_base.c                 | 112 +++++++++--------------
 drivers/mtd/nand/raw/qcom_nandc.c                |   4 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |   4 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |   4 +-
 include/linux/mtd/rawnand.h                      |  12 +--
 12 files changed, 70 insertions(+), 94 deletions(-)

diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 925d4cd4401e..357bc75948b0 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -390,8 +390,8 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 	b47n->nand_chip.legacy.read_byte = bcm47xxnflash_ops_bcm4706_read_byte;
 	b47n->nand_chip.legacy.read_buf = bcm47xxnflash_ops_bcm4706_read_buf;
 	b47n->nand_chip.legacy.write_buf = bcm47xxnflash_ops_bcm4706_write_buf;
-	b47n->nand_chip.set_features = nand_get_set_features_notsupp;
-	b47n->nand_chip.get_features = nand_get_set_features_notsupp;
+	b47n->nand_chip.legacy.set_features = nand_get_set_features_notsupp;
+	b47n->nand_chip.legacy.get_features = nand_get_set_features_notsupp;
 
 	nand_chip->chip_delay = 50;
 	b47n->nand_chip.bbt_options = NAND_BBT_USE_FLASH;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index db62b12800d3..e3f702bef549 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -709,8 +709,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	cafe->nand.legacy.read_buf = cafe_read_buf;
 	cafe->nand.legacy.write_buf = cafe_write_buf;
 	cafe->nand.select_chip = cafe_select_chip;
-	cafe->nand.set_features = nand_get_set_features_notsupp;
-	cafe->nand.get_features = nand_get_set_features_notsupp;
+	cafe->nand.legacy.set_features = nand_get_set_features_notsupp;
+	cafe->nand.legacy.get_features = nand_get_set_features_notsupp;
 
 	cafe->nand.chip_delay = 0;
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 29f0832de39b..c5f3aa908416 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -782,8 +782,8 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->select_chip = fsl_elbc_select_chip;
 	chip->legacy.cmdfunc = fsl_elbc_cmdfunc;
 	chip->legacy.waitfunc = fsl_elbc_wait;
-	chip->set_features = nand_get_set_features_notsupp;
-	chip->get_features = nand_get_set_features_notsupp;
+	chip->legacy.set_features = nand_get_set_features_notsupp;
+	chip->legacy.get_features = nand_get_set_features_notsupp;
 
 	chip->bbt_td = &bbt_main_descr;
 	chip->bbt_md = &bbt_mirror_descr;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 682ae383c3e9..a303d12079f0 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -867,8 +867,8 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	chip->select_chip = fsl_ifc_select_chip;
 	chip->legacy.cmdfunc = fsl_ifc_cmdfunc;
 	chip->legacy.waitfunc = fsl_ifc_wait;
-	chip->set_features = nand_get_set_features_notsupp;
-	chip->get_features = nand_get_set_features_notsupp;
+	chip->legacy.set_features = nand_get_set_features_notsupp;
+	chip->legacy.get_features = nand_get_set_features_notsupp;
 
 	chip->bbt_td = &bbt_main_descr;
 	chip->bbt_md = &bbt_mirror_descr;
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 6e17239983db..fee7d63e8de8 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -788,8 +788,8 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	chip->legacy.write_buf	= hisi_nfc_write_buf;
 	chip->legacy.read_buf	= hisi_nfc_read_buf;
 	chip->chip_delay	= HINFC504_CHIP_DELAY;
-	chip->set_features	= nand_get_set_features_notsupp;
-	chip->get_features	= nand_get_set_features_notsupp;
+	chip->legacy.set_features	= nand_get_set_features_notsupp;
+	chip->legacy.get_features	= nand_get_set_features_notsupp;
 
 	hisi_nfc_host_init(host);
 
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index 9a6dc783689e..86a0aabe08df 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -698,8 +698,8 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	chip->legacy.read_buf = mpc5121_nfc_read_buf;
 	chip->legacy.write_buf = mpc5121_nfc_write_buf;
 	chip->select_chip = mpc5121_nfc_select_chip;
-	chip->set_features	= nand_get_set_features_notsupp;
-	chip->get_features	= nand_get_set_features_notsupp;
+	chip->legacy.set_features = nand_get_set_features_notsupp;
+	chip->legacy.get_features = nand_get_set_features_notsupp;
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 	chip->ecc.mode = NAND_ECC_SOFT;
 	chip->ecc.algo = NAND_ECC_HAMMING;
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index ca074c955147..b8115100a0b8 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1778,8 +1778,8 @@ static int mxcnd_probe(struct platform_device *pdev)
 	this->legacy.read_byte = mxc_nand_read_byte;
 	this->legacy.write_buf = mxc_nand_write_buf;
 	this->legacy.read_buf = mxc_nand_read_buf;
-	this->set_features = mxc_nand_set_features;
-	this->get_features = mxc_nand_get_features;
+	this->legacy.set_features = mxc_nand_set_features;
+	this->legacy.get_features = mxc_nand_get_features;
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 57c89e275a3a..d4a84a871fc7 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1175,44 +1175,6 @@ static bool nand_supports_set_features(struct nand_chip *chip, int addr)
 		test_bit(addr, chip->parameters.set_feature_list));
 }
 
-/**
- * nand_get_features - wrapper to perform a GET_FEATURE
- * @chip: NAND chip info structure
- * @addr: feature address
- * @subfeature_param: the subfeature parameters, a four bytes array
- *
- * Returns 0 for success, a negative error otherwise. Returns -ENOTSUPP if the
- * operation cannot be handled.
- */
-int nand_get_features(struct nand_chip *chip, int addr,
-		      u8 *subfeature_param)
-{
-	if (!nand_supports_get_features(chip, addr))
-		return -ENOTSUPP;
-
-	return chip->get_features(chip, addr, subfeature_param);
-}
-EXPORT_SYMBOL_GPL(nand_get_features);
-
-/**
- * nand_set_features - wrapper to perform a SET_FEATURE
- * @chip: NAND chip info structure
- * @addr: feature address
- * @subfeature_param: the subfeature parameters, a four bytes array
- *
- * Returns 0 for success, a negative error otherwise. Returns -ENOTSUPP if the
- * operation cannot be handled.
- */
-int nand_set_features(struct nand_chip *chip, int addr,
-		      u8 *subfeature_param)
-{
-	if (!nand_supports_set_features(chip, addr))
-		return -ENOTSUPP;
-
-	return chip->set_features(chip, addr, subfeature_param);
-}
-EXPORT_SYMBOL_GPL(nand_set_features);
-
 /**
  * nand_reset_data_interface - Reset data interface and timings
  * @chip: The NAND chip
@@ -2833,6 +2795,50 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 }
 EXPORT_SYMBOL_GPL(nand_reset);
 
+/**
+ * nand_get_features - wrapper to perform a GET_FEATURE
+ * @chip: NAND chip info structure
+ * @addr: feature address
+ * @subfeature_param: the subfeature parameters, a four bytes array
+ *
+ * Returns 0 for success, a negative error otherwise. Returns -ENOTSUPP if the
+ * operation cannot be handled.
+ */
+int nand_get_features(struct nand_chip *chip, int addr,
+		      u8 *subfeature_param)
+{
+	if (!nand_supports_get_features(chip, addr))
+		return -ENOTSUPP;
+
+	if (chip->legacy.get_features)
+		return chip->legacy.get_features(chip, addr, subfeature_param);
+
+	return nand_get_features_op(chip, addr, subfeature_param);
+}
+EXPORT_SYMBOL_GPL(nand_get_features);
+
+/**
+ * nand_set_features - wrapper to perform a SET_FEATURE
+ * @chip: NAND chip info structure
+ * @addr: feature address
+ * @subfeature_param: the subfeature parameters, a four bytes array
+ *
+ * Returns 0 for success, a negative error otherwise. Returns -ENOTSUPP if the
+ * operation cannot be handled.
+ */
+int nand_set_features(struct nand_chip *chip, int addr,
+		      u8 *subfeature_param)
+{
+	if (!nand_supports_set_features(chip, addr))
+		return -ENOTSUPP;
+
+	if (chip->legacy.set_features)
+		return chip->legacy.set_features(chip, addr, subfeature_param);
+
+	return nand_set_features_op(chip, addr, subfeature_param);
+}
+EXPORT_SYMBOL_GPL(nand_set_features);
+
 /**
  * nand_check_erased_buf - check if a buffer contains (almost) only 0xff data
  * @buf: buffer to test
@@ -4864,30 +4870,6 @@ static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
 	return chip->max_bb_per_die * (part_end_die - part_start_die + 1);
 }
 
-/**
- * nand_default_set_features- [REPLACEABLE] set NAND chip features
- * @chip: nand chip info structure
- * @addr: feature address.
- * @subfeature_param: the subfeature parameters, a four bytes array.
- */
-static int nand_default_set_features(struct nand_chip *chip, int addr,
-				     uint8_t *subfeature_param)
-{
-	return nand_set_features_op(chip, addr, subfeature_param);
-}
-
-/**
- * nand_default_get_features- [REPLACEABLE] get NAND chip features
- * @chip: nand chip info structure
- * @addr: feature address.
- * @subfeature_param: the subfeature parameters, a four bytes array.
- */
-static int nand_default_get_features(struct nand_chip *chip, int addr,
-				     uint8_t *subfeature_param)
-{
-	return nand_get_features_op(chip, addr, subfeature_param);
-}
-
 /**
  * nand_get_set_features_notsupp - set/get features stub returning -ENOTSUPP
  * @chip: nand chip info structure
@@ -4958,12 +4940,6 @@ static void nand_set_defaults(struct nand_chip *chip)
 	if (!chip->select_chip)
 		chip->select_chip = nand_select_chip;
 
-	/* set for ONFI nand */
-	if (!chip->set_features)
-		chip->set_features = nand_default_set_features;
-	if (!chip->get_features)
-		chip->get_features = nand_default_get_features;
-
 	/* If called twice, pointers that depend on busw may need to be reset */
 	if (!chip->legacy.read_byte || chip->legacy.read_byte == nand_read_byte)
 		chip->legacy.read_byte = busw ? nand_read_byte16 : nand_read_byte;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 79342e24ed81..ef75dfa62a4f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2808,8 +2808,8 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	chip->legacy.read_byte	= qcom_nandc_read_byte;
 	chip->legacy.read_buf	= qcom_nandc_read_buf;
 	chip->legacy.write_buf	= qcom_nandc_write_buf;
-	chip->set_features	= nand_get_set_features_notsupp;
-	chip->get_features	= nand_get_set_features_notsupp;
+	chip->legacy.set_features	= nand_get_set_features_notsupp;
+	chip->legacy.get_features	= nand_get_set_features_notsupp;
 
 	/*
 	 * the bad block marker is readable only when we read the last codeword
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 71658fbd99a3..40a4159924a7 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1185,8 +1185,8 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->legacy.read_buf = flctl_read_buf;
 	nand->select_chip = flctl_select_chip;
 	nand->legacy.cmdfunc = flctl_cmdfunc;
-	nand->set_features = nand_get_set_features_notsupp;
-	nand->get_features = nand_get_set_features_notsupp;
+	nand->legacy.set_features = nand_get_set_features_notsupp;
+	nand->legacy.get_features = nand_get_set_features_notsupp;
 
 	if (pdata->flcmncr_val & SEL_16BIT)
 		nand->options |= NAND_BUSWIDTH_16;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index fb28cc6331f2..def8a1f57d1c 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -922,8 +922,8 @@ static int spinand_probe(struct spi_device *spi_nand)
 	chip->legacy.waitfunc	= spinand_wait;
 	chip->options	|= NAND_CACHEPRG;
 	chip->select_chip = spinand_select_chip;
-	chip->set_features = nand_get_set_features_notsupp;
-	chip->get_features = nand_get_set_features_notsupp;
+	chip->legacy.set_features = nand_get_set_features_notsupp;
+	chip->legacy.get_features = nand_get_set_features_notsupp;
 
 	mtd = nand_to_mtd(chip);
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 97c6ff7d127e..02ac70a30c63 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1190,6 +1190,8 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * @block_bad: check if a block is bad, using OOB markers
  * @block_markbad: mark a block bad
  * @erase: erase function
+ * @set_features: set the NAND chip features
+ * @get_features: get the NAND chip features
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1209,6 +1211,10 @@ struct nand_legacy {
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 	int (*erase)(struct nand_chip *chip, int page);
+	int (*set_features)(struct nand_chip *chip, int feature_addr,
+			    u8 *subfeature_para);
+	int (*get_features)(struct nand_chip *chip, int feature_addr,
+			    u8 *subfeature_para);
 };
 
 /**
@@ -1279,8 +1285,6 @@ struct nand_legacy {
  * @blocks_per_die:	[INTERN] The number of PEBs in a die
  * @data_interface:	[INTERN] NAND interface timing information
  * @read_retries:	[INTERN] the number of read retry modes supported
- * @set_features:	[REPLACEABLE] set the NAND chip features
- * @get_features:	[REPLACEABLE] get the NAND chip features
  * @setup_data_interface: [OPTIONAL] setup the data interface and timing. If
  *			  chipnr is set to %NAND_DATA_IFACE_CHECK_ONLY this
  *			  means the configuration should not be applied but
@@ -1309,10 +1313,6 @@ struct nand_chip {
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-	int (*set_features)(struct nand_chip *chip, int feature_addr,
-			    uint8_t *subfeature_para);
-	int (*get_features)(struct nand_chip *chip, int feature_addr,
-			    uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*setup_data_interface)(struct nand_chip *chip, int chipnr,
 				    const struct nand_data_interface *conf);
-- 
2.14.1
