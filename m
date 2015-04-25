From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Fri, 24 Apr 2015 21:10:24 -0500
Message-ID: <20150425021024.GA14963@saruman.tx.rr.com>
References: <20150424190207.GU19431@pengutronix.de>
 <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429906850-5420-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-K=F6nig wrote:
> ti,hwmods doesn't belong into the compatible section but is a property
> on it's own. Also reformat the section of required properties to match the
> usual style of dt binding documents.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

looks great to me, thanks

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
> Hello Felipe,
>=20
> what about this patch before the previously sent patch 1?
>=20
> Best regards
> Uwe
>=20
>  Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Do=
cumentation/devicetree/bindings/watchdog/omap-wdt.txt
> index c227970671ea..597e19d18dca 100644
> --- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> @@ -1,10 +1,8 @@
>  TI Watchdog Timer (WDT) Controller for OMAP
> =20
>  Required properties:
> -compatible:
> -- "ti,omap3-wdt" for OMAP3
> -- "ti,omap4-wdt" for OMAP4
> -- ti,hwmods: Name of the hwmod associated to the WDT
> +- compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
> +- ti,hwmods : Name of the hwmod associated to the WDT
> =20
>  Examples:
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOveQAAoJEIaOsuA1yqREL0gP/34NgRMjYSMyHQO8DchbdLJ7
L9XsBtm/6JEVrlye/wGl+dTa/iNLXrF1Eb8nrqc36gUsXIO6snhVzS6+5fzL+QWh
qrzIJtfRbYdYNjIvbduUmNLZ0OmJZV12I7GxpvebgTnEamDVJ05QuP/twVm5gVkL
rq7kN2xspX5IplMuewC2pvxYXn2EfrhkFVwTfmdo3nKZ/y6GESq6eZgo9kWlh7ob
p47lehxFrqJdmqVDWKok15hbfkOSWaQ8jib5RqtwxkeKMr7PKp8A7JFLJt6plNBe
z6KA1C7bdDQp3MKy3I8PQB4PxAdroPgYmgcbztM3WFy4IL/Uj1M9kr6y/1DKlen6
7MQQ4rMI1eJMSX6luKVBwLQnMPy5Tqh9fUvhCNhukRJFxcDih0+W27xxVI0wqIr2
ax8vafSHsOEk8DK/57OO4/UyYjJc18V0OSNvatt2PWr4aTGQIM+ILu1Q7JHFMsKR
N8cd8G0lUguE86vaSicEBETm6EcezfYyHGHLEkyqn9DSLh6908CnC+CA0rIE1zY9
PSgNLh1swvvwr0qyCNDXuMp0oiGAsfYA0NU1JtHl/HfI4XgQR2dseREJpkjtg2gm
ITQK160CIW6hm4SUBY0aPIZ5bNWIGI8N20DcyzZSxch3uWTaMArUFVN9cFD7C00H
APhT8A0FQXgonbic1dF+
=qbg9
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
