From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
Date: Tue, 18 Mar 2014 09:04:43 +0100
Message-ID: <20140318080443.GH11360@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
 <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
 <20140317171136.GC30471@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47442 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaCRIEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 04:04:54 -0400
Content-Disposition: inline
In-Reply-To: <20140317171136.GC30471@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 17, 2014 at 10:11:36AM -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Markus Pargmann <mpa@pengutronix.de> [140315 06:12]:
> > This driver extracts the hardware macid from the control module of
> > am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
> > to get the macid from within the processor.
>=20
> Few things have improved recently :) This can be now implemented
> in a much cleaner way using regmap against the already defined syscon
> node.
>=20
> For an example, see how the MMC PBIAS regulator is using regmap
> in Linux next:
>=20
> 11469e0bb1 (regulator: add pbias regulator support)
> cd042fe5c1 (ARM: dts: add pbias dt node)
>=20
> That avoids the problem of the tinkering with SoC specific registers
> that belong to another device.
>=20
> So please update this series for regmap, let's not add more mapping
> of system control module registers to the drivers.

Thanks, I will have a look into this and update the series.

Regards,

Markus

>=20
> Regards,
>=20
> Tony
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTJ/4bAAoJEEpcgKtcEGQQckEP/2Iz88huJVYH/GBCBdm390NH
AlEZg5mQ0ZQUehpseUQxnMqD7IqfYBEY8dGwMYxrFeQ6MqPXhqwVxnXZnftVHX4P
koN35d7okMBtL67vycjC8qFcGjHGHnw8A1avema2jy6Z35SQ5a5YOigVkmyf/zRX
N79cL4FHFlog3ReuQZBZZuOqBBwu1OMkgad9yz0i5OeyHqSm+xd5Q0DYYNTjv3H1
+R9IexU7ii1fAomzYRTZW0BFys8pdTz1o0/NoS7HcUzwG0UycagOKo51nL3Qt7G4
LkFaDNmhj0wy5VQztgoAPYYrmwR0omX6ZGqwfFoJ+Y/DRsRMmfeee/Mv8LuJexeg
OnUgXVSpbngHIz+Qu1TIKZxsQ5TMQE5rJuSVkJ5tQ/5/wfIc3XSIQxb/jk9yzXWf
KfPB4qVE/H5cfv9sACAdlbzRLIcq7l1kxWNopqYLQAaH9VA83rKR0wfVHbqC6hlk
mrr1+tw91X3/sF0V1ekZkfWXVQAFGEzWIgdqQe+rki+s3+p3HznSclaoq73mK2fm
JKLpb33k/Ob6qsjUp49H7mwimrhrO3U6SlcQAlrSZE4RbAgk7NpJya+rQr9re/NH
lynAU/85xTI42wCia7gg1K28TrHv+GN4Qs2M+btxL0IVXKfdxVyN+PL3itHwm1qf
Uv1BIpckPcV7TgGlQoof
=1gRq
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
