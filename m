From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 14/27] mtd: nand: use the mtd instance embedded
 in struct nand_chip
Date: Mon, 16 Nov 2015 14:37:47 +0100
Message-ID: <1447681080-31232-15-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBU5YU6ZAKGQEMDDMR7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

struct nand_chip now embeds an mtd device. Patch all drivers to make use
of this mtd instance instead of using the instance embedded in their
private struct or dynamically allocated.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
---
Most of those changes were generate with this coccinelle script:
http://code.bulix.org/5vxuih-89429
---
 drivers/mtd/nand/ams-delta.c                   | 13 ++--
 drivers/mtd/nand/atmel_nand.c                  | 11 ++-
 drivers/mtd/nand/au1550nd.c                    | 18 ++---
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |  1 -
 drivers/mtd/nand/bcm47xxnflash/main.c          |  7 +-
 drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  2 +-
 drivers/mtd/nand/bf5xx_nand.c                  | 14 ++--
 drivers/mtd/nand/brcmnand/brcmnand.c           | 11 ++-
 drivers/mtd/nand/cafe_nand.c                   | 10 +--
 drivers/mtd/nand/cmx270_nand.c                 | 11 ++-
 drivers/mtd/nand/cs553x_nand.c                 | 13 ++--
 drivers/mtd/nand/davinci_nand.c                | 25 +++----
 drivers/mtd/nand/denali.c                      | 61 +++++++++--------
 drivers/mtd/nand/denali.h                      |  1 -
 drivers/mtd/nand/diskonchip.c                  | 11 ++-
 drivers/mtd/nand/docg4.c                       | 18 +++--
 drivers/mtd/nand/fsl_elbc_nand.c               | 22 +++---
 drivers/mtd/nand/fsl_ifc_nand.c                | 23 +++----
 drivers/mtd/nand/fsl_upm.c                     | 26 +++----
 drivers/mtd/nand/fsmc_nand.c                   | 59 +++++++++-------
 drivers/mtd/nand/gpio.c                        | 16 ++---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c         | 20 +++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |  1 -
 drivers/mtd/nand/hisi504_nand.c                | 11 ++-
 drivers/mtd/nand/jz4740_nand.c                 |  9 ++-
 drivers/mtd/nand/lpc32xx_mlc.c                 |  7 +-
 drivers/mtd/nand/lpc32xx_slc.c                 |  7 +-
 drivers/mtd/nand/mpc5121_nfc.c                 |  3 +-
 drivers/mtd/nand/mxc_nand.c                    |  5 +-
 drivers/mtd/nand/nandsim.c                     | 12 ++--
 drivers/mtd/nand/ndfc.c                        | 22 +++---
 drivers/mtd/nand/nuc900_nand.c                 | 21 +++---
 drivers/mtd/nand/omap2.c                       | 94 +++++++++++++++-----------
 drivers/mtd/nand/orion_nand.c                  |  4 +-
 drivers/mtd/nand/pasemi_nand.c                 | 14 ++--
 drivers/mtd/nand/plat_nand.c                   | 14 ++--
 drivers/mtd/nand/pxa3xx_nand.c                 | 33 ++++-----
 drivers/mtd/nand/r852.c                        | 34 ++++------
 drivers/mtd/nand/r852.h                        |  1 -
 drivers/mtd/nand/s3c2410.c                     | 19 +++---
 drivers/mtd/nand/sh_flctl.c                    |  8 +--
 drivers/mtd/nand/sharpsl.c                     | 18 ++---
 drivers/mtd/nand/socrates_nand.c               |  5 +-
 drivers/mtd/nand/sunxi_nand.c                  | 13 ++--
 drivers/mtd/nand/tmio_nand.c                   |  7 +-
 drivers/mtd/nand/txx9ndfmc.c                   |  3 +-
 drivers/mtd/nand/vf610_nfc.c                   |  5 +-
 include/linux/mtd/sh_flctl.h                   |  3 +-
 49 files changed, 383 insertions(+), 385 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index b2b49c4..0f638c6 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -183,19 +183,16 @@ static int ams_delta_init(struct platform_device *pdev)
 		return -ENXIO;
 
 	/* Allocate memory for MTD device structure and private data */
-	ams_delta_mtd = kzalloc(sizeof(struct mtd_info) +
-				sizeof(struct nand_chip), GFP_KERNEL);
-	if (!ams_delta_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
+	ams_delta_mtd = nand_to_mtd(this);
 	ams_delta_mtd->owner = THIS_MODULE;
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *) (&ams_delta_mtd[1]);
-
 	/* Link the private data with the MTD structure */
 	ams_delta_mtd->priv = this;
 
@@ -256,7 +253,7 @@ out_gpio:
 	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
-	kfree(ams_delta_mtd);
+	kfree(this);
  out:
 	return err;
 }
@@ -276,7 +273,7 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-	kfree(ams_delta_mtd);
+	kfree(mtd_to_nand(ams_delta_mtd));
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index f8aac0a..51748b4 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -116,7 +116,6 @@ static struct atmel_nfc	nand_nfc;
 
 struct atmel_nand_host {
 	struct nand_chip	nand_chip;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	dma_addr_t		io_phys;
 	struct atmel_nand_data	board;
@@ -318,7 +317,7 @@ static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
 
 	if (bank) {
 		/* Only for a 2k-page or lower flash, NFC can handle 2 banks */
-		if (host->mtd.writesize > 2048)
+		if (nand_to_mtd(&host->nand_chip)->writesize > 2048)
 			return -EINVAL;
 		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
 	} else {
@@ -1159,7 +1158,7 @@ static uint16_t *create_lookup_table(struct device *dev, int sector_size)
 static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	struct nand_chip *nand_chip = &host->nand_chip;
 	struct resource *regs, *regs_pmerr, *regs_rom;
 	uint16_t *galois_table;
@@ -1586,7 +1585,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 static int atmel_hw_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	struct nand_chip *nand_chip = &host->nand_chip;
 	struct resource		*regs;
 
@@ -2112,7 +2111,7 @@ static int atmel_nand_probe(struct platform_device *pdev)
 	}
 	host->io_phys = (dma_addr_t)mem->start;
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand_chip);
 	nand_chip = &host->nand_chip;
 	host->dev = &pdev->dev;
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
@@ -2283,7 +2282,7 @@ err_nand_ioremap:
 static int atmel_nand_remove(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 73fceb8..7e2a376 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -23,7 +23,6 @@
 
 
 struct au1550nd_ctx {
-	struct mtd_info info;
 	struct nand_chip chip;
 
 	int cs;
@@ -197,7 +196,8 @@ static void au_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 
 static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 {
-	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
+	struct au1550nd_ctx *ctx = container_of(mtd_to_nand(mtd),
+						struct au1550nd_ctx, chip);
 	struct nand_chip *this = mtd_to_nand(mtd);
 
 	switch (cmd) {
@@ -267,7 +267,8 @@ static void au1550_select_chip(struct mtd_info *mtd, int chip)
  */
 static void au1550_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
 {
-	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
+	struct au1550nd_ctx *ctx = container_of(mtd_to_nand(mtd),
+						struct au1550nd_ctx, chip);
 	struct nand_chip *this = mtd_to_nand(mtd);
 	int ce_override = 0, i;
 	unsigned long flags = 0;
@@ -438,8 +439,8 @@ static int au1550nd_probe(struct platform_device *pdev)
 	}
 
 	this = &ctx->chip;
-	ctx->info.priv = this;
-	ctx->info.dev.parent = &pdev->dev;
+	nand_to_mtd(&ctx->chip)->priv = this;
+	nand_to_mtd(&ctx->chip)->dev.parent = &pdev->dev;
 
 	/* figure out which CS# r->start belongs to */
 	cs = find_nand_cs(r->start);
@@ -467,13 +468,14 @@ static int au1550nd_probe(struct platform_device *pdev)
 	this->write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
 	this->read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
 
-	ret = nand_scan(&ctx->info, 1);
+	ret = nand_scan(nand_to_mtd(&ctx->chip), 1);
 	if (ret) {
 		dev_err(&pdev->dev, "NAND scan failed with %d\n", ret);
 		goto out3;
 	}
 
-	mtd_device_register(&ctx->info, pd->parts, pd->num_parts);
+	mtd_device_register(nand_to_mtd(&ctx->chip), pd->parts,
+			    pd->num_parts);
 
 	platform_set_drvdata(pdev, ctx);
 
@@ -493,7 +495,7 @@ static int au1550nd_remove(struct platform_device *pdev)
 	struct au1550nd_ctx *ctx = platform_get_drvdata(pdev);
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	nand_release(&ctx->info);
+	nand_release(nand_to_mtd(&ctx->chip));
 	iounmap(ctx->base);
 	release_mem_region(r->start, 0x1000);
 	kfree(ctx);
diff --git a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
index c005a62..8ea7571 100644
--- a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
+++ b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
@@ -12,7 +12,6 @@ struct bcm47xxnflash {
 	struct bcma_drv_cc *cc;
 
 	struct nand_chip nand_chip;
-	struct mtd_info mtd;
 
 	unsigned curr_command;
 	int curr_page_addr;
diff --git a/drivers/mtd/nand/bcm47xxnflash/main.c b/drivers/mtd/nand/bcm47xxnflash/main.c
index 9ba0c0f..f3476fa 100644
--- a/drivers/mtd/nand/bcm47xxnflash/main.c
+++ b/drivers/mtd/nand/bcm47xxnflash/main.c
@@ -34,8 +34,8 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	b47n->nand_chip.priv = b47n;
-	b47n->mtd.dev.parent = &pdev->dev;
-	b47n->mtd.priv = &b47n->nand_chip; /* Required */
+	nand_to_mtd(&b47n->nand_chip)->dev.parent = &pdev->dev;
+	nand_to_mtd(&b47n->nand_chip)->priv = &b47n->nand_chip; /* Required */
 	b47n->cc = container_of(nflash, struct bcma_drv_cc, nflash);
 
 	if (b47n->cc->core->bus->chipinfo.id == BCMA_CHIP_ID_BCM4706) {
@@ -49,7 +49,8 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = mtd_device_parse_register(&b47n->mtd, probes, NULL, NULL, 0);
+	err = mtd_device_parse_register(nand_to_mtd(&b47n->nand_chip),
+					probes, NULL, NULL, 0);
 	if (err) {
 		pr_err("Failed to register MTD device: %d\n", err);
 		return err;
diff --git a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
index e5b2e48..6524780 100644
--- a/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c
@@ -421,7 +421,7 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 			(w4 << 24 | w3 << 18 | w2 << 12 | w1 << 6 | w0));
 
 	/* Scan NAND */
-	err = nand_scan(&b47n->mtd, 1);
+	err = nand_scan(nand_to_mtd(&b47n->nand_chip), 1);
 	if (err) {
 		pr_err("Could not scan NAND flash: %d\n", err);
 		goto exit;
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index d9da5ed..671d983 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -142,7 +142,6 @@ static struct nand_ecclayout bootrom_ecclayout = {
 struct bf5xx_nand_info {
 	/* mtd info */
 	struct nand_hw_control		controller;
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 
 	/* platform info */
@@ -160,7 +159,8 @@ struct bf5xx_nand_info {
  */
 static struct bf5xx_nand_info *mtd_to_nand_info(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct bf5xx_nand_info, mtd);
+	return container_of(mtd_to_nand(mtd), struct bf5xx_nand_info,
+			    chip);
 }
 
 static struct bf5xx_nand_info *to_nand_info(struct platform_device *pdev)
@@ -660,7 +660,7 @@ static int bf5xx_nand_hw_init(struct bf5xx_nand_info *info)
  */
 static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
 {
-	struct mtd_info *mtd = &info->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&info->chip);
 	struct mtd_partition *parts = info->platform->partitions;
 	int nr = info->platform->nr_partitions;
 
@@ -675,7 +675,7 @@ static int bf5xx_nand_remove(struct platform_device *pdev)
 	 * and their partitions, then go through freeing the
 	 * resources used
 	 */
-	nand_release(&info->mtd);
+	nand_release(nand_to_mtd(&info->chip));
 
 	peripheral_free_list(bfin_nfc_pin_req);
 	bf5xx_nand_dma_remove(info);
@@ -772,7 +772,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl     = bf5xx_nand_hwcontrol;
 	chip->dev_ready    = bf5xx_nand_devready;
 
-	chip->priv	   = &info->mtd;
+	chip->priv	   = nand_to_mtd(&info->chip);
 	chip->controller   = &info->controller;
 
 	chip->IO_ADDR_R    = (void __iomem *) NFC_READ;
@@ -781,9 +781,9 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->chip_delay   = 0;
 
 	/* initialise mtd info data struct */
-	mtd 		= &info->mtd;
+	mtd		= nand_to_mtd(&info->chip);
 	mtd->priv	= chip;
-	mtd->dev.parent = &pdev->dev;
+	mtd->dev.parent	= &pdev->dev;
 
 	/* initialise the hardware */
 	err = bf5xx_nand_hw_init(info);
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index ed67aae..20ebf00 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -179,7 +179,6 @@ struct brcmnand_host {
 	struct device_node	*of_node;
 
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	struct platform_device	*pdev;
 	int			cs;
 
@@ -1075,7 +1074,7 @@ static int brcmnand_low_level_op(struct brcmnand_host *host,
 				 enum brcmnand_llop_type type, u32 data,
 				 bool last_op)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u32 tmp;
@@ -1806,7 +1805,7 @@ static inline int get_blk_adr_bytes(u64 size, u32 writesize)
 
 static int brcmnand_setup_dev(struct brcmnand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
@@ -1921,7 +1920,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 		return -ENXIO;
 	}
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->chip);
 	chip = &host->chip;
 
 	nand_set_flash_node(chip, dn);
@@ -2066,7 +2065,7 @@ static int brcmnand_resume(struct device *dev)
 	}
 
 	list_for_each_entry(host, &ctrl->host_list, node) {
-		struct mtd_info *mtd = &host->mtd;
+		struct mtd_info *mtd = nand_to_mtd(&host->chip);
 		struct nand_chip *chip = mtd->priv;
 
 		brcmnand_save_restore_cs_config(host, 1);
@@ -2265,7 +2264,7 @@ int brcmnand_remove(struct platform_device *pdev)
 	struct brcmnand_host *host;
 
 	list_for_each_entry(host, &ctrl->host_list, node)
-		nand_release(&host->mtd);
+		nand_release(nand_to_mtd(&host->chip));
 
 	dev_set_drvdata(&pdev->dev, NULL);
 
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 77c92f1..1d3a66c 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -605,15 +605,15 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	mtd = kzalloc(sizeof(*mtd) + sizeof(struct cafe_priv), GFP_KERNEL);
-	if (!mtd)
+	cafe = kzalloc(sizeof(*cafe), GFP_KERNEL);
+	if (!cafe)
 		return  -ENOMEM;
-	cafe = (void *)(&mtd[1]);
 
+	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
 	mtd->priv = &cafe->nand;
-	cafe->nand.priv = cafe;
 
+	cafe->nand.priv = cafe;
 	cafe->pdev = pdev;
 	cafe->mmio = pci_iomap(pdev, 0, 0);
 	if (!cafe->mmio) {
@@ -813,7 +813,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 			2112 + sizeof(struct nand_buffers) +
 			mtd->writesize + mtd->oobsize,
 			cafe->dmabuf, cafe->dmaaddr);
-	kfree(mtd);
+	kfree(cafe);
 }
 
 static const struct pci_device_id cafe_nand_tbl[] = {
diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index 43bded6..84d027e 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -160,10 +160,8 @@ static int __init cmx270_init(void)
 	gpio_direction_input(GPIO_NAND_RB);
 
 	/* Allocate memory for MTD device structure and private data */
-	cmx270_nand_mtd = kzalloc(sizeof(struct mtd_info) +
-				  sizeof(struct nand_chip),
-				  GFP_KERNEL);
-	if (!cmx270_nand_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		ret = -ENOMEM;
 		goto err_kzalloc;
 	}
@@ -175,8 +173,7 @@ static int __init cmx270_init(void)
 		goto err_ioremap;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&cmx270_nand_mtd[1]);
+	cmx270_nand_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
 	cmx270_nand_mtd->owner = THIS_MODULE;
@@ -241,7 +238,7 @@ static void __exit cmx270_cleanup(void)
 	iounmap(cmx270_nand_io);
 
 	/* Free the MTD device structure */
-	kfree (cmx270_nand_mtd);
+	kfree(mtd_to_nand(cmx270_nand_mtd));
 }
 module_exit(cmx270_cleanup);
 
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 9537bbe..ea51a9c 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -197,14 +197,13 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	}
 
 	/* Allocate memory for MTD device structure and private data */
-	new_mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!new_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&new_mtd[1]);
+	new_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
 	new_mtd->priv = this;
@@ -337,12 +336,12 @@ static void __exit cs553x_cleanup(void)
 		if (!mtd)
 			continue;
 
-		this = cs553x_mtd[i]->priv;
+		this = mtd_to_nand(mtd);
 		mmio_base = this->IO_ADDR_R;
 
 		/* Release resources, unregister device */
-		nand_release(cs553x_mtd[i]);
-		kfree(cs553x_mtd[i]->name);
+		nand_release(mtd);
+		kfree(mtd->name);
 		cs553x_mtd[i] = NULL;
 
 		/* unmap physical address */
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index b5978d5..0cf04bb 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -53,7 +53,6 @@
  * outputs in a "wire-AND" configuration, with no per-chip signals.
  */
 struct davinci_nand_info {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 	struct nand_ecclayout	ecclayout;
 
@@ -80,7 +79,7 @@ struct davinci_nand_info {
 static DEFINE_SPINLOCK(davinci_nand_lock);
 static bool ecc4_busy;
 
-#define to_davinci_nand(m) container_of(m, struct davinci_nand_info, mtd)
+#define to_davinci_nand(m) container_of(mtd_to_nand(m), struct davinci_nand_info, chip)
 
 
 static inline unsigned int davinci_nand_readl(struct davinci_nand_info *info,
@@ -682,8 +681,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->base		= base;
 	info->vaddr		= vaddr;
 
-	info->mtd.priv		= &info->chip;
-	info->mtd.dev.parent	= &pdev->dev;
+	nand_to_mtd(&info->chip)->priv		= &info->chip;
+	nand_to_mtd(&info->chip)->dev.parent	= &pdev->dev;
 	nand_set_flash_node(&info->chip, pdev->dev.of_node);
 
 	info->chip.IO_ADDR_R	= vaddr;
@@ -785,7 +784,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	spin_unlock_irq(&davinci_nand_lock);
 
 	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(&info->mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	ret = nand_scan_ident(nand_to_mtd(&info->chip),
+			      pdata->mask_chipsel ? 2 : 1, NULL);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		goto err;
@@ -797,9 +797,9 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	 * usable:  10 bytes are needed, not 6.
 	 */
 	if (pdata->ecc_bits == 4) {
-		int	chunks = info->mtd.writesize / 512;
+		int	chunks = nand_to_mtd(&info->chip)->writesize / 512;
 
-		if (!chunks || info->mtd.oobsize < 16) {
+		if (!chunks || nand_to_mtd(&info->chip)->oobsize < 16) {
 			dev_dbg(&pdev->dev, "too small\n");
 			ret = -EINVAL;
 			goto err;
@@ -812,7 +812,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		if (chunks == 1) {
 			info->ecclayout = hwecc4_small;
 			info->ecclayout.oobfree[1].length =
-				info->mtd.oobsize - 16;
+				nand_to_mtd(&info->chip)->oobsize - 16;
 			goto syndrome_done;
 		}
 		if (chunks == 4) {
@@ -833,15 +833,16 @@ syndrome_done:
 		info->chip.ecc.layout = &info->ecclayout;
 	}
 
-	ret = nand_scan_tail(&info->mtd);
+	ret = nand_scan_tail(nand_to_mtd(&info->chip));
 	if (ret < 0)
 		goto err;
 
 	if (pdata->parts)
-		ret = mtd_device_parse_register(&info->mtd, NULL, NULL,
+		ret = mtd_device_parse_register(nand_to_mtd(&info->chip),
+						NULL, NULL,
 					pdata->parts, pdata->nr_parts);
 	else
-		ret = mtd_device_register(&info->mtd, NULL, 0);
+		ret = mtd_device_register(nand_to_mtd(&info->chip), NULL, 0);
 	if (ret < 0)
 		goto err;
 
@@ -871,7 +872,7 @@ static int nand_davinci_remove(struct platform_device *pdev)
 		ecc4_busy = false;
 	spin_unlock_irq(&davinci_nand_lock);
 
-	nand_release(&info->mtd);
+	nand_release(nand_to_mtd(&info->chip));
 
 	clk_disable_unprepare(info->clk);
 
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 67eb2be..dbe9aac 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -75,7 +75,7 @@ MODULE_PARM_DESC(onfi_timing_mode,
  * this macro allows us to convert from an MTD structure to our own
  * device context (denali) structure.
  */
-#define mtd_to_denali(m) container_of(m, struct denali_nand_info, mtd)
+#define mtd_to_denali(m) container_of(mtd_to_nand(m), struct denali_nand_info, nand)
 
 /*
  * These constants are defined by the driver to enable common driver
@@ -995,7 +995,7 @@ static bool handle_ecc(struct denali_nand_info *denali, uint8_t *buf,
 							err_device;
 					/* correct the ECC error */
 					buf[offset] ^= err_correction_value;
-					denali->mtd.ecc_stats.corrected++;
+					nand_to_mtd(&denali->nand)->ecc_stats.corrected++;
 					bitflips++;
 				}
 			} else {
@@ -1062,7 +1062,7 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize;
 	uint32_t irq_status;
 	uint32_t irq_mask = INTR_STATUS__DMA_CMD_COMP |
 						INTR_STATUS__PROGRAM_FAIL;
@@ -1160,7 +1160,7 @@ static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize;
 
 	uint32_t irq_status;
 	uint32_t irq_mask = INTR_STATUS__ECC_TRANSACTION_DONE |
@@ -1193,14 +1193,15 @@ static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	denali_enable_dma(denali, false);
 
 	if (check_erased_page) {
-		read_oob_data(&denali->mtd, chip->oob_poi, denali->page);
+		read_oob_data(nand_to_mtd(&denali->nand), chip->oob_poi,
+			      denali->page);
 
 		/* check ECC failures that may have occurred on erased pages */
 		if (check_erased_page) {
-			if (!is_erased(buf, denali->mtd.writesize))
-				denali->mtd.ecc_stats.failed++;
-			if (!is_erased(buf, denali->mtd.oobsize))
-				denali->mtd.ecc_stats.failed++;
+			if (!is_erased(buf, nand_to_mtd(&denali->nand)->writesize))
+				nand_to_mtd(&denali->nand)->ecc_stats.failed++;
+			if (!is_erased(buf, nand_to_mtd(&denali->nand)->oobsize))
+				nand_to_mtd(&denali->nand)->ecc_stats.failed++;
 		}
 	}
 	return max_bitflips;
@@ -1211,7 +1212,7 @@ static int denali_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize;
 	uint32_t irq_mask = INTR_STATUS__DMA_CMD_COMP;
 
 	if (page != denali->page) {
@@ -1447,7 +1448,7 @@ int denali_init(struct denali_nand_info *denali)
 	if (!denali->buf.buf)
 		return -ENOMEM;
 
-	denali->mtd.dev.parent = denali->dev;
+	nand_to_mtd(&denali->nand)->dev.parent = denali->dev;
 	denali_hw_init(denali);
 	denali_drv_init(denali);
 
@@ -1463,8 +1464,8 @@ int denali_init(struct denali_nand_info *denali)
 
 	/* now that our ISR is registered, we can enable interrupts */
 	denali_set_intr_modes(denali, true);
-	denali->mtd.name = "denali-nand";
-	denali->mtd.priv = &denali->nand;
+	nand_to_mtd(&denali->nand)->name = "denali-nand";
+	nand_to_mtd(&denali->nand)->priv = &denali->nand;
 
 	/* register the driver with the NAND core subsystem */
 	denali->nand.select_chip = denali_select_chip;
@@ -1477,7 +1478,7 @@ int denali_init(struct denali_nand_info *denali)
 	 * this is the first stage in a two step process to register
 	 * with the nand subsystem
 	 */
-	if (nand_scan_ident(&denali->mtd, denali->max_banks, NULL)) {
+	if (nand_scan_ident(nand_to_mtd(&denali->nand), denali->max_banks, NULL)) {
 		ret = -ENXIO;
 		goto failed_req_irq;
 	}
@@ -1485,7 +1486,7 @@ int denali_init(struct denali_nand_info *denali)
 	/* allocate the right size buffer now */
 	devm_kfree(denali->dev, denali->buf.buf);
 	denali->buf.buf = devm_kzalloc(denali->dev,
-			     denali->mtd.writesize + denali->mtd.oobsize,
+			     nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize,
 			     GFP_KERNEL);
 	if (!denali->buf.buf) {
 		ret = -ENOMEM;
@@ -1500,7 +1501,7 @@ int denali_init(struct denali_nand_info *denali)
 	}
 
 	denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
-			     denali->mtd.writesize + denali->mtd.oobsize,
+			     nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize,
 			     DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(denali->dev, denali->buf.dma_buf)) {
 		dev_err(denali->dev, "Spectra: failed to map DMA buffer\n");
@@ -1521,10 +1522,10 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.bbt_erase_shift += (denali->devnum - 1);
 	denali->nand.phys_erase_shift = denali->nand.bbt_erase_shift;
 	denali->nand.chip_shift += (denali->devnum - 1);
-	denali->mtd.writesize <<= (denali->devnum - 1);
-	denali->mtd.oobsize <<= (denali->devnum - 1);
-	denali->mtd.erasesize <<= (denali->devnum - 1);
-	denali->mtd.size = denali->nand.numchips * denali->nand.chipsize;
+	nand_to_mtd(&denali->nand)->writesize <<= (denali->devnum - 1);
+	nand_to_mtd(&denali->nand)->oobsize <<= (denali->devnum - 1);
+	nand_to_mtd(&denali->nand)->erasesize <<= (denali->devnum - 1);
+	nand_to_mtd(&denali->nand)->size = denali->nand.numchips * denali->nand.chipsize;
 	denali->bbtskipbytes *= denali->devnum;
 
 	/*
@@ -1551,16 +1552,16 @@ int denali_init(struct denali_nand_info *denali)
 	 * SLC if possible.
 	 * */
 	if (!nand_is_slc(&denali->nand) &&
-			(denali->mtd.oobsize > (denali->bbtskipbytes +
-			ECC_15BITS * (denali->mtd.writesize /
+			(nand_to_mtd(&denali->nand)->oobsize > (denali->bbtskipbytes +
+			ECC_15BITS * (nand_to_mtd(&denali->nand)->writesize /
 			ECC_SECTOR_SIZE)))) {
 		/* if MLC OOB size is large enough, use 15bit ECC*/
 		denali->nand.ecc.strength = 15;
 		denali->nand.ecc.layout = &nand_15bit_oob;
 		denali->nand.ecc.bytes = ECC_15BITS;
 		iowrite32(15, denali->flash_reg + ECC_CORRECTION);
-	} else if (denali->mtd.oobsize < (denali->bbtskipbytes +
-			ECC_8BITS * (denali->mtd.writesize /
+	} else if (nand_to_mtd(&denali->nand)->oobsize < (denali->bbtskipbytes +
+			ECC_8BITS * (nand_to_mtd(&denali->nand)->writesize /
 			ECC_SECTOR_SIZE))) {
 		pr_err("Your NAND chip OOB is not large enough to contain 8bit ECC correction codes");
 		goto failed_req_irq;
@@ -1574,11 +1575,11 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.ecc.bytes *= denali->devnum;
 	denali->nand.ecc.strength *= denali->devnum;
 	denali->nand.ecc.layout->eccbytes *=
-		denali->mtd.writesize / ECC_SECTOR_SIZE;
+		nand_to_mtd(&denali->nand)->writesize / ECC_SECTOR_SIZE;
 	denali->nand.ecc.layout->oobfree[0].offset =
 		denali->bbtskipbytes + denali->nand.ecc.layout->eccbytes;
 	denali->nand.ecc.layout->oobfree[0].length =
-		denali->mtd.oobsize - denali->nand.ecc.layout->eccbytes -
+		nand_to_mtd(&denali->nand)->oobsize - denali->nand.ecc.layout->eccbytes -
 		denali->bbtskipbytes;
 
 	/*
@@ -1586,7 +1587,7 @@ int denali_init(struct denali_nand_info *denali)
 	 * contained by each nand chip. blksperchip will help driver to
 	 * know how many blocks is taken by FW.
 	 */
-	denali->totalblks = denali->mtd.size >> denali->nand.phys_erase_shift;
+	denali->totalblks = nand_to_mtd(&denali->nand)->size >> denali->nand.phys_erase_shift;
 	denali->blksperchip = denali->totalblks / denali->nand.numchips;
 
 	/* override the default read operations */
@@ -1599,12 +1600,12 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.ecc.write_oob = denali_write_oob;
 	denali->nand.erase = denali_erase;
 
-	if (nand_scan_tail(&denali->mtd)) {
+	if (nand_scan_tail(nand_to_mtd(&denali->nand))) {
 		ret = -ENXIO;
 		goto failed_req_irq;
 	}
 
-	ret = mtd_device_register(&denali->mtd, NULL, 0);
+	ret = mtd_device_register(nand_to_mtd(&denali->nand), NULL, 0);
 	if (ret) {
 		dev_err(denali->dev, "Spectra: Failed to register MTD: %d\n",
 				ret);
@@ -1624,7 +1625,7 @@ void denali_remove(struct denali_nand_info *denali)
 {
 	denali_irq_cleanup(denali->irq, denali);
 	dma_unmap_single(denali->dev, denali->buf.dma_buf,
-			 denali->mtd.writesize + denali->mtd.oobsize,
+			 nand_to_mtd(&denali->nand)->writesize + nand_to_mtd(&denali->nand)->oobsize,
 			 DMA_BIDIRECTIONAL);
 }
 EXPORT_SYMBOL(denali_remove);
diff --git a/drivers/mtd/nand/denali.h b/drivers/mtd/nand/denali.h
index 4b12cd3..e7ab486 100644
--- a/drivers/mtd/nand/denali.h
+++ b/drivers/mtd/nand/denali.h
@@ -450,7 +450,6 @@ struct nand_buf {
 #define DT		3
 
 struct denali_nand_info {
-	struct mtd_info mtd;
 	struct nand_chip nand;
 	int flash_bank; /* currently selected chip */
 	int status;
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 5f7bcc8..96f1c81 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1556,15 +1556,14 @@ static int __init doc_probe(unsigned long physadr)
 
 	printk(KERN_NOTICE "DiskOnChip found at 0x%lx\n", physadr);
 
-	len = sizeof(struct mtd_info) +
-	    sizeof(struct nand_chip) + sizeof(struct doc_priv) + (2 * sizeof(struct nand_bbt_descr));
-	mtd = kzalloc(len, GFP_KERNEL);
-	if (!mtd) {
+	len = sizeof(struct nand_chip) + sizeof(struct doc_priv) + (2 * sizeof(struct nand_bbt_descr));
+	nand = kzalloc(len, GFP_KERNEL);
+	if (!nand) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	nand			= (struct nand_chip *) (mtd + 1);
+	mtd			= nand_to_mtd(nand);
 	doc			= (struct doc_priv *) (nand + 1);
 	nand->bbt_td		= (struct nand_bbt_descr *) (doc + 1);
 	nand->bbt_md		= nand->bbt_td + 1;
@@ -1650,7 +1649,7 @@ static void release_nanddoc(void)
 		nand_release(mtd);
 		iounmap(doc->virtadr);
 		release_mem_region(doc->physadr, DOC_IOREMAP_LEN);
-		kfree(mtd);
+		kfree(nand);
 	}
 }
 
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index da93d7f..a136ef0 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -1285,7 +1285,7 @@ static char const *part_probes[] = { "cmdlinepart", "saftlpart", NULL };
 
 static int __init probe_docg4(struct platform_device *pdev)
 {
-	struct mtd_info *mtd;
+	struct mtd_info *mtd = NULL;
 	struct nand_chip *nand;
 	void __iomem *virtadr;
 	struct docg4_priv *doc;
@@ -1305,14 +1305,13 @@ static int __init probe_docg4(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	len = sizeof(struct mtd_info) + sizeof(struct nand_chip) +
-		sizeof(struct docg4_priv);
-	mtd = kzalloc(len, GFP_KERNEL);
-	if (mtd == NULL) {
+	len = sizeof(struct nand_chip) + sizeof(struct docg4_priv);
+	nand = kzalloc(len, GFP_KERNEL);
+	if (nand == NULL) {
 		retval = -ENOMEM;
 		goto fail;
 	}
-	nand = (struct nand_chip *) (mtd + 1);
+	mtd = nand_to_mtd(nand);
 	doc = (struct docg4_priv *) (nand + 1);
 	mtd->priv = nand;
 	nand->priv = doc;
@@ -1355,13 +1354,12 @@ static int __init probe_docg4(struct platform_device *pdev)
 
  fail:
 	iounmap(virtadr);
-	if (mtd) {
+	if (nand) {
 		/* re-declarations avoid compiler warning */
-		struct nand_chip *nand = mtd_to_nand(mtd);
 		struct docg4_priv *doc = nand->priv;
 		nand_release(mtd); /* deletes partitions and mtd devices */
 		free_bch(doc->bch);
-		kfree(mtd);
+		kfree(nand);
 	}
 
 	return retval;
@@ -1372,7 +1370,7 @@ static int __exit cleanup_docg4(struct platform_device *pdev)
 	struct docg4_priv *doc = platform_get_drvdata(pdev);
 	nand_release(doc->mtd);
 	free_bch(doc->bch);
-	kfree(doc->mtd);
+	kfree(mtd_to_nand(doc->mtd));
 	iounmap(doc->virtadr);
 	return 0;
 }
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index ad6d5da..5d2e302 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -48,7 +48,6 @@
 /* mtd information per set */
 
 struct fsl_elbc_mtd {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct fsl_lbc_ctrl *ctrl;
 
@@ -746,8 +745,8 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	dev_dbg(priv->dev, "eLBC Set Information for bank %d\n", priv->bank);
 
 	/* Fill in fsl_elbc_mtd structure */
-	priv->mtd.priv = chip;
-	priv->mtd.dev.parent = priv->dev;
+	nand_to_mtd(&priv->chip)->priv = chip;
+	nand_to_mtd(&priv->chip)->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
 	/* set timeout to maximum */
@@ -798,9 +797,9 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 {
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
-	nand_release(&priv->mtd);
+	nand_release(nand_to_mtd(&priv->chip));
 
-	kfree(priv->mtd.name);
+	kfree(nand_to_mtd(&priv->chip)->name);
 
 	if (priv->vbase)
 		iounmap(priv->vbase);
@@ -886,8 +885,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	priv->mtd.name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
-	if (!priv->mtd.name) {
+	nand_to_mtd(&priv->chip)->name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
+	if (!nand_to_mtd(&priv->chip)->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -896,21 +895,22 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(&priv->mtd, 1, NULL);
+	ret = nand_scan_ident(nand_to_mtd(&priv->chip), 1, NULL);
 	if (ret)
 		goto err;
 
-	ret = fsl_elbc_chip_init_tail(&priv->mtd);
+	ret = fsl_elbc_chip_init_tail(nand_to_mtd(&priv->chip));
 	if (ret)
 		goto err;
 
-	ret = nand_scan_tail(&priv->mtd);
+	ret = nand_scan_tail(nand_to_mtd(&priv->chip));
 	if (ret)
 		goto err;
 
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
-	mtd_device_parse_register(&priv->mtd, part_probe_types, NULL,
+	mtd_device_parse_register(nand_to_mtd(&priv->chip),
+				  part_probe_types, NULL,
 				  NULL, 0);
 
 	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 3136842..f37b180 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -40,7 +40,6 @@ struct fsl_ifc_ctrl;
 
 /* mtd information per set */
 struct fsl_ifc_mtd {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct fsl_ifc_ctrl *ctrl;
 
@@ -881,8 +880,8 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
-	priv->mtd.priv = chip;
-	priv->mtd.dev.parent = priv->dev;
+	nand_to_mtd(&priv->chip)->priv = chip;
+	nand_to_mtd(&priv->chip)->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
 	/* fill in nand_chip structure */
@@ -994,9 +993,9 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 
 static int fsl_ifc_chip_remove(struct fsl_ifc_mtd *priv)
 {
-	nand_release(&priv->mtd);
+	nand_release(nand_to_mtd(&priv->chip));
 
-	kfree(priv->mtd.name);
+	kfree(nand_to_mtd(&priv->chip)->name);
 
 	if (priv->vbase)
 		iounmap(priv->vbase);
@@ -1103,8 +1102,8 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 		  IFC_NAND_EVTER_INTR_FTOERIR_EN |
 		  IFC_NAND_EVTER_INTR_WPERIR_EN,
 		  &ifc->ifc_nand.nand_evter_intr_en);
-	priv->mtd.name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
-	if (!priv->mtd.name) {
+	nand_to_mtd(&priv->chip)->name = kasprintf(GFP_KERNEL, "%llx.flash", (u64)res.start);
+	if (!nand_to_mtd(&priv->chip)->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -1113,22 +1112,22 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 	if (ret)
 		goto err;
 
-	ret = nand_scan_ident(&priv->mtd, 1, NULL);
+	ret = nand_scan_ident(nand_to_mtd(&priv->chip), 1, NULL);
 	if (ret)
 		goto err;
 
-	ret = fsl_ifc_chip_init_tail(&priv->mtd);
+	ret = fsl_ifc_chip_init_tail(nand_to_mtd(&priv->chip));
 	if (ret)
 		goto err;
 
-	ret = nand_scan_tail(&priv->mtd);
+	ret = nand_scan_tail(nand_to_mtd(&priv->chip));
 	if (ret)
 		goto err;
 
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
-	mtd_device_parse_register(&priv->mtd, part_probe_types, NULL,
-						NULL, 0);
+	mtd_device_parse_register(nand_to_mtd(&priv->chip),
+				  part_probe_types, NULL, NULL, 0);
 
 	dev_info(priv->dev, "IFC NAND device at 0x%llx, bank %d\n",
 		 (unsigned long long)res.start, priv->bank);
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 68ec128..65919b8 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -31,7 +31,6 @@
 
 struct fsl_upm_nand {
 	struct device *dev;
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	int last_ctrl;
 	struct mtd_partition *parts;
@@ -49,7 +48,8 @@ struct fsl_upm_nand {
 
 static inline struct fsl_upm_nand *to_fsl_upm_nand(struct mtd_info *mtdinfo)
 {
-	return container_of(mtdinfo, struct fsl_upm_nand, mtd);
+	return container_of(mtd_to_nand(mtdinfo), struct fsl_upm_nand,
+			    chip);
 }
 
 static int fun_chip_ready(struct mtd_info *mtd)
@@ -68,7 +68,7 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 	if (fun->rnb_gpio[fun->mchip_number] >= 0) {
 		int cnt = 1000000;
 
-		while (--cnt && !fun_chip_ready(&fun->mtd))
+		while (--cnt && !fun_chip_ready(nand_to_mtd(&fun->chip)))
 			cpu_relax();
 		if (!cnt)
 			dev_err(fun->dev, "tired waiting for RNB\n");
@@ -174,30 +174,30 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
-	fun->mtd.priv = &fun->chip;
-	fun->mtd.dev.parent = fun->dev;
+	nand_to_mtd(&fun->chip)->priv = &fun->chip;
+	nand_to_mtd(&fun->chip)->dev.parent = fun->dev;
 
 	flash_np = of_get_next_child(upm_np, NULL);
 	if (!flash_np)
 		return -ENODEV;
 
 	nand_set_flash_node(&fun->chip, flash_np);
-	fun->mtd.name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
-				  flash_np->name);
-	if (!fun->mtd.name) {
+	nand_to_mtd(&fun->chip)->name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
+					  flash_np->name);
+	if (!nand_to_mtd(&fun->chip)->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, fun->mchip_count);
+	ret = nand_scan(nand_to_mtd(&fun->chip), fun->mchip_count);
 	if (ret)
 		goto err;
 
-	ret = mtd_device_register(&fun->mtd, NULL, 0);
+	ret = mtd_device_register(nand_to_mtd(&fun->chip), NULL, 0);
 err:
 	of_node_put(flash_np);
 	if (ret)
-		kfree(fun->mtd.name);
+		kfree(nand_to_mtd(&fun->chip)->name);
 	return ret;
 }
 
@@ -323,8 +323,8 @@ static int fun_remove(struct platform_device *ofdev)
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
 	int i;
 
-	nand_release(&fun->mtd);
-	kfree(fun->mtd.name);
+	nand_release(nand_to_mtd(&fun->chip));
+	kfree(nand_to_mtd(&fun->chip)->name);
 
 	for (i = 0; i < fun->mchip_count; i++) {
 		if (fun->rnb_gpio[i] < 0)
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 1c6c399..a3080b9 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -299,7 +299,6 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
  */
 struct fsmc_nand_data {
 	u32			pid;
-	struct mtd_info		mtd;
 	struct nand_chip	nand;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
@@ -332,7 +331,8 @@ static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsmc_nand_data *host;
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
+	host = container_of(mtd_to_nand(mtd), struct fsmc_nand_data,
+			    nand);
 
 	switch (chipnr) {
 	case -1:
@@ -359,8 +359,9 @@ static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	void __iomem *regs = host->regs_va;
 	unsigned int bank = host->bank;
 
@@ -445,8 +446,9 @@ static void fsmc_nand_setup(void __iomem *regs, uint32_t bank,
  */
 static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 
@@ -466,8 +468,9 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 	uint32_t ecc_tmp;
@@ -517,8 +520,9 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 	uint32_t ecc_tmp;
@@ -676,7 +680,8 @@ static void fsmc_read_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct fsmc_nand_data *host;
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
+	host = container_of(mtd_to_nand(mtd), struct fsmc_nand_data,
+			    nand);
 	dma_xfer(host, buf, len, DMA_FROM_DEVICE);
 }
 
@@ -691,7 +696,8 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 {
 	struct fsmc_nand_data *host;
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
+	host = container_of(mtd_to_nand(mtd), struct fsmc_nand_data,
+			    nand);
 	dma_xfer(host, (void *)buf, len, DMA_TO_DEVICE);
 }
 
@@ -712,8 +718,9 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				 uint8_t *buf, int oob_required, int page)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	struct fsmc_eccplace *ecc_place = host->ecc_place;
 	int i, j, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -782,8 +789,9 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
 			     uint8_t *read_ecc, uint8_t *calc_ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = container_of(mtd_to_nand(mtd),
+						   struct fsmc_nand_data,
+						   nand);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	void __iomem *regs = host->regs_va;
 	unsigned int bank = host->bank;
@@ -1011,13 +1019,13 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		init_completion(&host->dma_access_complete);
 
 	/* Link all private pointers */
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand);
 	nand = &host->nand;
 	mtd->priv = nand;
 	nand->priv = host;
 	nand_set_flash_node(nand, np);
 
-	host->mtd.dev.parent = &pdev->dev;
+	nand_to_mtd(&host->nand)->dev.parent = &pdev->dev;
 	nand->IO_ADDR_R = host->data_va;
 	nand->IO_ADDR_W = host->data_va;
 	nand->cmd_ctrl = fsmc_cmd_ctrl;
@@ -1080,14 +1088,14 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Scan to find existence of the device
 	 */
-	if (nand_scan_ident(&host->mtd, 1, NULL)) {
+	if (nand_scan_ident(nand_to_mtd(&host->nand), 1, NULL)) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "No NAND Device found!\n");
 		goto err_scan_ident;
 	}
 
 	if (AMBA_REV_BITS(host->pid) >= 8) {
-		switch (host->mtd.oobsize) {
+		switch (nand_to_mtd(&host->nand)->oobsize) {
 		case 16:
 			nand->ecc.layout = &fsmc_ecc4_16_layout;
 			host->ecc_place = &fsmc_ecc4_sp_place;
@@ -1138,7 +1146,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		 * generated later in nand_bch_init() later.
 		 */
 		if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
-			switch (host->mtd.oobsize) {
+			switch (nand_to_mtd(&host->nand)->oobsize) {
 			case 16:
 				nand->ecc.layout = &fsmc_ecc1_16_layout;
 				break;
@@ -1159,7 +1167,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Second stage of scan to fill MTD data-structures */
-	if (nand_scan_tail(&host->mtd)) {
+	if (nand_scan_tail(nand_to_mtd(&host->nand))) {
 		ret = -ENXIO;
 		goto err_probe;
 	}
@@ -1174,8 +1182,9 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Check for partition info passed
 	 */
-	host->mtd.name = "nand";
-	ret = mtd_device_register(&host->mtd, host->partitions,
+	nand_to_mtd(&host->nand)->name = "nand";
+	ret = mtd_device_register(nand_to_mtd(&host->nand),
+				  host->partitions,
 				  host->nr_partitions);
 	if (ret)
 		goto err_probe;
@@ -1206,7 +1215,7 @@ static int fsmc_nand_remove(struct platform_device *pdev)
 	struct fsmc_nand_data *host = platform_get_drvdata(pdev);
 
 	if (host) {
-		nand_release(&host->mtd);
+		nand_release(nand_to_mtd(&host->nand));
 
 		if (host->mode == USE_DMA_ACCESS) {
 			dma_release_channel(host->write_dma_chan);
diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index d57a07a..fc30326 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -35,12 +35,11 @@
 
 struct gpiomtd {
 	void __iomem		*io_sync;
-	struct mtd_info		mtd_info;
 	struct nand_chip	nand_chip;
 	struct gpio_nand_platdata plat;
 };
 
-#define gpio_nand_getpriv(x) container_of(x, struct gpiomtd, mtd_info)
+#define gpio_nand_getpriv(x) container_of(mtd_to_nand(x), struct gpiomtd, nand_chip)
 
 
 #ifdef CONFIG_ARM
@@ -195,7 +194,7 @@ static int gpio_nand_remove(struct platform_device *pdev)
 {
 	struct gpiomtd *gpiomtd = platform_get_drvdata(pdev);
 
-	nand_release(&gpiomtd->mtd_info);
+	nand_release(nand_to_mtd(&gpiomtd->nand_chip));
 
 	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
 		gpio_set_value(gpiomtd->plat.gpio_nwp, 0);
@@ -274,24 +273,25 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip->chip_delay	= gpiomtd->plat.chip_delay;
 	chip->cmd_ctrl		= gpio_nand_cmd_ctrl;
 
-	gpiomtd->mtd_info.priv	= chip;
-	gpiomtd->mtd_info.dev.parent = &pdev->dev;
+	nand_to_mtd(&gpiomtd->nand_chip)->priv	= chip;
+	nand_to_mtd(&gpiomtd->nand_chip)->dev.parent = &pdev->dev;
 
 	platform_set_drvdata(pdev, gpiomtd);
 
 	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
 		gpio_direction_output(gpiomtd->plat.gpio_nwp, 1);
 
-	if (nand_scan(&gpiomtd->mtd_info, 1)) {
+	if (nand_scan(nand_to_mtd(&gpiomtd->nand_chip), 1)) {
 		ret = -ENXIO;
 		goto err_wp;
 	}
 
 	if (gpiomtd->plat.adjust_parts)
 		gpiomtd->plat.adjust_parts(&gpiomtd->plat,
-					   gpiomtd->mtd_info.size);
+					   nand_to_mtd(&gpiomtd->nand_chip)->size);
 
-	ret = mtd_device_register(&gpiomtd->mtd_info, gpiomtd->plat.parts,
+	ret = mtd_device_register(nand_to_mtd(&gpiomtd->nand_chip),
+				  gpiomtd->plat.parts,
 				  gpiomtd->plat.num_parts);
 	if (!ret)
 		return 0;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 43fa16b..081228f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -919,7 +919,7 @@ static int enable_edo_mode(struct gpmi_nand_data *this, int mode)
 {
 	struct resources  *r = &this->resources;
 	struct nand_chip *nand = &this->nand;
-	struct mtd_info	 *mtd = &this->mtd;
+	struct mtd_info	 *mtd = nand_to_mtd(&this->nand);
 	uint8_t *feature;
 	unsigned long rate;
 	int ret;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 802adb0..b7229a1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -107,7 +107,7 @@ static irqreturn_t bch_irq(int irq, void *cookie)
 static inline int get_ecc_strength(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info	*mtd = &this->mtd;
+	struct mtd_info	*mtd = nand_to_mtd(&this->nand);
 	int ecc_strength;
 
 	ecc_strength = ((mtd->oobsize - geo->metadata_size) * 8)
@@ -139,7 +139,7 @@ static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
 static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
 	unsigned int block_mark_bit_offset;
@@ -257,7 +257,7 @@ static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 static int legacy_set_geometry(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	unsigned int metadata_size;
 	unsigned int status_size;
 	unsigned int block_mark_bit_offset;
@@ -804,7 +804,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
 	struct device *dev = this->dev;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 
 	/* [1] Allocate a command buffer. PAGE_SIZE is enough. */
 	this->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
@@ -1600,7 +1600,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 {
 	struct boot_rom_geometry *rom_geo = &this->rom_geometry;
 	struct device *dev = this->dev;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	struct nand_chip *chip = &this->nand;
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
@@ -1655,7 +1655,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 {
 	struct device *dev = this->dev;
 	struct boot_rom_geometry *rom_geo = &this->rom_geometry;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	struct nand_chip *chip = &this->nand;
 	unsigned int block_size_in_pages;
 	unsigned int search_area_size_in_strides;
@@ -1735,7 +1735,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 {
 	struct device *dev = this->dev;
 	struct nand_chip *chip = &this->nand;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	unsigned int block_count;
 	unsigned int block;
 	int     chipnr;
@@ -1831,13 +1831,13 @@ static int gpmi_set_geometry(struct gpmi_nand_data *this)
 
 static void gpmi_nand_exit(struct gpmi_nand_data *this)
 {
-	nand_release(&this->mtd);
+	nand_release(nand_to_mtd(&this->nand));
 	gpmi_free_dma_buffer(this);
 }
 
 static int gpmi_init_last(struct gpmi_nand_data *this)
 {
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct bch_geometry *bch_geo = &this->bch_geometry;
@@ -1886,7 +1886,7 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 
 static int gpmi_nand_init(struct gpmi_nand_data *this)
 {
-	struct mtd_info  *mtd = &this->mtd;
+	struct mtd_info  *mtd = nand_to_mtd(&this->nand);
 	struct nand_chip *chip = &this->nand;
 	int ret;
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 544062f..4e49a1f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -160,7 +160,6 @@ struct gpmi_nand_data {
 
 	/* MTD / NAND */
 	struct nand_chip	nand;
-	struct mtd_info		mtd;
 
 	/* General-use Variables */
 	int			current_chip;
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 6358d4a..21ff2b4 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -134,7 +134,6 @@
 
 struct hinfc_host {
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	struct device		*dev;
 	void __iomem		*iobase;
 	void __iomem		*mmio;
@@ -189,7 +188,7 @@ static void wait_controller_finished(struct hinfc_host *host)
 
 static void hisi_nfc_dma_transfer(struct hinfc_host *host, int todev)
 {
-	struct mtd_info	*mtd = &host->mtd;
+	struct mtd_info	*mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned long val;
 	int ret;
@@ -262,7 +261,7 @@ static int hisi_nfc_send_cmd_pageprog(struct hinfc_host *host)
 
 static int hisi_nfc_send_cmd_readstart(struct hinfc_host *host)
 {
-	struct mtd_info	*mtd = &host->mtd;
+	struct mtd_info	*mtd = nand_to_mtd(&host->chip);
 
 	if ((host->addr_value[0] == host->cache_addr_value[0]) &&
 	    (host->addr_value[1] == host->cache_addr_value[1]))
@@ -643,7 +642,7 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
 	int size, strength, ecc_bits;
 	struct device *dev = host->dev;
 	struct nand_chip *chip = &host->chip;
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct device_node *np = host->dev->of_node;
 
 	size = of_get_nand_ecc_step_size(np);
@@ -712,7 +711,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 	chip = &host->chip;
-	mtd  = &host->mtd;
+	mtd  = nand_to_mtd(&host->chip);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -822,7 +821,7 @@ err_res:
 static int hisi_nfc_remove(struct platform_device *pdev)
 {
 	struct hinfc_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 
 	nand_release(mtd);
 
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index e8eb518..58dca30 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -58,7 +58,6 @@
 #define JZ_NAND_MEM_ADDR_OFFSET 0x10000
 
 struct jz_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	void __iomem *base;
 	struct resource *mem;
@@ -75,7 +74,7 @@ struct jz_nand {
 
 static inline struct jz_nand *mtd_to_jz_nand(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct jz_nand, mtd);
+	return container_of(mtd_to_nand(mtd), struct jz_nand, chip);
 }
 
 static void jz_nand_select_chip(struct mtd_info *mtd, int chipnr)
@@ -333,7 +332,7 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	char gpio_name[9];
 	char res_name[6];
 	uint32_t ctrl;
-	struct mtd_info *mtd = &nand->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
 	struct nand_chip *chip = &nand->chip;
 
 	/* Request GPIO port. */
@@ -431,7 +430,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 		goto err_iounmap_mmio;
 	}
 
-	mtd		= &nand->mtd;
+	mtd		= nand_to_mtd(&nand->chip);
 	chip		= &nand->chip;
 	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
@@ -542,7 +541,7 @@ static int jz_nand_remove(struct platform_device *pdev)
 	struct jz_nand *nand = platform_get_drvdata(pdev);
 	size_t i;
 
-	nand_release(&nand->mtd);
+	nand_release(nand_to_mtd(&nand->chip));
 
 	/* Deassert and disable all chips */
 	writel(0, nand->base + JZ_REG_NAND_CTRL);
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 3738856..600d467 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -173,7 +173,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	int			irq;
 	struct lpc32xx_nand_cfg_mlc	*ncfg;
@@ -566,7 +565,7 @@ static void lpc32xx_ecc_enable(struct mtd_info *mtd, int mode)
 
 static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -660,7 +659,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	
 	host->io_base_phy = rc->start;
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand_chip);
 	nand_chip = &host->nand_chip;
 	if (pdev->dev.of_node)
 		host->ncfg = lpc32xx_parse_dt(&pdev->dev);
@@ -814,7 +813,7 @@ err_exit1:
 static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	free_irq(host->irq, host);
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index fcd9fac..de0f909 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -204,7 +204,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_slc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	struct lpc32xx_nand_cfg_slc *ncfg;
 
@@ -703,7 +702,7 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 
 static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -799,7 +798,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->pdata = dev_get_platdata(&pdev->dev);
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand_chip);
 	chip = &host->nand_chip;
 	chip->priv = host;
 	nand_set_flash_node(chip, pdev->dev.of_node);
@@ -932,7 +931,7 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	uint32_t tmp;
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	dma_release_channel(host->dma_chan);
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 642c486..950443b 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -118,7 +118,6 @@
 #define NFC_TIMEOUT		(HZ / 10)	/* 1/10 s */
 
 struct mpc5121_nfc_prv {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 	int			irq;
 	void __iomem		*regs;
@@ -654,7 +653,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	if (!prv)
 		return -ENOMEM;
 
-	mtd = &prv->mtd;
+	mtd = nand_to_mtd(&prv->chip);
 	chip = &prv->chip;
 
 	mtd->priv = chip;
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 034e066..520152d 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -173,7 +173,6 @@ struct mxc_nand_devtype_data {
 };
 
 struct mxc_nand_host {
-	struct mtd_info		mtd;
 	struct nand_chip	nand;
 	struct device		*dev;
 
@@ -1515,7 +1514,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	/* structures must be linked */
 	this = &host->nand;
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand);
 	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name = DRIVER_NAME;
@@ -1703,7 +1702,7 @@ static int mxcnd_remove(struct platform_device *pdev)
 {
 	struct mxc_nand_host *host = platform_get_drvdata(pdev);
 
-	nand_release(&host->mtd);
+	nand_release(nand_to_mtd(&host->nand));
 	if (host->clk_act)
 		clk_disable_unprepare(host->clk);
 
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index eb2a567..442eeaf 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2236,13 +2236,13 @@ static int __init ns_init_module(void)
 	}
 
 	/* Allocate and initialize mtd_info, nand_chip and nandsim structures */
-	nsmtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip)
-				+ sizeof(struct nandsim), GFP_KERNEL);
-	if (!nsmtd) {
+	chip = kzalloc(sizeof(struct nand_chip) + sizeof(struct nandsim),
+		       GFP_KERNEL);
+	if (!chip) {
 		NS_ERR("unable to allocate core structures.\n");
 		return -ENOMEM;
 	}
-	chip        = (struct nand_chip *)(nsmtd + 1);
+	nsmtd       = nand_to_mtd(chip);
         nsmtd->priv = (void *)chip;
 	nand        = (struct nandsim *)(chip + 1);
 	chip->priv  = (void *)nand;
@@ -2392,7 +2392,7 @@ err_exit:
 	for (i = 0;i < ARRAY_SIZE(nand->partitions); ++i)
 		kfree(nand->partitions[i].name);
 error:
-	kfree(nsmtd);
+	kfree(chip);
 	free_lists();
 
 	return retval;
@@ -2413,7 +2413,7 @@ static void __exit ns_cleanup_module(void)
 	nand_release(nsmtd); /* Unregister driver */
 	for (i = 0;i < ARRAY_SIZE(ns->partitions); ++i)
 		kfree(ns->partitions[i].name);
-	kfree(nsmtd);        /* Free other structures */
+	kfree(mtd_to_nand(nsmtd));        /* Free other structures */
 	free_lists();
 }
 
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index d8a23b0..6962f3b 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -37,7 +37,6 @@
 struct ndfc_controller {
 	struct platform_device *ofdev;
 	void __iomem *ndfcbase;
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	int chip_select;
 	struct nand_hw_control ndfc_control;
@@ -167,31 +166,32 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->ecc.strength = 1;
 	chip->priv = ndfc;
 
-	ndfc->mtd.priv = chip;
-	ndfc->mtd.dev.parent = &ndfc->ofdev->dev;
+	nand_to_mtd(&ndfc->chip)->priv = chip;
+	nand_to_mtd(&ndfc->chip)->dev.parent = &ndfc->ofdev->dev;
 
 	flash_np = of_get_next_child(node, NULL);
 	if (!flash_np)
 		return -ENODEV;
 	nand_set_flash_node(chip, flash_np);
 
-	ndfc->mtd.name = kasprintf(GFP_KERNEL, "%s.%s",
-			dev_name(&ndfc->ofdev->dev), flash_np->name);
-	if (!ndfc->mtd.name) {
+	ppdata.of_node = flash_np;
+	nand_to_mtd(&ndfc->chip)->name = kasprintf(GFP_KERNEL, "%s.%s",
+				dev_name(&ndfc->ofdev->dev), flash_np->name);
+	if (!nand_to_mtd(&ndfc->chip)->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = nand_scan(&ndfc->mtd, 1);
+	ret = nand_scan(nand_to_mtd(&ndfc->chip), 1);
 	if (ret)
 		goto err;
 
-	ret = mtd_device_register(&ndfc->mtd, NULL, 0);
+	ret = mtd_device_register(nand_to_mtd(&ndfc->chip), NULL, 0);
 
 err:
 	of_node_put(flash_np);
 	if (ret)
-		kfree(ndfc->mtd.name);
+		kfree(nand_to_mtd(&ndfc->chip)->name);
 	return ret;
 }
 
@@ -259,8 +259,8 @@ static int ndfc_remove(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc = dev_get_drvdata(&ofdev->dev);
 
-	nand_release(&ndfc->mtd);
-	kfree(ndfc->mtd.name);
+	nand_release(nand_to_mtd(&ndfc->chip));
+	kfree(nand_to_mtd(&ndfc->chip)->name);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 8148cd6..fc5376f 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -55,7 +55,6 @@
 	__raw_writel((val), (dev)->reg + REG_SMADDR)
 
 struct nuc900_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	void __iomem *reg;
 	struct clk *clk;
@@ -80,7 +79,7 @@ static unsigned char nuc900_nand_read_byte(struct mtd_info *mtd)
 	unsigned char ret;
 	struct nuc900_nand *nand;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	nand = container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 
 	ret = (unsigned char)read_data_reg(nand);
 
@@ -93,7 +92,7 @@ static void nuc900_nand_read_buf(struct mtd_info *mtd,
 	int i;
 	struct nuc900_nand *nand;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	nand = container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 
 	for (i = 0; i < len; i++)
 		buf[i] = (unsigned char)read_data_reg(nand);
@@ -105,7 +104,7 @@ static void nuc900_nand_write_buf(struct mtd_info *mtd,
 	int i;
 	struct nuc900_nand *nand;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	nand = container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 
 	for (i = 0; i < len; i++)
 		write_data_reg(nand, buf[i]);
@@ -127,7 +126,7 @@ static int nuc900_nand_devready(struct mtd_info *mtd)
 	struct nuc900_nand *nand;
 	int ready;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	nand = container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 
 	ready = (nuc900_check_rb(nand)) ? 1 : 0;
 	return ready;
@@ -139,7 +138,7 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 	register struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nuc900_nand *nand;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	nand = container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 
 	if (command == NAND_CMD_READOOB) {
 		column += mtd->writesize;
@@ -249,8 +248,8 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	chip = &(nuc900_nand->chip);
 
-	nuc900_nand->mtd.priv	= chip;
-	nuc900_nand->mtd.dev.parent = &pdev->dev;
+	nand_to_mtd(&nuc900_nand->chip)->priv	= chip;
+	nand_to_mtd(&nuc900_nand->chip)->dev.parent = &pdev->dev;
 	spin_lock_init(&nuc900_nand->lock);
 
 	nuc900_nand->clk = devm_clk_get(&pdev->dev, NULL);
@@ -274,10 +273,10 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 
 	nuc900_nand_enable(nuc900_nand);
 
-	if (nand_scan(&(nuc900_nand->mtd), 1))
+	if (nand_scan(nand_to_mtd(&nuc900_nand->chip), 1))
 		return -ENXIO;
 
-	mtd_device_register(&(nuc900_nand->mtd), partitions,
+	mtd_device_register(nand_to_mtd(&nuc900_nand->chip), partitions,
 			    ARRAY_SIZE(partitions));
 
 	platform_set_drvdata(pdev, nuc900_nand);
@@ -289,7 +288,7 @@ static int nuc900_nand_remove(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
 
-	nand_release(&nuc900_nand->mtd);
+	nand_release(nand_to_mtd(&nuc900_nand->chip));
 	clk_disable(nuc900_nand->clk);
 
 	return 0;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 944a74e..d7f79ed 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -152,7 +152,6 @@ static struct nand_hw_control omap_gpmc_controller = {
 
 struct omap_nand_info {
 	struct omap_nand_platform_data	*pdata;
-	struct mtd_info			mtd;
 	struct nand_chip		nand;
 	struct platform_device		*pdev;
 
@@ -247,8 +246,9 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
  */
 static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct omap_nand_info *info = container_of(mtd,
-					struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
@@ -283,8 +283,9 @@ static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	u_char *p = (u_char *)buf;
 	u32	status = 0;
 
@@ -319,8 +320,9 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	u16 *p = (u16 *) buf;
 	u32	status = 0;
 	/* FIXME try bursts of writesw() or DMA ... */
@@ -344,8 +346,9 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
  */
 static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	uint32_t r_count = 0;
 	int ret = 0;
 	u32 *p = (u32 *)buf;
@@ -392,8 +395,9 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 static void omap_write_buf_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	uint32_t w_count = 0;
 	int i = 0, ret = 0;
 	u16 *p = (u16 *)buf;
@@ -458,8 +462,9 @@ static void omap_nand_dma_callback(void *data)
 static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 					unsigned int len, int is_write)
 {
-	struct omap_nand_info *info = container_of(mtd,
-					struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	struct dma_async_tx_descriptor *tx;
 	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
 							DMA_FROM_DEVICE;
@@ -623,8 +628,9 @@ done:
  */
 static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	int ret = 0;
 
 	if (len <= mtd->oobsize) {
@@ -671,8 +677,9 @@ out_copy:
 static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	int ret = 0;
 	unsigned long tim, limit;
 	u32 val;
@@ -886,8 +893,9 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 				u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	int blockCnt = 0, i = 0, ret = 0;
 	int stat = 0;
 
@@ -928,8 +936,9 @@ static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 				u_char *ecc_code)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	u32 val;
 
 	val = readl(info->reg.gpmc_ecc_config);
@@ -953,8 +962,9 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
  */
 static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
 	u32 val;
@@ -1002,8 +1012,9 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	unsigned long timeo = jiffies;
 	int status, state = this->state;
 
@@ -1031,8 +1042,9 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int omap_dev_ready(struct mtd_info *mtd)
 {
 	unsigned int val = 0;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 
 	val = readl(info->reg.gpmc_status);
 
@@ -1058,8 +1070,9 @@ static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 {
 	unsigned int bch_type;
 	unsigned int dev_width, nsectors;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	enum omap_ecc ecc_opt = info->ecc_opt;
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	u32 val, wr_mode;
@@ -1162,8 +1175,9 @@ static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
 static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 					const u_char *dat, u_char *ecc_calc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	int eccbytes	= info->nand.ecc.bytes;
 	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
 	u8 *ecc_code;
@@ -1334,8 +1348,9 @@ static int erased_sector_bitflips(u_char *data, u_char *oob,
 static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 				u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-			mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
 	int eccsteps = info->nand.ecc.steps;
 	int i , j, stat = 0;
@@ -1682,7 +1697,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->reg		= pdata->reg;
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
-	mtd			= &info->mtd;
+	mtd			= nand_to_mtd(&info->nand);
 	mtd->priv		= &info->nand;
 	mtd->dev.parent		= &pdev->dev;
 	nand_chip		= &info->nand;
@@ -1909,7 +1924,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 
 		err = elm_config(info->elm_dev, BCH4_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_to_mtd(&info->nand)->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1963,7 +1978,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH8_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_to_mtd(&info->nand)->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1993,7 +2008,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH16_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_to_mtd(&info->nand)->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -2057,8 +2072,9 @@ static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = container_of(mtd_to_nand(mtd),
+						   struct omap_nand_info,
+						   nand);
 	if (nand_chip->ecc.priv) {
 		nand_bch_free(nand_chip->ecc.priv);
 		nand_chip->ecc.priv = NULL;
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 4ed4f67..087a040 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -85,11 +85,11 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	u32 val = 0;
 
 	nc = devm_kzalloc(&pdev->dev,
-			sizeof(struct nand_chip) + sizeof(struct mtd_info),
+			sizeof(struct nand_chip),
 			GFP_KERNEL);
 	if (!nc)
 		return -ENOMEM;
-	mtd = (struct mtd_info *)(nc + 1);
+	mtd = nand_to_mtd(nc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index fa2f1fe..4dd2985 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -110,17 +110,15 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	pr_debug("pasemi_nand at %pR\n", &res);
 
 	/* Allocate memory for MTD device structure and private data */
-	pasemi_nand_mtd = kzalloc(sizeof(struct mtd_info) +
-				  sizeof(struct nand_chip), GFP_KERNEL);
-	if (!pasemi_nand_mtd) {
+	chip = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!chip) {
 		printk(KERN_WARNING
 		       "Unable to allocate PASEMI NAND MTD device structure\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* Get pointer to private data */
-	chip = (struct nand_chip *)&pasemi_nand_mtd[1];
+	pasemi_nand_mtd = nand_to_mtd(chip);
 
 	/* Link the private data with the MTD structure */
 	pasemi_nand_mtd->priv = chip;
@@ -180,7 +178,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
  out_ior:
 	iounmap(chip->IO_ADDR_R);
  out_mtd:
-	kfree(pasemi_nand_mtd);
+	kfree(chip);
  out:
 	return err;
 }
@@ -192,7 +190,7 @@ static int pasemi_nand_remove(struct platform_device *ofdev)
 	if (!pasemi_nand_mtd)
 		return 0;
 
-	chip = pasemi_nand_mtd->priv;
+	chip = mtd_to_nand(pasemi_nand_mtd);
 
 	/* Release resources, unregister device */
 	nand_release(pasemi_nand_mtd);
@@ -202,7 +200,7 @@ static int pasemi_nand_remove(struct platform_device *ofdev)
 	iounmap(chip->IO_ADDR_R);
 
 	/* Free the MTD device structure */
-	kfree(pasemi_nand_mtd);
+	kfree(chip);
 
 	pasemi_nand_mtd = NULL;
 
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 06ac6c6..789c4fa 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -20,7 +20,6 @@
 
 struct plat_nand_data {
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 };
 
@@ -58,8 +57,8 @@ static int plat_nand_probe(struct platform_device *pdev)
 
 	data->chip.priv = &data;
 	nand_set_flash_node(&data->chip, pdev->dev.of_node);
-	data->mtd.priv = &data->chip;
-	data->mtd.dev.parent = &pdev->dev;
+	nand_to_mtd(&data->chip)->priv = &data->chip;
+	nand_to_mtd(&data->chip)->dev.parent = &pdev->dev;
 
 	data->chip.IO_ADDR_R = data->io_base;
 	data->chip.IO_ADDR_W = data->io_base;
@@ -87,21 +86,22 @@ static int plat_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Scan to find existence of the device */
-	if (nand_scan(&data->mtd, pdata->chip.nr_chips)) {
+	if (nand_scan(nand_to_mtd(&data->chip), pdata->chip.nr_chips)) {
 		err = -ENXIO;
 		goto out;
 	}
 
 	part_types = pdata->chip.part_probe_types;
 
-	err = mtd_device_parse_register(&data->mtd, part_types, NULL,
+	err = mtd_device_parse_register(nand_to_mtd(&data->chip),
+					part_types, NULL,
 					pdata->chip.partitions,
 					pdata->chip.nr_partitions);
 
 	if (!err)
 		return err;
 
-	nand_release(&data->mtd);
+	nand_release(nand_to_mtd(&data->chip));
 out:
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
@@ -116,7 +116,7 @@ static int plat_nand_remove(struct platform_device *pdev)
 	struct plat_nand_data *data = platform_get_drvdata(pdev);
 	struct platform_nand_data *pdata = dev_get_platdata(&pdev->dev);
 
-	nand_release(&data->mtd);
+	nand_release(nand_to_mtd(&data->chip));
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
 
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 6e22682f..86b2de5 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -172,7 +172,6 @@ enum pxa3xx_nand_variant {
 
 struct pxa3xx_nand_host {
 	struct nand_chip	chip;
-	struct mtd_info         *mtd;
 	void			*info_data;
 
 	/* page size of attached chip */
@@ -455,14 +454,15 @@ static int pxa3xx_nand_init_timings_compat(struct pxa3xx_nand_host *host,
 	struct nand_chip *chip = &host->chip;
 	struct pxa3xx_nand_info *info = host->info_data;
 	const struct pxa3xx_nand_flash *f = NULL;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	int i, id, ntypes;
 
 	ntypes = ARRAY_SIZE(builtin_flash_types);
 
-	chip->cmdfunc(host->mtd, NAND_CMD_READID, 0x00, -1);
+	chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
 
-	id = chip->read_byte(host->mtd);
-	id |= chip->read_byte(host->mtd) << 0x8;
+	id = chip->read_byte(mtd);
+	id |= chip->read_byte(mtd) << 0x8;
 
 	for (i = 0; i < ntypes; i++) {
 		f = &builtin_flash_types[i];
@@ -895,7 +895,7 @@ static void set_command_address(struct pxa3xx_nand_info *info,
 static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 {
 	struct pxa3xx_nand_host *host = info->host[info->cs];
-	struct mtd_info *mtd = host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 
 	/* reset data and oob column point to handle data */
 	info->buf_start		= 0;
@@ -948,7 +948,7 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 	struct mtd_info *mtd;
 
 	host = info->host[info->cs];
-	mtd = host->mtd;
+	mtd = nand_to_mtd(&host->chip);
 	addr_cycle = 0;
 	exec_cmd = 1;
 
@@ -1399,7 +1399,7 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info)
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct pxa3xx_nand_host *host = info->host[info->cs];
-	struct mtd_info *mtd = host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	/* configure default flash values */
@@ -1498,7 +1498,7 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_host *host)
 	const struct nand_sdr_timings *timings;
 	int ret;
 
-	mtd = info->host[info->cs]->mtd;
+	mtd = nand_to_mtd(&info->host[info->cs]->chip);
 	chip = mtd_to_nand(mtd);
 
 	/* use the common timing to make a try */
@@ -1716,19 +1716,20 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata->num_cs <= 0)
 		return -ENODEV;
-	info = devm_kzalloc(&pdev->dev, sizeof(*info) + (sizeof(*mtd) +
-			    sizeof(*host)) * pdata->num_cs, GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev,
+			    sizeof(*info) + sizeof(*host) * pdata->num_cs,
+			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	info->pdev = pdev;
 	info->variant = pxa3xx_nand_get_variant(pdev);
 	for (cs = 0; cs < pdata->num_cs; cs++) {
-		mtd = (void *)&info[1] + (sizeof(*mtd) + sizeof(*host)) * cs;
-		chip = (struct nand_chip *)(&mtd[1]);
-		host = (struct pxa3xx_nand_host *)chip;
+		host = (void *)&info[1] + sizeof(*host) * cs;
+		chip = &host->chip;
+		chip->priv = host;
+		mtd = nand_to_mtd(chip);
 		info->host[cs] = host;
-		host->mtd = mtd;
 		host->cs = cs;
 		host->info_data = info;
 		mtd->priv = chip;
@@ -1856,7 +1857,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable_unprepare(info->clk);
 
 	for (cs = 0; cs < pdata->num_cs; cs++)
-		nand_release(info->host[cs]->mtd);
+		nand_release(nand_to_mtd(&info->host[cs]->chip));
 	return 0;
 }
 
@@ -1927,7 +1928,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	info = platform_get_drvdata(pdev);
 	probe_success = 0;
 	for (cs = 0; cs < pdata->num_cs; cs++) {
-		struct mtd_info *mtd = info->host[cs]->mtd;
+		struct mtd_info *mtd = nand_to_mtd(&info->host[cs]->chip);
 
 		/*
 		 * The mtd name matches the one used in 'mtdparts' kernel
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index 39decfa..9c86409 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -634,25 +634,22 @@ static void r852_update_media_status(struct r852_device *dev)
  */
 static int r852_register_nand_device(struct r852_device *dev)
 {
-	dev->mtd = kzalloc(sizeof(struct mtd_info), GFP_KERNEL);
-
-	if (!dev->mtd)
-		goto error1;
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
 	WARN_ON(dev->card_registred);
 
-	dev->mtd->priv = dev->chip;
-	dev->mtd->dev.parent = &dev->pci_dev->dev;
+	mtd->priv = dev->chip;
+	mtd->dev.parent = &dev->pci_dev->dev;
 
 	if (dev->readonly)
 		dev->chip->options |= NAND_ROM;
 
 	r852_engine_enable(dev);
 
-	if (sm_register_device(dev->mtd, dev->sm))
-		goto error2;
+	if (sm_register_device(mtd, dev->sm))
+		goto error1;
 
-	if (device_create_file(&dev->mtd->dev, &dev_attr_media_type)) {
+	if (device_create_file(&mtd->dev, &dev_attr_media_type)) {
 		message("can't create media type sysfs attribute");
 		goto error3;
 	}
@@ -660,9 +657,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 	dev->card_registred = 1;
 	return 0;
 error3:
-	nand_release(dev->mtd);
-error2:
-	kfree(dev->mtd);
+	nand_release(mtd);
 error1:
 	/* Force card redetect */
 	dev->card_detected = 0;
@@ -675,15 +670,15 @@ error1:
 
 static void r852_unregister_nand_device(struct r852_device *dev)
 {
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
+
 	if (!dev->card_registred)
 		return;
 
-	device_remove_file(&dev->mtd->dev, &dev_attr_media_type);
-	nand_release(dev->mtd);
+	device_remove_file(&mtd->dev, &dev_attr_media_type);
+	nand_release(mtd);
 	r852_engine_disable(dev);
 	dev->card_registred = 0;
-	kfree(dev->mtd);
-	dev->mtd = NULL;
 }
 
 /* Card state updater */
@@ -1032,6 +1027,7 @@ static int r852_suspend(struct device *device)
 static int r852_resume(struct device *device)
 {
 	struct r852_device *dev = pci_get_drvdata(to_pci_dev(device));
+	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
 	r852_disable_irqs(dev);
 	r852_card_update_present(dev);
@@ -1051,9 +1047,9 @@ static int r852_resume(struct device *device)
 	/* Otherwise, initialize the card */
 	if (dev->card_registred) {
 		r852_engine_enable(dev);
-		dev->chip->select_chip(dev->mtd, 0);
-		dev->chip->cmdfunc(dev->mtd, NAND_CMD_RESET, -1, -1);
-		dev->chip->select_chip(dev->mtd, -1);
+		dev->chip->select_chip(mtd, 0);
+		dev->chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+		dev->chip->select_chip(mtd, -1);
 	}
 
 	/* Program card detection IRQ */
diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
index e6a21d9..d042ddb 100644
--- a/drivers/mtd/nand/r852.h
+++ b/drivers/mtd/nand/r852.h
@@ -108,7 +108,6 @@
 
 struct r852_device {
 	void __iomem *mmio;		/* mmio */
-	struct mtd_info *mtd;		/* mtd backpointer */
 	struct nand_chip *chip;		/* nand chip backpointer */
 	struct pci_dev *pci_dev;	/* pci backpointer */
 
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index e658b29..9f6423d 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -104,7 +104,6 @@ struct s3c2410_nand_info;
  * @scan_res: The result from calling nand_scan_ident().
 */
 struct s3c2410_nand_mtd {
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 	struct s3c2410_nand_set		*set;
 	struct s3c2410_nand_info	*info;
@@ -168,7 +167,8 @@ struct s3c2410_nand_info {
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct s3c2410_nand_mtd, mtd);
+	return container_of(mtd_to_nand(mtd), struct s3c2410_nand_mtd,
+			    chip);
 }
 
 static struct s3c2410_nand_info *s3c2410_nand_mtd_toinfo(struct mtd_info *mtd)
@@ -745,7 +745,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
 
 		for (mtdno = 0; mtdno < info->mtd_count; mtdno++, ptr++) {
 			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
-			nand_release(&ptr->mtd);
+			nand_release(nand_to_mtd(&ptr->chip));
 		}
 	}
 
@@ -762,9 +762,10 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 				      struct s3c2410_nand_set *set)
 {
 	if (set) {
-		mtd->mtd.name = set->name;
+		nand_to_mtd(&mtd->chip)->name = set->name;
 
-		return mtd_device_parse_register(&mtd->mtd, NULL, NULL,
+		return mtd_device_parse_register(nand_to_mtd(&mtd->chip),
+						 NULL, NULL,
 					 set->partitions, set->nr_partitions);
 	}
 
@@ -831,7 +832,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->IO_ADDR_R = chip->IO_ADDR_W;
 
 	nmtd->info	   = info;
-	nmtd->mtd.priv	   = chip;
+	nand_to_mtd(&nmtd->chip)->priv	   = chip;
 	nmtd->set	   = set;
 
 #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
@@ -1015,16 +1016,16 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 		pr_debug("initialising set %d (%p, info %p)\n",
 			 setno, nmtd, info);
 
-		nmtd->mtd.dev.parent = &pdev->dev;
+		nand_to_mtd(&nmtd->chip)->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		nmtd->scan_res = nand_scan_ident(&nmtd->mtd,
+		nmtd->scan_res = nand_scan_ident(nand_to_mtd(&nmtd->chip),
 						 (sets) ? sets->nr_chips : 1,
 						 NULL);
 
 		if (nmtd->scan_res == 0) {
 			s3c2410_nand_update_chip(info, nmtd);
-			nand_scan_tail(&nmtd->mtd);
+			nand_scan_tail(nand_to_mtd(&nmtd->chip));
 			s3c2410_nand_add_partition(info, nmtd, sets);
 		}
 
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 57dc525..0ec4b04 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -607,13 +607,13 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 		case FL_REPAIRABLE:
 			dev_info(&flctl->pdev->dev,
 				"applied ecc on page 0x%x", page_addr);
-			flctl->mtd.ecc_stats.corrected++;
+			mtd->ecc_stats.corrected++;
 			break;
 		case FL_ERROR:
 			dev_warn(&flctl->pdev->dev,
 				"page 0x%x contains corrupted data\n",
 				page_addr);
-			flctl->mtd.ecc_stats.failed++;
+			mtd->ecc_stats.failed++;
 			break;
 		default:
 			;
@@ -1120,8 +1120,8 @@ static int flctl_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, flctl);
-	flctl_mtd = &flctl->mtd;
 	nand = &flctl->chip;
+	flctl_mtd = nand_to_mtd(nand);
 	nand_set_flash_node(nand, pdev->dev.of_node);
 	flctl_mtd->priv = nand;
 	flctl_mtd->dev.parent = &pdev->dev;
@@ -1178,7 +1178,7 @@ static int flctl_remove(struct platform_device *pdev)
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
 	flctl_release_dma(flctl);
-	nand_release(&flctl->mtd);
+	nand_release(nand_to_mtd(&flctl->chip));
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 84129e5..be5a4bc 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -29,13 +29,12 @@
 #include <asm/mach-types.h>
 
 struct sharpsl_nand {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 
 	void __iomem		*io;
 };
 
-#define mtd_to_sharpsl(_mtd)	container_of(_mtd, struct sharpsl_nand, mtd)
+#define mtd_to_sharpsl(_mtd)	container_of(mtd_to_nand(_mtd), struct sharpsl_nand, chip)
 
 /* register offset */
 #define ECCLPLB		0x00	/* line parity 7 - 0 bit */
@@ -143,8 +142,8 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this = (struct nand_chip *)(&sharpsl->chip);
 
 	/* Link the private data with the MTD structure */
-	sharpsl->mtd.priv = this;
-	sharpsl->mtd.dev.parent = &pdev->dev;
+	nand_to_mtd(&sharpsl->chip)->priv = this;
+	nand_to_mtd(&sharpsl->chip)->dev.parent = &pdev->dev;
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -173,14 +172,15 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.correct = nand_correct_data;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(&sharpsl->mtd, 1);
+	err = nand_scan(nand_to_mtd(&sharpsl->chip), 1);
 	if (err)
 		goto err_scan;
 
 	/* Register the partitions */
-	sharpsl->mtd.name = "sharpsl-nand";
+	nand_to_mtd(&sharpsl->chip)->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(&sharpsl->mtd, NULL, NULL,
+	err = mtd_device_parse_register(nand_to_mtd(&sharpsl->chip),
+					NULL, NULL,
 					data->partitions, data->nr_partitions);
 	if (err)
 		goto err_add;
@@ -189,7 +189,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(&sharpsl->mtd);
+	nand_release(nand_to_mtd(&sharpsl->chip));
 
 err_scan:
 	iounmap(sharpsl->io);
@@ -207,7 +207,7 @@ static int sharpsl_nand_remove(struct platform_device *pdev)
 	struct sharpsl_nand *sharpsl = platform_get_drvdata(pdev);
 
 	/* Release resources, unregister device */
-	nand_release(&sharpsl->mtd);
+	nand_release(nand_to_mtd(&sharpsl->chip));
 
 	iounmap(sharpsl->io);
 
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index 2dfb1e0..6c0ea1c 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -30,7 +30,6 @@
 
 struct socrates_nand_host {
 	struct nand_chip	nand_chip;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	struct device		*dev;
 };
@@ -159,7 +158,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 		return -EIO;
 	}
 
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(&host->nand_chip);
 	nand_chip = &host->nand_chip;
 	host->dev = &ofdev->dev;
 
@@ -216,7 +215,7 @@ out:
 static int socrates_nand_remove(struct platform_device *ofdev)
 {
 	struct socrates_nand_host *host = dev_get_drvdata(&ofdev->dev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index a69302b..b8f5e41 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -234,7 +234,6 @@ struct sunxi_nand_hw_ecc {
 struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
-	struct mtd_info mtd;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -1008,12 +1007,14 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
 
 		feature[0] = mode;
 		for (i = 0; i < chip->nsels; i++) {
-			chip->nand.select_chip(&chip->mtd, i);
-			ret = chip->nand.onfi_set_features(&chip->mtd,
+			chip->nand.select_chip(nand_to_mtd(&chip->nand),
+					       i);
+			ret = chip->nand.onfi_set_features(nand_to_mtd(&chip->nand),
 						&chip->nand,
 						ONFI_FEATURE_ADDR_TIMING_MODE,
 						feature);
-			chip->nand.select_chip(&chip->mtd, -1);
+			chip->nand.select_chip(nand_to_mtd(&chip->nand),
+					       -1);
 			if (ret)
 				return ret;
 		}
@@ -1336,7 +1337,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	nand->write_buf = sunxi_nfc_write_buf;
 	nand->read_byte = sunxi_nfc_read_byte;
 
-	mtd = &chip->mtd;
+	mtd = nand_to_mtd(&chip->nand);
 	mtd->dev.parent = dev;
 	mtd->priv = nand;
 
@@ -1405,7 +1406,7 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 	while (!list_empty(&nfc->chips)) {
 		chip = list_first_entry(&nfc->chips, struct sunxi_nand_chip,
 					node);
-		nand_release(&chip->mtd);
+		nand_release(nand_to_mtd(&chip->nand));
 		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
 		list_del(&chip->node);
 	}
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index 6d0cbe9..127c382 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -103,7 +103,6 @@
 /*--------------------------------------------------------------------------*/
 
 struct tmio_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 
 	struct platform_device *dev;
@@ -119,7 +118,7 @@ struct tmio_nand {
 	unsigned read_good:1;
 };
 
-#define mtd_to_tmio(m)			container_of(m, struct tmio_nand, mtd)
+#define mtd_to_tmio(m)			container_of(mtd_to_nand(m), struct tmio_nand, chip)
 
 
 /*--------------------------------------------------------------------------*/
@@ -378,7 +377,7 @@ static int tmio_probe(struct platform_device *dev)
 	tmio->dev = dev;
 
 	platform_set_drvdata(dev, tmio);
-	mtd = &tmio->mtd;
+	mtd = nand_to_mtd(&tmio->chip);
 	nand_chip = &tmio->chip;
 	mtd->priv = nand_chip;
 	mtd->name = "tmio-nand";
@@ -456,7 +455,7 @@ static int tmio_remove(struct platform_device *dev)
 {
 	struct tmio_nand *tmio = platform_get_drvdata(dev);
 
-	nand_release(&tmio->mtd);
+	nand_release(nand_to_mtd(&tmio->chip));
 	tmio_hw_stop(dev, tmio);
 	return 0;
 }
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index ff9afb1..fa7cd49 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -63,7 +63,6 @@
 struct txx9ndfmc_priv {
 	struct platform_device *dev;
 	struct nand_chip chip;
-	struct mtd_info mtd;
 	int cs;
 	const char *mtdname;
 };
@@ -322,7 +321,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		if (!txx9_priv)
 			continue;
 		chip = &txx9_priv->chip;
-		mtd = &txx9_priv->mtd;
+		mtd = nand_to_mtd(&txx9_priv->chip);
 		mtd->dev.parent = &dev->dev;
 
 		mtd->priv = chip;
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 1c86c6b..a1cbd35 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -156,7 +156,6 @@ enum vf610_nfc_variant {
 };
 
 struct vf610_nfc {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	struct device *dev;
 	void __iomem *regs;
@@ -171,7 +170,7 @@ struct vf610_nfc {
 	u32 ecc_mode;
 };
 
-#define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
+#define mtd_to_nfc(_mtd) container_of(mtd_to_nand(_mtd), struct vf610_nfc, chip)
 
 static struct nand_ecclayout vf610_nfc_ecc45 = {
 	.eccbytes = 45,
@@ -674,7 +673,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	nfc->dev = &pdev->dev;
-	mtd = &nfc->mtd;
+	mtd = nand_to_mtd(&nfc->chip);
 	chip = &nfc->chip;
 
 	mtd->priv = chip;
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 1c28f88..ac53f55 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -143,7 +143,6 @@ enum flctl_ecc_res_t {
 struct dma_chan;
 
 struct sh_flctl {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 	struct platform_device	*pdev;
 	struct dev_pm_qos_request pm_qos;
@@ -186,7 +185,7 @@ struct sh_flctl_platform_data {
 
 static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
 {
-	return container_of(mtdinfo, struct sh_flctl, mtd);
+	return container_of(mtd_to_nand_chip(mtdinfo), struct sh_flctl, chip);
 }
 
 #endif	/* __SH_FLCTL_H__ */
-- 
2.1.4
