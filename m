From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Sun, 23 Jun 2013 00:47:17 +0300
Message-ID: <20130622214717.GA1569@arwen.pp.htv.fi>
References: <1371935030-20773-1-git-send-email-pekon@ti.com>
 <1371935030-20773-2-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51352 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab3FVVr5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Jun 2013 17:47:57 -0400
Content-Disposition: inline
In-Reply-To: <1371935030-20773-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: tony@atomide.com, artem.bityutskiy@linux.intel.com, b-cousson@ti.com, arnd@arndb.de, avinashphilip@ti.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2013 at 02:33:47AM +0530, Pekon Gupta wrote:
> From: "Gupta, Pekon" <pekon@ti.com>

Can you fix your From address ? I guess:

git config --global user.name "Pekon Gupta"

should do it, but you'll have to recommit those commits with:

git commit --amend --reset-author

cheers

--=20
balbi

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRxhtkAAoJEIaOsuA1yqRE02gP/2TjYSUDrUxnZXm2USBTI8UM
eiuOgbadEevAkKlhvsNn50WGdwbmzZr2NRhzjh0GN+xsF4KBMUIITkNxj52IIdQI
40nazy4sV93bu+tLKBWhVdBldWayhKD2IEuM5725f0zK+58LGJDi9Iz+UPWjK/82
gNrafBlNqZOBCk/74mB/jc//wupFuat9gRShzPGTum0PFKiWFRX6FCaNEvth/HWF
BLq1whb2lOVEXmoxBPB1K1qmDxnjYdisrapzzCkwjL3tqzzj5wRJrbkRuzjgRm+b
kFLij1Fo446KQ32MaEabBFKikhzPiO9D8ushcbxchdzPxU0WCWnAzTtEVW+KdWXt
bO7YQhZxNoB18xpAA0XbJWUDPv4RkywI0804IA6Sh5H+z09mEUoikzS9vaLfYs+0
AgDkC8pgcksbI/uOLXGAk+3VG0jERqkFe2j9ZYTZGs0N4H2eV94aLSQ6tXWL9LI/
iUg1FQeYk5F+X9h2Ij5YdXwvLWwu2UOJGQ+sdjc3mh41nsSpJwToYftXx/mXF10S
QeWukT20yA/iylmeGgQN9iXvWp6ZBC3SA06jONC6d9erfHfnNpO4sb2qImDCadcI
ViCGpZ60Kz76eC7b+sKy3KMesD8/xXT/1x5Wp5ck+MogByutcG9ZPsOg8GpX4T7d
ncaDDmpOdVQeszE/lFbp
=Ue2M
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
