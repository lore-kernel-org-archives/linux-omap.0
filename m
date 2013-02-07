From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc6
Date: Thu, 7 Feb 2013 10:32:17 +0200
Message-ID: <20130207083217.GA15462@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57008 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493Ab3BGIcZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 03:32:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 06, 2013 at 11:34:32PM +0000, Paul Walmsley wrote:
> Boot tests:
>=20
> * am335xbone: hangs after "Starting kernel"
>   - Cause unknown
>   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
>   - http://marc.info/?l=3Dlinux-omap&m=3D135903184512238&w=3D2
>   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83942.html

After testing quite a lot and having help from other folks, the problem
(for me at least) was missing fdt_high in u-boot environment.

setenv fdt_high 0xffffffff

fixed everything.

--=20
balbi

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRE2aRAAoJEIaOsuA1yqREe5EP/2DHKumtATfBTXaikrUbWCCZ
Z7ZHeftMf/F8Ett0HIyBz4MiIx7pp16crEqCzhexJhYRjROmYuRhDgo2JAPqWykC
47ir0GVlbJdhBk3NaxQb9qvYxzBIZ7HzbippOCFVxjSJP1ScyxuXGyVkjJYxptpD
GyM4PyTrDdEQRbXAKspPxqaiOPV2O+3E3FFwq+LnhPVrmOEslaVklphg1N+rV8UZ
FvLphgxK5+LKRfKKohH5BvCJzEqIXWg48g7S9lIP+/O66OOtEx1WudWB5pMDdGUN
Ra/q2mICyFER3GkGk5WRtykKWEg6r9lRxB307sSiMW11JyEQvspNU1kO2GuqJFN6
DXsGnQj313lIUIK1UITJgSAkuyChujAOmyIr7VTLWYpnsCez1TApFqxOYAvYEktE
1hxpfW26SZUul/nRqe0Kkwrppyb69oJkHovwtqLvEbMpNGLySNoerW0Y49l1dk3o
Npp4KaYujKzfyrJe0Mv2MAajCdfMHFWJ4Nmt/F0cyowL+nV519HlSHkIe47z4DCj
1lw8O2rQ2KKYaqVn0PGy8Uixd+ZUWwJ88GvCKLYP0d8pY/CbT6aV+/C1wu9xuIg7
iieOOcdiopq5FCwy/uSFLYAZI1LPH/ZNHN+PmRSaUbtdmoK6jDOy1cg4iA0gbPwn
WC/pSdgvlXncZFUJLs+M
=PVHx
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
