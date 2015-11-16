From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 04/27] ARM: nand: make use of mtd_to_nand()
 where appropriate
Date: Mon, 16 Nov 2015 14:37:37 +0100
Message-ID: <1447681080-31232-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBQVYU6ZAKGQEU5WG34I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all ARM specific implementations to use this
helper.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/mach-ep93xx/snappercl15.c   | 4 ++--
 arch/arm/mach-ep93xx/ts72xx.c        | 4 ++--
 arch/arm/mach-imx/mach-qong.c        | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 2 +-
 arch/arm/mach-omap1/board-nand.c     | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c | 6 +++---
 arch/arm/mach-pxa/balloon3.c         | 2 +-
 arch/arm/mach-pxa/em-x270.c          | 2 +-
 arch/arm/mach-pxa/palmtx.c           | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index c490426..b2db791 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -49,7 +49,7 @@
 static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				      unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	static u16 nand_state = SNAPPERCL15_NAND_WPN;
 	u16 set;
 
@@ -76,7 +76,7 @@ static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 
 static int snappercl15_nand_dev_ready(struct mtd_info *mtd)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	return !!(__raw_readw(NAND_CTRL_ADDR(chip)) & SNAPPERCL15_NAND_RDY);
 }
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 61f4b5d..45b81a2 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -74,7 +74,7 @@ static void __init ts72xx_map_io(void)
 static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
 				  int cmd, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		void __iomem *addr = chip->IO_ADDR_R;
@@ -96,7 +96,7 @@ static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
 
 static int ts72xx_nand_device_ready(struct mtd_info *mtd)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	void __iomem *addr = chip->IO_ADDR_R;
 
 	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index a213e7b..5c27646 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -131,7 +131,7 @@ static void qong_init_nor_mtd(void)
  */
 static void qong_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *nand_chip = mtd->priv;
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 
 	if (cmd == NAND_CMD_NONE)
 		return;
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index e7b8bef..333b0f9 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -76,7 +76,7 @@ static struct mtd_partition ixdp425_partitions[] = {
 static void
 ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	int offset = (int)this->priv;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
diff --git a/arch/arm/mach-omap1/board-nand.c b/arch/arm/mach-omap1/board-nand.c
index 4d08353..7684f92 100644
--- a/arch/arm/mach-omap1/board-nand.c
+++ b/arch/arm/mach-omap1/board-nand.c
@@ -22,7 +22,7 @@
 
 void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long mask;
 
 	if (cmd == NAND_CMD_NONE)
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 1b704d3..96cf6b5 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -176,7 +176,7 @@ static void ts78xx_ts_rtc_unload(void)
 static void ts78xx_ts_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 			unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		unsigned char bits;
@@ -200,7 +200,7 @@ static int ts78xx_ts_nand_dev_ready(struct mtd_info *mtd)
 static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
 			const uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	void __iomem *io_base = chip->IO_ADDR_W;
 	unsigned long off = ((unsigned long)buf & 3);
 	int sz;
@@ -227,7 +227,7 @@ static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
 static void ts78xx_ts_nand_read_buf(struct mtd_info *mtd,
 			uint8_t *buf, int len)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	void __iomem *io_base = chip->IO_ADDR_R;
 	unsigned long off = ((unsigned long)buf & 3);
 	int sz;
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index a727282..7734ec4 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -572,7 +572,7 @@ static inline void balloon3_i2c_init(void) {}
 #if defined(CONFIG_MTD_NAND_PLATFORM)||defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
 static void balloon3_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	uint8_t balloon3_ctl_set = 0, balloon3_ctl_clr = 0;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 9d7072b..38600a7 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -289,7 +289,7 @@ static void nand_cs_off(void)
 static void em_x270_nand_cmd_ctl(struct mtd_info *mtd, int dat,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
 
 	dsb();
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 83f830d..d787dd1 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -250,7 +250,7 @@ static inline void palmtx_keys_init(void) {}
 static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	char __iomem *nandaddr = this->IO_ADDR_W;
 
 	if (cmd == NAND_CMD_NONE)
-- 
2.1.4
