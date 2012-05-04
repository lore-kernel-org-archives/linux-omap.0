From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Fri, 04 May 2012 17:58:20 +0300
Message-ID: <1336143500.2552.23.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	 <1336143281.2552.21.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fuYpt9O63+qXx0MmiFvz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53600 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753914Ab2EDO6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 10:58:25 -0400
Received: by lbjn8 with SMTP id n8so3005512lbj.14
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 07:58:22 -0700 (PDT)
In-Reply-To: <1336143281.2552.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Paul Walmsley <paul@pwsan.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-fuYpt9O63+qXx0MmiFvz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 17:54 +0300, Tomi Valkeinen wrote:
> Hi Kevin, Paul,
>=20
> On Fri, 2012-05-04 at 15:09 +0100, Joe Woodward wrote:
>=20
> > > > Ok, I can replicate it now. It seems to be somehow PM related. I
> > > > normally have USB gadget stuff compiled into kernel so that I can
> > > boot
> > > > via nfsroot with usb. After disabling USB support from the kernel, =
I
> > > can
> > > > see synclosts.
> > > >=20
> > > > I have no idea yet what could be causing this. I've also tried addi=
ng
> > > > the couple of DSS patches which are in queue for next merge window,
> > > that
> > > > force OPP100 when DSS is enabled. They don't seem to help.
> > >=20
> > > Also, at least on my setup, the sync lost doesn't happen very quickly
> > > after starting the video output, but (I think) only when the system
> > > starts to idle. My init scripts generate keys for sshd and some other
> > > stuff, and no sync lost there, only just before the shell prompt do I
> > > get a sync lost.
> > >=20
> > >  Tomi
> > >=20
> >=20
> > That sounds like the same as I'm seeing. It seems that the sync lost ju=
mps=20
> > around a bit, from almost immediately (when the graphics are enabled), =
to=20
> > up to 3 or 4 seconds later (still just before the shell prompt).
> >=20
> > I'm assuming that setting the FIFO low and high points fixes your sync =
losts=20
> > as well (as in the first patch you sent)?
> >=20
> > I've also noted that doing things in different orders can sometimes fix=
 the=20
> > sync lost (such as disabling or enabling DVI output), but this all seem=
s a bit=20
> > random.
> >=20
> > I'm just glad someone else has been able to replicate the problem :p
>=20
> Kevin, Paul, there seems to be a problem with DSS on v3.4-rc4 running on
> omap3, causing DSS losing sync. I didn't notice this earlier as I have
> USB gadget compiled into my kernel. Removing USB support from the kernel
> causes the problem to appear, which more or less hints at a PM related
> issue.

Sorry, not sync lost, but FIFO underflow. So DSS is unable to fetch
enough pixels to update the panel. And in this case the pixel clock is
very low (small panel), so it's nowhere near any limit.

 Tomi


--=-fuYpt9O63+qXx0MmiFvz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo+6MAAoJEPo9qoy8lh71XcMQAKsxQ5AhKFk7xVUJ9vVfScaX
thgcvotyd7VHDRNv8aHm7grBI1Z8O0atKZPmBIE+k+inashh1z90KN3hz4iSt2RZ
EXYy/sw/ssg5xmxXU4BksgVCe0hpOuY3jvhSIkqBKYunKNgY7Tg9ObqxTyQhAkTn
gnHInr3cD2D7b4vxlNLC7tt+57SZSnlZ2Hrzm1TCdQGNjYi7ubjVENxXMru12pev
IUe+59HlVIkkhVZCvlXQGNlfYNxr8C1gfj3TAo/5T20uv7SmJDC4TE7gX/mx2FAK
XOer51iUbtZbQ7AWHkyc516BeXDFb/WeB7JSmDajCfYmhkPppfp1p9EGuUohXUZf
fAW4CTScSl+yv0jbc+q0IXHK07w04dH8xWQR3hxdZmtpTStB4R8omTV5WGfrxTjJ
2VaqfcvIMvaYd9/4dUlFUkJ51KwFEB1ESP9tTeAoGWZvA48Bq1ZJQhmYBsNyBXOn
PN4EiF/4BoJ5Zu1z64S4+mCS84W8hyOZmPKTkxkWdk+t+wey97672DKZ/kFJU9eX
YuGqpy+TxjCiLX+iLkS+9H7cZt7+6Rg8rs6ch0TEPmb5VKb61yKbMboWsU+RX/vt
ZL7CppfQv34snqSBENORhSlA6lVLwnuhsTGtdsuEDJ9u+qdNfu9UFHG6XfUviFNv
m3O8YeK8340XBth9rieX
=sbwY
-----END PGP SIGNATURE-----

--=-fuYpt9O63+qXx0MmiFvz--

