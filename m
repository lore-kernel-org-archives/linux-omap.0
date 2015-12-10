From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 03/58] mtd: nand: nuc900: create and use mtd_to_nuc900()
Date: Thu, 10 Dec 2015 08:59:47 +0100
Message-ID: <1449734442-18672-4-git-send-email-boris.brezillon@free-electrons.com>
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

Create and use mtd_to_nuc900() instead of direct container_of() calls.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/nuc900_nand.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 8148cd6..65908c0 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -62,6 +62,11 @@ struct nuc900_nand {
 	spinlock_t lock;
 };
 
+static inline struct nuc900_nand *mtd_to_nuc900(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct nuc900_nand, mtd);
+}
+
 static const struct mtd_partition partitions[] = {
 	{
 	 .name = "NAND FS 0",
@@ -78,9 +83,7 @@ static const struct mtd_partition partitions[] = {
 static unsigned char nuc900_nand_read_byte(struct mtd_info *mtd)
 {
 	unsigned char ret;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	ret = (unsigned char)read_data_reg(nand);
 
@@ -91,9 +94,7 @@ static void nuc900_nand_read_buf(struct mtd_info *mtd,
 				 unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	for (i = 0; i < len; i++)
 		buf[i] = (unsigned char)read_data_reg(nand);
@@ -103,9 +104,7 @@ static void nuc900_nand_write_buf(struct mtd_info *mtd,
 				  const unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	for (i = 0; i < len; i++)
 		write_data_reg(nand, buf[i]);
@@ -124,11 +123,9 @@ static int nuc900_check_rb(struct nuc900_nand *nand)
 
 static int nuc900_nand_devready(struct mtd_info *mtd)
 {
-	struct nuc900_nand *nand;
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 	int ready;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
-
 	ready = (nuc900_check_rb(nand)) ? 1 : 0;
 	return ready;
 }
@@ -137,9 +134,7 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 				   int column, int page_addr)
 {
 	register struct nand_chip *chip = mtd_to_nand(mtd);
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	if (command == NAND_CMD_READOOB) {
 		column += mtd->writesize;
-- 
2.1.4
