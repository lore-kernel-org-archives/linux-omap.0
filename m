From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 04/12] ARM: OMAP1: OHCI: use platform_data fn ptr to
 enable OCPI bus
Date: Wed, 11 Apr 2012 21:26:37 +0300
Message-ID: <20120411182634.GA9396@arwen.pp.htv.fi>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003528.27059.8836.stgit@dusk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120411003528.27059.8836.stgit@dusk>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

+Alan Stern

On Tue, Apr 10, 2012 at 06:35:38PM -0600, Paul Walmsley wrote:
> The OMAP1 OHCI driver needs to enable the OCPI IP block before it can
> work.  Previously, the driver was simply calling a symbol defined in
> the OMAP platform code, but this is incorrect: drivers should be fully
> decoupled from platform and architecture code.
>=20
> So instead, modify the driver to call through a platform_data function
> pointer instead.  We skip any DT aspect, since OMAP1 is not scheduled
> to be converted to DT in the near future.
>=20
> This resolves the following sparse warning:
>=20
> It also gets rid of a cpu_is_omap16xx() call in a driver.
>=20
> In the long term, it probably makes sense to move the OCPI bus code to
> somewhere under drivers/.  This should avoid the whole platform_data/DT
> issue with this function.
>=20
> Also interesting is that drivers/usb/host/ohci-nxp.c contains a stub
> for ocpi_enable() - perhaps the NXP chips use a similar OCPI IP block?
>=20
> Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

FWIW:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

ideally ocpi.c would be a platform_driver

> ---
>  arch/arm/mach-omap1/usb.c               |    3 +++
>  arch/arm/plat-omap/include/plat/board.h |    2 ++
>  drivers/usb/host/ohci-omap.c            |    5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 19de03b..e61afd9 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -29,6 +29,8 @@
>  #include <plat/mux.h>
>  #include <plat/usb.h>
> =20
> +#include "common.h"
> +
>  /* These routines should handle the standard chip-specific modes
>   * for usb0/1/2 ports, covering basic mux and transceiver setup.
>   *
> @@ -138,6 +140,7 @@ static inline void ohci_device_init(struct omap_usb_c=
onfig *pdata)
>  	if (cpu_is_omap7xx())
>  		ohci_resources[1].start =3D INT_7XX_USB_HHC_1;
>  	pdata->ohci_device =3D &ohci_device;
> +	pdata->ocpi_enable =3D &ocpi_enable;
>  }
> =20
>  #else
> diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap=
/include/plat/board.h
> index d5eb4c8..4814c5b 100644
> --- a/arch/arm/plat-omap/include/plat/board.h
> +++ b/arch/arm/plat-omap/include/plat/board.h
> @@ -91,6 +91,8 @@ struct omap_usb_config {
>  	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
>  	u32 (*usb1_init)(unsigned nwires);
>  	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
> +
> +	int (*ocpi_enable)(void);
>  };
> =20
>  struct omap_lcd_config {
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index 96451e4..71229cb 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -205,8 +205,9 @@ static int ohci_omap_init(struct usb_hcd *hcd)
>  	need_transceiver =3D need_transceiver
>  			|| machine_is_omap_h2() || machine_is_omap_h3();
> =20
> -	if (cpu_is_omap16xx())
> -		ocpi_enable();
> +	/* XXX OMAP16xx only */
> +	if (config->ocpi_enable)
> +		config->ocpi_enable();
> =20
>  #ifdef	CONFIG_USB_OTG
>  	if (need_transceiver) {
>=20
>=20

--=20
balbi

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhczaAAoJEIaOsuA1yqREf9IP/AxX75MMgI6QN1iNzguNzV9t
RDokOk7hSMhHBnxb2onwHQkOfi77DGTPhkeA13CLmHnw84U2I847uSVSEAQpwa4J
6XLSKa49PO4ARcGpctcV2FWKD2YRk6dNpCT15AuI+RA2knC9Y6vzZi23D4qnDN2v
EkdiezcUIT7letPmePno2XxJ6OEeEWyQheXzrlimTti5A7+W/bfEYHZnxFXeRoyB
7Z+XNlhg1cpR7/iMlJDhSqrkf7gDmrmJ2qqnEEe2ez6yAgTsPmARypw8mNrNugxB
1FzEuCnW1yXmx/1xjXsDWQCDX1D1LkVolgW+OeHUcF8z0FINkKVRbiapnZDD4xSK
khyXEYZtv/4GB8aquDPorJ4VZ2/NlrqvYtR6dfliwAyEWLrxwwnZuFGcGa00L/AG
QGDtaLb62xPOelSKQpq3LKCX4rxUSJOQU+mjDpIEbIQgb+IG58Ri3qaAT1RHojM0
loWBerRh5QUbX374Vvy9I70dinMf6A8sesIZ9UO1VZVZaRDQJ4VIFVvluWeV7Pjf
RK/Mo9GgN22pCHsAqtUXYW0OX2bTfc910jB0OfU/PB42GbyuU2QgzGFg1fyNWC7N
Sbpb1nnKdsu2rcqMJJU2mZBZT0aAFWzMN403Z7svORgk0YxjN6y/CGRpNwKCZs9M
ekYkgWqDUXSn0S0gjhld
=Czy+
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
