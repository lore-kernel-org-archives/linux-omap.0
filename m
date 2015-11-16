From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 01/27] mtd: nand: fix drivers abusing mtd->priv
Date: Mon, 16 Nov 2015 14:37:34 +0100
Message-ID: <1447681080-31232-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBPVYU6ZAKGQE5GM27DY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The ->priv field of the mtd_info object attached to a nand_chip device
should point to the nand_chip device. The pxa and cafe drivers are
assigning this field their own private structure, which works fine as long
as the nand_chip field is the first one in the driver private struct but
seems a bit fragile.
Fix that by setting mtd->priv to point the nand_chip field and assigning
chip->priv to the private structure head.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/cafe_nand.c   | 34 ++++++++++++++++++++++------------
 drivers/mtd/nand/pxa3xx_nand.c | 30 +++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 9de78d2..cce3ac4 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -101,7 +101,8 @@ static const char *part_probes[] = { "cmdlinepart", "RedBoot", NULL };
 
 static int cafe_device_ready(struct mtd_info *mtd)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 	int result = !!(cafe_readl(cafe, NAND_STATUS) & 0x40000000);
 	uint32_t irqs = cafe_readl(cafe, NAND_IRQ);
 
@@ -117,7 +118,8 @@ static int cafe_device_ready(struct mtd_info *mtd)
 
 static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
 	if (usedma)
 		memcpy(cafe->dmabuf + cafe->datalen, buf, len);
@@ -132,7 +134,8 @@ static void cafe_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
 	if (usedma)
 		memcpy(buf, cafe->dmabuf + cafe->datalen, len);
@@ -146,7 +149,8 @@ static void cafe_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 
 static uint8_t cafe_read_byte(struct mtd_info *mtd)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 	uint8_t d;
 
 	cafe_read_buf(mtd, &d, 1);
@@ -158,7 +162,8 @@ static uint8_t cafe_read_byte(struct mtd_info *mtd)
 static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			      int column, int page_addr)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 	int adrbytes = 0;
 	uint32_t ctl1;
 	uint32_t doneint = 0x80000000;
@@ -313,7 +318,8 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 
 static void cafe_select_chip(struct mtd_info *mtd, int chipnr)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
 	cafe_dev_dbg(&cafe->pdev->dev, "select_chip %d\n", chipnr);
 
@@ -328,7 +334,8 @@ static void cafe_select_chip(struct mtd_info *mtd, int chipnr)
 static irqreturn_t cafe_nand_interrupt(int irq, void *id)
 {
 	struct mtd_info *mtd = id;
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 	uint32_t irqs = cafe_readl(cafe, NAND_IRQ);
 	cafe_writel(cafe, irqs & ~0x90000000, NAND_IRQ);
 	if (!irqs)
@@ -377,7 +384,7 @@ static int cafe_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			       uint8_t *buf, int oob_required, int page)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 	unsigned int max_bitflips = 0;
 
 	cafe_dev_dbg(&cafe->pdev->dev, "ECC result %08x SYN1,2 %08x\n",
@@ -519,7 +526,7 @@ static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 					  const uint8_t *buf, int oob_required,
 					  int page)
 {
-	struct cafe_priv *cafe = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
 	chip->write_buf(mtd, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -604,7 +611,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	cafe = (void *)(&mtd[1]);
 
 	mtd->dev.parent = &pdev->dev;
-	mtd->priv = cafe;
+	mtd->priv = &cafe->nand;
+	cafe->nand.priv = cafe;
 
 	cafe->pdev = pdev;
 	cafe->mmio = pci_iomap(pdev, 0, 0);
@@ -792,7 +800,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 static void cafe_nand_remove(struct pci_dev *pdev)
 {
 	struct mtd_info *mtd = pci_get_drvdata(pdev);
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
@@ -819,7 +828,8 @@ static int cafe_nand_resume(struct pci_dev *pdev)
 {
 	uint32_t ctrl;
 	struct mtd_info *mtd = pci_get_drvdata(pdev);
-	struct cafe_priv *cafe = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct cafe_priv *cafe = chip->priv;
 
        /* Start off by resetting the NAND controller completely */
 	cafe_writel(cafe, 1, NAND_RESET);
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 37df51d..ec421ad 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1118,7 +1118,8 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 static void nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			 int column, int page_addr)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	int exec_cmd;
 
@@ -1166,7 +1167,8 @@ static void nand_cmdfunc_extended(struct mtd_info *mtd,
 				  const unsigned command,
 				  int column, int page_addr)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	int exec_cmd, ext_cmd_type;
 
@@ -1286,7 +1288,7 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int oob_required,
 		int page)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
@@ -1312,7 +1314,8 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	char retval = 0xFF;
 
@@ -1325,7 +1328,8 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 
 static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	u16 retval = 0xFFFF;
 
@@ -1338,7 +1342,8 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 
 static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
@@ -1349,7 +1354,8 @@ static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 		const uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
@@ -1364,7 +1370,8 @@ static void pxa3xx_nand_select_chip(struct mtd_info *mtd, int chip)
 
 static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 
 	if (info->need_wait) {
@@ -1580,11 +1587,11 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_host *host = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_host *host = chip->priv;
 	struct pxa3xx_nand_info *info = host->info_data;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct nand_chip *chip = mtd->priv;
 	int ret;
 	uint16_t ecc_strength, ecc_step;
 
@@ -1724,11 +1731,12 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		host->mtd = mtd;
 		host->cs = cs;
 		host->info_data = info;
-		mtd->priv = host;
+		mtd->priv = chip;
 		mtd->dev.parent = &pdev->dev;
 		/* FIXME: all chips use the same device tree partitions */
 		nand_set_flash_node(chip, np);
 
+		chip->priv = host;
 		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
 		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
 		chip->controller        = &info->controller;
-- 
2.1.4
