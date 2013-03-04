From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] board-overo.c: enable TWL4030 power off
Date: Mon, 4 Mar 2013 11:00:36 -0800
Message-ID: <20130304190035.GT11806@atomide.com>
References: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35278 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758541Ab3CDTAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 14:00:37 -0500
Content-Disposition: inline
In-Reply-To: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas =?utf-8?Q?M=C3=BCller?= <schnitzeltony@googlemail.com>
Cc: linux-omap@vger.kernel.org, steve@sakoman.com

* Andreas M=C3=BCller <schnitzeltony@googlemail.com> [130228 04:50]:

Can you please add a description here? Preferrably something
like "With commit XYZ overo poweroff stopped working. Fix this
by blah blah blah" so this can be queued as a fix.

Regards,

Tony

> Signed-off-by: Andreas M=C3=BCller <schnitzeltony@googlemail.com>
> ---
>  arch/arm/mach-omap2/board-overo.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/=
board-overo.c
> index 86bab51..b975c72 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -418,9 +418,14 @@ static struct regulator_init_data overo_vmmc1 =3D=
 {
>  	.consumer_supplies	=3D overo_vmmc1_supply,
>  };
> =20
> +static struct twl4030_power_data overo_power_data =3D {
> +	.use_poweroff	=3D true,
> +};
> +
>  static struct twl4030_platform_data overo_twldata =3D {
>  	.gpio		=3D &overo_gpio_data,
>  	.vmmc1		=3D &overo_vmmc1,
> +	.power		=3D &overo_power_data,
>  };
> =20
>  static int __init overo_i2c_init(void)
> --=20
> 1.7.6.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
