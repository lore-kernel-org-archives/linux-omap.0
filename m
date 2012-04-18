From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Wed, 18 Apr 2012 16:13:35 +0300
Message-ID: <1334754815.2027.34.camel@deskari>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
	 <1331646353.2856.354.camel@deskari>  <87zkbkmjo1.fsf@ti.com>
	 <1331707131.1618.7.camel@lappy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-YG6PiGVEqUmYEwIq6U5A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:44212 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382Ab2DRNNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 09:13:41 -0400
Received: by lagz14 with SMTP id z14so7421332lag.14
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:13:38 -0700 (PDT)
In-Reply-To: <1331707131.1618.7.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com


--=-YG6PiGVEqUmYEwIq6U5A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

 Tomi

On Wed, 2012-03-14 at 08:38 +0200, Tomi Valkeinen wrote:
> On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
> > Hi Tomi,
> >=20
> > Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> >=20
> > > Hi Kevin, Paul,
> > >
> > > I know you're busy, but I'd appreciate a comment/ack on these two sma=
ll
> > > patches, so I could get them in to next merge window. Otherwise using
> > > any other OPP than OPP100 will most likely break the DSS.
> > >
> > > This looks quite straightforward fix for me, but I'm not sure if ther=
e
> > > could be any side effects.
> >=20
> > How does it affect OMAP3?  OPP50/OPP100 names are specific to OMAP4.
>=20
> They are? At least 3630 TRM speaks of them in the DSS chapter.
>=20
> > Also, Can you help us understand the exact nature of the constraint?
>=20
> The TRM lists maximum clock rates for the DSS clocks. You should be able
> to find them by searching "OPP100" in the DSS chapter. In my TRMs there
> are:
>=20
> OMAP3630: Table 7-19. Display Subsystem Clocks
> OMAP4430: Table 10-4. DSS Clock Frequencies
>=20
> > It sounds to me like it acutally is a throughput constraint on CORE.  I=
f
> > so, wouldn't it be clearer to set a throughput constraint that is
> > calculated based on the pixel clock and resulting bitrate that would
> > have the same effect?
>=20
> I don't see that these limits would have anything to do with CORE. I'm
> guessing that the DSS HW just can't function properly with high clocks
> and low voltage.
>=20
> Making a constraint for the throughput is another matter, which should
> be also fixed at some point. So in the future I hope we'll have PM
> constraints coming from two sources: 1) a calculation based on the
> memory throughput needs 2) the minimum clock rates.
>=20
> But both of those are non-trivial to code, so this patch aims to keep
> DSS working until those are implemented. Also, in practice, it's quite
> rare that the DSS clocks would all be below the limits in the tables.
> That could only happen with a fixed, known configuration with rather
> small displays.
>=20
>  Tomi
>=20
>=20


--=-YG6PiGVEqUmYEwIq6U5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPjr3/AAoJEPo9qoy8lh71McQP/0jlAB0o6ji/fB7isdymkCx1
PJnyfEDme8hNz9izdLGBrFkGhwk/tmq8JmdN8+VFqXbQpV2j5GZq5vIqZC55jPip
maqFJ/jBq+uKs+GoXZjtPr/UbBqyHuYFseCo5SxVUxskATJ0l5AQDl3zhcSQXyeM
NqEZs99Xx4iNBmmIhtmR8nxQNuvpwRPC3xSMa+Rz18bEP/YANRJci3o9DkHFV+gg
GfX7z/kqWYhEgsyD5oeRuY5GCAkthazH9cpHAvaGoJinVpr8ZknX7cOEWGfNKohi
Vo5mRk0sGsukvuLhIBJRvvWWEUrgHZayt2VUxmjWdZe5eP9jJSGKm7mQRIIUcrZX
YuWFGRTCKFnazf3nv3hFMIENTJqsGB7/EjhiRwa9cu6zEiEgvZbkWkI9HVCwa0Iq
NU3yX8zA786pOgzLZUBYFNT2aGryUpa25EfgLvX+H8Ci+oHUczmQr3S7Fgo8nY5N
XzGY/j3Qa6mg8HrocEZ8dAChXa7rmZhkXSnzJeGoaiTvkB66Xe5XQFj9mVo2+U30
GQj0o0Fl3fhbbVFbXRa0r37cA14x8JWTfXxyMDui/oIT60TX2zNE93eRipIoIb3V
Pvw2l/q4nkzkkF09Y9Ey96pgsZUkv6oDumBnM96eLlhv06QdcW1EbVmi705jZSzz
DoG0tumaq+S+IE0Q6QCW
=SQpI
-----END PGP SIGNATURE-----

--=-YG6PiGVEqUmYEwIq6U5A--

