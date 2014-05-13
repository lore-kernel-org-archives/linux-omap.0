From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/8] usb: phy: fix isp1301-omap dependency on tps65010
Date: Tue, 13 May 2014 10:26:31 -0500
Message-ID: <20140513152631.GI1151@saruman.home>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-5-git-send-email-arnd@arndb.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399557141-1346645-5-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 03:52:17PM +0200, Arnd Bergmann wrote:
> The isp1301-omap driver cannot be built-in if the tps65010 driver
> is a module, otherwise we get a link error from the reference to
> the tps65010_set_vbus_draw function.
>=20
> There is already a hack in the driver to work around the problem
> of tps65010 being not available at all. This patch extends that
> hack to ensure that the real tps65010_set_vbus_draw() function
> is only called when it's avaiable.
>=20
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/usb/phy/phy-isp1301-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp=
1301-omap.c
> index 6e146d7..35a0dd2 100644
> --- a/drivers/usb/phy/phy-isp1301-omap.c
> +++ b/drivers/usb/phy/phy-isp1301-omap.c
> @@ -94,7 +94,7 @@ struct isp1301 {
> =20
>  #if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
> =20
> -#if	defined(CONFIG_TPS65010) || defined(CONFIG_TPS65010_MODULE)
> +#if	defined(CONFIG_TPS65010) || (defined(CONFIG_TPS65010_MODULE) && defi=
ned(MODULE))

nack, I would rather see a real fix, possibly also fixing the original
hack.

--=20
balbi

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcjmnAAoJEIaOsuA1yqREsHIP/i6A23/UcJeYz4s+Ed8y60/I
2zX8hlGWQf/6B6gnIWCZenNk7duVuHlsmImcA+Ja7weGzK1l+rxuUZWNUXjp/4iT
logymzThsMFamxnddMIgVBZNCQDuA5wBngfvfwzde04vwhz1Tdt5RGkr4JksgJ8A
3prhzr8MYA5+Fj5nnoH8wuMyXtzvDsNfaCU4RtbOoqGvQtrRiVyTVxcL9k82LYlS
fWUFJaozJ6CIGz+M6d2YTs3ccpNAdPeVywJb/CDzLcEwcTnoda9Y1wDcryCR6xwe
cxItuqYvOUzrJnhS90uEKCom3zAOM/hFL1yzkr3Eh0hUzU6SP9Ree02J3d/+Ev6V
C/86u0GBjUxtoFNIZOFb9/alFw4oGVbzBRg3sNsbyZRyssrnobd4gQBvnGhMWdf2
qnuJ6zm+jQVSFOV+IWeaOtI9aoeQJJZ+QN+ZHjqerEEiEMsbWF0uxBNd9aatBky8
c1W5EX0MNEqdw2B0n12PB1G388lNthc7/qxTxUqmrUjwXzg357POrAmKnMX5fD3o
OipDyL3zTM/ax0DTGhs6u+5vb+4R8dWHBeyMAovLUEcV9fu06FxKRdZG7h0ZP493
j0CmhBDQQTW2XNWNMSFCJBA+4Z7tOe93/usidxLZHokrJjXxBHMD+rTnShViZ3RK
FT0NB9V5TdFPiLYxDCZe
=9REK
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
