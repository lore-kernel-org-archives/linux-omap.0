From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 3/3] can: ti_hecc: Add DT support for TI HECC module
Date: Fri, 17 Feb 2017 14:54:35 +0100
Message-ID: <5eeddc52-4bdc-6f40-51a4-f8e4d14e6b9b@pengutronix.de>
References: <1487339158-18809-1-git-send-email-yegorslists@googlemail.com>
 <1487339158-18809-4-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4woCS7riNlxXpl4W3aLUTw8klU4GlknPN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487339158-18809-4-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4woCS7riNlxXpl4W3aLUTw8klU4GlknPN
Content-Type: multipart/mixed; boundary="RI1Dp1huQ4w7CEojVNLIuNSi0Q7ctawrT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <5eeddc52-4bdc-6f40-51a4-f8e4d14e6b9b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 3/3] can: ti_hecc: Add DT support for TI HECC module
References: <1487339158-18809-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
 <1487339158-18809-4-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <1487339158-18809-4-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

--RI1Dp1huQ4w7CEojVNLIuNSi0Q7ctawrT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:45 PM, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>=20
> This patch converts TI HECC driver to DT only driver. This results in
> removing ti_hecc.h containing now obsolete platform data.
>=20
> Former transceiver_switch callback function will be now modelled via
> regulator API.
>=20
> Signed-off-by: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

What about ti_hecc_remove(struct platform_device *pdev)? - As you now
are using devm_ some manual deallocations will go away.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RI1Dp1huQ4w7CEojVNLIuNSi0Q7ctawrT--

--4woCS7riNlxXpl4W3aLUTw8klU4GlknPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlinAJsACgkQHv7KIOw4
HPYXcggAmogD1WAlogHGdGvt26l8h9vxDYLechKlJHiT+e6gpZoj2RzJeMV7d90z
Nr9tgozVPVjmhwQH7Z2cMl2Lns+1FDfsvr6fNT8Wfdm78VSbeYbHGzK8VWQit+jD
nzJFTpXC+TH/q3nEe/36veBI7A5KzRsY15jcJqOcW7IxfSrMd3Gzs/RjOjRkfMKn
cI9StccwohV7q6revi2Bg8UIZDmE+vApzpbdQYDw44DMck8p5hKngVT60RBmRQa0
qPIUIvXadReGagKrQUa7vBkZflSyeF1RGNEJQlurcNygKcoXGbqNVKK6Z/ke3E3n
qE+CVzY6ZSpujKoc/tk88kGifoSTDQ==
=3EOY
-----END PGP SIGNATURE-----

--4woCS7riNlxXpl4W3aLUTw8klU4GlknPN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
