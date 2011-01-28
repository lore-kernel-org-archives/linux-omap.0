From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/2] omap3: beaglexm: fix DVI initialization
Date: Fri, 28 Jan 2011 12:16:07 +0530
Message-ID: <AANLkTikiPvOC6kMGjH5E28gS50xYH8eNp4Pi6EHCMZd4@mail.gmail.com>
References: <1296186571-22009-1-git-send-email-ricardo.salveti@canonical.com> <1296186571-22009-3-git-send-email-ricardo.salveti@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48576 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab1A1Gqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 01:46:48 -0500
Received: by ywp6 with SMTP id 6so997390ywp.27
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 22:46:47 -0800 (PST)
In-Reply-To: <1296186571-22009-3-git-send-email-ricardo.salveti@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 28, 2011 at 09:19, Ricardo Salveti de Araujo
<ricardo.salveti@canonical.com> wrote:
> Function beagle_twl_gpio_setup is called after beagle_display_init, w=
hat
> makes lets reset_gpio with an invalid value at the time it request th=
e
> gpio. As a side effect the DVI reset GPIO is not properly set.
>
> Also removing old code that power down DVI in a hardcoded way, as it'=
s
> not necessary anymore.
>
> Tested with Beagle-xM and C4.
>
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.c=
om>
> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 17 ++++++-----------
> =A01 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 685ac06..c8ab478 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -248,6 +248,12 @@ static void __init beagle_display_init(void)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 /* DVI reset GPIO is different between beagle revisions=
 */
> + =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 129;

Define a macro for this gpio and use it here.

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_dvi_device.reset_gpio =3D 170;

Ditto.

> +

Where is the mux configuration (omap_mux_init_gpio()) done for this gpi=
o?

-V Charulatha

> =A0 =A0 =A0 =A0r =3D gpio_request(beagle_dvi_device.reset_gpio, "DVI =
reset");
> =A0 =A0 =A0 =A0if (r < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Unable to get DVI res=
et GPIO\n");
> @@ -324,12 +330,6 @@ static int beagle_twl_gpio_setup(struct device *=
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
> @@ -620,11 +620,6 @@ static void __init omap3_beagle_init(void)
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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
