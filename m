From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 21/23] mtd: rawnand: Pass a nand_chip object to
 chip->setup_data_interface()
Date: Fri, 17 Aug 2018 18:09:20 +0200
Message-ID: <20180817160922.6224-22-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mans Rullgard <mans@mansr.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, Gregory Clement <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-omap@vger.kernel.org

Let's make the raw NAND API consistent by patching all helpers and
hooks to take a nand_chip object instead of an mtd_info one or
remove the mtd_info object when both are passed.

Let's tackle the chip->setup_data_interface() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 3 +--
 drivers/mtd/nand/raw/denali.c                | 4 ++--
 drivers/mtd/nand/raw/fsmc_nand.c             | 3 +--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c    | 3 +--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h   | 2 +-
 drivers/mtd/nand/raw/marvell_nand.c          | 3 +--
 drivers/mtd/nand/raw/mtk_nand.c              | 4 ++--
 drivers/mtd/nand/raw/mxc_nand.c              | 7 +++----
 drivers/mtd/nand/raw/nand_base.c             | 9 +++------
 drivers/mtd/nand/raw/s3c2410.c               | 3 ++-
 drivers/mtd/nand/raw/sunxi_nand.c            | 3 +--
 drivers/mtd/nand/raw/tango_nand.c            | 3 +--
 drivers/mtd/nand/raw/tegra_nand.c            | 3 +--
 include/linux/mtd/rawnand.h                  | 2 +-
 14 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index f964914cbcf0..8e80a7e78d1b 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1448,10 +1448,9 @@ static int atmel_hsmc_nand_setup_data_interface(struct atmel_nand *nand,
 	return 0;
 }
 
-static int atmel_nand_setup_data_interface(struct mtd_info *mtd, int csline,
+static int atmel_nand_setup_data_interface(struct nand_chip *chip, int csline,
 					const struct nand_data_interface *conf)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_nand_controller *nc;
 
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index fb7d778c3578..e8625d452a37 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -939,10 +939,10 @@ static int denali_erase(struct nand_chip *chip, int page)
 	return irq_status & INTR__ERASE_COMP ? 0 : -EIO;
 }
 
-static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
+static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 				       const struct nand_data_interface *conf)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	const struct nand_sdr_timings *timings;
 	unsigned long t_x, mult_x;
 	int acc_clks, re_2_we, re_2_re, we_2_re, addr_2_data;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 15bf533c907a..5e06fce4b295 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -340,10 +340,9 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 	return 0;
 }
 
-static int fsmc_setup_data_interface(struct mtd_info *mtd, int csline,
+static int fsmc_setup_data_interface(struct nand_chip *nand, int csline,
 				     const struct nand_data_interface *conf)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct fsmc_nand_data *host = nand_get_controller_data(nand);
 	struct fsmc_nand_timings tims;
 	const struct nand_sdr_timings *sdrt;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
index 88ea2203e263..bd4cfac6b5aa 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c
@@ -471,10 +471,9 @@ void gpmi_nfc_apply_timings(struct gpmi_nand_data *this)
 	udelay(dll_wait_time_us);
 }
 
-int gpmi_setup_data_interface(struct mtd_info *mtd, int chipnr,
+int gpmi_setup_data_interface(struct nand_chip *chip, int chipnr,
 			      const struct nand_data_interface *conf)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	const struct nand_sdr_timings *sdr;
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
index 69cd0cbde4f2..d0b79bac2728 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
@@ -178,7 +178,7 @@ int gpmi_is_ready(struct gpmi_nand_data *, unsigned chip);
 int gpmi_send_command(struct gpmi_nand_data *);
 int gpmi_enable_clk(struct gpmi_nand_data *this);
 int gpmi_disable_clk(struct gpmi_nand_data *this);
-int gpmi_setup_data_interface(struct mtd_info *mtd, int chipnr,
+int gpmi_setup_data_interface(struct nand_chip *chip, int chipnr,
 			      const struct nand_data_interface *conf);
 void gpmi_nfc_apply_timings(struct gpmi_nand_data *this);
 int gpmi_read_data(struct gpmi_nand_data *, void *buf, int len);
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 2bde92d0f424..b2f2bede60e6 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2183,11 +2183,10 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = bbt_mirror_pattern
 };
 
-static int marvell_nfc_setup_data_interface(struct mtd_info *mtd, int chipnr,
+static int marvell_nfc_setup_data_interface(struct nand_chip *chip, int chipnr,
 					    const struct nand_data_interface
 					    *conf)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
 	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
 	unsigned int period_ns = 1000000000 / clk_get_rate(nfc->core_clk) * 2;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index cf8c42fb8feb..42f9dc2cd172 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -503,10 +503,10 @@ static void mtk_nfc_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 		mtk_nfc_write_byte(chip, buf[i]);
 }
 
-static int mtk_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
+static int mtk_nfc_setup_data_interface(struct nand_chip *chip, int csline,
 					const struct nand_data_interface *conf)
 {
-	struct mtk_nfc *nfc = nand_get_controller_data(mtd_to_nand(mtd));
+	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 	const struct nand_sdr_timings *timings;
 	u32 rate, tpoecs, tprecs, tc2r, tw2r, twh, twst, trlt;
 
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index ec150e19a368..895f85ee29db 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -137,7 +137,7 @@ struct mxc_nand_devtype_data {
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
 	const struct mtd_ooblayout_ops *ooblayout;
 	void (*select_chip)(struct nand_chip *chip, int cs);
-	int (*setup_data_interface)(struct mtd_info *mtd, int csline,
+	int (*setup_data_interface)(struct nand_chip *chip, int csline,
 				    const struct nand_data_interface *conf);
 	void (*enable_hwecc)(struct nand_chip *chip, bool enable);
 
@@ -1139,11 +1139,10 @@ static void preset_v1(struct mtd_info *mtd)
 	writew(0x4, NFC_V1_V2_WRPROT);
 }
 
-static int mxc_nand_v2_setup_data_interface(struct mtd_info *mtd, int csline,
+static int mxc_nand_v2_setup_data_interface(struct nand_chip *chip, int csline,
 					const struct nand_data_interface *conf)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int tRC_min_ns, tRC_ps, ret;
 	unsigned long rate, rate_round;
 	const struct nand_sdr_timings *timings;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a7575aa68c48..0a89ab663728 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1200,7 +1200,6 @@ EXPORT_SYMBOL_GPL(nand_set_features);
  */
 static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	if (!chip->setup_data_interface)
@@ -1221,7 +1220,7 @@ static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
 	 */
 
 	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
-	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
+	ret = chip->setup_data_interface(chip, chipnr, &chip->data_interface);
 	if (ret)
 		pr_err("Failed to configure data interface to SDR timing mode 0\n");
 
@@ -1243,7 +1242,6 @@ static int nand_reset_data_interface(struct nand_chip *chip, int chipnr)
  */
 static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
 		chip->onfi_timing_mode_default,
 	};
@@ -1263,7 +1261,7 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 	}
 
 	/* Change the mode on the controller side */
-	ret = chip->setup_data_interface(mtd, chipnr, &chip->data_interface);
+	ret = chip->setup_data_interface(chip, chipnr, &chip->data_interface);
 	if (ret)
 		return ret;
 
@@ -1316,7 +1314,6 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
  */
 static int nand_init_data_interface(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	int modes, mode, ret;
 
 	if (!chip->setup_data_interface)
@@ -1345,7 +1342,7 @@ static int nand_init_data_interface(struct nand_chip *chip)
 		 * Pass NAND_DATA_IFACE_CHECK_ONLY to only check if the
 		 * controller supports the requested timings.
 		 */
-		ret = chip->setup_data_interface(mtd,
+		ret = chip->setup_data_interface(chip,
 						 NAND_DATA_IFACE_CHECK_ONLY,
 						 &chip->data_interface);
 		if (!ret) {
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 1d549f5e53f5..1f70eb35320b 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -820,9 +820,10 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 	return -ENODEV;
 }
 
-static int s3c2410_nand_setup_data_interface(struct mtd_info *mtd, int csline,
+static int s3c2410_nand_setup_data_interface(struct nand_chip *chip, int csline,
 					const struct nand_data_interface *conf)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	struct s3c2410_platform_nand *pdata = info->platform;
 	const struct nand_sdr_timings *timings;
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index fe30fb589ffb..a3700b79bdeb 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1468,10 +1468,9 @@ static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
 #define sunxi_nand_lookup_timing(l, p, c) \
 			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
 
-static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
+static int sunxi_nfc_setup_data_interface(struct nand_chip *nand, int csline,
 					const struct nand_data_interface *conf)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *chip = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->nand.controller);
 	const struct nand_sdr_timings *timings;
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index c21a0f2d26fc..bf7012099790 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -479,11 +479,10 @@ static u32 to_ticks(int kHz, int ps)
 	return DIV_ROUND_UP_ULL((u64)kHz * ps, NSEC_PER_SEC);
 }
 
-static int tango_set_timings(struct mtd_info *mtd, int csline,
+static int tango_set_timings(struct nand_chip *chip, int csline,
 			     const struct nand_data_interface *conf)
 {
 	const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct tango_nfc *nfc = to_tango_nfc(chip->controller);
 	struct tango_chip *tchip = to_tango_chip(chip);
 	u32 Trdy, Textw, Twc, Twpw, Tacc, Thold, Trpw, Textr;
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 1088741eed1d..9767e29d74e2 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -814,10 +814,9 @@ static void tegra_nand_setup_timing(struct tegra_nand_controller *ctrl,
 	writel_relaxed(reg, ctrl->regs + TIMING_2);
 }
 
-static int tegra_nand_setup_data_interface(struct mtd_info *mtd, int csline,
+static int tegra_nand_setup_data_interface(struct nand_chip *chip, int csline,
 					const struct nand_data_interface *conf)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 	const struct nand_sdr_timings *timings;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6f5e7ea36dab..7df3e29a1f83 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1304,7 +1304,7 @@ struct nand_chip {
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
 			    uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
-	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
+	int (*setup_data_interface)(struct nand_chip *chip, int chipnr,
 				    const struct nand_data_interface *conf);
 
 	int chip_delay;
-- 
2.14.1
