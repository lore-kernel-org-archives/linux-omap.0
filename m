From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 06/12] ARM: omap2: mark unused functions as __maybe_unused
Date: Thu, 27 Jul 2017 12:08:31 +0200
Message-ID: <20170727100831.dixjoysxje6vkduq@earth>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155209.3250880-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6j2wckdkcwaopzwi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170720155209.3250880-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--6j2wckdkcwaopzwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 20, 2017 at 05:51:44PM +0200, Arnd Bergmann wrote:
> The omap_generic_init() and omap_hwmod_init_postsetup() functions are
> used in the initialization for all OMAP2+ SoC types, but in the
> extreme case that those are all disabled, we get a warning about
> unused code:
>=20
> arch/arm/mach-omap2/io.c:412:123: error: 'omap_hwmod_init_postsetup' defi=
ned but not used [-Werror=3Dunused-function]
> arch/arm/mach-omap2/board-generic.c:30:123: error: 'omap_generic_init' de=
fined but not used [-Werror=3Dunused-function]
>=20
> This annotates both as __maybe_unused to shut up that warning.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Tony Lindgren <tony@atomide.com>

I guess I am CC'd because of get_maintainer's git feature? Anyways:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

> ---
> Originally sent in Feb 2016, but it got lost for some reason.
> ---
>  arch/arm/mach-omap2/board-generic.c | 2 +-
>  arch/arm/mach-omap2/io.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/bo=
ard-generic.c
> index dc9e34e670a2..b1e661bb5521 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -28,7 +28,7 @@ static const struct of_device_id omap_dt_match_table[] =
__initconst =3D {
>  	{ }
>  };
> =20
> -static void __init omap_generic_init(void)
> +static void __init __maybe_unused omap_generic_init(void)
>  {
>  	pdata_quirks_init(omap_dt_match_table);
> =20
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 1d739d1a0a65..1cd20e4d56b0 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -410,7 +410,7 @@ static int _set_hwmod_postsetup_state(struct omap_hwm=
od *oh, void *data)
>  	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
>  }
> =20
> -static void __init omap_hwmod_init_postsetup(void)
> +static void __init __maybe_unused omap_hwmod_init_postsetup(void)
>  {
>  	u8 postsetup_state;
> =20
> --=20
> 2.9.0
>=20

--6j2wckdkcwaopzwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll5u58ACgkQ2O7X88g7
+pqq4A/+LV+9Xg9nGeQJROObei5ub/Jk+Aztiy3qjuHWQOy+MlZbJU9G+95oAG7A
dYjKVXRXaDB7Il/vwRC11TZSG0zoSQJVeN/bEzIuMn/Wd0sMIAP5imC4st/EqKt5
q5puk66GhhG42aRaLf4wMAnWa4YrMhQGQ3W7OYUkJ4tYBIPBegnxvOozXaqjw6Qv
gIcffZ+bLr5bRkohOj5kwqcQcxv4Z3nUDnTKOVZBJGR0sCrF1XGm01BxY9DKwrHp
LPAwwdC/+ooyMEMKX8WI6ZRF34A/o3GyhfPCrDU4NCb9C66hW0vQoMZ+12bMKCAS
IR4QKliUfEEO1ATyOMjkZrBcWeDSdnh3q3X2sY4zd3qk4BMpLDYetxYIUDHx4cFW
Mj1p1x62Z770wsb4KgzvmX2VO5k24QnLzBNRL9g/HbCgUOVYcnLn0NBAXwrB2Frj
bcB8iIsZfmZcWEPPIFqhxdmyZ/XBb/d5U+Krai+VgdJDcNohqUx3kwBpDjzC9Ufk
nhNADOf8vS3oQap+3U1T/MqoiYadavzMaY0bLXHU9Phteq6K17ijT3gqZhH3wPPk
/Jd76MbXxkQTkaHgwSBBomcmu8nboR/obdQXDTCuZl9IEa9ZHjoPlQqKSI7Lb+x+
v8cZFfvhA7OKrD8bcLrJ/jFG64oTVdFPoC4AwiMwm/nu0xn+haM=
=23hb
-----END PGP SIGNATURE-----

--6j2wckdkcwaopzwi--
