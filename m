From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Wed, 20 Jun 2012 06:48:01 -0700
Message-ID: <20120620134800.GM12766@atomide.com>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
 <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
 <1339658290.2236.5.camel@deskari>
 <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
 <1339661613.2229.6.camel@deskari>
 <CA+Bv8Xbqi7y3v2O7u8B31tv4JCTfQq3wWFojfK4UuAqDoYhB-Q@mail.gmail.com>
 <1339676435.2229.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47371 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab2FTNsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 09:48:04 -0400
Content-Disposition: inline
In-Reply-To: <1339676435.2229.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120614 05:25]:
> On Thu, 2012-06-14 at 04:40 -0700, Russ Dill wrote:
> > On Thu, Jun 14, 2012 at 1:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > > On Thu, 2012-06-14 at 00:59 -0700, Russ Dill wrote:
> > >> On Thu, Jun 14, 2012 at 12:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > >> > On Wed, 2012-06-13 at 23:58 -0700, Russ Dill wrote:
> > >> >> On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > >> >> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> > >> >> > remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> > >> >> > powerdown-gpio handling from the board files to the tfp410 driver. One
> > >> >> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> > >> >> > the Beagle board file. This causes the tfp410 driver to fail to request
> > >> >> > the gpio on Beagle, causing the driver to fail and thus the DVI output
> > >> >> > doesn't work.
> > >> >>
> > >> >> Can you take the one I sent earlier instead?
> > >> >>
> > >> >> http://www.spinics.net/lists/linux-omap/msg69913.html
> > >> >
> > >> > Hmm, that probably doesn't apply. The power-down GPIO is now handled in
> > >> > the tfp410 driver, not in the board files.
> > >>
> > >> Give me a branch to rebase it onto and I will.
> > >
> > > v3.5-rc2
> > 
> > This one (v4) already applies to v3.5-rc2
> > 
> > http://www.spinics.net/lists/linux-omap/msg70042.html
> 
> My ack for v4:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> And I'd reword the description, "fix" instead of cleanup. The "boot
> warnings" are errors. I don't think the DVI output works at all with
> beagle in the current mainline.
> 
> Btw, please cc me when sending patches related to display.

Applying the following version into fixes. Took the first paragraph
with the regression info from Tomi's patch.

Regards,

Tony


From: Russ Dill <Russ.Dill@ti.com>
Date: Wed, 9 May 2012 15:15:03 -0700
Subject: [PATCH] ARM: OMAP: Fix Beagleboard DVI reset gpio

Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
remove custom PD GPIO handling for DVI output") moved TFP410 chip's
powerdown-gpio handling from the board files to the tfp410 driver. One
gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
the Beagle board file. This causes the tfp410 driver to fail to request
the gpio on Beagle, causing the driver to fail and thus the DVI output
doesn't work.

This patch removes several boot errors from board-omap3beagle.c:

 - gpio_request: gpio--22 (DVI reset) status -22
 - Unable to get DVI reset GPIO

There is a combination of leftover code and revision confusion.
Additionally, xM support is currently a hack.

For original Beagleboard this removes the double initialization of GPIO
170, properly configures it as an output, and wraps the initialization
in an if block so that xM does not attempt to request it.

For Beagleboard xM it removes reference to GPIO 129 which was part
of rev A1 and A2 designs, but never functioned. It then properly assigns
beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
hack of initializing it high. Additionally, it uses
gpio_set_value_cansleep since this GPIO is connected through i2c.

Unfortunately, there is no way to tell the difference between xM A2 and
A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
problems created by this fix.

Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 79c6909..580fd17 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -81,13 +81,13 @@ static u8 omap3_beagle_version;
 static struct {
 	int mmc1_gpio_wp;
 	int usb_pwr_level;
-	int reset_gpio;
+	int dvi_pd_gpio;
 	int usr_button_gpio;
 	int mmc_caps;
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
 	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
-	.reset_gpio = 129,
+	.dvi_pd_gpio = -EINVAL,
 	.usr_button_gpio = 4,
 	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
@@ -126,21 +126,21 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
 		beagle_config.mmc1_gpio_wp = 29;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 6:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 5:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 0:
@@ -274,11 +274,9 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (r)
 			pr_err("%s: unable to configure nDVI_PWR_EN\n",
 				__func__);
-		r = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
-				     "DVI_LDO_EN");
-		if (r)
-			pr_err("%s: unable to configure DVI_LDO_EN\n",
-				__func__);
+
+		beagle_config.dvi_pd_gpio = gpio + 2;
+
 	} else {
 		/*
 		 * REVISIT: need ehci-omap hooks for external VBUS
@@ -287,7 +285,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	dvi_panel.power_down_gpio = beagle_config.reset_gpio;
+	dvi_panel.power_down_gpio = beagle_config.dvi_pd_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -499,7 +497,7 @@ static void __init omap3_beagle_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 
-	if (beagle_config.mmc1_gpio_wp != -EINVAL)
+	if (gpio_is_valid(beagle_config.mmc1_gpio_wp))
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	mmc[0].caps = beagle_config.mmc_caps;
 	omap_hsmmc_init(mmc);
@@ -510,15 +508,13 @@ static void __init omap3_beagle_init(void)
 
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
+	if (gpio_is_valid(beagle_config.dvi_pd_gpio))
+		omap_mux_init_gpio(beagle_config.dvi_pd_gpio, OMAP_PIN_OUTPUT);
 	omap_display_init(&beagle_dss_data);
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
-
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
