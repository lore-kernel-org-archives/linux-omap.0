From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 02/58] mtd: nand: fsmc: create and use mtd_to_fsmc()
Date: Thu, 10 Dec 2015 08:59:46 +0100
Message-ID: <1449734442-18672-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBQXCUSZQKGQELMU36LI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Create and use mtd_to_fsmc() to avoid duplication of
container_of(mtd, struct fsmc_nand_data, mtd) calls.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/fsmc_nand.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 1c6c399..499fc59 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -326,13 +326,18 @@ struct fsmc_nand_data {
 	void			(*select_chip)(uint32_t bank, uint32_t busw);
 };
 
+static inline struct fsmc_nand_data *mtd_to_fsmc(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct fsmc_nand_data, mtd);
+}
+
 /* Assert CS signal based on chipnr */
 static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct fsmc_nand_data *host;
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
+	host = mtd_to_fsmc(mtd);
 
 	switch (chipnr) {
 	case -1:
@@ -359,8 +364,7 @@ static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	void __iomem *regs = host->regs_va;
 	unsigned int bank = host->bank;
 
@@ -445,8 +449,7 @@ static void fsmc_nand_setup(void __iomem *regs, uint32_t bank,
  */
 static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 
@@ -466,8 +469,7 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 	uint32_t ecc_tmp;
@@ -517,8 +519,7 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
 static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	void __iomem *regs = host->regs_va;
 	uint32_t bank = host->bank;
 	uint32_t ecc_tmp;
@@ -674,9 +675,8 @@ static void fsmc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
  */
 static void fsmc_read_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct fsmc_nand_data *host;
+	struct fsmc_nand_data *host  = mtd_to_fsmc(mtd);
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
 	dma_xfer(host, buf, len, DMA_FROM_DEVICE);
 }
 
@@ -689,9 +689,8 @@ static void fsmc_read_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len)
 static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 		int len)
 {
-	struct fsmc_nand_data *host;
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 
-	host = container_of(mtd, struct fsmc_nand_data, mtd);
 	dma_xfer(host, (void *)buf, len, DMA_TO_DEVICE);
 }
 
@@ -712,8 +711,7 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				 uint8_t *buf, int oob_required, int page)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	struct fsmc_eccplace *ecc_place = host->ecc_place;
 	int i, j, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -782,9 +780,8 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
 			     uint8_t *read_ecc, uint8_t *calc_ecc)
 {
-	struct fsmc_nand_data *host = container_of(mtd,
-					struct fsmc_nand_data, mtd);
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 	void __iomem *regs = host->regs_va;
 	unsigned int bank = host->bank;
 	uint32_t err_idx[8];
-- 
2.1.4
