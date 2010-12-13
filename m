From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH 2/2] omap3: igepv2: LED gpio-led:green:d1 is active low
Date: Mon, 13 Dec 2010 16:25:36 +0100
Message-ID: <AANLkTim-Di+-eHThiJXn_viB2MTEmzESp_x-gXMLo9La@mail.gmail.com>
References: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1292178938-9819-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56469 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0LMPZg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 10:25:36 -0500
Received: by pva4 with SMTP id 4so1123407pva.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 07:25:36 -0800 (PST)
In-Reply-To: <1292178938-9819-2-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org

2010/12/12 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Make sure the LED is turned off at boot time, and configure the GPIO =
LED
> device as active low.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index 20b88c1..41a4b25 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -317,6 +317,7 @@ static struct gpio_led igep2_gpio_leds[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "gpio-led:gree=
n:d1",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.default_trigg=
er =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "heartbeat",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -EINVAL, /* ge=
ts replaced */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .active_low =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> @@ -394,7 +395,7 @@ static int igep2_twl_gpio_setup(struct device *de=
v,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB (out, =
active low LED) */
> =C2=A0#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MOD=
ULE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gpio_request(gpio+TWL4030_GPIO_MAX+1,=
 "gpio-led:green:d1") =3D=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && (gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX + 1, 0) =3D=3D 0))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && (gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX + 1, 1) =3D=3D 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(gp=
io + TWL4030_GPIO_MAX + 1, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
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
