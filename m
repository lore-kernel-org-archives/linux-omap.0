From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git] hsmmc gpio updates
Date: Thu, 6 Nov 2008 21:15:30 -0800
Message-ID: <200811062115.30519.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:25023 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750771AbYKGFPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 00:15:33 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Rework card detect GPIO handling in the twl4030 MMC glue:  drive
it *only* from the hsmmc_info passed; remove most of remaining
"we know we're always a twl4030 GPIO" logic.

Add write-protect switch detection support to that glue.  Stub
in a not-present WP GPIO into most boards.  (Beagle's is real.)

Teach the hsmmc driver how to use the card detect and writeprotect
methods, and move some data structure init earlier so that when IRQs
come in, more of the data used by their handlers is initialized.

Verified on Beagle (WP, card detect events) and Overo (boots, both
card and wlan are seen).  Beagle behaves fully, and is the model
to follow for the common case where the TWL4030 gpio-0 card detect
magic is used.

Most hsmmc boards need to list what GPIOs they use with MMC...

Note that supporting card detect and writeprotect GPIOs on a
second MMC slot, or using the MMC3 controller, requires some
interface updates that aren't part of this patch.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    1 
 arch/arm/mach-omap2/board-3430sdp.c      |    2 
 arch/arm/mach-omap2/board-ldp.c          |    1 
 arch/arm/mach-omap2/board-omap2evm.c     |    1 
 arch/arm/mach-omap2/board-omap3beagle.c  |   26 ++---
 arch/arm/mach-omap2/board-omap3evm.c     |    1 
 arch/arm/mach-omap2/board-omap3pandora.c |    1 
 arch/arm/mach-omap2/board-overo.c        |    2 
 arch/arm/mach-omap2/mmc-twl4030.c        |  133 ++++++++++++++---------------
 arch/arm/mach-omap2/mmc-twl4030.h        |    1 
 drivers/mmc/host/omap_hsmmc.c            |   51 ++++++++---
 11 files changed, 127 insertions(+), 93 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -395,6 +395,7 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -450,11 +450,13 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -346,6 +346,7 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -345,6 +345,7 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -116,6 +116,15 @@ static struct twl4030_usb_data beagle_us
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_hsmmc_info mmc[] __initdata = {
+	{
+		.mmc		= 1,
+		.wires		= 8,
+		.gpio_wp	= 29,
+	},
+	{}	/* Terminator */
+};
+
 static struct gpio_led gpio_leds[];
 
 #include <linux/interrupt.h>
@@ -135,6 +144,9 @@ static int beagle_twl_gpio_setup(struct 
 	int	status;
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	omap_cfg_reg(AH8_34XX_GPIO29);
+	mmc[0].gpio_cd = gpio + 0;
+	hsmmc_init(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -319,15 +331,6 @@ static void __init omap3beagle_flash_ini
 	}
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 8,
-		.gpio_cd	= TWL4030_GPIO_IRQ_NO(0),
-	},
-	{}	/* Terminator */
-};
-
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -344,11 +347,6 @@ static void __init omap3_beagle_init(voi
 #endif
 	omap_serial_init();
 
-	omap_cfg_reg(AH8_34XX_GPIO29);
-	gpio_request(29, "mmc0_wp");
-	gpio_direction_input(29);
-	hsmmc_init(mmc);
-
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -240,6 +240,7 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -208,6 +208,7 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -213,11 +213,13 @@ static struct twl4030_hsmmc_info mmc[] _
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -27,11 +27,8 @@
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#define TWL_GPIO_IMR1A		0x1C
-#define TWL_GPIO_ISR1A		0x19
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
-#define GPIO_0_BIT_POS		(1 << 0)
 
 #define VMMC1_DEV_GRP		0x27
 #define VMMC1_CLR		0x00
@@ -58,27 +55,36 @@ static struct twl_mmc_controller {
 	u16		control_devconf_offset;
 	u32		devconf_loopback_clock;
 	int		card_detect_gpio;
+	unsigned	card_wp_gpio;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
 } hsmmc[] = {
 	{
 		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
 		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
-		.card_detect_gpio		= OMAP_MAX_GPIO_LINES,
+		.card_detect_gpio		= -EINVAL,
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC1_DEDICATED,
 	},
 	{
 		/* control_devconf_offset set dynamically */
 		.devconf_loopback_clock		= OMAP2_MMCSDIO2ADPCLKISEL,
+		.card_detect_gpio		= -EINVAL,
 		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC2_DEDICATED,
 	},
- };
+};
 
 static int twl_mmc1_card_detect(int irq)
 {
-	return gpio_get_value_cansleep(hsmmc[0].card_detect_gpio);
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(hsmmc[0].card_detect_gpio);
+}
+
+static int twl_mmc1_get_ro(struct device *dev, int slot)
+{
+	/* NOTE: assumes write protect signal is active-high */
+	return gpio_get_value_cansleep(hsmmc[0].card_wp_gpio);
 }
 
 /*
@@ -86,15 +92,19 @@ static int twl_mmc1_card_detect(int irq)
  */
 static int twl_mmc1_late_init(struct device *dev)
 {
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
 	int ret = 0;
 
-	/*
-	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
-	 */
 	ret = gpio_request(hsmmc[0].card_detect_gpio, "mmc0_cd");
 	if (ret)
+		goto done;
+	ret = gpio_direction_input(hsmmc[0].card_detect_gpio);
+	if (ret)
 		goto err;
 
+	/* FIXME assumes this uses (a) TWL4030 and (b) GPIO-0 ...
+	 * but that's not actually required.
+	 */
 	ret = twl4030_set_gpio_debounce(0, true);
 	if (ret)
 		goto err;
@@ -102,8 +112,10 @@ static int twl_mmc1_late_init(struct dev
 	return ret;
 
 err:
-	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
-
+	dev_err(dev, "Failed to configure TWL4030 card detect\n");
+done:
+	mmc->slots[0].card_detect_irq = 0;
+	mmc->slots[0].card_detect = NULL;
 	return ret;
 }
 
@@ -114,62 +126,25 @@ static void twl_mmc1_cleanup(struct devi
 
 #ifdef CONFIG_PM
 
-/*
- * Mask and unmask MMC Card Detect Interrupt
- * mask : 1
- * unmask : 0
- */
-static int twl_mmc_mask_cd_interrupt(int mask)
-{
-	u8 reg = 0, ret = 0;
-
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_IMR1A);
-	if (ret)
-		goto err;
-
-	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_IMR1A);
-	if (ret)
-		goto err;
-
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_ISR1A);
-	if (ret)
-		goto err;
-
-	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_ISR1A);
-	if (ret)
-		goto err;
-
-err:
-	return ret;
-}
-
-static int twl_mmc1_suspend(struct device *dev, int slot)
+static int twl_mmc_suspend(struct device *dev, int slot)
 {
-	int ret = 0;
-
-	disable_irq(hsmmc[0].card_detect_gpio);
-	ret = twl_mmc_mask_cd_interrupt(1);
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
-	return ret;
+	disable_irq(mmc->slots[0].card_detect_irq);
+	return 0;
 }
 
-static int twl_mmc1_resume(struct device *dev, int slot)
+static int twl_mmc_resume(struct device *dev, int slot)
 {
-	int ret = 0;
-
-	enable_irq(hsmmc[0].card_detect_gpio);
-	ret = twl_mmc_mask_cd_interrupt(0);
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
-	return ret;
+	enable_irq(mmc->slots[0].card_detect_irq);
+	return 0;
 }
 
 #else
-#define twl_mmc1_suspend	NULL
-#define twl_mmc1_resume		NULL
+#define twl_mmc_suspend	NULL
+#define twl_mmc_resume	NULL
 #endif
 
 /*
@@ -362,26 +337,52 @@ void __init hsmmc_init(struct twl4030_hs
 					MMC_VDD_29_30 |
 					MMC_VDD_30_31 | MMC_VDD_31_32;
 		mmc->slots[0].wires = c->wires;
-		if (c->gpio_cd != -EINVAL)
-			mmc->slots[0].card_detect_irq = c->gpio_cd;
 		mmc->dma_mask = 0xffffffff;
 
+		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
+		 * the TWL4030's VMMC1 and VMMC2, respectively;
+		 * and that OMAP's MMC3 isn't used.
+		 */
+
 		switch (c->mmc) {
 		case 1:
-			mmc->init = twl_mmc1_late_init;
-			mmc->cleanup = twl_mmc1_cleanup;
-			mmc->suspend = twl_mmc1_suspend;
-			mmc->resume = twl_mmc1_resume;
 			mmc->slots[0].set_power = twl_mmc1_set_power;
-			mmc->slots[0].card_detect = twl_mmc1_card_detect;
+			if (gpio_is_valid(c->gpio_cd)) {
+				mmc->slots[0].card_detect_irq =
+						gpio_to_irq(c->gpio_cd);
+				mmc->suspend = twl_mmc_suspend;
+				mmc->resume = twl_mmc_resume;
+
+				/* NOTE: hsmmc[0] is hard-wired ... */
+				hsmmc[0].card_detect_gpio = c->gpio_cd;
+				mmc->init = twl_mmc1_late_init;
+				mmc->cleanup = twl_mmc1_cleanup;
+				mmc->slots[0].card_detect =
+						twl_mmc1_card_detect;
+			}
+			if (gpio_is_valid(c->gpio_wp)) {
+				gpio_request(c->gpio_wp, "mmc0_wp");
+				gpio_direction_input(c->gpio_wp);
+
+				/* NOTE: hsmmc[0] is hard-wired ... */
+				hsmmc[0].card_wp_gpio = c->gpio_wp;
+				mmc->slots[0].get_ro = twl_mmc1_get_ro;
+			}
 			hsmmc_data[0] = mmc;
 			break;
 		case 2:
+			/* FIXME rework interfaces so that mmc2 (and mmc3) can
+			 * be fully functional... hsmmc[] shouldn't hold gpios.
+			 */
 			mmc->slots[0].set_power = twl_mmc2_set_power;
+			if (gpio_is_valid(c->gpio_cd))
+				pr_warning("MMC2 detect nyet supported!\n");
+			if (gpio_is_valid(c->gpio_wp))
+				pr_warning("MMC2 WP nyet supported!\n");
 			hsmmc_data[1] = mmc;
 			break;
 		default:
-			pr_err("Unknown MMC configuration!\n");
+			pr_err("MMC%d configuration not supported!\n", c->mmc);
 			return;
 		}
 	}
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -10,6 +10,7 @@ struct twl4030_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
 	int	gpio_cd;	/* or -EINVAL */
+	int	gpio_wp;	/* or -EINVAL */
 };
 
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -825,10 +825,33 @@ static void omap_mmc_set_ios(struct mmc_
 		OMAP_HSMMC_WRITE(host->base, CON,
 				OMAP_HSMMC_READ(host->base, CON) | OD);
 }
-/* NOTE: Read only switch not supported yet */
+
+static int omap_hsmmc_get_cd(struct mmc_host *mmc)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct omap_mmc_platform_data *pdata = host->pdata;
+
+	if (!pdata->slots[0].card_detect)
+		return -ENOSYS;
+	return pdata->slots[0].card_detect(pdata->slots[0].card_detect_irq);
+}
+
+static int omap_hsmmc_get_ro(struct mmc_host *mmc)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct omap_mmc_platform_data *pdata = host->pdata;
+
+	if (!pdata->slots[0].get_ro)
+		return -ENOSYS;
+	return pdata->slots[0].get_ro(host->dev, 0);
+}
+
 static struct mmc_host_ops mmc_omap_ops = {
 	.request = omap_mmc_request,
 	.set_ios = omap_mmc_set_ios,
+	.get_cd = omap_hsmmc_get_cd,
+	.get_ro = omap_hsmmc_get_ro,
+	/* NYET -- enable_sdio_irq */
 };
 
 static int __init omap_mmc_probe(struct platform_device *pdev)
@@ -878,6 +901,10 @@ static int __init omap_mmc_probe(struct 
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
+
+	platform_set_drvdata(pdev, host);
+	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
+
 	mmc->ops	= &mmc_omap_ops;
 	mmc->f_min	= 400000;
 	mmc->f_max	= 52000000;
@@ -970,6 +997,14 @@ static int __init omap_mmc_probe(struct 
 		goto err_irq;
 	}
 
+	if (pdata->init != NULL) {
+		if (pdata->init(&pdev->dev) != 0) {
+			dev_dbg(mmc_dev(host->mmc),
+				"Unable to configure MMC IRQs\n");
+			goto err_irq_cd_init;
+		}
+	}
+
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
 		ret = request_irq(mmc_slot(host).card_detect_irq,
@@ -984,19 +1019,9 @@ static int __init omap_mmc_probe(struct 
 		}
 	}
 
-	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
-	if (pdata->init != NULL) {
-		if (pdata->init(&pdev->dev) != 0) {
-			dev_dbg(mmc_dev(host->mmc),
-				"Unable to configure MMC IRQs\n");
-			goto err_irq_cd_init;
-		}
-	}
-
 	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
 	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
 
-	platform_set_drvdata(pdev, host);
 	mmc_add_host(mmc);
 
 	if (host->pdata->slots[host->slot_id].name != NULL) {
@@ -1017,9 +1042,9 @@ err_cover_switch:
 	device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
 err_slot_name:
 	mmc_remove_host(mmc);
-err_irq_cd_init:
-	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
+	free_irq(mmc_slot(host).card_detect_irq, host);
+err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
 	clk_disable(host->fclk);
