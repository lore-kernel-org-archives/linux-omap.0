From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 15 May 2012 10:28:17 +0300
Message-ID: <1337066897.1951.12.camel@lappyti>
References: <1336033721.14378.2.camel@deskari>
	 <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	 <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	 <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk>
	 <1336982138.2532.32.camel@lappyti> <87mx5apefo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pJz2SAj0JOEUSF6BDNCF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:60440 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757113Ab2EOH2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 03:28:23 -0400
Received: by lahd3 with SMTP id d3so3921599lah.19
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 00:28:20 -0700 (PDT)
In-Reply-To: <87mx5apefo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-pJz2SAj0JOEUSF6BDNCF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-14 at 15:48 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>=20
> > On Mon, 2012-05-14 at 08:36 +0100, Joe Woodward wrote:
> >> Any news on this?
> >>=20
> >> This thread seems to have gone a little quiet...
> >
> > Hi,
> >
> > I've been doing testing to understand the problem, but so far I don't
> > have any idea why things go wrong. I haven't found out any logic in
> > which configuration works and which doesn't. Looks to me that for some
> > reason the PM prevents DSS from getting data fast enough with certain
> > fifo thresholds.
> >
> > I have two ways to avoid the problem, but I've been reluctant to make
> > patches for those because I feel it's just hiding the problem. One way
> > is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
> > other is to use certain fifo threshold values, which just seem to work
> > for unknown reasons.
> >
> > Considering that we already have a SIDLEMODE hack in DSS for omap3 when
> > using DSI, I wonder if the omap3 PM + DSS combination is just plain
> > broken, and we should disallow idle. I'm not quite sure what are the
> > implications of that.
> >
> > I'd appreciate comments from the PM people =3D).
>=20
> Unfortunately, without the bandwidth to dig into this deeply myself, I
> don't have much to add.

Yes, that's understandable.

However, can you shed some light about the PM in OMAP3. What is it that
happens here regarding PM, which does not happen is USB gadget driver is
compiled in? Or when I set DSS to no-idle or no-standby? Something about
L3/core/memory going into idle state?

I tried to look at the debugfs/pm_debug/ files, but I couldn't see a
difference between working and non-working cases. At least the
OFF/RET/ON/etc states were not affected. Are there some other debug
files to look at? Are there power saving features that are not
observable via debug files?

> As we know, it's not unheard of for various IPs to have bugs in
> smart-idle mode ;)
>=20
> The one thing I can say is that the reason it probably worked on earlier
> kernels was because the UART driver was not actually idling, so you were
> probably never hitting low power states. =20

There is also a change in the DSS fifos, which probably triggered this.
I think I can fall back to the old behavior.

 Tomi


--=-pJz2SAj0JOEUSF6BDNCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPsgWRAAoJEPo9qoy8lh716bkP/i4nsX+ULe9x7UMJR8i3frqI
8V+B5ZDIAxoHz5KZr00vRjMNpiOOsSG/iCL0DWy5p6VCKSnLgMeM8q558reD0O/1
jzAWNn6DHExx7iqFjFyxs943BaA1xx4cPoyU2FdDPvmfdcHByIJ4+pv621Kbsfqi
NeiLhR3QicTxyEcbSRUHqIuE/gCC+WwPOZjwH1YPTzTjxVCoVpDPAGRqxoIIy2fN
5WwNmNO9i0YFM1+KHmwUHWPvn4bIHKRvxw2xRWSscqpZu01ir4EKwapf01zxO53g
+J6vDvTVmOHGfvJ2DVGksaI/s9i8n6kKvf/94lRfAFJZnSEk9dVfBYPzZS2sgomw
mTB4PVr8sRNPXJ4N5AFQX8vHTFw6CqlM8TgeozD3CoaRnVId98+158UdG1wvmgSC
YmBkj7AK5YwbpYZfDzFG+uU/c0p+HCBw8CDFtZk2xBwVCnuJG1eTs/IIsoCjrGyL
S7t/e34cboHIyqScUH0IE/MsGAGHP/xLTFgISU+rFCifUKgSwaeWzjQvnAhsUY5H
jgw3L+lU3FsUpUbClaV9IOOcV5Lwg3PtUr7zaM385cyKbe8YqwoPCJGGxbSkLm2S
a0AXU9N1vyxmlOHMvLLEWRe77GoJczrTqhDFJcomRfAyhQU7QN5iK1JK6dehVC9l
PQdVeVvLcjw6VIz5tKm+
=XJQH
-----END PGP SIGNATURE-----

--=-pJz2SAj0JOEUSF6BDNCF--

