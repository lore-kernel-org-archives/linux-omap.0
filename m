From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 15/58] mtd: nand: denali: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 08:59:59 +0100
Message-ID: <1449734442-18672-16-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBA7DUSZQKGQEWSBUVTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---

Conflicts:
	drivers/mtd/nand/denali.c
---
 drivers/mtd/nand/denali.c | 70 ++++++++++++++++++++++++++---------------------
 drivers/mtd/nand/denali.h |  1 -
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 8feece3..2b66cee 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -75,7 +75,10 @@ MODULE_PARM_DESC(onfi_timing_mode,
  * this macro allows us to convert from an MTD structure to our own
  * device context (denali) structure.
  */
-#define mtd_to_denali(m) container_of(m, struct denali_nand_info, mtd)
+static inline struct denali_nand_info *mtd_to_denali(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct denali_nand_info, nand);
+}
 
 /*
  * These constants are defined by the driver to enable common driver
@@ -986,6 +989,8 @@ static bool handle_ecc(struct denali_nand_info *denali, uint8_t *buf,
 				 * than one NAND connected.
 				 */
 				if (err_byte < ECC_SECTOR_SIZE) {
+					struct mtd_info *mtd =
+						nand_to_mtd(&denali->nand);
 					int offset;
 
 					offset = (err_sector *
@@ -995,7 +1000,7 @@ static bool handle_ecc(struct denali_nand_info *denali, uint8_t *buf,
 							err_device;
 					/* correct the ECC error */
 					buf[offset] ^= err_correction_value;
-					denali->mtd.ecc_stats.corrected++;
+					mtd->ecc_stats.corrected++;
 					bitflips++;
 				}
 			} else {
@@ -1062,7 +1067,7 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = mtd->writesize + mtd->oobsize;
 	uint32_t irq_status;
 	uint32_t irq_mask = INTR_STATUS__DMA_CMD_COMP |
 						INTR_STATUS__PROGRAM_FAIL;
@@ -1160,7 +1165,7 @@ static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = mtd->writesize + mtd->oobsize;
 
 	uint32_t irq_status;
 	uint32_t irq_mask = INTR_STATUS__ECC_TRANSACTION_DONE |
@@ -1193,14 +1198,14 @@ static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	denali_enable_dma(denali, false);
 
 	if (check_erased_page) {
-		read_oob_data(&denali->mtd, chip->oob_poi, denali->page);
+		read_oob_data(mtd, chip->oob_poi, denali->page);
 
 		/* check ECC failures that may have occurred on erased pages */
 		if (check_erased_page) {
-			if (!is_erased(buf, denali->mtd.writesize))
-				denali->mtd.ecc_stats.failed++;
-			if (!is_erased(buf, denali->mtd.oobsize))
-				denali->mtd.ecc_stats.failed++;
+			if (!is_erased(buf, mtd->writesize))
+				mtd->ecc_stats.failed++;
+			if (!is_erased(buf, mtd->oobsize))
+				mtd->ecc_stats.failed++;
 		}
 	}
 	return max_bitflips;
@@ -1211,7 +1216,7 @@ static int denali_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	dma_addr_t addr = denali->buf.dma_buf;
-	size_t size = denali->mtd.writesize + denali->mtd.oobsize;
+	size_t size = mtd->writesize + mtd->oobsize;
 	uint32_t irq_mask = INTR_STATUS__DMA_CMD_COMP;
 
 	if (page != denali->page) {
@@ -1428,6 +1433,7 @@ static void denali_drv_init(struct denali_nand_info *denali)
 
 int denali_init(struct denali_nand_info *denali)
 {
+	struct mtd_info *mtd = nand_to_mtd(&denali->nand);
 	int ret;
 
 	if (denali->platform == INTEL_CE4100) {
@@ -1447,7 +1453,7 @@ int denali_init(struct denali_nand_info *denali)
 	if (!denali->buf.buf)
 		return -ENOMEM;
 
-	denali->mtd.dev.parent = denali->dev;
+	mtd->dev.parent = denali->dev;
 	denali_hw_init(denali);
 	denali_drv_init(denali);
 
@@ -1463,8 +1469,8 @@ int denali_init(struct denali_nand_info *denali)
 
 	/* now that our ISR is registered, we can enable interrupts */
 	denali_set_intr_modes(denali, true);
-	denali->mtd.name = "denali-nand";
-	denali->mtd.priv = &denali->nand;
+	mtd->name = "denali-nand";
+	mtd->priv = &denali->nand;
 
 	/* register the driver with the NAND core subsystem */
 	denali->nand.select_chip = denali_select_chip;
@@ -1477,7 +1483,7 @@ int denali_init(struct denali_nand_info *denali)
 	 * this is the first stage in a two step process to register
 	 * with the nand subsystem
 	 */
-	if (nand_scan_ident(&denali->mtd, denali->max_banks, NULL)) {
+	if (nand_scan_ident(mtd, denali->max_banks, NULL)) {
 		ret = -ENXIO;
 		goto failed_req_irq;
 	}
@@ -1485,7 +1491,7 @@ int denali_init(struct denali_nand_info *denali)
 	/* allocate the right size buffer now */
 	devm_kfree(denali->dev, denali->buf.buf);
 	denali->buf.buf = devm_kzalloc(denali->dev,
-			     denali->mtd.writesize + denali->mtd.oobsize,
+			     mtd->writesize + mtd->oobsize,
 			     GFP_KERNEL);
 	if (!denali->buf.buf) {
 		ret = -ENOMEM;
@@ -1500,7 +1506,7 @@ int denali_init(struct denali_nand_info *denali)
 	}
 
 	denali->buf.dma_buf = dma_map_single(denali->dev, denali->buf.buf,
-			     denali->mtd.writesize + denali->mtd.oobsize,
+			     mtd->writesize + mtd->oobsize,
 			     DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(denali->dev, denali->buf.dma_buf)) {
 		dev_err(denali->dev, "Spectra: failed to map DMA buffer\n");
@@ -1521,10 +1527,10 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.bbt_erase_shift += (denali->devnum - 1);
 	denali->nand.phys_erase_shift = denali->nand.bbt_erase_shift;
 	denali->nand.chip_shift += (denali->devnum - 1);
-	denali->mtd.writesize <<= (denali->devnum - 1);
-	denali->mtd.oobsize <<= (denali->devnum - 1);
-	denali->mtd.erasesize <<= (denali->devnum - 1);
-	denali->mtd.size = denali->nand.numchips * denali->nand.chipsize;
+	mtd->writesize <<= (denali->devnum - 1);
+	mtd->oobsize <<= (denali->devnum - 1);
+	mtd->erasesize <<= (denali->devnum - 1);
+	mtd->size = denali->nand.numchips * denali->nand.chipsize;
 	denali->bbtskipbytes *= denali->devnum;
 
 	/*
@@ -1551,16 +1557,16 @@ int denali_init(struct denali_nand_info *denali)
 	 * SLC if possible.
 	 * */
 	if (!nand_is_slc(&denali->nand) &&
-			(denali->mtd.oobsize > (denali->bbtskipbytes +
-			ECC_15BITS * (denali->mtd.writesize /
+			(mtd->oobsize > (denali->bbtskipbytes +
+			ECC_15BITS * (mtd->writesize /
 			ECC_SECTOR_SIZE)))) {
 		/* if MLC OOB size is large enough, use 15bit ECC*/
 		denali->nand.ecc.strength = 15;
 		denali->nand.ecc.layout = &nand_15bit_oob;
 		denali->nand.ecc.bytes = ECC_15BITS;
 		iowrite32(15, denali->flash_reg + ECC_CORRECTION);
-	} else if (denali->mtd.oobsize < (denali->bbtskipbytes +
-			ECC_8BITS * (denali->mtd.writesize /
+	} else if (mtd->oobsize < (denali->bbtskipbytes +
+			ECC_8BITS * (mtd->writesize /
 			ECC_SECTOR_SIZE))) {
 		pr_err("Your NAND chip OOB is not large enough to contain 8bit ECC correction codes");
 		goto failed_req_irq;
@@ -1574,11 +1580,11 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.ecc.bytes *= denali->devnum;
 	denali->nand.ecc.strength *= denali->devnum;
 	denali->nand.ecc.layout->eccbytes *=
-		denali->mtd.writesize / ECC_SECTOR_SIZE;
+		mtd->writesize / ECC_SECTOR_SIZE;
 	denali->nand.ecc.layout->oobfree[0].offset =
 		denali->bbtskipbytes + denali->nand.ecc.layout->eccbytes;
 	denali->nand.ecc.layout->oobfree[0].length =
-		denali->mtd.oobsize - denali->nand.ecc.layout->eccbytes -
+		mtd->oobsize - denali->nand.ecc.layout->eccbytes -
 		denali->bbtskipbytes;
 
 	/*
@@ -1586,7 +1592,7 @@ int denali_init(struct denali_nand_info *denali)
 	 * contained by each nand chip. blksperchip will help driver to
 	 * know how many blocks is taken by FW.
 	 */
-	denali->totalblks = denali->mtd.size >> denali->nand.phys_erase_shift;
+	denali->totalblks = mtd->size >> denali->nand.phys_erase_shift;
 	denali->blksperchip = denali->totalblks / denali->nand.numchips;
 
 	/* override the default read operations */
@@ -1599,12 +1605,12 @@ int denali_init(struct denali_nand_info *denali)
 	denali->nand.ecc.write_oob = denali_write_oob;
 	denali->nand.erase = denali_erase;
 
-	if (nand_scan_tail(&denali->mtd)) {
+	if (nand_scan_tail(mtd)) {
 		ret = -ENXIO;
 		goto failed_req_irq;
 	}
 
-	ret = mtd_device_register(&denali->mtd, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(denali->dev, "Spectra: Failed to register MTD: %d\n",
 				ret);
@@ -1622,10 +1628,12 @@ EXPORT_SYMBOL(denali_init);
 /* driver exit point */
 void denali_remove(struct denali_nand_info *denali)
 {
-	nand_release(&denali->mtd);
+	struct mtd_info *mtd = nand_to_mtd(&denali->nand);
+
+	nand_release(mtd);
 	denali_irq_cleanup(denali->irq, denali);
 	dma_unmap_single(denali->dev, denali->buf.dma_buf,
-			 denali->mtd.writesize + denali->mtd.oobsize,
+			 mtd->writesize + mtd->oobsize,
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
-- 
2.1.4
