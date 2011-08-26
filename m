From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [patch] dwc3: add a kfree() on error to dwc3_testmode_open()
Date: Fri, 26 Aug 2011 12:43:22 +0300
Message-ID: <20110826094322.GC22532@legolas.emea.dhcp.ti.com>
References: <20110826092113.GO5975@shale.localdomain>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdEaXsHGJIWX/19R"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110826092113.GO5975-z0WHZYlhLlzP0Z7Jsv878P8+0UxHXcjY@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--gdEaXsHGJIWX/19R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 26, 2011 at 12:21:13PM +0300, Dan Carpenter wrote:
> We may as well fix this potential leak so we don't have to listen to
> the static checkers complain.
>=20
> Signed-off-by: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

applied, thanks

--=20
balbi

--gdEaXsHGJIWX/19R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOV2q6AAoJEAv8Txj19kN1m4oIAJI8Ernwcj4wpLt16V1ceJOV
7iLFRtaOJy2rRax+02D3ZqPOJahBlLJbtkkXTdEIVqE2Qd6lucR5CD1cLrKvsc84
qFeFYLho5ski6QpHboXcb/Ssimz/UpkfRSCzQs+UGOGy0d2BKw7I1Nyx1Zz7yDkK
B3Z8D1TFxO+Jqzzga4/Bj5z4OmFphBzEJcEHkH0strlpaz/JyohFhmYxJbbF7biL
3q/AtNruGM4u6N61b/MW9YdpF41FZ2UEvXXuqumupU7JMTseRaHYIoFRnF3+UjjN
JQPNdmC0yaeetg5JutQ858VzET3B1gStAA/WRZAxA4DmS0J+GruBYJdPekCz6/A=
=XvsU
-----END PGP SIGNATURE-----

--gdEaXsHGJIWX/19R--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
