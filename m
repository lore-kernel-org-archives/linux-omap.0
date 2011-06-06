From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
Date: Mon, 6 Jun 2011 22:24:38 +0300
Message-ID: <20110606192436.GO12242@legolas.emea.dhcp.ti.com>
References: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
 <1307386628-1153-2-git-send-email-green@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFMLoheMaWcIEZAi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52244 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753712Ab1FFTYr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 15:24:47 -0400
Received: by mail-fx0-f47.google.com with SMTP id 19so3118762fxm.20
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 12:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307386628-1153-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, peter.barada@logicpd.com


--UFMLoheMaWcIEZAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2011 at 02:57:07PM -0400, green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
>=20
> to use REGULATOR_SUPPLY arrays.
>=20
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: peter.barada@logicpd.com
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Acked-by: Felipe Balbi <balbi@ti.com>

I also compile tested with omap2plus_defconfig against 3.0-rc2 and it's
fine.

--=20
balbi

--UFMLoheMaWcIEZAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7Sl0AAoJEAv8Txj19kN1GrAH/iGzI7hTH4ntQUZWMB9Hux2t
NXcguOJ+SV3kA6T4lrdJk8Q8GMdpg8k4Q78OlSW1jEDlJuSyoAhvC/kDjQqa6CIR
rxXfSk8BfOSggwjWMkkm/LrUSnnA85XfNlgCCA5fsg8MLYUqY4l4PVmuj4pNIMxl
zmiK2tjAo6cMHDLGapTwTk2HrsaLzYN2A+e//KoICR1Fjs8kAgPqUW38/9eRqJ2q
Xs/Fnb4+Na9hcmejqBzTCFJCrPpOh0Xohg5sTJQESQaBKKejGWlTMtyFvrJVnw2T
E5oOr+RPQZqOWczeztwkmppcD7b2znwx34nQ4Dk72jNi8dy4TvHWosijL5PNJVY=
=asyO
-----END PGP SIGNATURE-----

--UFMLoheMaWcIEZAi--
