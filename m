From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH 1/2] omap3: igepv2: Don't call gpio_set_value right after gpio_direction_output
Date: Mon, 13 Dec 2010 09:56:19 +0100
Message-ID: <AANLkTinpj59AaNCBU8apJ-9PQMVefJ5OKB_=oL6Z+=NV@mail.gmail.com>
References: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1292178938-9819-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44141 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab0LMI4T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 03:56:19 -0500
Received: by pwj3 with SMTP id 3so1090266pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 00:56:19 -0800 (PST)
In-Reply-To: <1292178938-9819-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org

2010/12/12 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> gpio_direction_output() has a value argument, there's no need to call
> gpio_set_value() explicitly right after.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 20 ++++++++------=
------
> =C2=A01 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index 5e035a5..20b88c1 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -342,24 +342,21 @@ static void __init igep2_leds_init(void)
> =C2=A0static inline void igep2_leds_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gpio_request(IGEP2_GPIO_LED0_RED, "gp=
io-led:red:d0") =3D=3D 0) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED0_RED, 1) =3D=3D 0)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED0_RED, 0) =3D=3D 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(IG=
EP2_GPIO_LED0_RED, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(IGE=
P2_GPIO_LED0_RED, 0);
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain gpio GPIO_LED0_RED\n");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gpio_request(IGEP2_GPIO_LED0_GREEN, "=
gpio-led:green:d0") =3D=3D 0) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED0_GREEN, 1) =3D=3D 0)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED0_GREEN, 0) =3D=3D 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(IG=
EP2_GPIO_LED0_GREEN, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(IGE=
P2_GPIO_LED0_GREEN, 0);
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain gpio GPIO_LED0_GREEN\n");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gpio_request(IGEP2_GPIO_LED1_RED, "gp=
io-led:red:d1") =3D=3D 0) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED1_RED, 1) =3D=3D 0)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(IGEP2_GPI=
O_LED1_RED, 0) =3D=3D 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(IG=
EP2_GPIO_LED1_RED, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(IGE=
P2_GPIO_LED1_RED, 0);
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain gpio GPIO_LED1_RED\n");
>
> =C2=A0}
> @@ -397,10 +394,9 @@ static int igep2_twl_gpio_setup(struct device *d=
ev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB (out, =
active low LED) */
> =C2=A0#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MOD=
ULE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gpio_request(gpio+TWL4030_GPIO_MAX+1,=
 "gpio-led:green:d1") =3D=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && (gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX + 1, 1) =3D=3D 0)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && (gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX + 1, 0) =3D=3D 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(gp=
io + TWL4030_GPIO_MAX + 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(gpi=
o + TWL4030_GPIO_MAX + 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
> =C2=A0#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep2_gpio_leds[3].gpio =3D gpio + TWL4030=
_GPIO_MAX + 1;
> --
> 1.7.2.2
>
>

Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
