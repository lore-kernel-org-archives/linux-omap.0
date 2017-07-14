From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: hsmmc.c: Remove dead code
Date: Fri, 14 Jul 2017 18:16:43 +0530
Message-ID: <1500036404-5556-2-git-send-email-faiz_abbas@ti.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, nsekhar@ti.com, linux@armlinux.org.uk, kishon@ti.com, peter.ujfalusi@ti.com, Faiz Abbas <faiz_abbas@ti.com>, rk@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hkallweit1@gmail.com
List-Id: linux-omap@vger.kernel.org

Most platforms using OMAP hsmmc driver have switched to device tree
for passing platform data to omap_hsmmc.c driver.

The hsmmc.c file in mach-omap2 exists only to support pandora board
which uses wl1251 driver in legacy platform data mode.

Hence, remove the dead code not used by the pandora board.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
This is only compile tested. Someone with a pandora board should help
test this for functionality.

 arch/arm/mach-omap2/hsmmc.c | 239 +-------------------------------------------
 arch/arm/mach-omap2/hsmmc.h |   9 --
 2 files changed, 2 insertions(+), 246 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index be517b0..5b61438 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,120 +32,6 @@ static u16 control_devconf1_offset;
 
 #define HSMMC_NAME_LEN	9
 
-static void omap_hsmmc1_before_set_reg(struct device *dev,
-				       int power_on, int vdd)
-{
-	u32 reg, prog_io;
-	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
-
-	if (mmc->remux)
-		mmc->remux(dev, power_on);
-
-	/*
-	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
-	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
-	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
-	 *
-	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
-	 * is most naturally TWL VSIM; those pins also use PBIAS.
-	 *
-	 * FIXME handle VMMC1A as needed ...
-	 */
-	if (power_on) {
-		if (cpu_is_omap2430()) {
-			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
-			if ((1 << vdd) >= MMC_VDD_30_31)
-				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
-			else
-				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
-			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
-		}
-
-		if (mmc->internal_clock) {
-			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
-			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
-		}
-
-		reg = omap_ctrl_readl(control_pbias_offset);
-		if (cpu_is_omap3630()) {
-			/* Set MMC I/O to 52MHz */
-			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
-			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
-			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
-		} else {
-			reg |= OMAP2_PBIASSPEEDCTRL0;
-		}
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-	} else {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-	}
-}
-
-static void omap_hsmmc1_after_set_reg(struct device *dev, int power_on, int vdd)
-{
-	u32 reg;
-
-	/* 100ms delay required for PBIAS configuration */
-	msleep(100);
-
-	if (power_on) {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if ((1 << vdd) <= MMC_VDD_165_195)
-			reg &= ~OMAP2_PBIASLITEVMODE0;
-		else
-			reg |= OMAP2_PBIASLITEVMODE0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-	} else {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
-			OMAP2_PBIASLITEVMODE0);
-		omap_ctrl_writel(reg, control_pbias_offset);
-	}
-}
-
-static void hsmmc2_select_input_clk_src(struct omap_hsmmc_platform_data *mmc)
-{
-	u32 reg;
-
-	reg = omap_ctrl_readl(control_devconf1_offset);
-	if (mmc->internal_clock)
-		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-	else
-		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
-	omap_ctrl_writel(reg, control_devconf1_offset);
-}
-
-static void hsmmc2_before_set_reg(struct device *dev, int power_on, int vdd)
-{
-	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
-
-	if (mmc->remux)
-		mmc->remux(dev, power_on);
-
-	if (power_on)
-		hsmmc2_select_input_clk_src(mmc);
-}
-
-static int am35x_hsmmc2_set_power(struct device *dev, int power_on, int vdd)
-{
-	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
-
-	if (power_on)
-		hsmmc2_select_input_clk_src(mmc);
-
-	return 0;
-}
-
-static int nop_mmc_set_power(struct device *dev, int power_on, int vdd)
-{
-	return 0;
-}
-
 static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 					struct omap_hsmmc_platform_data *mmc)
 {
@@ -157,101 +43,11 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		return -ENOMEM;
 	}
 
-	if (c->name)
-		strncpy(hc_name, c->name, HSMMC_NAME_LEN);
-	else
-		snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i",
-								c->mmc, 1);
+	snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i", c->mmc, 1);
 	mmc->name = hc_name;
 	mmc->caps = c->caps;
-	mmc->internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
 
-	if (c->cover_only) {
-		/* detect if mobile phone cover removed */
-		mmc->gpio_cd = -EINVAL;
-		mmc->gpio_cod = c->gpio_cd;
-	} else {
-		/* card detect pin on the mmc socket itself */
-		mmc->gpio_cd = c->gpio_cd;
-		mmc->gpio_cod = -EINVAL;
-	}
-	mmc->gpio_wp = c->gpio_wp;
-
-	mmc->remux = c->remux;
-	mmc->init_card = c->init_card;
-
-	if (c->nonremovable)
-		mmc->nonremovable = 1;
-
-	/*
-	 * NOTE:  MMC slots should have a Vcc regulator set up.
-	 * This may be from a TWL4030-family chip, another
-	 * controllable regulator, or a fixed supply.
-	 *
-	 * temporary HACK: ocr_mask instead of fixed supply
-	 */
-	if (soc_is_am35xx())
-		mmc->ocr_mask = MMC_VDD_165_195 |
-					 MMC_VDD_26_27 |
-					 MMC_VDD_27_28 |
-					 MMC_VDD_29_30 |
-					 MMC_VDD_30_31 |
-					 MMC_VDD_31_32;
-	else
-		mmc->ocr_mask = c->ocr_mask;
-
-	if (!soc_is_am35xx())
-		mmc->features |= HSMMC_HAS_PBIAS;
-
-	switch (c->mmc) {
-	case 1:
-		if (mmc->features & HSMMC_HAS_PBIAS) {
-			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			mmc->before_set_reg =
-					omap_hsmmc1_before_set_reg;
-			mmc->after_set_reg =
-					omap_hsmmc1_after_set_reg;
-		}
-
-		if (soc_is_am35xx())
-			mmc->set_power = nop_mmc_set_power;
-
-		/* OMAP3630 HSMMC1 supports only 4-bit */
-		if (cpu_is_omap3630() &&
-				(c->caps & MMC_CAP_8_BIT_DATA)) {
-			c->caps &= ~MMC_CAP_8_BIT_DATA;
-			c->caps |= MMC_CAP_4_BIT_DATA;
-			mmc->caps = c->caps;
-		}
-		break;
-	case 2:
-		if (soc_is_am35xx())
-			mmc->set_power = am35x_hsmmc2_set_power;
-
-		if (c->ext_clock)
-			c->transceiver = 1;
-		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
-			c->caps &= ~MMC_CAP_8_BIT_DATA;
-			c->caps |= MMC_CAP_4_BIT_DATA;
-		}
-		if (mmc->features & HSMMC_HAS_PBIAS) {
-			/* off-chip level shifting, or none */
-			mmc->before_set_reg = hsmmc2_before_set_reg;
-			mmc->after_set_reg = NULL;
-		}
-		break;
-	case 3:
-	case 4:
-	case 5:
-		mmc->before_set_reg = NULL;
-		mmc->after_set_reg = NULL;
-		break;
-	default:
-		pr_err("MMC%d configuration not supported!\n", c->mmc);
-		kfree(hc_name);
-		return -ENODEV;
-	}
 	return 0;
 }
 
@@ -260,7 +56,6 @@ static int omap_hsmmc_done;
 void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 {
 	struct platform_device *pdev;
-	struct omap_hsmmc_platform_data *mmc_pdata;
 	int res;
 
 	if (omap_hsmmc_done != 1)
@@ -269,32 +64,12 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 	omap_hsmmc_done++;
 
 	for (; c->mmc; c++) {
-		if (!c->deferred)
-			continue;
-
 		pdev = c->pdev;
 		if (!pdev)
 			continue;
-
-		mmc_pdata = pdev->dev.platform_data;
-		if (!mmc_pdata)
-			continue;
-
-		if (c->cover_only) {
-			/* detect if mobile phone cover removed */
-			mmc_pdata->gpio_cd = -EINVAL;
-			mmc_pdata->gpio_cod = c->gpio_cd;
-		} else {
-			/* card detect pin on the mmc socket itself */
-			mmc_pdata->gpio_cd = c->gpio_cd;
-			mmc_pdata->gpio_cod = -EINVAL;
-		}
-		mmc_pdata->gpio_wp = c->gpio_wp;
-
 		res = omap_device_register(pdev);
 		if (res)
-			pr_err("Could not late init MMC %s\n",
-			       c->name);
+			pr_err("Could not late init MMC\n");
 	}
 }
 
@@ -336,13 +111,6 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	if (oh->dev_attr != NULL) {
 		mmc_dev_attr = oh->dev_attr;
 		mmc_data->controller_flags = mmc_dev_attr->flags;
-		/*
-		 * erratum 2.1.1.128 doesn't apply if board has
-		 * a transceiver is attached
-		 */
-		if (hsmmcinfo->transceiver)
-			mmc_data->controller_flags &=
-				~OMAP_HSMMC_BROKEN_MULTIBLOCK_READ;
 	}
 
 	pdev = platform_device_alloc(name, ctrl_nr - 1);
@@ -367,9 +135,6 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 
 	hsmmcinfo->pdev = pdev;
 
-	if (hsmmcinfo->deferred)
-		goto free_mmc;
-
 	res = omap_device_register(pdev);
 	if (res) {
 		pr_err("Could not register od for %s\n", name);
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 69b619d..af9af50 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -12,18 +12,9 @@ struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u32	caps;		/* 4/8 wires and any additional host
 				 * capabilities OR'd (ref. linux/mmc/host.h) */
-	bool	transceiver;	/* MMC-2 option */
-	bool	ext_clock;	/* use external pin for input clock */
-	bool	cover_only;	/* No card detect - just cover switch */
-	bool	nonremovable;	/* Nonremovable e.g. eMMC */
-	bool	deferred;	/* mmc needs a deferred probe */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
-	char	*name;		/* or NULL for default */
 	struct platform_device *pdev;	/* mmc controller instance */
-	int	ocr_mask;	/* temporary HACK */
-	/* Remux (pad configuration) when powering on/off */
-	void (*remux)(struct device *dev, int power_on);
 	/* init some special card */
 	void (*init_card)(struct mmc_card *card);
 };
-- 
2.7.4
