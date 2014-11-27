From: Hans Verkuil <hansverk@cisco.com>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 27 Nov 2014 08:41:59 +0100
Message-ID: <5476D5C7.7030400@cisco.com>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aer-iport-4.cisco.com ([173.38.203.54]:54354 "EHLO
	aer-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaK0HwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2014 02:52:12 -0500
In-Reply-To: <1417033655-32332-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On 11/26/2014 09:27 PM, Felipe Balbi wrote:
> commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> si4713 platform data) updated board-rx51-peripherals.c
> so that si4713 could be easily used on DT boot, but
> it ended up introducing a build warning whenever
> si4713 isn't enabled.
>=20
> This patches fixes that warning:
>=20
> arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [-W=
unused-variable]
>  static struct si4713_platform_data rx51_si4713_platform_data =3D {
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index d18a5cf..bda20c5 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -997,9 +997,11 @@ static struct aic3x_pdata rx51_aic3x_data2 =3D {
>  	.gpio_reset =3D 60,
>  };
> =20
> +#if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI47=
13)
>  static struct si4713_platform_data rx51_si4713_platform_data =3D {
>  	.is_platform_device =3D true
>  };
> +#endif
> =20
>  static struct i2c_board_info __initdata rx51_peripherals_i2c_board_i=
nfo_2[] =3D {
>  #if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI47=
13)
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
