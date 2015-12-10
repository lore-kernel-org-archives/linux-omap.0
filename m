From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 36/58] mtd: nand: pxa3xx: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:20 +0100
Message-ID: <1449734442-18672-37-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBJXFUSZQKGQEZL7DZXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/pxa3xx_nand.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index dc39a98..c4d5788 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -167,7 +167,6 @@ enum pxa3xx_nand_variant {
 
 struct pxa3xx_nand_host {
 	struct nand_chip	chip;
-	struct mtd_info         *mtd;
 	void			*info_data;
 
 	/* page size of attached chip */
@@ -450,14 +449,15 @@ static int pxa3xx_nand_init_timings_compat(struct pxa3xx_nand_host *host,
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
@@ -890,7 +890,7 @@ static void set_command_address(struct pxa3xx_nand_info *info,
 static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 {
 	struct pxa3xx_nand_host *host = info->host[info->cs];
-	struct mtd_info *mtd = host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 
 	/* reset data and oob column point to handle data */
 	info->buf_start		= 0;
@@ -943,7 +943,7 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 	struct mtd_info *mtd;
 
 	host = info->host[info->cs];
-	mtd = host->mtd;
+	mtd = nand_to_mtd(&host->chip);
 	addr_cycle = 0;
 	exec_cmd = 1;
 
@@ -1415,8 +1415,8 @@ static int pxa3xx_nand_config_ident(struct pxa3xx_nand_info *info)
 static void pxa3xx_nand_config_tail(struct pxa3xx_nand_info *info)
 {
 	struct pxa3xx_nand_host *host = info->host[info->cs];
-	struct mtd_info *mtd = host->mtd;
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_chip *chip = &host->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	info->reg_ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
 	info->reg_ndcr |= (chip->page_shift == 6) ? NDCR_PG_PER_BLK : 0;
@@ -1693,19 +1693,20 @@ static int alloc_nand_resource(struct platform_device *pdev)
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
@@ -1833,7 +1834,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable_unprepare(info->clk);
 
 	for (cs = 0; cs < pdata->num_cs; cs++)
-		nand_release(info->host[cs]->mtd);
+		nand_release(nand_to_mtd(&info->host[cs]->chip));
 	return 0;
 }
 
@@ -1904,7 +1905,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	info = platform_get_drvdata(pdev);
 	probe_success = 0;
 	for (cs = 0; cs < pdata->num_cs; cs++) {
-		struct mtd_info *mtd = info->host[cs]->mtd;
+		struct mtd_info *mtd = nand_to_mtd(&info->host[cs]->chip);
 
 		/*
 		 * The mtd name matches the one used in 'mtdparts' kernel
-- 
2.1.4
