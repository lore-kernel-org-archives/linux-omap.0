From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH v6] OMAP3: beagle: add support for beagleboard xM revision C
Date: Sat, 4 Jun 2011 10:11:08 -0400
Message-ID: <BANLkTinodyTjcD-Pd==M0MApBhj7xAZsrw@mail.gmail.com>
References: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252DB@dlee02.ent.ti.com>
	<13872098A06B02418CF379A158C0F14601606D6821@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46603 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab1FDOLJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 10:11:09 -0400
Received: by iwn34 with SMTP id 34so2062075iwn.19
        for <linux-omap@vger.kernel.org>; Sat, 04 Jun 2011 07:11:09 -0700 (PDT)
In-Reply-To: <13872098A06B02418CF379A158C0F14601606D6821@dnce02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kooi, Koen" <k-kooi@ti.com>
Cc: "Fernandes, Joel A" <joelagnel@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagle@list.ti.com - Ultra-low cost OMAP3 board (May contain non-TIers)" <beagle@list.ti.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, "Maupin, Chase" <chase.maupin@ti.com>

On Sat, Jun 4, 2011 at 4:01 AM, Kooi, Koen <k-kooi@ti.com> wrote:
>
>
> Texas Instruments Limited, 800 Pavilion Drive, Northampton, NN4 7YL. =
Registered in England & Wales under company number 00574102
>
> ________________________________________
>
> From: Fernandes, Joel A
> Sent: 03 June 2011 23:56
> To: linux-omap@vger.kernel.org
> Cc: beagle@list.ti.com - Ultra-low cost OMAP3 board (May contain non-=
TIers); beagleboard@googlegroups.com; Maupin, Chase
> Subject: [beagle] [PATCH v6] OMAP3: beagle: add support for beagleboa=
rd xM revision C
>
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
>
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
>
> PLease add a comment like "valid for all xM versions" to the above.
>
> @@ -526,7 +545,7 @@ static void __init beagle_opp_init(void)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Custom OPP enabled for XM */
> - =A0 =A0 =A0 if (omap3_beagle_get_rev() =3D=3D OMAP3BEAGLE_BOARD_XM)=
 {
> + =A0 =A0 =A0 if (cpu_is_omap3630()) {
>
> same
>
> @@ -566,6 +585,9 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> =A0 =A0 =A0 =A0omap3_beagle_init_rev();
> =A0 =A0 =A0 =A0omap3_beagle_i2c_init();
> +
> + =A0 =A0 =A0 gpio_buttons[0].gpio =3D beagle_config.usr_button_gpio;
> +
>
> And please move that into
>
> static struct gpio_keys_button gpio_buttons[] =3D {
> =A0 =A0{
> =A0 =A0 =A0 =A0.code =A0 =A0 =A0 =A0 =A0 =3D BTN_EXTRA,
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D 7, =A0<- there

I don't follow.  The other assignment is dynamic, following the
detection of the board revision and, hopefully, before the
initialization of the GPIO button.  I don't see how it can be moved
here.  Perhaps it might be better to set it to -EINVAL to indicate it
will be assigned later?

> =A0 =A0 =A0 =A0.desc =A0 =A0 =A0 =A0 =A0 =3D "user",
> =A0 =A0 =A0 =A0.wakeup =A0 =A0 =A0 =A0 =3D 1,
> =A0 =A0},
> }
>
> regards,
>
> Koen
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
