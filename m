From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
Date: Fri, 17 Feb 2012 11:05:43 -0800
Message-ID: <20120217190543.GD18185@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182825.18884.40972.stgit@kaulin.local>
 <20120216164504.GD15692@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10158 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2BQTFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 14:05:51 -0500
Content-Disposition: inline
In-Reply-To: <20120216164504.GD15692@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120216 08:13]:
> * Tony Lindgren <tony@atomide.com> [120215 09:57]:
> >  
> > +void omap_hsmmc_late_init(struct omap2_hsmmc_info *controllers)
> > +{
> > +	struct platform_device *pdev;
> > +	int res;
> > +
> > +	for (; controllers->mmc; controllers++) {
> > +		if (!controllers->deferred)
> > +			continue;
> > +
> > +		pdev = controllers->pdev;
> > +		if (!pdev)
> > +			continue;
> > +
> > +		res = omap_device_register(pdev);
> > +		if (res) {
> > +			pr_err("Could not late init MMC %s\n",
> > +			       controllers->name);
> > +			continue;
> > +		}
> > +	}
> > +}
> 
> Most likely there's no need to pass struct omap2_hsmmc_info *controllers
> to omap_hsmmc_late_init() here. And I'll also take a look at making
> it a completion to make it more generic across various PMICs.

Well looks like it does not make sense to try to do this from the
drivers directly as this is platform_data. And we need to pass the
gpio_cd and gpio_wp anyways to the omap_hsmmc_late_init(), so
might as well keep on using the existing data structure for it.

Updated patch below with the issue noted by Rajendra fixed by
copying gpio_cd and gpio_wp into the pdata in omap_hsmmc_late_init().
Also fixed up the freeing of the controller name that I messed
up in my patch. The name should only get freed on errors, only
pdata gets copied when the platform_device gets registered.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 14 Feb 2012 16:05:23 -0800
Subject: [PATCH] ARM: OMAP2+: Split omap2_hsmmc_init() to properly support I2C GPIO pins

Otherwise omap_device_build() and omap_mux related functions
can't be marked as __init when twl is build as a module.

If a board is using GPIO pins or regulators configured by an
external chip, such as TWL PMIC on I2C bus, the board must
mark those MMC controllers as deferred. Additionally both
omap_hsmmc_init() and omap_hsmmc_late_init() must be called
by the board.

For MMC controllers using internal GPIO pins for card
detect and regulators the slots don't need to be marked
deferred. In this case calling omap_hsmmc_init() is sufficient.

Note that this patch does not change the behaviour for
board-4430sdp.c board-omap4panda.c. These boards wrongly
rely on the omap_hsmmc.c init function callback to configure
the PMIC GPIO interrupt lines on external chip. If the PMIC
interrupt lines are not configured during init, they will
fail.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 7370983..c8bda62 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -279,7 +279,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
 
 	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 383717b..da75f23 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -232,11 +232,13 @@ static struct omap2_hsmmc_info mmc[] = {
 		 */
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 4,
+		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 7,
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -249,7 +251,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	 */
 	mmc[0].gpio_cd = gpio + 0;
 	mmc[1].gpio_cd = gpio + 1;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "sub_lcd_en_bkl");
@@ -606,6 +608,7 @@ static void __init omap_3430sdp_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap_hsmmc_init(mmc);
 	omap3430_i2c_init();
 	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4e90715..09ae257 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -491,9 +491,9 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	struct omap2_hsmmc_info *c;
 
-	omap2_hsmmc_init(controllers);
+	omap_hsmmc_init(controllers);
 	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(c->dev);
+		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4b1cfe3..71138a1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -504,7 +504,7 @@ static void __init am3517_evm_init(void)
 	am3517_evm_musb_init();
 
 	/* MMC init function */
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 }
 
 MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e921e3b..60f0501 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -413,7 +413,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
-
+		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
@@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -471,7 +472,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	return 0;
 }
@@ -639,6 +640,7 @@ static void __init cm_t3x_common_init(void)
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
+	omap_hsmmc_init(mmc);
 	cm_t35_init_i2c();
 	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
 	cm_t35_init_ethernet();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e873063..11cd2a8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -100,6 +100,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -228,7 +229,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -636,6 +637,7 @@ static void __init devkit8000_init(void)
 
 	omap_dm9000_init();
 
+	omap_hsmmc_init(mmc);
 	devkit8000_i2c_init();
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a59ace0..ac1de09 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -295,6 +295,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.deferred	= true,
 	},
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
 	{
@@ -302,6 +303,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.deferred	= true,
 	},
 #endif
 	{}      /* Terminator */
@@ -402,7 +404,7 @@ static int igep_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
@@ -639,6 +641,9 @@ static void __init igep_init(void)
 
 	/* Get IGEP2 hardware revision */
 	igep2_get_revision();
+
+	omap_hsmmc_init(mmc);
+
 	/* Register I2C busses and drivers */
 	igep_i2c_init();
 	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 2d2a61f..b5bc9b2 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -424,7 +424,7 @@ static void __init omap_ldp_init(void)
 	board_nand_init(ldp_nand_partitions,
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 	ldp_display_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7ffcd28..78bfcd5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -253,6 +253,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -277,7 +278,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
@@ -521,6 +522,7 @@ static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
+	omap_hsmmc_init(mmc);
 	omap3_beagle_i2c_init();
 
 	gpio_buttons[0].gpio = beagle_config.usr_button_gpio;
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c775bea..db0aa27 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -317,6 +317,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
+		.deferred	= true,
 	},
 #ifdef CONFIG_WL12XX_PLATFORM_DATA
 	{
@@ -326,6 +327,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
+		.deferred	= true,
 	},
 #endif
 	{}	/* Terminator */
@@ -363,7 +365,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
@@ -644,6 +646,7 @@ static void __init omap3_evm_init(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 
+	omap_hsmmc_init(mmc);
 	omap3_evm_i2c_init();
 
 	omap_display_init(&omap3_evm_dss_data);
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4198dd0..2304ba3 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -128,7 +128,7 @@ static void __init board_mmc_init(void)
 		return;
 	}
 
-	omap2_hsmmc_init(board_mmc_info);
+	omap_hsmmc_init(board_mmc_info);
 }
 
 static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 1644b73..84c83c8 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -273,6 +273,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
+		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
@@ -281,6 +282,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_wp	= 127,
 		.ext_clock	= 1,
 		.transceiver	= true,
+		.deferred	= true,
 	},
 	{
 		.mmc		= 3,
@@ -288,6 +290,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -300,7 +303,7 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
-	omap2_hsmmc_init(omap3pandora_mmc);
+	omap_hsmmc_late_init(omap3pandora_mmc);
 
 	/* gpio + 13 drives 32kHz buffer for wifi module */
 	gpio_32khz = gpio + 13;
@@ -580,6 +583,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap3pandora_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap_hsmmc_init(omap3pandora_mmc);
 	omap3pandora_i2c_init();
 	pandora_wl1251_init();
 	platform_add_devices(omap3pandora_devices,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index cb089a4..8eee993 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -209,10 +209,11 @@ static struct regulator_init_data omap3stalker_vsim = {
 
 static struct omap2_hsmmc_info mmc[] = {
 	{
-	 .mmc		= 1,
-	 .caps		= MMC_CAP_4_BIT_DATA,
-	 .gpio_cd	= -EINVAL,
-	 .gpio_wp	= 23,
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= 23,
+		.deferred	= true,
 	 },
 	{}			/* Terminator */
 };
@@ -284,7 +285,7 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
@@ -425,6 +426,7 @@ static void __init omap3_stalker_init(void)
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 
+	omap_hsmmc_init(mmc);
 	omap3_stalker_i2c_init();
 
 	platform_add_devices(omap3_stalker_devices,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index a0b851a..ba9c118 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -100,6 +100,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -125,7 +126,7 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -351,6 +352,7 @@ static void __init omap3_touchbook_init(void)
 
 	pm_power_off = omap3_touchbook_poweroff;
 
+	omap_hsmmc_init(mmc);
 	omap3_touchbook_i2c_init();
 	platform_add_devices(omap3_touchbook_devices,
 			ARRAY_SIZE(omap3_touchbook_devices));
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..bcc563c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -245,9 +245,9 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	struct omap2_hsmmc_info *c;
 
-	omap2_hsmmc_init(controllers);
+	omap_hsmmc_init(controllers);
 	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(c->dev);
+		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52c0cef..1fc5f7a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -301,6 +301,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
@@ -309,6 +310,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.transceiver	= true,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
+		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -407,7 +409,7 @@ static inline void __init overo_init_keys(void) { return; }
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
@@ -505,6 +507,7 @@ static void __init overo_init(void)
 	int ret;
 
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap_hsmmc_init(mmc);
 	overo_i2c_init();
 	omap_display_init(&overo_dss_data);
 	omap_serial_init();
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 8678b38..2d24c98 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -120,7 +120,7 @@ static void __init rm680_peripherals_init(void)
 				ARRAY_SIZE(rm680_peripherals_devices));
 	rm680_i2c_init();
 	gpmc_onenand_init(board_onenand_data);
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index acb4e77..0e9d89a 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1145,7 +1145,7 @@ void __init rx51_peripherals_init(void)
 
 	partition = omap_mux_get("core");
 	if (partition)
-		omap2_hsmmc_init(mmc);
+		omap_hsmmc_init(mmc);
 
 	rx51_charger_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index c126461..82a0f7c 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -205,6 +205,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
+		.deferred	= true,
 	},
 	{
 		.name		= "internal",
@@ -214,6 +215,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.deferred	= true,
 	},
 	{
 		.name		= "wl1271",
@@ -222,6 +224,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
+		.deferred	= true,
 	},
 	{}      /* Terminator */
 };
@@ -233,7 +236,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+	omap_hsmmc_late_init(mmc);
 
 	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
 			       "lcd enable");
@@ -301,6 +304,7 @@ void __init zoom_peripherals_init(void)
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);
 
+	omap_hsmmc_init(mmc);
 	omap_i2c_init();
 	platform_device_register(&omap_vwlan_device);
 	usb_musb_init(NULL);
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b40c288..f904766 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -428,66 +428,132 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	return 0;
 }
 
+static int omap_hsmmc_done;
+
+void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
+{
+	struct platform_device *pdev;
+	struct omap_mmc_platform_data *mmc_pdata;
+	int res;
+
+	if (omap_hsmmc_done)
+		return;
+
+	omap_hsmmc_done = 1;
+
+	for (; c->mmc; c++) {
+		if (!c->deferred)
+			continue;
+
+		pdev = c->pdev;
+		if (!pdev)
+			continue;
+
+		mmc_pdata = pdev->dev.platform_data;
+		if (!mmc_pdata)
+			continue;
+
+		mmc_pdata->slots[0].switch_pin = c->gpio_cd;
+		mmc_pdata->slots[0].gpio_wp = c->gpio_wp;
+
+		res = omap_device_register(pdev);
+		if (res)
+			pr_err("Could not late init MMC %s\n",
+			       c->name);
+	}
+}
+
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
-void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
+static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
+					int ctrl_nr)
 {
 	struct omap_hwmod *oh;
+	struct omap_hwmod *ohs[1];
+	struct omap_device *od;
 	struct platform_device *pdev;
 	char oh_name[MAX_OMAP_MMC_HWMOD_NAME_LEN];
 	struct omap_mmc_platform_data *mmc_data;
 	struct omap_mmc_dev_attr *mmc_dev_attr;
 	char *name;
-	int l;
+	int res;
 
 	mmc_data = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
 	if (!mmc_data) {
 		pr_err("Cannot allocate memory for mmc device!\n");
-		goto done;
+		return;
 	}
 
-	if (omap_hsmmc_pdata_init(hsmmcinfo, mmc_data) < 0) {
-		pr_err("%s fails!\n", __func__);
-		goto done;
-	}
+	res = omap_hsmmc_pdata_init(hsmmcinfo, mmc_data);
+	if (res < 0)
+		goto free_mmc;
+
 	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
 
 	name = "omap_hsmmc";
-
-	l = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
+	res = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
 		     "mmc%d", ctrl_nr);
-	WARN(l >= MAX_OMAP_MMC_HWMOD_NAME_LEN,
+	WARN(res >= MAX_OMAP_MMC_HWMOD_NAME_LEN,
 	     "String buffer overflow in MMC%d device setup\n", ctrl_nr);
+
 	oh = omap_hwmod_lookup(oh_name);
 	if (!oh) {
 		pr_err("Could not look up %s\n", oh_name);
-		kfree(mmc_data->slots[0].name);
-		goto done;
+		goto free_name;
 	}
-
+	ohs[0] = oh;
 	if (oh->dev_attr != NULL) {
 		mmc_dev_attr = oh->dev_attr;
 		mmc_data->controller_flags = mmc_dev_attr->flags;
 	}
 
-	pdev = omap_device_build(name, ctrl_nr - 1, oh, mmc_data,
-		sizeof(struct omap_mmc_platform_data), NULL, 0, false);
-	if (IS_ERR(pdev)) {
-		WARN(1, "Can't build omap_device for %s:%s.\n", name, oh->name);
-		kfree(mmc_data->slots[0].name);
-		goto done;
+	pdev = platform_device_alloc(name, ctrl_nr - 1);
+	if (!pdev) {
+		pr_err("Could not allocate pdev for %s\n", name);
+		goto free_name;
 	}
-	/*
-	 * return device handle to board setup code
-	 * required to populate for regulator framework structure
-	 */
-	hsmmcinfo->dev = &pdev->dev;
+	dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
+
+	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
+	if (!od) {
+		pr_err("Could not allocate od for %s\n", name);
+		goto put_pdev;
+	}
+
+	res = platform_device_add_data(pdev, mmc_data,
+			      sizeof(struct omap_mmc_platform_data));
+	if (res) {
+		pr_err("Could not add pdata for %s\n", name);
+		goto put_pdev;
+	}
+
+	hsmmcinfo->pdev = pdev;
+
+	if (hsmmcinfo->deferred)
+		goto free_mmc;
+
+	res = omap_device_register(pdev);
+	if (res) {
+		pr_err("Could not register od for %s\n", name);
+		goto free_od;
+	}
+
+	goto free_mmc;
+
+free_od:
+	omap_device_delete(od);
+
+put_pdev:
+	platform_device_put(pdev);
+
+free_name:
+	kfree(mmc_data->slots[0].name);
 
-done:
+free_mmc:
 	kfree(mmc_data);
 }
 
-void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+void omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
@@ -515,7 +581,7 @@ void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	}
 
 	for (; controllers->mmc; controllers++)
-		omap_init_hsmmc(controllers, controllers->mmc);
+		omap_hsmmc_init_one(controllers, controllers->mmc);
 
 }
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index c440973..07831cc 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -21,10 +21,11 @@ struct omap2_hsmmc_info {
 	bool	no_off;		/* power_saving and power is not to go off */
 	bool	no_off_init;	/* no power off when not in MMC sleep state */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
+	bool	deferred;	/* mmc needs a deferred probe */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
-	struct device *dev;	/* returned: pointer to mmc adapter */
+	struct platform_device *pdev;	/* mmc controller instance */
 	int	ocr_mask;	/* temporary HACK */
 	/* Remux (pad configuration) when powering on/off */
 	void (*remux)(struct device *dev, int slot, int power_on);
@@ -34,11 +35,16 @@ struct omap2_hsmmc_info {
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-void omap2_hsmmc_init(struct omap2_hsmmc_info *);
+void omap_hsmmc_init(struct omap2_hsmmc_info *);
+void omap_hsmmc_late_init(struct omap2_hsmmc_info *);
 
 #else
 
-static inline void omap2_hsmmc_init(struct omap2_hsmmc_info *info)
+static inline void omap_hsmmc_init(struct omap2_hsmmc_info *info)
+{
+}
+
+static inline void omap_hsmmc_late_init(struct omap2_hsmmc_info *info)
 {
 }
 
