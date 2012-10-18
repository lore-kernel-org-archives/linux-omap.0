From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
Date: Thu, 18 Oct 2012 20:23:50 +0300
Message-ID: <20121018172350.GA6914@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-4-git-send-email-balbi@ti.com>
 <878vb3g14c.fsf@deeprootsystems.com>
 <20121018170640.GB6641@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44812 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199Ab2JRR30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:29:26 -0400
Content-Disposition: inline
In-Reply-To: <20121018170640.GB6641@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 08:06:40PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Oct 18, 2012 at 10:07:31AM -0700, Kevin Hilman wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> >=20
> > > current omap_device PM implementation defines
> > > omap-specific *_noirq methods but uses the
> > > generic versions for all other PM methods.
> > >
> > > As it turns out, if a device decides to implement
> > > non-runtime PM callbacks, we might fall into a
> > > situation where the hwmod is still idled which
> > > will generate an abort exception when we try
> > > to access device's address space while clocks
> > > are still gated.
> >=20
> > Please explain in more detail how this could happen.
>=20
> just follow the patchset. If I implement system suspend and I'm not
> focefully calling runtime_* methods, who will be there to call
> omap_device_enable() ?

let me rephrase this. If we exit _noirq right in the beginning with the
extra check I've added, who will call omap_device_enable() ?

--=20
balbi

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDsmAAoJEIaOsuA1yqRE2ZIP/jf4YxGZfhSPh/zO0hblXcgA
8D0Hu5zlI0RxIvFK43WIBS4WOWTpEHUT1ZSQClWPsNlDJTzg5lYn4dFeLYrUxAoQ
zgkGzg37qCvBvKeXJkASWpNCZ6K6XeY8N/zk5oc6T+yAIaWOCCCqAwU8sjniB0Z9
fN7xCEy/AGO/Z4M9bWFGGdYA+W8XIosEcigpEhtS30bGU/wVJGkIFAI6q9W+oPhi
qYCaSypMdDztqenQM3dLQSq6QpZvpgYDFTOjkKMraX10QVDsd0WIC3ylVX6vxp09
mQ2VG0FxTkd+Uldn/eg41HGPGHYYVqgbvrSTqLp9og2AU03m6VVsm6E+sInE0sCn
SzMAJL1wMXy0oG1tZRAAjqMlwvYQzgloYVOS4iwsF8EkjE1jF7WJ+FSU79hG5SDe
8l8rLvsY4enTUTsqvj47Y3frepEUoMqQPLJXvMEcmkdtlKhcxQxiVbZFXP5DEXJB
Nahe9r4ItX/WXIreRLwBjH/W6CyMQLGj5jkwISA9EA1x3A2hbFovG7J6fhZOGc0W
9a3DPQH17xfKkCAvrWuHS7uMyT7SiGIY3YzdYhL05jlDd2vFgH76QNIHCI3iHbwr
HhcbaZk3AURnSAGqTafCsANtPazvXqUVxWs1OoGvkMhp3VvI09nHOFS7oeA5T8st
J+QzPRr8UMobBGKb8+J5
=NtNe
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
