From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v2 2/2] omap3: beaglexm: fix DVI initialization
Date: Wed, 9 Feb 2011 12:23:13 +0530
Message-ID: <AANLkTin9VRwgMyw9LUr691n++QByq14JGdARwN3ZVqW0@mail.gmail.com>
References: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
	<1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52938 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238Ab1BIGxQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 01:53:16 -0500
Received: by bwz8 with SMTP id 8so680726bwz.7
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 22:53:13 -0800 (PST)
In-Reply-To: <1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org, charu@ti.com

On Wed, Feb 9, 2011 at 1:13 AM, Ricardo Salveti de Araujo
<ricardo.salveti@canonical.com> wrote:
> Function beagle_twl_gpio_setup is called after beagle_display_init, w=
hat
> lets reset_gpio with an invalid value at the time it request the gpio=
=2E
> As a side effect the DVI reset GPIO is not properly set.
>
> Also removing old code that powers down DVI in a hardcoded way, as it=
's
> not necessary anymore.
>
> Tested with Beagle-xM and C4.

Surprised to see if this code works on C4 since there is gpio_request
for gpio_170 in the beagle init code
(linux omap master branch) which is before beagle_display_init()

        omap_mux_init_gpio(170, OMAP_PIN_INPUT);
        gpio_request(170, "DVI_nPD");
        /* REVISIT leave DVI powered down until it's needed ... */
        gpio_direction_output(170, true);

The second gpio_request(for 170) should fail in beagle_display_init.
Pls check and confirm.

-Manjunath

>
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.c=
om>
> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 22 +++++++++++------=
-----
> =A01 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 685ac06..1a21002 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -52,6 +52,9 @@
>
> =A0#define NAND_BLOCK_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SZ_128K
>
> +#define BEAGLE_DVI_RESET_GPIO =A0 =A0 =A0 =A0 =A0170
> +#define BEAGLE_XM_DVI_RESET_GPIO =A0 =A0 =A0 129
> +
> =A0/*
> =A0* OMAP3 Beagle revision
> =A0* Run time detection of Beagle revision is done by reading GPIO.
> @@ -248,6 +251,14 @@ static void __init beagle_display_init(void)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 /* DVI reset GPIO is different between beagle revisions=
 */
> + =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D BEAGLE=
_XM_DVI_RESET_GPIO;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D BEAGLE=
_DVI_RESET_GPIO;
> +
> + =A0 =A0 =A0 omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_P=
IN_OUTPUT);
> +
> =A0 =A0 =A0 =A0r =3D gpio_request(beagle_dvi_device.reset_gpio, "DVI =
reset");
> =A0 =A0 =A0 =A0if (r < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Unable to get DVI res=
et GPIO\n");
> @@ -324,12 +335,6 @@ static int beagle_twl_gpio_setup(struct device *=
dev,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_direction_output(gpio + TWL4030_G=
PIO_MAX, 0);
>
> - =A0 =A0 =A0 /* DVI reset GPIO is different between beagle revisions=
 */
> - =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 129;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 170;
> -
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, ac=
tive low LED) */
> =A0 =A0 =A0 =A0gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
>
> @@ -620,11 +625,6 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3_beagl=
e_devices));
> =A0 =A0 =A0 =A0omap_serial_init();
>
> - =A0 =A0 =A0 omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> - =A0 =A0 =A0 gpio_request(170, "DVI_nPD");
> - =A0 =A0 =A0 /* REVISIT leave DVI powered down until it's needed ...=
 */
> - =A0 =A0 =A0 gpio_direction_output(170, true);
> -
> =A0 =A0 =A0 =A0usb_musb_init(&musb_board_data);
> =A0 =A0 =A0 =A0usb_ehci_init(&ehci_pdata);
> =A0 =A0 =A0 =A0omap3beagle_flash_init();
> --
> 1.7.2.3
>
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
