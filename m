From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
Date: Sat, 9 Feb 2013 18:53:35 +0200
Message-ID: <20130209165335.GA13338@arwen.pp.htv.fi>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148Ab3BIQxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 11:53:43 -0500
Content-Disposition: inline
In-Reply-To: <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2013 at 01:38:12PM -0300, Ezequiel Garcia wrote:
> Fix gpmc_cs_reserved() so it returns 0 if the chip select
> is available (not reserved) or an error otherwise.
> This allows to use the return value directly and return a proper error co=
de.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index bd3bc93..604c1eb 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -452,12 +452,16 @@ static int gpmc_cs_set_reserved(int cs, int reserve=
d)
>  	return 0;
>  }
> =20
> +/* Returns 0 if CS is available (not reseverd) or an error otherwise */

s/reseverd/reserved/

>  static int gpmc_cs_reserved(int cs)
>  {
>  	if (cs > GPMC_CS_NUM)
>  		return -ENODEV;
> =20
> -	return gpmc_cs_map & (1 << cs);
> +	if (gpmc_cs_map & (1 << cs))
> +		return -EBUSY;
> +
> +	return 0;

you could use a ternary operator here:

bit =3D gpmc_cs_map & (1 << cs);

return bit ? -EBUSY : 0;

But to be frank, I'm not sure this makes that much sense, I'd expect
gpmc_cs_reserved() to return 0 or 1 depending on the state (just as it
was before). The name of the method asks for a boolean return value.

--=20
balbi

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFn8PAAoJEIaOsuA1yqRElpwP+wbSk4EndYUhrh/uTIEH/f1Z
/EWWblNVLbMGrDLokKI+uw6BbHbTubnfxP8UMrNSw6LEEl25pEOcW4TNFXcXpNPl
JIKcq9ZuFpTJCScMaeDrqmhSxbLwdZT0/lEUgrcBZSFwGGO3uOImm9SSf/rXPhux
Oq1DLCOrM2dHW5WNNF+xNd6UMyq1t+AZ+Aj+Jhd85ny83bX4Estf3Qj1IOeMUVdr
1WEX4z8tiV++3meWHOx9R1GLxNK7Z9R19lmsMMC81OxTQDKkzLvlGypUZLi8RSw1
2u+rP4f7vvdYHDZnlsFPuDTZDg+AH0wH5qtmBNq74LV0110Tb281OBpn4ekgMDYr
0WmeR3SOkgUoen7T6mh6p0qMSO9AKwkZVQPj0m9ZfomRPaSLg4KeA3NZLVOloeji
t/i+Rrp0dogsx+hp1zjvOlofsxwDVi0PUSZgH1EXVE+FX/OqezAy2I63joMWgJcF
o3LplHuAAHiVins664NbbOBDZZGKXXW9KmuhmPjfH5X4aEA35CzX97OEG5T8djfA
LnB0Pv2x676bgkiRkRbVQVpO4b8F1Qbnnk9oSRB4HLAGBzwe20IsqJK+0x61p3EK
gwSBg6IJGiYB/jD683DFCBU0bGkpJVIKD7y2Pz51PGL5YxmStH/2f5hZpkZwebEe
9rlQtvOZAWHscNmBFEYl
=Fh+c
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
