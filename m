From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git 1/2] mmc-twl4030 gpios for all controllers
Date: Fri, 7 Nov 2008 11:55:54 -0800
Message-ID: <200811071155.55180.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:33073 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751212AbYKGT7v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 14:59:51 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More HSMMC gpio updates: make the card detect and write protect
handling behave for slots connected to any controller (not just
for MMC1), and for non-twl4030 GPIOs.

It packs some structs more efficiently, and updates mmc platform
data to remember the relevant GPIOs.  It also adds some error
checks.

This removes debouncing, so it goes along with a following patch
to change how twl4030 debouncing kicks in.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Goes on top of the patch I sent yesterday.

So the remaining notably-messy bits of mmc-twl4030 glue seem
to be lack of MMC3 support, and the voltage regulator stuff
hard-wiring knowledge and not using drivers/regulator.

 arch/arm/mach-omap2/mmc-twl4030.c     |  152 +++++++++++++++++---------------
 arch/arm/plat-omap/include/mach/mmc.h |   12 +-
 2 files changed, 92 insertions(+), 72 deletions(-)

--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -51,77 +51,97 @@
 
 static u16 control_pbias_offset;
 
+#define HSMMC_NAME_LEN	9
+
 static struct twl_mmc_controller {
-	u16		control_devconf_offset;
+	struct omap_mmc_platform_data	*mmc;
 	u32		devconf_loopback_clock;
-	int		card_detect_gpio;
-	unsigned	card_wp_gpio;
+	u16		control_devconf_offset;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
+	char		name[HSMMC_NAME_LEN];
 } hsmmc[] = {
 	{
 		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
 		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
-		.card_detect_gpio		= -EINVAL,
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC1_DEDICATED,
 	},
 	{
 		/* control_devconf_offset set dynamically */
 		.devconf_loopback_clock		= OMAP2_MMCSDIO2ADPCLKISEL,
-		.card_detect_gpio		= -EINVAL,
 		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC2_DEDICATED,
 	},
 };
 
-static int twl_mmc1_card_detect(int irq)
+static int twl_mmc_card_detect(int irq)
 {
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(hsmmc[0].card_detect_gpio);
+	unsigned i;
+
+	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
+		struct omap_mmc_platform_data *mmc;
+
+		mmc = hsmmc[i].mmc;
+		if (!mmc)
+			continue;
+		if (irq != mmc->slots[0].card_detect_irq)
+			continue;
+
+		/* NOTE: assumes card detect signal is active-low */
+		return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+	}
+	return -ENOSYS;
 }
 
-static int twl_mmc1_get_ro(struct device *dev, int slot)
+static int twl_mmc_get_ro(struct device *dev, int slot)
 {
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
 	/* NOTE: assumes write protect signal is active-high */
-	return gpio_get_value_cansleep(hsmmc[0].card_wp_gpio);
+	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
 }
 
 /*
  * MMC Slot Initialization.
  */
-static int twl_mmc1_late_init(struct device *dev)
+static int twl_mmc_late_init(struct device *dev)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 	int ret = 0;
+	int i;
 
-	ret = gpio_request(hsmmc[0].card_detect_gpio, "mmc0_cd");
+	ret = gpio_request(mmc->slots[0].switch_pin, "mmc_cd");
 	if (ret)
 		goto done;
-	ret = gpio_direction_input(hsmmc[0].card_detect_gpio);
+	ret = gpio_direction_input(mmc->slots[0].switch_pin);
 	if (ret)
 		goto err;
 
-	/* FIXME assumes this uses (a) TWL4030 and (b) GPIO-0 ...
-	 * but that's not actually required.
-	 */
-	ret = twl4030_set_gpio_debounce(0, true);
-	if (ret)
-		goto err;
+	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
+		if (hsmmc[i].name == mmc->slots[0].name) {
+			hsmmc[i].mmc = mmc;
+			break;
+		}
+	}
 
-	return ret;
+	return 0;
 
 err:
-	dev_err(dev, "Failed to configure TWL4030 card detect\n");
+	gpio_free(mmc->slots[0].switch_pin);
 done:
 	mmc->slots[0].card_detect_irq = 0;
 	mmc->slots[0].card_detect = NULL;
+
+	dev_err(dev, "err %d configuring card detect\n", ret);
 	return ret;
 }
 
-static void twl_mmc1_cleanup(struct device *dev)
+static void twl_mmc_cleanup(struct device *dev)
 {
-	gpio_free(hsmmc[0].card_detect_gpio);
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	gpio_free(mmc->slots[0].switch_pin);
 }
 
 #ifdef CONFIG_PM
@@ -296,25 +316,34 @@ static int twl_mmc2_set_power(struct dev
 	return ret;
 }
 
-static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC];
-
-#define HSMMC_NAME_LEN	9
+static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init hsmmc_init(struct twl4030_hsmmc_info *controllers)
 {
 	struct twl4030_hsmmc_info *c;
+	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
 
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
 		hsmmc[1].control_devconf_offset = OMAP243X_CONTROL_DEVCONF1;
+		nr_hsmmc = 2;
 	} else {
 		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
 		hsmmc[1].control_devconf_offset = OMAP343X_CONTROL_DEVCONF1;
 	}
 
 	for (c = controllers; c->mmc; c++) {
-		struct omap_mmc_platform_data *mmc;
-		char *name;
+		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
+		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
+
+		if (!c->mmc || c->mmc > nr_hsmmc) {
+			pr_debug("MMC%d: no such controller\n", c->mmc);
+			continue;
+		}
+		if (mmc) {
+			pr_debug("MMC%d: already configured\n", c->mmc);
+			continue;
+		}
 
 		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
 		if (!mmc) {
@@ -322,15 +351,8 @@ void __init hsmmc_init(struct twl4030_hs
 			return;
 		}
 
-		name = kzalloc(HSMMC_NAME_LEN, GFP_KERNEL);
-		if (!name) {
-			kfree(mmc);
-			pr_err("Cannot allocate memory for mmc name!\n");
-			return;
-		}
-
-		sprintf(name, "mmc%islot%i", c->mmc, 1);
-		mmc->slots[0].name = name;
+		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
+		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
 					MMC_VDD_26_27 | MMC_VDD_27_28 |
@@ -339,6 +361,29 @@ void __init hsmmc_init(struct twl4030_hs
 		mmc->slots[0].wires = c->wires;
 		mmc->dma_mask = 0xffffffff;
 
+		/* note: twl4030 card detect GPIOs normally switch VMMCx ... */
+		if (gpio_is_valid(c->gpio_cd)) {
+			mmc->init = twl_mmc_late_init;
+			mmc->cleanup = twl_mmc_cleanup;
+			mmc->suspend = twl_mmc_suspend;
+			mmc->resume = twl_mmc_resume;
+
+			mmc->slots[0].switch_pin = c->gpio_cd;
+			mmc->slots[0].card_detect_irq = gpio_to_irq(c->gpio_cd);
+			mmc->slots[0].card_detect = twl_mmc_card_detect;
+		} else
+			mmc->slots[0].switch_pin = -EINVAL;
+
+		/* write protect normally uses an OMAP gpio */
+		if (gpio_is_valid(c->gpio_wp)) {
+			gpio_request(c->gpio_wp, "mmc_wp");
+			gpio_direction_input(c->gpio_wp);
+
+			mmc->slots[0].gpio_wp = c->gpio_wp;
+			mmc->slots[0].get_ro = twl_mmc_get_ro;
+		} else
+			mmc->slots[0].gpio_wp = -EINVAL;
+
 		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
 		 * the TWL4030's VMMC1 and VMMC2, respectively;
 		 * and that OMAP's MMC3 isn't used.
@@ -347,44 +392,15 @@ void __init hsmmc_init(struct twl4030_hs
 		switch (c->mmc) {
 		case 1:
 			mmc->slots[0].set_power = twl_mmc1_set_power;
-			if (gpio_is_valid(c->gpio_cd)) {
-				mmc->slots[0].card_detect_irq =
-						gpio_to_irq(c->gpio_cd);
-				mmc->suspend = twl_mmc_suspend;
-				mmc->resume = twl_mmc_resume;
-
-				/* NOTE: hsmmc[0] is hard-wired ... */
-				hsmmc[0].card_detect_gpio = c->gpio_cd;
-				mmc->init = twl_mmc1_late_init;
-				mmc->cleanup = twl_mmc1_cleanup;
-				mmc->slots[0].card_detect =
-						twl_mmc1_card_detect;
-			}
-			if (gpio_is_valid(c->gpio_wp)) {
-				gpio_request(c->gpio_wp, "mmc0_wp");
-				gpio_direction_input(c->gpio_wp);
-
-				/* NOTE: hsmmc[0] is hard-wired ... */
-				hsmmc[0].card_wp_gpio = c->gpio_wp;
-				mmc->slots[0].get_ro = twl_mmc1_get_ro;
-			}
-			hsmmc_data[0] = mmc;
 			break;
 		case 2:
-			/* FIXME rework interfaces so that mmc2 (and mmc3) can
-			 * be fully functional... hsmmc[] shouldn't hold gpios.
-			 */
 			mmc->slots[0].set_power = twl_mmc2_set_power;
-			if (gpio_is_valid(c->gpio_cd))
-				pr_warning("MMC2 detect nyet supported!\n");
-			if (gpio_is_valid(c->gpio_wp))
-				pr_warning("MMC2 WP nyet supported!\n");
-			hsmmc_data[1] = mmc;
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
-			return;
+			continue;
 		}
+		hsmmc_data[c->mmc - 1] = mmc;
 	}
 
 	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -61,6 +61,11 @@ struct omap_mmc_platform_data {
 
 	struct omap_mmc_slot_data {
 
+		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
+		 * 8 wire signaling is also optional, and is used with HSMMC
+		 */
+		u8 wires;
+
 		/*
 		 * nomux means "standard" muxing is wrong on this board, and
 		 * that board-specific code handled it before common init logic.
@@ -70,13 +75,12 @@ struct omap_mmc_platform_data {
 		/* switch pin can be for card detect (default) or card cover */
 		unsigned cover:1;
 
-		/* 4 wire signaling is optional, and is only used for SD/SDIO */
-		u8 wires;
-
 		/* use the internal clock */
 		unsigned internal_clock:1;
 		s16 power_pin;
-		s16 switch_pin;
+
+		int switch_pin;			/* gpio (card detect) */
+		int gpio_wp;			/* gpio (write protect) */
 
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);
