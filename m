From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP3: mmc-twl4030 uses regulator framework
Date: Mon, 25 May 2009 10:48:21 -0700
Message-ID: <20090525174821.19679.1412.stgit@localhost>
References: <20090525174517.19679.18805.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49695 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZEYRsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:48:21 -0400
In-Reply-To: <20090525174517.19679.18805.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>

From: David Brownell <dbrownell@users.sourceforge.net>

Decouple the HSMMC glue from the twl4030 as the only
regulator provider, using the regulator framework instead.
This makes the glue's "mmc-twl4030" name become a complete
misnomer ... this code could probably all migrate into the
HSMMC driver now.

Tested on 3430SDP (SD and low-voltage MMC) and Beagle (SD),
plus some other boards (including Overo) after they were
converted to set up MMC regulators properly.

Eventually all boards should just associate a regulator with
each MMC controller they use.  In some cases (Overo MMC2 and
Pandora MMC3, at least) that would be a fixed-voltage regulator
with no real software control.  As a temporary hack (pending
regulator-next updates to make the "fixed.c" regulator become
usable) there's a new ocr_mask field for those boards.

Patch updated with a fix for disabling vcc_aux by
Adrian Hunter <adrian.hunter@nokia.com>

Cc: Pierre Ossman <drzeus-list@drzeus.cx>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |  280 +++++++++++++++----------------------
 arch/arm/mach-omap2/mmc-twl4030.h |    3 
 drivers/mmc/host/omap_hsmmc.c     |    6 -
 3 files changed, 118 insertions(+), 171 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index dc40b3e..5524cfa 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -16,8 +16,8 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl4030.h>
-#include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
+#include <linux/regulator/consumer.h>
 
 #include <mach/hardware.h>
 #include <mach/control.h>
@@ -26,31 +26,9 @@
 
 #include "mmc-twl4030.h"
 
-#if defined(CONFIG_TWL4030_CORE) && \
-	(defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE))
 
-#define LDO_CLR			0x00
-#define VSEL_S2_CLR		0x40
-
-#define VMMC1_DEV_GRP		0x27
-#define VMMC1_CLR		0x00
-#define VMMC1_315V		0x03
-#define VMMC1_300V		0x02
-#define VMMC1_285V		0x01
-#define VMMC1_185V		0x00
-#define VMMC1_DEDICATED		0x2A
-
-#define VMMC2_DEV_GRP		0x2B
-#define VMMC2_CLR		0x40
-#define VMMC2_315V		0x0c
-#define VMMC2_300V		0x0b
-#define VMMC2_285V		0x0a
-#define VMMC2_280V		0x09
-#define VMMC2_260V		0x08
-#define VMMC2_185V		0x06
-#define VMMC2_DEDICATED		0x2E
-
-#define VMMC_DEV_GRP_P1		0x20
+#if defined(CONFIG_REGULATOR) && \
+	(defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE))
 
 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
@@ -59,19 +37,16 @@ static u16 control_devconf1_offset;
 
 static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
-	u8		twl_vmmc_dev_grp;
-	u8		twl_mmc_dedicated;
-	char		name[HSMMC_NAME_LEN + 1];
-} hsmmc[OMAP34XX_NR_MMC] = {
-	{
-		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
-		.twl_mmc_dedicated		= VMMC1_DEDICATED,
-	},
-	{
-		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
-		.twl_mmc_dedicated		= VMMC2_DEDICATED,
-	},
-};
+	/* Vcc == configured supply
+	 * Vcc_alt == optional
+	 *   -	MMC1, supply for DAT4..DAT7
+	 *   -	MMC2/MMC2, external level shifter voltage supply, for
+	 *	chip (SDIO, eMMC, etc) or transceiver (MMC2 only)
+	 */
+	struct regulator		*vcc;
+	struct regulator		*vcc_aux;
+	char				name[HSMMC_NAME_LEN + 1];
+} hsmmc[OMAP34XX_NR_MMC];
 
 static int twl_mmc_card_detect(int irq)
 {
@@ -117,16 +92,60 @@ static int twl_mmc_late_init(struct device *dev)
 	int ret = 0;
 	int i;
 
-	ret = gpio_request(mmc->slots[0].switch_pin, "mmc_cd");
-	if (ret)
-		goto done;
-	ret = gpio_direction_input(mmc->slots[0].switch_pin);
-	if (ret)
-		goto err;
+	/* MMC/SD/SDIO doesn't require a card detect switch */
+	if (gpio_is_valid(mmc->slots[0].switch_pin)) {
+		ret = gpio_request(mmc->slots[0].switch_pin, "mmc_cd");
+		if (ret)
+			goto done;
+		ret = gpio_direction_input(mmc->slots[0].switch_pin);
+		if (ret)
+			goto err;
+	}
 
+	/* require at least main regulator */
 	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
 		if (hsmmc[i].name == mmc->slots[0].name) {
+			struct regulator *reg;
+
 			hsmmc[i].mmc = mmc;
+
+			reg = regulator_get(dev, "vmmc");
+			if (IS_ERR(reg)) {
+				dev_dbg(dev, "vmmc regulator missing\n");
+				/* HACK: until fixed.c regulator is usable,
+				 * we don't require a main regulator
+				 * for MMC2 or MMC3
+				 */
+				if (i != 0)
+					break;
+				ret = PTR_ERR(reg);
+				goto err;
+			}
+			hsmmc[i].vcc = reg;
+			mmc->slots[0].ocr_mask = mmc_regulator_get_ocrmask(reg);
+
+			/* allow an aux regulator */
+			reg = regulator_get(dev, "vmmc_aux");
+			hsmmc[i].vcc_aux = IS_ERR(reg) ? NULL : reg;
+
+			/* UGLY HACK:  workaround regulator framework bugs.
+			 * When the bootloader leaves a supply active, it's
+			 * initialized with zero usecount ... and we can't
+			 * disable it without first disabling it.  Until the
+			 * framework is fixed, we need a workaround like this
+			 * (which is safe for MMC, but not in general).
+			 */
+			if (regulator_is_enabled(hsmmc[i].vcc) > 0) {
+				regulator_enable(hsmmc[i].vcc);
+				regulator_disable(hsmmc[i].vcc);
+			}
+			if (hsmmc[i].vcc_aux) {
+				if (regulator_is_enabled(reg) > 0) {
+					regulator_enable(reg);
+					regulator_disable(reg);
+				}
+			}
+
 			break;
 		}
 	}
@@ -173,96 +192,6 @@ static int twl_mmc_resume(struct device *dev, int slot)
 #define twl_mmc_resume	NULL
 #endif
 
-/*
- * Sets the MMC voltage in twl4030
- */
-
-#define MMC1_OCR	(MMC_VDD_165_195 \
-		|MMC_VDD_28_29|MMC_VDD_29_30|MMC_VDD_30_31|MMC_VDD_31_32)
-#define MMC2_OCR	(MMC_VDD_165_195 \
-		|MMC_VDD_25_26|MMC_VDD_26_27|MMC_VDD_27_28 \
-		|MMC_VDD_28_29|MMC_VDD_29_30|MMC_VDD_30_31|MMC_VDD_31_32)
-
-static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
-{
-	int ret;
-	u8 vmmc = 0, dev_grp_val;
-
-	if (!vdd)
-		goto doit;
-
-	if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP) {
-		/* VMMC1:  max 220 mA.  And for 8-bit mode,
-		 * VSIM:  max 50 mA
-		 */
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-			vmmc = VMMC1_185V;
-			/* and VSIM_180V */
-			break;
-		case MMC_VDD_28_29:
-			vmmc = VMMC1_285V;
-			/* and VSIM_280V */
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			vmmc = VMMC1_300V;
-			/* and VSIM_300V */
-			break;
-		case MMC_VDD_31_32:
-			vmmc = VMMC1_315V;
-			/* error if VSIM needed */
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else if (c->twl_vmmc_dev_grp == VMMC2_DEV_GRP) {
-		/* VMMC2:  max 100 mA */
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-			vmmc = VMMC2_185V;
-			break;
-		case MMC_VDD_25_26:
-		case MMC_VDD_26_27:
-			vmmc = VMMC2_260V;
-			break;
-		case MMC_VDD_27_28:
-			vmmc = VMMC2_280V;
-			break;
-		case MMC_VDD_28_29:
-			vmmc = VMMC2_285V;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			vmmc = VMMC2_300V;
-			break;
-		case MMC_VDD_31_32:
-			vmmc = VMMC2_315V;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		return -EINVAL;
-	}
-
-doit:
-	if (vdd)
-		dev_grp_val = VMMC_DEV_GRP_P1;	/* Power up */
-	else
-		dev_grp_val = LDO_CLR;		/* Power down */
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					dev_grp_val, c->twl_vmmc_dev_grp);
-	if (ret || !vdd)
-		return ret;
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					vmmc, c->twl_mmc_dedicated);
-
-	return ret;
-}
-
 static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
@@ -273,11 +202,13 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
-	 * card using the same TWL VMMC1 supply (hsmmc[0]); OMAP has both
+	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
 	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
 	 *
 	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
 	 * is most naturally TWL VSIM; those pins also use PBIAS.
+	 *
+	 * FIXME handle VMMC1A as needed ...
 	 */
 	if (power_on) {
 		if (cpu_is_omap2430()) {
@@ -300,7 +231,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 
-		ret = twl_mmc_set_voltage(c, vdd);
+		ret = mmc_regulator_set_ocr(c->vcc, vdd);
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
@@ -316,7 +247,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 
-		ret = twl_mmc_set_voltage(c, 0);
+		ret = mmc_regulator_set_ocr(c->vcc, 0);
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
@@ -329,19 +260,33 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 	return ret;
 }
 
-static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
+static int twl_mmc23_set_power(struct device *dev, int slot, int power_on, int vdd)
 {
-	int ret;
+	int ret = 0;
 	struct twl_mmc_controller *c = &hsmmc[1];
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	/* If we don't see a Vcc regulator, assume it's a fixed
+	 * voltage always-on regulator.
+	 */
+	if (!c->vcc)
+		return 0;
+
 	/*
-	 * Assume TWL VMMC2 (hsmmc[1]) is used only to power the card ... OMAP
+	 * Assume Vcc regulator is used only to power the card ... OMAP
 	 * VDDS is used to power the pins, optionally with a transceiver to
 	 * support cards using voltages other than VDDS (1.8V nominal).  When a
 	 * transceiver is used, DAT3..7 are muxed as transceiver control pins.
+	 *
+	 * In some cases this regulator won't support enable/disable;
+	 * e.g. it's a fixed rail for a WLAN chip.
+	 *
+	 * In other cases vcc_aux switches interface power.  Example, for
+	 * eMMC cards it represents VccQ.  Sometimes transceivers or SDIO
+	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
+		/* only MMC2 supports a CLKIN */
 		if (mmc->slots[0].internal_clock) {
 			u32 reg;
 
@@ -349,24 +294,23 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
 			omap_ctrl_writel(reg, control_devconf1_offset);
 		}
-		ret = twl_mmc_set_voltage(c, vdd);
+		ret = mmc_regulator_set_ocr(c->vcc, vdd);
+		/* enable interface voltage rail, if needed */
+		if (ret == 0 && c->vcc_aux) {
+			ret = regulator_enable(c->vcc_aux);
+			if (ret < 0)
+				ret = mmc_regulator_set_ocr(c->vcc, 0);
+		}
 	} else {
-		ret = twl_mmc_set_voltage(c, 0);
+		if (c->vcc_aux && (ret = regulator_is_enabled(c->vcc_aux)) > 0)
+			ret = regulator_disable(c->vcc_aux);
+		if (ret == 0)
+			ret = mmc_regulator_set_ocr(c->vcc, 0);
 	}
 
 	return ret;
 }
 
-static int twl_mmc3_set_power(struct device *dev, int slot, int power_on,
-		int vdd)
-{
-	/*
-	 * Assume MMC3 has self-powered device connected, for example on-board
-	 * chip with external power source.
-	 */
-	return 0;
-}
-
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
@@ -412,10 +356,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
+		mmc->init = twl_mmc_late_init;
 
-		/* note: twl4030 card detect GPIOs normally switch VMMCx ... */
+		/* note: twl4030 card detect GPIOs can disable VMMCx ... */
 		if (gpio_is_valid(c->gpio_cd)) {
-			mmc->init = twl_mmc_late_init;
 			mmc->cleanup = twl_mmc_cleanup;
 			mmc->suspend = twl_mmc_suspend;
 			mmc->resume = twl_mmc_resume;
@@ -439,26 +383,28 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		} else
 			mmc->slots[0].gpio_wp = -EINVAL;
 
-		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
-		 * the TWL4030's VMMC1 and VMMC2, respectively;
-		 * and that MMC3 device has it's own power source.
+		/* NOTE:  MMC slots should have a Vcc regulator set up.
+		 * This may be from a TWL4030-family chip, another
+		 * controllable regulator, or a fixed supply.
+		 *
+		 * temporary HACK: ocr_mask instead of fixed supply
 		 */
+		mmc->slots[0].ocr_mask = c->ocr_mask;
 
 		switch (c->mmc) {
 		case 1:
+			/* on-chip level shifting via PBIAS0/PBIAS1 */
 			mmc->slots[0].set_power = twl_mmc1_set_power;
-			mmc->slots[0].ocr_mask = MMC1_OCR;
 			break;
 		case 2:
-			mmc->slots[0].set_power = twl_mmc2_set_power;
-			if (c->transceiver)
-				mmc->slots[0].ocr_mask = MMC2_OCR;
-			else
-				mmc->slots[0].ocr_mask = MMC_VDD_165_195;
-			break;
+			if (c->ext_clock)
+				c->transceiver = 1;
+			if (c->transceiver && c->wires > 4)
+				c->wires = 4;
+			/* FALLTHROUGH */
 		case 3:
-			mmc->slots[0].set_power = twl_mmc3_set_power;
-			mmc->slots[0].ocr_mask = MMC_VDD_165_195;
+			/* off-chip level shifting, or none */
+			mmc->slots[0].set_power = twl_mmc23_set_power;
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index ea59e86..3807c45 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -16,9 +16,10 @@ struct twl4030_hsmmc_info {
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
+	int	ocr_mask;	/* temporary HACK */
 };
 
-#if	defined(CONFIG_TWL4030_CORE) && \
+#if defined(CONFIG_REGULATOR) && \
 	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	 defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE))
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e62a22a..2f19c63 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1073,7 +1073,6 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	mmc->ocr_avail = mmc_slot(host).ocr_mask;
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
 
 	if (pdata->slots[host->slot_id].wires >= 8)
@@ -1110,13 +1109,14 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/* initialize power supplies, gpios, etc */
 	if (pdata->init != NULL) {
 		if (pdata->init(&pdev->dev) != 0) {
-			dev_dbg(mmc_dev(host->mmc),
-				"Unable to configure MMC IRQs\n");
+			dev_dbg(mmc_dev(host->mmc), "late init error\n");
 			goto err_irq_cd_init;
 		}
 	}
+	mmc->ocr_avail = mmc_slot(host).ocr_mask;
 
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq)) {

