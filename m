From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 08 May 2012 16:26:38 +0300
Message-ID: <1336483598.5761.45.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	 <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-okXJl0iae9tC1o4sjqZo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53335 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753815Ab2EHN0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:26:44 -0400
Received: by lagr15 with SMTP id r15so5013019lag.2
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 06:26:41 -0700 (PDT)
In-Reply-To: <1336143500.2552.23.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, khilman@ti.com
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, Joe Woodward <jw@terrafix.co.uk>


--=-okXJl0iae9tC1o4sjqZo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 17:58 +0300, Tomi Valkeinen wrote:
> On Fri, 2012-05-04 at 17:54 +0300, Tomi Valkeinen wrote:
> > Hi Kevin, Paul,
> >=20
> > On Fri, 2012-05-04 at 15:09 +0100, Joe Woodward wrote:
> >=20
> > > > > Ok, I can replicate it now. It seems to be somehow PM related. I
> > > > > normally have USB gadget stuff compiled into kernel so that I can
> > > > boot
> > > > > via nfsroot with usb. After disabling USB support from the kernel=
, I
> > > > can
> > > > > see synclosts.
> > > > >=20
> > > > > I have no idea yet what could be causing this. I've also tried ad=
ding
> > > > > the couple of DSS patches which are in queue for next merge windo=
w,
> > > > that
> > > > > force OPP100 when DSS is enabled. They don't seem to help.
> > > >=20
> > > > Also, at least on my setup, the sync lost doesn't happen very quick=
ly
> > > > after starting the video output, but (I think) only when the system
> > > > starts to idle. My init scripts generate keys for sshd and some oth=
er
> > > > stuff, and no sync lost there, only just before the shell prompt do=
 I
> > > > get a sync lost.
> > > >=20
> > > >  Tomi
> > > >=20
> > >=20
> > > That sounds like the same as I'm seeing. It seems that the sync lost =
jumps=20
> > > around a bit, from almost immediately (when the graphics are enabled)=
, to=20
> > > up to 3 or 4 seconds later (still just before the shell prompt).
> > >=20
> > > I'm assuming that setting the FIFO low and high points fixes your syn=
c losts=20
> > > as well (as in the first patch you sent)?
> > >=20
> > > I've also noted that doing things in different orders can sometimes f=
ix the=20
> > > sync lost (such as disabling or enabling DVI output), but this all se=
ems a bit=20
> > > random.
> > >=20
> > > I'm just glad someone else has been able to replicate the problem :p
> >=20
> > Kevin, Paul, there seems to be a problem with DSS on v3.4-rc4 running o=
n
> > omap3, causing DSS losing sync. I didn't notice this earlier as I have
> > USB gadget compiled into my kernel. Removing USB support from the kerne=
l
> > causes the problem to appear, which more or less hints at a PM related
> > issue.
>=20
> Sorry, not sync lost, but FIFO underflow. So DSS is unable to fetch
> enough pixels to update the panel. And in this case the pixel clock is
> very low (small panel), so it's nowhere near any limit.

And two more interesting points about the problem:

Setting DISPC's SIDLEMODE to no-idle seems to remove the issue.

With some DISPC's fifo high/low threshold values things seem to work,
while with others we get underflows. And as the required bandwidth here
is quite small, and the threshold values I tested are close to each
other, I don't think it's really a proper bandwidth issue.

I'm guessing that certain threshold values cause somehow un-optimal
accesses to the memory, and with smart-idle this somehow causes
problems.

Archit, you looked into the thresholds some time ago. I recall that some
threshold values were "bad" in some way? Were those only for OMAP4?

 Tomi


--=-okXJl0iae9tC1o4sjqZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqR8OAAoJEPo9qoy8lh7166sQAKGdmkEZLl8RuHJNCfihIqm0
ZJUymiify1/rswtNC/mLqWA6im6SSv6Bz72eHqW462pC7AfoTM6kOJEx36uoc+p+
Rm2hoPVk5ukYTt21W+0ahIiHJvIjTgG6RI9L65aweZvL1fGD+h4c9tI35YKyC6vs
wp8h5b6E6dqroxReLhJTzawN5DkkgCGgef5OkxU84yUERTcHZ15RH7W5nXfJFkU9
X6nfvDcSBhpZ9fqFURLjnY3oguqZFYK6SRvqRsooGXeMEaAInC/WNl8Y9FZZP3Gu
SyXyc2qTfhjqBCA0VIM67hmcIEnX7CFiI4MsTfNqBysBry9Xa7WP16XKbWRiqV7G
J4AMmu94yU3ufa+BGmAUZWrkQROAnyzQ3jjTe5jr6jkrOD++he0DDUE76JgLqcog
e7BNF8buzrTzdYQM9YpO28ZUaAa1LNj4HkIS83lsCRgro+uXjjMtdmnMXRpiw6+Z
ENBdQQgTAV/WM0sgbHBGisqCH3PTpxF81jlH3uhrlUhtUSynC00oFF5A1rFEvYYR
9A7iumchqyFUUdkn7fc0w1ggTTiqpOzWZeA8V0K79Rr0koKjxPjWKHEsEaZYlsHe
lMSwCxW1LdGnNxP8w1Nnc4ta+hAwG26GdRy1uSw9NL9He4BzniIpd5MH10AD8zC0
whOOhXyE6AyVmtYtP2i3
=EsLf
-----END PGP SIGNATURE-----

--=-okXJl0iae9tC1o4sjqZo--

