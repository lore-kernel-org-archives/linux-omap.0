From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
 to use REGULATOR_SUPPLY
Date: Mon, 6 Jun 2011 12:21:27 +0300
Message-ID: <20110606092126.GG18731@legolas.emea.dhcp.ti.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
 <1307342762-25363-2-git-send-email-green@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59385 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1FFJVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 05:21:32 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so5178478bwz.33
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 02:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307342762-25363-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2011 at 02:46:01AM -0400, green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
>=20
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c          |   16 +++++-----------
>  arch/arm/mach-omap2/board-cm-t35.c           |   10 ++++------
>  arch/arm/mach-omap2/board-ldp.c              |    5 ++---
>  arch/arm/mach-omap2/board-omap3beagle.c      |   10 ++++------
>  arch/arm/mach-omap2/board-omap3evm.c         |   10 ++++------
>  arch/arm/mach-omap2/board-omap3logic.c       |    5 ++---
>  arch/arm/mach-omap2/board-omap3stalker.c     |   10 ++++------
>  arch/arm/mach-omap2/board-omap3touchbook.c   |   10 ++++------
>  arch/arm/mach-omap2/board-omap4panda.c       |   16 +++++-----------
>  arch/arm/mach-omap2/board-overo.c            |    5 ++---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   21 ++++++++-------------
>  11 files changed, 44 insertions(+), 74 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/bo=
ard-4430sdp.c
> index 63de2d3..914885a 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -332,17 +332,11 @@ static struct omap2_hsmmc_info mmc[] =3D {
>  	{}	/* Terminator */
>  };
> =20
> -static struct regulator_consumer_supply sdp4430_vaux_supply[] =3D {
> -	{
> -		.supply =3D "vmmc",
> -		.dev_name =3D "omap_hsmmc.1",
> -	},
> -};
> +static struct regulator_consumer_supply sdp4430_vaux_supply =3D
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");

this should be an array, as it was before.

> +
>  static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
> -	{
> -		.supply =3D "vmmc",
> -		.dev_name =3D "omap_hsmmc.0",
> -	},
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
>  };
> =20
>  static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> @@ -400,7 +394,7 @@ static struct regulator_init_data sdp4430_vaux1 =3D {
>  					| REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies  =3D 1,

and this should use ARRAY_SIZE(),

> -	.consumer_supplies      =3D sdp4430_vaux_supply,
> +	.consumer_supplies      =3D &sdp4430_vaux_supply,
>  };
> =20
>  static struct regulator_init_data sdp4430_vaux2 =3D {
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/boa=
rd-cm-t35.c
> index 77456de..33855e4 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -337,13 +337,11 @@ static void __init cm_t35_init_display(void)
>  	}
>  }
> =20
> -static struct regulator_consumer_supply cm_t35_vmmc1_supply =3D {
> -	.supply			=3D "vmmc",
> -};
> +static struct regulator_consumer_supply cm_t35_vmmc1_supply =3D
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");

this should also be array. It should read as:

static struct regulator_consumer_supply cm_t35_vmmc1_supply[] =3D
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0",
};

ditto to all others.

--=20
balbi

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7JwWAAoJEAv8Txj19kN1k/4IAJaXJpsGjAkeprZY3DAxWIqY
1Pts2bEasNGNaZrjyKAAevKr4smZQSOwGSqObTuwrtly7zyn85gDH5nZz6e+CZfb
5913lQ1mMqmLvI6HwqPuA3tdD/xRv4kQMvreqFPVTjItjmyWqoEWzm1uSsvibnxg
/yIF3Q2PSiWhK4Yxc2RiYlkEAf65LR8Z8Mbz+DZZ6v19C9lO7+tpjtxvD0vy0fli
7jE9Oi5nJLpg/at92vN2jPbqL7veR+VnDsQWoQYMVCdxEnWvLyXgF6QZ+VEnLwpk
q0D2CFgG0FL12g+QfMHHVRKZRmWKaVO665qVNN9jNplcAtirKGcHUIv7+bcLpUE=
=I2oZ
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
