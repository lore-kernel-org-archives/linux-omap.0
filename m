From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sat, 21 Jan 2012 17:57:07 +0200
Message-ID: <1327161427.1863.5.camel@lappy>
References: <1327055619.1921.57.camel@deskari>
	 <alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ql7yS5aY+1KDowg/Srdd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59334 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384Ab2AUP5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Jan 2012 10:57:19 -0500
Received: by lahj13 with SMTP id j13so1052235lah.32
        for <linux-omap@vger.kernel.org>; Sat, 21 Jan 2012 07:57:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-Ql7yS5aY+1KDowg/Srdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-01-21 at 00:47 -0700, Paul Walmsley wrote:
> On Fri, 20 Jan 2012, Tomi Valkeinen wrote:
>=20
> > Third, when I load the DSS modules, I see only ON state increasing for
> > dss_pwrdm, as it should be. However, I'm getting constant stream of syn=
c
> > losts from DSS, and the display doesn't basically work at all.
> >=20
> > I can see MPU pwrdm going into RET a lot, and if I do "while true; do
> > echo foo; done", which I presume basically prevents RET for MPU, the
> > display becomes stable.
>=20
> If this particular problem persists after you apply the patch set that I=
=20
> sent earlier, it suggests that something in the DSS is sensitive to the=
=20
> amount of time it takes the MPU to wake up and service an interrupt when=
=20
> the MPU powerdomain is in a low-power state.  Total guess, but perhaps =
=20
> omap_dispc_irq_handler() is getting called after each frame and needs to=
=20
> run within a certain bounded time when that happens?

No. After the DSS has been configured and started (by the MPU), it runs
by itself, reading the pixels from the memory displaying them on the
screen. Only when the user wants to change the configs or the frame, the
MPU does something. And interrupts are only needed to handle the
changing of configs or frame data using VSYNCs as the interval. The user
probably doesn't like it if the VSYNC irq is handled a few seconds
later, but the DSS HW doesn't care, and functions normally.

In this case something is affecting the DSS (clocks? powers?), or the
memory, or the process of reading the pixels. I really don't see the MPU
or IRQs affecting this problem, except indirectly.

 Tomi


--=-Ql7yS5aY+1KDowg/Srdd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGuBTAAoJEPo9qoy8lh71wVoP/3GgKoXoMhzAF1qk5pWLOrD2
0s/zj/KQNoaWJJfgY715hPICS9vdsbt8w160CQ5jJwiIWzWYt7lJO/wHCwLa/HAr
RDH4lbQ7uMNzevc1Kl+c8dfAFC7FW2ETdEMzZx6MsO724Aof440H5lZvUG+VbVZ5
9TazSZ1swBwaMaouYDipd7muBaKBKKLD6emUBzIKyWY1SWHKMp1U3o9jEe6Xxcbi
LBvEofeie8bvnI6FT3SQrRIXXc1MbY4TeBHZOfihOuTHjek3KB9TPwyT7VLcE4b6
LfSAHyPR5ZQ/jLJqpagk+rLozp+hEkpzVFw8iLF8tlzGdnjoFLPdx+yj4wdM1bnJ
IkOTjvqmB1OYflUKNoEhGnq/R4XeGruUBPWYxDaCKy+1KOmvm91/4PZxcjE+MMGS
W2LboqDZlKpHf16lKQHGbe1PAKSWjUzdAAnAtQ4ZAFLdSpB3wGB5OLKcH8GWThDo
wAy1//VZSh2n4gxF6MR5316WODSMSeLmIcT6/mtF1Zh7JZ/EWTTDma9SjEMjsHAO
UBynIPjyERYSslrCdvx9h1CF/5nHGAPBk8ARkzRn6FQvB+b+nanQlH6s+eT97XuC
NF9EYuEzxa6zCM0pwm+rJGU7YvO634++wE1KDDNUVV1szH3X1qPPvyPdj4UdIQvU
Dl7oNVdu1ttFhuGY9jHq
=IlTP
-----END PGP SIGNATURE-----

--=-Ql7yS5aY+1KDowg/Srdd--

