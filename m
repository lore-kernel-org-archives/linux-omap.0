From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Thu, 19 Apr 2012 08:06:12 +0300
Message-ID: <1334811972.1521.30.camel@lappy>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
	 <1331646353.2856.354.camel@deskari> <87zkbkmjo1.fsf@ti.com>
	 <1331707131.1618.7.camel@lappy> <87vckxm0px.fsf@ti.com>
	 <CAJOA=zN4ghhg2wpJeqFN97myMihGxvOSN05NkxoMFKG2BgYORA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-F8dKhHgJr6tZF8g7dvuc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:36162 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038Ab2DSFGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 01:06:19 -0400
Received: by lahj13 with SMTP id j13so6299712lah.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 22:06:16 -0700 (PDT)
In-Reply-To: <CAJOA=zN4ghhg2wpJeqFN97myMihGxvOSN05NkxoMFKG2BgYORA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com


--=-F8dKhHgJr6tZF8g7dvuc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-18 at 10:26 -0700, Turquette, Mike wrote:
> On Wed, Apr 18, 2012 at 10:03 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> >> On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
> >>> It sounds to me like it acutally is a throughput constraint on CORE. =
 If
> >>> so, wouldn't it be clearer to set a throughput constraint that is
> >>> calculated based on the pixel clock and resulting bitrate that would
> >>> have the same effect?
> >>
> >> I don't see that these limits would have anything to do with CORE. I'm
> >> guessing that the DSS HW just can't function properly with high clocks
> >> and low voltage.
> >
> > OK, this gets back to something we've talked about a few times that is
> > needed in the clock framework.  Basically, we need a way for clocks to
> > prevent changes so these kinds of dependencies can be tracked.  We've
> > talked about new APIs like clk_allow_changes(), clk_block_changes() or
> > something like that.
> >
> > Basically, something that allows clocks to know that their will not be
> > changed under them.
>=20
> Are the DSS clocks changing frequency behind your back?  Or are the
> clock rates staying the same while the voltage is dropped?

The latter. The clocks do not change behind my back. It's the DSS driver
making the clock rate changes.

> For the former issue Kevin is right that we need better clock
> semantics.  For the latter issue hopefully the future dvfs
> architecture will do the right thing (at least it does on paper).

Note that many of the DSS clocks are generated inside DSS HW, and
managed by the DSS driver, and thus the clock framework doesn't know
anything about them. Will the future dvfs offer some way for the drivers
to limit the OPP?

 Tomi


--=-F8dKhHgJr6tZF8g7dvuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj51EAAoJEPo9qoy8lh71yukP/RvM0jprMMDCHqk6v5C1FdZ0
ciniNirW/6qGc+3yefcqXDZCvPEgvSm6dbuLKL+0ErowSNTva8CR3IawwL6kyEJl
HGb0LWYGpqO+XCZeLEj0QlYuJVSd2aZP390NuQEnfZSCAVZp7vOQ8rSHVPxyMuNU
9HC0WDK7uawx1G/Z9rtG01cP/MZtDA9KV2Jby2J6YHgNb8gjPROEsOQECtGWP64Y
uEmDvzMposDxdDHbS0ZTJvf9EqQ0NVqXZaMylcFV4DU1Zq5y0erVF4ukClj6ypvq
7UB79v9dWI4/kXGqmmnKnoQrz1P9MQg94sUdiGePsFgAv7MK8pp+H+er4Rm0ACfD
JAi1eBGaRNEEfEIaOTRfA9suJMBCtVqWHh9eBFzXmacANSqCkG6J6Ga44Kl7zz09
XzF5TmtNdkmjce697QwT+y6o5QBI6tfWmjnjxM7ZeE35qbfxaAdwfEUk2Ap+aMEz
Vk/wauOGHo6ZmVCXEcndnBOo/Nt2raF005ipnLjhcZe5rstVcwTTPX2tOaBTZrE9
ik5u7DxfkDa3FCGIa5Evn2AuKr2F5hdqOHmq1Tg1tq5BrRaTpj18DdoEt8WtPt18
QJlGDnCQmdhacGmKfKQykKLIsJy9clpVDrMOl03gVbP7orBoJxGRPl7rlF6nirwc
GoNNmwLVUTthQ1G3fXDK
=RLfD
-----END PGP SIGNATURE-----

--=-F8dKhHgJr6tZF8g7dvuc--

