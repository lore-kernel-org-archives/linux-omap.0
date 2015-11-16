From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 26/27] mtd: nand: make use of
 nand_set/get_controller_data() helpers
Date: Mon, 16 Nov 2015 14:37:59 +0100
Message-ID: <1447681080-31232-27-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBZVYU6ZAKGQEZGYYWFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>a
List-Id: linux-omap@vger.kernel.org

New helpers have been added to avoid directly accessing chip->field. Use
them where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/ams-delta.c                 |  6 +--
 drivers/mtd/nand/atmel_nand.c                | 54 ++++++++++-----------
 drivers/mtd/nand/bcm47xxnflash/main.c        |  2 +-
 drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c | 16 +++----
 drivers/mtd/nand/bf5xx_nand.c                |  2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c         | 32 ++++++-------
 drivers/mtd/nand/cafe_nand.c                 | 24 +++++-----
 drivers/mtd/nand/diskonchip.c                | 70 ++++++++++++++--------------
 drivers/mtd/nand/docg4.c                     | 42 ++++++++---------
 drivers/mtd/nand/fsl_elbc_nand.c             | 22 ++++-----
 drivers/mtd/nand/fsl_ifc_nand.c              | 26 +++++------
 drivers/mtd/nand/fsmc_nand.c                 |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c       | 28 +++++------
 drivers/mtd/nand/hisi504_nand.c              | 20 ++++----
 drivers/mtd/nand/lpc32xx_mlc.c               | 18 +++----
 drivers/mtd/nand/lpc32xx_slc.c               | 20 ++++----
 drivers/mtd/nand/mpc5121_nfc.c               | 24 +++++-----
 drivers/mtd/nand/mxc_nand.c                  | 36 +++++++-------
 drivers/mtd/nand/nandsim.c                   |  4 +-
 drivers/mtd/nand/ndfc.c                      | 16 +++----
 drivers/mtd/nand/orion_nand.c                |  4 +-
 drivers/mtd/nand/plat_nand.c                 |  2 +-
 drivers/mtd/nand/pxa3xx_nand.c               | 22 ++++-----
 drivers/mtd/nand/r852.c                      |  6 +--
 drivers/mtd/nand/s3c2410.c                   |  4 +-
 drivers/mtd/nand/socrates_nand.c             | 10 ++--
 drivers/mtd/nand/txx9ndfmc.c                 |  8 ++--
 27 files changed, 260 insertions(+), 260 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 1a18938..68b58c8 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -65,7 +65,7 @@ static struct mtd_partition partition_info[] = {
 static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	void __iomem *io_base = this->priv;
+	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
@@ -78,7 +78,7 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 {
 	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	void __iomem *io_base = this->priv;
+	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
 	ndelay(40);
@@ -206,7 +206,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	this->priv = io_base;
+	nand_set_controller_data(this, (void *)io_base);
 
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index aef02d3..769ad8b 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -182,7 +182,7 @@ static void atmel_nand_disable(struct atmel_nand_host *host)
 static void atmel_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_NCE)
@@ -205,7 +205,7 @@ static void atmel_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl
 static int atmel_nand_device_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	return gpio_get_value(host->board.rdy_pin) ^
                 !!host->board.rdy_pin_active_low;
@@ -215,7 +215,7 @@ static int atmel_nand_device_ready(struct mtd_info *mtd)
 static int atmel_nand_set_enable_ready_pins(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	int res = 0;
 
 	if (gpio_is_valid(host->board.rdy_pin)) {
@@ -267,7 +267,7 @@ static int atmel_nand_set_enable_ready_pins(struct mtd_info *mtd)
 static void atmel_read_buf8(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip	*nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (host->nfc && host->nfc->use_nfc_sram && host->nfc->data_in_sram) {
 		memcpy(buf, host->nfc->data_in_sram, len);
@@ -280,7 +280,7 @@ static void atmel_read_buf8(struct mtd_info *mtd, u8 *buf, int len)
 static void atmel_read_buf16(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip	*nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (host->nfc && host->nfc->use_nfc_sram && host->nfc->data_in_sram) {
 		memcpy(buf, host->nfc->data_in_sram, len);
@@ -352,7 +352,7 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 	struct dma_async_tx_descriptor *tx = NULL;
 	dma_cookie_t cookie;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	void *p = buf;
 	int err = -EIO;
 	enum dma_data_direction dir = is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
@@ -425,7 +425,7 @@ err_buf:
 static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 
 	if (use_dma && len > mtd->oobsize)
 		/* only use DMA for bigger than oob size: better performances */
@@ -441,7 +441,7 @@ static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 
 	if (use_dma && len > mtd->oobsize)
 		/* only use DMA for bigger than oob size: better performances */
@@ -533,7 +533,7 @@ static int pmecc_data_alloc(struct atmel_nand_host *host)
 static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	int i;
 	uint32_t value;
 
@@ -550,7 +550,7 @@ static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
 static void pmecc_substitute(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	int16_t __iomem *alpha_to = host->pmecc_alpha_to;
 	int16_t __iomem *index_of = host->pmecc_index_of;
 	int16_t *partial_syn = host->pmecc_partial_syn;
@@ -592,7 +592,7 @@ static void pmecc_substitute(struct mtd_info *mtd)
 static void pmecc_get_sigma(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	int16_t *lmu = host->pmecc_lmu;
 	int16_t *si = host->pmecc_si;
@@ -750,7 +750,7 @@ static void pmecc_get_sigma(struct mtd_info *mtd)
 static int pmecc_err_location(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	unsigned long end_time;
 	const int cap = host->pmecc_corr_cap;
 	const int num = 2 * cap + 1;
@@ -802,7 +802,7 @@ static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf, uint8_t *ecc,
 		int sector_num, int extra_bytes, int err_nbr)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	int i = 0;
 	int byte_pos, bit_pos, sector_size, pos;
 	uint32_t tmp;
@@ -848,7 +848,7 @@ static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
 	u8 *ecc)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	int i, err_nbr;
 	uint8_t *buf_pos;
 	int max_bitflips = 0;
@@ -918,7 +918,7 @@ static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
 static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
 {
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	int eccsize = chip->ecc.size * chip->ecc.steps;
 	uint8_t *oob = chip->oob_poi;
 	uint32_t *eccpos = chip->ecc.layout->eccpos;
@@ -956,7 +956,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 		struct nand_chip *chip, const uint8_t *buf, int oob_required,
 		int page)
 {
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	int i, j;
 	unsigned long end_time;
@@ -992,7 +992,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 static void atmel_pmecc_core_init(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	uint32_t val = 0;
 	struct nand_ecclayout *ecc_layout;
 
@@ -1308,7 +1308,7 @@ static int atmel_nand_calculate(struct mtd_info *mtd,
 		const u_char *dat, unsigned char *ecc_code)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	unsigned int ecc_value;
 
 	/* get the first 2 ECC bytes */
@@ -1354,7 +1354,7 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	 * Workaround: Reset the parity registers before reading the
 	 * actual data.
 	 */
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	if (host->board.need_reset_workaround)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
 
@@ -1412,7 +1412,7 @@ static int atmel_nand_correct(struct mtd_info *mtd, u_char *dat,
 		u_char *read_ecc, u_char *isnull)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	unsigned int ecc_status;
 	unsigned int ecc_word, ecc_bit;
 
@@ -1478,7 +1478,7 @@ static int atmel_nand_correct(struct mtd_info *mtd, u_char *dat,
 static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (host->board.need_reset_workaround)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
@@ -1771,7 +1771,7 @@ static int nfc_device_ready(struct mtd_info *mtd)
 {
 	u32 status, mask;
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	status = nfc_read_status(host);
 	mask = nfc_readl(host->nfc->hsmc_regs, IMR);
@@ -1787,7 +1787,7 @@ static int nfc_device_ready(struct mtd_info *mtd)
 static void nfc_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = nand_chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (chip == -1)
 		nfc_writel(host->nfc->hsmc_regs, CTRL, NFC_CTRL_DISABLE);
@@ -1839,7 +1839,7 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
 				int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	unsigned long timeout;
 	unsigned int nfc_addr_cmd = 0;
 
@@ -1965,7 +1965,7 @@ static int nfc_sram_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int cfg, len;
 	int status = 0;
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	void *sram = host->nfc->sram_bank0 + nfc_get_sram_off(host);
 
 	/* Subpage write is not supported */
@@ -2026,7 +2026,7 @@ static int nfc_sram_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int nfc_sram_init(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	int res = 0;
 
 	/* Initialize the NFC CFG register */
@@ -2125,7 +2125,7 @@ static int atmel_nand_probe(struct platform_device *pdev)
 		       sizeof(struct atmel_nand_data));
 	}
 
-	nand_chip->priv = host;		/* link the private data structures */
+	nand_set_controller_data(nand_chip, host);		/* link the private data structures */
 	mtd->dev.parent = &pdev->dev;
 
 	/* Set address of NAND IO lines */
diff --git a/drivers/mtd/nand/bcm47xxnflash/main.c b/drivers/mtd/nand/bcm47xxnflash/main.c
index f3476fa..f9a8d28 100644
--- a/drivers/mtd/nand/bcm47xxnflash/main.c
+++ b/drivers/mtd/nand/bcm47xxnflash/main.c
@@ -33,7 +33,7 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 	if (!b47n)
 		return -ENOMEM;
 
-	b47n->nand_chip.priv = b47n;
+	nand_set_controller_data(&b47n->nand_chip, b47n);
 	nand_to_mtd(&b47n->nand_chip)->dev.parent = &pdev->dev;
 	nand_to_mtd(&b47n->nand_chip)->priv = &b47n->nand_chip; /* Required */
 	b47n->cc = container_of(nflash, struct bcma_drv_cc, nflash);
diff --git a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
index 6524780..bc698bd 100644
--- a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
@@ -90,7 +90,7 @@ static void bcm47xxnflash_ops_bcm4706_read(struct mtd_info *mtd, uint8_t *buf,
 					   int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 
 	u32 ctlcode;
 	u32 *dest = (u32 *)buf;
@@ -140,7 +140,7 @@ static void bcm47xxnflash_ops_bcm4706_write(struct mtd_info *mtd,
 					    const uint8_t *buf, int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 	struct bcma_drv_cc *cc = b47n->cc;
 
 	u32 ctlcode;
@@ -174,7 +174,7 @@ static void bcm47xxnflash_ops_bcm4706_cmd_ctrl(struct mtd_info *mtd, int cmd,
 					       unsigned int ctrl)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 	u32 code = 0;
 
 	if (cmd == NAND_CMD_NONE)
@@ -200,7 +200,7 @@ static void bcm47xxnflash_ops_bcm4706_select_chip(struct mtd_info *mtd,
 static int bcm47xxnflash_ops_bcm4706_dev_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 
 	return !!(bcma_cc_read32(b47n->cc, BCMA_CC_NFLASH_CTL) & NCTL_READY);
 }
@@ -217,7 +217,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 					      int page_addr)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 	struct bcma_drv_cc *cc = b47n->cc;
 	u32 ctlcode;
 	int i;
@@ -313,7 +313,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 static u8 bcm47xxnflash_ops_bcm4706_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 	struct bcma_drv_cc *cc = b47n->cc;
 	u32 tmp = 0;
 
@@ -342,7 +342,7 @@ static void bcm47xxnflash_ops_bcm4706_read_buf(struct mtd_info *mtd,
 					       uint8_t *buf, int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 
 	switch (b47n->curr_command) {
 	case NAND_CMD_READ0:
@@ -358,7 +358,7 @@ static void bcm47xxnflash_ops_bcm4706_write_buf(struct mtd_info *mtd,
 						const uint8_t *buf, int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_chip->priv;
+	struct bcm47xxnflash *b47n = (struct bcm47xxnflash *)nand_get_controller_data(nand_chip);
 
 	switch (b47n->curr_command) {
 	case NAND_CMD_SEQIN:
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 77d3b11..90db6ae 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -772,7 +772,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl     = bf5xx_nand_hwcontrol;
 	chip->dev_ready    = bf5xx_nand_devready;
 
-	chip->priv	   = nand_to_mtd(&info->chip);
+	nand_set_controller_data(chip, nand_to_mtd(&info->chip));
 	chip->controller   = &info->controller;
 
 	chip->IO_ADDR_R    = (void __iomem *) NFC_READ;
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index a124147..10c4907 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -874,7 +874,7 @@ static struct nand_ecclayout *brcmstb_choose_ecc_layout(
 static void brcmnand_wp(struct mtd_info *mtd, int wp)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 
 	if ((ctrl->features & BRCMNAND_HAS_WP) && wp_on == 1) {
@@ -1040,7 +1040,7 @@ static void brcmnand_cmd_ctrl(struct mtd_info *mtd, int dat,
 static int brcmnand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	unsigned long timeo = msecs_to_jiffies(100);
 
@@ -1114,7 +1114,7 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			     int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u64 addr = (u64)page_addr << chip->page_shift;
 	int native_cmd = 0;
@@ -1214,7 +1214,7 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
 static uint8_t brcmnand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	uint8_t ret = 0;
 	int addr, offs;
@@ -1282,7 +1282,7 @@ static void brcmnand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
 {
 	int i;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 
 	switch (host->last_cmd) {
 	case NAND_CMD_SET_FEATURES:
@@ -1392,7 +1392,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 				u64 addr, unsigned int trans, u32 *buf,
 				u8 *oob, u64 *err_addr)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	int i, j, ret = 0;
 
@@ -1453,7 +1453,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 			 u64 addr, unsigned int trans, u32 *buf, u8 *oob)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u64 err_addr = 0;
 	int err;
@@ -1503,7 +1503,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			      uint8_t *buf, int oob_required, int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 
 	return brcmnand_read(mtd, chip, host->last_addr,
@@ -1513,7 +1513,7 @@ static int brcmnand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				  uint8_t *buf, int oob_required, int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 	int ret;
 
@@ -1535,7 +1535,7 @@ static int brcmnand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				 int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 
 	brcmnand_set_ecc_enabled(host, 0);
 	brcmnand_read(mtd, chip, (u64)page << chip->page_shift,
@@ -1549,7 +1549,7 @@ static int brcmnand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 				 uint32_t data_offs, uint32_t readlen,
 				 uint8_t *bufpoi, int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 
 	return brcmnand_read(mtd, chip, host->last_addr + data_offs,
 			readlen >> FC_SHIFT, (u32 *)bufpoi, NULL);
@@ -1558,7 +1558,7 @@ static int brcmnand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 			  u64 addr, const u32 *buf, u8 *oob)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	unsigned int i, j, trans = mtd->writesize >> FC_SHIFT;
 	int status, ret = 0;
@@ -1629,7 +1629,7 @@ out:
 static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required, int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
 	brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob);
@@ -1640,7 +1640,7 @@ static int brcmnand_write_page_raw(struct mtd_info *mtd,
 				   struct nand_chip *chip, const uint8_t *buf,
 				   int oob_required, int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
 	brcmnand_set_ecc_enabled(host, 0);
@@ -1659,7 +1659,7 @@ static int brcmnand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int brcmnand_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				  int page)
 {
-	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	int ret;
 
 	brcmnand_set_ecc_enabled(host, 0);
@@ -1924,7 +1924,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 	chip = &host->chip;
 
 	nand_set_flash_node(chip, dn);
-	chip->priv = host;
+	nand_set_controller_data(chip, host);
 	mtd->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "brcmnand.%d",
 				   host->cs);
 	mtd->owner = THIS_MODULE;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 096917a..7a630ae 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -102,7 +102,7 @@ static const char *part_probes[] = { "cmdlinepart", "RedBoot", NULL };
 static int cafe_device_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	int result = !!(cafe_readl(cafe, NAND_STATUS) & 0x40000000);
 	uint32_t irqs = cafe_readl(cafe, NAND_IRQ);
 
@@ -119,7 +119,7 @@ static int cafe_device_ready(struct mtd_info *mtd)
 static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	if (usedma)
 		memcpy(cafe->dmabuf + cafe->datalen, buf, len);
@@ -135,7 +135,7 @@ static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	if (usedma)
 		memcpy(buf, cafe->dmabuf + cafe->datalen, len);
@@ -150,7 +150,7 @@ static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static uint8_t cafe_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	uint8_t d;
 
 	cafe_read_buf(mtd, &d, 1);
@@ -163,7 +163,7 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			      int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	int adrbytes = 0;
 	uint32_t ctl1;
 	uint32_t doneint = 0x80000000;
@@ -319,7 +319,7 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 static void cafe_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	cafe_dev_dbg(&cafe->pdev->dev, "select_chip %d\n", chipnr);
 
@@ -335,7 +335,7 @@ static irqreturn_t cafe_nand_interrupt(int irq, void *id)
 {
 	struct mtd_info *mtd = id;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	uint32_t irqs = cafe_readl(cafe, NAND_IRQ);
 	cafe_writel(cafe, irqs & ~0x90000000, NAND_IRQ);
 	if (!irqs)
@@ -384,7 +384,7 @@ static int cafe_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			       uint8_t *buf, int oob_required, int page)
 {
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	unsigned int max_bitflips = 0;
 
 	cafe_dev_dbg(&cafe->pdev->dev, "ECC result %08x SYN1,2 %08x\n",
@@ -526,7 +526,7 @@ static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 					  const uint8_t *buf, int oob_required,
 					  int page)
 {
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	chip->write_buf(mtd, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -612,7 +612,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
 
-	cafe->nand.priv = cafe;
+	nand_set_controller_data(&cafe->nand, cafe);
 	cafe->pdev = pdev;
 	cafe->mmio = pci_iomap(pdev, 0, 0);
 	if (!cafe->mmio) {
@@ -800,7 +800,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 {
 	struct mtd_info *mtd = pci_get_drvdata(pdev);
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
@@ -828,7 +828,7 @@ static int cafe_nand_resume(struct pci_dev *pdev)
 	uint32_t ctrl;
 	struct mtd_info *mtd = pci_get_drvdata(pdev);
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct cafe_priv *cafe = chip->priv;
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
        /* Start off by resetting the NAND controller completely */
 	cafe_writel(cafe, 1, NAND_RESET);
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 395c037..dbd16e8 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -300,7 +300,7 @@ static inline int DoC_WaitReady(struct doc_priv *doc)
 static void doc2000_write_byte(struct mtd_info *mtd, u_char datum)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	if (debug)
@@ -312,7 +312,7 @@ static void doc2000_write_byte(struct mtd_info *mtd, u_char datum)
 static u_char doc2000_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	u_char ret;
 
@@ -327,7 +327,7 @@ static u_char doc2000_read_byte(struct mtd_info *mtd)
 static void doc2000_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 	if (debug)
@@ -344,7 +344,7 @@ static void doc2000_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 static void doc2000_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -359,7 +359,7 @@ static void doc2000_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 static void doc2000_readbuf_dword(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -380,7 +380,7 @@ static void doc2000_readbuf_dword(struct mtd_info *mtd, u_char *buf, int len)
 static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	uint16_t ret;
 
 	doc200x_select_chip(mtd, nr);
@@ -426,7 +426,7 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 static void __init doc2000_count_chips(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	uint16_t mfrid;
 	int i;
 
@@ -447,7 +447,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
 
 static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
 {
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 
 	int status;
 
@@ -462,7 +462,7 @@ static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
 static void doc2001_write_byte(struct mtd_info *mtd, u_char datum)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	WriteDOC(datum, docptr, CDSNSlowIO);
@@ -473,7 +473,7 @@ static void doc2001_write_byte(struct mtd_info *mtd, u_char datum)
 static u_char doc2001_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	//ReadDOC(docptr, CDSNSlowIO);
@@ -487,7 +487,7 @@ static u_char doc2001_read_byte(struct mtd_info *mtd)
 static void doc2001_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -500,7 +500,7 @@ static void doc2001_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 static void doc2001_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -517,7 +517,7 @@ static void doc2001_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 static u_char doc2001plus_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	u_char ret;
 
@@ -532,7 +532,7 @@ static u_char doc2001plus_read_byte(struct mtd_info *mtd)
 static void doc2001plus_writebuf(struct mtd_info *mtd, const u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -550,7 +550,7 @@ static void doc2001plus_writebuf(struct mtd_info *mtd, const u_char *buf, int le
 static void doc2001plus_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 
@@ -581,7 +581,7 @@ static void doc2001plus_readbuf(struct mtd_info *mtd, u_char *buf, int len)
 static void doc2001plus_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int floor = 0;
 
@@ -608,7 +608,7 @@ static void doc2001plus_select_chip(struct mtd_info *mtd, int chip)
 static void doc200x_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int floor = 0;
 
@@ -639,7 +639,7 @@ static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
 			      unsigned int ctrl)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
@@ -662,7 +662,7 @@ static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
 static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	/*
@@ -768,7 +768,7 @@ static void doc2001plus_command(struct mtd_info *mtd, unsigned command, int colu
 static int doc200x_dev_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	if (DoC_is_MillenniumPlus(doc)) {
@@ -808,7 +808,7 @@ static int doc200x_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
 static void doc200x_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	/* Prime the ECC engine */
@@ -827,7 +827,7 @@ static void doc200x_enable_hwecc(struct mtd_info *mtd, int mode)
 static void doc2001plus_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
 	/* Prime the ECC engine */
@@ -847,7 +847,7 @@ static void doc2001plus_enable_hwecc(struct mtd_info *mtd, int mode)
 static int doc200x_calculate_ecc(struct mtd_info *mtd, const u_char *dat, unsigned char *ecc_code)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
 	int emptymatch = 1;
@@ -908,7 +908,7 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
 {
 	int i, ret = 0;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	uint8_t calc_ecc[6];
 	volatile u_char dummy;
@@ -1008,7 +1008,7 @@ static struct nand_ecclayout doc200x_oobinfo = {
 static int __init find_media_headers(struct mtd_info *mtd, u_char *buf, const char *id, int findmirror)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	unsigned offs;
 	int ret;
 	size_t retlen;
@@ -1051,7 +1051,7 @@ static int __init find_media_headers(struct mtd_info *mtd, u_char *buf, const ch
 static inline int __init nftl_partscan(struct mtd_info *mtd, struct mtd_partition *parts)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	int ret = 0;
 	u_char *buf;
 	struct NFTLMediaHeader *mh;
@@ -1153,7 +1153,7 @@ static inline int __init nftl_partscan(struct mtd_info *mtd, struct mtd_partitio
 static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partition *parts)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	int ret = 0;
 	u_char *buf;
 	struct INFTLMediaHeader *mh;
@@ -1273,7 +1273,7 @@ static int __init nftl_scan_bbt(struct mtd_info *mtd)
 {
 	int ret, numparts;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	struct mtd_partition parts[2];
 
 	memset((char *)parts, 0, sizeof(parts));
@@ -1308,7 +1308,7 @@ static int __init inftl_scan_bbt(struct mtd_info *mtd)
 {
 	int ret, numparts;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 	struct mtd_partition parts[5];
 
 	if (this->numchips > doc->chips_per_floor) {
@@ -1361,7 +1361,7 @@ static int __init inftl_scan_bbt(struct mtd_info *mtd)
 static inline int __init doc2000_init(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 
 	this->read_byte = doc2000_read_byte;
 	this->write_buf = doc2000_writebuf;
@@ -1377,7 +1377,7 @@ static inline int __init doc2000_init(struct mtd_info *mtd)
 static inline int __init doc2001_init(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 
 	this->read_byte = doc2001_read_byte;
 	this->write_buf = doc2001_writebuf;
@@ -1407,7 +1407,7 @@ static inline int __init doc2001_init(struct mtd_info *mtd)
 static inline int __init doc2001plus_init(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct doc_priv *doc = this->priv;
+	struct doc_priv *doc = nand_get_controller_data(this);
 
 	this->read_byte = doc2001plus_read_byte;
 	this->write_buf = doc2001plus_writebuf;
@@ -1524,7 +1524,7 @@ static int __init doc_probe(unsigned long physadr)
 		unsigned char oldval;
 		unsigned char newval;
 		nand = mtd_to_nand(mtd);
-		doc = nand->priv;
+		doc = nand_get_controller_data(nand);
 		/* Use the alias resolution register to determine if this is
 		   in fact the same DOC aliased to a new address.  If writes
 		   to one chip's alias resolution register change the value on
@@ -1570,7 +1570,7 @@ static int __init doc_probe(unsigned long physadr)
 
 	mtd->owner		= THIS_MODULE;
 
-	nand->priv		= doc;
+	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
 	nand->cmd_ctrl		= doc200x_hwcontrol;
 	nand->dev_ready		= doc200x_dev_ready;
@@ -1642,7 +1642,7 @@ static void release_nanddoc(void)
 
 	for (mtd = doclist; mtd; mtd = nextmtd) {
 		nand = mtd_to_nand(mtd);
-		doc = nand->priv;
+		doc = nand_get_controller_data(nand);
 
 		nextmtd = doc->nextdoc;
 		nand_release(mtd);
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index 31135c7..10eb463 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -297,7 +297,7 @@ static int poll_status(struct docg4_priv *doc)
 static int docg4_wait(struct mtd_info *mtd, struct nand_chip *nand)
 {
 
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	int status = NAND_STATUS_WP;       /* inverse logic?? */
 	dev_dbg(doc->dev, "%s...\n", __func__);
 
@@ -319,7 +319,7 @@ static void docg4_select_chip(struct mtd_info *mtd, int chip)
 	 * not yet supported, so the only valid non-negative value is 0.
 	 */
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
 	dev_dbg(doc->dev, "%s: chip %d\n", __func__, chip);
@@ -338,7 +338,7 @@ static void reset(struct mtd_info *mtd)
 	/* full device reset */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
 	writew(DOC_ASICMODE_RESET | DOC_ASICMODE_MDWREN,
@@ -376,7 +376,7 @@ static int correct_data(struct mtd_info *mtd, uint8_t *buf, int page)
 	 */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	int i, numerrs, errpos[4];
 	const uint8_t blank_read_hwecc[8] = {
@@ -465,7 +465,7 @@ static int correct_data(struct mtd_info *mtd, uint8_t *buf, int page)
 static uint8_t docg4_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 
 	dev_dbg(doc->dev, "%s\n", __func__);
 
@@ -546,7 +546,7 @@ static int pageprog(struct mtd_info *mtd)
 	 */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	int retval = 0;
 
@@ -583,7 +583,7 @@ static void sequence_reset(struct mtd_info *mtd)
 	/* common starting sequence for all operations */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
 	writew(DOC_CTRL_UNKNOWN | DOC_CTRL_CE, docptr + DOC_FLASHCONTROL);
@@ -600,7 +600,7 @@ static void read_page_prologue(struct mtd_info *mtd, uint32_t docg4_addr)
 	/* first step in reading a page */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
 	dev_dbg(doc->dev,
@@ -627,7 +627,7 @@ static void write_page_prologue(struct mtd_info *mtd, uint32_t docg4_addr)
 	/* first step in writing a page */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
 	dev_dbg(doc->dev,
@@ -692,7 +692,7 @@ static void docg4_command(struct mtd_info *mtd, unsigned command, int column,
 	/* handle standard nand commands */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	uint32_t g4_addr = mtd_to_docg4_address(page_addr, column);
 
 	dev_dbg(doc->dev, "%s %x, page_addr=%x, column=%x\n",
@@ -756,7 +756,7 @@ static void docg4_command(struct mtd_info *mtd, unsigned command, int column,
 static int read_page(struct mtd_info *mtd, struct nand_chip *nand,
 		     uint8_t *buf, int page, bool use_ecc)
 {
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t status, edc_err, *buf16;
 	int bits_corrected = 0;
@@ -836,7 +836,7 @@ static int docg4_read_page(struct mtd_info *mtd, struct nand_chip *nand,
 static int docg4_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
 			  int page)
 {
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t status;
 
@@ -875,7 +875,7 @@ static int docg4_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
 static int docg4_erase_block(struct mtd_info *mtd, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t g4_page;
 
@@ -923,7 +923,7 @@ static int docg4_erase_block(struct mtd_info *mtd, int page)
 static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 		       const uint8_t *buf, bool use_ecc)
 {
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint8_t ecc_buf[8];
 
@@ -1003,7 +1003,7 @@ static int docg4_write_oob(struct mtd_info *mtd, struct nand_chip *nand,
 	 */
 
 	/* note that bytes 7..14 are hw generated hamming/ecc and overwritten */
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	doc->oob_page = page;
 	memcpy(doc->oob_buf, nand->oob_poi, 16);
 	return 0;
@@ -1017,7 +1017,7 @@ static int __init read_factory_bbt(struct mtd_info *mtd)
 	 */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	uint32_t g4_addr = mtd_to_docg4_address(DOCG4_FACTORY_BBT_PAGE, 0);
 	uint8_t *buf;
 	int i, block;
@@ -1090,7 +1090,7 @@ static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	int ret, i;
 	uint8_t *buf;
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	struct nand_bbt_descr *bbtd = nand->badblock_pattern;
 	int page = (int)(ofs >> nand->page_shift);
 	uint32_t g4_addr = mtd_to_docg4_address(page, 0);
@@ -1203,7 +1203,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	 */
 
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 
 	mtd->size = DOCG4_CHIP_SIZE;
 	mtd->name = "Msys_Diskonchip_G4";
@@ -1262,7 +1262,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 static int __init read_id_reg(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct docg4_priv *doc = nand->priv;
+	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t id1, id2;
 
@@ -1313,7 +1313,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 	}
 	mtd = nand_to_mtd(nand);
 	doc = (struct docg4_priv *) (nand + 1);
-	nand->priv = doc;
+	nand_set_controller_data(nand, doc);
 	mtd->dev.parent = &pdev->dev;
 	doc->virtadr = virtadr;
 	doc->dev = dev;
@@ -1355,7 +1355,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 	iounmap(virtadr);
 	if (nand) {
 		/* re-declarations avoid compiler warning */
-		struct docg4_priv *doc = nand->priv;
+		struct docg4_priv *doc = nand_get_controller_data(nand);
 		nand_release(mtd); /* deletes partitions and mtd devices */
 		free_bch(doc->bch);
 		kfree(nand);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 5d2e302..46fa900 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -144,7 +144,7 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
@@ -195,7 +195,7 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 static int fsl_elbc_run_command(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
@@ -267,7 +267,7 @@ static int fsl_elbc_run_command(struct mtd_info *mtd)
 
 static void fsl_elbc_do_read(struct nand_chip *chip, int oob)
 {
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
@@ -300,7 +300,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
                              int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
@@ -525,7 +525,7 @@ static void fsl_elbc_select_chip(struct mtd_info *mtd, int chip)
 static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
@@ -563,7 +563,7 @@ static void fsl_elbc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 static u8 fsl_elbc_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
 	/* If there are still bytes in the FCM, then use the next byte. */
@@ -580,7 +580,7 @@ static u8 fsl_elbc_read_byte(struct mtd_info *mtd)
 static void fsl_elbc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 	int avail;
 
@@ -604,7 +604,7 @@ static void fsl_elbc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
  */
 static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
 
 	if (elbc_fcm_ctrl->status != LTESR_CC)
@@ -619,7 +619,7 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	unsigned int al;
@@ -696,7 +696,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			      uint8_t *buf, int oob_required, int page)
 {
-	struct fsl_elbc_mtd *priv = chip->priv;
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 
@@ -770,7 +770,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	chip->controller = &elbc_fcm_ctrl->controller;
-	chip->priv = priv;
+	nand_set_controller_data(chip, priv);
 
 	chip->ecc.read_page = fsl_elbc_read_page;
 	chip->ecc.write_page = fsl_elbc_write_page;
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index f37b180..255f4bc 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -230,7 +230,7 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	int buf_num;
@@ -253,7 +253,7 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr, int oob)
 static int is_blank(struct mtd_info *mtd, unsigned int bufnum)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	u8 __iomem *addr = priv->vbase + bufnum * (mtd->writesize * 2);
 	u32 __iomem *mainarea = (u32 __iomem *)addr;
 	u8 __iomem *oob = addr + mtd->writesize;
@@ -292,7 +292,7 @@ static int check_read_ecc(struct mtd_info *mtd, struct fsl_ifc_ctrl *ctrl,
 static void fsl_ifc_run_command(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
@@ -369,7 +369,7 @@ static void fsl_ifc_do_read(struct nand_chip *chip,
 			    int oob,
 			    struct mtd_info *mtd)
 {
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 
@@ -409,7 +409,7 @@ static void fsl_ifc_do_read(struct nand_chip *chip,
 static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			     int column, int page_addr) {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 
@@ -624,7 +624,7 @@ static void fsl_ifc_select_chip(struct mtd_info *mtd, int chip)
 static void fsl_ifc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	unsigned int bufsize = mtd->writesize + mtd->oobsize;
 
 	if (len <= 0) {
@@ -650,7 +650,7 @@ static void fsl_ifc_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 static uint8_t fsl_ifc_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	unsigned int offset;
 
 	/*
@@ -673,7 +673,7 @@ static uint8_t fsl_ifc_read_byte(struct mtd_info *mtd)
 static uint8_t fsl_ifc_read_byte16(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	uint16_t data;
 
 	/*
@@ -696,7 +696,7 @@ static uint8_t fsl_ifc_read_byte16(struct mtd_info *mtd)
 static void fsl_ifc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	int avail;
 
 	if (len < 0) {
@@ -721,7 +721,7 @@ static void fsl_ifc_read_buf(struct mtd_info *mtd, u8 *buf, int len)
  */
 static int fsl_ifc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	u32 nand_fsr;
@@ -750,7 +750,7 @@ static int fsl_ifc_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			     uint8_t *buf, int oob_required, int page)
 {
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 
@@ -782,7 +782,7 @@ static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsl_ifc_mtd *priv = chip->priv;
+	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 
 	dev_dbg(priv->dev, "%s: nand->numchips = %d\n", __func__,
 							chip->numchips);
@@ -914,7 +914,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	}
 
 	chip->controller = &ifc_nand_ctrl->controller;
-	chip->priv = priv;
+	nand_set_controller_data(chip, priv);
 
 	chip->ecc.read_page = fsl_ifc_read_page;
 	chip->ecc.write_page = fsl_ifc_write_page;
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 40aa0bc..e90eafa 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -1021,7 +1021,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/* Link all private pointers */
 	mtd = nand_to_mtd(&host->nand);
 	nand = &host->nand;
-	nand->priv = host;
+	nand_set_controller_data(nand, host);
 	nand_set_flash_node(nand, np);
 
 	nand_to_mtd(&host->nand)->dev.parent = &pdev->dev;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 30c6bea..603c8bc 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -857,7 +857,7 @@ error_alloc:
 static void gpmi_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret;
 
 	/*
@@ -891,7 +891,7 @@ static void gpmi_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
 static int gpmi_dev_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	return gpmi_is_ready(this, this->current_chip);
 }
@@ -899,7 +899,7 @@ static int gpmi_dev_ready(struct mtd_info *mtd)
 static void gpmi_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	if ((this->current_chip < 0) && (chipnr >= 0))
 		gpmi_begin(this);
@@ -912,7 +912,7 @@ static void gpmi_select_chip(struct mtd_info *mtd, int chipnr)
 static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "len is %d\n", len);
 	this->upper_buf	= buf;
@@ -924,7 +924,7 @@ static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "len is %d\n", len);
 	this->upper_buf	= (uint8_t *)buf;
@@ -936,7 +936,7 @@ static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 static uint8_t gpmi_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	uint8_t *buf = this->data_buffer_dma;
 
 	gpmi_read_buf(mtd, buf, 1);
@@ -994,7 +994,7 @@ static void block_mark_swapping(struct gpmi_nand_data *this,
 static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	void          *payload_virt;
 	dma_addr_t    payload_phys;
@@ -1074,7 +1074,7 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offs, uint32_t len, uint8_t *buf, int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	void __iomem *bch_regs = this->resources.bch_regs;
 	struct bch_geometry old_geo = this->bch_geometry;
 	struct bch_geometry *geo = &this->bch_geometry;
@@ -1162,7 +1162,7 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required, int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	const void *payload_virt;
 	dma_addr_t payload_phys;
@@ -1298,7 +1298,7 @@ exit_auxiliary:
 static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "page number is %d\n", page);
 	/* clear the OOB buffer */
@@ -1359,7 +1359,7 @@ static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
 				  struct nand_chip *chip, uint8_t *buf,
 				  int oob_required, int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	int eccsize = nfc_geo->ecc_chunk_size;
 	int eccbits = nfc_geo->ecc_strength * nfc_geo->gf_len;
@@ -1448,7 +1448,7 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 				   const uint8_t *buf,
 				   int oob_required, int page)
 {
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	int eccsize = nfc_geo->ecc_chunk_size;
 	int eccbits = nfc_geo->ecc_strength * nfc_geo->gf_len;
@@ -1539,7 +1539,7 @@ static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct gpmi_nand_data *this = chip->priv;
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret = 0;
 	uint8_t *block_mark;
 	int column, page, status, chipnr;
@@ -1898,7 +1898,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	mtd->dev.parent		= this->dev;
 
 	/* init the nand_chip{}, we don't support a 16-bit NAND Flash bus. */
-	chip->priv		= this;
+	nand_set_controller_data(chip, this);
 	nand_set_flash_node(chip, this->pdev->dev.of_node);
 	chip->select_chip	= gpmi_select_chip;
 	chip->cmd_ctrl		= gpmi_cmd_ctrl;
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index fb13861..402415e 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -357,7 +357,7 @@ static int hisi_nfc_send_cmd_reset(struct hinfc_host *host, int chipselect)
 static void hisi_nfc_select_chip(struct mtd_info *mtd, int chipselect)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	if (chipselect < 0)
 		return;
@@ -368,7 +368,7 @@ static void hisi_nfc_select_chip(struct mtd_info *mtd, int chipselect)
 static uint8_t hisi_nfc_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	if (host->command == NAND_CMD_STATUS)
 		return *(uint8_t *)(host->mmio);
@@ -384,7 +384,7 @@ static uint8_t hisi_nfc_read_byte(struct mtd_info *mtd)
 static u16 hisi_nfc_read_word(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	host->offset += 2;
 	return *(u16 *)(host->buffer + host->offset - 2);
@@ -394,7 +394,7 @@ static void
 hisi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	memcpy(host->buffer + host->offset, buf, len);
 	host->offset += len;
@@ -403,7 +403,7 @@ hisi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 static void hisi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	memcpy(buf, host->buffer + host->offset, len);
 	host->offset += len;
@@ -412,7 +412,7 @@ static void hisi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void set_addr(struct mtd_info *mtd, int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 	unsigned int command = host->command;
 
 	host->addr_cycle    = 0;
@@ -448,7 +448,7 @@ static void hisi_nfc_cmdfunc(struct mtd_info *mtd, unsigned command, int column,
 		int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 	int is_cache_invalid = 1;
 	unsigned int flag = 0;
 
@@ -542,7 +542,7 @@ static irqreturn_t hinfc_irq_handle(int irq, void *devid)
 static int hisi_nand_read_page_hwecc(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
 {
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 	int max_bitflips = 0, stat = 0, stat_max = 0, status_ecc;
 	int stat_1, stat_2;
 
@@ -574,7 +574,7 @@ static int hisi_nand_read_page_hwecc(struct mtd_info *mtd,
 static int hisi_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
 {
-	struct hinfc_host *host = chip->priv;
+	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -738,7 +738,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	mtd->name		= "hisi_nand";
 	mtd->dev.parent         = &pdev->dev;
 
-	chip->priv		= host;
+	nand_set_controller_data(chip, host);
 	nand_set_flash_node(chip, np);
 	chip->cmdfunc		= hisi_nfc_cmdfunc;
 	chip->select_chip	= hisi_nfc_select_chip;
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index e000106..30e3f33 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -275,7 +275,7 @@ static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				  unsigned int ctrl)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = nand_chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
@@ -291,7 +291,7 @@ static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = nand_chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if ((readb(MLC_ISR(host->io_base)) &
 	     (MLCISR_CONTROLLER_READY | MLCISR_NAND_READY)) ==
@@ -317,7 +317,7 @@ static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
 
 static int lpc32xx_waitfunc_nand(struct mtd_info *mtd, struct nand_chip *chip)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	if (readb(MLC_ISR(host->io_base)) & MLCISR_NAND_READY)
 		goto exit;
@@ -337,7 +337,7 @@ exit:
 static int lpc32xx_waitfunc_controller(struct mtd_info *mtd,
 				       struct nand_chip *chip)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	if (readb(MLC_ISR(host->io_base)) & MLCISR_CONTROLLER_READY)
 		goto exit;
@@ -389,7 +389,7 @@ static int lpc32xx_xmit_dma(struct mtd_info *mtd, void *mem, int len,
 			    enum dma_transfer_direction dir)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	struct dma_async_tx_descriptor *desc;
 	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	int res;
@@ -430,7 +430,7 @@ out1:
 static int lpc32xx_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			     uint8_t *buf, int oob_required, int page)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int i, j;
 	uint8_t *oobbuf = chip->oob_poi;
 	uint32_t mlc_isr;
@@ -497,7 +497,7 @@ static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 				       const uint8_t *buf, int oob_required,
 				       int page)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	const uint8_t *oobbuf = chip->oob_poi;
 	uint8_t *dma_buf = (uint8_t *)buf;
 	int res;
@@ -542,7 +542,7 @@ static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 static int lpc32xx_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			    int page)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Read whole page - necessary with MLC controller! */
 	lpc32xx_read_page(mtd, chip, host->dummy_buf, 1, page);
@@ -679,7 +679,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->pdata = dev_get_platdata(&pdev->dev);
 
-	nand_chip->priv = host;		/* link the private data structures */
+	nand_set_controller_data(nand_chip, host);		/* link the private data structures */
 	nand_set_flash_node(nand_chip, pdev->dev.of_node);
 	mtd->dev.parent = &pdev->dev;
 
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 016641b..c792536 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -260,7 +260,7 @@ static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 {
 	uint32_t tmp;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Does CE state need to be changed? */
 	tmp = readl(SLC_CFG(host->io_base));
@@ -284,7 +284,7 @@ static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int rdy = 0;
 
 	if ((readl(SLC_STAT(host->io_base)) & SLCSTAT_NAND_READY) != 0)
@@ -339,7 +339,7 @@ static int lpc32xx_nand_ecc_calculate(struct mtd_info *mtd,
 static uint8_t lpc32xx_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	return (uint8_t)readl(SLC_DATA(host->io_base));
 }
@@ -350,7 +350,7 @@ static uint8_t lpc32xx_nand_read_byte(struct mtd_info *mtd)
 static void lpc32xx_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Direct device read with no ECC */
 	while (len-- > 0)
@@ -363,7 +363,7 @@ static void lpc32xx_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 static void lpc32xx_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Direct device write with no ECC */
 	while (len-- > 0)
@@ -428,7 +428,7 @@ static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
 			    void *mem, int len, enum dma_transfer_direction dir)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	struct dma_async_tx_descriptor *desc;
 	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	int res;
@@ -488,7 +488,7 @@ static int lpc32xx_xfer(struct mtd_info *mtd, uint8_t *buf, int eccsubpages,
 			int read)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int i, status = 0;
 	unsigned long timeout;
 	int res;
@@ -603,7 +603,7 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 					   struct nand_chip *chip, uint8_t *buf,
 					   int oob_required, int page)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int stat, i, status;
 	uint8_t *oobecc, tmpecc[LPC32XX_ECC_SAVE_SIZE];
 
@@ -665,7 +665,7 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 					    const uint8_t *buf,
 					    int oob_required, int page)
 {
-	struct lpc32xx_nand_host *host = chip->priv;
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	uint8_t *pb = chip->oob_poi + chip->ecc.layout->eccpos[0];
 	int error;
 
@@ -800,7 +800,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	mtd = nand_to_mtd(&host->nand_chip);
 	chip = &host->nand_chip;
-	chip->priv = host;
+	nand_set_controller_data(chip, host);
 	nand_set_flash_node(chip, pdev->dev.of_node);
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = &pdev->dev;
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index efdb647..d2946f1 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -135,7 +135,7 @@ static void mpc5121_nfc_done(struct mtd_info *mtd);
 static inline u16 nfc_read(struct mtd_info *mtd, uint reg)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	return in_be16(prv->regs + reg);
 }
@@ -144,7 +144,7 @@ static inline u16 nfc_read(struct mtd_info *mtd, uint reg)
 static inline void nfc_write(struct mtd_info *mtd, uint reg, u16 val)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	out_be16(prv->regs + reg, val);
 }
@@ -214,7 +214,7 @@ static irqreturn_t mpc5121_nfc_irq(int irq, void *data)
 {
 	struct mtd_info *mtd = data;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	nfc_set(mtd, NFC_CONFIG1, NFC_INT_MASK);
 	wake_up(&prv->irq_waitq);
@@ -226,7 +226,7 @@ static irqreturn_t mpc5121_nfc_irq(int irq, void *data)
 static void mpc5121_nfc_done(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 	int rv;
 
 	if ((nfc_read(mtd, NFC_CONFIG2) & NFC_INT) == 0) {
@@ -281,7 +281,7 @@ static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)
 static int ads5121_chipselect_init(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 	struct device_node *dn;
 
 	dn = of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-cpld");
@@ -303,7 +303,7 @@ static int ads5121_chipselect_init(struct mtd_info *mtd)
 static void ads5121_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = nand->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(nand);
 	u8 v;
 
 	v = in_8(prv->csreg);
@@ -333,7 +333,7 @@ static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,
 							int column, int page)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	prv->column = (column >= 0) ? column : 0;
 	prv->spareonly = 0;
@@ -406,7 +406,7 @@ static void mpc5121_nfc_copy_spare(struct mtd_info *mtd, uint offset,
 						u8 *buffer, uint size, int wr)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = nand->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(nand);
 	uint o, s, sbsize, blksize;
 
 	/*
@@ -458,7 +458,7 @@ static void mpc5121_nfc_buf_copy(struct mtd_info *mtd, u_char *buf, int len,
 									int wr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 	uint c = prv->column;
 	uint l;
 
@@ -536,7 +536,7 @@ static u16 mpc5121_nfc_read_word(struct mtd_info *mtd)
 static int mpc5121_nfc_read_hw_config(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 	struct mpc512x_reset_module *rm;
 	struct device_node *rmnode;
 	uint rcw_pagesize = 0;
@@ -615,7 +615,7 @@ out:
 static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mpc5121_nfc_prv *prv = chip->priv;
+	struct mpc5121_nfc_prv *prv = nand_get_controller_data(chip);
 
 	if (prv->clk)
 		clk_disable_unprepare(prv->clk);
@@ -657,7 +657,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	chip = &prv->chip;
 
 	mtd->dev.parent = dev;
-	chip->priv = prv;
+	nand_set_controller_data(chip, prv);
 	nand_set_flash_node(chip, dn);
 	prv->dev = dev;
 
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index d6c25cd..68817f1 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -532,7 +532,7 @@ static void send_addr_v1_v2(struct mxc_nand_host *host, uint16_t addr, int islas
 static void send_page_v3(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint32_t tmp;
 
 	tmp = readl(NFC_V3_CONFIG1);
@@ -548,7 +548,7 @@ static void send_page_v3(struct mtd_info *mtd, unsigned int ops)
 static void send_page_v2(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	/* NANDFC buffer 0 is used for page read/write */
 	writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
@@ -562,7 +562,7 @@ static void send_page_v2(struct mtd_info *mtd, unsigned int ops)
 static void send_page_v1(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	int bufs, i;
 
 	if (mtd->writesize > 512)
@@ -663,7 +663,7 @@ static int mxc_nand_correct_data_v1(struct mtd_info *mtd, u_char *dat,
 				 u_char *read_ecc, u_char *calc_ecc)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	/*
 	 * 1-Bit errors are automatically corrected in HW.  No need for
@@ -684,7 +684,7 @@ static int mxc_nand_correct_data_v2_v3(struct mtd_info *mtd, u_char *dat,
 				 u_char *read_ecc, u_char *calc_ecc)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	u32 ecc_stat, err;
 	int no_subpages = 1;
 	int ret = 0;
@@ -722,7 +722,7 @@ static int mxc_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint8_t ret;
 
 	/* Check for status request */
@@ -746,7 +746,7 @@ static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 static uint16_t mxc_nand_read_word(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint16_t ret;
 
 	ret = *(uint16_t *)(host->data_buf + host->buf_start);
@@ -762,7 +762,7 @@ static void mxc_nand_write_buf(struct mtd_info *mtd,
 				const u_char *buf, int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	u16 col = host->buf_start;
 	int n = mtd->oobsize + mtd->writesize - col;
 
@@ -780,7 +780,7 @@ static void mxc_nand_write_buf(struct mtd_info *mtd,
 static void mxc_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	u16 col = host->buf_start;
 	int n = mtd->oobsize + mtd->writesize - col;
 
@@ -796,7 +796,7 @@ static void mxc_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 static void mxc_nand_select_chip_v1_v3(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (chip == -1) {
 		/* Disable the NFC clock */
@@ -817,7 +817,7 @@ static void mxc_nand_select_chip_v1_v3(struct mtd_info *mtd, int chip)
 static void mxc_nand_select_chip_v2(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (chip == -1) {
 		/* Disable the NFC clock */
@@ -850,7 +850,7 @@ static void mxc_nand_select_chip_v2(struct mtd_info *mtd, int chip)
 static void copy_spare(struct mtd_info *mtd, bool bfrom)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = this->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(this);
 	u16 i, oob_chunk_size;
 	u16 num_chunks = mtd->writesize / 512;
 
@@ -893,7 +893,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	/* Write out column address, if necessary */
 	if (column != -1) {
@@ -979,7 +979,7 @@ static void ecc_8bit_layout_4k(struct nand_ecclayout *layout)
 static void preset_v1(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint16_t config1 = 0;
 
 	if (nand_chip->ecc.mode == NAND_ECC_HW && mtd->writesize)
@@ -1007,7 +1007,7 @@ static void preset_v1(struct mtd_info *mtd)
 static void preset_v2(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 	uint16_t config1 = 0;
 
 	config1 |= NFC_V2_CONFIG1_FP_INT;
@@ -1053,7 +1053,7 @@ static void preset_v2(struct mtd_info *mtd)
 static void preset_v3(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	uint32_t config2, config3;
 	int i, addr_phases;
 
@@ -1125,7 +1125,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_chip->priv;
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	pr_debug("mxc_nand_command (cmd = 0x%x, col = 0x%x, page = 0x%x)\n",
 	      command, column, page_addr);
@@ -1521,7 +1521,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	/* 50 us command delay time */
 	this->chip_delay = 5;
 
-	this->priv = host;
+	nand_set_controller_data(this, host);
 	nand_set_flash_node(this, pdev->dev.of_node),
 	this->dev_ready = mxc_nand_dev_ready;
 	this->cmdfunc = mxc_nand_command;
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 442eeaf..f7e0d2c 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -667,7 +667,7 @@ static char *get_partition_name(int i)
 static int init_nandsim(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct nandsim   *ns   = chip->priv;
+	struct nandsim   *ns   = nand_get_controller_data(chip);
 	int i, ret = 0;
 	uint64_t remains;
 	uint64_t next_offset;
@@ -2245,7 +2245,7 @@ static int __init ns_init_module(void)
 	nsmtd       = nand_to_mtd(chip);
         nsmtd->priv = (void *)chip;
 	nand        = (struct nandsim *)(chip + 1);
-	chip->priv  = (void *)nand;
+	nand_set_controller_data(chip, (void *)nand);
 
 	/*
 	 * Register simulator's callbacks.
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 6962f3b..2b8a793 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -48,7 +48,7 @@ static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 {
 	uint32_t ccr;
 	struct nand_chip *nchip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = nchip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(nchip);
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	if (chip >= 0) {
@@ -62,7 +62,7 @@ static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	if (cmd == NAND_CMD_NONE)
 		return;
@@ -76,7 +76,7 @@ static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 static int ndfc_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	return in_be32(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
 }
@@ -85,7 +85,7 @@ static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	uint32_t ccr;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	ccr |= NDFC_CCR_RESET_ECC;
@@ -97,7 +97,7 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 			      const u_char *dat, u_char *ecc_code)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t ecc;
 	uint8_t *p = (uint8_t *)&ecc;
 
@@ -121,7 +121,7 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -131,7 +131,7 @@ static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct ndfc_controller *ndfc = chip->priv;
+	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -164,7 +164,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->ecc.size = 256;
 	chip->ecc.bytes = 3;
 	chip->ecc.strength = 1;
-	chip->priv = ndfc;
+	nand_set_controller_data(chip, ndfc);
 
 	nand_to_mtd(&ndfc->chip)->priv = chip;
 	nand_to_mtd(&ndfc->chip)->dev.parent = &ndfc->ofdev->dev;
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 2c2be61..d4614bf 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -26,7 +26,7 @@
 static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *nc = mtd_to_nand(mtd);
-	struct orion_nand_data *board = nc->priv;
+	struct orion_nand_data *board = nand_get_controller_data(nc);
 	u32 offs;
 
 	if (cmd == NAND_CMD_NONE)
@@ -124,7 +124,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 
 	mtd->dev.parent = &pdev->dev;
 
-	nc->priv = board;
+	nand_set_controller_data(nc, board);
 	nand_set_flash_node(nc, pdev->dev.of_node);
 	nc->IO_ADDR_R = nc->IO_ADDR_W = io_base;
 	nc->cmd_ctrl = orion_nand_cmd_ctrl;
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 789c4fa..95ffedb 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -55,7 +55,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(data->io_base))
 		return PTR_ERR(data->io_base);
 
-	data->chip.priv = &data;
+	nand_set_controller_data(&data->chip, &data);
 	nand_set_flash_node(&data->chip, pdev->dev.of_node);
 	nand_to_mtd(&data->chip)->priv = &data->chip;
 	nand_to_mtd(&data->chip)->dev.parent = &pdev->dev;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 8bb9057..3e24ed5 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1119,7 +1119,7 @@ static void nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			 int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	int exec_cmd;
 
@@ -1168,7 +1168,7 @@ static void nand_cmdfunc_extended(struct mtd_info *mtd,
 				  int column, int page_addr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	int exec_cmd, ext_cmd_type;
 
@@ -1288,7 +1288,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int oob_required,
 		int page)
 {
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
@@ -1315,7 +1315,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	char retval = 0xFF;
 
@@ -1329,7 +1329,7 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	u16 retval = 0xFFFF;
 
@@ -1343,7 +1343,7 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
@@ -1355,7 +1355,7 @@ static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 		const uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
@@ -1371,7 +1371,7 @@ static void pxa3xx_nand_select_chip(struct mtd_info *mtd, int chip)
 static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 
 	if (info->need_wait) {
@@ -1588,7 +1588,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
 	struct pxa3xx_nand_info *info = host->info_data;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -1727,7 +1727,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	for (cs = 0; cs < pdata->num_cs; cs++) {
 		host = (void *)&info[1] + sizeof(*host) * cs;
 		chip = &host->chip;
-		chip->priv = host;
+		nand_set_controller_data(chip, host);
 		mtd = nand_to_mtd(chip);
 		info->host[cs] = host;
 		host->cs = cs;
@@ -1736,7 +1736,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		/* FIXME: all chips use the same device tree partitions */
 		nand_set_flash_node(chip, np);
 
-		chip->priv = host;
+		nand_set_controller_data(chip, host);
 		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
 		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
 		chip->controller        = &info->controller;
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index f969d26..2263580 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -65,7 +65,7 @@ static inline void r852_write_reg_dword(struct r852_device *dev,
 static inline struct r852_device *r852_get_dev(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	return chip->priv;
+	return nand_get_controller_data(chip);
 }
 
 
@@ -361,7 +361,7 @@ static void r852_cmdctl(struct mtd_info *mtd, int dat, unsigned int ctrl)
  */
 static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
-	struct r852_device *dev = chip->priv;
+	struct r852_device *dev = nand_get_controller_data(chip);
 
 	unsigned long timeout;
 	int status;
@@ -879,7 +879,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	if (!dev)
 		goto error5;
 
-	chip->priv = dev;
+	nand_set_controller_data(chip, dev);
 	dev->chip = chip;
 	dev->pci_dev = pci_dev;
 	pci_set_drvdata(pci_dev, dev);
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 9f6423d..2e05b63 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -385,7 +385,7 @@ static void s3c2410_nand_select_chip(struct mtd_info *mtd, int chip)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long cur;
 
-	nmtd = this->priv;
+	nmtd = nand_get_controller_data(this);
 	info = nmtd->info;
 
 	if (chip != -1)
@@ -793,7 +793,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->read_buf     = s3c2410_nand_read_buf;
 	chip->select_chip  = s3c2410_nand_select_chip;
 	chip->chip_delay   = 50;
-	chip->priv	   = nmtd;
+	nand_set_controller_data(chip, nmtd);
 	chip->options	   = set->options;
 	chip->controller   = &info->controller;
 
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index b009d75..9c1e6a7 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -45,7 +45,7 @@ static void socrates_nand_write_buf(struct mtd_info *mtd,
 {
 	int i;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct socrates_nand_host *host = this->priv;
+	struct socrates_nand_host *host = nand_get_controller_data(this);
 
 	for (i = 0; i < len; i++) {
 		out_be32(host->io_base, FPGA_NAND_ENABLE |
@@ -64,7 +64,7 @@ static void socrates_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	int i;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct socrates_nand_host *host = this->priv;
+	struct socrates_nand_host *host = nand_get_controller_data(this);
 	uint32_t val;
 
 	val = FPGA_NAND_ENABLE | FPGA_NAND_CMD_READ;
@@ -105,7 +105,7 @@ static void socrates_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 		unsigned int ctrl)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct socrates_nand_host *host = nand_chip->priv;
+	struct socrates_nand_host *host = nand_get_controller_data(nand_chip);
 	uint32_t val;
 
 	if (cmd == NAND_CMD_NONE)
@@ -130,7 +130,7 @@ static void socrates_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 static int socrates_nand_device_ready(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct socrates_nand_host *host = nand_chip->priv;
+	struct socrates_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (in_be32(host->io_base) & FPGA_NAND_BUSY)
 		return 0; /* busy */
@@ -162,7 +162,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	nand_chip = &host->nand_chip;
 	host->dev = &ofdev->dev;
 
-	nand_chip->priv = host;		/* link the private data structures */
+	nand_set_controller_data(nand_chip, host);		/* link the private data structures */
 	nand_set_flash_node(nand_chip, ofdev->dev.of_node);
 	mtd->name = "socrates_nand";
 	mtd->dev.parent = &ofdev->dev;
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index da74a1d..abce8ef 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -79,7 +79,7 @@ struct txx9ndfmc_drvdata {
 static struct platform_device *mtd_to_platdev(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct txx9ndfmc_priv *txx9_priv = chip->priv;
+	struct txx9ndfmc_priv *txx9_priv = nand_get_controller_data(chip);
 	return txx9_priv->dev;
 }
 
@@ -135,7 +135,7 @@ static void txx9ndfmc_cmd_ctrl(struct mtd_info *mtd, int cmd,
 			       unsigned int ctrl)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct txx9ndfmc_priv *txx9_priv = chip->priv;
+	struct txx9ndfmc_priv *txx9_priv = nand_get_controller_data(chip);
 	struct platform_device *dev = txx9_priv->dev;
 	struct txx9ndfmc_platform_data *plat = dev_get_platdata(&dev->dev);
 
@@ -340,7 +340,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		chip->chip_delay = 100;
 		chip->controller = &drvdata->hw_control;
 
-		chip->priv = txx9_priv;
+		nand_set_controller_data(chip, txx9_priv);
 		txx9_priv->dev = dev;
 
 		if (plat->ch_mask != 1) {
@@ -389,7 +389,7 @@ static int __exit txx9ndfmc_remove(struct platform_device *dev)
 		if (!mtd)
 			continue;
 		chip = mtd_to_nand(mtd);
-		txx9_priv = chip->priv;
+		txx9_priv = nand_get_controller_data(chip);
 
 		nand_release(mtd);
 		kfree(txx9_priv->mtdname);
-- 
2.1.4
