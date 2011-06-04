From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH v6] OMAP3: beagle: add support for beagleboard xM revision C
Date: Sat, 4 Jun 2011 10:07:53 -0400
Message-ID: <BANLkTi=uAWC=CwdBvH00hYp9CYJqk-HDNg@mail.gmail.com>
References: <AQHMIjbc1GOjdu39Zku6xIzu4J56tg==>
	<8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252DB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36642 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab1FDOHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 10:07:54 -0400
Received: by iwn34 with SMTP id 34so2060689iwn.19
        for <linux-omap@vger.kernel.org>; Sat, 04 Jun 2011 07:07:53 -0700 (PDT)
In-Reply-To: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252DB@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Fernandes, Joel A" <joelagnel@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagle@list.ti.com - Ultra-low cost OMAP3 board (May contain non-TIers)" <beagle@list.ti.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, "Maupin, Chase" <chase.maupin@ti.com>

On Fri, Jun 3, 2011 at 5:56 PM, Fernandes, Joel A <joelagnel@ti.com> wr=
ote:
> The USB enable GPIO has been in beagleboard xM revision C
> The USER button has been moved since beagleboard xM
> Also, board specific initialization has been moved to beagle_config s=
truct
> and initialized in omap3_beagle_init_rev. Default values in struct ar=
e for xMC.
>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 70 +++++++++++++++++=
+++-----------
> =A01 files changed, 46 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7f21d24..261fb53 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -61,7 +61,8 @@
> =A0* =A0 =A0 AXBX =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 1 1
> =A0* =A0 =A0 C1_3 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 1 0
> =A0* =A0 =A0 C4 =A0 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 1 0 1
> - * =A0 =A0 XM =A0 =A0 =A0=3D GPIO173, GPIO172, GPIO171: 0 0 0
> + * =A0 =A0 XMA/XMB =3D GPIO173, GPIO172, GPIO171: 0 0 0
> + * =A0 =A0 XMC =3D GPIO173, GPIO172, GPIO171: 0 1 0
> =A0*/
> =A0enum {
> =A0 =A0 =A0 =A0OMAP3BEAGLE_BOARD_UNKN =3D 0,
> @@ -69,14 +70,26 @@ enum {
> =A0 =A0 =A0 =A0OMAP3BEAGLE_BOARD_C1_3,
> =A0 =A0 =A0 =A0OMAP3BEAGLE_BOARD_C4,
> =A0 =A0 =A0 =A0OMAP3BEAGLE_BOARD_XM,
> + =A0 =A0 =A0 OMAP3BEAGLE_BOARD_XMC,
> =A0};
>
> =A0static u8 omap3_beagle_version;
>
> -static u8 omap3_beagle_get_rev(void)
> -{
> - =A0 =A0 =A0 return omap3_beagle_version;
> -}
> +/*
> + * Board-specific configuration
> + * Defaults to BeagleBoard-xMC
> + */
> +static struct {
> + =A0 =A0 =A0 int mmc1_gpio_wp;
> + =A0 =A0 =A0 int usb_pwr_level;
> + =A0 =A0 =A0 int reset_gpio;
> + =A0 =A0 =A0 int usr_button_gpio;
> +} beagle_config =3D {
> + =A0 =A0 =A0 .mmc1_gpio_wp =3D -EINVAL,
> + =A0 =A0 =A0 .usb_pwr_level =3D GPIOF_OUT_INIT_LOW,
> + =A0 =A0 =A0 .reset_gpio =3D 129,
> + =A0 =A0 =A0 .usr_button_gpio =3D 4,
> +};
>
> =A0static struct gpio omap3_beagle_rev_gpios[] __initdata =3D {
> =A0 =A0 =A0 =A0{ 171, GPIOF_IN, "rev_id_0" =A0 =A0},
> @@ -111,18 +124,32 @@ static void __init omap3_beagle_init_rev(void)
> =A0 =A0 =A0 =A0case 7:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "OMAP3 Beagle Rev: Ax=
/Bx\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_beagle_version =3D OMAP3BEAGLE_B=
OARD_AXBX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.mmc1_gpio_wp =3D 29;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.reset_gpio =3D 170;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.usr_button_gpio =3D 7;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 6:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "OMAP3 Beagle Rev: C1=
/C2/C3\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_beagle_version =3D OMAP3BEAGLE_B=
OARD_C1_3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.mmc1_gpio_wp =3D 23;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.reset_gpio =3D 170;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.usr_button_gpio =3D 7;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 5:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "OMAP3 Beagle Rev: C4=
\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_beagle_version =3D OMAP3BEAGLE_B=
OARD_C4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.mmc1_gpio_wp =3D 23;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.reset_gpio =3D 170;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.usr_button_gpio =3D 7;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "OMAP3 Beagle Rev: xM=
\n");

Since it sounds like there is already another revision coming, update
the text above to:
                printk(KERN_INFO "OMAP3 Beagle Rev: xM Ax/Bx\n");

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_beagle_version =3D OMAP3BEAGLE_B=
OARD_XM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.usb_pwr_level =3D GPIOF_O=
UT_INIT_HIGH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: xM =
C\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_beagle_version =3D OMAP3BEAGLE_BO=
ARD_XMC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "OMAP3 Beagle Rev: un=
known %hd\n", beagle_rev);
> @@ -234,7 +261,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_=
4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D 29,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> =A0};
> @@ -252,17 +279,11 @@ static struct gpio_led gpio_leds[];
> =A0static int beagle_twl_gpio_setup(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> =A0{
> - =A0 =A0 =A0 int r, usb_pwr_level;
> -
> - =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc[0].gpio_wp =3D -EINVAL;
> - =A0 =A0 =A0 } else if ((omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_B=
OARD_C1_3) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (omap3_beagle_get_rev() =3D=3D OMAP3BEA=
GLE_BOARD_C4)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(23, OMAP_PIN_INPUT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc[0].gpio_wp =3D 23;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(29, OMAP_PIN_INPUT);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 if (beagle_config.mmc1_gpio_wp !=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(beagle_config.mmc1_g=
pio_wp, OMAP_PIN_INPUT);
> + =A0 =A0 =A0 mmc[0].gpio_wp =3D beagle_config.mmc1_gpio_wp;
> =A0 =A0 =A0 =A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> =A0 =A0 =A0 =A0omap2_hsmmc_init(mmc);
> @@ -276,9 +297,7 @@ static int beagle_twl_gpio_setup(struct device *d=
ev,
> =A0 =A0 =A0 =A0 * high / others active low)
> =A0 =A0 =A0 =A0 * DVI reset GPIO is different between beagle revision=
s
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_pwr_level =3D GPIOF_OUT_INIT_HIGH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 129;
> + =A0 =A0 =A0 if (cpu_is_omap3630()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * gpio + 1 on Xm controls the TFP410'=
s enable line (active low)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * gpio + 2 control varies depending o=
n the board rev as below:
> @@ -296,8 +315,6 @@ static int beagle_twl_gpio_setup(struct device *d=
ev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: unable to =
configure DVI_LDO_EN\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func=
__);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_pwr_level =3D GPIOF_OUT_INIT_LOW;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 170;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * REVISIT: need ehci-omap hooks for e=
xternal VBUS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * power switch and overcurrent detect
> @@ -305,8 +322,10 @@ static int beagle_twl_gpio_setup(struct device *=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_request_one(gpio + 1, GPIOF_I=
N, "EHCI_nOC"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: unable to =
configure EHCI_nOC\n", __func__);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D beagle_config.reset_gp=
io;
>
> - =A0 =A0 =A0 gpio_request_one(gpio + TWL4030_GPIO_MAX, usb_pwr_level=
, "nEN_USB_PWR");
> + =A0 =A0 =A0 gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config=
=2Eusb_pwr_level,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "nEN_USB_PWR");
>
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, ac=
tive low LED) */
> =A0 =A0 =A0 =A0gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
> @@ -526,7 +545,7 @@ static void __init beagle_opp_init(void)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Custom OPP enabled for XM */
> - =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)=
 {
> + =A0 =A0 =A0 if (cpu_is_omap3630()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_hwmod *mh =3D omap_hwmod_l=
ookup("mpu");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_hwmod *dh =3D omap_hwmod_l=
ookup("iva");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev;
> @@ -566,6 +585,9 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> =A0 =A0 =A0 =A0omap3_beagle_init_rev();
> =A0 =A0 =A0 =A0omap3_beagle_i2c_init();
> +
> + =A0 =A0 =A0 gpio_buttons[0].gpio =3D beagle_config.usr_button_gpio;
> +
> =A0 =A0 =A0 =A0platform_add_devices(omap3_beagle_devices,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3_beagl=
e_devices));
> =A0 =A0 =A0 =A0omap_display_init(&beagle_dss_data);
> --
> 1.6.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
