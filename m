From: green <greenfreedom10@gmail.com>
Subject: Re: 24xx/n8x0 booting again, linux-omap updated to -rc5
Date: Tue, 20 Oct 2009 17:08:49 -0500
Message-ID: <20091020220849.GC22912@swansys>
References: <20091016012747.GA12576@atomide.com> <20091020163102.GB22912@swansys> <20091020185627.GJ12576@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:65442 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbZJTWIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 18:08:53 -0400
Received: by ewy3 with SMTP id 3so5359243ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 15:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091020185627.GJ12576@atomide.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tony Lindgren wrote at 2009-10-20 13:56 -0500:
> * green <greenfreedom10@gmail.com> [091020 09:31]:
> > But I must be missing something somewhere... I have not yet been able t=
o get=20
> > the N810 to boot.  I see only the Nokia splash.  Note that I just want =
to see=20
> > the framebuffer console at this point: I expect a panic due to no root =
fs.
> >=20
> > Attached is the config I'm using, which is based on n8x0_defconfig.
>=20
> Looks like your config ends up waiting for root on the mmc. But we're mis=
sing
> what was board-n800-mmc.c, so that needs to be updated for mainline.
> You can find the old code in the omap-2.6.30 branch under arch/arm/mach-o=
map2
> if you have the cycles to update it.

I did not expect it to boot, even if mmc was available (no rootfs exists on=
=20
either mmc).  But the framebuffer does not seem to be working.  I would lik=
e to=20
see a console.  Any idea about that?

> Also, the drivers/cbus needs to be updated to get the GPIO pins from
> board-*.c files, otherwise the retu watchdog will power down the system
> in 30 seconds.

Yeah, I see the Nokia splash for roughly 30 seconds before the device power=
s=20
off.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkreNO8ACgkQ682C+dBP+oTe3QCdGfRfsq/Ol+F8jcg4wVz0uUHn
d/wAoM208tPqHIoeom3MyR34gMvjGVoN
=a2VL
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
