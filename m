From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Mon, 9 Dec 2013 14:01:21 +0200
Message-ID: <52A5B111.3010307@ti.com>
References: <52A29A82.106@collabora.co.uk> <52A2A3EF.1030306@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="x2a9SnsX5VohohiFsHTB4kjLHJXkNvABV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40028 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932604Ab3LIMBm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Dec 2013 07:01:42 -0500
In-Reply-To: <52A2A3EF.1030306@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--x2a9SnsX5VohohiFsHTB4kjLHJXkNvABV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-07 06:28, Javier Martinez Canillas wrote:

> Actually, I looked at drivers/video/omap2/connector-dvi.c and it does t=
he right
> thing for legacy platform data probing but no for DT probing:
>=20
> static int dvic_probe_pdata(struct platform_device *pdev)
> {
> ..
> 		adapter =3D i2c_get_adapter(i2c_bus_num);
> 		if (!adapter) {
> 			dev_err(&pdev->dev,
> 					"Failed to get I2C adapter, bus %d\n",
> 					i2c_bus_num);
> 			return -EPROBE_DEFER;
> 		}
> ..
> }
>=20
> static int dvic_probe_of(struct platform_device *pdev)
> {
> ..
>                adapter =3D of_find_i2c_adapter_by_node(adapter_node);
>                 if (adapter =3D=3D NULL) {
>                         dev_err(&pdev->dev, "failed to parse i2c-bus\n"=
);
>                         omap_dss_put_device(ddata->in);
>                         return -EINVAL;
>                 }
> ..
> }
>=20
> The following patch solves the issue if you want to include in your pat=
ch-set:

Thanks, I'll add this and the omap3-igep0020 support to my DT branch.

 Tomi



--x2a9SnsX5VohohiFsHTB4kjLHJXkNvABV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpbERAAoJEPo9qoy8lh71wG4QAIBSCuEU8CfFAhDUcipbXYbp
frdhNEUr+HsQP/7UlCNInPh6bntuz6KRFDVpxSGNhJxXxGr5xg5PIL4EdYMAGgt+
4Ke/8c9ejRLOh+HzUsdao2ssBFmmbZFVE2HZ6GqaZ4AfCx6h7/B8WQD93Ar9kIUu
emdaI8rZGt3mA53w9bTfuHTZdddZTbwrdDbZLd0muk7dLLfJgHgA0eoOdpO+Lslw
mDFrVtE28iF0QXoIuGwsWNYyPOprCX8uEkY9QkUZDSrLnY/UpxN42XzhGx0iE2sR
Cy1ZQdTa6GppvejtDqmrBReL16wVJlKpQsbv7VDtk3y8yrtxBmuz/9cBmk63SLt4
eVar4h4H1R2Ge2v7Qo954GijaVh0BZCAUGLrwrMdYkhtlRlY9Be/uydrVsrE+Uhq
yuSMi2+nLfxYXKX/1EatevpFLpQ19Z0TfPmetcL5A7SPPp32WdrQpqC+GLs9eqp0
IBBRTAxXDV2eKj9GILnaKGjWMkZIWeQCmVh5SaLRqlZ/VNqU4ZY33zfRKIXqNs/u
SEzWa2yeGsmO9i1uY42A8Lh2Fkcyds3K/KqlmvHlg7gxw/bgKH5rc8bjqX63l+3y
7w0xHR89d4vFGyPMHuRX/AsAZqwleN4TYZepLm3LGnf3rWCsKt9FT52+06Zfzsme
Kpwg0yJ37CGfqCZ16VbR
=rGoT
-----END PGP SIGNATURE-----

--x2a9SnsX5VohohiFsHTB4kjLHJXkNvABV--
