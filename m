From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 04/58] mtd: nand: omap2: create and use mtd_to_omap()
Date: Thu, 10 Dec 2015 08:59:48 +0100
Message-ID: <1449734442-18672-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBRHCUSZQKGQE3ZFMFOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Define and use mtd_to_omap() instead of container_of();

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/omap2.c | 55 ++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 944a74e..1fb40db 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -177,6 +177,10 @@ struct omap_nand_info {
 	struct device_node		*of_node;
 };
 
+static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct omap_nand_info, mtd);
+}
 /**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
@@ -247,8 +251,7 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
  */
 static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct omap_nand_info *info = container_of(mtd,
-					struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
@@ -283,8 +286,7 @@ static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	u_char *p = (u_char *)buf;
 	u32	status = 0;
 
@@ -319,8 +321,7 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
  */
 static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	u16 *p = (u16 *) buf;
 	u32	status = 0;
 	/* FIXME try bursts of writesw() or DMA ... */
@@ -344,8 +345,7 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
  */
 static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	uint32_t r_count = 0;
 	int ret = 0;
 	u32 *p = (u32 *)buf;
@@ -392,8 +392,7 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 static void omap_write_buf_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	uint32_t w_count = 0;
 	int i = 0, ret = 0;
 	u16 *p = (u16 *)buf;
@@ -458,8 +457,7 @@ static void omap_nand_dma_callback(void *data)
 static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 					unsigned int len, int is_write)
 {
-	struct omap_nand_info *info = container_of(mtd,
-					struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	struct dma_async_tx_descriptor *tx;
 	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
 							DMA_FROM_DEVICE;
@@ -623,8 +621,7 @@ done:
  */
 static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int ret = 0;
 
 	if (len <= mtd->oobsize) {
@@ -671,8 +668,7 @@ out_copy:
 static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-						struct omap_nand_info, mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int ret = 0;
 	unsigned long tim, limit;
 	u32 val;
@@ -886,8 +882,7 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 				u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int blockCnt = 0, i = 0, ret = 0;
 	int stat = 0;
 
@@ -928,8 +923,7 @@ static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 				u_char *ecc_code)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	u32 val;
 
 	val = readl(info->reg.gpmc_ecc_config);
@@ -953,8 +947,7 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
  */
 static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
 	u32 val;
@@ -1002,8 +995,7 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	unsigned long timeo = jiffies;
 	int status, state = this->state;
 
@@ -1031,8 +1023,7 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 static int omap_dev_ready(struct mtd_info *mtd)
 {
 	unsigned int val = 0;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 
 	val = readl(info->reg.gpmc_status);
 
@@ -1058,8 +1049,7 @@ static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 {
 	unsigned int bch_type;
 	unsigned int dev_width, nsectors;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	enum omap_ecc ecc_opt = info->ecc_opt;
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	u32 val, wr_mode;
@@ -1162,8 +1152,7 @@ static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
 static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 					const u_char *dat, u_char *ecc_calc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	int eccbytes	= info->nand.ecc.bytes;
 	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
 	u8 *ecc_code;
@@ -1334,8 +1323,7 @@ static int erased_sector_bitflips(u_char *data, u_char *oob,
 static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 				u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-			mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
 	int eccsteps = info->nand.ecc.steps;
 	int i , j, stat = 0;
@@ -2057,8 +2045,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
 	if (nand_chip->ecc.priv) {
 		nand_bch_free(nand_chip->ecc.priv);
 		nand_chip->ecc.priv = NULL;
-- 
2.1.4
