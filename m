From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: use proper child nodes
Date: Thu, 25 Jul 2013 17:30:00 +0300
Message-ID: <20130725142951.GG16106@radagast>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
 <1373031178-8871-5-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042Ab3GYOaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jul 2013 10:30:12 -0400
Content-Disposition: inline
In-Reply-To: <1373031178-8871-5-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Benoit Cousson <benoit.cousson@linaro.org>

--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 03:32:57PM +0200, Sebastian Andrzej Siewior wrote:
> This moves the two instances from the big node into two child nodes. The
> glue layer ontop does almost nothing.
> This could be two indepentant child nodes but I have no idea how
> 'ti,hwmods =3D "usb_otg_hs";' affects the two musb controler.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

pretty good :-)

--=20
balbi

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8TZoAAoJEIaOsuA1yqRERZ4P/R1/WUDWFOQ6/0iF4X2x4QhT
Y0x0CROqbODw8gTtauDrTeZPgVB+amlaUnYovPbXJ8dD0DPxGfVGhGHxlr+1Hue4
+fvOSV6eTDAEVTuTW6D3Ekgxe/T2PeXXgaPXt+fkUqc4+8qii3uSiVLKu0tyPBxh
K8fzvOFzUSrm96B1y8vB3XqnU4kvJXTgTiicPZmh2brKub1dctMunl+EG/yIbClf
5RGY6DrB5HA+jO1lzjql+xkuF/SFi3IMcrw2Ky7uuR/RKnpqjjl+j3PZivyUV68I
28MVjk8pj7/QV3CZjn42B1f/5s34VcRtZCAoYwsBuoHBLpFhHAa0Aph0YFfNHS+B
r16cLTHUTVYyGlOrPeWrlW09eXwpYD+mZ2rQNPAtJii7qv0toKquxZF2Fr0TE3JC
2CqwZkDmFePvz0N4+cECvBJmXHYRnvDbWpB8Zk9iE9xvS7TKfbnEoxzI4EnjRxWW
ONcyTgjV3cEbugIc6nCDL11zJiqecyvdem0auVbjXoVTL84Tl0BH1TkQ24H0YXE1
YXAV8uXP7o5VHIauQAJO4nGzahM/lMJPBbCFvYtuUMANja76vmhdzZ8KiLj0yTDo
RVTUu3ZTw9RMDrv+zHIiop8ueU+rVAhqqRc6uwOgnVWVTLLRGcYBpLmVuLJL5oI4
TP0xDeeNwLqOYdfnB9iO
=2tPv
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
