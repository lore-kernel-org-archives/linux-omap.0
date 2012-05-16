From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Wed, 16 May 2012 12:08:20 +0300
Message-ID: <1337159300.7692.22.camel@deskari>
References: <1336033721.14378.2.camel@deskari>
	  <WC20120503084938.900446@terrafix.co.uk>
	  <1336050442.14378.10.camel@deskari>
	  <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	  <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	  <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	  <1336483598.5761.45.camel@deskari>
	 <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti>
	 <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-x5yhvx+u/oh9Zubtys8s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47334 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965873Ab2EPJIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 05:08:25 -0400
Received: by lbgc1 with SMTP id c1so799003lbg.1
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 02:08:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-x5yhvx+u/oh9Zubtys8s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-15 at 11:55 -0600, Paul Walmsley wrote:
> Hello Tomi,
>=20
> On Mon, 14 May 2012, Tomi Valkeinen wrote:
>=20
> > I've been doing testing to understand the problem, but so far I don't
> > have any idea why things go wrong. I haven't found out any logic in
> > which configuration works and which doesn't. Looks to me that for some
> > reason the PM prevents DSS from getting data fast enough with certain
> > fifo thresholds.
> >=20
> > I have two ways to avoid the problem, but I've been reluctant to make
> > patches for those because I feel it's just hiding the problem. One way
> > is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
> > other is to use certain fifo threshold values, which just seem to work
> > for unknown reasons.
> >=20
> > Considering that we already have a SIDLEMODE hack in DSS for omap3 when
> > using DSI, I wonder if the omap3 PM + DSS combination is just plain
> > broken, and we should disallow idle. I'm not quite sure what are the
> > implications of that.
> >=20
> > I'd appreciate comments from the PM people =3D).
>=20
> This may be caused by one of the DPLLs going into autoidle.  This can=20
> involve a significant wakeup latency.  I'd suggest looking at DPLL3, whic=
h=20
> provides the DSS interface clock, and DPLL4, which can provide the DSS=
=20
> functional clock.
>=20
> Could you try:
>=20
> 1. applying something like the patch at the bottom of this message and=
=20
> seeing if it makes any difference?
>=20
> 2. if #1 does not work, changing the "dpll3" in the patch to "dpll4" ?
>=20
> 3. if #2 does not work, disabling autoidle on both dpll3 and dpll4?

Disabling DPLL3 autoidle fixes the problem. Disabling DPLL4 autoidle
doesn't affect the problem.

But... Isn't the iface clock only needed to program DSS? When the DSS is
just running independently, plain func clock should be enough, right? Or
is iface clock used for the communication between DSS and
CORE/DPLL/wakeup/something?

I also suspect that this could be just a plain DSS bug. The default FIFO
low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling the
FIFO when there are 960 or less bytes in the fifo, and stops at 1023.
The fifo is 1024 bytes). The values are calculated with fifo_size -
burst_size and fifo_size - 1.

We are now using FIFO merge features, which combines multiple fifos into
one when possible, making the fifo size 1024*3 =3D 3072. Using the same
low threshold and increasing the high threshold to 960/3071 works fine.
Changing the high threshold to 3008 causes underflows. Increasing the
low threshold to ~1600 makes DSS work again.

So I think that the high thresholds of 3071 and 3008 are so close to
each other that there shouldn't be any real difference in practice,
presuming everything works. But, for whatever reason, fetching of the
pixels becomes much more inefficient or with much higher start latency,
causing the underflows.

I guess we'd need HW people to debug this, but their interest in OMAP3
is probably long gone. So I think I'll just have to use values that seem
to work for the use cases we test.

 Tomi


--=-x5yhvx+u/oh9Zubtys8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPs26EAAoJEPo9qoy8lh71CbUP/0cidWnXUXPzfM8bdvpaYFSn
hM0Aj+QtkB98UMhz73nlyjk4lNWbPxl86bUBj5FzrzM31SV8rh1kbiTRL07VgDnw
YSbuZTmB2al5fMeF2iW2vaUvcb/bro8NrQQaGoIahfnH9Ou5T1YW7bAbYqUw9CYB
ovSpAsCymjT1C0WvW9r0LZGZdbTP+OF+AAQobMBExTAtaUxYKekuw6AI27WYNehi
bcqAdcyJMuI9vf1O2yE+S5qsS7oOplUrNu2l1xbuyzBiW0dyIFHwCBPKeisSArUq
Lbg9G/gjrJcMy6MRLxvE5oGVyHw67I5gltHEpx/vcyYn1ljuYzEdEoUGNw7WHurk
+uqQqbT4AADYHdRYWgRnHwWOlf1OFhrNpRmjJAFcMvxrk2zv9iKXCZAdHswYiIBm
2Erel+VMcMj5n/cDpbbFlxEzYuOSGJ0p9LVPkhyZItRRLwNBFU+dNqO1klGzNT/8
hDID64XL+BmmywHA1SHk4EVtRcATz+7R6okkKgzResLfQq/HZYiNDhblA/6HwJb/
a5oLDpN1JJwJdkrILCQvDzLyzucXWMgYN/kNEvprzcZ5FYi/dCb0pRFdWA6Mej8a
Zj5d7ig11uIa8rxDZDJ2H5jdxaT7jhsvJROw0vAFMXwFZQMRWUXt38T4mlgSHWt+
PKo4Xq79JqZqLU2wkRY6
=+F8W
-----END PGP SIGNATURE-----

--=-x5yhvx+u/oh9Zubtys8s--

