From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] omap fixes and cleanups for v3.8 merge window
Date: Mon, 17 Dec 2012 20:08:52 +0200
Message-ID: <20121217180852.GA24440@arwen.pp.htv.fi>
References: <20121217180200.GU4989@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39595 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab2LQSQP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 13:16:15 -0500
Content-Disposition: inline
In-Reply-To: <20121217180200.GU4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 17, 2012 at 10:02:01AM -0800, Tony Lindgren wrote:
>  drivers/mfd/omap-usb-host.c                        |  3 +-
>  drivers/tty/serial/omap-serial.c                   |  3 +-
>  drivers/usb/phy/Kconfig                            |  1 +

I did mention I was against adding OMAP dependencies do drivers.
Interesting to see to commit going upstream without a reply to my
comment :-s

http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=3Dcommi=
tdiff;h=3D3e194c88f8b71700822828749187e65853ed8166

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQz1+0AAoJEIaOsuA1yqREt1EP/iG3aLclX2bXiUsABWkK4hyg
bztKYA+9rBqoHD8FCXRJCvO682WQmWIyyEAdwlbxtYGsC2o/u4kpYqRD32B3uwqE
UL2ZsQAShETHHFxSEGmsj2HiU7GvXYTStNFrCWRO4Zhrs5asKGfHDZT9IakgVA+A
cnE+J9oOSVivppQ/DTGxmvv3P1rPBTIOZpagD4ltx4X9niICkSpKeF4uGbWD25GV
exAEv+RrPOmG+5Ep0yQ2Sz2flzDEs7ghom7C3ISMtKI7RiOvCkGL2JGfpVOdgYVL
91Cc2a86ZfGqU26cHk+SAO7f+yajea08iAyPnVkvMVZis+r4efIfhEAYzLDPLS37
rtdpXdVGC8LOxhG9Fp2MVplgA1j1QYCndjcIcHSYPgV38piAvJ5ScD+TNav/g/cp
pMx/gZynBarc/x84xJKQDeGgYCpLfmq6gUmI5YiWRVmlWk2hX5k11bxRlf2w7Rra
04582J3xIkI8Fylz/vjmLSGevIiqVzqgUIVOL6Az4V39TQkx5eDNjANyA2yrr1Rm
HgOcjMf5dOPJvm8sbzte1k8gBXbttKbFvn/hwg5WrjVE5JIcNr1U/wbLgZAFdkRu
tePnD4fSKX1zrJfcBS/S7ZjrGzOAm5v/Rrbkc27LO02ywUodQ4nvTlmlBzKS5xuI
3Bb2Jrw5Qq2IrvoQ46g2
=zHjh
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
