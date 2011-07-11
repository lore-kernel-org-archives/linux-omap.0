From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 09:21:14 +0300
Message-ID: <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
 <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37181 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757177Ab1GKGVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 02:21:21 -0400
Received: by mail-yi0-f54.google.com with SMTP id 13so435383yic.13
        for <linux-omap@vger.kernel.org>; Sun, 10 Jul 2011 23:21:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 10, 2011 at 05:43:23AM -0600, Paul Walmsley wrote:
> On Sun, 10 Jul 2011, Felipe Balbi wrote:
>=20
> > On Sat, Jul 09, 2011 at 07:57:20PM -0600, Paul Walmsley wrote:
> > > Hello Hema, Felipe,
> > >=20
> > > Commits 208466dc10083e734a8af71d10f923ee4bff950c ("usb: otg:
> > > OMAP4430: Powerdown the internal PHY when USB is disabled") and
> > > fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430:
> > > Power down the PHY during board init") break compilation on OMAP2:
> > >=20
> > >   LD      .tmp_vmlinux1
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to=
 `omap4430_phy_init'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to=
 `omap4430_phy_exit'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to=
 `omap4430_phy_power'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to=
 `omap4430_phy_set_clk'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to=
 `omap4430_phy_suspend'
> > > make: *** [.tmp_vmlinux1] Error 1
> > >=20
> > >=20
> > > Could you please figure out a clean way to fix this for the 3.1 rc se=
ries?
> >=20
> > Patch attached, if you want to queue it for the merge window.
>=20
> This patch doesn't build when based on the arm-soc omap/cleanup branch.
>=20
> arch/arm/mach-omap2/twl-common.c:55:19: error: 'omap4430_phy_set_clk'=20
> undeclared here (not in a function)

What on earth is arm-soc omap/cleanup branch ? I generally base my
patches off of Linus' tags. This one in particular was based off of
3.0-rc6 (or -rc5, can't quite remember). Where is this particular branch
I should base off ?

--=20
balbi

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGpZYAAoJEAv8Txj19kN1PfkIAIMMAOllqUuI0ulVwz6UKb6m
5URhVzooxKWB62jIfrlVbvoXqjfHk602caPSjme2oER5kA0oKW/lwMaPVrjWJa+P
/T1aWov2qE6W8J+ewjMx4APx311GN2orvlgBnMlQqkInjJMp4ykuhKrHv5oYhV0x
sRkgTeWJUqYsGGYTXeSzfjwQ1CyIFMcG7wYoAbwF6b6snTMBIqbUbv2MUFIwOKoP
yymH2UVu6mXPh/Nts1b/sLsLxDE3snEg054eFZrPKUueedwCF+MNJ03+b5Gxugik
ktgNHiQMkElLoWbCYg5iuyyVGRoAEvDM6SSPHBYJGMm3JVRzj4b1QzgV3BNkqNc=
=O4Bj
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
