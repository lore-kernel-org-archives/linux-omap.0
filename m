From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 5/7] usb: phy: twl4030-usb: check if vbus is driven by
 twl itself
Date: Wed, 20 Mar 2013 15:07:50 +0200
Message-ID: <20130320130750.GR29659@arwen.pp.htv.fi>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
 <1363544607-17634-6-git-send-email-notasas@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zpd1bWBxfrI+71+6"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363544607-17634-6-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--zpd1bWBxfrI+71+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2013 at 08:23:25PM +0200, Grazvydas Ignotas wrote:
> At least on pandora, STS_VBUS gets set even when VBUS is driven by twl
> itself. Reporting VBUS in this case confuses OMAP musb glue and charger
> driver, so check if OTG VBUS charge pump is on before reporting VBUS
> event to avoid this problem.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/phy/phy-twl4030-usb.c |   36 +++++++++++++++++++++++++++++++=
-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4=
030-usb.c
> index 425c18a..87bf11d 100644
> --- a/drivers/usb/phy/phy-twl4030-usb.c
> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> @@ -248,11 +248,31 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 =
reg, u8 bits)
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> +static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
> +{
> +	int ret;
> +
> +	ret =3D twl4030_usb_read(twl, PHY_CLK_CTRL_STS);
> +	if (ret < 0 || !(ret & PHY_DPLL_CLK))
> +		/*
> +		 * if clocks are off, registers are not updated,
> +		 * but we can assume we don't drive VBUS in this case
> +		 */
> +		return false;
> +
> +	ret =3D twl4030_usb_read(twl, ULPI_OTG_CTRL);
> +	if (ret < 0)
> +		return false;
> +
> +	return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : false;
> +}
> +
>  static enum omap_musb_vbus_id_status
>  	twl4030_usb_linkstat(struct twl4030_usb *twl)
>  {
>  	int	status;
>  	enum omap_musb_vbus_id_status linkstat =3D OMAP_MUSB_UNKNOWN;
> +	bool	driving_vbus =3D false;
> =20
>  	twl->vbus_supplied =3D false;
> =20
> @@ -270,20 +290,26 @@ static enum omap_musb_vbus_id_status
>  	if (status < 0)
>  		dev_err(twl->dev, "USB link status err %d\n", status);
>  	else if (status & (BIT(7) | BIT(2))) {
> -		if (status & (BIT(7)))
> -                        twl->vbus_supplied =3D true;
> +		if (status & BIT(7)) {
> +			driving_vbus =3D twl4030_is_driving_vbus(twl);
> +			if (driving_vbus)

how about just:

if (twl4030_is_driving_vbus(twl))
	status &=3D ~BIT(7);

????

--=20
balbi

--zpd1bWBxfrI+71+6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSbSmAAoJEIaOsuA1yqREp5gP/AjBuWlfqcNeC8CTcBPUTiE2
f50NbPggvpe82LCi4sEFUJgw6uDSz9Jt7L/TqC3CtM524Gy/TKvNtGhZqABco3Jo
oq7CdqQmwTJGtKCjb4x9in0t7MJSi3IuLY4oK8djuz5WXqECJJBZg5+iVM23hRY5
+VM0dg0p5mGKyZpiNrv+qQJEwBYGdJI4NNH6y0jfBhsAPGySj5vVj0WZzzjoCwYE
JipUgFsNkrtO/rfXi7mrpHn+ZQyVR0ZmzUZOLl871z3b4pmiV+EoHCOkm+vPpQ2b
QhWX8sFyUOzmoHzkEux4c3bV+hzmq4bEqp4Mha53UOn3ct2uED7XTlXTMDBNz2O5
2F8I6YlhiTHb726Hi8o4x64+HrzaCxyNquNQSD/+MU4JrGPnv+r3s6/zq1mPY7Hi
8qoLpiKUHrtXM1rapBgEjCVztvGHOgijHNnVaLHhLXKb+JkN/bnTy8GFJsaF588a
oLrPAIBDRxCUdpUfRgpjb6x1ea/A2WgRa8fKmj4wYXYyk3ebeSqy9dUKfdt9jP+Y
BANYjhS6yQMZKXyu/iBHtZbc8xCTK8MVUxuICOXaHGwiOL8CP/ijBnSQTj9olNB9
hXy5JMs5YenjslegxdzMPc7GNR5Clg0KsFiCPceGkxAjfcXn5RWjVtb2dswhQKKX
iA0mw2VCYWgs8NyF1/W1
=MyLG
-----END PGP SIGNATURE-----

--zpd1bWBxfrI+71+6--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
