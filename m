From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] RX-51: Add support for OMAP3 ROM Random Number
 Generator
Date: Wed, 18 Sep 2013 13:39:49 -0700
Message-ID: <20130918203949.GI9994@atomide.com>
References: <201303281854.02847@pali>
 <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379534757-20870-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379534757-20870-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 13:15]:
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Description please, then also add a note that this makes
sense to do as a platform device at least until we have
some ARM generic way to deal with SMC calls.

>  arch/arm/mach-omap2/board-rx51.c  |   10 ++++++++++
>  arch/arm/mach-omap2/omap-secure.c |   11 +++++++++++
>  arch/arm/mach-omap2/omap-secure.h |    1 +
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/b=
oard-rx51.c
> index db168c9..c2a3e39 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -93,6 +93,14 @@ static struct omap_musb_board_data musb_board_data=
 =3D {
>  	.power			=3D 0,
>  };
> =20
> +static struct platform_device omap3_rom_rng_device =3D {
> +	.name		=3D "omap_rng",
> +	.id		=3D -1,
> +	.dev	=3D {
> +		.platform_data	=3D rx51_secure_rng_call,
> +	},
> +};
> +
>  static void __init rx51_init(void)
>  {
>  	struct omap_sdrc_params *sdrc_params;
> @@ -113,6 +121,8 @@ static void __init rx51_init(void)
>  		/* set IBE to 1 */
>  		rx51_secure_update_aux_cr(BIT(6), 0);
>  #endif
> +		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
> +		platform_device_register(&omap3_rom_rng_device);
>  	}
> =20
>  	/* Ensure SDRC pins are mux'd for self-refresh */

Maybe this should be in board-rx51-peripherals.c instead?

That way we can initialize the legacy platform devices
from there for DT based booting too and don't have to
move code around when moving to DT based booting.

Regards,

Tony
