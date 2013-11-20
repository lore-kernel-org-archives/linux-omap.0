From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
Date: Wed, 20 Nov 2013 10:09:59 +0000
Message-ID: <20131120100959.GV2674@sirena.org.uk>
References: <cover.1384862950.git.jsarha@ti.com>
 <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
 <20131120102342.7befe75e@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jz2RIiWkXBLiaBi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53627 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3KTKKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 05:10:24 -0500
Content-Disposition: inline
In-Reply-To: <20131120102342.7befe75e@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Jyri Sarha <jsarha@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com


--4jz2RIiWkXBLiaBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 10:23:42AM +0100, Jean-Francois Moine wrote:

> But now, I am wondering again about these `empty`codecs:
> - in a DT context, should we continue to add / modify such codecs?
> - what do you think about my generic DT codec? (indeed, I would do a new
>   version according to the previous remarks)

We still want to be able to have users just name the CODEC on their
board rather than have to type in all the details from the datasheet,
if we're going to try to amalgamate the drivers it should still let
people do that.

--4jz2RIiWkXBLiaBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjIpzAAoJELSic+t+oim9h14QAJW/PVQUKOznoNKVXTdu9DEw
UBS/UDjc3gg+VzXYHeJG5+mdUJjwXe3LD0MXI0vXNla4VPgRy+wSJA6xWX3UFs9J
mSfb/gbuayMM9i2qRmm86CaM9TluKEunhGacZ5BCs6dwzfJrVgM80Il0ESkK76BY
/vY6Lcn0WtGEgojNskmbGGR3NirRnkemNcs6Jz8elK5pVblqwYX8vQEi+Lja/veN
pXEXZH7IWdWuzfNZce/vU3LFCyJI9g/tifssdQYrK30F+IELj/gATCIMCDTqAHJ3
jD3DUs98eZ4wWkugXDrNhi9U9cE7ihPiJanHBz+WkefbRLL5985fi/pCLlv5SKuY
N6/23Mh4I+f/ETbnJPYHDbyBx78ARFz7bD60TLAlyOMkUezt+aZXH1480bEuZGSL
Nxd3KNjO2xEWJuwJlkdQS35GprX0lWj3x9SLAEVOKt86LgZyhx0muiYOgN11l3O6
YMpUFVCrxm0BMR11benOv/qvvKNMDg8Gvbgzul1DKOfQLlhFJQx0UULMYDqYm6r2
okbWAP7uwJT4JTkcSgDYs3590yNvq5eYGlSpjesoOXK+EfL1wdG0kWU6XB4YnnYf
hnknEEh+wlJ3kgWrMqYzSFqaif7byTNcC21fqy6HhcTMsNMusN3F4vTIfqwChkXP
FxFxyUmknSa7dkpjiRys
=h209
-----END PGP SIGNATURE-----

--4jz2RIiWkXBLiaBi--
